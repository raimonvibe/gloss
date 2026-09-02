import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../state/settings_controller.dart';
import '../theme/brand_colors.dart';
import 'card_surface.dart';

/// The furniture the study is built from, lent to any page that wants to
/// look like it — the contact letter does.
///
/// These were private to `study_screen.dart` until the letter needed the
/// same card, the same hairline between rows, and the same light switch.
/// Two copies of a card is how two pages start to drift apart.

/// A titled card, with a calligraphic aside beside the title.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    this.caption,
    required this.children,
  });

  final String title;
  final String? caption;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // A title wraps rather than runs off the card: 'A word before
              // you send' is short in English and a whole line in German,
              // and the caption beside it has to keep its room either way.
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: brand.foreground,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              if (caption != null) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: ScriptCaption(
                    caption!,
                    textAlign: TextAlign.start,
                    fontSize: 20,
                  ),
                ),
              ],
            ],
          ),
        ),
        CardSurface(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// The rule between two rows of a section.
class SettingsHairLine extends StatelessWidget {
  const SettingsHairLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.brand.cardBorder.withValues(alpha: 0.45),
    );
  }
}

/// A row that turns something on or off.
class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.label,
    this.caption,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String? caption;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      activeThumbColor: brand.accentGold,
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: caption == null
          ? null
          : Text(
              caption!,
              style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
            ),
    );
  }
}

/// A row that leads somewhere, or reports a number.
class SettingsLinkRow extends StatelessWidget {
  const SettingsLinkRow({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: brand.accentGold),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      trailing: trailing == null
          ? (onTap == null
              ? null
              : Icon(Icons.chevron_right, color: brand.foregroundMuted))
          : Text(
              trailing!,
              style: TextStyle(color: brand.foregroundMuted),
            ),
      onTap: onTap,
    );
  }
}

/// Parchment, candlelight, or whatever the device is doing.
///
/// The study has always carried it; the letter carries it too, because a
/// page of fields is exactly where someone wants to see both lights — a
/// placeholder that disappears into the paper is a placeholder that only
/// shows itself in one of them.
class ThemeModeControl extends StatelessWidget {
  const ThemeModeControl({super.key, required this.settings});

  final SettingsController settings;

  /// Three labels split one row, and the reader may be running text at twice
  /// the normal size (see the clamp in `app.dart`). Every other way out is
  /// worse: wrapping splits words mid-word ('Perkamen/t'), ellipsis hides
  /// which theme a segment picks, and a fixed small font would quietly
  /// override the reader's own text-size choice. Shrink only when it will not
  /// otherwise fit.
  Widget _label(String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text, maxLines: 1, softWrap: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SegmentedButton<ThemeMode>(
        // Rebuilt whenever the light changes, which throws away whatever this
        // control had in flight at that moment.
        //
        // It is the one button that repaints the page underneath itself. The
        // page turns over in a single frame (see `themeAnimationStyle` in
        // app.dart), but the button's own ink went on running afterwards in
        // the colours of the theme just left: a pale splash spreading and
        // fading inside the segment, and the fill and labels crossing to
        // their new colours over another fifth of a second, while everything
        // around them had already changed. A light moving over the page, and
        // the last of it. A new key here ends both, because the segments and
        // the Material holding their ink are built afresh.
        key: ValueKey(Theme.of(context).brightness),
        // The default segment padding is generous; the room is better spent
        // on the words, which run long in most of the 61 locales.
        style: SegmentedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
        segments: [
          ButtonSegment(
            value: ThemeMode.system,
            label: _label(l10n.themeSystem),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            label: _label(l10n.themeLight),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            label: _label(l10n.themeDark),
          ),
        ],
        selected: {settings.themeMode},
        showSelectedIcon: false,
        onSelectionChanged: (modes) => settings.setThemeMode(modes.first),
      ),
    );
  }
}
