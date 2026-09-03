import 'app_localizations.dart';

/// The phrases a reading is built from.
///
/// A reading is the page read out, so where the page sets a heading over a
/// paragraph the voice says that heading. Three of them were missing: the
/// definition was read with nothing to introduce it, the sentence was
/// introduced as "Zoals in" where the page says "in een zin", and the
/// translated gloss under the sentence arrived with no heading at all — a
/// reader heard the English sentence, then a Dutch one, and was never told
/// the second was the first said again. A reader following along heard the
/// app announce a section that was not there and skip the ones that were.
///
/// All four headings are composed from the page's own strings rather than
/// from speech keys of their own. That is the point: they cannot drift from
/// what is written above the paragraph, and the sixty translations already
/// exist because the page needed them. It leaves `speechInPlainWords` and
/// `speechAsIn` unused in the ARBs — kept there, because taking a key out of
/// sixty files buys nothing.
class SpeechTemplates {
  const SpeechTemplates({
    required this.also,
    required this.fromOrigin,
    required this.rootMeaning,
    required this.inPlainWords,
    required this.theDefinition,
    required this.inASentence,
    required this.inOtherWords,
  });

  final String Function(String variants) also;
  final String Function(String origin, String originWord) fromOrigin;
  final String Function(String form, String meaning) rootMeaning;
  final String Function(String friendly) inPlainWords;
  final String Function(String definition) theDefinition;
  final String Function(String example) inASentence;
  final String Function(String gloss) inOtherWords;

  static final english = SpeechTemplates(
    also: (variants) => 'Also $variants.',
    fromOrigin: (origin, originWord) => 'From $origin, $originWord.',
    rootMeaning: (form, meaning) => '$form, meaning $meaning',
    // The English page's own headings, to the letter.
    inPlainWords: (friendly) => 'in plain words: $friendly',
    theDefinition: (definition) => 'the definition: $definition',
    inASentence: (example) => 'in a sentence: $example',
    // English is the source and carries no gloss, so this is here for
    // completeness and as the fallback shape.
    inOtherWords: (gloss) => 'in other words: $gloss',
  );

  factory SpeechTemplates.fromL10n(AppLocalizations l10n) {
    return SpeechTemplates(
      also: l10n.speechAlso,
      fromOrigin: l10n.speechFrom,
      rootMeaning: l10n.speechRoot,
      inPlainWords: (friendly) => '${l10n.inPlainWords}: $friendly',
      theDefinition: (definition) => '${l10n.theDefinition}: $definition',
      inASentence: (example) => '${l10n.inASentence}: $example',
      inOtherWords: (gloss) => '${l10n.exampleGlossLabel}: $gloss',
    );
  }
}
