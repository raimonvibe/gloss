import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/etymology_card.dart';
import '../widgets/ornament.dart';
import '../widgets/speak_button.dart';
import '../widgets/theme_toggle.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({super.key, required this.entry});

  final WordEntry entry;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final progress = context.watch<ProgressController>();
    final repo = context.watch<WordRepository>();
    final saved = progress.favorites.contains(entry.id);

    return StopSpeechOnExit(
      child: PaperBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        title: Text(entry.word),
        actions: [
          SpeakButton(
            speechKey: 'entry:${entry.id}',
            text: entry.spokenEntry,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: ThemeToggle(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          EtymologyCard(entry: entry),
          const DividerFlourish(),
          _Section(
            title: 'in plain words',
            child: Text(
              entry.friendly,
              style: TextStyle(
                fontSize: 18,
                height: 1.45,
                color: brand.foreground,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _Section(
            title: 'the definition',
            child: Text(
              entry.definition,
              style: TextStyle(
                fontSize: 16,
                height: 1.45,
                color: brand.foregroundMuted,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _Section(
            title: 'in a sentence',
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: brand.accentGold.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '“${entry.example}”',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.45,
                  color: brand.foregroundMuted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in entry.tags)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: brand.backgroundAlt,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: brand.cardBorder),
                  ),
                  child: Text(
                    repo.labelForTag(tag),
                    style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _PillButton(
                  icon: saved ? Icons.favorite : Icons.favorite_border,
                  label: saved ? 'Saved' : 'Save',
                  filled: saved,
                  onTap: () => progress.favorites.toggle(entry.id),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PillButton(
                  icon: Icons.copy_outlined,
                  label: 'Copy',
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: '${entry.word} — ${entry.friendly}'),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScriptCaption(
          title,
          textAlign: TextAlign.start,
          fontSize: 26,
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
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
    return Material(
      color: filled ? brand.accentWine : brand.card,
      shape: StadiumBorder(
        side: BorderSide(color: filled ? brand.accentWine : brand.cardBorder),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: filled ? Colors.white : brand.foregroundMuted),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: filled ? Colors.white : brand.foregroundMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
