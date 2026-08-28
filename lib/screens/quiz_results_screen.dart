import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/quiz_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/ornament.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/speak_button.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    final brand = context.brand;
    final score = quiz.score;
    final total = quiz.length;

    return StopSpeechOnExit(
      child: PaperBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Results'),
          actions: [
            SpeakButton(
              speechKey: 'results',
              text: score == 1
                  ? 'One definition right, of $total.'
                  : '$score definitions right, of $total.',
            ),
            const SizedBox(width: 8),
          ],
        ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          ScriptCaption(score == total ? 'a perfect page' : 'well marked'),
          const SizedBox(height: 8),
          GradientText(
            '$score / $total',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          ProgressTracker(
            current: score,
            total: total,
            label: score == 1 ? '1 definition right' : '$score definitions right',
          ),
          const DividerFlourish(),
          for (var i = 0; i < quiz.questions.length; i++) ...[
            _ResultRow(
              index: i,
              correct: quiz.questions[i].isCorrect(quiz.answerFor(i) ?? -1),
              word: quiz.questions[i].word.word,
              definition: quiz.questions[i].word.definition,
              speechKey: 'result:${quiz.questions[i].word.id}',
              speechText: quiz.questions[i].word.spokenGlance,
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              context.read<SpeechController>().stop();
              context.read<QuizController>().reset();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: brand.accentGold,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Try another round'),
          ),
        ],
      ),
      ),
    ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.index,
    required this.correct,
    required this.word,
    required this.definition,
    required this.speechKey,
    required this.speechText,
  });

  final int index;
  final bool correct;
  final String word;
  final String definition;
  final String speechKey;
  final String speechText;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final color = correct ? brand.correct : brand.incorrect;
    return CardSurface(
      padding: const EdgeInsets.all(14),
      borderColor: color.withValues(alpha: 0.55),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct ? Icons.check_circle_outline : Icons.highlight_off,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. $word',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  definition,
                  style: TextStyle(color: brand.foregroundMuted, height: 1.35),
                ),
              ],
            ),
          ),
          SpeakButton(
            compact: true,
            speechKey: speechKey,
            text: speechText,
          ),
        ],
      ),
    );
  }
}
