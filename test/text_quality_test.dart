import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The mechanical half of proofreading, over every language Gloss ships.
///
/// These checks say nothing about grammar — no tool can, for sixty
/// languages. What they do guarantee is form: that a quotation closes, that
/// a bracket has a partner, that no escape or stray space survived the
/// generation step. That is where the real damage has come from twice now:
/// twenty examples showing a literal backslash, and twenty-three
/// explanations cut off where their quotation began.
///
/// Each check is calibrated against the sixty languages rather than against
/// English habits, because most of the obvious rules are wrong somewhere:
///
///  * French puts a space before ':' ';' '!' and '?', so only a space
///    before a full stop or a comma counts as a fault.
///  * Languages close a quotation with different characters — „…" in
///    German, „…" in Bulgarian, «…» in French — so the whole double-quote
///    family is counted together and only an odd total is a fault.
///  * Turkish 'uzun uzun', Swahili 'lile lile' and Urdu 'ایک ایک' are
///    ordinary reduplication, so a repeated word is only a fault when it is
///    not one of the twenty-three known good ones below.
void main() {
  final english = _readWords('assets/data/words.json');
  final overlays = _readOverlays();

  test('every language ships, and every entry with it', () {
    expect(english, hasLength(134));
    expect(overlays, hasLength(60));
    final missing = <String>[];
    overlays.forEach((locale, words) {
      for (final id in english.keys) {
        if (!words.containsKey(id)) missing.add('$locale/$id');
      }
    });
    expect(missing, isEmpty, reason: 'entries missing from an overlay');
  });

  test('a root always keeps its meaning', () {
    final wrong = <String>[];
    overlays.forEach((locale, words) {
      words.forEach((id, word) {
        final meanings = word['rootMeanings'];
        final roots = (english[id]?['roots'] as List?)?.length;
        if (meanings is List && roots != null && meanings.length != roots) {
          wrong.add('$locale/$id: ${meanings.length} for $roots roots');
        }
      });
    });
    expect(wrong, isEmpty, reason: 'root meanings do not line up');
  });

  test('nothing survived generation that should not have', () {
    final faults = <String>[];
    _eachField(english, overlays, (where, text) {
      if (text.contains(r'\')) faults.add('$where: a stray escape');
      if (text != text.trim()) faults.add('$where: space at the edges');
      if (text.contains('  ')) faults.add('$where: a double space');
      if (text.contains('\n') || text.contains('\t')) {
        faults.add('$where: a line break');
      }
    });
    expect(faults, isEmpty);
  });

  test('a quotation closes, and so does a bracket', () {
    final faults = <String>[];
    _eachField(english, overlays, (where, text) {
      final quotes = _quotationMarks.allMatches(text).length;
      if (quotes.isOdd) faults.add('$where: a quotation never closes');
      if ('('.allMatches(text).length != ')'.allMatches(text).length) {
        faults.add('$where: a bracket has no partner');
      }
    });
    expect(faults, isEmpty);
  });

  test('punctuation sits where the language puts it', () {
    final faults = <String>[];
    _eachField(english, overlays, (where, text) {
      // Never right in any of the sixty. A space before ':' or '?' is
      // deliberately not checked: that is correct French.
      if (RegExp(r'\s[.,]').hasMatch(text)) {
        faults.add('$where: a space before a full stop or comma');
      }
      if (RegExp(r'([.,;:])\1').hasMatch(text)) {
        faults.add('$where: doubled punctuation');
      }
    });
    expect(faults, isEmpty);
  });

  test('no word is typed twice by accident', () {
    final faults = <String>[];
    _eachField(english, overlays, (where, text) {
      if (_knownReduplication.contains(where)) return;
      final twice = _repeatedWord.firstMatch(text);
      if (twice != null) faults.add('$where: "${twice.group(0)}"');
    });
    expect(
      faults,
      isEmpty,
      reason: 'if the repetition is deliberate, add it to '
          '_knownReduplication with a note on what it means',
    );
  });

  // ---- the seven quotations that cannot be translated -------------------
  //
  // Fourteen of the 134 put a phrase in quotation marks, and they are not all
  // the same kind of thing. Seven of them *are* the specimen: the ambiguity
  // of "Visiting relatives can be tiring", the redundancy of "It is what it
  // is", the bad grammar of "Between you and I" exist in English and nowhere
  // else, so a translation of the quotation shows the reader nothing at all.
  // The other seven quote reported speech — "excellent taste", "unforeseen
  // challenges" — which carries no such weight and which about half the
  // locales have already translated.
  //
  // Nobody wrote that rule down and all sixty translations found it anyway:
  // the seven below stand in 58, 59 or 60 locales out of 60, where the
  // reported speech runs 16 to 44. `python tool/gloss_english.py` prints the
  // whole table.
  //
  // This is here because the obvious next piece of work is a pass that
  // renders the English headword in each gloss into the reader's language,
  // and a pass like that would take these seven with it by accident. They are
  // the one place in the app where English text inside a translated sentence
  // is the content rather than a gap in it.
  group('a quotation that is the specimen stays in English', () {
    const specimens = <String, String>{
      'amphiboly': 'Visiting relatives can be tiring',
      'euphonious': 'Murmuring brook',
      'tautology': 'It is what it is',
      'solecism': 'Between you and I',
      'laconism': 'Molon labe',
      'metonymy': 'Wall Street had a rough day',
      'specious': "Everyone's doing it",
    };

    // Two have lost one, and they are named rather than waved through, so the
    // count can only go down from here.
    //
    // `nb/metonymy` used to be in this set and is not a loss at all: the row
    // read "Wall Street hat a rough day", one letter off, and Danish has it
    // right — so it was a typo that had been recorded as a translation
    // decision. Repaired 2026-09-03 while rewriting nb. **An entry here is
    // worth reading before it is trusted**: this one had been sitting as
    // evidence of a rule the locale never actually broke.
    //
    // The two that remain are real. Lao and Burmese render the quotation in
    // their own scripts, which empties it out — but both are `_data_` locales
    // that `tool/localize_gloss.py` refuses, so repairing them means editing
    // `tool/_data_lo.py` and `_data_my.py` and re-emitting.
    const alreadyGone = <String>{
      'lo/specious',
      'my/specious',
    };

    test('all sixty keep it, and the exceptions are the known ones', () {
      final lost = <String>[];
      overlays.forEach((locale, words) {
        specimens.forEach((id, phrase) {
          final gloss = words[id]?['exampleGloss'] as String?;
          if (gloss == null) return;
          if (!gloss.toLowerCase().contains(phrase.toLowerCase())) {
            lost.add('$locale/$id');
          }
        });
      });
      expect(
        lost.toSet(),
        alreadyGone,
        reason: 'a quotation that is the thing being examined was translated '
            'away, or one came back — see tool/gloss_english.py',
      );
    });
  });

  // ---- the English an explanation names, as English ---------------------
  //
  // The same line runs through the other fields, and it was drawn there by
  // sixty translators without being written down either. An explanation can
  // *use* the English headword, which is the bug a reader reported on
  // 2026-09-03 — "aan een ineluctable uitkomst wring je je niet los", with
  // the one word the sentence exists to explain left unreadable. Or it can
  // *mention* it, naming an English word as English, and then the English is
  // the content:
  //
  //   dint         survives in the phrase "by dint of" and almost nowhere
  //                else, which is what its definition and its plain-words
  //                line both say
  //   ingenuous    is the word its explanation tells apart from "ingenious"
  //   fricaseed    is the misspelling its definition corrects to
  //                "fricasseed"
  //
  // A pass that renders the headword into the reader's language — the one
  // `tool/localize_gloss.py` runs, now over `friendly` and `definition` too —
  // would carry these off by accident, and the sentence would then say
  // nothing at all. `python tool/english_in_translation.py` tells the two
  // apart across all six translated fields and prints what is left.
  group('an English word a translation names must stay English', () {
    const mentions = <String, String>{
      'dint.definition': 'dint',
      'dint.friendly': 'dint',
      'ingenuous.friendly': 'ingenious',
      'fricaseed.definition': 'fricasseed',
    };

    // Serbian used to transliterate it into Cyrillic — "ингениоус" — which
    // gives a reader the sound and takes away the spelling, and the spelling
    // is the whole point of a word you are being told to tell apart. That was
    // one symptom of a locale that had been transliterated from Croatian
    // rather than written: 23 example sentences carried the headword the same
    // way. Serbian was rewritten on 2026-09-03 and this set is empty, which is
    // the state to hold it in — an exemption here is a reader losing a word.
    const alreadyGone = <String>{};

    test('all sixty keep it, and the exceptions are the known ones', () {
      final lost = <String>[];
      overlays.forEach((locale, words) {
        mentions.forEach((where, english) {
          final parts = where.split('.');
          final text = words[parts[0]]?[parts[1]] as String?;
          if (text == null) return;
          if (!text.toLowerCase().contains(english.toLowerCase())) {
            lost.add('$locale/$where');
          }
        });
      });
      expect(
        lost.toSet(),
        alreadyGone,
        reason: 'an English word the explanation exists to name was '
            'translated away — see tool/english_in_translation.py',
      );
    });
  });
}

/// Reduplication that is correct in the language, gone through one by one.
///
/// Most of these are grammar doing its job. Turkish doubles a word for
/// degree ('uzun uzun', at length; 'birer birer', one by one). Swahili
/// doubles for sameness ('lile lile', that very one). Urdu doubles for
/// distribution ('ایک ایک', one by one) and for smallness ('چھوٹی چھوٹی').
/// Lithuanian 'vos vos' and Vietnamese 'phăng phăng' are intensifiers.
///
/// Vietnamese reduplicates far more freely than any of those, and the 2026-09-04
/// rewrite of its 134 sentences duly added three at once: 'đều đều' is a drone
/// (đều, even, doubled into monotony), 'chăm chăm' is fixedly (chăm, to attend),
/// 'thao thao' is on and on. All three are the ordinary form of the word rather
/// than an emphatic option, so expect one per handful of Vietnamese rows.
///
/// Three are two different phrases meeting at a seam, which reads oddly but
/// parses correctly: German 'Interesse, das das Gesunde…' is a relative
/// pronoun before an article; Dutch 'in plaats van van meet af aan' is the
/// preposition of one idiom before the start of another; Vietnamese 'nổi
/// tiếng tiếng Hy Lạp' is 'famous' meeting 'the Greek language'.
///
/// Kazakh 'Әкесінің әкесінің' is a grandfather — his father's father.
/// Estonian 'pere pere vastu' and Urdu 'خاندان خاندان کے خلاف' are both
/// 'family against family', which is what internecine means.
const _knownReduplication = <String>{
  'de/prurience.friendly',
  'et/internecine.friendly',
  'kk/plumb-line.exampleGloss',
  'lt/eluded.friendly',
  'nl/adscititious.friendly',
  'sw/dotage.exampleGloss',
  'sw/eluded.friendly',
  'sw/tautology.definition',
  'sw/tautology.friendly',
  'sw/tautology.root0',
  'tr/expatiate.definition',
  'tr/fain.definition',
  'tr/fain.friendly',
  'tr/fain.root1',
  'tr/incipient.friendly',
  'tr/seriatim.friendly',
  'tr/seriatim.root1',
  'ur/eluded.friendly',
  'ur/garrulous.friendly',
  'ur/internecine.friendly',
  'ur/seriatim.friendly',
  'vi/captious.exampleGloss',
  'vi/expatiate.exampleGloss',
  'vi/gainsay.friendly',
  'vi/solecism.root0',
  'vi/soporific.exampleGloss',
};

final _quotationMarks = RegExp(r'["“”„«»]');

/// The same word twice over.
///
/// Unicode-aware on purpose: Dart's `\w` and `\b` are ASCII, which reads
/// Vietnamese 'viên thu thuế' as 'thu' followed by 'thu', and cannot see a
/// repetition in Cyrillic or Arabic at all.
final _repeatedWord = RegExp(
  r'(?<![\p{L}\p{N}])(\p{L}{3,})\s+\1(?![\p{L}\p{N}])',
  unicode: true,
  caseSensitive: false,
);

Map<String, Map<String, dynamic>> _readWords(String path) {
  final json = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final word in json['words'] as List)
      (word as Map<String, dynamic>)['id'] as String: word,
  };
}

Map<String, Map<String, dynamic>> _readOverlays() {
  final overlays = <String, Map<String, dynamic>>{};
  for (final file in Directory('assets/l10n').listSync().whereType<File>()) {
    final name = file.uri.pathSegments.last;
    if (!name.startsWith('words_') || !name.endsWith('.json')) continue;
    final locale = name.substring('words_'.length, name.length - 5);
    final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    overlays[locale] = (json['words'] ?? json) as Map<String, dynamic>;
  }
  return overlays;
}

/// Every piece of prose the app shows, labelled 'locale/entry.field'.
void _eachField(
  Map<String, Map<String, dynamic>> english,
  Map<String, Map<String, dynamic>> overlays,
  void Function(String where, String text) check,
) {
  void visit(String where, Object? value) {
    if (value is String && value.trim().isNotEmpty) check(where, value);
  }

  english.forEach((id, word) {
    for (final field in ['definition', 'friendly', 'example']) {
      visit('en/$id.$field', word[field]);
    }
  });
  overlays.forEach((locale, words) {
    words.forEach((id, word) {
      for (final field in [
        'definition',
        'friendly',
        'exampleGloss',
        'partOfSpeech',
        'origin',
      ]) {
        visit('$locale/$id.$field', (word as Map<String, dynamic>)[field]);
      }
      final meanings = word['rootMeanings'];
      if (meanings is List) {
        for (var i = 0; i < meanings.length; i++) {
          visit('$locale/$id.root$i', meanings[i]);
        }
      }
    });
  });
}
