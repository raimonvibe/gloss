import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/word_entry.dart';
import '../models/respelling.dart';
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
    this.revealRoots = true,
  });

  final WordEntry entry;
  final bool compact;

  /// Whether the roots are shown at all.
  ///
  /// The quiz holds them back until the answer is in: *hebes* "dull, blunt"
  /// above four definitions of which one is "Mental dullness or lethargy"
  /// is not a clue, it is the answer. They arrive with the rest of the
  /// explanation once the reader has committed, which is where they teach
  /// something rather than give something away.
  final bool revealRoots;

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
            _MetaLine(
              pronunciation: entry.pronunciation,
              partOfSpeech: entry.partOfSpeech,
              fontSize: 13,
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
            if (revealRoots) ...[
              const DividerFlourish(symbol: '❧'),
              ScriptCaption(
                l10n.roots,
                textAlign: TextAlign.start,
                fontSize: 26,
              ),
              const SizedBox(height: 10),
              _Roots(roots: entry.roots, compact: compact),
            ],
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
        // The forms' own column, with the air beside it kept out of it.
        //
        // The gap used to be slack inside this box, which works only while
        // the page reads left to right. Laid out right to left the box is
        // the right-hand one and its slack falls on the far side of the
        // form, so the meaning ended up against the form with nothing
        // between them — 'يناضل للخروجeluctari' on the Arabic card. A gap
        // in the row instead lands on the near side whichever way the row
        // is laid out.
        //
        // Never narrower than the column has always been, so an ordinary
        // entry at an ordinary text size looks exactly as it did.
        final forms = math.min(
          math.max(widest, (compact ? 108.0 : 124.0) - _gap),
          room,
        );
        // Which edge of that column the form stands against follows the
        // page, not the form. The form is English and reads left to right
        // wherever it is, but on an Arabic page its column is the
        // right-hand one, and it belongs against the right of it.
        final ltr = Directionality.of(context) == TextDirection.ltr;

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
                            width: forms,
                            child: EnglishLemma(
                              child: Text(
                                root.form,
                                style: formStyle,
                                textAlign:
                                    ltr ? TextAlign.left : TextAlign.right,
                              ),
                            ),
                          ),
                          const SizedBox(width: _gap),
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

/// An English pronunciation, a middot, and a translated part of speech.
///
/// The air between them is the Wrap's, not two spaces typed into the front
/// of a string. Spacing written as content sits inside a run of text, and a
/// run boundary is where a right-to-left page is free to trim or reorder it
/// — the same mistake that left a root pressed against its meaning on the
/// Arabic card. Here it never had a chance to show, because two spaces are
/// about the width the gap wanted anyway; it was luck rather than layout.
class _MetaLine extends StatelessWidget {
  const _MetaLine({
    required this.pronunciation,
    required this.partOfSpeech,
    required this.fontSize,
  });

  final String pronunciation;
  final String partOfSpeech;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontStyle: FontStyle.italic,
      color: context.brand.foregroundMuted,
      fontSize: fontSize,
    );
    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        EnglishLemma(
          child: Text(
            pronunciation,
            style: style,
            // What a screen reader says, so it matches the app's own
            // voice — see spokenRespelling.
            semanticsLabel: spokenRespelling(pronunciation),
          ),
        ),
        Text('·', style: style),
        Text(partOfSpeech, style: style),
      ],
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
