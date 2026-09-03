import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/favorite_button.dart';

const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech & Rhetoric"}],
  "words": [
    {
      "id": "edulcorate",
      "word": "Edulcorate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-DUL-kuh-rate",
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

final _nav = find.byWidgetPredicate(
  (widget) => widget is NavigationBar || widget is NavigationRail,
);

/// The heart, wherever a page draws one — and never the Saved tab's own
/// icon, which wears the same glyph and would swallow the tap.
final _saveWord = find.byType(FavoriteButton);

Future<(ProgressController, WordRepository)> _pumpApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double textScale = 1.0,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final settings = SettingsController(prefs);
  if (textScale != 1.0) await settings.setTextScale(textScale);
  final progress = ProgressController(prefs);
  final repository = WordRepository.fromJsonString(_fixture);

  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    GlossApp(
      settings: settings,
      progress: progress,
      repository: repository,
      speech: SpeechController(engine: SilentSpeechEngine()),
    ),
  );
  await tester.pumpAndSettle();
  return (progress, repository);
}

Future<void> _openTab(WidgetTester tester, IconData icon) async {
  await tester.tap(find.descendant(of: _nav, matching: find.byIcon(icon)));
  await tester.pumpAndSettle();
}

/// Answers every question until the results page is up.
Future<void> _playToTheEnd(WidgetTester tester) async {
  for (var question = 0; question < 12; question++) {
    await tester.tap(find.text('A'));
    await tester.pumpAndSettle();
    final last = find.text('See results');
    if (last.evaluate().isNotEmpty) {
      await tester.tap(last);
      await tester.pumpAndSettle();
      return;
    }
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
  }
  fail('the quiz never reached its results');
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  // The save used to live on the lexicon card alone. A reader who met a word
  // as the word of the day, or inside a quiz, or in the list of what they had
  // just been asked, had to go and find it again in the lexicon to keep it.
  testWidgets('the word of the day can be saved where it stands', (
    tester,
  ) async {
    final (progress, repo) = await _pumpApp(tester);
    final today = repo.wordOfTheDay().id;

    expect(_saveWord, findsOneWidget, reason: 'no heart on the home page');
    await tester.tap(_saveWord);
    await tester.pumpAndSettle();

    expect(progress.favorites.contains(today), isTrue);

    // And the same heart takes it back off.
    await tester.tap(_saveWord);
    await tester.pumpAndSettle();
    expect(progress.favorites.contains(today), isFalse);
  });

  testWidgets('a quiz question can be saved while it is being answered', (
    tester,
  ) async {
    final (progress, _) = await _pumpApp(tester);
    await _openTab(tester, Icons.quiz_outlined);
    await tester.tap(find.text('Begin'));
    await tester.pumpAndSettle();

    expect(_saveWord, findsOneWidget, reason: 'no heart on a quiz question');
    await tester.tap(_saveWord);
    await tester.pumpAndSettle();
    expect(progress.favorites.count, 1);

    // The question after it arrives unsaved, and saves on its own.
    await tester.tap(find.text('A'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(_saveWord);
    await tester.pumpAndSettle();
    expect(progress.favorites.count, 2);
  });

  testWidgets('every word in the results can be saved', (tester) async {
    final (progress, _) = await _pumpApp(tester, size: const Size(800, 1600));
    await _openTab(tester, Icons.quiz_outlined);
    await tester.tap(find.text('Begin'));
    await tester.pumpAndSettle();
    await _playToTheEnd(tester);

    expect(_saveWord, findsNWidgets(4), reason: 'a heart per word reviewed');
    for (var row = 0; row < 4; row++) {
      await tester.tap(_saveWord.at(row));
      await tester.pumpAndSettle();
    }
    expect(progress.favorites.count, 4);
  });

  // The one screen that always had it, kept.
  testWidgets('the lexicon card still saves', (tester) async {
    final (progress, _) = await _pumpApp(tester);
    await _openTab(tester, Icons.menu_book_outlined);

    await tester.tap(_saveWord.first);
    await tester.pumpAndSettle();
    expect(progress.favorites.count, 1);

    // And the Saved tab shows what it saved.
    await _openTab(tester, Icons.favorite_border);
    expect(_saveWord, findsOneWidget);
  });

  // The Save pill is at the foot of the word's own page, behind the roots,
  // the sentence and the gloss. A reader who knows they want the word should
  // not have to read to the end of it to keep it.
  testWidgets('a word can be saved from the top of its own page', (
    tester,
  ) async {
    final (progress, _) = await _pumpApp(tester);
    await _openTab(tester, Icons.menu_book_outlined);
    await tester.tap(find.text('Edulcorate'));
    await tester.pumpAndSettle();

    expect(_saveWord, findsOneWidget, reason: 'no heart on the page itself');
    await tester.tap(_saveWord);
    await tester.pumpAndSettle();
    expect(progress.favorites.contains('edulcorate'), isTrue);

    // And the pill at the foot of the page — which a ListView has not even
    // built yet — agrees when the reader gets there.
    await tester.scrollUntilVisible(
      find.text('Saved'),
      300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 40,
    );
    expect(find.text('Saved'), findsOneWidget);
  });

  // Four icons stand in the quiz's top row now, and the progress bar has
  // whatever they leave. The smallest phone at the largest text is where
  // that runs out first; an overflow anywhere fails this on its own.
  testWidgets('the quiz header fits a small phone at the largest text size', (
    tester,
  ) async {
    await _pumpApp(tester, size: const Size(320, 640), textScale: 2.0);
    await _openTab(tester, Icons.quiz_outlined);
    // Twice the text puts the button under the fold of a 640pt phone.
    await tester.scrollUntilVisible(
      find.text('Begin'),
      200,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 30,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Begin'));
    await tester.pumpAndSettle();
    expect(_saveWord, findsOneWidget);
  });
}
