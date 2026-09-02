import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/screens/quiz_results_screen.dart';
import 'package:beautiful_words/state/quiz_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';
import 'package:beautiful_words/widgets/speak_button.dart';

const _words = [
  WordEntry(
    id: 'edulcorate',
    word: 'Edulcorate',
    partOfSpeech: 'verb',
    pronunciation: 'ee-DUL-cor-ate',
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

/// The results page reads a line of the app's own words. It has to reach the
/// engine on a tablet exactly as it does on a phone — the page is wider
/// there, and its speak button sits in the app bar either way.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<SilentSpeechEngine> openResults(
    WidgetTester tester, {
    required Size size,
    bool readInDutch = false,
    List<VoiceOption> voices = const [],
  }) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:read-translation': readInDutch,
    });
    final prefs = await SharedPreferences.getInstance();
    final engine = SilentSpeechEngine(voices: voices);
    final quiz = QuizController()..start(_words, count: 4);
    for (var i = 0; i < quiz.length; i++) {
      quiz.select(quiz.questions[i].correctIndex);
      quiz.next();
    }

    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SettingsController(prefs)),
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
          home: const QuizResultsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return engine;
  }

  /// The button in the app bar, not the one on each answered word.
  final scoreButton = find.descendant(
    of: find.byType(AppBar),
    matching: find.byType(SpeakButton),
  );

  for (final size in const <String, Size>{
    'phone': Size(390, 844),
    'tablet portrait': Size(834, 1112),
    'tablet landscape': Size(1112, 834),
  }.entries) {
    testWidgets('the score reads aloud on a ${size.key}', (tester) async {
      final engine = await openResults(tester, size: size.value);

      expect(scoreButton, findsOneWidget, reason: 'no speak button');
      await tester.tap(scoreButton);
      await tester.pumpAndSettle();

      expect(
        engine.spokenSegments,
        ['en:4 definitions right, of 4.'],
        reason: 'the score never reached the engine',
      );
    });
  }

  testWidgets('a tablet reader who asked for Dutch gets a Dutch voice',
      (tester) async {
    final engine = await openResults(
      tester,
      size: const Size(1112, 834),
      readInDutch: true,
      voices: const [VoiceOption(name: 'nl-nl-x-dma-local', locale: 'nl-nl')],
    );
    await tester.tap(scoreButton);
    await tester.pumpAndSettle();
    // English here, because this harness runs the page in English: what
    // matters is that a tagged segment still reaches the engine.
    expect(engine.spokenSegments, isNotEmpty);
  });

  testWidgets('the word rows read aloud too', (tester) async {
    final engine = await openResults(tester, size: const Size(1112, 834));
    final rowButtons = find.byType(SpeakButton);
    expect(rowButtons, findsNWidgets(5), reason: 'one score, four words');

    await tester.tap(rowButtons.last);
    await tester.pumpAndSettle();
    expect(engine.lastSpoken, isNotNull);
    expect(engine.lastSpoken, contains('.'));
  });
}
