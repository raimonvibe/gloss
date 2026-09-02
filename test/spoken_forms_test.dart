import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/models/respelling.dart';
import 'package:beautiful_words/models/spoken_forms.dart';
import 'package:beautiful_words/models/ssml.dart';
import 'package:beautiful_words/models/word_entry.dart';

/// The engine cannot say the words this app is about.
///
/// Gloss is a lexicon of rare English, so Google's Android engine holds almost
/// none of the 134 in its dictionary and invents a reading from the spelling —
/// *pietistic* came out "pi-e-stic" on a device. `<sub alias="...">` fixes
/// that wherever a word is spoken, because the respelling beside it on the
/// page is the pronunciation.
///
/// The headword at the top of a reading was the easy half. The hard half is
/// the sentence underneath it, which shows the word off by using it — often
/// inflected, where the headword's own respelling would say the wrong word.
/// This file holds the whole arrangement together.
void main() {
  final words = _readWords('assets/data/words.json');
  final entries = [for (final word in words) WordEntry.fromJson(word)];

  test('every example sentence can be said', () {
    final mangled = <String>[];
    for (final entry in entries) {
      final voiced = entry.voiced(entry.example);
      if (!voiced.contains(kSsmlOpen)) {
        mangled.add('${entry.word}: ${entry.example}');
      }
    }
    expect(
      mangled,
      isEmpty,
      reason: 'the sentence never names its own word in a form the voice has '
          'a respelling for — add the form to kSpokenForms in '
          'lib/models/spoken_forms.dart',
    );
  });

  test('the headword is voiced wherever it appears, in any case', () {
    final entry = entries.firstWhere((e) => e.word == 'Pietistic');
    expect(
      entry.voiced('A pietistic man. Pietistic, even.'),
      'A ${ssmlSub('pie uh tiss tik', 'pietistic')} man. '
      '${ssmlSub('pie uh tiss tik', 'Pietistic')}, even.',
    );
  });

  test('a longer form wins over the headword inside it', () {
    // 'edulcorated' must not be read as 'edulcorate' followed by a stray 'd'.
    final entry = entries.firstWhere((e) => e.word == 'Edulcorate');
    final voiced = entry.voiced('The editor edulcorated the review.');
    expect(voiced, contains(ssmlSub('eeh dul core ay tidd', 'edulcorated')));
    expect(voiced, isNot(contains('>edulcorate<')));
  });

  test('a word inside another word is left alone', () {
    final entry = entries.firstWhere((e) => e.word == 'Cant');
    // 'cannot' and 'scanty' contain no whole 'cant'; 'Cant.' does.
    expect(entry.voiced('He cannot be scanty.'), 'He cannot be scanty.');
    expect(entry.voiced('Cant.'), contains(kSsmlOpen));
  });

  test('every spoken form is a respelling the substitution table knows', () {
    // The same guard the 134 are held to: a form written here goes through
    // spokenRespelling, so it must not smuggle in a syllable no engine has
    // been asked about.
    final probed = _readProbe('tool/respelling_probe.json');
    final unprobed = <String>{};
    for (final byId in kSpokenForms.entries) {
      for (final form in byId.value.entries) {
        for (final syllable in spokenRespelling(form.value).split(' ')) {
          if (!probed.contains(syllable)) {
            unprobed.add('${byId.key}/${form.key}: $syllable');
          }
        }
      }
    }
    expect(
      unprobed,
      isEmpty,
      reason: 'add it to tool/respelling_tokens.txt and run '
          'tool/probe_respellings.ps1',
    );
  });

  test('every id in the table is a word in the lexicon', () {
    final ids = {for (final entry in entries) entry.id};
    expect(kSpokenForms.keys.where((id) => !ids.contains(id)), isEmpty);
  });

  test('the whole English reading carries no nested markup', () {
    for (final entry in entries) {
      final reading = entry.spokenEntry;
      // Every opened tag is closed before the next one opens.
      var depth = 0;
      for (final unit in reading.split('')) {
        if (unit == kSsmlOpen) depth++;
        if (unit == kSsmlClose) depth--;
        expect(depth, inInclusiveRange(0, 1), reason: '${entry.word}: nested');
      }
      expect(depth, 0, reason: '${entry.word}: unclosed');
    }
  });
}

List<Map<String, dynamic>> _readWords(String path) {
  final json = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return [
    for (final word in json['words'] as List) word as Map<String, dynamic>,
  ];
}

Set<String> _readProbe(String path) {
  final text = File(path).readAsStringSync().replaceFirst('\uFEFF', '');
  final json = jsonDecode(text) as Map<String, dynamic>;
  return {
    for (final token in json['said'] as List) token as String,
    for (final token in json['spelled'] as List) token as String,
  };
}
