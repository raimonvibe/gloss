import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../state/progress_controller.dart';
import '../state/quiz_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/card_surface.dart';
import '../widgets/etymology_card.dart';
import '../widgets/multiple_choice.dart';
import '../widgets/ornament.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/speak_button.dart';
import '../widgets/theme_toggle.dart';
import 'quiz_results_screen.dart';
import 'quiz_theme_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    if (!quiz.isActive) {
      return const _QuizSetup();
    }
    return const _QuizPlay();
  }
}

class _QuizSetup extends StatefulWidget {
  const _QuizSetup();

  @override
  State<_QuizSetup> createState() => _QuizSetupState();
}

class _QuizSetupState extends State<_QuizSetup> {
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final repo = context.watch<WordRepository>();
    final l10n = AppLocalizations.of(context);
    final layout = context.layout;
    return ListView(
      padding: layout.pagePadding(top: 20, bottom: 40),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.quizTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const ThemeToggle(),
          ],
        ),
        const SizedBox(height: 8),
        ScriptCaption(l10n.quizCaption),
        const SizedBox(height: 16),
        Text(
          l10n.quizIntro,
          style: TextStyle(fontSize: 16, height: 1.4, color: brand.foregroundMuted),
        ),
        const DividerFlourish(),
        ScriptCaption(
          l10n.howManyWords,
          textAlign: TextAlign.start,
          fontSize: 26,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            for (final n in const [5, 10, 20])
              _CountChip(
                label: '$n',
                selected: _count == n,
                onTap: () => setState(() => _count = n),
              ),
          ],
        ),
        const SizedBox(height: 28),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<QuizController>().start(repo.words, count: _count);
            },
            borderRadius: BorderRadius.circular(999),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(colors: brand.heroGradient),
              ),
              child: Text(
                l10n.begin,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => QuizThemeScreen(count: _count),
              ),
            );
          },
          child: Text(l10n.quizByTheme),
        ),
      ],
    );
  }
}

class _CountChip extends StatelessWidget {
  const _CountChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Material(
      color: selected ? brand.accentGold : brand.card,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? brand.accentGold : brand.cardBorder),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : brand.foregroundMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizPlay extends StatelessWidget {
  const _QuizPlay();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    final question = quiz.current!;
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final layout = context.layout;
    final side = layout.sideInset();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(side, 12, side, 0),
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.endQuiz,
                onPressed: () {
                  context.read<SpeechController>().stop();
                  context.read<QuizController>().reset();
                },
                icon: Icon(Icons.close, color: brand.foregroundMuted),
              ),
              Expanded(
                child: ProgressTracker(
                  current: quiz.index + (quiz.hasAnsweredCurrent ? 1 : 0),
                  total: quiz.length,
                  label: l10n.questionOf(quiz.index + 1, quiz.length),
                ),
              ),
              const SizedBox(width: 8),
              SpeakButton(
                speechKey: 'quiz:${question.word.id}:${quiz.index}',
                text: question.word.spokenQuiz(
                  revealed: quiz.hasAnsweredCurrent,
                ),
              ),
              const SizedBox(width: 8),
              const ThemeToggle(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(side, 16, side, 20),
            children: [
              EtymologyCard(entry: question.word, compact: true),
              const SizedBox(height: 18),
              ScriptCaption(
                l10n.whichDefinitionFits,
                textAlign: TextAlign.start,
                fontSize: 26,
              ),
              const SizedBox(height: 10),
              MultipleChoice(
                options: question.options,
                correctIndex: question.correctIndex,
                selectedIndex: quiz.selectedIndex,
                onSelect: (index) {
                  context.read<QuizController>().select(index);
                  context
                      .read<ProgressController>()
                      .explored
                      .add(question.word.id);
                },
              ),
              if (quiz.hasAnsweredCurrent) ...[
                const SizedBox(height: 16),
                CardSurface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScriptCaption(
                        l10n.inPlainWords,
                        textAlign: TextAlign.start,
                        fontSize: 26,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.word.friendly,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          color: brand.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(side, 8, side, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: quiz.canGoBack
                        ? () {
                            context.read<SpeechController>().stop();
                            context.read<QuizController>().previous();
                          }
                        : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: brand.foreground,
                      side: BorderSide(color: brand.cardBorder),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(l10n.previous, textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: quiz.hasAnsweredCurrent
                        ? () => _forward(context, quiz)
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: brand.accentGold,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      quiz.isLast ? l10n.seeResults : l10n.next,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _forward(BuildContext context, QuizController quiz) {
    context.read<SpeechController>().stop();
    if (quiz.isLast) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const QuizResultsScreen()),
      );
    } else {
      quiz.next();
    }
  }
}
