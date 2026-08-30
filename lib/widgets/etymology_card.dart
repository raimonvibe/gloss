import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/word_entry.dart';
import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';
import 'button_label.dart';
import 'card_surface.dart';
import 'english_lemma.dart';
import 'fit_to_width.dart';
import 'pill.dart';
import 'ornament.dart';

class EtymologyCard extends StatelessWidget {
  const EtymologyCard({
    super.key,
    required this.entry,
    this.compact = false,
  });

  final WordEntry entry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    return GildedFrame(
      child: Padding(
        padding: EdgeInsets.fromLTRB(22, 20, 22, compact ? 18 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                EnglishLemma(
                  child: Text(
                    entry.pronunciation,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: brand.foregroundMuted,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  '  ·  ${entry.partOfSpeech}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: brand.foregroundMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            EnglishLemma(
              child: FitToWidth(
                child: GradientText(
                  entry.word,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: compact ? 32 : 40,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                ),
              ),
            ),
            if (entry.variants.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: EnglishLemma(
                  child: Text(
                    '(${entry.variants.join(', ')})',
                    style: TextStyle(color: brand.foregroundMuted, fontSize: 14),
                  ),
                ),
              ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _OriginChip(label: entry.origin),
                EnglishLemma(
                  child: _OriginChip(label: entry.originWord, muted: true),
                ),
              ],
            ),
            const DividerFlourish(symbol: '❧'),
            ScriptCaption(
              l10n.roots,
              textAlign: TextAlign.start,
              fontSize: 26,
            ),
            const SizedBox(height: 10),
            _Roots(roots: entry.roots, compact: compact),
          ],
        ),
      ),
    );
  }
}

/// A root and what it means, side by side for as long as both have room.
///
/// The forms stood in a column of a fixed 124pt, which was wrong from both
/// ends: `paidagōgos (Greek)` broke across it at the ordinary text size, and
/// at the largest one that same 124pt left the translated meaning beside it
/// barely a third of the card — Georgian and Khmer meanings shredded into
/// two-word lines. So the column is measured from the forms this entry
/// actually carries, and when even that will not fit in [_share] of the row,
/// the meaning goes underneath rather than into a crush.
class _Roots extends StatelessWidget {
  const _Roots({required this.roots, required this.compact});

  final List<WordRoot> roots;
  final bool compact;

  /// How much of a row the forms may take before the two stop sharing it.
  static const double _share = 0.45;

  /// The air between the form and the meaning beside it.
  static const double _gap = 12;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    // Merged the way [Text] would merge it, so that what is measured below
    // is what ends up on the card.
    final formStyle = DefaultTextStyle.of(context).style.merge(
          AppFonts.playfair(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            color: brand.accentWine,
          ),
        );
    final meaningStyle = TextStyle(
      fontSize: 16,
      height: 1.3,
      color: brand.foreground,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final scaler = MediaQuery.textScalerOf(context);
        var widest = 0.0;
        for (final root in roots) {
          final painter = TextPainter(
            text: TextSpan(text: root.form, style: formStyle),
            // The forms are English wherever the rest of the card is written.
            textDirection: TextDirection.ltr,
            textScaler: scaler,
            maxLines: 1,
          )..layout();
          widest = math.max(widest, painter.width);
          painter.dispose();
        }

        final room = constraints.maxWidth * _share;
        final stacked = !constraints.maxWidth.isFinite || widest > room;
        // Never narrower than the column has always been, so an ordinary
        // entry at an ordinary text size looks exactly as it did.
        final column = math.min(
          math.max(widest + _gap, compact ? 108.0 : 124.0),
          room,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final root in roots)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: stacked
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EnglishLemma(
                            child: Text(root.form, style: formStyle),
                          ),
                          const SizedBox(height: 2),
                          Text(root.meaning, style: meaningStyle),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: column,
                            child: EnglishLemma(
                              child: Text(root.form, style: formStyle),
                            ),
                          ),
                          Expanded(
                            child: Text(root.meaning, style: meaningStyle),
                          ),
                        ],
                      ),
              ),
          ],
        );
      },
    );
  }
}

class _OriginChip extends StatelessWidget {
  const _OriginChip({required this.label, this.muted = false});

  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final labelStyle = TextStyle(
      fontSize: 13,
      color: muted ? brand.foregroundMuted : brand.accentGold,
      fontWeight: FontWeight.w600,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: muted ? brand.backgroundAlt : brand.accentGold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(
          pillRadius(context, style: labelStyle, verticalPadding: 6),
        ),
        border: Border.all(
          color: muted ? brand.cardBorder : brand.accentGold.withValues(alpha: 0.45),
        ),
      ),
      child: ButtonLabel(label, minScale: 0.7, style: labelStyle),
    );
  }
}
