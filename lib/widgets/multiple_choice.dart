import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';
import 'card_surface.dart';

class MultipleChoice extends StatelessWidget {
  const MultipleChoice({
    super.key,
    required this.options,
    required this.correctIndex,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> options;
  final int correctIndex;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          _ChoiceTile(
            label: String.fromCharCode(65 + i),
            text: options[i],
            state: _stateFor(i),
            onTap: selectedIndex == null ? () => onSelect(i) : null,
          ),
          if (i != options.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }

  _ChoiceState _stateFor(int index) {
    if (selectedIndex == null) return _ChoiceState.idle;
    if (index == correctIndex) return _ChoiceState.correct;
    if (index == selectedIndex) return _ChoiceState.incorrect;
    return _ChoiceState.dimmed;
  }
}

enum _ChoiceState { idle, correct, incorrect, dimmed }

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.label,
    required this.text,
    required this.state,
    required this.onTap,
  });

  final String label;
  final String text;
  final _ChoiceState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final Color border;
    final Color badge;
    final IconData? icon;
    switch (state) {
      case _ChoiceState.correct:
        border = brand.correct;
        badge = brand.correct;
        icon = Icons.check_rounded;
      case _ChoiceState.incorrect:
        border = brand.incorrect;
        badge = brand.incorrect;
        icon = Icons.close_rounded;
      case _ChoiceState.dimmed:
        border = brand.cardBorder.withValues(alpha: 0.5);
        badge = brand.foregroundMuted;
        icon = null;
      case _ChoiceState.idle:
        border = brand.cardBorder;
        badge = brand.accentGold;
        icon = null;
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: state == _ChoiceState.dimmed ? 0.45 : 1,
      child: CardSurface(
        onTap: onTap,
        borderColor: border,
        borderWidth: state == _ChoiceState.correct || state == _ChoiceState.incorrect
            ? 1.8
            : 1,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: badge.withValues(alpha: 0.14),
                border: Border.all(color: badge.withValues(alpha: 0.55)),
              ),
              child: icon == null
                  ? Text(
                      label,
                      style: AppFonts.playfair(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: badge,
                      ),
                    )
                  : Icon(icon, size: 18, color: badge),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.45,
                  color: brand.foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
