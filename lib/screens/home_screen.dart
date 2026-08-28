import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../branding.dart';
import '../data/word_repository.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/ornament.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/speak_button.dart';
import '../widgets/theme_toggle.dart';
import 'word_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onOpenLexicon,
    required this.onOpenQuiz,
  });

  final VoidCallback onOpenLexicon;
  final VoidCallback onOpenQuiz;

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<WordRepository>();
    final progress = context.watch<ProgressController>();
    final brand = context.brand;
    final today = repo.wordOfTheDay();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
            child: Column(
              children: [
                const Row(
                  children: [
                    Spacer(),
                    ThemeToggle(),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    Branding.markAsset,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    semanticLabel: '${Branding.displayName} icon',
                  ),
                ),
                const SizedBox(height: 14),
                const ScriptCaption(Branding.tagline),
                const SizedBox(height: 8),
                GradientText(
                  Branding.displayName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 42,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${repo.words.length} rare, rich words from the ${Branding.lexiconName} lexicon — explained the way a friend would explain them, not a dictionary.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.4,
                    color: brand.foregroundMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: ProgressTracker(
              current: progress.explored.count,
              total: repo.words.length,
              label:
                  '${progress.explored.count} of ${repo.words.length} words explored',
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerFlourish()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _WordOfTheDay(
              entry: today,
              onOpen: () => _open(context, today),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
            child: Column(
              children: [
                _ActionButton(
                  icon: Icons.menu_book_outlined,
                  label: 'Explore the lexicon',
                  onTap: onOpenLexicon,
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  icon: Icons.quiz_outlined,
                  label: 'Start a quiz',
                  filled: true,
                  onTap: onOpenQuiz,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _open(BuildContext context, WordEntry entry) {
    context.read<ProgressController>().explored.add(entry.id);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => WordDetailScreen(entry: entry)),
    );
  }
}

class _WordOfTheDay extends StatelessWidget {
  const _WordOfTheDay({required this.entry, required this.onOpen});

  final WordEntry entry;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return GildedFrame(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: ScriptCaption(
                    'word of the day',
                    textAlign: TextAlign.start,
                    fontSize: 26,
                  ),
                ),
                SpeakButton(
                  speechKey: 'wotd:${entry.id}',
                  text: entry.spokenGlance,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.word, style: Theme.of(context).textTheme.headlineMedium),
            Text(
              entry.pronunciation,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: brand.foregroundMuted,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              entry.friendly,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: brand.foregroundMuted,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Read the full entry →',
              style: TextStyle(color: brand.accentGold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    if (filled) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(colors: brand.heroGradient),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return CardSurface(
      onTap: onTap,
      radius: 999,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: brand.accentGold, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: brand.foreground,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
