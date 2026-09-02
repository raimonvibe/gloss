import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart'
    show SettingsController, kMaxTextScale;
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/favorite_button.dart';
import 'package:beautiful_words/widgets/progress_tracker.dart';
import 'package:beautiful_words/widgets/theme_toggle.dart';

const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech & Rhetoric"}],
  "words": [
    {
      "id": "edulcorate", "word": "Edulcorate", "variants": [],
      "partOfSpeech": "verb", "pronunciation": "ee-DUL-kuh-rate",
      "definition": "To sweeten or purify.",
      "friendly": "To take the bitterness out of something.",
      "example": "The editor edulcorated the review.",
      "tags": ["speech"], "origin": "Latin", "originWord": "edulcorare",
      "roots": [{"form": "dulcis", "meaning": "sweet"}]
    },
    {
      "id": "garrulous", "word": "Garrulous", "variants": [],
      "partOfSpeech": "adjective", "pronunciation": "GAIR-uh-lus",
      "definition": "Excessively talkative.",
      "friendly": "Just won't stop chatting.",
      "example": "The garrulous cab driver talked the whole way.",
      "tags": ["speech"], "origin": "Latin", "originWord": "garrulus",
      "roots": [{"form": "garrire", "meaning": "to chatter"}]
    },
    {
      "id": "mendicant", "word": "Mendicant", "variants": [],
      "partOfSpeech": "noun", "pronunciation": "MEN-dih-kunt",
      "definition": "A beggar, or one living on alms.",
      "friendly": "Someone who lives by asking for charity.",
      "example": "The mendicant friars owned nothing.",
      "tags": ["speech"], "origin": "Latin", "originWord": "mendicans",
      "roots": [{"form": "mendicare", "meaning": "to beg"}]
    },
    {
      "id": "paroxysm", "word": "Paroxysm", "variants": [],
      "partOfSpeech": "noun", "pronunciation": "PARR-uk-siz-um",
      "definition": "A sudden violent outburst.",
      "friendly": "A sudden intense burst of emotion.",
      "example": "A paroxysm of laughter.",
      "tags": ["speech"], "origin": "Greek", "originWord": "paroxysmos",
      "roots": [{"form": "oxys", "meaning": "sharp"}]
    }
  ]
}
''';

final _nav = find.byWidgetPredicate(
  (widget) => widget is NavigationBar || widget is NavigationRail,
);

/// Opens a quiz question at [size], in [localeId], and returns nothing but a
/// settled page: the header is what every test here measures.
Future<void> _openQuestion(
  WidgetTester tester, {
  required Size size,
  String localeId = 'en',
  double textScale = 1.0,
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

  await tester.tap(
    find.descendant(of: _nav, matching: find.byIcon(Icons.quiz_outlined)),
  );
  await tester.pumpAndSettle();

  final arb = jsonDecode(
    File('lib/l10n/app_${localeId.split('-').first}.arb').readAsStringSync(),
  ) as Map<String, dynamic>;
  final begin = find.text(arb['begin'] as String);
  await tester.scrollUntilVisible(
    begin,
    200,
    scrollable: find.byType(Scrollable).first,
    maxScrolls: 30,
  );
  await tester.pumpAndSettle();
  await tester.tap(begin);
  await tester.pumpAndSettle();
}

/// The label the progress line carries, as it was actually drawn.
Finder get _progressLabel => find.descendant(
      of: find.byType(ProgressTracker),
      matching: find.byType(Text),
    );

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  // Five things across a phone is one thing too many. The progress line was
  // handed whatever the four controls left it — 152pt on a 390pt phone — and
  // its label wrapped into three lines inside a bar drawn for one.
  for (final phone in <String, Size>{
    'a small phone': const Size(320, 640),
    'a phone': const Size(390, 844),
    'a large phone': const Size(412, 892),
  }.entries) {
    testWidgets('the progress line has the width of the page on ${phone.key}',
        (tester) async {
      await _openQuestion(tester, size: phone.value);

      final tracker = tester.getRect(find.byType(ProgressTracker));
      final controls = tester.getRect(find.byType(ThemeToggle));

      expect(
        tracker.top,
        greaterThanOrEqualTo(controls.bottom - 0.5),
        reason: 'the progress line is still squeezed in beside the controls',
      );
      // It has the page, not a sliver of it: the gutter is 20 each side.
      expect(tracker.width, greaterThanOrEqualTo(phone.value.width - 41));

      // And the label has that width to read in: the tracker's own icon,
      // its gap and its percentage are all that stand beside it.
      //
      // Not a count of lines — a test runs in a font whose every glyph is a
      // full em square, so "Question 1 of 4" wraps here at a width where the
      // Cormorant the app ships would not. The width the label is given is
      // the thing this layout controls; how many lines that buys is the
      // font's business.
      expect(
        tester.getSize(_progressLabel.first).width,
        greaterThanOrEqualTo(tracker.width - 60),
        reason: 'something else took the room the label was given',
      );
    });
  }

  testWidgets('a tablet keeps the controls and the progress on one line',
      (tester) async {
    await _openQuestion(tester, size: const Size(834, 1112));

    final tracker = tester.getRect(find.byType(ProgressTracker));
    final toggle = tester.getRect(find.byType(ThemeToggle));
    expect(
      tracker.center.dy,
      closeTo(toggle.center.dy, 4),
      reason: 'the tablet dropped the progress line for no reason',
    );
    expect(tracker.right, lessThanOrEqualTo(toggle.left));
  });

  // Enough room for a row at one text size is not enough at twice it. The
  // floor is measured in type for exactly this reason: the controls are a
  // fixed 198pt whatever the reader has set, and the line beside them is not.
  const window = Size(500, 900);

  testWidgets('a 500pt window has room for the row at the ordinary size',
      (tester) async {
    await _openQuestion(tester, size: window);
    expect(
      tester.getRect(find.byType(ProgressTracker)).center.dy,
      closeTo(tester.getRect(find.byType(ThemeToggle)).center.dy, 4),
    );
  });

  testWidgets('and drops the line at the largest text size',
      (tester) async {
    await _openQuestion(tester, size: window, textScale: kMaxTextScale);
    expect(
      tester.getRect(find.byType(ProgressTracker)).top,
      greaterThanOrEqualTo(
        tester.getRect(find.byType(ThemeToggle)).bottom - 0.5,
      ),
      reason: 'half again the type in the same row, and the label has '
          'nowhere left to go',
    );
  });

  // Whatever shape it takes, everything in it is reachable and inside the
  // page. An overflow anywhere fails these on its own.
  for (final locale in ['en', 'nl-NL', 'el-GR', 'ar']) {
    testWidgets('the header fits a small phone in $locale at the largest text',
        (tester) async {
      await _openQuestion(
        tester,
        size: const Size(320, 640),
        localeId: locale,
        textScale: kMaxTextScale,
      );

      for (final control in [
        find.byIcon(Icons.close),
        find.byType(FavoriteButton),
        find.byType(ThemeToggle),
        find.byType(ProgressTracker),
      ]) {
        final rect = tester.getRect(control.first);
        expect(rect.left, greaterThanOrEqualTo(-0.5));
        expect(rect.right, lessThanOrEqualTo(320.5));
      }
    });
  }
}
