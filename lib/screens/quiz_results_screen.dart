import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/speech_templates.dart';
import '../state/quiz_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/english_lemma.dart';
import '../widgets/ornament.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/speak_button.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final score = quiz.score;
    final total = quiz.length;

    return StopSpeechOnExit(
      child: PaperBackdrop(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(l10n.results),
            actions: [
              SpeakButton(
                speechKey: 'results',
                text: l10n.definitionsRightSpoken(score, total),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              ScriptCaption(score == total ? l10n.perfectPage : l10n.wellMarked),
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
                label: l10n.definitionsRight(score),
              ),
              const DividerFlourish(),
              for (var i = 0; i < quiz.questions.length; i++) ...[
                _ResultRow(
                  index: i,
                  correct: quiz.questions[i].isCorrect(quiz.answerFor(i) ?? -1),
                  word: quiz.questions[i].word.word,
                  definition: quiz.questions[i].word.definition,
                  speechKey: 'result:${quiz.questions[i].word.id}',
                  speechText: quiz.questions[i].word.spokenGlanceWith(
                    SpeechTemplates.fromL10n(l10n),
                  ),
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
                child: Text(l10n.tryAnotherRound),
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
                EnglishLemma(
                  child: Text(
                    '${index + 1}. $word',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
