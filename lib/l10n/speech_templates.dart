import 'app_localizations.dart';

class SpeechTemplates {
  const SpeechTemplates({
    required this.also,
    required this.asIn,
    required this.fromOrigin,
    required this.rootMeaning,
    required this.inPlainWords,
  });

  final String Function(String variants) also;
  final String Function(String example) asIn;
  final String Function(String origin, String originWord) fromOrigin;
  final String Function(String form, String meaning) rootMeaning;
  final String Function(String friendly) inPlainWords;

  static final english = SpeechTemplates(
    also: (variants) => 'Also $variants.',
    asIn: (example) => 'As in: $example',
    fromOrigin: (origin, originWord) => 'From $origin, $originWord.',
    rootMeaning: (form, meaning) => '$form, meaning $meaning',
    inPlainWords: (friendly) => 'In plain words: $friendly',
  );

  factory SpeechTemplates.fromL10n(AppLocalizations l10n) {
    return SpeechTemplates(
      also: l10n.speechAlso,
      asIn: l10n.speechAsIn,
      fromOrigin: l10n.speechFrom,
      rootMeaning: l10n.speechRoot,
      inPlainWords: l10n.speechInPlainWords,
    );
  }
}
