import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../models/word_entry.dart';
import '../state/progress_controller.dart';
import '../theme/app_theme.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
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
    final layout = context.layout;
    final side = layout.sideInset(layout.contentWidth);
    final columns = layout.columnsFor();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(side, 16, side, 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The page's own name, which is furniture rather than
                    // reading: doubled it wrapped to three lines and took
                    // the room the words needed. The list below it is what
                    // the reader turned their text size up for.
                    MediaQuery.withClampedTextScaling(
                      maxScaleFactor: 1.4,
                      child: Text(
                        widget.favoritesOnly
                            ? l10n.savedTitle
                            : l10n.lexiconTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
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
          padding: EdgeInsets.symmetric(horizontal: side),
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
                      hintMaxLines: hintLines(context),
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
          // A floor, not a height. The strip used to be a 40pt box, which
          // is a promise about the type inside it that no reader with large
          // text turned on has agreed to — and a clipped strip reports no
          // overflow, so the labels simply lost their tops and tails. It
          // keeps the 40 it always stood at, and grows past it when the
          // chips do.
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: side),
              child: Row(
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
          ),
        if (_query.text.isNotEmpty)
          Padding(
            padding: EdgeInsets.fromLTRB(side + 4, 10, side + 4, 0),
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
              // Centred while it fits and scrollable when it does not: at
              // the largest text size "No saved words yet. Tap the heart on
              // any entry." is taller than the space between the search box
              // and the tabs, and a Center has nowhere to put the rest.
              ? LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      child: Center(
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
                                fontSize: 17,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : _WordList(
                  results: results,
                  columns: columns,
                  padding: EdgeInsets.fromLTRB(side, 16, side, 32),
                  card: (entry) => WordCard(
                    entry: entry,
                    onOpen: () => _open(context, entry),
                  ),
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

/// The words, one column on a phone and two or three once the page is wide
/// enough that a single column would leave the cards stranded.
///
/// The rows are built from the list rather than from a grid delegate so a
/// card is as tall as its own text needs — a grid would want one height for
/// every tile, which the reader's text size keeps moving.
class _WordList extends StatelessWidget {
  const _WordList({
    required this.results,
    required this.columns,
    required this.padding,
    required this.card,
  });

  final List<WordEntry> results;
  final int columns;
  final EdgeInsets padding;
  final Widget Function(WordEntry entry) card;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return ListView.separated(
        padding: padding,
        itemCount: results.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => card(results[index]),
      );
    }

    final rows = (results.length + columns - 1) ~/ columns;
    return ListView.separated(
      padding: padding,
      itemCount: rows,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, row) {
        final start = row * columns;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var column = 0; column < columns; column++) ...[
                if (column > 0) const SizedBox(width: 12),
                Expanded(
                  child: start + column < results.length
                      ? card(results[start + column])
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        );
      },
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
