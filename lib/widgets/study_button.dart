import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/brand_colors.dart';

class StudyButton extends StatelessWidget {
  const StudyButton({super.key, this.onOpen});

  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.navStudy,
      child: Material(
        color: brand.card,
        shape: CircleBorder(side: BorderSide(color: brand.cardBorder)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onOpen,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              Icons.auto_stories_outlined,
              color: brand.accentGold,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
