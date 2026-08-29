import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../l10n/category_labels.dart';
import '../models/word_entry.dart';
import '../state/quiz_controller.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/card_surface.dart';
import '../widgets/ornament.dart';

class QuizThemeScreen extends StatelessWidget {
  const QuizThemeScreen({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<WordRepository>();
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);

    return PaperBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(l10n.themeTitle)),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (repo.categories.isEmpty) {
              return Center(
                child: Text(
                  l10n.noThemesYet,
                  style: TextStyle(color: brand.foregroundMuted, fontSize: 16),
                ),
              );
            }
            final layout = Layout.fromConstraints(constraints);
            return ListView.builder(
              padding: layout.pagePadding(top: 8, bottom: 48),
              itemCount: repo.categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: ScriptCaption(l10n.chooseASubject),
                  );
                }
                final category = repo.categories[index - 1];
                final themed = repo.wordsForCategory(category.id);
                return _ThemeRow(
                  label: localizedCategoryLabel(l10n, category.id),
                  count: themed.length,
                  onTap: themed.isEmpty
                      ? null
                      : () => _begin(context, themed, repo.words),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _begin(
    BuildContext context,
    List<WordEntry> themed,
    List<WordEntry> allWords,
  ) {
    final l10n = AppLocalizations.of(context);
    try {
      context.read<QuizController>().start(
            themed,
            count: count,
            distractors: themed.length >= 4 ? null : allWords,
          );
      Navigator.of(context).pop();
    } on ArgumentError {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notEnoughWordsInTheme)),
      );
    }
  }
}

class _ThemeRow extends StatelessWidget {
  const _ThemeRow({
    required this.label,
    required this.count,
    this.onTap,
  });

  final String label;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: enabled ? 1 : 0.45,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                count == 0 ? '—' : '$count',
                style: TextStyle(
                  color: brand.foregroundMuted,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
