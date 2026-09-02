import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state/progress_controller.dart';
import '../theme/brand_colors.dart';

/// Save a word, wherever the word is shown.
///
/// It wires itself to [ProgressController], so a screen has only to name the
/// word it is drawing. That is what keeps the lexicon card, the word of the
/// day, a quiz question and a result row wearing one heart between them —
/// the save used to live on the lexicon alone, and a reader who met a word
/// anywhere else had to go and find it again to keep it.
///
/// [compact] follows `SpeakButton`: a bare icon where it sits inside a card,
/// a gold circle where it stands beside one.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.wordId,
    this.compact = false,
  });

  final String wordId;

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<ProgressController>().favorites;
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final saved = favorites.contains(wordId);
    final label = saved ? l10n.removeFromFavorites : l10n.saveWord;
    void toggle() => favorites.toggle(wordId);

    final icon = Icon(
      saved ? Icons.favorite : Icons.favorite_border,
      color: saved
          ? brand.accentWine
          : compact
              ? brand.foregroundMuted
              : brand.accentGold,
      size: compact ? 22 : 20,
    );

    if (compact) {
      return IconButton(
        tooltip: label,
        onPressed: toggle,
        icon: icon,
      );
    }

    return Tooltip(
      message: label,
      child: Material(
        color: brand.card,
        shape: CircleBorder(side: BorderSide(color: brand.cardBorder)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: toggle,
          child: SizedBox(
            width: 42,
            height: 42,
            child: icon,
          ),
        ),
      ),
    );
  }
}
