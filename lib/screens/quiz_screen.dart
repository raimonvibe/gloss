import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_engine.dart';
import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../state/progress_controller.dart';
import '../state/quiz_controller.dart';
import '../state/reading.dart';
import '../state/settings_controller.dart';
import '../state/speech_controller.dart';
import '../theme/app_theme.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/button_label.dart';
import '../widgets/card_surface.dart';
import '../widgets/etymology_card.dart';
import '../widgets/favorite_button.dart';
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
          style: TextStyle(
            fontSize: 17,
            height: 1.45,
            color: brand.foregroundMuted,
          ),
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
              padding: kButtonPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(colors: brand.heroGradient),
              ),
              child: ButtonLabel(
                l10n.begin,
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

class _QuizPlay extends StatefulWidget {
  const _QuizPlay();

  @override
  State<_QuizPlay> createState() => _QuizPlayState();
}

class _QuizPlayState extends State<_QuizPlay> {
  /// The question the voice has already been handed, so that an answer
  /// coming in does not start the reading over.
  int? _read;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final quiz = context.read<QuizController>();
    if (!quiz.isActive || _read == quiz.index) return;
    _read = quiz.index;
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoplay());
  }

  /// "Read a word aloud when it opens", carried into the quiz: each question
  /// as it arrives, answers and all.
  ///
  /// Once per question, and not again when the answer lands — that would
  /// start talking over the reader at the moment they are reading.
  void _autoplay() {
    if (!mounted) return;
    if (!context.read<SettingsController>().autoplayPronunciation) return;
    final quiz = context.read<QuizController>();
    final question = quiz.current;
    if (question == null) return;
    final key = 'quiz:${question.word.id}:${quiz.index}';
    context.read<SpeechController>().speakSegments(
          key,
          quizReadingOf(
            context,
            question,
            revealed: quiz.hasAnsweredCurrent,
            group: key,
          ),
        );
  }

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
          child: _QuizHeader(quiz: quiz, question: question),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(side, 16, side, 20),
            children: [
              EtymologyCard(
                entry: question.word,
                compact: true,
                revealRoots: quiz.hasAnsweredCurrent,
              ),
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
                          fontSize: 17,
                          height: 1.45,
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
                    ),
                    child: ButtonLabel(l10n.previous),
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
                    ),
                    child: ButtonLabel(quiz.isLast ? l10n.seeResults : l10n.next),
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

/// The room the controls take: the close button's 48, and three 42pt circles
/// with 8pt between them and 8pt before the first.
const double _quizControlsWidth = 48 + 8 + 42 + 8 + 42 + 8 + 42;

/// What is left has to be enough for the progress line to read on one line —
/// "Question 3 of 5" is "Ερώτηση 3 από 5" in Greek, and the percentage
/// beside it is a fixed width that never shrinks. Measured in type rather
/// than in pixels, so it grows with the reader's text size.
double _progressFloor(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(190);

/// The strip above the question: leave, how far along, save, listen, light.
///
/// Five things across a phone is one thing too many. The progress line was
/// handed whatever the four controls left it — `width - 238`, which is 152pt
/// on a 390pt phone — and "Vraag 3 van 5" wrapped into three lines inside a
/// bar drawn for one, with the percentage squeezed against the edge. So the
/// controls keep their row and the progress line drops underneath whenever
/// sharing would crush it, which on a phone is always and on a tablet never.
class _QuizHeader extends StatelessWidget {
  const _QuizHeader({required this.quiz, required this.question});

  final QuizController quiz;
  final QuizQuestion question;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final key = 'quiz:${question.word.id}:${quiz.index}';

    final leave = IconButton(
      tooltip: l10n.endQuiz,
      onPressed: () {
        context.read<SpeechController>().stop();
        context.read<QuizController>().reset();
      },
      icon: Icon(Icons.close, color: brand.foregroundMuted),
    );
    final progress = ProgressTracker(
      current: quiz.index + (quiz.hasAnsweredCurrent ? 1 : 0),
      total: quiz.length,
      label: l10n.questionOf(quiz.index + 1, quiz.length),
    );
    final controls = <Widget>[
      FavoriteButton(wordId: question.word.id),
      const SizedBox(width: 8),
      SpeakButton(
        speechKey: key,
        text: question.word.english.spokenQuiz(
          revealed: quiz.hasAnsweredCurrent,
        ),
        segments: quizReadingOf(
          context,
          question,
          revealed: quiz.hasAnsweredCurrent,
          group: key,
        ),
      ),
      const SizedBox(width: 8),
      const ThemeToggle(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final room = constraints.maxWidth - _quizControlsWidth;
        if (room >= _progressFloor(context)) {
          return Row(
            children: [
              leave,
              Expanded(child: progress),
              const SizedBox(width: 8),
              ...controls,
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [leave, const Spacer(), ...controls]),
            const SizedBox(height: 6),
            progress,
          ],
        );
      },
    );
  }
}
