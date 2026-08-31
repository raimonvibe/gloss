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
    // Carried as entries rather than as definitions: the reading needs each
    // option's English twin, and a definition on its own cannot be traced
    // back to the word it belongs to.
    final seen = <String>{target.definition};
    final distractors = <WordEntry>[];
    for (final word in distractorPool) {
      if (word.id == target.id) continue;
      if (seen.add(word.definition)) distractors.add(word);
    }
    distractors.shuffle(_random);
    final chosen = <WordEntry>[target, ...distractors.take(3)]
      ..shuffle(_random);
    return QuizQuestion(
      word: target,
      options: [for (final word in chosen) word.definition],
      englishOptions: [for (final word in chosen) word.english.definition],
      correctIndex: chosen.indexWhere((word) => word.id == target.id),
    );
  }
}
