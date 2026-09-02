import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/models/ssml.dart';
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

  test('markup the app wrote survives the escaping, and data never becomes '
      'markup', () {
    // The alias reaches the parser as a tag; the ampersand and the angle
    // brackets the data carries reach it as characters.
    expect(
      wrapEnglishSsml('${ssmlSub('pie uh tiss tik', 'Pietistic')}. A & <b>.'),
      '<speak xml:lang="en-US">'
      '<sub alias="pie uh tiss tik">Pietistic</sub>. A &amp; &lt;b&gt;.'
      '</speak>',
    );
  });

  test('an engine that is not handed SSML is given the alias, not sentinels',
      () {
    // iOS, desktop and every non-Google Android engine take plain text. A
    // sentinel reaching one of those would be a control character inside a
    // word, which is worse than the bug the tag was written to fix.
    expect(
      ssmlToPlainText('${ssmlSub('pie uh tiss tik', 'Pietistic')}. adjective.'),
      'pie uh tiss tik. adjective.',
    );
    expect(ssmlToPlainText('nothing to undo'), 'nothing to undo');
    for (final sentinel in [kSsmlOpen, kSsmlClose, kSsmlQuote]) {
      expect(ssmlToPlainText('a${sentinel}b'), 'ab');
    }
  });

  test('treats Android LANG_AVAILABLE zero as available', () {
    expect(ttsLanguageLooksAvailable(0), isTrue);
    expect(ttsLanguageLooksAvailable(1), isTrue);
    expect(ttsLanguageLooksAvailable(true), isTrue);
    expect(ttsLanguageLooksAvailable(false), isFalse);
    expect(ttsLanguageLooksAvailable(-2), isFalse);
  });
}
