import 'package:flutter/foundation.dart';

import '../data/quiz_engine.dart';
import '../models/word_entry.dart';

class QuizController extends ChangeNotifier {
  QuizController({QuizEngine? engine}) : _engine = engine ?? QuizEngine();

  final QuizEngine _engine;
  List<QuizQuestion> _questions = const [];
  final Map<int, int> _answers = {};
  int _index = 0;

  List<QuizQuestion> get questions => _questions;
  int get index => _index;
  int get length => _questions.length;
  bool get isActive => _questions.isNotEmpty;
  bool get isComplete =>
      _questions.isNotEmpty && _answers.length == _questions.length;
  QuizQuestion? get current =>
      _questions.isEmpty ? null : _questions[_index];
  int? get selectedIndex => _answers[_index];
  bool get hasAnsweredCurrent => _answers.containsKey(_index);
  bool get canGoBack => _index > 0;
  bool get canGoForward => hasAnsweredCurrent && _index < _questions.length - 1;
  bool get isLast => _index == _questions.length - 1 && hasAnsweredCurrent;

  int get score => _answers.entries.where((entry) {
        return _questions[entry.key].isCorrect(entry.value);
      }).length;

  void start(
    List<WordEntry> words, {
    int count = 10,
    List<WordEntry>? distractors,
  }) {
    _questions = _engine.build(
      words: words,
      count: count,
      distractors: distractors,
    );
    _answers.clear();
    _index = 0;
    notifyListeners();
  }

  void select(int optionIndex) {
    if (hasAnsweredCurrent) return;
    _answers[_index] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!canGoForward && !isLast) return;
    if (_index < _questions.length - 1) {
      _index += 1;
      notifyListeners();
    }
  }

  void previous() {
    if (!canGoBack) return;
    _index -= 1;
    notifyListeners();
  }

  void reset() {
    _questions = const [];
    _answers.clear();
    _index = 0;
    notifyListeners();
  }

  int? answerFor(int questionIndex) => _answers[questionIndex];
}
