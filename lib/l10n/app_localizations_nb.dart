// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'et leksikon av deilig språk';

  @override
  String get navHome => 'Hjem';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Lagret';

  @override
  String get navLanguages => 'Språk';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count sjeldne, rike ord fra $lexicon-leksikonet — forklart slik en venn ville forklart dem, ikke en ordbok.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current av $total ord utforsket';
  }

  @override
  String get exploreLexicon => 'Utforsk leksikonet';

  @override
  String get startQuiz => 'Start en quiz';

  @override
  String get wordOfTheDay => 'dagens ord';

  @override
  String get readFullEntry => 'Les hele oppslaget →';

  @override
  String get lexiconTitle => 'Leksikonet';

  @override
  String get lexiconCaption => 'samlingen';

  @override
  String get savedTitle => 'Lagrede ord';

  @override
  String get savedCaption => 'holdt nær';

  @override
  String get searchHint => 'Søk etter et ord, eller beskriv betydningen…';

  @override
  String get clearSearch => 'Tøm søk';

  @override
  String get filterAll => 'Alle';

  @override
  String get noMatches =>
      'Ingen treff ennå — prøv et annet ord eller en annen følelse.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treff',
      one: '1 treff',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ingenting her';

  @override
  String get emptyLexicon => 'Ingenting i denne kroken av leksikonet.';

  @override
  String get emptySaved =>
      'Ingen lagrede ord ennå. Trykk på hjertet ved et oppslag.';

  @override
  String get tapToReadMore => 'Trykk for å lese mer';

  @override
  String get saveWord => 'Lagre ord';

  @override
  String get removeFromFavorites => 'Fjern fra favoritter';

  @override
  String get inPlainWords => 'med enkle ord';

  @override
  String get theDefinition => 'definisjonen';

  @override
  String get inASentence => 'i en setning';

  @override
  String get exampleGlossLabel => 'med andre ord';

  @override
  String get save => 'Lagre';

  @override
  String get saved => 'Lagret';

  @override
  String get copy => 'Kopier';

  @override
  String get copiedToClipboard => 'Kopiert til utklippstavlen';

  @override
  String get roots => 'røtter';

  @override
  String get quizTitle => 'En liten quiz';

  @override
  String get quizCaption => 'kjenn røttene, velg så betydningen';

  @override
  String get quizIntro =>
      'Hvert spørsmål viser et ord og etymologien. Velg definisjonen som passer — fire valg, ett sant.';

  @override
  String get howManyWords => 'hvor mange ord';

  @override
  String get begin => 'Begynn';

  @override
  String get quizByTheme => 'Quiz etter tema';

  @override
  String get endQuiz => 'Avslutt quiz';

  @override
  String questionOf(int index, int length) {
    return 'Spørsmål $index av $length';
  }

  @override
  String get whichDefinitionFits => 'hvilken definisjon passer?';

  @override
  String get previous => 'Forrige';

  @override
  String get next => 'Neste';

  @override
  String get seeResults => 'Se resultater';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'velg et emne';

  @override
  String get noThemesYet => 'Ingen temaer ennå.';

  @override
  String get notEnoughWordsInTheme => 'Ikke nok ord i dette temaet ennå.';

  @override
  String get results => 'Resultater';

  @override
  String get perfectPage => 'en feilfri side';

  @override
  String get wellMarked => 'fint merket';

  @override
  String get tryAnotherRound => 'Prøv en runde til';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score riktige definisjoner',
      one: '1 riktig definisjon',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score riktige definisjoner, av $total.',
      one: 'Én riktig definisjon, av $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Bytt til lyst modus';

  @override
  String get switchToDarkMode => 'Bytt til mørkt modus';

  @override
  String get listen => 'Lytt';

  @override
  String get stop => 'Stopp';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Språk';

  @override
  String get languagesCaption => 'tungene';

  @override
  String get searchLanguages => 'Søk etter et land eller språk…';

  @override
  String get noMatchingLanguages => 'Ingen samsvarende land eller språk.';

  @override
  String get selectedLanguage => 'Leser på';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oseania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current av $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Også $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Som i: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Fra $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betydning $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Med enkle ord: $friendly';
  }

  @override
  String get categorySpeech => 'Tale og retorikk';

  @override
  String get categoryCharacter => 'Karakter og temperament';

  @override
  String get categoryCriticism => 'Kritikk og fornærmelse';

  @override
  String get categoryVirtue => 'Dyd';

  @override
  String get categoryVice => 'Last';

  @override
  String get categoryKnowledge => 'Kunnskap og tanke';

  @override
  String get categoryReligion => 'Religion og ånd';

  @override
  String get categoryBeginnings => 'Begynnelser';

  @override
  String get categoryConflict => 'Konflikt og bedrag';

  @override
  String get categoryAppearance => 'Utseende og lys';

  @override
  String get categoryPeople => 'Mennesker og roller';

  @override
  String get categoryObjects => 'Gjenstander og ting';

  @override
  String get categoryEmotion => 'Følelse';

  @override
  String get categoryArchaic => 'Gammelt og arkaisk';

  @override
  String get navStudy => 'Studie';

  @override
  String get studyTitle => 'Arbeidsrommet';

  @override
  String get studyCaption => 'lesing, stemme og lys';

  @override
  String get readingSection => 'Lesing';

  @override
  String get readingCaption => 'hvordan siden sitter';

  @override
  String get textSize => 'Tekststørrelse';

  @override
  String get textSizeSample => 'Edulcorate — å søte, å mildne.';

  @override
  String get smaller => 'Mindre';

  @override
  String get larger => 'Større';

  @override
  String get autoplayPronunciation => 'Les et ord høyt når det åpnes';

  @override
  String get reduceMotion => 'Demp utsmykningen';

  @override
  String get reduceMotionCaption => 'færre kruseduller og fargeoverganger';

  @override
  String get voiceSection => 'Stemme';

  @override
  String get voiceCaption => 'hvordan Gloss leser høyt';

  @override
  String get chooseVoice => 'Stemme';

  @override
  String get voiceDefault => 'Valgt for deg';

  @override
  String get noOtherVoices =>
      'Ingen andre engelske stemmer er installert på denne enheten.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Saktere';

  @override
  String get faster => 'Raskere';

  @override
  String get hearIt => 'Hør det';

  @override
  String get lightSection => 'Lys';

  @override
  String get lightCaption => 'pergament eller levende lys';

  @override
  String get themeSystem => 'Følg enheten';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Levende lys';

  @override
  String get tongueSection => 'Tunge';

  @override
  String get aboutSection => 'Om';

  @override
  String get aboutCaption => 'hvordan det ble til';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Åpen kildekode-lisenser';

  @override
  String get shareGloss => 'Del Gloss';

  @override
  String get followTheMaker => 'Følg skaperen';

  @override
  String couldNotOpenLink(String label) {
    return 'Kunne ikke åpne $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Les forklaringer på $language';
  }

  @override
  String get readExplanationsCaption => 'Selve ordet leses alltid på engelsk.';

  @override
  String noVoiceInstalled(String language) {
    return 'Denne enheten har ingen $language-stemme installert.';
  }
}
