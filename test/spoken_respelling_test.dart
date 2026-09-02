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
    expect(spokenRespelling('PAR-uk-siz-um'), 'parre uck siz um');
    expect(spokenRespelling('ee-DUL-cor-ate'), 'eeh dul core ate');
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

  test('nothing the engine spells reaches the voice', () {
    final left = <String>[];
    for (final word in words) {
      for (final syllable in spokenRespelling(
        word['pronunciation'] as String,
      ).split(' ')) {
        if (spelled.contains(syllable)) left.add('${word['word']}: $syllable');
      }
    }
    expect(
      left,
      isEmpty,
      reason: 'give it a spelling in _spokenSyllables in respelling.dart',
    );
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
        expect(entry.spokenWord, contains('Hebetude'));
      case RespellingVoicing.respellingOnly:
        // ...and this one says nothing but.
        expect(entry.spokenWord, 'heb ihh tood.');
      case RespellingVoicing.sub:
      case RespellingVoicing.probe:
        // The word is shown and the respelling is spoken, so both are in the
        // utterance and the respelling is inside the alias.
        expect(entry.spokenWord, contains(ssmlSub('heb ihh tood', 'Hebetude')));
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
