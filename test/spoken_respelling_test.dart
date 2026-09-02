import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/models/respelling.dart';
import 'package:beautiful_words/models/word_entry.dart';

/// The respelling is the one piece of the app written for the eye and then
/// handed straight to a voice, and the two want different things from it.
///
/// The eye wants the stress marked, which the 134 respellings do in capitals.
/// A text-to-speech engine reads a short run of capitals as an initialism, so
/// `HEB-ih-tood` came out spelled — "aitch ee bee", then "tood" — and every
/// word whose stress falls on a single short syllable had the same fault.
void main() {
  final words = _readWords('assets/data/words.json');

  test('a shouted syllable is sounded out, not spelled', () {
    expect(spokenRespelling('HEB-ih-tood'), 'heb ih tood');
    expect(spokenRespelling('PYOO-tuh-tiv'), 'pyoo tuh tiv');
    expect(spokenRespelling('ee-DUL-cor-ate'), 'ee dul cor ate');
  });

  test('a respelling that never shouted is left alone', () {
    expect(spokenRespelling('sir-kum-in-sesh-un'), 'sir kum in sesh un');
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

  test('every syllable survives — the change is case and spacing only', () {
    for (final word in words) {
      final written = word['pronunciation'] as String;
      final spoken = spokenRespelling(written);
      expect(
        spoken.replaceAll(' ', ''),
        written.toLowerCase().replaceAll(RegExp(r'[-\s]'), ''),
        reason: '${word['word']} lost or gained a letter',
      );
    }
  });

  test('the page keeps the capitals; only the voice loses them', () {
    final entry = WordEntry.fromJson(
      words.firstWhere((word) => word['word'] == 'Hebetude'),
    );
    expect(entry.pronunciation, 'HEB-ih-tood');
    expect(entry.spokenPronunciation, 'heb ih tood');
    expect(entry.spokenWord, 'Hebetude. heb ih tood.');
    expect(entry.spokenEntry, contains('heb ih tood'));
    expect(entry.spokenGlance, contains('heb ih tood'));
    expect(entry.spokenPrompt, contains('heb ih tood'));
  });
}

final RegExp _capitals = RegExp('[A-Z]{2,}');

List<Map<String, dynamic>> _readWords(String path) {
  final json = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return [
    for (final word in json['words'] as List) word as Map<String, dynamic>,
  ];
}
