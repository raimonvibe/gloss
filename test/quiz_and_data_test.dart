import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/data/quiz_engine.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/state/quiz_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';

const _fixture = '''
{
  "categories": [
    {"id": "speech", "label": "Speech & Rhetoric"},
    {"id": "knowledge", "label": "Knowledge & Thought"}
  ],
  "words": [
    {
      "id": "edulcorate",
      "word": "Edulcorate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-DUL-cor-ate",
      "definition": "To sweeten or purify.",
      "friendly": "To take the bitterness out of something.",
      "example": "The editor edulcorated the review.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "edulcorare",
      "roots": [
        {"form": "dulcis", "meaning": "sweet"}
      ]
    },
    {
      "id": "garrulous",
      "word": "Garrulous",
      "variants": [],
      "partOfSpeech": "adjective",
      "pronunciation": "GAIR-uh-lus",
      "definition": "Excessively talkative.",
      "friendly": "Just won't stop chatting.",
      "example": "The garrulous cab driver talked the whole way.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "garrulus",
      "roots": [
        {"form": "garrire", "meaning": "to chatter"}
      ]
    },
    {
      "id": "mendicant",
      "word": "Mendicant",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "MEN-dih-kunt",
      "definition": "A beggar, or one living on alms.",
      "friendly": "Someone who lives by asking for charity.",
      "example": "The mendicant friars owned nothing.",
      "tags": ["knowledge"],
      "origin": "Latin",
      "originWord": "mendicans",
      "roots": [
        {"form": "mendicare", "meaning": "to beg"}
      ]
    },
    {
      "id": "paroxysm",
      "word": "Paroxysm",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "PAR-uk-siz-um",
      "definition": "A sudden violent outburst.",
      "friendly": "A sudden intense burst of emotion.",
      "example": "A paroxysm of laughter.",
      "tags": ["knowledge"],
      "origin": "Greek",
      "originWord": "paroxysmos",
      "roots": [
        {"form": "oxys", "meaning": "sharp"}
      ]
    }
  ]
}
''';

void main() {
  final repo = WordRepository.fromJsonString(_fixture);

  test('parses lexicon entries with etymology', () {
    expect(repo.words, hasLength(4));
    expect(repo.words.first.word, 'Edulcorate');
    expect(repo.words.first.origin, 'Latin');
    expect(repo.words.first.roots.first.form, 'dulcis');
    expect(repo.labelForTag('speech'), 'Speech & Rhetoric');
  });

  test('smart search matches a description, not only the headword', () {
    final hits = repo.search(query: 'a beggar');
    expect(hits.first.word, 'Mendicant');
  });

  test('word of the day is deterministic for a given date', () {
    final a = repo.wordOfTheDay(DateTime(2026, 8, 28));
    final b = repo.wordOfTheDay(DateTime(2026, 8, 28));
    expect(a.id, b.id);
  });

  test('quiz engine builds four unique options including the answer', () {
    final engine = QuizEngine(random: Random(1));
    final questions = engine.build(words: repo.words, count: 3);
    expect(questions, hasLength(3));
    for (final q in questions) {
      expect(q.options, hasLength(4));
      expect(q.options.toSet(), hasLength(4));
      expect(q.options[q.correctIndex], q.word.definition);
    }
  });

  test('quiz controller records answers and navigates between questions', () {
    final quiz = QuizController(engine: QuizEngine(random: Random(2)));
    quiz.start(repo.words, count: 3);
    expect(quiz.isActive, isTrue);
    expect(quiz.canGoBack, isFalse);
    expect(quiz.canGoForward, isFalse);

    final first = quiz.current!;
    quiz.select(first.correctIndex);
    expect(quiz.hasAnsweredCurrent, isTrue);
    expect(quiz.score, 1);

    quiz.next();
    expect(quiz.index, 1);
    expect(quiz.canGoBack, isTrue);
    quiz.previous();
    expect(quiz.index, 0);
    expect(quiz.selectedIndex, first.correctIndex);
  });

  test('WordEntry searchable includes origin and roots', () {
    final entry = repo.words.first;
    expect(entry.searchable, contains('dulcis'));
    expect(entry.searchable, contains('latin'));
  });

  test('filters words by theme category', () {
    expect(repo.wordsForCategory('speech').map((w) => w.id), [
      'edulcorate',
      'garrulous',
    ]);
    expect(repo.wordsForCategory('knowledge'), hasLength(2));
    expect(repo.wordsForCategory('missing'), isEmpty);
  });

  test('themed quiz can use a small pool with shared distractors', () {
    final engine = QuizEngine(random: Random(3));
    final themed = repo.wordsForCategory('speech');
    expect(themed, hasLength(2));
    final questions = engine.build(
      words: themed,
      count: 10,
      distractors: repo.words,
    );
    expect(questions, hasLength(2));
    for (final q in questions) {
      expect(q.options, hasLength(4));
      expect(q.options[q.correctIndex], q.word.definition);
    }
  });

  test('quiz engine rejects an empty word list', () {
    expect(
      () => QuizEngine(random: Random(1)).build(words: const []),
      throwsArgumentError,
    );
  });

  test('spoken prompts name the word and hide the definition', () {
    final entry = repo.words.first;
    expect(entry.spokenPronunciation, 'ee DUL cor ate');
    expect(entry.spokenPrompt, contains('Edulcorate'));
    expect(entry.spokenPrompt, contains('dulcis'));
    expect(entry.spokenPrompt, isNot(contains(entry.definition)));
    expect(entry.spokenQuiz(revealed: true), contains('bitterness'));
  });

  test('speech controller replaces the current utterance', () async {
    final engine = SilentSpeechEngine();
    final speech = SpeechController(engine: engine);
    await speech.speak('a', 'one');
    expect(engine.lastSpoken, 'one');
    await speech.speak('b', 'two');
    expect(engine.lastSpoken, 'two');
    expect(speech.activeKey, 'b');
    await speech.toggle('b', 'two');
    expect(speech.isSpeaking, isFalse);
    speech.dispose();
  });
}
