import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/theme/brand_colors.dart';
import 'package:beautiful_words/widgets/gradient_mask.dart';
import 'package:beautiful_words/widgets/ornament.dart';
import 'package:beautiful_words/widgets/social_row.dart';

const _key = ValueKey('painted');

/// What was drawn: how much ink there is, and how much of it is raw white.
///
/// White is the tell. A gradient mask paints its child flat white so that the
/// blend mode can tint it, so a white pixel on the page is ink the mask never
/// reached — see [GradientMask]. Everything is drawn on black, which the app's
/// dark theme is close to and no gradient stop comes near.
Future<({int painted, int white})> _ink(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(_key));
  final bytes = await tester.runAsync(() async {
    final image = await boundary.toImage();
    return image.toByteData(format: ui.ImageByteFormat.rawRgba);
  });
  var painted = 0;
  var white = 0;
  final data = bytes!.buffer.asUint8List();
  for (var i = 0; i < data.length; i += 4) {
    final r = data[i], g = data[i + 1], b = data[i + 2], a = data[i + 3];
    if (a > 200 && (r > 8 || g > 8 || b > 8)) painted++;
    if (a > 200 && r > 240 && g > 240 && b > 240) white++;
  }
  return (painted: painted, white: white);
}

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.binding.setSurfaceSize(const Size(400, 260));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(extensions: const [BrandColors.dark]),
      home: RepaintBoundary(
        key: _key,
        child: ColoredBox(
          color: const Color(0xFF000000),
          child: Center(child: child),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Descenders, an accent over a capital, and a word with neither.
///
/// Tangerine is the one display face the app ships in the bundle, so it is the
/// one a test can actually draw with — Cormorant is fetched at runtime and a
/// test gets a fallback. It is also the harder case: its descenders are longer
/// than Cormorant's, so what escapes here would escape there.
const _style = TextStyle(fontFamily: 'Tangerine', fontSize: 90, height: 1.0);

void main() {
  // A mask that stops at the child's layout box leaves everything the glyph
  // drew outside that box untinted, and the child of a gradient mask is white.
  // On a device that was a white sliver under the tail of the p in
  // "Splenetic", on a page whose every other pixel is right.
  for (final word in ['pygmy', 'Ǻgape', 'nomen']) {
    testWidgets('no ink escapes the gradient in "$word"', (tester) async {
      await _pump(tester, GradientText(word, style: _style));

      final ink = await _ink(tester);
      expect(ink.painted, greaterThan(500), reason: 'nothing was drawn');
      expect(
        ink.white,
        0,
        reason: '${ink.white} pixels of "$word" are raw white — that is ink '
            'the mask did not reach',
      );
    });
  }

  // Checked both ways round, because a pixel test that cannot fail is worth
  // nothing: the same scene through Flutter's own ShaderMask must show the
  // white this fix exists to remove. If this ever stops finding any, either
  // the font changed or the measurement stopped measuring.
  testWidgets('a plain ShaderMask still lets the descender through', (
    tester,
  ) async {
    await _pump(
      tester,
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6D3B5E), Color(0xFFA33B2A)],
        ).createShader(bounds),
        // White, as GradientText paints its own child — that is what makes
        // the leak visible rather than merely mistinted.
        child: Text('pygmy', style: _style.copyWith(color: Colors.white)),
      ),
    );

    final ink = await _ink(tester);
    expect(
      ink.white,
      greaterThan(0),
      reason: 'ShaderMask stopped leaking, so this test proves nothing',
    );
  });

  // The other mask in the app. An icon font draws to its own metrics rather
  // than to the em it was asked for, so its box is not a promise either.
  testWidgets('no ink escapes the gradient on a brand mark', (tester) async {
    await _pump(tester, SocialRow(onOpen: (_) async => true));

    final ink = await _ink(tester);
    expect(ink.painted, greaterThan(500), reason: 'nothing was drawn');
    expect(ink.white, 0, reason: '${ink.white} pixels of a brand mark are raw '
        'white — that is ink the mask did not reach');
  });
}
