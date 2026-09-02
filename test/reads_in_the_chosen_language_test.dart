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
              reading = readingOf(context, entry);
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
}
