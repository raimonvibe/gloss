import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';
import '../models/word_entry.dart';
import 'settings_controller.dart';
import 'speech_controller.dart';

/// Who reads what, in one place.
///
/// Gloss speaks two languages and must never confuse them. English text in a
/// Dutch voice and Dutch text in an English voice are the same bug wearing
/// different clothes, and both are easy to write by accident: a screen only
/// has to hand [SpeakButton] a string that came out of `l10n`.
///
/// Everything that reads aloud goes through here.

/// The app's own copy in English, whatever the reader has chosen.
///
/// The English-locked voice has to be given English words. The generated
/// localisations already hold them, so nothing is written twice.
final AppLocalizations englishCopy = AppLocalizationsEn();

/// The language the reader asked to be read to in, or null for English.
///
/// Null when the switch in the study is off, when the reader is already
/// reading English, or when the catalog has no locale to speak.
String? readerLanguageTag(BuildContext context) {
  final settings = context.read<SettingsController>();
  if (!settings.readTranslationAloud) return null;
  final info = settings.catalog.infoFor(
    settings.localeIdFor(View.of(context).platformDispatcher.locales),
  );
  if (info == null || info.translationKey == 'en') return null;
  return info.flutterLocale.toLanguageTag();
}

/// One line of the app's own words — a score, a heading, a summary.
///
/// Spoken in the reader's language when they asked for that and the device
/// can manage it, and in English otherwise. What it never does is hand
/// [localized] to the English voice, which is what gives a Dutch sentence an
/// English accent.
List<SpeechSegment> spokenLine(
  BuildContext context, {
  required String localized,
  required String english,
  Object? group,
}) {
  final tag = readerLanguageTag(context);
  if (tag == null) return [SpeechSegment(english)];
  return [
    SpeechSegment(
      localized,
      languageTag: tag,
      fallback: english,
      group: group ?? localized,
    ),
  ];
}

/// The reading of one entry: the lemma is always English, the explanation
/// follows the reader's language only when they have switched it on in the
/// study, and the engine drops that half if the device has no voice for it.
List<SpeechSegment> readingOf(BuildContext context, WordEntry live) {
  final englishOnly = [SpeechSegment(live.spokenEntry)];
  final tag = readerLanguageTag(context);
  if (tag == null) return englishOnly;

  final explanation = live.spokenExplanation;
  if (explanation.isEmpty) return englishOnly;

  // The English half shrinks to what only exists in English, so the two
  // readings do not say the same thing twice. The explanation follows in
  // the reader's language — cut at whatever English it quotes, so a Dutch
  // voice never has to read an English sentence.
  return [
    SpeechSegment(live.spokenLemma),
    ...segmentTranslation(
      explanation,
      languageTag: tag,
      englishTerms: live.quotedEnglish,
      // If the voice went missing since the switch was turned on, the
      // reader still hears the explanation, in English.
      fallback: live.english.spokenExplanationFallback,
      group: 'explanation:${live.id}',
    ),
  ];
}
