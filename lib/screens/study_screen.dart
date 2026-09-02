import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../branding.dart';
import '../l10n/app_localizations.dart';
import '../data/word_repository.dart';
import '../state/progress_controller.dart';
import '../state/reading.dart';
import '../state/settings_controller.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/card_surface.dart';
import '../widgets/settings_section.dart';
import '../widgets/social_row.dart';
import 'contact_screen.dart';
import 'languages_screen.dart';

/// The entry the voice preview reads.
///
/// A real one, so the preview is the thing itself rather than a description
/// of it — and so it can be read in both voices, the way every other page
/// reads a word.
const kPreviewWordId = 'edulcorate';

/// Spoken when the reader tries a voice and the lexicon is not there to read
/// from — a fallback, and English, because it is written here rather than
/// translated. See `_VoiceControl._preview`, which prefers the real entry.
const kVoicePreview = 'Edulcorate. To sweeten, or to soften.';

/// What the reader hands on when they share the app.
///
/// The link sits last and alone on its line: that is the part a messaging app
/// lifts out for its preview card, and the part someone can tap. It is the
/// same link that goes to the clipboard, so the two can never disagree.
String shareMessage(String tagline) =>
    '${Branding.storeName} — $tagline\n${Branding.storeUrl}';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key, this.onShare, this.onShareText});

  /// Injected by tests so no browser opens. Carries the maker's links.
  final Future<bool> Function(Uri url)? onShare;

  /// Injected by tests so no share sheet opens.
  final Future<bool> Function(String message)? onShareText;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  /// Anchors the iPad share popover to the row that was tapped.
  final _shareRowKey = GlobalKey();

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
    final layout = context.layout;

    return ListView(
      padding: layout.pagePadding(top: 16, bottom: 32),
      children: [
        _Header(title: l10n.studyTitle, caption: l10n.studyCaption),
        const SizedBox(height: 16),
        SettingsSection(
          title: l10n.readingSection,
          caption: l10n.readingCaption,
          children: [
            _TextSizeControl(settings: settings),
            const SettingsHairLine(),
            SettingsSwitchRow(
              label: l10n.autoplayPronunciation,
              value: settings.autoplayPronunciation,
              onChanged: settings.setAutoplayPronunciation,
            ),
            const SettingsHairLine(),
            SettingsSwitchRow(
              label: l10n.reduceMotion,
              caption: l10n.reduceMotionCaption,
              value: settings.reduceMotion,
              onChanged: settings.setReduceMotion,
            ),
          ],
        ),
        const SizedBox(height: 14),
        SettingsSection(
          title: l10n.voiceSection,
          caption: l10n.voiceCaption,
          children: [_VoiceControl(settings: settings)],
        ),
        const SizedBox(height: 14),
        SettingsSection(
          title: l10n.lightSection,
          caption: l10n.lightCaption,
          children: [ThemeModeControl(settings: settings)],
        ),
        const SizedBox(height: 14),
        SettingsSection(
          title: l10n.tongueSection,
          children: [
            SettingsLinkRow(
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
        SettingsSection(
          title: l10n.memorySection,
          caption: l10n.memoryCaption,
          children: [
            SettingsLinkRow(
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
            const SettingsHairLine(),
            SettingsLinkRow(
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
        SettingsSection(
          title: l10n.aboutSection,
          caption: l10n.aboutCaption,
          children: [
            SettingsLinkRow(
              icon: Icons.info_outline,
              label: l10n.versionLine(Branding.version),
            ),
            const SettingsHairLine(),
            SettingsLinkRow(
              icon: Icons.article_outlined,
              label: l10n.openLicences,
              onTap: () => showLicensePage(
                context: context,
                applicationName: Branding.displayName,
                applicationVersion: Branding.version,
              ),
            ),
            const SettingsHairLine(),
            SettingsLinkRow(
              key: _shareRowKey,
              icon: Icons.ios_share,
              label: l10n.shareGloss,
              onTap: () => _share(context),
            ),
            const SettingsHairLine(),
            // The website has a contact page; the app had a row of brand
            // marks and nothing to write on. This is that page, in the one
            // place a reader already goes looking for the app itself.
            SettingsLinkRow(
              icon: Icons.mail_outline,
              label: l10n.contactTitle,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ContactPage(onOpenLink: widget.onShare),
                ),
              ),
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

  /// Hand the app on, rather than walking the reader to the shop.
  ///
  /// Sharing used to open the store listing itself, which sent the reader
  /// away to a page about an app they already have. What they wanted was the
  /// link, to give to somebody else. So: copy it, then offer the sheet.
  Future<void> _share(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final l10n = AppLocalizations.of(context);

    // The clipboard first, and unconditionally. Whatever becomes of the sheet
    // - dismissed, or an app that keeps the text and drops the link - the
    // reader is left holding the thing they asked for.
    await Clipboard.setData(const ClipboardData(text: Branding.storeUrl));

    final share = widget.onShareText ?? _openShareSheet;
    try {
      await share(shareMessage(l10n.tagline));
    } catch (_) {
      // A sheet that will not open earns no error of its own. The promise
      // this row makes is the copy above, and that has already been kept;
      // 'could not open Gloss' would be a lie told over a full clipboard.
    }
    if (!context.mounted) return;
    messenger?.showSnackBar(SnackBar(content: Text(l10n.copiedToClipboard)));
  }

  Future<bool> _openShareSheet(String message) async {
    final result = await SharePlus.instance.share(
      ShareParams(
        text: message,
        subject: Branding.storeName,
        // iPad and macOS anchor the popover here. Without a rect it lands in
        // the middle of the screen, pointing at nothing.
        sharePositionOrigin: _shareRowRect(),
      ),
    );
    return result.status == ShareResultStatus.success;
  }

  Rect? _shareRowRect() {
    final box = _shareRowKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
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
      body: const SafeArea(
        child: LayoutBoundary(child: LanguagesScreen()),
      ),
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

  /// The preview reads the way an entry reads: the lemma in English, the
  /// rest in whatever language the reader has asked for.
  ///
  /// Locked to English it could say that the engine works, but not whether
  /// the reader's own voice does — which is the one thing the switch under
  /// it turns on.
  void _preview(BuildContext context, SpeechController speech) {
    final matches = context
        .read<WordRepository>()
        .words
        .where((word) => word.id == kPreviewWordId);
    if (matches.isEmpty) {
      speech.speak('study-preview', kVoicePreview);
      return;
    }
    speech.speakSegments(
      'study-preview',
      glanceOf(context, matches.first, group: 'study-preview'),
    );
  }

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
              onPressed: () => _preview(context, speech),
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
class _TranslationVoiceControl extends StatefulWidget {
  const _TranslationVoiceControl({required this.settings});

  final SettingsController settings;

  @override
  State<_TranslationVoiceControl> createState() =>
      _TranslationVoiceControlState();
}

class _TranslationVoiceControlState extends State<_TranslationVoiceControl> {
  Future<VoiceOption?>? _voice;
  String? _asked;
  List<VoiceOption>? _knownVoices;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brand = context.brand;
    final speech = context.watch<SpeechController>();
    final devices = View.of(context).platformDispatcher.locales;
    final settings = widget.settings;
    final info = settings.catalog.infoFor(settings.localeIdFor(devices));

    if (info == null || info.translationKey == 'en') {
      return const SizedBox.shrink();
    }
    final tag = info.flutterLocale.toLanguageTag();

    // The engine is asked once per language, and again only when it reports
    // a new list of voices.
    //
    // Handing `future:` a call made here in build asks again on every
    // rebuild, and until each new answer arrives this row is nothing at all —
    // so the row vanished and the whole page below it jumped up, then
    // dropped back. Changing the light rebuilds the page, which is why the
    // settings hopped whenever the reader switched parchment to candlelight.
    if (tag != _asked || !identical(speech.voices, _knownVoices)) {
      _asked = tag;
      _knownVoices = speech.voices;
      _voice = speech.voiceForLanguage(tag);
    }

    return FutureBuilder<VoiceOption?>(
      future: _voice,
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
        return SettingsSwitchRow(
          label: l10n.readExplanationsIn(info.languageNameNative),
          caption: l10n.readExplanationsCaption,
          value: settings.readTranslationAloud,
          onChanged: settings.setReadTranslationAloud,
        );
      },
    );
  }
}

