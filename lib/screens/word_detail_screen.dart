import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../state/reading.dart';
import '../state/settings_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/button_label.dart';
import '../widgets/card_surface.dart';
import '../widgets/english_lemma.dart';
import '../widgets/etymology_card.dart';
import '../widgets/favorite_button.dart';
import '../widgets/ornament.dart';
import '../widgets/pill.dart';
import '../widgets/speak_button.dart';
import '../widgets/theme_toggle.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({super.key, required this.entry});

  final WordEntry entry;

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoplay());
  }

  /// "Read a word aloud when it opens".
  void _autoplay() {
    if (!mounted) return;
    if (!context.read<SettingsController>().autoplayPronunciation) return;
    final repo = context.read<WordRepository>();
    final matches = repo.words.where((word) => word.id == widget.entry.id);
    final live = matches.isEmpty ? widget.entry : matches.first;
    context
        .read<SpeechController>()
        .speakSegments('entry:${live.id}', readingOf(context, live));
  }

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final progress = context.watch<ProgressController>();
    final repo = context.watch<WordRepository>();
    final l10n = AppLocalizations.of(context);
    final saved = progress.favorites.contains(widget.entry.id);
    final matches = repo.words.where((word) => word.id == widget.entry.id);
    final live = matches.isEmpty ? widget.entry : matches.first;

    return StopSpeechOnExit(
      child: PaperBackdrop(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: EnglishLemma(child: Text(live.word)),
            actions: [
              // The Save pill is at the foot of the page, behind the roots,
              // the sentence and the gloss. A reader who knows already that
              // they want the word should not have to read to the end to
              // keep it.
              FavoriteButton(wordId: live.id, compact: true),
              SpeakButton(
                speechKey: 'entry:${live.id}',
                text: live.spokenEntry,
                segments: readingOf(context, live),
              ),
              // Listen stops the reading; the toggle repaints the app. Two
              // gold circles of the same size, so they keep the gap the quiz
              // page gives them rather than touching under one thumb.
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: ThemeToggle(),
              ),
            ],
          ),
          body: LayoutBoundary(
            child: Builder(
              builder: (context) => ListView(
                padding: context.layout.pagePadding(top: 8, bottom: 40),
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
                        fontSize: 17,
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
                          child: EnglishLemma(
                            child: Text(
                              '“${live.example}”',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                height: 1.45,
                                color: brand.foregroundMuted,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // The gloss is a section like the three above it, and it
                  // is drawn like one: the same script face at the same 26,
                  // on the page's own left edge, with the same air over it.
                  // It used to sit inside the quotation's rule at 22, which
                  // put two headings of two sizes on two different margins
                  // within a few lines of each other — the page stopped
                  // looking level, which is what a reader saw. The rule now
                  // marks the quotation and nothing else.
                  if (live.exampleGloss != null) ...[
                    const SizedBox(height: 18),
                    _Section(
                      title: l10n.exampleGlossLabel,
                      child: Text(
                        live.exampleGloss!,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.45,
                          color: brand.foregroundMuted,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in live.tags)
                        _TagPill(label: localizedCategoryLabel(l10n, tag)),
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
                              ClipboardData(
                            text: '${live.word} — ${live.friendly}',
                          ),
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

/// A category the word belongs to.
///
/// Shrink-then-wrap words ([ButtonLabel]) and a radius that stops growing
/// once they take a second line ([pillRadius]) — "Speech & Rhetoric" is
/// "Sprache und Rhetorik" in German and longer still in Georgian, and at the
/// largest text size the label used to be cut by the curve of its own pill.
class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final labelStyle = TextStyle(fontSize: 12, color: brand.foregroundMuted);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: brand.backgroundAlt,
        borderRadius: BorderRadius.circular(
          pillRadius(context, style: labelStyle, verticalPadding: 6),
        ),
        border: Border.all(color: brand.cardBorder),
      ),
      child: ButtonLabel(label, minScale: 0.7, style: labelStyle),
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: filled ? Colors.white : brand.foregroundMuted,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: ButtonLabel(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: filled ? Colors.white : brand.foregroundMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
