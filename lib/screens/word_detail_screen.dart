import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../l10n/speech_templates.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/english_lemma.dart';
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
    final l10n = AppLocalizations.of(context);
    final saved = progress.favorites.contains(entry.id);
    final matches = repo.words.where((word) => word.id == entry.id);
    final live = matches.isEmpty ? entry : matches.first;

    return StopSpeechOnExit(
      child: PaperBackdrop(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: EnglishLemma(child: Text(live.word)),
            actions: [
              SpeakButton(
                speechKey: 'entry:${live.id}',
                text: live.spokenEntryWith(SpeechTemplates.fromL10n(l10n)),
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
              EtymologyCard(entry: live),
              const DividerFlourish(),
              _Section(
                title: l10n.inPlainWords,
                child: Text(
                  live.friendly,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.45,
                    color: brand.foreground,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Section(
                title: l10n.theDefinition,
                child: Text(
                  live.definition,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: brand.foregroundMuted,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Section(
                title: l10n.inASentence,
                child: Builder(
                  builder: (context) {
                    final rtl =
                        Directionality.of(context) == TextDirection.rtl;
                    final gold = brand.accentGold.withValues(alpha: 0.5);
                    return Container(
                      padding: EdgeInsets.only(
                        left: rtl ? 0 : 12,
                        right: rtl ? 12 : 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: rtl
                              ? BorderSide.none
                              : BorderSide(color: gold, width: 2),
                          right: rtl
                              ? BorderSide(color: gold, width: 2)
                              : BorderSide.none,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EnglishLemma(
                            child: Text(
                              '“${live.example}”',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                height: 1.45,
                                color: brand.foregroundMuted,
                              ),
                            ),
                          ),
                          if (live.exampleGloss != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              l10n.exampleGlossLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: brand.accentGold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              live.exampleGloss!,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.4,
                                color: brand.foregroundMuted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in live.tags)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: brand.backgroundAlt,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: brand.cardBorder),
                      ),
                      child: Text(
                        localizedCategoryLabel(l10n, tag),
                        style: TextStyle(
                          fontSize: 12,
                          color: brand.foregroundMuted,
                        ),
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
                      label: saved ? l10n.saved : l10n.save,
                      filled: saved,
                      onTap: () => progress.favorites.toggle(live.id),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PillButton(
                      icon: Icons.copy_outlined,
                      label: l10n.copy,
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: '${live.word} — ${live.friendly}'),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.copiedToClipboard)),
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
              Icon(
                icon,
                size: 18,
                color: filled ? Colors.white : brand.foregroundMuted,
              ),
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
