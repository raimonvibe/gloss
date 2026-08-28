import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const tangerineFamily = 'Tangerine';

  static bool get enabled => GoogleFonts.config.allowRuntimeFetching;

  static List<String> get scriptFallbacks {
    if (!enabled) return const ['sans-serif', 'serif'];
    return [
      GoogleFonts.notoSans().fontFamily!,
      GoogleFonts.notoNaskhArabic().fontFamily!,
      GoogleFonts.notoSansHebrew().fontFamily!,
      GoogleFonts.notoSansJP().fontFamily!,
      GoogleFonts.notoSansKR().fontFamily!,
      GoogleFonts.notoSansSC().fontFamily!,
      GoogleFonts.notoSansTC().fontFamily!,
      GoogleFonts.notoSansThai().fontFamily!,
      GoogleFonts.notoSansBengali().fontFamily!,
      GoogleFonts.notoSansDevanagari().fontFamily!,
      GoogleFonts.notoSansSinhala().fontFamily!,
      GoogleFonts.notoSansArmenian().fontFamily!,
      GoogleFonts.notoSansGeorgian().fontFamily!,
      GoogleFonts.notoSansKhmer().fontFamily!,
      GoogleFonts.notoSansLao().fontFamily!,
      GoogleFonts.notoSansMyanmar().fontFamily!,
    ];
  }

  static TextStyle _withScripts(TextStyle style) {
    return style.copyWith(fontFamilyFallback: scriptFallbacks);
  }

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
    return _withScripts(
      GoogleFonts.playfairDisplay(
        textStyle: textStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
        letterSpacing: letterSpacing,
      ),
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
    return _withScripts(
      GoogleFonts.cormorantGaramond(
        textStyle: textStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
      ),
    );
  }

  /// Calligraphic script from `assets/fonts` (Tangerine).
  static TextStyle tangerine({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return _withScripts(
      TextStyle(
        fontFamily: tangerineFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  static TextTheme textTheme(Color foreground) {
    final base = !enabled
        ? Typography.englishLike2021.apply(fontFamily: 'serif')
        : GoogleFonts.cormorantGaramondTextTheme();
    return _withScriptTheme(
      base.apply(bodyColor: foreground, displayColor: foreground),
    );
  }

  static TextTheme _withScriptTheme(TextTheme theme) {
    TextStyle? wrap(TextStyle? style) =>
        style == null ? null : _withScripts(style);
    return theme.copyWith(
      displayLarge: wrap(theme.displayLarge),
      displayMedium: wrap(theme.displayMedium),
      displaySmall: wrap(theme.displaySmall),
      headlineLarge: wrap(theme.headlineLarge),
      headlineMedium: wrap(theme.headlineMedium),
      headlineSmall: wrap(theme.headlineSmall),
      titleLarge: wrap(theme.titleLarge),
      titleMedium: wrap(theme.titleMedium),
      titleSmall: wrap(theme.titleSmall),
      bodyLarge: wrap(theme.bodyLarge),
      bodyMedium: wrap(theme.bodyMedium),
      bodySmall: wrap(theme.bodySmall),
      labelLarge: wrap(theme.labelLarge),
      labelMedium: wrap(theme.labelMedium),
      labelSmall: wrap(theme.labelSmall),
    );
  }
}
