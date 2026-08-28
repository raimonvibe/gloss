import 'package:flutter/material.dart';

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({
    required this.background,
    required this.backgroundAlt,
    required this.foreground,
    required this.foregroundMuted,
    required this.card,
    required this.cardBorder,
    required this.accentGold,
    required this.accentWine,
    required this.accentInk,
    required this.pageGradient,
    required this.cardGradient,
    required this.heroGradient,
    required this.frameGradient,
    required this.correct,
    required this.incorrect,
  });

  final Color background;
  final Color backgroundAlt;
  final Color foreground;
  final Color foregroundMuted;
  final Color card;
  final Color cardBorder;
  final Color accentGold;
  final Color accentWine;
  final Color accentInk;
  final List<Color> pageGradient;
  final List<Color> cardGradient;
  final List<Color> heroGradient;
  final List<Color> frameGradient;
  final Color correct;
  final Color incorrect;

  static const light = BrandColors(
    background: Color(0xFFFAF3E3),
    backgroundAlt: Color(0xFFF3E6C9),
    foreground: Color(0xFF3A2C1A),
    foregroundMuted: Color(0xFF6B5940),
    card: Color(0xFFFFFBF2),
    cardBorder: Color(0xFFD8BF8A),
    accentGold: Color(0xFFA9762F),
    accentWine: Color(0xFF7A2E3A),
    accentInk: Color(0xFF2F4858),
    pageGradient: [Color(0xFFFBF4E4), Color(0xFFF4E7C9), Color(0xFFF0DDB8)],
    cardGradient: [Color(0xFFFFFDF7), Color(0xFFFBF1DC)],
    heroGradient: [Color(0xFFA9762F), Color(0xFF7A2E3A), Color(0xFF4C2A52)],
    frameGradient: [Color(0xFFC99A3D), Color(0xFF8A3247), Color(0xFF4C2A52)],
    correct: Color(0xFF3D6B4A),
    incorrect: Color(0xFF7A2E3A),
  );

  static const dark = BrandColors(
    background: Color(0xFF1A1420),
    backgroundAlt: Color(0xFF241A2C),
    foreground: Color(0xFFECDFC8),
    foregroundMuted: Color(0xFFB8A888),
    card: Color(0xFF221A2A),
    cardBorder: Color(0xFF5A3F52),
    accentGold: Color(0xFFE0B45C),
    accentWine: Color(0xFFD98A97),
    accentInk: Color(0xFF8DB3C9),
    pageGradient: [Color(0xFF16111D), Color(0xFF1E1526), Color(0xFF241A2C)],
    cardGradient: [Color(0xFF241A2C), Color(0xFF1C1522)],
    heroGradient: [Color(0xFF3D2748), Color(0xFF5A2A3D), Color(0xFF7A3A2E)],
    frameGradient: [Color(0xFFE0B45C), Color(0xFFD9738A), Color(0xFF8D6FD9)],
    correct: Color(0xFF8FCB9B),
    incorrect: Color(0xFFD98A97),
  );

  @override
  BrandColors copyWith({
    Color? background,
    Color? backgroundAlt,
    Color? foreground,
    Color? foregroundMuted,
    Color? card,
    Color? cardBorder,
    Color? accentGold,
    Color? accentWine,
    Color? accentInk,
    List<Color>? pageGradient,
    List<Color>? cardGradient,
    List<Color>? heroGradient,
    List<Color>? frameGradient,
    Color? correct,
    Color? incorrect,
  }) {
    return BrandColors(
      background: background ?? this.background,
      backgroundAlt: backgroundAlt ?? this.backgroundAlt,
      foreground: foreground ?? this.foreground,
      foregroundMuted: foregroundMuted ?? this.foregroundMuted,
      card: card ?? this.card,
      cardBorder: cardBorder ?? this.cardBorder,
      accentGold: accentGold ?? this.accentGold,
      accentWine: accentWine ?? this.accentWine,
      accentInk: accentInk ?? this.accentInk,
      pageGradient: pageGradient ?? this.pageGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      frameGradient: frameGradient ?? this.frameGradient,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      background: Color.lerp(background, other.background, t)!,
      backgroundAlt: Color.lerp(backgroundAlt, other.backgroundAlt, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      foregroundMuted: Color.lerp(foregroundMuted, other.foregroundMuted, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      accentGold: Color.lerp(accentGold, other.accentGold, t)!,
      accentWine: Color.lerp(accentWine, other.accentWine, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
      pageGradient: [
        Color.lerp(pageGradient[0], other.pageGradient[0], t)!,
        Color.lerp(pageGradient[1], other.pageGradient[1], t)!,
        Color.lerp(pageGradient[2], other.pageGradient[2], t)!,
      ],
      cardGradient: [
        Color.lerp(cardGradient[0], other.cardGradient[0], t)!,
        Color.lerp(cardGradient[1], other.cardGradient[1], t)!,
      ],
      heroGradient: [
        Color.lerp(heroGradient[0], other.heroGradient[0], t)!,
        Color.lerp(heroGradient[1], other.heroGradient[1], t)!,
        Color.lerp(heroGradient[2], other.heroGradient[2], t)!,
      ],
      frameGradient: [
        Color.lerp(frameGradient[0], other.frameGradient[0], t)!,
        Color.lerp(frameGradient[1], other.frameGradient[1], t)!,
        Color.lerp(frameGradient[2], other.frameGradient[2], t)!,
      ],
      correct: Color.lerp(correct, other.correct, t)!,
      incorrect: Color.lerp(incorrect, other.incorrect, t)!,
    );
  }
}

extension BrandColorsContext on BuildContext {
  BrandColors get brand {
    return Theme.of(this).extension<BrandColors>() ?? BrandColors.light;
  }
}
