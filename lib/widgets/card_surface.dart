import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';

class CardSurface extends StatelessWidget {
  const CardSurface({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderColor,
    this.borderWidth = 1,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? brand.cardBorder,
              width: borderWidth,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: brand.cardGradient,
            ),
            // No shadow, in either theme.
            //
            // Impeller drew this one as a hard-edged rectangle around every
            // card — the blur squared off at the bounding box, so each
            // rounded card sat inside a grey box with pointed corners.
            // Neither a stadium shape nor moving the decoration out of the
            // ink layer shifted it on the emulator, and the border alone
            // holds the card well enough.
          ),
          child: child,
        ),
      ),
    );
  }
}

class GildedFrame extends StatelessWidget {
  const GildedFrame({
    super.key,
    required this.child,
    this.radius = 24,
    this.onTap,
  });

  final Widget child;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: context.brand.frameGradient,
            ),
            boxShadow: [
              BoxShadow(
                color: context.brand.accentGold.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius - 1.5),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: context.brand.cardGradient,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ScriptCaption extends StatelessWidget {
  const ScriptCaption(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
    this.fontSize = 28,
  });

  final String text;
  final TextAlign textAlign;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppFonts.tangerine(
        fontSize: fontSize,
        height: 1,
        color: context.brand.accentGold,
      ),
    );
  }
}
