import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/models/respelling.dart';
import 'package:beautiful_words/models/ssml.dart';
import 'package:beautiful_words/models/word_entry.dart';

/// The respelling is the one piece of the app written for the eye and then
/// handed straight to a voice, and the two want different things from it.
///
/// The eye wants the stress marked, which the 134 respellings do in capitals.
/// A text-to-speech engine reads a short run of capitals as an initialism, so
/// `HEB-ih-tood` came out spelled — "aitch ee bee", then "tood" — and every
/// word whose stress falls on a single short syllable had the same fault.
///
/// Lower case fixed that and left a second fault behind it: a syllable is not
/// a word, and an engine handed a fragment it does not know guesses, often at
/// the letter names. `heb ih tood` was still being read "heb eye-aitch tood".
///
/// Which fragments those are cannot be reasoned out — `par` is spelled where
/// `tuh` is not — so `tool/probe_respellings.ps1` measures it against a real
/// engine and writes `tool/respelling_probe.json`. This file is what holds the
/// app to that measurement.
void main() {
  final words = _readWords('assets/data/words.json');
  final probe = _readProbe('tool/respelling_probe.json');
  final said = {...probe['said']!};
  final spelled = {...probe['spelled']!};

  List<String> syllablesOf(String respelling) =>
      respelling.split(RegExp(r'[-\s]+')).where((s) => s.isNotEmpty).toList();

  test('a shouted syllable is sounded out, not spelled', () {
    expect(spokenRespelling('PYOO-tuh-tiv'), 'pyoo tuh tiv');
    expect(spokenRespelling('sir-kum-in-sesh-un'), 'sir kum in sesh un');
  });

  test('a syllable the engine spells is given one it says', () {
    expect(spokenRespelling('HEB-ih-tood'), 'heb ihh tood');
    // `parr` is the /a/ of bat with an r; `par` would be the /ar/ of bar.
    expect(spokenRespelling('PARR-uk-siz-um'), 'parre uck siz um');
    expect(spokenRespelling('PAR-sih-moh-nee'), 'parr sih moh nee');
    expect(spokenRespelling('ee-DUL-kuh-rate'), 'e dul kuh rate');
    expect(spokenRespelling('thee-OD-ih-see'), 'thee odd ihh see');
    expect(spokenRespelling('SY-uh-list'), 'sigh uh list');
    expect(spokenRespelling('vy-too-per-AY-shun'), 'vye too per ay shun');
    expect(spokenRespelling('py-uh-TISS-tik'), 'pie uh tiss tik');
  });

  test('the two-word respellings keep their two words', () {
    expect(spokenRespelling('LEE-side'), 'lee side');
    expect(spokenRespelling('PLUM line'), 'plum line');
  });

  test('nothing a voice would spell is left in any of the 134', () {
    final shouting = <String>[];
    for (final word in words) {
      final spoken = spokenRespelling(word['pronunciation'] as String);
      if (_capitals.hasMatch(spoken)) {
        shouting.add('${word['word']}: $spoken');
      }
    }
    expect(shouting, isEmpty, reason: 'capitals a voice would spell out');
  });

  test('no separator a voice would read as a pause or a word', () {
    for (final word in words) {
      final spoken = spokenRespelling(word['pronunciation'] as String);
      expect(spoken, isNot(contains('-')), reason: '${word['word']}');
      expect(spoken, isNot(contains('  ')), reason: '${word['word']}');
      expect(spoken.trim(), spoken, reason: '${word['word']}');
    }
  });

  test('every syllable in the lexicon has been put to an engine', () {
    final unprobed = <String>{};
    for (final word in words) {
      for (final syllable in syllablesOf(word['pronunciation'] as String)) {
        final lower = syllable.toLowerCase();
        if (!said.contains(lower) && !spelled.contains(lower)) {
          unprobed.add('${word['word']}: $lower');
        }
      }
    }
    expect(
      unprobed,
      isEmpty,
      reason: 'add it to tool/respelling_tokens.txt and run '
          'tool/probe_respellings.ps1 — an unprobed syllable is one nobody has '
          'asked an engine about',
    );
  });

  /// The one kind of spelled syllable that may reach the voice: one whose
  /// letters, read out as letters, **are** the sound it was written for.
  ///
  /// The name of the letter E is /iː/, so an engine that spells a lone `e`
  /// and an engine that says it arrive at the same sound. Every other entry
  /// in `_spokenSyllables` is a spelling some measured engine happens to say,
  /// and carries the risk that the next engine does not; this one cannot go
  /// wrong, because naming a letter is the one thing every engine agrees on.
  ///
  /// The probe has no useful verdict to give about it either way, and the
  /// exemption is here for that rather than for a verdict it gave. Its test
  /// is whether a token reads the same as its own letters spaced apart, and
  /// for a one-letter token those are the same string — so the answer is
  /// whichever way the phoneme events happen to land. It came back `said` on
  /// the run that added it and `SPELLED` on the run before. What is stable,
  /// and what settled the choice, is the phoneme count in the carrier:
  /// `e` is one beat of /iː/ where `ee` is two.
  ///
  /// This used to be `heardOnDevice = {'ee'}`, an exemption for a syllable
  /// the probe called spelled and the app sent anyway on the theory that the
  /// letter E was near enough. It was not: `ee` is two letters, so it is two
  /// names, and *Edulcorate* opened "E-E-dul-kuh-rate" on a reader's phone.
  const spelledIsTheSound = <String>{'e'};

  test('nothing the engine spells reaches the voice', () {
    final left = <String>[];
    for (final word in words) {
      for (final syllable in spokenRespelling(
        word['pronunciation'] as String,
      ).split(' ')) {
        if (spelled.contains(syllable) &&
            !spelledIsTheSound.contains(syllable)) {
          left.add('${word['word']}: $syllable');
        }
      }
    }
    expect(
      left,
      isEmpty,
      reason: 'give it a spelling in _spokenSyllables in respelling.dart',
    );
  });

  // The gap that let `ee` sit unnoticed: the sweep above asks whether a
  // spoken syllable is in the probe's *spelled* list, so a replacement the
  // probe has never been shown at all answers "no" and passes. A replacement
  // is exactly the string that reaches a reader's ear, so it is the one that
  // most needs to have been asked about.
  test('every syllable the voice is handed has been put to an engine', () {
    final unprobed = <String>{};
    for (final word in words) {
      for (final syllable in spokenRespelling(
        word['pronunciation'] as String,
      ).split(' ')) {
        if (!said.contains(syllable) && !spelled.contains(syllable)) {
          unprobed.add('${word['word']}: $syllable');
        }
      }
    }
    expect(
      unprobed,
      isEmpty,
      reason: 'add it to tool/respelling_tokens.txt and re-run '
          'tool/probe_respellings.ps1 — a replacement nobody has measured is '
          'a guess about an engine',
    );
  });

  // The bug itself, in one line: a doubled vowel is one sound to the eye and
  // two letter names to an engine.
  test('a bare ee is handed over as one letter, not two', () {
    expect(spokenSyllable('ee'), 'e');
    expect(spokenRespelling('ee-DUL-kuh-rate'), 'e dul kuh rate');
    expect(spokenRespelling('ee-men-DAY-shun'), 'e men day shun');
    expect(spokenRespelling('PARR-ee'), 'parre e');
    // And a syllable that merely contains the pair is left alone: `thee`,
    // `see`, `lee` are words, and the table is for fragments that are not.
    expect(spokenSyllable('thee'), 'thee');
    expect(spokenSyllable('see'), 'see');
  });

  test('every syllable survives — one syllable in, one syllable out', () {
    for (final word in words) {
      final written = syllablesOf(word['pronunciation'] as String);
      final spoken = spokenRespelling(
        word['pronunciation'] as String,
      ).split(' ');
      expect(
        spoken.length,
        written.length,
        reason: '${word['word']} lost or gained a syllable',
      );
      for (var i = 0; i < written.length; i++) {
        expect(
          spoken[i],
          spokenSyllable(written[i].toLowerCase()),
          reason: '${word['word']} changed in a way the table does not account '
              'for',
        );
      }
    }
  });

  test('the page keeps the capitals; only the voice loses them', () {
    final entry = WordEntry.fromJson(
      words.firstWhere((word) => word['word'] == 'Hebetude'),
    );
    expect(entry.pronunciation, 'HEB-ih-tood');
    // The syllables themselves never change shape; only the way they are
    // joined for the voice does, which is [kRespellingVoicing]'s business.
    expect(entry.spokenPronunciation, 'heb ihh tood');

    switch (kRespellingVoicing) {
      case RespellingVoicing.twice:
      case RespellingVoicing.wordOnly:
        // These two do not say the respelling at all.
        expect(entry.spokenWord, isNot(contains('ihh')));
        expect(entry.spokenWord, contains('ˈhɛbɪtuːd'));
      case RespellingVoicing.respellingOnly:
        // ...and this one says nothing but.
        expect(entry.spokenWord, 'heb ihh tood.');
      case RespellingVoicing.sub:
      case RespellingVoicing.probe:
        // The word is shown and the respelling is spoken, so both are in the
        // utterance and the respelling is inside the alias.
        expect(entry.spokenWord, contains(ssmlPhoneme('ˈhɛbɪtuːd', 'heb ihh tood')));
      case RespellingVoicing.spaced:
      case RespellingVoicing.commas:
      case RespellingVoicing.sentences:
        final voiced = switch (kRespellingVoicing) {
          RespellingVoicing.commas => 'heb, ihh, tood',
          RespellingVoicing.sentences => 'heb. ihh. tood',
          _ => 'heb ihh tood',
        };
        expect(entry.spokenWord, 'Hebetude. $voiced.');
        expect(entry.spokenEntry, contains(voiced));
        expect(entry.spokenGlance, contains(voiced));
        expect(entry.spokenPrompt, contains(voiced));
    }
  });
}

final RegExp _capitals = RegExp('[A-Z]{2,}');

List<Map<String, dynamic>> _readWords(String path) {
  final json = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return [
    for (final word in json['words'] as List) word as Map<String, dynamic>,
  ];
}

Map<String, List<String>> _readProbe(String path) {
  final text = File(path).readAsStringSync().replaceFirst('\uFEFF', '');
  final json = jsonDecode(text) as Map<String, dynamic>;
  return {
    'said': [for (final t in json['said'] as List) t as String],
    'spelled': [for (final t in json['spelled'] as List) t as String],
  };
}
