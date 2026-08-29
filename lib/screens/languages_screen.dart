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

  /// Null until the first build, which is the earliest point the selected
  /// locale is known. 177 countries in one flat list is a long scroll, so
  /// only the continent the reader is already reading in starts open.
  Set<String>? _open;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  /// A search has to reach into every continent, or matches outside the open
  /// ones would silently not show up.
  bool _isOpen(String continent, {required bool searching}) =>
      searching || (_open?.contains(continent) ?? false);

  void _toggle(String continent) {
    setState(() {
      final open = _open ??= <String>{};
      if (!open.remove(continent)) open.add(continent);
    });
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
    final searching = needle.isNotEmpty;
    _open ??= {
      if (selected != null) selected.country.continent,
    };

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
                        _ContinentHeader(
                          label: localizedContinent(l10n, continent),
                          count: grouped[continent]!.length,
                          open: _isOpen(continent, searching: searching),
                          onTap: searching
                              ? null
                              : () => _toggle(continent),
                        ),
                        if (_isOpen(continent, searching: searching))
                          for (final choice in grouped[continent]!)
                            _LanguageRow(
                              choice: choice,
                              selected: choice.locale.id == selectedId,
                              onTap: () =>
                                  settings.setLocaleId(choice.locale.id),
                            ),
                      ],
                  ],
                ),
        ),
      ],
    );
  }
}

/// A continent that folds away. The chevron and the count are the only hints
/// that anything is hidden, so both stay visible when the section is shut.
class _ContinentHeader extends StatelessWidget {
  const _ContinentHeader({
    required this.label,
    required this.count,
    required this.open,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool open;

  /// Null while a search is running - the sections are forced open then, and
  /// a header that refused to close would just look broken.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Semantics(
      button: onTap != null,
      expanded: open,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
          child: Row(
            children: [
              Expanded(
                child: ScriptCaption(
                  label,
                  textAlign: TextAlign.start,
                  fontSize: 24,
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 13,
                  color: brand.foregroundMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedRotation(
                turns: open ? 0.5 : 0,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.expand_more,
                  size: 22,
                  color: onTap == null ? brand.foregroundMuted : brand.accentGold,
                ),
              ),
            ],
          ),
        ),
      ),
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
