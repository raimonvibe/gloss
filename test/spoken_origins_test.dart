import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/l10n/speech_templates.dart';
import 'package:beautiful_words/models/origin_voice.dart';
import 'package:beautiful_words/models/spoken_origin.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/state/reading.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';

/// Loads the shipped lexicon under [translationKey].
///
/// Reading the assets is real I/O and a widget test's clock is not, so it
/// has to happen inside runAsync or the load never returns.
Future<WordRepository> _shipped(
  WidgetTester tester,
  String translationKey,
) async {
  return (await tester.runAsync(() async {
    final loaded = await WordRepository.load();
    await loaded.applyLocale(translationKey);
    return loaded;
  }))!;
}

/// The reading of [entry] as a reader of [localeId] hears it.
Future<List<SpeechSegment>> _readingIn(
  WidgetTester tester, {
  required String localeId,
  required WordRepository repo,
  required WordEntry entry,
}) async {
  SharedPreferences.setMockInitialValues({
    'beautiful-words:locale': localeId,
    'beautiful-words:read-translation': true,
  });
  final prefs = await SharedPreferences.getInstance();
  final settings = SettingsController(
    prefs,
    catalog: LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    ),
  );

  late List<SpeechSegment> reading;
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: repo),
      ],
      child: MaterialApp(
        locale: Locale(localeId.split('-').first),
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

void main() {
  // ---- The word the word came from -------------------------------------
  //
  // A Dutch reader was told *Chicane* comes "van Frans" and then heard
  // *chicaner* read with an English mouth.

  group('an etymon is read in its own language', () {
    const french = WordEntry(
      id: 'chicane',
      word: 'Chicane',
      partOfSpeech: 'noun',
      pronunciation: 'shih-KAYN',
      definition: 'A quibble.',
      friendly: 'A petty objection.',
      example: 'The chicane delayed the hearing.',
      tags: ['speech'],
      origin: 'French',
      originWord: 'chicaner',
      roots: [
        WordRoot(form: 'chicaner', meaning: 'to quibble'),
        WordRoot(form: 'chicane', meaning: 'trickery'),
      ],
    );

    test('the etymon and its roots take the origin\'s voice', () {
      expect(french.etymonVoiceFor('chicaner'), 'fr-FR');
      expect(french.etymonVoiceFor('chicane'), 'fr-FR');
      expect(french.etymonVoiceFor('Chicaner'), 'fr-FR', reason: 'case');
      expect(french.etymonVoiceFor('quibble'), isNull);
      expect(french.etymonVoiceFor(''), isNull);
    });

    test('Latin is read by the nearest voice there is', () {
      const latin = WordEntry(
        id: 'edulcorate',
        word: 'Edulcorate',
        partOfSpeech: 'verb',
        pronunciation: 'ee-DUL-kuh-rate',
        definition: 'To sweeten.',
        friendly: 'To take the bitterness out.',
        example: 'The editor edulcorated the review.',
        tags: ['speech'],
        origin: 'Latin',
        originWord: 'edulcorare',
        roots: [WordRoot(form: 'dulcis', meaning: 'sweet')],
      );
      expect(latin.etymonVoiceFor('edulcorare'), kOriginVoices['Latin']);
      expect(latin.etymonVoiceFor('dulcis'), kOriginVoices['Latin']);
    });

    // The page writes Greek in Latin letters, which a Greek voice would
    // spell; the voice is handed the Greek letters instead. Heard on a
    // device: "van Grieks, mathesis" said the etymon as an English word.
    test('a Greek etymon is handed to a Greek voice, in Greek letters', () {
      const greek = WordEntry(
        id: 'paroxysm',
        word: 'Paroxysm',
        partOfSpeech: 'noun',
        pronunciation: 'PARR-uk-siz-um',
        definition: 'A sudden outburst.',
        friendly: 'A burst of feeling.',
        example: 'A paroxysm of laughter.',
        tags: ['speech'],
        origin: 'Greek',
        originWord: 'paroxysmos',
        roots: [WordRoot(form: 'oxys', meaning: 'sharp')],
      );
      expect(greek.etymonVoiceFor('paroxysmos'), kGreekVoice);
      expect(greek.spokenEtymonFor('paroxysmos')!.text, 'παροξυσμός');
      expect(greek.spokenEtymonFor('oxys')!.text, 'οξύς');
      // The page is untouched: the transliteration is what it shows.
      expect(greek.originWord, 'paroxysmos');
      // A form this entry does not own is nobody's, Greek table or not.
      expect(greek.spokenEtymonFor('logos'), isNull);
    });

    // Greek with no Greek spelling here keeps the English voice rather than
    // being sent to a Greek mouth as Latin letters, which is the whole
    // reason the table is per form instead of per origin label.
    test('an unlisted Greek form keeps the English voice', () {
      const unlisted = WordEntry(
        id: 'notaword',
        word: 'Notaword',
        partOfSpeech: 'noun',
        pronunciation: 'NOT-uh-word',
        definition: 'A word that is not.',
        friendly: 'Not a word.',
        example: 'Notaword is not a word.',
        tags: ['speech'],
        origin: 'Greek',
        originWord: 'notēgrapton',
        roots: [WordRoot(form: 'notē', meaning: 'not')],
      );
      expect(unlisted.spokenEtymonFor('notēgrapton'), isNull);
      expect(unlisted.spokenEtymonFor('notē'), isNull);
    });

    // The table is keyed on the form alone, and a prefix is not the property
    // of one language: *pro-* is Greek in *proleptical* and Spanish in
    // *pronunciamento*, which was being sent to a Greek voice.
    testWidgets('a Greek form is only Greek in a word that has Greek in it', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'en');
      final byId = {for (final word in repo.words) word.id: word};

      expect(byId['proleptical']!.spokenEtymonFor('pro-')!.text, 'προ');
      final spanish = byId['pronunciamento']!;
      expect(spanish.origin, 'Spanish');
      expect(spanish.etymonVoiceFor('pro-'), kOriginVoices['Spanish']);
      expect(spanish.spokenEtymonFor('pro-')!.text, 'pro-');

      // No word outside the twenty-two ever reaches the Greek table.
      final greekVoiced = repo.words.where(
        (word) => [
          word.originWord,
          for (final root in word.roots) root.form,
        ].any((form) => word.etymonVoiceFor(form) == kGreekVoice),
      );
      expect(greekVoiced, hasLength(21));
      for (final word in greekVoiced) {
        expect(
          word.origin.contains('Greek'),
          isTrue,
          reason: '${word.id} is ${word.origin} and got a Greek voice',
        );
      }
    });

    // Every Greek form in the table is Greek: a Latin letter left in one
    // would be spelled out by the voice it was written for, which is the
    // bug this table exists to fix, inverted.
    test('the Greek table is written in Greek letters', () {
      final latin = RegExp(r'[A-Za-zāēīōū]');
      for (final entry in kGreekScript.entries) {
        expect(
          latin.hasMatch(entry.value),
          isFalse,
          reason: '${entry.key} is spoken as "${entry.value}", which still '
              'carries Latin letters',
        );
        expect(entry.key, entry.key.toLowerCase(), reason: 'lookup lowercases');
        expect(entry.value.contains('-'), isFalse, reason: 'a hyphen is said');
      }
    });

    // Word 135 is safe rather than lucky: a new Greek word whose forms are
    // not in the table fails here rather than being read in English on a
    // device.
    testWidgets('every Greek form in the lexicon is in the table', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'en');
      // Not Greek, though they sit on Greek stems or beside Greek words.
      const notGreek = {
        '-ic', '-etic', // English suffixes on Greek stems
        'spleneticus', 'pedante', // Latin and Italian, with their own voices
        'theodicy (leibniz)', // a coinage naming its coiner
        // Two languages in one string, the same as `racine (radix)`. It
        // keeps the English voice by kMixedForm, and a Greek spelling here
        // would drop the "(Greek)" that the page shows beside it.
        'paidagōgos (greek)',
        // A macron is not proof of Greek — Old English writes one too, and
        // hlēo has no voice of any kind. Named here so the sweep can go on
        // using the macron as its signal for the words that are Greek.
        'hlēo', 'hlēo + side',
        // Two letters. segmentTranslation never cuts a term this short out
        // of a passage, so it never reaches a voice on its own, and a lone
        // Greek letter handed to a Greek voice would be read as its name.
        'a-',
      };
      final missing = <String>[];
      for (final word in repo.words) {
        final greekWord = word.origin.contains('Greek');
        for (final form in [
          word.originWord,
          for (final root in word.roots) root.form,
        ]) {
          final key = form.trim().toLowerCase();
          if (kGreekScript.containsKey(key) || notGreek.contains(key)) continue;
          // Either the origin says Greek, or a macron says so for it.
          if (greekWord || kTransliteratedGreek.hasMatch(key)) {
            missing.add('${word.id}: $form');
          }
        }
      }
      expect(missing, isEmpty, reason: 'a Greek form has no Greek spelling');
    });

    testWidgets('the shipped Greek etymon reaches a Greek voice', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'nl');
      final entry = repo.words.firstWhere((word) => word.id == 'mathesis');
      final reading = await _readingIn(
        tester,
        localeId: 'nl-NL',
        repo: repo,
        entry: entry,
      );

      final greek = reading.where((piece) => piece.languageTag == kGreekVoice);
      expect(greek, isNotEmpty, reason: 'the etymon stayed with English');
      final said = greek.map((piece) => piece.text).join(' ');
      expect(said, contains('μάθησις'));
      expect(said, isNot(contains('mathesis')));

      // Alone, like the French one: a device with no Greek voice loses this
      // word and keeps its Dutch reading.
      for (final piece in greek) {
        expect(piece.group, isNull, reason: 'the etymon joined the passage');
        expect(piece.fallback, isNotNull, reason: 'no English to fall back on');
      }
      expect(
        reading.where((piece) => piece.languageTag == 'nl-NL'),
        isNotEmpty,
        reason: 'the Dutch explanation went missing',
      );
    });

    test('a compound origin and a mixed form keep the English voice', () {
      const mixed = WordEntry(
        id: 'plumb',
        word: 'Plumb line',
        partOfSpeech: 'noun',
        pronunciation: 'PLUM line',
        definition: 'A weighted cord.',
        friendly: 'A string with a weight.',
        example: 'The plumb line hung true.',
        tags: ['objects'],
        origin: 'Latin / English',
        originWord: 'plumbum + line',
        roots: [WordRoot(form: 'plumbum', meaning: 'lead')],
      );
      expect(mixed.etymonVoiceFor('plumbum'), isNull, reason: 'compound');

      const glossed = WordEntry(
        id: 'deracinate',
        word: 'Deracinate',
        partOfSpeech: 'verb',
        pronunciation: 'dih-RASS-ih-nate',
        definition: 'To uproot.',
        friendly: 'To tear out by the roots.',
        example: 'War deracinated them.',
        tags: ['conflict'],
        origin: 'French',
        originWord: 'déraciner',
        roots: [WordRoot(form: 'racine (radix)', meaning: 'root')],
      );
      // Two languages in one string: the French word and its Latin gloss.
      expect(glossed.etymonVoiceFor('racine (radix)'), isNull);
      expect(glossed.etymonVoiceFor('déraciner'), 'fr-FR');
    });

    // A census, so "did you do all of them?" has an answer that is checked
    // rather than remembered. Everything not named here is read in the
    // language it was written in.
    testWidgets('every word that can have an etymon voice has one', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'en');
      expect(repo.words, hasLength(134));

      bool voiced(WordEntry word) => [
            word.originWord,
            for (final root in word.roots) root.form,
          ].any((form) => word.etymonVoiceFor(form) != null);

      final silent = repo.words.where((w) => !voiced(w)).map((w) => w.id);
      expect(
        silent.toSet(),
        {
          // The nineteen Greek words stood here until 2026-09-03. They are
          // read in Greek letters now, out of kGreekScript, so what is left
          // is the words for which there is no voice at all.
          // English, Old English and Middle English. The English voice is
          // the right one, and the only one any engine has.
          'clodpate', 'dint', 'fain', 'lee-side', 'slake', 'dotage', 'gainsay',
          // Frankish, which no engine speaks.
          'seneschal',
          // An English word quoted beside the foreign one — "plumbum + line",
          // "hardi + -hood" — so no single voice is right for the pair.
          'plumb-line', 'hardihood',
        },
        reason: 'a word lost its etymon voice, or gained one unexpectedly',
      );
    });

    testWidgets('the compound origins were resolved one at a time', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'en');
      // All four "Latin / French" words, and no rule could have sorted them:
      // one quotes the Latin and three quote the French.
      final byId = {for (final word in repo.words) word.id: word};
      expect(byId['mordant']!.etymonVoiceFor('mordere'), 'it-IT');
      expect(byId['demur']!.etymonVoiceFor('demorer'), 'fr-FR');
      expect(byId['mortised']!.etymonVoiceFor('mortaise'), 'fr-FR');
      expect(byId['appurtenance']!.etymonVoiceFor('apartenance'), 'fr-FR');

      // Greek hiding under an origin that does not say Greek: "Greek /
      // Latin" and "Italian / Greek" are compounds, so no origin label
      // could have routed these. The form is what decides.
      expect(byId['splenetic']!.etymonVoiceFor('splēn'), kGreekVoice);
      expect(byId['pedantic']!.etymonVoiceFor('paidagōgos'), kGreekVoice);
      expect(byId['pedantic']!.etymonVoiceFor('pedante'), 'it-IT');
    });

    testWidgets('the shipped French etymon reaches a French voice', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'nl');
      final entry = repo.words.firstWhere((word) => word.id == 'chicane');
      final reading = await _readingIn(
        tester,
        localeId: 'nl-NL',
        repo: repo,
        entry: entry,
      );

      final french = reading.where((piece) => piece.languageTag == 'fr-FR');
      expect(french, isNotEmpty, reason: 'the etymon stayed with English');
      expect(
        french.map((piece) => piece.text).join(' ').toLowerCase(),
        contains('chicaner'),
      );

      // It stands or falls alone. Sharing the passage's group would take a
      // whole Dutch reading down to English on a device with no French.
      for (final piece in french) {
        expect(piece.group, isNull, reason: 'the etymon joined the passage');
        expect(piece.fallback, isNotNull, reason: 'no English to fall back on');
        expect(piece.fallback!.trim(), isNotEmpty);
      }

      // And the rest of the reading is untouched.
      expect(
        reading.where((piece) => piece.languageTag == 'nl-NL'),
        isNotEmpty,
        reason: 'the Dutch explanation went missing',
      );
    });
  });

  // ---- The name of the language it came from ----------------------------
  //
  // Dutch writes Old English closed, as "Oudengels", and the voice read it
  // as one word it had never met.

  group('a compound origin is spoken in its parts', () {
    const dutch = {'Engels', 'Frans', 'Latijn', 'Grieks', 'Oudengels'};

    test('a closed compound is split at the language inside it', () {
      expect(spokenOrigin('Oudengels', dutch), 'Oud engels');
      expect(spokenOrigin('Middelengels', dutch), 'Middel engels');
      expect(spokenOrigin('Oudfrans', dutch), 'Oud frans');
    });

    test('each side of a compound origin is split', () {
      expect(
        spokenOrigin('Latijn / Oudfrans', dutch),
        'Latijn / Oud frans',
      );
    });

    test('a label that is already two words is left alone', () {
      expect(spokenOrigin('inglés antiguo', {'inglés', 'latín'}),
          'inglés antiguo');
      expect(spokenOrigin('Latijn', dutch), 'Latijn');
      expect(spokenOrigin('Engels', dutch), 'Engels', reason: 'it is a base');
    });

    test('a script without spaces between words is left alone', () {
      // 古英語 ends in 英語 and is one word to a Japanese voice all the same.
      expect(spokenOrigin('古英語', {'英語', 'ラテン語'}), '古英語');
      expect(spokenOrigin('ภาษาอังกฤษเก่า', {'อังกฤษ'}), 'ภาษาอังกฤษเก่า');
    });

    test('a base too short to mean anything is not a seam', () {
      expect(spokenOrigin('Latin', {'in', 'Latin'}), 'Latin');
    });

    // The whole point of deriving the seam rather than listing it: every
    // locale that compounds gets this without a line of its own, and no
    // locale needs a word of its language known here.
    test('the shipped lexicon splits only by inserting spaces', () {
      final locales = Directory('assets/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList();
      expect(locales.length, 60, reason: 'the overlays moved');

      var split = 0;
      for (final file in locales) {
        final words = (jsonDecode(file.readAsStringSync())
            as Map<String, dynamic>)['words'] as Map<String, dynamic>;
        final labels = <String>{
          for (final word in words.values)
            if ((word as Map<String, dynamic>)['origin'] != null)
              word['origin'] as String,
        };
        final table = spokenOriginTable(labels);
        split += table.length;
        table.forEach((written, spoken) {
          expect(
            spoken.replaceAll(' ', ''),
            written.replaceAll(' ', ''),
            reason: '$written became $spoken in ${file.path} — a spoken '
                'origin may only gain spaces, never letters',
          );
          expect(spoken.split(' ').length, greaterThan(written.split(' ').length));
        });
      }
      // Germanic, Slavic, Finnic, Baltic and Hungarian compound; the rest
      // write the two words apart and are untouched.
      expect(split, greaterThan(80), reason: 'the rule stopped firing');
    });

    // The split is applied where the origin is named, and that is the whole
    // of the fix only while no other sentence quotes one of these compounds.
    // Nothing does today; if a new gloss ever writes "Oudengels" into a
    // definition, this fails and the substitution has to reach the prose too.
    test('a compound origin is never quoted in the prose around it', () {
      final offenders = <String>[];
      for (final file in Directory('assets/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))) {
        final words = (jsonDecode(file.readAsStringSync())
            as Map<String, dynamic>)['words'] as Map<String, dynamic>;
        final labels = <String>{
          for (final word in words.values)
            if ((word as Map<String, dynamic>)['origin'] != null)
              word['origin'] as String,
        };
        // The parts that the rule actually rewrites — not "Latijn", which
        // turns up in Dutch prose all the time and needs nothing.
        final compounds = <String>{
          for (final entry in spokenOriginTable(labels).entries)
            for (final part in entry.key.split('/'))
              if (spokenOrigin(part.trim(), <String>{
                    for (final label in labels)
                      for (final piece in label.split('/'))
                        if (!piece.trim().contains(' ')) piece.trim(),
                  }) !=
                  part.trim())
                part.trim(),
        };
        if (compounds.isEmpty) continue;

        for (final entry in words.entries) {
          final word = entry.value as Map<String, dynamic>;
          final prose = [
            word['definition'],
            word['friendly'],
            word['exampleGloss'],
            word['partOfSpeech'],
            ...?(word['rootMeanings'] as List<dynamic>?),
          ].whereType<String>().join(' ');
          for (final compound in compounds) {
            // Raw strings: '\p' is not an escape Dart knows, so a plain
            // string would hand the engine "p{L}" and match nothing —
            // a test that passes because it never looked.
            final standing = RegExp(
              r'(?<![\p{L}\p{N}])' +
                  RegExp.escape(compound) +
                  r'(?![\p{L}\p{N}])',
              caseSensitive: false,
              unicode: true,
            );
            if (standing.hasMatch(prose)) {
              offenders.add('${file.path} ${entry.key}: $compound');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'a compound origin is spoken inside a sentence, where the '
            'origin field never reaches',
      );
    });

    testWidgets('the Dutch for Old English is handed to the voice in parts', (
      tester,
    ) async {
      final repo = await _shipped(tester, 'nl');
      final entry = repo.words.firstWhere((word) => word.id == 'fain');

      // The page keeps the spelling Dutch actually uses.
      expect(entry.origin, 'Oudengels');
      expect(entry.spokenOrigin, 'Oud engels');

      final spoken = entry.spokenExplanationWith(SpeechTemplates.english);
      expect(spoken, contains('Oud engels'));
      expect(spoken, isNot(contains('Oudengels')));
    });

    testWidgets('English itself needs none of this', (tester) async {
      final repo = await _shipped(tester, 'en');
      final entry = repo.words.firstWhere((word) => word.id == 'fain');
      expect(entry.origin, 'Old English');
      expect(entry.spokenOrigin, isNull);
    });
  });
}
