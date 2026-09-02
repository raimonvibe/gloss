import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/theme/brand_colors.dart';

/// WCAG relative luminance.
double _luminance(Color color) {
  double channel(double v) =>
      v <= 0.04045 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(color.r) +
      0.7152 * channel(color.g) +
      0.0722 * channel(color.b);
}

/// The WCAG contrast ratio between two opaque colours, 1.0 to 21.0.
double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

/// [over] laid on [under] at [alpha] — a tinted fill is a ground of its own,
/// and the origin chip draws gold text on gold at 12%.
Color _composite(Color over, double alpha, Color under) => Color.fromARGB(
      255,
      ((over.r * alpha + under.r * (1 - alpha)) * 255).round(),
      ((over.g * alpha + under.g * (1 - alpha)) * 255).round(),
      ((over.b * alpha + under.b * (1 - alpha)) * 255).round(),
    );

/// AA for text below 18.66pt bold or 24pt regular, which is all the text
/// these colours carry.
const _aa = 4.5;

/// AA for icons, borders and other things that are not words.
const _aaNonText = 3.0;

void main() {
  // A reader wrote in to say the app was hard to read. The type was the
  // greater part of it, but the gold was measurably too pale to be read at
  // the sizes it was being set at — 3.8:1 on a card, 3.2:1 on a tag, against
  // the 4.5 a small word needs. Every colour that carries a word is held to
  // that here, so the next hand to touch the palette finds out at once.
  for (final theme in <String, BrandColors>{
    'the light theme': BrandColors.light,
    'the dark theme': BrandColors.dark,
  }.entries) {
    final brand = theme.value;

    // Every ground a word is set on, including the two tinted fills the
    // cards and chips draw for themselves.
    final grounds = <String, Color>{
      'the page': brand.background,
      'a card': brand.card,
      'a tag': brand.backgroundAlt,
      'the gold chip fill': _composite(brand.accentGold, 0.12, brand.card),
    };

    for (final ground in grounds.entries) {
      for (final ink in <String, Color>{
        'foreground': brand.foreground,
        'foregroundMuted': brand.foregroundMuted,
        'accentGold': brand.accentGold,
        'accentWine': brand.accentWine,
      }.entries) {
        test('${ink.key} reads on ${ground.key} in ${theme.key}', () {
          final ratio = _contrast(ink.value, ground.value);
          expect(
            ratio,
            greaterThanOrEqualTo(_aa),
            reason: '${ink.key} on ${ground.key} is '
                '${ratio.toStringAsFixed(2)}:1, under AA\'s $_aa',
          );
        });
      }
    }

    // A right answer and a wrong one are told apart by their colour, so the
    // marks have to be made out as shapes.
    //
    // `cardBorder` is deliberately not here. It measures about 1.8:1 in both
    // themes, and it is a hairline around a card rather than a control or a
    // boundary a reader has to perceive to follow anything — the words
    // inside it carry their own contrast, and the card's fill is a second
    // separation from the page. Worth revisiting only if the cards are ever
    // given their shadow back (see *Cards carry no shadow*), because the
    // hairline is doing that job alone at the moment.
    for (final mark in <String, Color>{
      'correct': brand.correct,
      'incorrect': brand.incorrect,
    }.entries) {
      test('${mark.key} is visible on a card in ${theme.key}', () {
        final ratio = _contrast(mark.value, brand.card);
        expect(
          ratio,
          greaterThanOrEqualTo(_aaNonText),
          reason: '${mark.key} is ${ratio.toStringAsFixed(2)}:1 on a card, '
              'under the $_aaNonText a shape needs to be made out',
        );
      });
    }
  }
}
