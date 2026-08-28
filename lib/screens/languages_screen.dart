import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../l10n/locale_catalog.dart';
import '../state/settings_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/theme_toggle.dart';

const _continentOrder = [
  'Africa',
  'Asia',
  'Europe',
  'Americas',
  'Oceania',
];

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final catalog = settings.catalog;
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final devices = View.of(context).platformDispatcher.locales;
    final selectedId = settings.localeIdFor(devices);
    final needle = _query.text.trim().toLowerCase();
    final matches = catalog.choices.where((choice) {
      if (needle.isEmpty) return true;
      return choice.searchHaystack.contains(needle);
    }).toList();
    final selected = catalog.choiceForLocale(selectedId);

    final grouped = <String, List<LanguageChoice>>{
      for (final continent in _continentOrder) continent: [],
    };
    for (final choice in matches) {
      grouped.putIfAbsent(choice.country.continent, () => []).add(choice);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.languagesTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ScriptCaption(
                      l10n.languagesCaption,
                      textAlign: TextAlign.start,
                      fontSize: 24,
                    ),
                  ],
                ),
              ),
              const ThemeToggle(),
            ],
          ),
        ),
        if (selected != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: _LanguageRow(
              choice: selected,
              selected: true,
              caption: l10n.selectedLanguage,
              onTap: () {},
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CardSurface(
            radius: 999,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.search, color: brand.accentGold),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _query,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: l10n.searchLanguages,
                    ),
                  ),
                ),
                if (_query.text.isNotEmpty)
                  IconButton(
                    tooltip: l10n.clearSearch,
                    onPressed: () {
                      _query.clear();
                      setState(() {});
                    },
                    icon: Icon(Icons.close, color: brand.foregroundMuted),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: matches.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScriptCaption(l10n.nothingHere),
                        const SizedBox(height: 8),
                        Text(
                          l10n.noMatchingLanguages,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: brand.foregroundMuted,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: [
                    for (final continent in _continentOrder)
                      if (grouped[continent]!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
                          child: ScriptCaption(
                            localizedContinent(l10n, continent),
                            textAlign: TextAlign.start,
                            fontSize: 24,
                          ),
                        ),
                        for (final choice in grouped[continent]!)
                          _LanguageRow(
                            choice: choice,
                            selected: choice.locale.id == selectedId,
                            onTap: () => settings.setLocaleId(choice.locale.id),
                          ),
                      ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.choice,
    required this.selected,
    required this.onTap,
    this.caption,
  });

  final LanguageChoice choice;
  final bool selected;
  final VoidCallback onTap;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CardSurface(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderColor: selected ? brand.accentGold.withValues(alpha: 0.55) : null,
        child: Row(
          children: [
            Text(choice.country.flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (caption != null)
                    Text(
                      caption!,
                      style: TextStyle(
                        fontSize: 11,
                        color: brand.accentGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  Text(
                    choice.country.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${choice.locale.languageNameNative} · ${choice.locale.languageNameEn}',
                    style: TextStyle(
                      fontSize: 14,
                      color: brand.foregroundMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_outline, color: brand.accentGold, size: 20),
          ],
        ),
      ),
    );
  }
}
