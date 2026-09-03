import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/l10n/speech_templates.dart';
import 'package:beautiful_words/models/ssml.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/state/speech_controller.dart';

const _dutch = WordOverlay(
  partOfSpeech: 'werkwoord',
  definition: 'Zoeten of zuiveren.',
  friendly: 'De bitterheid eruit halen.',
  exampleGloss: 'De redacteur verzachtte de recensie.',
  origin: 'Latijn',
  // One meaning, because the entry below has one root.
  rootMeanings: ['zoet'],
);

const _entry = WordEntry(
  id: 'edulcorate',
  word: 'Edulcorate',
  variants: ['edulcorated'],
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

const _amphiboly = WordEntry(
  id: 'amphiboly',
  word: 'Amphiboly',
  partOfSpeech: 'noun',
  pronunciation: 'am-FIB-uh-lee',
  definition: 'Ambiguity of grammatical structure.',
  friendly: 'A sentence that can be read two ways.',
  example: '"Visiting relatives can be tiring" is a classic amphiboly.',
  tags: ['speech'],
  origin: 'Greek',
  originWord: 'amphibolos',
  roots: [
    WordRoot(form: 'amphi-', meaning: 'both'),
    WordRoot(form: 'ballein', meaning: 'to throw'),
  ],
);

/// The lexicon is English and the TTS engine is locked to an English voice.
/// Speaking translated text through it makes the voice mangle the words —
/// the mirror of the bug where a Dutch device voice mangled English lemmas.
void main() {
  group('read-aloud stays English after a locale is applied', () {
    final localized = _entry.withOverlay(_dutch);

    test('display fields are translated', () {
      expect(localized.partOfSpeech, 'werkwoord');
      expect(localized.friendly, 'De bitterheid eruit halen.');
      expect(localized.definition, 'Zoeten of zuiveren.');
      expect(localized.exampleGloss, 'De redacteur verzachtte de recensie.');
      expect(localized.roots.first.meaning, 'zoet');
    });

    test('the entry keeps a handle on its English original', () {
      expect(localized.english.friendly, 'To take the bitterness out.');
      expect(localized.english.partOfSpeech, 'verb');
      // An un-overlaid entry is its own English source.
      expect(_entry.english, same(_entry));
    });

    test('spoken entry carries no translated words', () {
      final spoken = localized.spokenEntry;
      expect(spoken, contains('Edulcorate'));
      expect(spoken, contains('verb'));
      expect(spoken, contains('To take the bitterness out.'));
      expect(spoken, contains('To sweeten or purify.'));
      expect(spoken, isNot(contains('werkwoord')));
      expect(spoken, isNot(contains('bitterheid')));
      expect(spoken, isNot(contains('Zoeten')));
    });

    test('spoken glance, prompt, and quiz stay English too', () {
      expect(localized.spokenGlance, isNot(contains('bitterheid')));
      expect(localized.spokenGlance, contains('To take the bitterness out.'));

      expect(localized.spokenPrompt, contains('Latin'));
      expect(localized.spokenPrompt, contains('sweet'));
      expect(localized.spokenPrompt, isNot(contains('Latijn')));
      expect(localized.spokenPrompt, isNot(contains('zoet')));

      final quiz = localized.spokenQuiz(revealed: true);
      expect(quiz, contains('To take the bitterness out.'));
      expect(quiz, isNot(contains('bitterheid')));
    });

    test('overlaying twice does not lose the English source', () {
      final twice = localized.withOverlay(_dutch);
      expect(twice.english.friendly, 'To take the bitterness out.');
      expect(twice.spokenEntry, isNot(contains('bitterheid')));
    });
  });

  test('the real Thai overlay never reaches the English voice', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final repo = await WordRepository.load();
    await repo.applyLocale('th');
    final entry = repo.words.firstWhere((word) => word.id == 'edulcorate');

    // Thai on the page…
    expect(entry.friendly, isNot(equals(entry.english.friendly)));
    expect(RegExp(r'[฀-๿]').hasMatch(entry.friendly), isTrue);

    // …and not a single Thai character in what gets spoken.
    expect(RegExp(r'[฀-๿]').hasMatch(entry.spokenEntry), isFalse);
    expect(RegExp(r'[฀-๿]').hasMatch(entry.spokenPrompt), isFalse);
  });

  _splitNarration();
  _quotedEnglish();
}

/// A translation quotes the lexicon rather than translating it: the headword
/// and the sentence it lives in stay English inside the reader's own
/// language. Those words belong to the English voice wherever they appear.
void _quotedEnglish() {
  group('English quoted inside a translation', () {
    const dutch = 'Een zin die grammatisch klopt, maar op twee heel '
        'verschillende manieren te lezen is, zoals '
        '„Visiting relatives can be tiring.”';

    List<SpeechSegment> cut(String text, {String? fallback}) {
      return segmentTranslation(
        text,
        languageTag: 'nl-NL',
        englishTerms: _amphiboly.quotedEnglish,
        fallback: fallback,
        group: 'explanation',
      );
    }

    test('the entry offers the English a translation may quote', () {
      final quoted = _amphiboly.quotedEnglish;
      expect(quoted, contains('Amphiboly'));
      // The phrase the example puts in quotation marks, which is what the
      // Dutch quotes - not the whole sentence around it.
      expect(quoted, contains('Visiting relatives can be tiring'));
      expect(quoted, contains('ballein'));
    });

    test('the English sentence becomes a segment of its own', () {
      final segments = cut(dutch);
      expect(segments.length, 2);
      expect(segments[0].languageTag, 'nl-NL');
      expect(segments[0].text, startsWith('Een zin die'));

      expect(segments[1].isEnglish, isTrue);
      expect(segments[1].text, 'Visiting relatives can be tiring');
      // What is left of the Dutch is a full stop and a closing quote, which
      // no voice needs to say.
    });

    test('the headword is handed back to the English voice as well', () {
      final segments = cut('Dit is een klassieke amphiboly in het Nederlands.');
      expect(segments.map((s) => s.text).toList(), [
        'Dit is een klassieke',
        'amphiboly',
        'in het Nederlands.',
      ]);
      expect(segments[1].isEnglish, isTrue);
    });

    test('a translation quoting nothing English stays one segment', () {
      final segments = cut('Zoeten of zuiveren.');
      expect(segments.length, 1);
      expect(segments.single.languageTag, 'nl-NL');
    });

    test('a term inside a longer word is left alone', () {
      // 'ballein' is a root of this entry; 'balleinachtig' is not it.
      final segments = cut('Een balleinachtig woord.');
      expect(segments.length, 1);
      expect(segments.single.languageTag, 'nl-NL');
    });

    test('the whole passage speaks when the voice is there', () async {
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'nl-nl-x-dma-local', locale: 'nl-nl')],
      );
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('entry:amphiboly', cut(dutch));
      // No quotation mark reaches the engine: the opening one the Dutch
      // was left holding is trimmed, and quotation marks are not sounds.
      expect(engine.spokenSegments, [
        'nl-NL:Een zin die grammatisch klopt, maar op twee heel '
            'verschillende manieren te lezen is, zoals',
        'en:Visiting relatives can be tiring',
      ]);
    });

    test('the shipped Dutch entry no longer hands English to a Dutch voice',
        () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final repo = await WordRepository.load();
      await repo.applyLocale('nl');
      final entry = repo.words.firstWhere((word) => word.id == 'amphiboly');

      // This is the entry from the bug report: the Dutch explanation quotes
      // the English sentence in the middle of a Dutch one.
      final dutch = SpeechTemplates.fromL10n(
        lookupAppLocalizations(const Locale('nl')),
      );
      expect(
        entry.spokenExplanationWith(dutch),
        contains('Visiting relatives'),
      );

      final segments = segmentTranslation(
        entry.spokenExplanationWith(dutch),
        languageTag: 'nl-NL',
        englishTerms: entry.quotedEnglish,
        group: 'explanation',
      );
      final english = segments.where((piece) => piece.isEnglish);
      expect(
        english.map((piece) => piece.text),
        contains('Visiting relatives can be tiring'),
      );
      for (final piece in segments.where((piece) => !piece.isEnglish)) {
        expect(piece.text, isNot(contains('Visiting relatives')));
      }
    });

    test('no shipped passage in any script keeps English for a local voice',
        () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final repo = await WordRepository.load();

      // One from each family the catalog covers, including a right-to-left
      // script and two that are not written in Latin letters at all.
      final leaked = <String>[];
      for (final locale in ['nl', 'de', 'fr', 'ru', 'th', 'ar']) {
        await repo.applyLocale(locale);
        for (final entry in repo.words) {
          final segments = segmentTranslation(
            entry.spokenExplanationWith(
              SpeechTemplates.fromL10n(
                lookupAppLocalizations(Locale(locale)),
              ),
            ),
            languageTag: locale,
            englishTerms: entry.quotedEnglish,
            group: entry.id,
          );
          for (final piece in segments.where((piece) => !piece.isEnglish)) {
            for (final term in entry.quotedEnglish) {
              if (term.length < 3) continue;
              // A term standing on its own is English that the local voice
              // would have to read. The same string inside a longer word of
              // the language ('gefricasseerd') is simply that language, and
              // stays where it is.
              if (_standingAlone(term).hasMatch(piece.text)) {
                leaked.add('$locale/${entry.id}: "$term"');
              }
            }
          }
        }
      }
      expect(leaked, isEmpty, reason: 'English left for a local voice');
    });

    test('no voice is ever handed a quotation mark to pronounce', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final repo = await WordRepository.load();

      // What the engine was handed, and which entry it came from.
      final spoken = <(String, String)>[];
      for (final locale in ['nl', 'de', 'fr']) {
        await repo.applyLocale(locale);
        final templates = SpeechTemplates.fromL10n(
          lookupAppLocalizations(Locale(locale)),
        );
        for (final entry in repo.words) {
          final engine = SilentSpeechEngine(
            voices: [VoiceOption(name: '$locale-x-local', locale: locale)],
          );
          await SpeechController(engine: engine).speakSegments(entry.id, [
            SpeechSegment(entry.spokenWord, group: entry.id),
            ...segmentTranslation(
              entry.spokenExplanationWith(templates),
              languageTag: locale,
              englishTerms: entry.quotedEnglish,
              fallback: entry.english.spokenEntry,
              group: entry.id,
            ),
          ]);
          for (final line in engine.spokenSegments) {
            // 'nl:betekenis werpen.' — the tag is everything up to the
            // first colon, the utterance is the rest.
            final split = line.indexOf(':');
            spoken.add(('$locale/${entry.id}', line.substring(split + 1)));
          }
        }
      }
      expect(spoken, isNotEmpty, reason: 'nothing was spoken to check');

      // A quotation mark is a mark on the page. Some engines say it out
      // loud, in the middle of a sentence, in the reader's language.
      final quoted = [
        for (final (where, text) in spoken)
          if (_quotationMark.hasMatch(text)) '$where: $text',
      ];
      expect(quoted, isEmpty, reason: 'a quotation mark reached a voice');

      // And nothing opens on the punctuation the English left behind — a
      // full stop and a closing quote were being read out as words.
      final dangling = [
        for (final (where, text) in spoken)
          if (_opensOnPunctuation.hasMatch(text)) '$where: $text',
      ];
      expect(dangling, isEmpty, reason: 'a piece opens on punctuation');
    });

    test('no Dutch voice replaces the passage once, not piece by piece',
        () async {
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'en-us-x-sfg', locale: 'en-us')],
      );
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('entry:amphiboly', [
        const SpeechSegment('Amphiboly. noun.'),
        ...cut(dutch, fallback: 'A sentence that can be read two ways.'),
      ]);
      // The English quoted inside the Dutch does not survive on its own: it
      // would be said once alone and again inside the fallback.
      expect(engine.spokenSegments, [
        'en:Amphiboly. noun.',
        'en:A sentence that can be read two ways.',
      ]);
    });
  });
}

/// The opt-in second half: the explanation may follow the reader's language,
/// but only through a voice that actually speaks it.
void _splitNarration() {
  group('split narration', () {
    final localized = _entry.withOverlay(_dutch);
    const dutchVoices = [VoiceOption(name: 'nl-nl-x-dma-local', locale: 'nl-nl')];

    test('picks an exact locale match over a same-language one', () {
      final voice = pickVoiceForLanguage(const [
        {'name': 'pt-br-x-ptd-network', 'locale': 'pt-BR'},
        {'name': 'pt-pt-x-pmj-local', 'locale': 'pt-PT'},
      ], 'pt-PT');
      expect(voice!.name, 'pt-pt-x-pmj-local');
    });

    test('falls back to the language when the region is missing', () {
      final voice = pickVoiceForLanguage(const [
        {'name': 'es-es-x-eef-local', 'locale': 'es-ES'},
      ], 'es-419');
      expect(voice!.locale, 'es-es');
    });

    test('prefers an offline voice over a network one', () {
      final voice = pickVoiceForLanguage(const [
        {'name': 'nl-nl-x-dma-network', 'locale': 'nl-NL'},
        {'name': 'nl-nl-x-dma-local', 'locale': 'nl-NL'},
      ], 'nl-NL');
      expect(voice!.name, contains('local'));
    });

    test('returns nothing when the device has no such voice', () {
      final voice = pickVoiceForLanguage(const [
        {'name': 'en-us-x-sfg-local', 'locale': 'en-US'},
      ], 'my-MM');
      expect(voice, isNull);
    });

    test('both segments play when a voice exists', () async {
      final engine = SilentSpeechEngine(voices: dutchVoices);
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('entry:edulcorate', const [
        SpeechSegment('Edulcorate. verb.'),
        SpeechSegment('De bitterheid eruit halen.', languageTag: 'nl-NL'),
      ]);
      expect(engine.spokenSegments, [
        'en:Edulcorate. verb.',
        'nl-NL:De bitterheid eruit halen.',
      ]);
    });

    test('a segment with no voice and no fallback is dropped, not mangled',
        () async {
      // A Burmese reader on a device with only an English voice.
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'en-us-x-sfg', locale: 'en-us')],
      );
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('entry:edulcorate', const [
        SpeechSegment('Edulcorate. verb.'),
        SpeechSegment('ချိုစေခြင်း', languageTag: 'my-MM'),
      ]);
      expect(engine.spokenSegments, ['en:Edulcorate. verb.']);
    });

    test('a missing voice falls back to English rather than losing the text',
        () async {
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'en-us-x-sfg', locale: 'en-us')],
      );
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('entry:edulcorate', const [
        SpeechSegment('Edulcorate. verb.'),
        SpeechSegment(
          'ချိုစေခြင်း',
          languageTag: 'my-MM',
          fallback: 'To take the bitterness out.',
        ),
      ]);
      expect(engine.spokenSegments, [
        'en:Edulcorate. verb.',
        'en:To take the bitterness out.',
      ]);
    });

    test('empty segments never reach the engine', () async {
      final engine = SilentSpeechEngine(voices: dutchVoices);
      final speech = SpeechController(engine: engine);
      await speech.speakSegments('k', const [
        SpeechSegment('   '),
        SpeechSegment('', languageTag: 'nl-NL'),
      ]);
      expect(engine.spokenSegments, isEmpty);
    });

    test('an untranslated entry offers no explanation segment', () {
      expect(_entry.spokenExplanationWith(SpeechTemplates.english), isEmpty);
      expect(
        localized.spokenExplanationWith(SpeechTemplates.english),
        contains('bitterheid'),
      );
    });

    test('the reading covers the whole page, not half of it', () {
      // The English lemma and how to say it open the reading; everything
      // else follows in the reader's language.
      expect(localized.spokenWord, contains('Edulcorate'));

      final dutch = localized.spokenExplanationWith(SpeechTemplates.english);
      // What kind of word it is, where it came from, what it is built of,
      // what it means, and the sentence - the card at the top of the page
      // used to be left out entirely.
      expect(dutch, contains('werkwoord'));
      expect(dutch, contains('Latijn'));
      expect(dutch, contains('edulcorare'));
      expect(dutch, contains('dulcis'));
      expect(dutch, contains('zoet'));
      expect(dutch, contains('bitterheid'));
      expect(dutch, contains('Zoeten'));
      expect(dutch, contains('The editor edulcorated the review.'));
      // The gloss belongs to the page too. It keeps the English lemma
      // inside a Dutch sentence, which the splitter hands back to the
      // English voice rather than dropping the sentence.
      expect(dutch, contains('redacteur'));
    });

    test('the English reading is the same page, whole', () {
      // The reading carries <sub> tags now, because the engine cannot say
      // these words — see kSpokenForms. This test is about the copy, not the
      // speaking, so it reads the page as written.
      final english = ssmlWithoutTags(localized.spokenEntry);
      expect(english, contains('Edulcorate'));
      expect(english, contains('verb'));
      expect(english, contains('From Latin, edulcorare.'));
      expect(english, contains('dulcis'));
      expect(english, contains('To take the bitterness out.'));
      expect(english, contains('To sweeten or purify.'));
      // The word inside the sentence is handed over as its sound.
      expect(english, contains('The editor edulcorated the review.'));
      // Still not a word of Dutch in it.
      expect(english, isNot(contains('bitterheid')));
      expect(english, isNot(contains('Latijn')));
    });
  });
}

/// The same rule the splitter uses: a term counts only when it is not part
/// of a longer word.
///
/// Kept in a map because the sweep below asks for the same few thousand
/// terms over and over, and compiling each one again is what makes it slow.
final _boundaries = <String, RegExp>{};

RegExp _standingAlone(String term) => _boundaries.putIfAbsent(
      term,
      () => RegExp(
        r'(?<![\p{L}\p{N}])' + RegExp.escape(term) + r'(?![\p{L}\p{N}])',
        unicode: true,
        caseSensitive: false,
      ),
    );

final _quotationMark = RegExp(r'["“”„«»‹›]');

/// A hyphen is allowed: '-idus' is a suffix, and it is English.
final _opensOnPunctuation = RegExp(r'^[\s.,;:!?…]');
