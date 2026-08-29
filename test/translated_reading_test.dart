import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
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
    expect(reading.first.text, contains('Amphiboly'));

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
