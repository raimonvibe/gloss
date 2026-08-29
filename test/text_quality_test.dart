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
}

/// Reduplication that is correct in the language, gone through one by one.
///
/// Most of these are grammar doing its job. Turkish doubles a word for
/// degree ('uzun uzun', at length; 'birer birer', one by one). Swahili
/// doubles for sameness ('lile lile', that very one). Urdu doubles for
/// distribution ('ایک ایک', one by one) and for smallness ('چھوٹی چھوٹی').
/// Lithuanian 'vos vos' and Vietnamese 'phăng phăng' are intensifiers.
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
  'vi/gainsay.friendly',
  'vi/solecism.root0',
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
