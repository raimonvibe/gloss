import 'dart:math';

import '../models/word_entry.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.word,
    required this.options,
    required this.englishOptions,
    required this.correctIndex,
  });

  final WordEntry word;

  /// The four definitions as the page shows them — the reader's language
  /// wherever the lexicon has been overlaid.
  final List<String> options;

  /// The same four, in English, in the same order.
  ///
  /// The reading needs both. With the translation switch off the whole
  /// question is spoken in English, and handing the English voice a Dutch
  /// definition is the bug the two-voice split exists to prevent.
  final List<String> englishOptions;

  final int correctIndex;

  bool isCorrect(int index) => index == correctIndex;

  /// The choices lettered the way the page letters them, so a listener can
  /// follow the screen rather than counting.
  String get spokenOptions => _lettered(options);

  String get spokenOptionsEnglish => _lettered(englishOptions);

  static String _lettered(List<String> choices) => [
        for (var i = 0; i < choices.length; i++)
          '${String.fromCharCode(65 + i)}. ${choices[i]}',
      ].join(' ');
}

class QuizEngine {
  QuizEngine({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<QuizQuestion> build({
    required List<WordEntry> words,
    int count = 10,
    List<WordEntry>? distractors,
  }) {
    if (words.isEmpty) {
      throw ArgumentError('Need at least 1 word to build a quiz.');
    }
    final distractorPool = distractors ?? words;
    final uniqueDefinitions = distractorPool.map((w) => w.definition).toSet();
    if (uniqueDefinitions.length < 4) {
      throw ArgumentError('Need at least 4 unique definitions to build a quiz.');
    }
    final pool = [...words]..shuffle(_random);
    final take = min(count, pool.length);
    return [
      for (var i = 0; i < take; i++)
        _questionFor(pool[i], distractorPool: distractorPool),
    ];
  }

  QuizQuestion _questionFor(
    WordEntry target, {
    required List<WordEntry> distractorPool,
  }) {
    final chosen = <WordEntry>[
      target,
      ..._distractorsFor(target, distractorPool),
    ]..shuffle(_random);
    return QuizQuestion(
      word: target,
      options: [for (final word in chosen) word.definition],
      englishOptions: [for (final word in chosen) word.english.definition],
      correctIndex: chosen.indexWhere((word) => word.id == target.id),
    );
  }

  /// Three wrong answers, drawn as near the right one as the lexicon allows.
  ///
  /// Taken at random from the whole lexicon, a wrong answer was rarely in the
  /// same country as the right one: *Hebetude* was asked against moralizing,
  /// wisdom and air pressure, and the root meanings printed above the
  /// question — "dull, blunt" — picked the answer out of that field on their
  /// own. A word that shares a theme, or failing that an origin, gives the
  /// reader four answers that could each have been true, so the question is
  /// about the word rather than about which option is in the right area.
  ///
  /// Carried as entries rather than as definitions: the reading needs each
  /// option's English twin, and a definition on its own cannot be traced back
  /// to the word it belongs to.
  List<WordEntry> _distractorsFor(WordEntry target, List<WordEntry> pool) {
    final seen = <String>{target.definition};
    final themed = <WordEntry>[];
    final kin = <WordEntry>[];
    final rest = <WordEntry>[];
    for (final word in pool) {
      if (word.id == target.id) continue;
      // A definition twice in one question would make two options right.
      if (!seen.add(word.definition)) continue;
      if (word.tags.any(target.tags.contains)) {
        themed.add(word);
      } else if (word.origin == target.origin) {
        kin.add(word);
      } else {
        rest.add(word);
      }
    }
    // Shuffled inside each band, so a word does not meet the same three
    // wrong answers every time it comes up.
    for (final band in [themed, kin, rest]) {
      band.shuffle(_random);
    }
    return [...themed, ...kin, ...rest].take(3).toList();
  }
}
