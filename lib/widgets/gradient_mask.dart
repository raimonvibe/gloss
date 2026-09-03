import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A [ShaderMask] whose mask reaches past the child's own box.
///
/// `ShaderMask` masks a rectangle, and the rectangle is the child's layout
/// box: `RenderShaderMask` sets `maskRect` to `offset & size` and the engine
/// draws the shader over that rect and nothing else. Ink the child paints
/// **outside** its box is never touched by the mask — it composites through
/// exactly as the child drew it.
///
/// For a gradient that is the worst possible failure, because the child of a
/// gradient mask is painted in flat `Colors.white` so that `BlendMode.modulate`
/// can tint it. Any ink that escapes the box is therefore not "the wrong
/// colour", it is **pure white on a dark page**.
///
/// Text escapes its box all the time, and a display face escapes it most:
/// Cormorant's descenders reach well below the line box, and the headword on a
/// word's page is set at `height: 1.05`, which is tighter than the font's own
/// ascent plus descent. So *Splenetic* was drawn with a white sliver under the
/// tail of its **p** — reported from a device on 2026-09-03, and reproducible
/// in a test with the bundled Tangerine face, whose descenders are longer
/// still: 91 pure-white pixels, all of them on the last row of the text's box
/// and below.
///
/// Descenders are only the common case. The same thing happens above a line
/// (an accent on a capital, `Å`, `Ǻ`), past the right edge (the overhang of an
/// italic or a swash), and around a font icon whose glyph is drawn larger than
/// the em it was asked for. It is not a property of any one word, font or
/// screen — it is a property of `ShaderMask`, so the fix belongs here and not
/// at the four places that mask something.
///
/// The mask rect is inflated by the child's own height, which no glyph's ink
/// ever exceeds, while the **shader** is still built from the child's real box
/// so every colour lands exactly where it did before. Inflating costs nothing:
/// the child's layer is transparent everywhere it did not paint, and both
/// `modulate` and `srcIn` leave a transparent destination transparent.
///
/// Layout is untouched. That matters more than it looks — [FitToWidth] wraps
/// two of the call sites and the lexicon puts an `IntrinsicHeight` around a
/// row of cards, so anything that measured the text here (a `LayoutBuilder`, a
/// `TextPainter`) would break the intrinsic query that levels those cards.
/// See the note in `fit_to_width.dart`, which is where that was learned.
class GradientMask extends SingleChildRenderObjectWidget {
  const GradientMask({
    super.key,
    required this.shaderCallback,
    this.blendMode = BlendMode.modulate,
    required Widget super.child,
  });

  /// Handed the child's real box, exactly as [ShaderMask] would hand it over.
  final Shader Function(Rect bounds) shaderCallback;

  final BlendMode blendMode;

  @override
  RenderGradientMask createRenderObject(BuildContext context) {
    return RenderGradientMask(
      shaderCallback: shaderCallback,
      blendMode: blendMode,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderGradientMask renderObject,
  ) {
    renderObject
      ..shaderCallback = shaderCallback
      ..blendMode = blendMode;
  }
}

class RenderGradientMask extends RenderProxyBox {
  RenderGradientMask({
    required Shader Function(Rect bounds) shaderCallback,
    required BlendMode blendMode,
    RenderBox? child,
  })  : _shaderCallback = shaderCallback,
        _blendMode = blendMode,
        super(child);

  Shader Function(Rect bounds) get shaderCallback => _shaderCallback;
  Shader Function(Rect bounds) _shaderCallback;
  set shaderCallback(Shader Function(Rect bounds) value) {
    if (_shaderCallback == value) return;
    _shaderCallback = value;
    markNeedsPaint();
  }

  BlendMode get blendMode => _blendMode;
  BlendMode _blendMode;
  set blendMode(BlendMode value) {
    if (_blendMode == value) return;
    _blendMode = value;
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  /// [RenderShaderMask.paint] with one line changed — see the class doc.
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      layer = null;
      return;
    }
    assert(needsCompositing);
    final mask = (layer as ShaderMaskLayer?) ?? ShaderMaskLayer();
    layer = mask;
    mask
      // The child's real box, so the gradient runs corner to corner of the
      // words rather than of the room the mask was given.
      ..shader = _shaderCallback(Offset.zero & size)
      // The room the mask is given, and the whole of the change: a line's
      // height of slack on every side, which is more than a descender, an
      // accent or a swash can ever need and more than ShaderMask gives them.
      ..maskRect = (offset & size).inflate(size.height)
      ..blendMode = _blendMode;
    context.pushLayer(mask, super.paint, offset);
    assert(() {
      mask.debugCreator = debugCreator;
      return true;
    }());
  }
}
