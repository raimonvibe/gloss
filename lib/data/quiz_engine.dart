import 'dart:math';

import '../models/word_entry.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.word,
    required this.options,
    required this.correctIndex,
  });

  final WordEntry word;
  final List<String> options;
  final int correctIndex;

  bool isCorrect(int index) => index == correctIndex;
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
    final distractors = distractorPool
        .where((w) => w.id != target.id)
        .map((w) => w.definition)
        .toSet()
        .toList()
      ..shuffle(_random);
    final options = <String>[
      target.definition,
      ...distractors.take(3),
    ]..shuffle(_random);
    return QuizQuestion(
      word: target,
      options: options,
      correctIndex: options.indexOf(target.definition),
    );
  }
}
