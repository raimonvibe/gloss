import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const tangerineFamily = 'Tangerine';

  static bool get enabled => GoogleFonts.config.allowRuntimeFetching;

  static TextStyle playfair({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
  }) {
    final fallback = (textStyle ?? const TextStyle()).copyWith(
      fontFamily: 'serif',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
    );
    if (!enabled) return fallback;
    return GoogleFonts.playfairDisplay(
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle cormorant({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
  }) {
    final fallback = (textStyle ?? const TextStyle()).copyWith(
      fontFamily: 'serif',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
    );
    if (!enabled) return fallback;
    return GoogleFonts.cormorantGaramond(
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
    );
  }

  /// Calligraphic script from `assets/fonts` (Tangerine).
  static TextStyle tangerine({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextStyle(
      fontFamily: tangerineFamily,
      fontFamilyFallback: const ['cursive', 'serif'],
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextTheme textTheme(Color foreground) {
    if (!enabled) {
      return Typography.englishLike2021
          .apply(fontFamily: 'serif')
          .apply(bodyColor: foreground, displayColor: foreground);
    }
    return GoogleFonts.cormorantGaramondTextTheme().apply(
      bodyColor: foreground,
      displayColor: foreground,
    );
  }
}
