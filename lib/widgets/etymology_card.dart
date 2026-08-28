import 'package:flutter/material.dart';

import '../models/word_entry.dart';
import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';
import 'card_surface.dart';
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
    return GildedFrame(
      child: Padding(
        padding: EdgeInsets.fromLTRB(22, 20, 22, compact ? 18 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.pronunciation}  ·  ${entry.partOfSpeech}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: brand.foregroundMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            GradientText(
              entry.word,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: compact ? 32 : 40,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
            ),
            if (entry.variants.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '(${entry.variants.join(', ')})',
                  style: TextStyle(color: brand.foregroundMuted, fontSize: 14),
                ),
              ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _OriginChip(label: entry.origin),
                _OriginChip(label: entry.originWord, muted: true),
              ],
            ),
            const DividerFlourish(symbol: '❧'),
            const ScriptCaption(
              'roots',
              textAlign: TextAlign.start,
              fontSize: 26,
            ),
            const SizedBox(height: 10),
            ...entry.roots.map(
              (root) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: compact ? 108 : 124,
                      child: Text(
                        root.form,
                        style: AppFonts.playfair(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: brand.accentWine,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        root.meaning,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.3,
                          color: brand.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: muted ? brand.backgroundAlt : brand.accentGold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: muted ? brand.cardBorder : brand.accentGold.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: muted ? brand.foregroundMuted : brand.accentGold,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
