import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/quiz_engine.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/screens/quiz_screen.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/quiz_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';

/// Eight words: a full theme, a thin one, and origins that cross both, so a
/// distractor can be chosen by theme, by origin, or by neither.
const _fixture = '''
{
  "categories": [
    {"id": "speech", "label": "Speech & Rhetoric"},
    {"id": "mind", "label": "Knowledge & Thought"},
    {"id": "solo", "label": "A Theme Of One"}
  ],
  "words": [
    {
      "id": "a1", "word": "Alpha", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "AL-fuh", "definition": "The first of them.",
      "friendly": "The one at the front.", "example": "An Alpha stood first.",
      "tags": ["speech"], "origin": "Latin", "originWord": "alphus",
      "roots": [{"form": "alphus", "meaning": "foremost"}]
    },
    {
      "id": "a2", "word": "Beta", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "BAY-tuh", "definition": "The second of them.",
      "friendly": "The one behind.", "example": "A Beta followed.",
      "tags": ["speech"], "origin": "Latin", "originWord": "betus",
      "roots": [{"form": "betus", "meaning": "next after"}]
    },
    {
      "id": "a3", "word": "Gamma", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "GAM-uh", "definition": "The third of them.",
      "friendly": "The one after that.", "example": "A Gamma came late.",
      "tags": ["speech"], "origin": "Greek", "originWord": "gammos",
      "roots": [{"form": "gammos", "meaning": "third in line"}]
    },
    {
      "id": "a4", "word": "Delta", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "DEL-tuh", "definition": "The fourth of them.",
      "friendly": "The one at the back.", "example": "A Delta came last.",
      "tags": ["speech"], "origin": "Greek", "originWord": "deltos",
      "roots": [{"form": "deltos", "meaning": "fourth in line"}]
    },
    {
      "id": "b1", "word": "Epsilon", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "EP-sih-lon", "definition": "A very small amount.",
      "friendly": "Hardly anything at all.", "example": "An Epsilon of doubt.",
      "tags": ["mind"], "origin": "Greek", "originWord": "epsilos",
      "roots": [{"form": "epsilos", "meaning": "the least of it"}]
    },
    {
      "id": "b2", "word": "Zeta", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "ZAY-tuh", "definition": "A quantity left over.",
      "friendly": "What remains when the rest is gone.",
      "example": "A Zeta remained.",
      "tags": ["mind"], "origin": "Greek", "originWord": "zetos",
      "roots": [{"form": "zetos", "meaning": "the remainder"}]
    },
    {
      "id": "b3", "word": "Eta", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "AY-tuh", "definition": "A measure of usefulness.",
      "friendly": "How much of it does any good.",
      "example": "The Eta was poor.",
      "tags": ["mind"], "origin": "Latin", "originWord": "etus",
      "roots": [{"form": "etus", "meaning": "of use"}]
    },
    {
      "id": "c1", "word": "Theta", "variants": [], "partOfSpeech": "noun",
      "pronunciation": "THAY-tuh", "definition": "An angle of turning.",
      "friendly": "How far around it has gone.",
      "example": "The Theta widened.",
      "tags": ["solo"], "origin": "Greek", "originWord": "thetos",
      "roots": [{"form": "thetos", "meaning": "turned aside"}]
    }
  ]
}
''';

/// The quiz screen's own four, with root meanings that appear nowhere else
/// in the entry — so a reading that names a root cannot be mistaken for one
/// that merely read the definitions out.
const _words = [
  WordEntry(
    id: 'edulcorate',
    word: 'Edulcorate',
    partOfSpeech: 'verb',
    pronunciation: 'ee-DUL-kuh-rate',
    definition: 'To take the bitterness from a thing.',
    friendly: 'To make a hard thing easier to take.',
    example: 'The editor edulcorated the review.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'edulcorare',
    roots: [WordRoot(form: 'dulcis', meaning: 'honeyed')],
  ),
  WordEntry(
    id: 'garrulous',
    word: 'Garrulous',
    partOfSpeech: 'adjective',
    pronunciation: 'GAIR-uh-lus',
    definition: 'Given to talking without end.',
    friendly: "Won't stop for breath.",
    example: 'The garrulous cab driver talked the whole way.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'garrulus',
    roots: [WordRoot(form: 'garrire', meaning: 'to prattle')],
  ),
  WordEntry(
    id: 'mendicant',
    word: 'Mendicant',
    partOfSpeech: 'noun',
    pronunciation: 'MEN-dih-kunt',
    definition: 'One who lives on what is given.',
    friendly: 'Someone who asks for charity.',
    example: 'The mendicant friars owned nothing.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'mendicans',
    roots: [WordRoot(form: 'mendicare', meaning: 'to plead')],
  ),
  WordEntry(
    id: 'paroxysm',
    word: 'Paroxysm',
    partOfSpeech: 'noun',
    pronunciation: 'PARR-uk-siz-um',
    definition: 'A sudden violent outburst.',
    friendly: 'A burst of feeling all at once.',
    example: 'A paroxysm of laughter.',
    tags: ['speech'],
    origin: 'Greek',
    originWord: 'paroxysmos',
    roots: [WordRoot(form: 'oxys', meaning: 'keen-edged')],
  ),
];

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  final repo = WordRepository.fromJsonString(_fixture);
  WordEntry wordFor(String id) => repo.words.firstWhere((w) => w.id == id);

  // ---- The wrong answers ------------------------------------------------
  //
  // Drawn at random from the whole lexicon, a wrong answer was rarely in the
  // same country as the right one — *Hebetude* was asked against moralizing,
  // wisdom and air pressure — and any hint at all then picked the answer out
  // of that field.

  group('a wrong answer could have been right', () {
    test('the other three come from the theme when the theme has three', () {
      final engine = QuizEngine(random: Random(7));
      // Every question in a theme of four, many times over: the three wrong
      // answers are always the rest of that theme.
      for (var run = 0; run < 20; run++) {
        for (final question in engine.build(words: repo.words, count: 8)) {
          final target = question.word;
          final themed = repo.words
              .where((w) =>
                  w.id != target.id && w.tags.any(target.tags.contains))
              .toList();
          if (themed.length < 3) continue;
          final wrong = question.options.toList()
            ..removeAt(question.correctIndex);
          for (final definition in wrong) {
            expect(
              themed.map((w) => w.definition),
              contains(definition),
              reason: '${target.word} was asked against a word from '
                  'another theme while its own theme had three to spare',
            );
          }
        }
      }
    });

    test('a theme of one falls back to a shared origin', () {
      final engine = QuizEngine(random: Random(11));
      final solo = wordFor('c1');
      final kin = repo.words
          .where((w) => w.id != solo.id && w.origin == solo.origin)
          .map((w) => w.definition)
          .toSet();
      expect(kin, hasLength(4), reason: 'the fixture lost its Greek words');

      for (var run = 0; run < 20; run++) {
        final question = engine
            .build(words: [solo], count: 1, distractors: repo.words)
            .single;
        final wrong = question.options.toList()
          ..removeAt(question.correctIndex);
        expect(
          wrong.where(kin.contains),
          hasLength(3),
          reason: 'a Latin word was taken while Greek ones were free',
        );
      }
    });

    test('a thin pool still fills four options rather than throwing', () {
      final engine = QuizEngine(random: Random(3));
      final questions = engine.build(
        words: repo.wordsForCategory('solo'),
        count: 5,
        distractors: repo.words,
      );
      expect(questions, hasLength(1));
      for (final question in questions) {
        expect(question.options, hasLength(4));
        expect(question.options.toSet(), hasLength(4));
        expect(question.options[question.correctIndex],
            question.word.definition);
      }
    });
  });

  // ---- The roots --------------------------------------------------------

  group('the roots wait for the answer', () {
    Future<(SilentSpeechEngine, QuizController)> openQuiz(
      WidgetTester tester, {
      bool autoplay = false,
    }) async {
      SharedPreferences.setMockInitialValues({
        'beautiful-words:autoplay': autoplay,
      });
      final prefs = await SharedPreferences.getInstance();
      final engine = SilentSpeechEngine();
      final quiz = QuizController()..start(_words, count: 4);

      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: SettingsController(prefs)),
            ChangeNotifierProvider.value(value: ProgressController(prefs)),
            ChangeNotifierProvider.value(value: quiz),
            ChangeNotifierProvider.value(
              value: SpeechController(engine: engine),
            ),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: ThemeData(
              useMaterial3: true,
              extensions: const [BrandColors.light],
            ),
            home: const Scaffold(body: QuizScreen()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return (engine, quiz);
    }

    testWidgets('the card holds them back, then gives them over', (
      tester,
    ) async {
      final (_, quiz) = await openQuiz(tester);
      final root = quiz.current!.word.roots.single;

      expect(find.text('roots'), findsNothing);
      expect(find.text(root.form), findsNothing);
      expect(
        find.text(root.meaning),
        findsNothing,
        reason: '"${root.meaning}" was on the page beside the answer',
      );

      // The word and where it came from stay: they are the question.
      expect(find.text(quiz.current!.word.word), findsOneWidget);
      expect(find.text(quiz.current!.word.origin), findsOneWidget);

      await tester.tap(find.text(quiz.current!.options.first));
      await tester.pumpAndSettle();

      expect(find.text(root.form), findsOneWidget);
      expect(find.text(root.meaning), findsOneWidget);
    });

    testWidgets('the next question closes them again', (tester) async {
      final (_, quiz) = await openQuiz(tester);
      await tester.tap(find.text(quiz.current!.options.first));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      final root = quiz.current!.word.roots.single;
      expect(find.text(root.form), findsNothing);
      expect(find.text(root.meaning), findsNothing);
    });

    // Hiding them on the page and reading them out a second later would only
    // move the giveaway to the listen button.
    testWidgets('the reading holds them back too', (tester) async {
      final (engine, quiz) = await openQuiz(tester, autoplay: true);
      final word = quiz.current!.word;
      final root = word.roots.single;

      final heard = engine.spokenSegments.join(' ');
      expect(heard, contains(word.word), reason: 'the quiz opened in silence');
      expect(heard, contains('From ${word.origin}'));
      expect(heard, isNot(contains(root.form)));
      expect(heard, isNot(contains(root.meaning)));
      expect(heard, isNot(contains(word.friendly)));
    });

    testWidgets('and reads them once the answer is in', (tester) async {
      final (engine, quiz) = await openQuiz(tester);
      final root = quiz.current!.word.roots.single;

      await tester.tap(find.text(quiz.current!.options.first));
      await tester.pumpAndSettle();
      engine.spokenSegments.clear();

      await tester.tap(find.byTooltip('Listen'));
      await tester.pumpAndSettle();

      final heard = engine.spokenSegments.join(' ');
      expect(heard, contains(root.form));
      expect(heard, contains(root.meaning));
      expect(heard, contains(quiz.current!.word.friendly));
    });

    test('the spoken quiz says the roots only once it is answered', () {
      final entry = _words.first;
      final root = entry.roots.single;

      final asked = entry.spokenQuiz(revealed: false);
      expect(asked, contains(entry.word));
      expect(asked, contains('From ${entry.origin}'));
      expect(asked, isNot(contains(root.form)));
      expect(asked, isNot(contains(root.meaning)));

      final answered = entry.spokenQuiz(revealed: true);
      expect(answered, contains(root.form));
      expect(answered, contains(root.meaning));
      expect(answered, contains(entry.friendly));
    });

    // The word's own page is not a question, and keeps everything.
    test('the entry reading is untouched', () {
      final entry = _words.first;
      expect(entry.spokenPrompt, contains(entry.roots.single.form));
      expect(entry.spokenPrompt, contains(entry.roots.single.meaning));
    });
  });
}
