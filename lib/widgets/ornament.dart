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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
        if (!calm) CustomPaint(painter: _GrainPainter(dark: isDark)),
        child,
      ],
    );
  }
}

class _GrainPainter extends CustomPainter {
  const _GrainPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = dark
          ? const Color(0x08FFFFFF)
          : const Color(0x0A000000);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), size.width * 0.45, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), size.width * 0.4, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.55, paint);
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => oldDelegate.dark != dark;
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
    return CustomPaint(
      size: const Size(72, 72),
      painter: _FlourishPainter(color),
    );
  }
}

class _FlourishPainter extends CustomPainter {
  const _FlourishPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 120;
    canvas.scale(scale);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final thin = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final p1 = Path()
      ..moveTo(4, 4)
      ..cubicTo(4, 40, 4, 60, 30, 66)
      ..cubicTo(50, 71, 40, 88, 58, 90);
    final p2 = Path()
      ..moveTo(4, 4)
      ..cubicTo(40, 4, 60, 4, 66, 30)
      ..cubicTo(71, 50, 88, 40, 90, 58);
    final p3 = Path()
      ..moveTo(4, 4)
      ..cubicTo(20, 8, 24, 24, 8, 20);
    final p4 = Path()
      ..moveTo(30, 66)
      ..cubicTo(34, 60, 42, 60, 44, 68);
    final p5 = Path()
      ..moveTo(66, 30)
      ..cubicTo(60, 34, 60, 42, 68, 44);

    canvas.drawPath(p1, stroke);
    canvas.drawPath(p2, stroke);
    canvas.drawPath(p3, thin);
    canvas.drawPath(p4, thin);
    canvas.drawPath(p5, thin);
    canvas.drawCircle(const Offset(58, 90), 2.2, fill);
    canvas.drawCircle(const Offset(90, 58), 2.2, fill);
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
