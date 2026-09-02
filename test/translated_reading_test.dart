import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/models/ssml.dart';
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

/// Which voice gets which words, with the shipped Dutch behind it.
///
/// The pieces are covered in english_narration_test.dart — these are the
/// ones that fail if a screen stops asking for the split, or hands its own
/// translated copy to the English voice.
void main() {
  testWidgets('the page cuts its Dutch reading at the English it quotes',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:locale': 'nl-NL',
      'beautiful-words:read-translation': true,
    });
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );

    // Reading the shipped assets is real I/O, and a widget test's clock is
    // not: without runAsync the load never returns.
    final repo = (await tester.runAsync(() async {
      final loaded = await WordRepository.load();
      await loaded.applyLocale('nl');
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
          locale: const Locale('nl'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              reading = readingOf(context, entry);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    // The lemma, its pronunciation and the English sentence come first, in
    // English, as they always did.
    expect(reading.first.isEnglish, isTrue);
    // The engine is handed the lemma's sound, not its spelling.
    expect(reading.first.text, contains('æmˈfɪbəliː'));
    expect(reading.first.text, contains('am fib uh lee'));

    final dutch = reading.where((piece) => piece.languageTag == 'nl-NL');
    final english = reading.where((piece) => piece.isEnglish);

    expect(dutch, isNotEmpty, reason: 'the explanation stopped being Dutch');
    expect(
      dutch.map((piece) => piece.text).join(' '),
      contains('zin'),
      reason: 'the Dutch around the quote should still be Dutch',
    );

    // The point of the whole exercise: this sentence is English, and goes
    // to the English voice even though it sits inside a Dutch paragraph.
    expect(
      english.map((piece) => piece.text).join(' '),
      contains('Visiting relatives can be tiring'),
    );
    for (final piece in dutch) {
      expect(piece.text, isNot(contains('Visiting relatives')));
    }

    // One passage, so a device with no Dutch voice trades all of it for the
    // English fallback rather than reading half of it twice.
    final groups = {for (final piece in dutch) piece.group};
    expect(groups.length, 1);
    expect(dutch.first.fallback, isNotNull);
  });

  testWidgets('the reading covers the whole page, in both voices',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:locale': 'nl-NL',
      'beautiful-words:read-translation': true,
    });
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );

    final repo = (await tester.runAsync(() async {
      final loaded = await WordRepository.load();
      await loaded.applyLocale('nl');
      return loaded;
    }))!;
    final entry = repo.words.firstWhere((word) => word.id == 'torpid');

    late List<SpeechSegment> reading;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: repo),
        ],
        child: MaterialApp(
          locale: const Locale('nl'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              reading = readingOf(context, entry);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    final english =
        reading.where((p) => p.isEnglish).map((p) => p.text).join(' ');
    final dutch =
        reading.where((p) => !p.isEnglish).map((p) => p.text).join(' ');

    // The card at the top of the page - what kind of word, where it came
    // from, what it is built of - went unread before this.
    expect(dutch, contains('bijvoeglijk naamwoord'));
    expect(dutch, contains('Latijn'));
    expect(english, contains('torpidus'), reason: 'the etymon is not Dutch');
    expect(english, contains('torpere'), reason: 'a root form is not Dutch');
    expect(dutch, contains('verdoofd zijn'));
    expect(dutch, contains('in een staat van'));

    // Then the meaning, the sentence, and the sentence in Dutch - the last
    // of which was left off the reading entirely.
    expect(dutch, contains('Langzaam en half in slaap'));
    expect(dutch, contains('lichamelijk inactief'));
    expect(
      ssmlWithoutTags(english),
      // The word inside the sentence is handed over as its sound too, so
      // what is left when the tags come off is the respelling.
      contains('The office fell tor pidd in the heavy heat'),
    );
    expect(dutch, contains('Het kantoor viel'));
    expect(dutch, contains('augustushitte'));

    // The lemma opens it, in English, as it always did.
    expect(reading.first.isEnglish, isTrue);
    expect(reading.first.text, contains('tor pidd'));

    // And no Dutch voice is ever handed the English.
    for (final piece in reading.where((p) => !p.isEnglish)) {
      expect(piece.text, isNot(contains('The office fell')));
      expect(piece.text, isNot(contains('torpere')));
    }
  });

  testWidgets('with the switch off the whole page is read in English',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:locale': 'nl-NL',
      'beautiful-words:read-translation': false,
    });
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );
    final repo = (await tester.runAsync(() async {
      final loaded = await WordRepository.load();
      await loaded.applyLocale('nl');
      return loaded;
    }))!;
    final entry = repo.words.firstWhere((word) => word.id == 'torpid');

    late List<SpeechSegment> reading;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: repo),
        ],
        child: MaterialApp(
          locale: const Locale('nl'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              reading = readingOf(context, entry);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(reading.length, 1);
    expect(reading.single.isEnglish, isTrue);
    final spoken = reading.single.text;
    // The same page, the same order, one voice.
    expect(spoken, contains('tor pidd'));
    expect(spoken, contains('adjective'));
    expect(spoken, contains('From Latin, torpidus.'));
    expect(spoken, contains('torpere'));
    expect(spoken, contains('Slow and half-asleep'));
    expect(
      ssmlWithoutTags(spoken),
      contains('The office fell tor pidd'),
    );
    expect(spoken, isNot(contains('Latijn')));
  });

  // The detail page had the switch to itself for a while. A card, the word
  // of the day and the quiz all read the same word out of the same lexicon,
  // and all three did it in English no matter what the reader had asked for.
  group('the shorter readings', () {
    Future<List<SpeechSegment>> readingWith(
      WidgetTester tester, {
      required bool readInDutch,
      required List<SpeechSegment> Function(BuildContext, WordEntry) build,
    }) async {
      SharedPreferences.setMockInitialValues({
        'beautiful-words:locale': 'nl-NL',
        'beautiful-words:read-translation': readInDutch,
      });
      final prefs = await SharedPreferences.getInstance();
      final settings = SettingsController(
        prefs,
        catalog: LocaleCatalog.fromJsonString(
          File('l10n/catalog.json').readAsStringSync(),
        ),
      );
      final repo = (await tester.runAsync(() async {
        final loaded = await WordRepository.load();
        await loaded.applyLocale('nl');
        return loaded;
      }))!;
      final entry = repo.words.firstWhere((word) => word.id == 'torpid');

      late List<SpeechSegment> reading;
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: settings),
            ChangeNotifierProvider.value(value: repo),
          ],
          child: MaterialApp(
            locale: const Locale('nl'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: Builder(
              builder: (context) {
                reading = build(context, entry);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      return reading;
    }

    testWidgets('a card reads its lemma in English and its meaning in Dutch',
        (tester) async {
      final reading = await readingWith(
        tester,
        readInDutch: true,
        build: (context, entry) =>
            glanceOf(context, entry, group: 'card:torpid'),
      );

      expect(reading.first.isEnglish, isTrue);
      expect(reading.first.text, contains('tor pidd'));

      final dutch = reading.where((p) => !p.isEnglish);
      expect(dutch, isNotEmpty, reason: 'the glance stayed English');
      expect(
        dutch.map((p) => p.text).join(' '),
        contains('Langzaam en half in slaap'),
      );
      // One passage, so a phone with no Dutch voice reads the English glance
      // once rather than a lemma and then silence.
      expect({for (final p in reading) p.group}, {'card:torpid'});
      expect(dutch.first.fallback, contains('Slow and half-asleep'));
    });

    testWidgets('with the switch off a card is one English utterance',
        (tester) async {
      final reading = await readingWith(
        tester,
        readInDutch: false,
        build: (context, entry) =>
            glanceOf(context, entry, group: 'card:torpid'),
      );

      expect(reading.length, 1);
      expect(reading.single.isEnglish, isTrue);
      expect(reading.single.text, contains('Slow and half-asleep'));
      expect(reading.single.text, isNot(contains('Langzaam')));
    });

    // A question built by hand, so the assertions can name the four answers.
    // The Dutch and English lists are the pair the reading has to keep
    // straight: the page shows one, the English fallback speaks the other.
    QuizQuestion question(WordEntry entry) => QuizQuestion(
          word: entry,
          options: [entry.definition, 'Een', 'Twee', 'Drie'],
          englishOptions: [
            entry.english.definition,
            'One',
            'Two',
            'Three',
          ],
          correctIndex: 0,
        );

    testWidgets('the quiz keeps its answer back until the answer is given',
        (tester) async {
      final asked = await readingWith(
        tester,
        readInDutch: true,
        build: (context, entry) => quizReadingOf(
          context,
          question(entry),
          revealed: false,
          group: 'quiz:torpid:0',
        ),
      );
      final dutchAsked =
          asked.where((p) => !p.isEnglish).map((p) => p.text).join(' ');

      // The prompt: the word, where it came from, what it is built of.
      expect(asked.first.isEnglish, isTrue);
      expect(asked.first.text, contains('tor pidd'));
      expect(dutchAsked, contains('Latijn'));
      expect(dutchAsked, contains('verdoofd zijn'));
      // Not what it means - that is the question.
      expect(dutchAsked, isNot(contains('Langzaam en half in slaap')));

      // The four answers, lettered as the page letters them, in the language
      // the page shows them in. A listener cannot choose between four
      // definitions they have never heard.
      expect(dutchAsked, contains('welke definitie past'));
      expect(dutchAsked, contains('A.'));
      expect(dutchAsked, contains('B. Een'));
      expect(dutchAsked, contains('D. Drie'));
      // The English twins belong to the fallback, not to this reading.
      expect(dutchAsked, isNot(contains('One')));

      final answered = await readingWith(
        tester,
        readInDutch: true,
        build: (context, entry) => quizReadingOf(
          context,
          question(entry),
          revealed: true,
          group: 'quiz:torpid:0',
        ),
      );
      expect(
        answered.where((p) => !p.isEnglish).map((p) => p.text).join(' '),
        contains('Langzaam en half in slaap'),
      );

      // The etymon and the root forms are Latin, and stay with the English
      // voice in both halves.
      for (final reading in [asked, answered]) {
        final english =
            reading.where((p) => p.isEnglish).map((p) => p.text).join(' ');
        expect(english, contains('torpidus'));
        expect(english, contains('torpere'));
        for (final piece in reading.where((p) => !p.isEnglish)) {
          expect(piece.text, isNot(contains('torpere')));
        }
      }
    });

    testWidgets('with the switch off the quiz asks in English',
        (tester) async {
      final reading = await readingWith(
        tester,
        readInDutch: false,
        build: (context, entry) => quizReadingOf(
          context,
          question(entry),
          revealed: false,
          group: 'quiz:torpid:0',
        ),
      );

      expect(reading.length, 1);
      expect(reading.single.isEnglish, isTrue);
      final spoken = reading.single.text;
      expect(spoken, contains('From Latin, torpidus.'));
      expect(spoken, contains('which definition fits?'));
      // The English twins of the four answers - the Dutch on screen would be
      // mangled by an English voice, which is the whole point of the pair.
      expect(spoken, contains('B. One'));
      expect(spoken, contains('D. Three'));
      expect(spoken, isNot(contains('Een')));
      expect(spoken, isNot(contains('Latijn')));
    });
  });

  group("the app's own copy", () {
    // The quiz results read a line of the app's own words. On a Dutch phone
    // that line is Dutch, and it used to go to the English-locked voice.
    Future<List<SpeechSegment>> scoreLine(
      WidgetTester tester, {
      required bool readInDutch,
    }) async {
      SharedPreferences.setMockInitialValues({
        'beautiful-words:locale': 'nl-NL',
        'beautiful-words:read-translation': readInDutch,
      });
      final prefs = await SharedPreferences.getInstance();
      final settings = SettingsController(
        prefs,
        catalog: LocaleCatalog.fromJsonString(
          File('l10n/catalog.json').readAsStringSync(),
        ),
      );

      late List<SpeechSegment> line;
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: settings,
          child: MaterialApp(
            locale: const Locale('nl'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context);
                line = spokenLine(
                  context,
                  localized: l10n.definitionsRightSpoken(7, 10),
                  english: englishCopy.definitionsRightSpoken(7, 10),
                  group: 'results',
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      return line;
    }

    testWidgets('the English copy is there to fall back on', (tester) async {
      expect(
        englishCopy.definitionsRightSpoken(7, 10),
        '7 definitions right, of 10.',
      );
    });

    testWidgets('a Dutch score line asks for a Dutch voice', (tester) async {
      final line = await scoreLine(tester, readInDutch: true);
      expect(line.length, 1);
      expect(line.single.languageTag, 'nl-NL');
      expect(line.single.text, isNot(equals(line.single.fallback)));
      expect(line.single.text, contains('definities'));
      // And English waits behind it for a device with no Dutch voice.
      expect(line.single.fallback, '7 definitions right, of 10.');
    });

    testWidgets('with the switch off the line is spoken in English',
        (tester) async {
      final line = await scoreLine(tester, readInDutch: false);
      expect(line.length, 1);
      expect(line.single.isEnglish, isTrue);
      expect(line.single.text, '7 definitions right, of 10.');
    });

    testWidgets('no Dutch voice means the English line, not a Dutch one',
        (tester) async {
      final line = await scoreLine(tester, readInDutch: true);
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'en-us-x-sfg', locale: 'en-us')],
      );
      await SpeechController(engine: engine).speakSegments('results', line);
      expect(engine.spokenSegments, ['en:7 definitions right, of 10.']);
    });

    testWidgets('a Dutch voice reads the Dutch line', (tester) async {
      final line = await scoreLine(tester, readInDutch: true);
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'nl-nl-x-dma-local', locale: 'nl-nl')],
      );
      await SpeechController(engine: engine).speakSegments('results', line);
      expect(engine.spokenSegments.single, startsWith('nl-NL:'));
      expect(engine.spokenSegments.single, contains('definities'));
    });
  });
}
