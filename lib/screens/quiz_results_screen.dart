import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/word_entry.dart';
import '../state/quiz_controller.dart';
import '../state/reading.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/button_label.dart';
import '../widgets/card_surface.dart';
import '../widgets/english_lemma.dart';
import '../widgets/favorite_button.dart';
import '../widgets/fit_to_width.dart';
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
                // The score line is the app's own copy, so it is whatever
                // language the reader chose. Handing that to the
                // English-locked voice is what gave it an English accent.
                text: englishCopy.definitionsRightSpoken(score, total),
                segments: spokenLine(
                  context,
                  localized: l10n.definitionsRightSpoken(score, total),
                  english: englishCopy.definitionsRightSpoken(score, total),
                  group: 'results',
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: LayoutBoundary(
            child: Builder(
              builder: (context) => ListView(
                padding: context.layout.pagePadding(top: 8, bottom: 40),
                children: [
                  ScriptCaption(
                    score == total ? l10n.perfectPage : l10n.wellMarked,
                  ),
                  const SizedBox(height: 8),
                  FitToWidth(
                    child: GradientText(
                      '$score / $total',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
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
                      correct:
                          quiz.questions[i].isCorrect(quiz.answerFor(i) ?? -1),
                      entry: quiz.questions[i].word,
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
                    ),
                    child: ButtonLabel(l10n.tryAnotherRound),
                  ),
                ],
              ),
            ),
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
    required this.entry,
  });

  final int index;
  final bool correct;
  final WordEntry entry;

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
                  child: FitToWidth(
                    child: Text(
                      '${index + 1}. ${entry.word}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.definition,
                  style: TextStyle(color: brand.foregroundMuted, height: 1.35),
                ),
              ],
            ),
          ),
          FavoriteButton(wordId: entry.id, compact: true),
          SpeakButton(
            compact: true,
            speechKey: 'result:${entry.id}',
            text: entry.english.spokenGlance,
            segments: glanceOf(context, entry, group: 'result:${entry.id}'),
          ),
        ],
      ),
    );
  }
}
