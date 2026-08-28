import 'package:flutter/material.dart';

import '../models/word_entry.dart';
import '../theme/brand_colors.dart';
import 'card_surface.dart';
import 'speak_button.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.entry,
    required this.isFavorite,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  final WordEntry entry;
  final bool isFavorite;
  final VoidCallback onOpen;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
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
                    Text(
                      entry.word,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${entry.pronunciation}  ·  ${entry.partOfSpeech}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: brand.foregroundMuted,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                tooltip: isFavorite ? 'Remove from favorites' : 'Save word',
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? brand.accentWine : brand.foregroundMuted,
                ),
              ),
              SpeakButton(
                compact: true,
                speechKey: 'card:${entry.id}',
                text: entry.spokenGlance,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.friendly,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              height: 1.35,
              color: brand.foregroundMuted,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap to read more',
            style: TextStyle(fontSize: 13, color: brand.accentGold),
          ),
        ],
      ),
    );
  }
}
