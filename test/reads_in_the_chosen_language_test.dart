import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/quiz_engine.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/state/reading.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';

/// A reader who picks a language is read to in it.
///
/// "Read the translation aloud" defaulted to off, so a fresh install spoke
/// English in all sixty: pick Arabic, press listen, hear English. Every
/// translated test seeded the preference to true, so the whole suite was green
/// while the app did this — which is why the default gets its own file rather
/// than a line in someone else's.
///
/// A reinstall clears preferences, so this was not a one-time cost. It came
/// back every time the app was installed again.
void main() {
  Future<List<SpeechSegment>> readingWith(
    WidgetTester tester, {
    required Map<String, Object> preferences,
    required String localeId,
    required String languageCode,
    List<SpeechSegment> Function(BuildContext, WordEntry)? build,
  }) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:locale': localeId,
      ...preferences,
    });
    final settings = SettingsController(
      await SharedPreferences.getInstance(),
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );
    final repo = (await tester.runAsync(() async {
      final loaded = await WordRepository.load();
      await loaded.applyLocale(languageCode);
      return loaded;
    }))!;
    final entry = repo.words.firstWhere((word) => word.id == 'amphiboly');

    late List<SpeechSegment> reading;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: repo),
        ],
        child: MaterialApp(
          locale: Locale(languageCode),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              reading = (build ?? readingOf)(context, entry);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    return reading;
  }

  testWidgets('a fresh install reads Dutch to a Dutch reader', (tester) async {
    final reading = await readingWith(
      tester,
      preferences: const {}, // nothing chosen — this is the install default
      localeId: 'nl-NL',
      languageCode: 'nl',
    );
    expect(
      reading.where((piece) => piece.languageTag == 'nl-NL'),
      isNotEmpty,
      reason: 'a reader who picked Dutch was read to in English',
    );
  });

  testWidgets('a fresh install reads Arabic to an Arabic reader', (
    tester,
  ) async {
    final reading = await readingWith(
      tester,
      preferences: const {},
      localeId: 'ar',
      languageCode: 'ar',
    );
    expect(
      reading.where((piece) => !piece.isEnglish),
      isNotEmpty,
      reason: 'a reader who picked Arabic was read to in English',
    );
  });

  testWidgets('a reader who turned it off stays off', (tester) async {
    final reading = await readingWith(
      tester,
      preferences: const {'beautiful-words:read-translation': false},
      localeId: 'nl-NL',
      languageCode: 'nl',
    );
    expect(
      reading.every((piece) => piece.isEnglish),
      isTrue,
      reason: 'the switch stopped being obeyed',
    );
  });

  testWidgets('an English reader is unaffected', (tester) async {
    final reading = await readingWith(
      tester,
      preferences: const {},
      localeId: 'en-US',
      languageCode: 'en',
    );
    expect(reading.every((piece) => piece.isEnglish), isTrue);
  });

  // ---- and it reaches every reading, not only the word's own page --------
  //
  // "Does that switch still do anything?" is a fair question to ask of a
  // control that sits under a voice picker and a pace slider, and the file
  // above only ever answered it for `readingOf` — the reading a word's page
  // gives. The app builds four, and the switch is one `readerLanguageTag`
  // call inside the shape all four share, so proving one proves nothing
  // about the other three: a screen only has to reach past `reading.dart`
  // to lose it, which is exactly what the quiz results once did.
  //
  // So this walks the lot, in both positions. On, each has to carry a piece
  // in Dutch; off, every piece has to be English. Six listen buttons and the
  // study's own preview are built from these four between them.
  group('the switch reaches every reading the app builds', () {
    final readings = <String, List<SpeechSegment> Function(BuildContext,
        WordEntry)>{
      // The word's page.
      'readingOf': readingOf,
      // A lexicon card, the word of the day, a result row, and the voice
      // preview in the study — the button the reader is looking at when
      // they touch this switch.
      'glanceOf': (context, entry) =>
          glanceOf(context, entry, group: 'sweep'),
      // A question and its four answers.
      'quizReadingOf': (context, entry) => quizReadingOf(
            context,
            QuizQuestion(
              word: entry,
              options: const ['Een', 'Twee', 'Drie', 'Vier'],
              englishOptions: const ['One', 'Two', 'Three', 'Four'],
              correctIndex: 0,
            ),
            revealed: false,
            group: 'sweep',
          ),
      // The app's own copy — a score, a heading.
      'spokenLine': (context, entry) => spokenLine(
            context,
            localized: 'Vier van de vijf goed',
            english: 'Four of five right',
          ),
    };

    readings.forEach((name, build) {
      testWidgets('$name reads Dutch when the switch is on', (tester) async {
        final reading = await readingWith(
          tester,
          preferences: const {'beautiful-words:read-translation': true},
          localeId: 'nl-NL',
          languageCode: 'nl',
          build: build,
        );
        expect(
          reading.where((piece) => piece.languageTag == 'nl-NL'),
          isNotEmpty,
          reason: '$name never asked for the Dutch voice',
        );
      });

      testWidgets('$name reads English when the switch is off',
          (tester) async {
        final reading = await readingWith(
          tester,
          preferences: const {'beautiful-words:read-translation': false},
          localeId: 'nl-NL',
          languageCode: 'nl',
          build: build,
        );
        expect(
          reading.every((piece) => piece.isEnglish),
          isTrue,
          reason: '$name ignored the switch being off',
        );
      });
    });
  });
}
