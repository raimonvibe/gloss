import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../branding.dart';
import '../data/word_repository.dart';
import '../l10n/app_localizations.dart';
import '../models/word_entry.dart';
import '../state/contact_letter.dart';
import '../state/settings_controller.dart';
import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/brand_colors.dart';
import '../theme/layout.dart';
import '../widgets/card_surface.dart';
import '../widgets/english_lemma.dart';
import '../widgets/ornament.dart';
import '../widgets/settings_section.dart';
import '../widgets/social_row.dart';
import '../widgets/theme_toggle.dart';

/// A letter to the maker, pushed from the study.
///
/// It keeps its own scaffold, and its own light switch: the study's is a
/// tab away, and this is the page where the two lights matter most — a
/// field's placeholder either shows itself on parchment and on candlelight
/// or it is not a placeholder, and the only way to know is to turn the page
/// over while looking at it.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key, this.onPost, this.onSend, this.onOpenLink});

  /// Injected by tests, so no test ever posts to the real form.
  final PostLetter? onPost;

  /// Injected by tests so no mail composer opens.
  final Future<bool> Function(Uri url)? onSend;

  /// Injected by tests so no browser opens.
  final Future<bool> Function(Uri url)? onOpenLink;

  @override
  Widget build(BuildContext context) {
    return PaperBackdrop(
      child: Stack(
        children: [
          const FlourishCorners(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: context.brand.foreground,
              elevation: 0,
              actions: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 12),
                  child: Center(child: ThemeToggle()),
                ),
              ],
            ),
            body: SafeArea(
              child: LayoutBoundary(
                child: ContactScreen(
                  onPost: onPost,
                  onSend: onSend,
                  onOpenLink: onOpenLink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    super.key,
    this.onPost,
    this.onSend,
    this.onOpenLink,
  });

  final PostLetter? onPost;
  final Future<bool> Function(Uri url)? onSend;
  final Future<bool> Function(Uri url)? onOpenLink;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

/// The question the human check asks, and the answer that ends it.
typedef _Riddle = ({WordEntry word, List<String> options, int correct});

class _ContactScreenState extends State<ContactScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _messageFocus = FocusNode();

  /// Which fields have been left once. A field is not wrong while it is
  /// still being typed into — an error that appears at the first letter of
  /// an address is an error the reader was always going to fix themselves.
  final _left = <String>{};

  /// Set the first time Send is pressed, after which every field says what
  /// it still needs.
  var _submitted = false;

  var _reason = ContactReason.question;
  var _priority = ContactPriority.normal;
  var _includeDetails = false;

  /// The letter that was waiting when the page opened.
  var _restored = false;

  /// Where the letter is between the reader pressing Send and the form
  /// answering. Only one of [_sent] and [_failed] is ever true.
  var _sending = false;
  var _sent = false;
  var _failed = false;

  _Riddle? _riddle;
  var _humanPassed = false;
  var _humanWrong = false;
  final _random = math.Random();

  late final SettingsController _settings;
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    _settings = context.read<SettingsController>();
    _restoreDraft();
    _riddle = _composeRiddle(context.read<WordRepository>().words);
    // A page with no lexicon behind it — a test, or a first run that failed
    // to load — has no riddle to ask, and must not become unsendable for it.
    _humanPassed = _riddle == null;

    for (final MapEntry(key: field, value: node) in {
      'name': _nameFocus,
      'email': _emailFocus,
      'message': _messageFocus,
    }.entries) {
      node.addListener(() {
        if (node.hasFocus) return;
        if (_left.add(field) && mounted) setState(() {});
        _saveDraft();
      });
    }

    for (final controller in [_name, _email, _message]) {
      controller.addListener(_onTyped);
    }
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    // Whatever is on the page when it closes is what should be here next
    // time, including the last keystroke the debounce had not reached yet.
    _saveDraft();
    for (final controller in [_name, _email, _message]) {
      controller
        ..removeListener(_onTyped)
        ..dispose();
    }
    _nameFocus.dispose();
    _emailFocus.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  void _restoreDraft() {
    final draft = ContactDraft.decode(_settings.contactDraft);
    if (draft == null || draft.isEmpty) return;
    _name.text = draft.name;
    _email.text = draft.email;
    _message.text = draft.message;
    _reason = draft.reason;
    _priority = draft.priority;
    _includeDetails = draft.includeDetails;
    _restored = true;
  }

  ContactDraft _draft() => ContactDraft(
        name: _name.text,
        email: _email.text,
        reason: _reason,
        priority: _priority,
        message: _message.text,
        includeDetails: _includeDetails,
      );

  /// Kept on a pause rather than on a keystroke: the store is a file, and a
  /// letter is written faster than a file wants to be rewritten.
  void _onTyped() {
    // A new letter is being written, so the last one's news is stale.
    setState(() {
      _sent = false;
      _failed = false;
    });
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 700), _saveDraft);
  }

  void _saveDraft() {
    final draft = _draft();
    if (draft.isEmpty) {
      _settings.clearContactDraft();
    } else {
      _settings.saveContactDraft(draft.encode());
    }
  }

  _Riddle? _composeRiddle(List<WordEntry> words) {
    final usable = words.where((w) => w.friendly.trim().isNotEmpty).toList();
    if (usable.length < 3) return null;
    usable.shuffle(_random);
    final subject = usable.first;
    final options = [
      subject.friendly,
      usable[1].friendly,
      usable[2].friendly,
    ]..shuffle(_random);
    return (
      word: subject,
      options: options,
      correct: options.indexOf(subject.friendly),
    );
  }

  bool _shows(String field) => _submitted || _left.contains(field);

  String? _nameError(AppLocalizations l10n) =>
      _shows('name') && _name.text.trim().isEmpty ? l10n.contactNeedName : null;

  String? _emailError(AppLocalizations l10n) =>
      _shows('email') && !looksLikeEmail(_email.text)
          ? l10n.contactNeedEmail
          : null;

  String? _messageError(AppLocalizations l10n) =>
      _shows('message') && _message.text.trim().isEmpty
          ? l10n.contactNeedMessage
          : null;

  bool get _complete =>
      _name.text.trim().isNotEmpty &&
      looksLikeEmail(_email.text) &&
      _message.text.trim().isNotEmpty;

  String _reasonLabel(AppLocalizations l10n, ContactReason reason) =>
      switch (reason) {
        ContactReason.word => l10n.reasonWord,
        ContactReason.problem => l10n.reasonProblem,
        ContactReason.question => l10n.reasonQuestion,
        ContactReason.praise => l10n.reasonPraise,
        ContactReason.other => l10n.reasonOther,
      };

  IconData _reasonIcon(ContactReason reason) => switch (reason) {
        ContactReason.word => Icons.auto_stories_outlined,
        ContactReason.problem => Icons.error_outline,
        ContactReason.question => Icons.help_outline,
        ContactReason.praise => Icons.favorite_border,
        ContactReason.other => Icons.more_horiz,
      };

  String _priorityLabel(AppLocalizations l10n, ContactPriority priority) =>
      switch (priority) {
        ContactPriority.low => l10n.priorityLow,
        ContactPriority.normal => l10n.priorityNormal,
        ContactPriority.high => l10n.priorityHigh,
      };

  /// One line about this Gloss, shown in full under the switch that adds it.
  /// Nothing is attached that the reader has not read first.
  String _details(BuildContext context) {
    final devices = View.of(context).platformDispatcher.locales;
    return appDetailsLine(
      version: Branding.version,
      localeId: _settings.localeIdFor(devices),
      theme: Theme.of(context).brightness == Brightness.dark
          ? 'candlelight'
          : 'parchment',
      textScalePercent: (_settings.textScale * 100).round(),
      platform: Theme.of(context).platform.name,
    );
  }

  String _letter(BuildContext context, AppLocalizations l10n) => composeLetter(
        name: _name.text,
        email: _email.text,
        reason: _reasonLabel(l10n, _reason),
        priority: _priorityLabel(l10n, _priority),
        message: _message.text,
        details: _includeDetails ? _details(context) : null,
      );

  /// The letter goes to the clipboard first and unconditionally, then to the
  /// form. A post can fail for a hundred reasons the reader cannot see, and
  /// none of them should cost them what they wrote.
  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    setState(() => _submitted = true);

    if (!_complete) {
      _focusFirstGap();
      return;
    }
    if (!_humanPassed) {
      setState(() => _humanWrong = true);
      messenger?.showSnackBar(SnackBar(content: Text(l10n.contactHumanRetry)));
      return;
    }

    // Everything the page can tell us is read before the first await: after
    // it, this state may no longer be on screen to ask.
    final devices = View.of(context).platformDispatcher.locales;
    final details = _includeDetails ? _details(context) : null;
    final body = _letter(context, l10n);

    await Clipboard.setData(ClipboardData(text: body));

    final fields = formspreeFields(
      name: _name.text,
      email: _email.text,
      reason: englishReason(_reason),
      priority: englishPriority(_priority),
      message: _message.text,
      language: _settings.localeIdFor(devices),
      details: details,
    );

    setState(() {
      _sending = true;
      _failed = false;
      _sent = false;
    });

    var posted = false;
    try {
      posted = await (widget.onPost ?? postLetter)(formspreeEndpoint, fields);
    } catch (_) {
      // No network, a refusal, a rate limit: the page does the same thing
      // about all of them, so they are the same answer here.
      posted = false;
    }

    if (!mounted) return;
    setState(() {
      _sending = false;
      _sent = posted;
      _failed = !posted;
    });

    if (posted) {
      // Sent is the one moment the draft has stopped being worth keeping.
      _clear();
      setState(() => _sent = true);
      messenger?.showSnackBar(SnackBar(content: Text(l10n.contactSent)));
    } else {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.contactSendFailed)),
      );
    }
  }

  /// The way out when the form will not take it: hand the same letter to
  /// whatever writes mail on this device, already addressed and filled in.
  Future<void> _sendByMail() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final body = _letter(context, l10n);
    await Clipboard.setData(ClipboardData(text: body));

    final open = widget.onSend ??
        (Uri url) => launchUrl(url, mode: LaunchMode.externalApplication);
    var opened = false;
    try {
      opened = await open(
        contactMailto(
          subject: '${Branding.storeName} — ${_reasonLabel(l10n, _reason)}',
          body: body,
        ),
      );
    } catch (_) {
      opened = false;
    }

    if (!mounted) return;
    messenger?.showSnackBar(
      SnackBar(
        content: Text(opened ? l10n.copiedToClipboard : l10n.contactNoMailApp),
      ),
    );
    // The draft stays: a composer that opened is not a letter that was sent.
  }

  void _focusFirstGap() {
    if (_name.text.trim().isEmpty) {
      _nameFocus.requestFocus();
    } else if (!looksLikeEmail(_email.text)) {
      _emailFocus.requestFocus();
    } else if (_message.text.trim().isEmpty) {
      _messageFocus.requestFocus();
    }
  }

  Future<void> _copy() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    await Clipboard.setData(ClipboardData(text: _letter(context, l10n)));
    if (!mounted) return;
    messenger?.showSnackBar(SnackBar(content: Text(l10n.copiedToClipboard)));
  }

  void _clear() {
    setState(() {
      _name.clear();
      _email.clear();
      _message.clear();
      _reason = ContactReason.question;
      _priority = ContactPriority.normal;
      _includeDetails = false;
      _submitted = false;
      _restored = false;
      _left.clear();
    });
    _saveTimer?.cancel();
    _settings.clearContactDraft();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brand = context.brand;
    final layout = context.layout;
    final suggestion = suggestEmailDomain(_email.text);

    return ListView(
      padding: layout.pagePadding(top: 8, bottom: 32),
      children: [
        Text(l10n.contactTitle, style: Theme.of(context).textTheme.headlineSmall),
        ScriptCaption(l10n.contactCaption, textAlign: TextAlign.start, fontSize: 26),
        const SizedBox(height: 12),
        CardSurface(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.drafts_outlined, color: brand.accentGold),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.contactBlurb,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: brand.foregroundMuted,
                      ),
                ),
              ),
            ],
          ),
        ),
        if (_restored) ...[
          const SizedBox(height: 10),
          _Note(icon: Icons.history_toggle_off, text: l10n.contactDraftRestored),
        ],
        const SizedBox(height: 14),
        SettingsSection(
          title: l10n.contactLetterSection,
          children: [
            _LetterField(
              label: l10n.contactName,
              hint: l10n.contactNameHint,
              controller: _name,
              focusNode: _nameFocus,
              error: _nameError(l10n),
              autofillHints: const [AutofillHints.name],
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _emailFocus.requestFocus(),
            ),
            const SettingsHairLine(),
            _LetterField(
              label: l10n.contactEmail,
              hint: l10n.contactEmailHint,
              controller: _email,
              focusNode: _emailFocus,
              error: _emailError(l10n),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _messageFocus.requestFocus(),
              // A dropped letter in a domain is the one mistake that loses
              // the reply without anyone noticing. Offered, never applied
              // on its own: plenty of real addresses sit one letter from a
              // common one.
              footer: suggestion == null
                  ? null
                  : _Suggestion(
                      label: l10n.contactEmailTypo(suggestion),
                      onTap: () {
                        _email.text = withEmailDomain(_email.text, suggestion);
                        _email.selection = TextSelection.collapsed(
                          offset: _email.text.length,
                        );
                      },
                    ),
            ),
            const SettingsHairLine(),
            _ReasonChips(
              label: l10n.contactReason,
              selected: _reason,
              labelOf: (reason) => _reasonLabel(l10n, reason),
              iconOf: _reasonIcon,
              onSelect: (reason) {
                setState(() => _reason = reason);
                _saveDraft();
              },
            ),
            const SettingsHairLine(),
            _PriorityControl(
              label: l10n.contactPriority,
              selected: _priority,
              labelOf: (priority) => _priorityLabel(l10n, priority),
              onSelect: (priority) {
                setState(() => _priority = priority);
                _saveDraft();
              },
            ),
            const SettingsHairLine(),
            _LetterField(
              label: l10n.contactMessage,
              hint: l10n.contactMessageHint,
              controller: _message,
              focusNode: _messageFocus,
              error: _messageError(l10n),
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              // Not a limit, a mirror: it counts up, and says nothing about
              // how long a letter ought to be.
              trailing: Text(
                '${_message.text.characters.length}',
                style: TextStyle(fontSize: 12, color: brand.foregroundMuted),
              ),
            ),
            const SettingsHairLine(),
            SettingsSwitchRow(
              label: l10n.contactDetails,
              caption: l10n.contactDetailsCaption,
              value: _includeDetails,
              onChanged: (value) {
                setState(() => _includeDetails = value);
                _saveDraft();
              },
            ),
            if (_includeDetails)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SelectableText(
                  _details(context),
                  style: AppFonts.cormorant(
                    fontSize: 13,
                    color: brand.foregroundMuted,
                  ),
                ),
              ),
          ],
        ),
        if (_riddle != null) ...[
          const SizedBox(height: 14),
          SettingsSection(
            title: l10n.contactHumanCheck,
            children: [
              _HumanCheck(
                riddle: _riddle!,
                passed: _humanPassed,
                wrong: _humanWrong,
                question: l10n.contactHumanQuestion(_riddle!.word.word),
                retry: l10n.contactHumanRetry,
                onAnswer: (index) {
                  setState(() {
                    if (index == _riddle!.correct) {
                      _humanPassed = true;
                      _humanWrong = false;
                    } else {
                      _humanWrong = true;
                      // A fresh word rather than a second go at the same
                      // three: this asks whether someone is reading, and a
                      // re-run of one question answers that by elimination.
                      _riddle =
                          _composeRiddle(context.read<WordRepository>().words);
                    }
                  });
                },
              ),
            ],
          ),
        ],
        if (_sent) ...[
          const SizedBox(height: 14),
          _Note(
            icon: Icons.mark_email_read_outlined,
            text: l10n.contactSent,
            tint: brand.correct,
          ),
        ],
        if (_failed) ...[
          const SizedBox(height: 14),
          _Note(
            icon: Icons.cloud_off_outlined,
            text: l10n.contactSendFailed,
            tint: brand.incorrect,
          ),
        ],
        const SizedBox(height: 18),
        _Actions(
          // Disabled only while the form is being asked, so a letter cannot
          // be sent twice by a second press on a slow connection.
          onSend: _sending ? null : _send,
          sending: _sending,
          onCopy: _message.text.trim().isEmpty ? null : _copy,
          onClear: _draft().isEmpty ? null : _clear,
          // Offered only once the form has refused it.
          onMail: _failed ? _sendByMail : null,
          sendLabel: l10n.contactSend,
          copyLabel: l10n.contactCopyLetter,
          clearLabel: l10n.clear,
          mailLabel: l10n.contactSendByMail,
        ),
        const DividerFlourish(),
        SettingsSection(
          title: l10n.lightSection,
          caption: l10n.lightCaption,
          children: [ThemeModeControl(settings: context.watch<SettingsController>())],
        ),
        const SizedBox(height: 20),
        ScriptCaption(l10n.followTheMaker, fontSize: 26),
        const SizedBox(height: 10),
        SocialRow(onOpen: widget.onOpenLink),
      ],
    );
  }
}

/// A labelled field, drawn so that its placeholder is legible on parchment
/// and on candlelight alike.
///
/// The app's own [InputDecorationTheme] has no border and a transparent
/// fill, which suits the one search box it was written for and leaves a
/// letter's fields as floating text. Everything here is set against that.
class _LetterField extends StatelessWidget {
  const _LetterField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.error,
    this.keyboardType,
    this.autofillHints,
    this.maxLines = 1,
    this.textInputAction,
    this.onSubmitted,
    this.trailing,
    this.footer,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? error;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final int maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? trailing;
  final Widget? footer;

  OutlineInputBorder _border(Color colour, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: colour, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    final dark = Theme.of(context).brightness == Brightness.dark;
    // The card is a warm cream on parchment and a dark plum on candlelight,
    // so a field sinks into it from opposite directions: a shade of the
    // page's own alt paper on one, a little of the deeper background on the
    // other. Either way the field reads as an inset rather than as a patch.
    final fill = dark
        ? brand.background.withValues(alpha: 0.55)
        : brand.backgroundAlt.withValues(alpha: 0.5);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            maxLines: maxLines,
            minLines: maxLines > 1 ? 4 : 1,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            cursorColor: brand.accentGold,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hint,
              hintMaxLines: hintLines(context),
              // Muted ink at full strength. The theme's own hint is that
              // colour at seven tenths, which reads as a smudge on parchment
              // and as nothing at all by candlelight.
              hintStyle: AppFonts.cormorant(
                fontSize: 16,
                color: brand.foregroundMuted,
              ),
              errorText: error,
              errorStyle: AppFonts.cormorant(
                fontSize: 13,
                color: brand.incorrect,
              ),
              filled: true,
              fillColor: fill,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              enabledBorder: _border(brand.cardBorder),
              focusedBorder: _border(brand.accentGold, width: 1.8),
              errorBorder: _border(brand.incorrect),
              focusedErrorBorder: _border(brand.incorrect, width: 1.8),
            ),
          ),
          if (footer != null) ...[
            const SizedBox(height: 8),
            footer!,
          ],
        ],
      ),
    );
  }
}

/// The tap that fixes a mistyped domain.
class _Suggestion extends StatelessWidget {
  const _Suggestion({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ActionChip(
        avatar: Icon(Icons.auto_fix_high, size: 16, color: brand.accentGold),
        label: Text(label),
        labelStyle: AppFonts.cormorant(fontSize: 14, color: brand.foreground),
        backgroundColor: brand.accentGold.withValues(alpha: 0.12),
        side: BorderSide(color: brand.accentGold.withValues(alpha: 0.55)),
        onPressed: onTap,
      ),
    );
  }
}

/// Why someone is writing, as chips rather than a dropdown: five short
/// answers are quicker to read at a glance than to open a menu for.
class _ReasonChips extends StatelessWidget {
  const _ReasonChips({
    required this.label,
    required this.selected,
    required this.labelOf,
    required this.iconOf,
    required this.onSelect,
  });

  final String label;
  final ContactReason selected;
  final String Function(ContactReason) labelOf;
  final IconData Function(ContactReason) iconOf;
  final ValueChanged<ContactReason> onSelect;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final reason in ContactReason.values)
                ChoiceChip(
                  selected: reason == selected,
                  onSelected: (_) => onSelect(reason),
                  showCheckmark: false,
                  avatar: Icon(
                    iconOf(reason),
                    size: 16,
                    color: reason == selected
                        ? brand.accentGold
                        : brand.foregroundMuted,
                  ),
                  label: Text(labelOf(reason)),
                  labelStyle: AppFonts.cormorant(
                    fontSize: 15,
                    fontWeight:
                        reason == selected ? FontWeight.w700 : FontWeight.w500,
                    color: reason == selected
                        ? brand.foreground
                        : brand.foregroundMuted,
                  ),
                  backgroundColor: Colors.transparent,
                  selectedColor: brand.accentGold.withValues(alpha: 0.16),
                  side: BorderSide(
                    color: reason == selected
                        ? brand.accentGold
                        : brand.cardBorder,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// How pressing it is — the website's three, worn as the study wears its
/// light switch.
class _PriorityControl extends StatelessWidget {
  const _PriorityControl({
    required this.label,
    required this.selected,
    required this.labelOf,
    required this.onSelect,
  });

  final String label;
  final ContactPriority selected;
  final String Function(ContactPriority) labelOf;
  final ValueChanged<ContactPriority> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ContactPriority>(
              key: ValueKey(Theme.of(context).brightness),
              style: SegmentedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              segments: [
                for (final priority in ContactPriority.values)
                  ButtonSegment(
                    value: priority,
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        labelOf(priority),
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ),
              ],
              selected: {selected},
              showSelectedIcon: false,
              onSelectionChanged: (values) => onSelect(values.first),
            ),
          ),
        ],
      ),
    );
  }
}

/// "I am not a robot", asked the way this app would ask it.
///
/// A checkbox proves nothing and a CAPTCHA proves it unkindly. A word from
/// the lexicon and three plain-words meanings proves the same thing and
/// leaves the reader having read something.
class _HumanCheck extends StatelessWidget {
  const _HumanCheck({
    required this.riddle,
    required this.passed,
    required this.wrong,
    required this.question,
    required this.retry,
    required this.onAnswer,
  });

  final _Riddle riddle;
  final bool passed;
  final bool wrong;
  final String question;
  final String retry;
  final ValueChanged<int> onAnswer;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    if (passed) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.verified_outlined, color: brand.correct),
        title: Text(
          riddle.word.friendly,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        // The lemma is English wherever the page is written, and stands
        // against the reading edge rather than the form's.
        subtitle: EnglishLemma(
          child: Text(
            riddle.word.word,
            style: TextStyle(color: brand.foregroundMuted),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: Theme.of(context).textTheme.bodyLarge),
          if (wrong) ...[
            const SizedBox(height: 4),
            Text(
              retry,
              style: TextStyle(fontSize: 13, color: brand.incorrect),
            ),
          ],
          const SizedBox(height: 10),
          for (var i = 0; i < riddle.options.length; i++) ...[
            CardSurface(
              onTap: () => onAnswer(i),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.circle_outlined,
                    size: 18,
                    color: brand.accentGold,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      riddle.options[i],
                      style: TextStyle(fontSize: 15, color: brand.foreground),
                    ),
                  ),
                ],
              ),
            ),
            if (i != riddle.options.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

/// Send, copy, clear — in that order, and wrapped, because three labels in
/// sixty languages do not fit one line of a phone.
class _Actions extends StatelessWidget {
  const _Actions({
    required this.onSend,
    required this.sending,
    required this.onCopy,
    required this.onClear,
    required this.onMail,
    required this.sendLabel,
    required this.copyLabel,
    required this.clearLabel,
    required this.mailLabel,
  });

  final VoidCallback? onSend;
  final bool sending;
  final VoidCallback? onCopy;
  final VoidCallback? onClear;
  final VoidCallback? onMail;
  final String sendLabel;
  final String copyLabel;
  final String clearLabel;
  final String mailLabel;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: onSend,
          icon: sending
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.send_outlined, size: 18),
          label: Text(sendLabel),
        ),
        if (onMail != null)
          OutlinedButton.icon(
            onPressed: onMail,
            icon: Icon(
              Icons.alternate_email,
              size: 18,
              color: brand.accentGold,
            ),
            label: Text(mailLabel),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: brand.cardBorder),
            ),
          ),
        OutlinedButton.icon(
          onPressed: onCopy,
          icon: Icon(Icons.copy_all_outlined, size: 18, color: brand.accentGold),
          label: Text(copyLabel),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: brand.cardBorder),
          ),
        ),
        TextButton(onPressed: onClear, child: Text(clearLabel)),
      ],
    );
  }
}

/// A quiet line of news — that a letter was waiting here, for instance.
class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.text, this.tint});

  final IconData icon;
  final String text;

  /// Gold unless the news has a colour of its own — a letter sent, or one
  /// the form would not take.
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Row(
      children: [
        Icon(icon, size: 18, color: tint ?? brand.accentGold),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppFonts.cormorant(
              fontSize: 14,
              color: brand.foregroundMuted,
            ),
          ),
        ),
      ],
    );
  }
}
