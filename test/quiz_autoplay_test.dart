import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/screens/quiz_screen.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/quiz_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';

/// "Read a word aloud when it opens", carried into the quiz.
///
/// The detail page had the setting to itself: a reader with it switched on
/// opened a quiz and got silence, then had to find the speaker in the corner
/// for every one of ten questions.
const _words = [
  WordEntry(
    id: 'edulcorate',
    word: 'Edulcorate',
    partOfSpeech: 'verb',
    pronunciation: 'ee-DUL-kuh-rate',
    definition: 'To sweeten or purify.',
    friendly: 'To take the bitterness out.',
    example: 'The editor edulcorated the review.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'edulcorare',
    roots: [WordRoot(form: 'dulcis', meaning: 'sweet')],
  ),
  WordEntry(
    id: 'garrulous',
    word: 'Garrulous',
    partOfSpeech: 'adjective',
    pronunciation: 'GAIR-uh-lus',
    definition: 'Excessively talkative.',
    friendly: "Just won't stop chatting.",
    example: 'The garrulous cab driver talked the whole way.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'garrulus',
    roots: [WordRoot(form: 'garrire', meaning: 'to chatter')],
  ),
  WordEntry(
    id: 'mendicant',
    word: 'Mendicant',
    partOfSpeech: 'noun',
    pronunciation: 'MEN-dih-kunt',
    definition: 'A beggar, or one living on alms.',
    friendly: 'Someone who lives by asking for charity.',
    example: 'The mendicant friars owned nothing.',
    tags: ['speech'],
    origin: 'Latin',
    originWord: 'mendicans',
    roots: [WordRoot(form: 'mendicare', meaning: 'to beg')],
  ),
  WordEntry(
    id: 'paroxysm',
    word: 'Paroxysm',
    partOfSpeech: 'noun',
    pronunciation: 'PARR-uk-siz-um',
    definition: 'A sudden violent outburst.',
    friendly: 'A sudden intense burst of emotion.',
    example: 'A paroxysm of laughter.',
    tags: ['speech'],
    origin: 'Greek',
    originWord: 'paroxysmos',
    roots: [WordRoot(form: 'oxys', meaning: 'sharp')],
  ),
];

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<(SilentSpeechEngine, QuizController)> openQuiz(
    WidgetTester tester, {
    required bool autoplay,
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
          ChangeNotifierProvider.value(value: SpeechController(engine: engine)),
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

  String spoken(SilentSpeechEngine engine) => engine.spokenSegments.join(' ');

  testWidgets('the question reads itself when the setting is on',
      (tester) async {
    final (engine, quiz) = await openQuiz(tester, autoplay: true);
    final question = quiz.current!;

    final heard = spoken(engine);
    expect(heard, isNotEmpty, reason: 'the quiz opened in silence');
    expect(heard, contains(question.word.word));
    expect(heard, contains('From ${question.word.origin}'));

    // The four answers, lettered as the page letters them. Without them a
    // listener is asked to choose between definitions they never heard.
    expect(heard, contains('which definition fits?'));
    for (var i = 0; i < question.options.length; i++) {
      expect(
        heard,
        contains('${String.fromCharCode(65 + i)}. ${question.options[i]}'),
      );
    }

    // Not the meaning - that is the answer.
    expect(heard, isNot(contains(question.word.friendly)));
  });

  testWidgets('with the setting off the quiz opens in silence',
      (tester) async {
    final (engine, _) = await openQuiz(tester, autoplay: false);
    expect(engine.spokenSegments, isEmpty);
    expect(engine.lastSpoken, isNull);
  });

  testWidgets('answering does not start the reading over', (tester) async {
    final (engine, quiz) = await openQuiz(tester, autoplay: true);
    expect(engine.spokenSegments, isNotEmpty);
    engine.spokenSegments.clear();

    await tester.tap(find.text(quiz.current!.options.first));
    await tester.pumpAndSettle();

    // The reader is reading the page at this moment; talking over them is
    // worse than saying nothing.
    expect(engine.spokenSegments, isEmpty);
  });

  testWidgets('the next question reads itself in turn', (tester) async {
    final (engine, quiz) = await openQuiz(tester, autoplay: true);
    final first = quiz.current!.word.word;

    await tester.tap(find.text(quiz.current!.options.first));
    await tester.pumpAndSettle();
    engine.spokenSegments.clear();

    await tester.tap(find.text(AppLocalizations.of(
      tester.element(find.byType(QuizScreen)),
    ).next));
    await tester.pumpAndSettle();

    final second = quiz.current!.word.word;
    expect(second, isNot(first), reason: 'the quiz did not advance');
    expect(spoken(engine), contains(second));
  });
}
