import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Display type that shrinks to the width it was handed instead of breaking.
///
/// The longest English headwords — *Circumincession*, *Pronunciamento* — are
/// wider than a phone card at 40pt, and Flutter's own answer is to split the
/// word and drop the tail onto a line of its own. That is how *Proleptical*
/// came to sit above a lone "l" leaning on the frame, and *Circumincession*
/// above a stranded "on" in the lexicon. This gives the line back the room it
/// asked for and then scales it down to fit, no further than [minScale] of the
/// size it was written at; past that it stops and lets the text wrap, because
/// type that small is worse to read than a second line — a reader who has
/// turned their text size up gets a wrapped headword, not a shrunken one.
///
/// The child measures itself. An earlier version measured the text here with
/// a [TextPainter] inside a [LayoutBuilder], which was wrong twice over: the
/// measurement had to reproduce [Text]'s own merge with the ambient
/// [DefaultTextStyle] to be accurate, and a [LayoutBuilder] cannot answer the
/// intrinsic query an [IntrinsicHeight] makes — which is what the lexicon
/// puts around a row of cards to level them.
///
/// Only the big type needs this — a hero, a headword. Body and list text is
/// meant to wrap.
class FitToWidth extends SingleChildRenderObjectWidget {
  const FitToWidth({super.key, required Widget super.child, this.minScale = 0.62});

  /// How far the line may shrink before it is allowed to wrap instead.
  final double minScale;

  @override
  RenderFitToWidth createRenderObject(BuildContext context) =>
      RenderFitToWidth(minScale: minScale);

  @override
  void updateRenderObject(BuildContext context, RenderFitToWidth renderObject) {
    renderObject.minScale = minScale;
  }
}

class RenderFitToWidth extends RenderProxyBox {
  RenderFitToWidth({required double minScale, RenderBox? child})
      : _minScale = minScale,
        super(child);

  double get minScale => _minScale;
  double _minScale;
  set minScale(double value) {
    if (_minScale == value) return;
    _minScale = value;
    markNeedsLayout();
  }

  /// What the last layout settled on, and what [paint] draws through.
  double _scale = 1;

  /// The size this lands on, and the scale that gets it there. [dry] runs the
  /// same arithmetic without touching the child's own layout.
  (Size, double) _fit(BoxConstraints constraints, {required bool dry}) {
    final child = this.child!;
    // Unbounded first: what the child would like, all on one line.
    Size natural = dry
        ? child.getDryLayout(const BoxConstraints())
        : (child..layout(const BoxConstraints(), parentUsesSize: true)).size;

    var scale = 1.0;
    if (constraints.maxWidth.isFinite &&
        natural.width > constraints.maxWidth &&
        natural.width > 0) {
      scale = constraints.maxWidth / natural.width;
      if (scale < _minScale) {
        // Even the smallest step will not hold the line, so spend the rest of
        // the allowance on room to wrap in.
        scale = _minScale;
        final wrapped = BoxConstraints(maxWidth: constraints.maxWidth / scale);
        natural = dry
            ? child.getDryLayout(wrapped)
            : (child..layout(wrapped, parentUsesSize: true)).size;
      }
    }
    return (
      constraints.constrain(Size(natural.width * scale, natural.height * scale)),
      scale,
    );
  }

  @override
  void performLayout() {
    if (child == null) {
      _scale = 1;
      size = constraints.smallest;
      return;
    }
    final (fitted, scale) = _fit(constraints, dry: false);
    _scale = scale;
    size = fitted;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      child == null ? constraints.smallest : _fit(constraints, dry: true).$1;

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null || size.isEmpty) return;
    if (_scale == 1) {
      context.paintChild(child, offset);
      return;
    }
    layer = context.pushTransform(
      needsCompositing,
      offset,
      Matrix4.diagonal3Values(_scale, _scale, 1),
      (inner, at) => inner.paintChild(child, at),
      oldLayer: layer is TransformLayer ? layer! as TransformLayer : null,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (child == null || _scale == 1) {
      return super.hitTestChildren(result, position: position);
    }
    return result.addWithPaintTransform(
      transform: Matrix4.diagonal3Values(_scale, _scale, 1),
      position: position,
      hitTest: (inner, at) => child!.hitTest(inner, position: at),
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.scaleByDouble(_scale, _scale, 1.0, 1.0);
  }
}
