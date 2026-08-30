import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/theme/brand_colors.dart';
import 'package:beautiful_words/widgets/etymology_card.dart';
import 'package:beautiful_words/widgets/fit_to_width.dart';

/// The longest headword in the lexicon, and the shape of the bug: at 40pt it
/// is wider than a phone card, so the tail of the word was breaking onto a
/// line of its own against the frame.
const _long = WordEntry(
  id: 'circumincession',
  word: 'Circumincession',
  partOfSpeech: 'noun',
  pronunciation: 'sir-cum-in-SESH-un',
  definition: 'The mutual indwelling of the persons of the Trinity.',
  friendly: 'Three that live inside one another.',
  example: 'The homily turned on circumincession.',
  tags: ['speech'],
  origin: 'Latin',
  originWord: 'circumincessio',
  roots: [WordRoot(form: 'circum', meaning: 'around')],
);

/// A box of exactly [width], so the fit is measured against a known space
/// rather than whatever the test window happens to be.
Future<void> _pumpLine(
  WidgetTester tester,
  String text, {
  required double width,
  double fontSize = 40,
  double minScale = 0.62,
}) {
  return tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox(
          width: width,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FitToWidth(
              minScale: minScale,
              child: Text(text, style: TextStyle(fontSize: fontSize)),
            ),
          ),
        ),
      ),
    ),
  );
}

/// What the line was scaled by: the box it ended up in, against the size the
/// child laid itself out at. `getSize` reports a child's own size, before the
/// scale its parent paints it through; `getRect` reports where that lands.
double _scaleOf(WidgetTester tester, String text) =>
    tester.getSize(find.byType(FitToWidth)).width /
    tester.getSize(find.text(text)).width;

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('a line that already fits is left at the size it was written at',
      (tester) async {
    await _pumpLine(tester, 'Gloss', width: 400);
    expect(_scaleOf(tester, 'Gloss'), 1.0);
    expect(
      tester.getSize(find.byType(FitToWidth)),
      tester.getSize(find.text('Gloss')),
    );
  });

  testWidgets('a line too wide for its box shrinks onto one line',
      (tester) async {
    await _pumpLine(tester, 'Proleptical', width: 300);

    expect(_scaleOf(tester, 'Proleptical'), lessThan(1.0));
    // One line: two would stand at least twice as tall as the type.
    expect(tester.getSize(find.text('Proleptical')).height, lessThan(40 * 2));
    expect(tester.getRect(find.text('Proleptical')).width,
        lessThanOrEqualTo(300.5));
  });

  testWidgets('shrinking stops at minScale and lets the line wrap instead',
      (tester) async {
    await _pumpLine(tester, 'Circumincession', width: 40, minScale: 0.5);

    expect(_scaleOf(tester, 'Circumincession'), closeTo(0.5, 0.001));
    // It gave up on one line rather than shrinking past the floor: a reader
    // who turned their text size up gets a wrapped word, not a tiny one.
    expect(tester.getSize(find.text('Circumincession')).height,
        greaterThan(40 * 2));
  });

  testWidgets('a larger text size is still honoured, just fitted',
      (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(1.6)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 300,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FitToWidth(
                  child: Text('Proleptical', style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.getRect(find.text('Proleptical')).width,
        lessThanOrEqualTo(300.5));
  });

  testWidgets('the headword shrinks rather than breaking against the frame',
      (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(useMaterial3: true, extensions: const [BrandColors.light]),
        home: const Scaffold(
          body: SingleChildScrollView(child: EtymologyCard(entry: _long)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final headword = find.text('Circumincession');
    expect(headword, findsOneWidget);
    // Painted smaller than it laid itself out: it gave ground to the card.
    expect(
      tester.getRect(headword).width,
      lessThan(tester.getSize(headword).width),
    );

    // And whatever size it lands on, it stays inside the card it sits in.
    final card = tester.getRect(find.byType(EtymologyCard));
    final word = tester.getRect(headword);
    expect(word.left, greaterThanOrEqualTo(card.left));
    expect(word.right, lessThanOrEqualTo(card.right));
  });
}
