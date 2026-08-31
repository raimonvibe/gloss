import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/settings_controller.dart';
import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';

class PaperBackdrop extends StatelessWidget {
  const PaperBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final calm = context.select<SettingsController, bool>(
      (settings) => settings.reduceMotion,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: calm ? brand.background : null,
            gradient: calm
                ? null
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: brand.pageGradient,
                  ),
          ),
        ),
        if (!calm) CustomPaint(painter: _GrainPainter(tint: brand.grain)),
        child,
      ],
    );
  }
}

class _GrainPainter extends CustomPainter {
  const _GrainPainter({required this.tint});

  /// From [BrandColors.grain]: near-black on parchment, near-white in
  /// candlelight, and either way faint enough to read as paper rather than
  /// as three circles.
  final Color tint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = tint;
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), size.width * 0.45, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), size.width * 0.4, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.55, paint);
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) =>
      oldDelegate.tint != tint;
}

class FlourishCorners extends StatelessWidget {
  const FlourishCorners({super.key});

  @override
  Widget build(BuildContext context) {
    final calm = context.select<SettingsController, bool>(
      (settings) => settings.reduceMotion,
    );
    if (calm) return const SizedBox.shrink();
    final color = context.brand.accentGold.withValues(alpha: 0.55);
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(top: 4, left: 4, child: _Flourish(color: color)),
          Positioned(
            top: 4,
            right: 4,
            child: Transform.flip(flipX: true, child: _Flourish(color: color)),
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Transform.flip(flipY: true, child: _Flourish(color: color)),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Transform.flip(
              flipX: true,
              flipY: true,
              child: _Flourish(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _Flourish extends StatelessWidget {
  const _Flourish({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(72, 72),
        isComplex: true,
        willChange: false,
        painter: _FlourishPainter(color),
      ),
    );
  }
}

/// One corner of penwork, drawn as a pen would leave it.
///
/// The earlier version stroked its curves at a single width and stopped at
/// a bare dot, which is why it read as three stray marks rather than as one
/// gesture. Three things carry the difference: every stroke tapers, each
/// arm ends in a volute that winds inward instead of stopping, and the two
/// arms are the same path reflected about the diagonal, so the corner is
/// exactly symmetrical rather than nearly.
class _FlourishPainter extends CustomPainter {
  const _FlourishPainter(this.color);

  final Color color;

  /// Everything is laid out on a 120-point square and scaled to fit.
  static const _grid = 120.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / _grid);

    _arm(canvas);
    // The same arm across the diagonal: (x, y) becomes (y, x). Both start on
    // the diagonal itself, so the two meet at a point instead of crossing.
    canvas.save();
    canvas.transform(Float64List.fromList(const [
      0, 1, 0, 0, //
      1, 0, 0, 0, //
      0, 0, 1, 0, //
      0, 0, 0, 1, //
    ]));
    _arm(canvas);
    canvas.restore();

    // The bead where the two arms meet, sitting on the diagonal.
    canvas.drawCircle(const Offset(9, 9), 1.9, Paint()..color = color);
    canvas.restore();
  }

  /// One arm: the long sweep off the corner, the volute it winds into, a
  /// leaf resting on its back, and a hairline echoing it.
  void _arm(Canvas canvas) {
    final sweep = Path()
      ..moveTo(9, 9)
      ..cubicTo(9, 48, 17, 74, 51, 83);
    _taper(canvas, sweep, from: 2.4, to: 0.85);

    // The volute picks the sweep up where it ends and winds in.
    _taper(
      canvas,
      _volute(const Offset(51, 92), 9, -math.pi / 2, 1.15),
      from: 0.85,
      to: 0,
    );

    // A hairline running just inside the sweep, stopping short of it.
    final echo = Path()
      ..moveTo(13, 15)
      ..cubicTo(15, 44, 22, 62, 40, 69);
    _taper(canvas, echo, from: 0.8, to: 0);

    canvas.drawPath(
      _leaf(const Offset(11, 44), const Offset(27, 58), 4.2),
      Paint()..color = color,
    );
  }

  /// A spiral that loses radius as it turns, which is what makes it read as
  /// a wound line rather than as a circle.
  Path _volute(Offset centre, double radius, double startAngle, double turns) {
    final path = Path();
    const steps = 48;
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final angle = startAngle + turns * 2 * math.pi * t;
      final r = radius * (1 - 0.84 * t);
      final point = centre + Offset(math.cos(angle) * r, math.sin(angle) * r);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path;
  }

  /// A filled teardrop between two points, bowed one way on the outward
  /// journey and the other on the way back.
  Path _leaf(Offset a, Offset b, double bulge) {
    final along = b - a;
    final length = along.distance;
    if (length == 0) return Path();
    final across = Offset(-along.dy, along.dx) / length * bulge;
    final mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
    return Path()
      ..moveTo(a.dx, a.dy)
      ..quadraticBezierTo(mid.dx + across.dx, mid.dy + across.dy, b.dx, b.dy)
      ..quadraticBezierTo(mid.dx - across.dx, mid.dy - across.dy, a.dx, a.dy)
      ..close();
  }

  /// Fills a path as a ribbon whose width changes along its length.
  ///
  /// Flutter strokes at one width per path, so a taper cannot be stroked.
  /// Drawing it as a run of ever-thinner pieces was the first attempt and
  /// the round cap of every piece showed as a bead along the thick end. So
  /// the outline is walked instead: each side of the line is offset from
  /// the centre by half the width at that point, and the two sides are
  /// closed into one shape. A width of zero at the far end gives the nib's
  /// point rather than a clipped end.
  void _taper(
    Canvas canvas,
    Path path, {
    required double from,
    required double to,
  }) {
    final ribbon = Path();
    for (final metric in path.computeMetrics()) {
      const steps = 72;
      final near = <Offset>[];
      final far = <Offset>[];
      for (var i = 0; i <= steps; i++) {
        final t = i / steps;
        final tangent = metric.getTangentForOffset(metric.length * t);
        if (tangent == null) continue;
        final half = ui.lerpDouble(from, to, t)! / 2;
        // The tangent's vector is a unit vector; its perpendicular is the
        // direction the edge lies in.
        final edge = Offset(-tangent.vector.dy, tangent.vector.dx) * half;
        near.add(tangent.position + edge);
        far.add(tangent.position - edge);
      }
      if (near.length < 2) continue;
      ribbon.moveTo(near.first.dx, near.first.dy);
      for (final point in near.skip(1)) {
        ribbon.lineTo(point.dx, point.dy);
      }
      for (final point in far.reversed) {
        ribbon.lineTo(point.dx, point.dy);
      }
      ribbon.close();
    }
    canvas.drawPath(ribbon, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _FlourishPainter oldDelegate) =>
      oldDelegate.color != color;
}

class DividerFlourish extends StatelessWidget {
  const DividerFlourish({super.key, this.symbol = '❦'});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    final gold = context.brand.accentGold;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(child: _line(gold, fadeStart: true)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              symbol,
              style: AppFonts.tangerine(
                fontSize: 28,
                color: gold.withValues(alpha: 0.85),
                height: 1,
              ),
            ),
          ),
          Expanded(child: _line(gold, fadeStart: false)),
        ],
      ),
    );
  }

  Widget _line(Color gold, {required bool fadeStart}) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: fadeStart
              ? [gold.withValues(alpha: 0), gold]
              : [gold, gold.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: context.brand.heroGradient,
      ).createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}
