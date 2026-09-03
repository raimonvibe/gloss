import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/word_entry.dart';
import '../state/reading.dart';
import '../theme/brand_colors.dart';
import 'card_surface.dart';
import 'english_lemma.dart';
import 'favorite_button.dart';
import 'fit_to_width.dart';
import 'speak_button.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.entry,
    required this.onOpen,
  });

  final WordEntry entry;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    return CardSurface(
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EnglishLemma(
                      child: FitToWidth(
                        child: Text(
                          entry.word,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      // The gap is the Wrap's, not spaces typed into the
                      // string — see _MetaLine in etymology_card.dart.
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        EnglishLemma(
                          child: Text(
                            entry.pronunciation,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              color: brand.foregroundMuted,
                            ),
                            semanticsLabel: entry.spokenPronunciation,
                          ),
                        ),
                        Text(
                          '·',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: brand.foregroundMuted,
                          ),
                        ),
                        Text(
                          entry.partOfSpeech,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: brand.foregroundMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriteButton(wordId: entry.id, compact: true),
              SpeakButton(
                compact: true,
                speechKey: 'card:${entry.id}',
                text: entry.english.spokenGlance,
                segments: glanceOf(
                  context,
                  entry,
                  group: 'card:${entry.id}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.friendly,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              height: 1.45,
              color: brand.foregroundMuted,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.tapToReadMore,
            style: TextStyle(fontSize: 13, color: brand.accentGold),
          ),
        ],
      ),
    );
  }
}
