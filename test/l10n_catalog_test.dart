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

  test('catalog covers 177 countries and shared translation keys', () {
    expect(catalog.countries, hasLength(177));
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
    expect(hits.first.country.iso2, 'NL');
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
      pronunciation: 'ee-DUL-cor-ate',
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
    expect(localized.pronunciation, 'ee-DUL-cor-ate');
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
    "pronunciation": "ee-DUL-cor-ate",
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
}
