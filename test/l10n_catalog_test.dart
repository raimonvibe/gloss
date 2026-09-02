import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/state/settings_controller.dart';

void main() {
  late LocaleCatalog catalog;

  setUpAll(() {
    catalog = LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    );
  });

  test('catalog covers 178 countries and shared translation keys', () {
    expect(catalog.countries, hasLength(178));
    expect(catalog.locales.length, greaterThan(50));
    expect(catalog.translationKeyFor('nl-NL'), 'nl');
    expect(catalog.translationKeyFor('es-US'), 'es_419');
    expect(catalog.translationKeyFor('he-IL'), 'he');
    expect(catalog.infoFor('he-IL')?.rtl, isTrue);
    expect(catalog.infoFor('ar')?.rtl, isTrue);
    expect(catalog.infoFor('nl-NL')?.rtl, isFalse);
  });

  test('device Hebrew and Norwegian map onto catalog locales', () {
    expect(catalog.matchDevice(const [Locale('iw', 'IL')]), 'he-IL');
    expect(catalog.matchDevice(const [Locale('no', 'NO')]), 'nb-NO');
    expect(catalog.matchDevice(const [Locale('nl', 'NL')]), 'nl-NL');
    expect(catalog.matchDevice(const [Locale('xx')]), 'en-US');
  });

  test('picker search matches country, language, and locale code', () {
    final hits = catalog.choices.where(
      (choice) => choice.searchHaystack.contains('nederland'),
    );
    expect(hits, isNotEmpty);
    // Every country on nl-NL carries 'Nederlands' in its haystack (AW, BE, NL,
    // SR), so assert membership rather than ordering.
    expect(hits.any((choice) => choice.country.iso2 == 'NL'), isTrue);
    expect(
      catalog.choices.where((c) => c.searchHaystack.contains('العربية')),
      isNotEmpty,
    );
  });

  test('word overlay keeps English lemma and swaps explanations', () {
    const entry = WordEntry(
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
    );
    final localized = entry.withOverlay(
      const WordOverlay(
        partOfSpeech: 'werkwoord',
        definition: 'Zoeten of zuiveren.',
        friendly: 'De bitterheid eruit halen.',
        exampleGloss: 'De redacteur verzachtte de recensie.',
        origin: 'Latijn',
        rootMeanings: ['zoet'],
      ),
    );
    expect(localized.word, 'Edulcorate');
    expect(localized.pronunciation, 'ee-DUL-kuh-rate');
    expect(localized.originWord, 'edulcorare');
    expect(localized.partOfSpeech, 'werkwoord');
    expect(localized.friendly, 'De bitterheid eruit halen.');
    expect(localized.example, 'The editor edulcorated the review.');
    expect(localized.exampleGloss, 'De redacteur verzachtte de recensie.');
    expect(localized.roots.first.form, 'dulcis');
    expect(localized.roots.first.meaning, 'zoet');
  });

  test('settings persist a chosen locale id', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs, catalog: catalog);
    await settings.setLocaleId('nl-NL');
    expect(settings.savedLocaleId, 'nl-NL');
    expect(prefs.getString('beautiful-words:locale'), 'nl-NL');
    expect(
      settings.localeFor(const [Locale('en', 'US')]),
      const Locale('nl', 'NL'),
    );
  });

  test('every non-English translation key has a word overlay file', () {
    const incomplete = <String>{};
    final keys = catalog.locales.map((locale) => locale.translationKey).toSet();
    for (final key in keys) {
      if (key == 'en' || incomplete.contains(key)) continue;
      final file = File('assets/l10n/words_$key.json');
      expect(file.existsSync(), isTrue, reason: 'missing overlay for $key');
      final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final words = decoded['words'] as Map<String, dynamic>;
      expect(words.length, 134, reason: '$key should cover every lemma');
      final sample = words['edulcorate'] as Map<String, dynamic>;
      expect(sample['friendly'], isNotEmpty);
      expect(sample['exampleGloss'], isNotEmpty);
      expect(sample['rootMeanings'], hasLength(2));
    }
  });

  test('repository search still finds English lemmas after overlay', () {
    final repo = WordRepository.fromJsonString('''
{
  "categories": [{"id": "speech", "label": "Speech"}],
  "words": [{
    "id": "edulcorate",
    "word": "Edulcorate",
    "variants": [],
    "partOfSpeech": "verb",
    "pronunciation": "ee-DUL-kuh-rate",
    "definition": "To sweeten.",
    "friendly": "To take the bitterness out.",
    "example": "The editor edulcorated the review.",
    "tags": ["speech"],
    "origin": "Latin",
    "originWord": "edulcorare",
    "roots": [{"form": "dulcis", "meaning": "sweet"}]
  }]
}
''');
    expect(repo.search(query: 'Edulcorate'), isNotEmpty);
  });

  group('choiceForLocale picks the locale\'s own country', () {
    LocaleCatalog realCatalog() => LocaleCatalog.fromJsonString(
          File('l10n/catalog.json').readAsStringSync(),
        );

    test('nl-NL is the Netherlands, not the first country alphabetically', () {
      final catalog = realCatalog();

      // Aruba, Belgium, Netherlands and Suriname all list nl-NL, and the
      // country list is alphabetical, so Aruba used to win.
      final claimants = catalog.choices
          .where((c) => c.locale.id == 'nl-NL')
          .map((c) => c.country.name)
          .toList();
      expect(claimants.length, greaterThan(1));
      expect(claimants.first, isNot('Netherlands'));

      expect(catalog.choiceForLocale('nl-NL')?.country.iso2, 'NL');
    });

    test('every locale naming a country resolves to that country', () {
      final catalog = realCatalog();
      final wrong = <String>[];

      for (final locale in catalog.locales) {
        final code = locale.countryCode;
        if (code == null || code.isEmpty) continue;
        final claimed = catalog.choices.any(
          (c) =>
              c.locale.id == locale.id &&
              c.country.iso2.toUpperCase() == code.toUpperCase(),
        );
        if (!claimed) continue;
        final resolved = catalog.choiceForLocale(locale.id);
        if (resolved?.country.iso2.toUpperCase() != code.toUpperCase()) {
          expect(resolved, isNotNull);
          wrong.add('${locale.id} -> ${resolved?.country.iso2} (want $code)');
        }
      }

      expect(wrong, isEmpty);
    });

    test('a regional locale still resolves to some country', () {
      final catalog = realCatalog();
      final regional = catalog.locales.where(
        (l) => l.countryCode == null || l.countryCode!.isEmpty,
      );

      for (final locale in regional) {
        final claimed =
            catalog.choices.any((c) => c.locale.id == locale.id);
        if (!claimed) continue;
        expect(
          catalog.choiceForLocale(locale.id),
          isNotNull,
          reason: '${locale.id} lost its country',
        );
      }
    });
  });

  group('every locale carries the whole UI', () {
    Map<String, String> messagesOf(File file) {
      final decoded =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      return {
        for (final entry in decoded.entries)
          if (!entry.key.startsWith('@')) entry.key: entry.value as String,
      };
    }

    List<File> arbFiles() => Directory('lib/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));

    Set<String> placeholdersOf(String value) => RegExp(r'\{(\w+)\}')
        .allMatches(value)
        .map((m) => m.group(1)!)
        .toSet();

    test('no locale falls back to English for a missing key', () {
      final english = messagesOf(File('lib/l10n/app_en.arb'));
      final gaps = <String>[];

      for (final file in arbFiles()) {
        if (file.path.endsWith('app_en.arb')) continue;
        final missing = english.keys
            .where((k) => !messagesOf(file).containsKey(k))
            .toList();
        if (missing.isNotEmpty) {
          gaps.add('${file.uri.pathSegments.last}: ${missing.length} missing '
              '(${missing.take(4).join(', ')}...)');
        }
      }

      // gen-l10n falls back per key rather than failing, so a half-translated
      // screen ships silently. This is the only thing that catches it.
      expect(gaps, isEmpty, reason: gaps.join('\n'));
    });

    test('placeholders survive translation in every locale', () {
      final english = messagesOf(File('lib/l10n/app_en.arb'));
      final wrong = <String>[];

      for (final file in arbFiles()) {
        if (file.path.endsWith('app_en.arb')) continue;
        final name = file.uri.pathSegments.last;
        messagesOf(file).forEach((key, value) {
          final source = english[key];
          if (source == null) return;
          final want = placeholdersOf(source);
          final got = placeholdersOf(value);
          if (!got.containsAll(want)) {
            wrong.add('$name/$key lost ${want.difference(got)}');
          }
        });
      }

      expect(wrong, isEmpty, reason: wrong.join('\n'));
    });

    test('the lemma and the product name stay English', () {
      final wrong = <String>[];

      for (final file in arbFiles()) {
        final name = file.uri.pathSegments.last;
        final messages = messagesOf(file);
        // Gloss is a bilingual dictionary: the headword is never translated.
        final sample = messages['textSizeSample'];
        if (sample != null && !sample.contains('Edulcorate')) {
          wrong.add('$name/textSizeSample dropped the English lemma');
        }
        for (final key in ['versionLine', 'shareGloss', 'appTitle']) {
          final value = messages[key];
          if (value != null && !value.contains('Gloss')) {
            wrong.add('$name/$key dropped the product name');
          }
        }
      }

      expect(wrong, isEmpty, reason: wrong.join('\n'));
    });
  });

  group('the catalog and the ARBs agree on which locales exist', () {
    Set<String> arbKeys() => Directory('lib/l10n')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'))
        .map((f) => f.uri.pathSegments.last)
        .map((n) => n.substring('app_'.length, n.length - '.arb'.length))
        .toSet();

    test('no ARB is stranded without a catalog locale', () {
      final reachable = catalog.locales
          .map((l) => l.translationKey)
          .toSet()
        ..add('en');

      // app_zh.arb carried a whole Simplified Chinese UI that nothing could
      // ever select, because China was missing from the country list.
      expect(arbKeys().difference(reachable), isEmpty);
    });

    test('no catalog locale is left without an ARB', () {
      final keys = catalog.locales.map((l) => l.translationKey).toSet();
      expect(keys.difference(arbKeys()), isEmpty);
    });

    test('Simplified Chinese is reachable, and names China', () {
      expect(catalog.translationKeyFor('zh-CN'), 'zh');
      expect(catalog.choiceForLocale('zh-CN')?.country.iso2, 'CN');
      expect(catalog.infoFor('zh-CN')?.languageNameEn, 'Chinese (Simplified)');

      // Traditional must not have been disturbed by adding Simplified.
      expect(catalog.translationKeyFor('zh-TW'), 'zh_TW');
      expect(catalog.translationKeyFor('zh-HK'), 'zh_HK');
    });
  });
}
