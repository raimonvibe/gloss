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
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/button_label.dart';
import 'package:beautiful_words/widgets/etymology_card.dart';
import 'package:beautiful_words/widgets/word_card.dart';

const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech & Rhetoric"}],
  "words": [
    {
      "id": "edulcorate",
      "word": "Edulcorate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-DUL-cor-ate",
      "definition": "To sweeten or purify.",
      "friendly": "To take the bitterness out of something.",
      "example": "The editor edulcorated the review.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "edulcorare",
      "roots": [{"form": "dulcis", "meaning": "sweet"}]
    },
    {
      "id": "garrulous",
      "word": "Garrulous",
      "variants": [],
      "partOfSpeech": "adjective",
      "pronunciation": "GAIR-uh-lus",
      "definition": "Excessively talkative.",
      "friendly": "Just won't stop chatting.",
      "example": "The garrulous cab driver talked the whole way.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "garrulus",
      "roots": [{"form": "garrire", "meaning": "to chatter"}]
    },
    {
      "id": "mendicant",
      "word": "Mendicant",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "MEN-dih-kunt",
      "definition": "A beggar, or one living on alms.",
      "friendly": "Someone who lives by asking for charity.",
      "example": "The mendicant friars owned nothing.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "mendicans",
      "roots": [{"form": "mendicare", "meaning": "to beg"}]
    },
    {
      "id": "paroxysm",
      "word": "Paroxysm",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "PARR-uk-siz-um",
      "definition": "A sudden violent outburst.",
      "friendly": "A sudden intense burst of emotion.",
      "example": "A paroxysm of laughter.",
      "tags": ["speech"],
      "origin": "Greek",
      "originWord": "paroxysmos",
      "roots": [{"form": "oxys", "meaning": "sharp"}]
    }
  ]
}
''';

Future<SettingsController> _pumpApp(
  WidgetTester tester, {
  required Size size,
  double textScale = 1.0,
  String? localeId,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  // The real catalog, so the language picker has its 178 countries.
  final settings = SettingsController(
    prefs,
    catalog: LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    ),
  );
  if (textScale != 1.0) await settings.setTextScale(textScale);
  if (localeId != null) await settings.setLocaleId(localeId);

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
  return settings;
}

/// The bar or the rail, whichever this window is wearing.
final _nav = find.byWidgetPredicate(
  (widget) => widget is NavigationBar || widget is NavigationRail,
);

int _selectedTab(WidgetTester tester) {
  final widget = tester.widget(_nav);
  return widget is NavigationBar
      ? widget.selectedIndex
      : (widget as NavigationRail).selectedIndex ?? 0;
}

/// Every tab in turn. An overflow anywhere fails the test on its own: the
/// framework reports one as an exception, which the harness treats as a
/// failure.
///
/// Tapping the icons rather than the labels, because a label is allowed to
/// go away on a narrow window and a tap that lands on nothing would walk
/// none of the tabs at all.
Future<void> _walkTheTabs(WidgetTester tester) async {
  const tabs = <int, IconData>{
    1: Icons.menu_book_outlined,
    2: Icons.quiz_outlined,
    3: Icons.favorite_border,
    4: Icons.auto_stories_outlined,
    0: Icons.home_outlined,
  };
  for (final tab in tabs.entries) {
    await tester.tap(
      find.descendant(of: _nav, matching: find.byIcon(tab.value)),
    );
    await tester.pumpAndSettle();
    expect(
      _selectedTab(tester),
      tab.key,
      reason: 'tab ${tab.key} never opened',
    );
  }
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  // A small phone, a phone on its side, a tablet upright, a tablet on its
  // side, and a desktop window.
  const sizes = <String, Size>{
    'small phone': Size(320, 640),
    'phone': Size(390, 844),
    'phone landscape': Size(844, 390),
    'tablet portrait': Size(834, 1112),
    'tablet landscape': Size(1112, 834),
    'desktop': Size(1600, 1000),
  };

  for (final entry in sizes.entries) {
    testWidgets('every tab fits a ${entry.key}', (tester) async {
      await _pumpApp(tester, size: entry.value);
      await _walkTheTabs(tester);
    });
  }

  testWidgets('every tab fits a phone at the largest text size', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(360, 780), textScale: 2.0);
    await _walkTheTabs(tester);
  });

  // German turns "Saved" into "Gespeichert", which does not fit a fifth of a
  // phone. It used to wrap and lose its tail to the bottom of the bar.
  //
  // Note the widths below. A test runs in a font whose every glyph is a full
  // em square — half again as wide as the Cormorant the app really ships —
  // so a label needs far more room here than on a device.
  testWidgets('a long tab name shrinks rather than wrapping', (tester) async {
    await _pumpApp(tester, size: const Size(700, 900), localeId: 'de-DE');

    final label = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Gespeichert'),
    );
    expect(label, findsOneWidget);

    final size = tester.getSize(label);
    expect(size.width, lessThanOrEqualTo(700 / 5));
    // Two lines of a 13pt label stand about 36 high, and the bar shows one.
    expect(
      size.height,
      lessThan(30),
      reason: 'the label wrapped (${size.height}px tall)',
    );
  });

  testWidgets('a tab name never wraps, at any text size', (tester) async {
    for (final scale in [1.0, 1.5, 2.0]) {
      await _pumpApp(
        tester,
        size: const Size(411, 891),
        textScale: scale,
        localeId: 'de-DE',
      );

      final label = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Gespeichert'),
      );
      final size = tester.getSize(label);
      expect(
        size.width,
        lessThanOrEqualTo(411 / 5),
        reason: 'the label is wider than its tab at ${scale}x',
      );
      expect(
        size.height,
        lessThan(30),
        reason: 'the label wrapped at ${scale}x (${size.height}px tall)',
      );
    }
  });

  // A button's words are English-length in English and nothing like it
  // anywhere else: "See results" is "Ergebnisse ansehen" in German and
  // "Переглянути результати" in Ukrainian. Left alone the label wrapped,
  // which made the pill tall, which curved its rounded ends in over the
  // words — the label ended up printed across the outside of its own button.
  // It now shrinks first, and whatever it does it keeps clear of the curve.
  //
  // The four below are the longest of the sixty, by the two labels that
  // share a line. The fix is not theirs, though: nothing here names a
  // language, and any of the sixty would do as the sample.
  const worstCases = <String, String>{
    'uk': 'Ukrainian',
    'de-DE': 'German',
    'el-GR': 'Greek',
    'fil': 'Filipino',
  };

  for (final locale in worstCases.entries) {
    testWidgets('a long button label stays inside its pill in '
        '${locale.value}', (tester) async {
      final arb = jsonDecode(
        File('lib/l10n/app_${locale.key.split('-').first}.arb')
            .readAsStringSync(),
      ) as Map<String, dynamic>;
      String label(String key) => arb[key] as String;

      await _pumpApp(
        tester,
        size: const Size(411, 891),
        localeId: locale.key,
      );

      await tester.tap(
        find.descendant(of: _nav, matching: find.byIcon(Icons.quiz_outlined)),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(label('begin')));
      await tester.pumpAndSettle();

      // Answer until the last question, where the long label appears.
      for (var question = 0; question < 12; question++) {
        await tester.tap(find.text('A'));
        await tester.pumpAndSettle();
        if (find.text(label('seeResults')).evaluate().isNotEmpty) break;
        await tester.tap(find.text(label('next')));
        await tester.pumpAndSettle();
      }

      // Both buttons on the line: the one that grew and the one beside it.
      for (final button in [
        find.byType(FilledButton),
        find.byType(OutlinedButton),
      ]) {
        expect(button, findsOneWidget);
        final words = tester.getRect(
          find.descendant(of: button, matching: find.byType(ButtonLabel)),
        );
        final pill = tester.getRect(button);

        // Room at each end for the curve of a stadium to come in without
        // reaching the words.
        expect(
          words.left - pill.left,
          greaterThanOrEqualTo(12),
          reason: 'the label runs into the left end of the pill',
        );
        expect(
          pill.right - words.right,
          greaterThanOrEqualTo(12),
          reason: 'the label runs into the right end of the pill',
        );
        expect(pill.contains(words.topLeft), isTrue);
        expect(pill.contains(words.bottomRight - const Offset(0.5, 0.5)),
            isTrue);
      }
    });
  }

  testWidgets('the tabs move to a rail once there is room beside the page', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(390, 844));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);

    await tester.binding.setSurfaceSize(const Size(1112, 834));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    // And back again, so a resized desktop window is not left with both.
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('the lexicon stacks on a phone and columns on a tablet', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(390, 844));
    await tester.tap(find.text('Lexicon').last);
    await tester.pumpAndSettle();

    // A list only builds what is near the viewport, so two is all this
    // needs: whether they sit on the same line is the whole question.
    final cards = find.byType(WordCard);
    expect(cards, findsAtLeastNWidgets(2));
    expect(
      tester.getTopLeft(cards.at(0)).dy == tester.getTopLeft(cards.at(1)).dy,
      isFalse,
      reason: 'a phone should show one word per row',
    );

    await tester.binding.setSurfaceSize(const Size(1112, 834));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(cards.at(0)).dy,
      tester.getTopLeft(cards.at(1)).dy,
      reason: 'a tablet has room for more than one word per row',
    );
    // Cards in a row are the same height, however long their text runs.
    expect(tester.getSize(cards.at(0)).height,
        tester.getSize(cards.at(1)).height);
  });

  // The strip of filter chips was a `SizedBox(height: 40)`, and 40pt is a
  // promise about the type inside it that nobody with large text turned on
  // agreed to. A clipped strip reports no overflow, so nothing failed — the
  // labels simply lost their tops and tails, and a clipped label measures
  // shorter than it is, which is why the check below is on the strip.
  testWidgets('the filter strip grows with the text size', (tester) async {
    final heights = <double, double>{};
    for (final scale in [1.0, 2.0]) {
      await _pumpApp(tester, size: const Size(360, 780), textScale: scale);
      // By the label, not the icon: a second pass finds the tab already
      // open, and an open tab wears the filled icon instead.
      await tester.tap(find.text('Lexicon').last);
      await tester.pumpAndSettle();

      final label = find.text('All');
      expect(label, findsOneWidget);
      final strip = find.ancestor(
        of: label,
        matching: find.byType(SingleChildScrollView),
      );
      final words = tester.getRect(label);
      final rail = tester.getRect(strip.first);
      heights[scale] = rail.height;

      expect(rail.top, lessThanOrEqualTo(words.top));
      expect(rail.bottom, greaterThanOrEqualTo(words.bottom));
      // The chip keeps its own 8pt of air above and below the words.
      expect(rail.height, greaterThanOrEqualTo(words.height + 16));
    }

    expect(
      heights[2.0]!,
      greaterThan(heights[1.0]!),
      reason: 'the strip is the same height at twice the text size, so the '
          'chips inside it are being cut down to fit',
    );
  });

  testWidgets('the language picker columns on a tablet', (tester) async {
    await _pumpApp(tester, size: const Size(1112, 834));
    await tester.tap(find.text('Study').last);
    await tester.pumpAndSettle();

    // The tongues sit well down the study, and a list only builds what is
    // near the viewport.
    final link = find.text('Languages');
    await tester.scrollUntilVisible(
      link,
      300,
      scrollable: find.byType(Scrollable).last,
      maxScrolls: 60,
    );
    await tester.pumpAndSettle();
    await tester.tap(link);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Europe'));
    await tester.pumpAndSettle();

    // Countries are cards side by side here, not a single ribbon of rows.
    final albania = find.text('Albania');
    expect(albania, findsWidgets);
    final austria = find.text('Austria');
    expect(austria, findsWidgets);
    expect(
      tester.getTopLeft(albania.first).dy,
      tester.getTopLeft(austria.first).dy,
    );
  });

  testWidgets('a quiz round fits a desktop window', (tester) async {
    await _pumpApp(tester, size: const Size(1600, 1000));
    await tester.tap(find.text('Quiz').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Begin'));
    await tester.pumpAndSettle();

    // Answer whatever is offered until the round is over. Right or wrong
    // does not matter here; both states have to fit the page.
    for (var question = 0; question < 12; question++) {
      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();
      final last = find.text('See results');
      if (last.evaluate().isNotEmpty) {
        await tester.tap(last);
        break;
      }
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    await tester.pumpAndSettle();
    expect(find.text('Try another round'), findsOneWidget);
  });

  testWidgets('a word keeps a readable column on a wide window', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(1600, 1000));
    await tester.tap(find.text('Lexicon').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(WordCard).first);
    await tester.pumpAndSettle();

    // Prose that ran the full 1600px would lose the reader on every line.
    expect(
      tester.getSize(find.byType(EtymologyCard)).width,
      lessThanOrEqualTo(720),
    );
  });
}
