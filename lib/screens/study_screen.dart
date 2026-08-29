import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../branding.dart';
import '../l10n/app_localizations.dart';
import '../data/word_repository.dart';
import '../state/progress_controller.dart';
import '../state/settings_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../widgets/card_surface.dart';
import '../widgets/social_row.dart';
import 'languages_screen.dart';

/// Spoken when the reader tries a voice. Deliberately not localised: the
/// lexicon is English and the engine is locked to an English voice, so a
/// translated preview would be read in the wrong language.
const kVoicePreview = 'Edulcorate. To sweeten, or to soften.';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key, this.onShare});

  /// Injected by tests so no share sheet or browser opens.
  final Future<bool> Function(Uri url)? onShare;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  void initState() {
    super.initState();
    // The engine reports its voices asynchronously; ask once on arrival.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<SpeechController>().loadVoices();
    });
  }

  /// Clearing either store cannot be undone, so it is always behind a
  /// dialog whose confirm button says what it will do rather than "OK".
  Future<void> _confirmClear({
    required String title,
    required String body,
    required String confirmLabel,
    required Future<void> Function() onConfirm,
    required String done,
  }) async {
    final l10n = AppLocalizations.of(context);
    final errorColor = Theme.of(context).colorScheme.error;
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: errorColor),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await onConfirm();
    if (!mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(done)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = context.watch<SettingsController>();
    final progress = context.watch<ProgressController>();
    final total = context.watch<WordRepository>().words.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        _Header(title: l10n.studyTitle, caption: l10n.studyCaption),
        const SizedBox(height: 16),
        _Section(
          title: l10n.readingSection,
          caption: l10n.readingCaption,
          children: [
            _TextSizeControl(settings: settings),
            const _HairLine(),
            _SwitchRow(
              label: l10n.autoplayPronunciation,
              value: settings.autoplayPronunciation,
              onChanged: settings.setAutoplayPronunciation,
            ),
            const _HairLine(),
            _SwitchRow(
              label: l10n.reduceMotion,
              caption: l10n.reduceMotionCaption,
              value: settings.reduceMotion,
              onChanged: settings.setReduceMotion,
            ),
          ],
        ),
        const SizedBox(height: 14),
        _Section(
          title: l10n.voiceSection,
          caption: l10n.voiceCaption,
          children: [_VoiceControl(settings: settings)],
        ),
        const SizedBox(height: 14),
        _Section(
          title: l10n.lightSection,
          caption: l10n.lightCaption,
          children: [_ThemeControl(settings: settings)],
        ),
        const SizedBox(height: 14),
        _Section(
          title: l10n.tongueSection,
          children: [
            _LinkRow(
              icon: Icons.translate_outlined,
              label: l10n.languagesTitle,
              trailing: settings.catalog
                  .infoFor(settings.localeIdFor(
                    View.of(context).platformDispatcher.locales,
                  ))
                  ?.languageNameNative,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const _LanguagesPage(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _Section(
          title: l10n.memorySection,
          caption: l10n.memoryCaption,
          children: [
            _LinkRow(
              icon: Icons.history_toggle_off,
              label: l10n.forgetProgress,
              trailing: l10n.currentOfTotal(progress.explored.count, total),
              // Nothing to forget yet: an inert row says so more quietly
              // than a dialog that reports it has nothing to do.
              onTap: progress.explored.count == 0
                  ? null
                  : () => _confirmClear(
                        title: l10n.forgetProgress,
                        body: l10n.forgetProgressBody,
                        confirmLabel: l10n.forget,
                        onConfirm: progress.explored.clear,
                        done: l10n.progressForgotten,
                      ),
            ),
            const _HairLine(),
            _LinkRow(
              icon: Icons.bookmark_remove_outlined,
              label: l10n.clearSavedWords,
              trailing: '${progress.favorites.count}',
              onTap: progress.favorites.count == 0
                  ? null
                  : () => _confirmClear(
                        title: l10n.clearSavedWords,
                        body: l10n.clearSavedWordsBody,
                        confirmLabel: l10n.clear,
                        onConfirm: progress.favorites.clear,
                        done: l10n.savedWordsCleared,
                      ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _Section(
          title: l10n.aboutSection,
          caption: l10n.aboutCaption,
          children: [
            _LinkRow(
              icon: Icons.info_outline,
              label: l10n.versionLine(Branding.version),
            ),
            const _HairLine(),
            _LinkRow(
              icon: Icons.article_outlined,
              label: l10n.openLicences,
              onTap: () => showLicensePage(
                context: context,
                applicationName: Branding.displayName,
                applicationVersion: Branding.version,
              ),
            ),
            const _HairLine(),
            _LinkRow(
              icon: Icons.ios_share,
              label: l10n.shareGloss,
              onTap: () => _share(context),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ScriptCaption(l10n.followTheMaker, fontSize: 26),
        const SizedBox(height: 10),
        SocialRow(onOpen: widget.onShare),
      ],
    );
  }

  Future<void> _share(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final l10n = AppLocalizations.of(context);
    final url = Uri.parse(Branding.storeUrl);
    final launcher = widget.onShare ??
        (Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);
    var opened = false;
    try {
      opened = await launcher(url);
    } catch (_) {
      opened = false;
    }
    if (!opened) {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.couldNotOpenLink(Branding.displayName))),
      );
    }
  }
}

/// Languages keeps its own scaffold when pushed from the study.
class _LanguagesPage extends StatelessWidget {
  const _LanguagesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.brand.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: context.brand.foreground,
        elevation: 0,
      ),
      body: const SafeArea(child: LanguagesScreen()),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ScriptCaption(caption, textAlign: TextAlign.start, fontSize: 24),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, this.caption, required this.children});

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
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: brand.foreground,
                      fontWeight: FontWeight.w700,
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

class _HairLine extends StatelessWidget {
  const _HairLine();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.brand.cardBorder.withValues(alpha: 0.45),
    );
  }
}

class _TextSizeControl extends StatelessWidget {
  const _TextSizeControl({required this.settings});

  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brand = context.brand;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.textSize, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 6),
          // The sample ignores the app-wide scaler so it can show the chosen
          // size directly, rather than the chosen size squared.
          MediaQuery.withNoTextScaling(
            child: Text(
              l10n.textSizeSample,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15 * settings.textScale,
                    color: brand.foregroundMuted,
                  ),
            ),
          ),
          Row(
            children: [
              Text(
                l10n.smaller,
                style: TextStyle(fontSize: 11, color: brand.foregroundMuted),
              ),
              Expanded(
                child: Slider(
                  value: settings.textScale,
                  min: kMinTextScale,
                  max: kMaxTextScale,
                  divisions: 6,
                  label: '${(settings.textScale * 100).round()}%',
                  onChanged: settings.setTextScale,
                ),
              ),
              Text(
                l10n.larger,
                style: TextStyle(fontSize: 15, color: brand.foregroundMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VoiceControl extends StatelessWidget {
  const _VoiceControl({required this.settings});

  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brand = context.brand;
    final speech = context.watch<SpeechController>();
    final voices = speech.voices ?? const <VoiceOption>[];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (voices.isEmpty)
            Text(
              l10n.noOtherVoices,
              style: TextStyle(color: brand.foregroundMuted),
            )
          else
            DropdownButtonFormField<String?>(
              initialValue: voices.any((v) => v.name == settings.voiceName)
                  ? settings.voiceName
                  : null,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.chooseVoice),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.voiceDefault)),
                for (final voice in voices)
                  DropdownMenuItem(
                    value: voice.name,
                    child: Text(voice.label, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (name) async {
                await settings.setVoiceName(name);
                await speech.applyPreferences(
                  voiceName: name,
                  rate: settings.speechRate,
                );
              },
            ),
          const SizedBox(height: 8),
          Text(l10n.speechPace, style: Theme.of(context).textTheme.bodyLarge),
          Row(
            children: [
              Text(
                l10n.slower,
                style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
              ),
              Expanded(
                child: Slider(
                  value: settings.speechRate,
                  min: kMinSpeechRate,
                  max: kMaxSpeechRate,
                  divisions: 10,
                  onChanged: (rate) async {
                    await settings.setSpeechRate(rate);
                    await speech.applyPreferences(
                      voiceName: settings.voiceName,
                      rate: rate,
                    );
                  },
                ),
              ),
              Text(
                l10n.faster,
                style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () => speech.speak('study-preview', kVoicePreview),
              icon: Icon(Icons.volume_up_outlined, color: brand.accentGold),
              label: Text(l10n.hearIt),
            ),
          ),
          _TranslationVoiceControl(settings: settings),
        ],
      ),
    );
  }
}

/// Offered only when the reader is not already in English and the device
/// actually has a voice for their language — most do not, for the smaller
/// languages in the catalog.
class _TranslationVoiceControl extends StatelessWidget {
  const _TranslationVoiceControl({required this.settings});

  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brand = context.brand;
    final speech = context.watch<SpeechController>();
    final devices = View.of(context).platformDispatcher.locales;
    final info = settings.catalog.infoFor(settings.localeIdFor(devices));

    if (info == null || info.translationKey == 'en') {
      return const SizedBox.shrink();
    }
    final tag = info.flutterLocale.toLanguageTag();

    return FutureBuilder<VoiceOption?>(
      future: speech.voiceForLanguage(tag),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        if (snapshot.data == null) {
          return Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              l10n.noVoiceInstalled(info.languageNameNative),
              style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
            ),
          );
        }
        return _SwitchRow(
          label: l10n.readExplanationsIn(info.languageNameNative),
          caption: l10n.readExplanationsCaption,
          value: settings.readTranslationAloud,
          onChanged: settings.setReadTranslationAloud,
        );
      },
    );
  }
}

class _ThemeControl extends StatelessWidget {
  const _ThemeControl({required this.settings});

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

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
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

class _LinkRow extends StatelessWidget {
  const _LinkRow({
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
