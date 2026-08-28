import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/speech_templates.dart';
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
  pronunciation: 'ee-DUL-cor-ate',
  definition: 'To sweeten or purify.',
  friendly: 'To take the bitterness out.',
  example: 'The editor edulcorated the review.',
  tags: ['speech'],
  origin: 'Latin',
  originWord: 'edulcorare',
  roots: [WordRoot(form: 'dulcis', meaning: 'sweet')],
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
}

/// The opt-in second half: the explanation may follow the reader's language,
/// but only through a voice that actually speaks it.
void _splitNarration() {
  group('split narration', () {
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

    test('the translated segment is dropped, not mispronounced, with no voice',
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
      final localized = _entry.withOverlay(_dutch);
      expect(
        localized.spokenExplanationWith(SpeechTemplates.english),
        contains('bitterheid'),
      );
    });
  });
}
