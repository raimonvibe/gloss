import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state/settings_controller.dart';
import '../theme/brand_colors.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final brand = context.brand;
    final platform = MediaQuery.platformBrightnessOf(context);
    final isDark = settings.themeMode == ThemeMode.dark ||
        (settings.themeMode == ThemeMode.system && platform == Brightness.dark);

    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: isDark ? l10n.switchToLightMode : l10n.switchToDarkMode,
      child: Material(
        color: brand.card,
        shape: CircleBorder(side: BorderSide(color: brand.cardBorder)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => settings.cycleTheme(platform),
          child: SizedBox(
            width: 42,
            height: 42,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                key: ValueKey(isDark),
                color: brand.accentGold,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
