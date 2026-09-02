import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/app_theme.dart';

const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech & Rhetoric"}],
  "words": [
    {"id": "a", "word": "Alpha", "variants": [], "partOfSpeech": "noun",
     "pronunciation": "AL-fuh", "definition": "The first.", "friendly": "First.",
     "example": "An Alpha stood first.", "tags": ["speech"], "origin": "Latin",
     "originWord": "alphus", "roots": [{"form": "alphus", "meaning": "one"}]}
  ]
}
''';

final _nav = find.byWidgetPredicate(
  (widget) => widget is NavigationBar || widget is NavigationRail,
);

Future<void> _pumpApp(
  WidgetTester tester, {
  required double textScale,
  String localeId = 'en',
  Size size = const Size(390, 900),
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final settings = SettingsController(
    prefs,
    catalog: LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    ),
  );
  await settings.setLocaleId(localeId);
  if (textScale != 1.0) await settings.setTextScale(textScale);

  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    GlossApp(
      settings: settings,
      progress: ProgressController(prefs),
      repository: WordRepository.fromJsonString(_fixture),
      speech: SpeechController(engine: SilentSpeechEngine()),
    ),
  );
  await tester.pumpAndSettle();
}

/// The placeholder drawn inside the first field on screen.
({String text, int? maxLines, Rect box, Rect field}) _placeholder(
  WidgetTester tester,
) {
  final field = find.byType(TextField).first;
  final hint = (tester.widget<TextField>(field)).decoration!.hintText!;
  final drawn = find.text(hint).first;
  return (
    text: hint,
    maxLines: tester.widget<Text>(drawn).maxLines,
    box: tester.getRect(drawn),
    field: tester.getRect(field),
  );
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  // "Zoek een woord, of beschrijf de betekenis…" was cut off mid-phrase.
  // InputDecoration.hintMaxLines follows the field's own maxLines, which is
  // one for a search box or a name, so the placeholder had a single line
  // however large the reader had set the type — and the reader who most needs
  // the hint is the one who can least see the end of it.

  // The policy on its own, away from any font: a test runs in a face whose
  // every glyph is a full em square, so how many lines a given hint takes
  // here says nothing about how many it takes on a device. What the app
  // decides — one line, or room to wrap — does not depend on the font.
  testWidgets('the allowance is one line until the reader enlarges the type', (
    tester,
  ) async {
    final seen = <double, int>{};
    for (final scale in [1.0, 1.1, 1.6, 2.0]) {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(scale)),
          child: Builder(
            builder: (context) {
              seen[scale] = hintLines(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    }
    expect(seen[1.0], 1, reason: 'the search pill was drawn for one line');
    for (final scale in [1.1, 1.6, 2.0]) {
      expect(
        seen[scale],
        greaterThan(1),
        reason: 'a placeholder is still cut off at ${scale}x',
      );
    }
  });

  testWidgets('a placeholder keeps to one line at the ordinary size', (
    tester,
  ) async {
    await _pumpApp(tester, textScale: 1.0);
    await tester.tap(
      find.descendant(of: _nav, matching: find.byIcon(Icons.menu_book_outlined)),
    );
    await tester.pumpAndSettle();

    final hint = _placeholder(tester);
    expect(hint.maxLines, 1, reason: 'the search pill grew a second line');
  });

  for (final locale in ['en', 'nl-NL', 'de-DE']) {
    testWidgets('the search placeholder takes the room it needs in $locale', (
      tester,
    ) async {
      await _pumpApp(tester, textScale: 2.0, localeId: locale);
      await tester.tap(
        find.descendant(
          of: _nav,
          matching: find.byIcon(Icons.menu_book_outlined),
        ),
      );
      await tester.pumpAndSettle();

      final hint = _placeholder(tester);
      expect(hint.maxLines, greaterThan(1), reason: 'still capped at one line');

      // The field grew to hold whatever the hint took. Without this the extra
      // lines would be drawn and then cut off by the box around them, which
      // is the same bug wearing a taller hat.
      expect(
        hint.field.height,
        greaterThanOrEqualTo(hint.box.height),
        reason: 'the placeholder is taller than the field holding it',
      );
      expect(hint.box.top, greaterThanOrEqualTo(hint.field.top - 0.5));
      expect(hint.box.bottom, lessThanOrEqualTo(hint.field.bottom + 0.5));
    });
  }

  // The contact form is where the placeholder is an instruction rather than a
  // label — "where an answer may go" — so it is the one that has to be read.
  testWidgets('the contact form\'s placeholders are not cut off', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      textScale: 2.0,
      localeId: 'nl-NL',
      size: const Size(390, 1600),
    );
    await tester.tap(
      find.descendant(of: _nav, matching: find.byIcon(Icons.auto_stories_outlined)),
    );
    await tester.pumpAndSettle();

    // Study → Write to the maker.
    final letter = find.byIcon(Icons.mail_outline);
    await tester.scrollUntilVisible(
      letter,
      300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 60,
    );
    await tester.pumpAndSettle();
    await tester.tap(letter.first);
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    expect(fields, findsWidgets, reason: 'the letter has no fields');

    for (var i = 0; i < fields.evaluate().length; i++) {
      final widget = tester.widget<TextField>(fields.at(i));
      final hint = widget.decoration?.hintText;
      if (hint == null) continue;
      final drawn = find.text(hint);
      if (drawn.evaluate().isEmpty) continue;

      expect(
        tester.widget<Text>(drawn.first).maxLines,
        greaterThan(1),
        reason: '"$hint" is still held to one line',
      );
      // Nothing is being drawn outside the field that holds it.
      final box = tester.getRect(drawn.first);
      final field = tester.getRect(fields.at(i));
      expect(box.height, lessThanOrEqualTo(field.height + 0.5),
          reason: '"$hint" is taller than its field');
    }
  });
}
