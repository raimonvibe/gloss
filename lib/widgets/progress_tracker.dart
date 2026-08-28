import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';
import '../theme/brand_colors.dart';

class ProgressTracker extends StatelessWidget {
  const ProgressTracker({
    super.key,
    required this.current,
    required this.total,
    this.label,
  });

  final int current;
  final int total;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final pct = total == 0 ? 0.0 : (current / total).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_stories_outlined, size: 18, color: brand.accentGold),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label ?? '$current of $total',
                style: AppFonts.cormorant(
                  color: brand.foregroundMuted,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              '${(pct * 100).round()}%',
              style: AppFonts.playfair(
                color: brand.accentGold,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: brand.backgroundAlt),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: pct,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: brand.heroGradient),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
