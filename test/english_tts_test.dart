import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/state/speech_controller.dart';

void main() {
  test('normalizes Android underscore locales', () {
    expect(normalizeTtsLocale('en_US'), 'en-us');
    expect(isEnglishTtsLocale('en_GB'), isTrue);
    expect(isEnglishTtsLocale('nl-NL'), isFalse);
    expect(isEnglishTtsLocale('nl_NL'), isFalse);
  });

  test('picks English even when the device language is listed first', () {
    expect(
      pickEnglishLanguage(const ['nl-NL', 'de-DE', 'en-US', 'fr-FR']),
      'en-US',
    );
    expect(
      pickEnglishLanguage(const ['nl_NL', 'en_GB']),
      'en_GB',
    );
    expect(pickEnglishLanguage(const ['nl-NL', 'de-DE']), isNull);
  });

  test('prefers a local US English voice over Dutch and network voices', () {
    final voice = pickEnglishVoice([
      {'name': 'Dutch', 'locale': 'nl-NL'},
      {'name': 'en-gb-x-rbc-network', 'locale': 'en-GB'},
      {'name': 'en-us-x-sfg-local', 'locale': 'en-US'},
    ]);
    expect(voice, {
      'name': 'en-us-x-sfg-local',
      'locale': 'en-US',
    });
  });

  test('prefers Google TTS over a Dutch Samsung engine', () {
    expect(
      pickPreferredTtsEngine(const [
        'com.samsung.SMT',
        'com.google.android.tts',
      ]),
      'com.google.android.tts',
    );
    expect(pickPreferredTtsEngine(const ['com.samsung.SMT']), isNull);
  });

  test('wraps utterance as English SSML', () {
    expect(
      wrapEnglishSsml('Edulcorate & "sweet"'),
      '<speak xml:lang="en-US">Edulcorate &amp; &quot;sweet&quot;</speak>',
    );
  });

  test('treats Android LANG_AVAILABLE zero as available', () {
    expect(ttsLanguageLooksAvailable(0), isTrue);
    expect(ttsLanguageLooksAvailable(1), isTrue);
    expect(ttsLanguageLooksAvailable(true), isTrue);
    expect(ttsLanguageLooksAvailable(false), isFalse);
    expect(ttsLanguageLooksAvailable(-2), isFalse);
  });
}
