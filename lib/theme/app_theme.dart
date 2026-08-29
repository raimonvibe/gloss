import 'package:flutter/material.dart';

import 'app_fonts.dart';
import 'brand_colors.dart';

/// A wide button is a stadium, and a stadium's ends curve in by half its
/// height. Room at the sides keeps the label clear of that curve, however
/// tall the button grows — which is what stopped "Ergebnisse ansehen" from
/// spilling past its own pill. Every pill the app draws by hand uses it too.
const EdgeInsets kButtonPadding = EdgeInsets.symmetric(
  horizontal: 20,
  vertical: 14,
);

class AppTheme {
  static ThemeData light() => _build(Brightness.light, BrandColors.light);

  static ThemeData dark() => _build(Brightness.dark, BrandColors.dark);

  static ThemeData _build(Brightness brightness, BrandColors brand) {
    final baseText = AppFonts.textTheme(brand.foreground);

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: brand.accentGold,
        onPrimary: Colors.white,
        secondary: brand.accentWine,
        onSecondary: Colors.white,
        tertiary: brand.accentInk,
        onTertiary: Colors.white,
        error: brand.incorrect,
        onError: Colors.white,
        surface: brand.card,
        onSurface: brand.foreground,
      ),
      scaffoldBackgroundColor: brand.background,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      textTheme: baseText.copyWith(
        displayLarge: AppFonts.playfair(
          textStyle: baseText.displayLarge,
          fontWeight: FontWeight.w800,
          color: brand.foreground,
          letterSpacing: -0.5,
        ),
        displayMedium: AppFonts.playfair(
          textStyle: baseText.displayMedium,
          fontWeight: FontWeight.w700,
          color: brand.foreground,
        ),
        headlineLarge: AppFonts.playfair(
          textStyle: baseText.headlineLarge,
          fontWeight: FontWeight.w700,
          color: brand.foreground,
        ),
        headlineMedium: AppFonts.playfair(
          textStyle: baseText.headlineMedium,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        headlineSmall: AppFonts.playfair(
          textStyle: baseText.headlineSmall,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        titleLarge: AppFonts.playfair(
          textStyle: baseText.titleLarge,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        titleMedium: AppFonts.playfair(
          textStyle: baseText.titleMedium,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        titleSmall: AppFonts.playfair(
          textStyle: baseText.titleSmall,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        bodyLarge: AppFonts.cormorant(
          textStyle: baseText.bodyLarge,
          fontSize: 18,
          height: 1.45,
          color: brand.foreground,
        ),
        bodyMedium: AppFonts.cormorant(
          textStyle: baseText.bodyMedium,
          fontSize: 16,
          height: 1.4,
          color: brand.foreground,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: brand.foreground,
        centerTitle: true,
        titleTextStyle: AppFonts.playfair(
          fontWeight: FontWeight.w700,
          color: brand.foreground,
          fontSize: 20,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: brand.card.withValues(alpha: 0.94),
        indicatorColor: brand.accentGold.withValues(alpha: 0.18),
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return AppFonts.cormorant(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? brand.accentGold : brand.foregroundMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? brand.accentGold : brand.foregroundMuted,
          );
        }),
      ),
      // The rail stands in for the bottom bar on a wide window, so it wears
      // the same gold-on-parchment colours. Transparent, though: a solid
      // panel down the side reads as a slab pasted onto the page, and the
      // parchment and its corner flourish should carry on underneath.
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: brand.accentGold.withValues(alpha: 0.18),
        elevation: 0,
        selectedIconTheme: IconThemeData(color: brand.accentGold),
        unselectedIconTheme: IconThemeData(color: brand.foregroundMuted),
        selectedLabelTextStyle: AppFonts.cormorant(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: brand.accentGold,
        ),
        unselectedLabelTextStyle: AppFonts.cormorant(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: brand.foregroundMuted,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        hintStyle: AppFonts.cormorant(
          color: brand.foregroundMuted.withValues(alpha: 0.7),
          fontSize: 16,
        ),
        border: InputBorder.none,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: brand.accentGold,
          textStyle: AppFonts.cormorant(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brand.accentGold,
          foregroundColor: Colors.white,
          padding: kButtonPadding,
          textStyle: AppFonts.cormorant(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: brand.foreground,
          padding: kButtonPadding,
          textStyle: AppFonts.cormorant(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppFonts.playfair(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: brand.foreground,
        ),
        subtitleTextStyle: AppFonts.cormorant(
          fontSize: 14,
          color: brand.foregroundMuted,
        ),
      ),
      extensions: [brand],
    );
  }
}
