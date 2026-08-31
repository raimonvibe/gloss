import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/quiz_engine.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';
import '../l10n/speech_templates.dart';
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

/// The lemma in English, then the rest of the reading in the reader's
/// language — the shape every reading in the app takes.
///
/// [explanation] is the part that follows the word, already in the reader's
/// language; when it comes back empty (nothing translated for this entry)
/// the whole reading falls back to [english]. The English quoted inside it
/// is cut back out for the English voice.
///
/// One group across the lot, so a device with no voice for the language
/// reads the English once instead of a lemma followed by silence.
List<SpeechSegment> _lemmaThen(
  BuildContext context,
  WordEntry live, {
  required String Function(SpeechTemplates) explanation,
  required String english,
  required String group,
}) {
  final englishOnly = [SpeechSegment(english)];
  final tag = readerLanguageTag(context);
  if (tag == null) return englishOnly;

  final body =
      explanation(SpeechTemplates.fromL10n(AppLocalizations.of(context)));
  if (body.isEmpty) return englishOnly;

  return [
    SpeechSegment(live.spokenWord, group: group),
    ...segmentTranslation(
      body,
      languageTag: tag,
      englishTerms: live.quotedEnglish,
      // If the voice went missing since the switch was turned on, the
      // reader still hears the whole thing, in English.
      fallback: english,
      group: group,
    ),
  ];
}

/// The reading of one entry: the page, top to bottom, each piece in the
/// language it is written in.
///
/// The lemma and how to say it are English and always will be. Everything
/// after that — what kind of word it is, where it came from, what it is
/// built of, what it means, the sentence it lives in — follows the reader's
/// language when they have switched that on.
List<SpeechSegment> readingOf(BuildContext context, WordEntry live) {
  return _lemmaThen(
    context,
    live,
    explanation: live.spokenExplanationWith,
    english: live.english.spokenEntry,
    group: 'entry:${live.id}',
  );
}

/// The glance a card gives — the word of the day, a row in the lexicon, a
/// line in the quiz results.
///
/// Short where [readingOf] is long, and localised the same way: the lemma
/// and its respelling in English, what it means in the reader's language.
List<SpeechSegment> glanceOf(
  BuildContext context,
  WordEntry live, {
  required String group,
}) {
  return _lemmaThen(
    context,
    live,
    explanation: (_) => live.spokenGlanceExplanation,
    english: live.english.spokenGlance,
    group: group,
  );
}

/// The quiz's reading of the question in play: the lemma in English, then
/// its origin and roots, the question itself and the four answers — and
/// what the word means, once the answer is out — in the reader's language.
///
/// The answers are read because a listener cannot choose between four
/// definitions they have never heard.
List<SpeechSegment> quizReadingOf(
  BuildContext context,
  QuizQuestion question, {
  required bool revealed,
  required String group,
}) {
  final live = question.word;
  final l10n = AppLocalizations.of(context);
  return _lemmaThen(
    context,
    live,
    explanation: (templates) {
      final prompt = live.spokenQuizPromptWith(templates);
      if (prompt.isEmpty) return '';
      return [
        prompt,
        l10n.whichDefinitionFits,
        question.spokenOptions,
        if (revealed) live.spokenMeaningWith(templates),
      ].where((part) => part.isNotEmpty).join(' ');
    },
    english: [
      live.english.spokenPromptWith(SpeechTemplates.english),
      englishCopy.whichDefinitionFits,
      question.spokenOptionsEnglish,
      if (revealed)
        SpeechTemplates.english.inPlainWords(live.english.friendly),
    ].where((part) => part.isNotEmpty).join(' '),
    group: group,
  );
}
