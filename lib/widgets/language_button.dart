import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/brand_colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, this.onOpen});

  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.languagesTitle,
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
              Icons.translate_outlined,
              color: brand.accentGold,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
