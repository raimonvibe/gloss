import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/word_card.dart';
import 'word_detail_screen.dart';

class LexiconScreen extends StatefulWidget {
  const LexiconScreen({super.key, this.favoritesOnly = false});

  final bool favoritesOnly;

  @override
  State<LexiconScreen> createState() => _LexiconScreenState();
}

class _LexiconScreenState extends State<LexiconScreen> {
  final _query = TextEditingController();
  final _selectedTags = <String>{};

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<WordRepository>();
    final progress = context.watch<ProgressController>();
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final results = repo.search(
      query: _query.text,
      tags: _selectedTags.toList(),
      ids: widget.favoritesOnly ? progress.favorites.ids : null,
    );

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
                      widget.favoritesOnly
                          ? l10n.savedTitle
                          : l10n.lexiconTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ScriptCaption(
                      widget.favoritesOnly
                          ? l10n.savedCaption
                          : l10n.lexiconCaption,
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
                      hintText: l10n.searchHint,
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
        const SizedBox(height: 12),
        if (!widget.favoritesOnly)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _TagChip(
                  label: l10n.filterAll,
                  selected: _selectedTags.isEmpty,
                  onTap: () => setState(_selectedTags.clear),
                ),
                const SizedBox(width: 8),
                ...repo.categories.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _TagChip(
                      label: localizedCategoryLabel(l10n, cat.id),
                      selected: _selectedTags.contains(cat.id),
                      wine: true,
                      onTap: () => setState(() {
                        if (!_selectedTags.add(cat.id)) {
                          _selectedTags.remove(cat.id);
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (_query.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                results.isEmpty
                    ? l10n.noMatches
                    : l10n.matchCount(results.length),
                style: TextStyle(color: brand.foregroundMuted, fontSize: 13),
              ),
            ),
          ),
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScriptCaption(l10n.nothingHere),
                        const SizedBox(height: 8),
                        Text(
                          widget.favoritesOnly
                              ? l10n.emptySaved
                              : l10n.emptyLexicon,
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
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final entry = results[index];
                    return WordCard(
                      entry: entry,
                      isFavorite: progress.favorites.contains(entry.id),
                      onToggleFavorite: () =>
                          progress.favorites.toggle(entry.id),
                      onOpen: () => _open(context, entry),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _open(BuildContext context, WordEntry entry) {
    context.read<ProgressController>().explored.add(entry.id);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => WordDetailScreen(entry: entry)),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.wine = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool wine;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final fill = wine ? brand.accentWine : brand.accentGold;
    return Material(
      color: selected ? fill : brand.card,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? fill : brand.cardBorder),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: selected ? Colors.white : brand.foregroundMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
