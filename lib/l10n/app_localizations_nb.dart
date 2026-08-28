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
  String get navStudy => 'Study';

  @override
  String get studyTitle => 'The study';

  @override
  String get studyCaption => 'reading, voice, and light';

  @override
  String get readingSection => 'Reading';

  @override
  String get readingCaption => 'how the page sits';

  @override
  String get textSize => 'Text size';

  @override
  String get textSizeSample => 'Edulcorate — to sweeten, to soften.';

  @override
  String get smaller => 'Smaller';

  @override
  String get larger => 'Larger';

  @override
  String get autoplayPronunciation => 'Read a word aloud when it opens';

  @override
  String get reduceMotion => 'Calm the ornaments';

  @override
  String get reduceMotionCaption => 'fewer flourishes and gradients';

  @override
  String get voiceSection => 'Voice';

  @override
  String get voiceCaption => 'how Gloss reads aloud';

  @override
  String get chooseVoice => 'Voice';

  @override
  String get voiceDefault => 'Chosen for you';

  @override
  String get noOtherVoices =>
      'No other English voices are installed on this device.';

  @override
  String get speechPace => 'Pace';

  @override
  String get slower => 'Slower';

  @override
  String get faster => 'Faster';

  @override
  String get hearIt => 'Hear it';

  @override
  String get lightSection => 'Light';

  @override
  String get lightCaption => 'parchment or candlelight';

  @override
  String get themeSystem => 'Match device';

  @override
  String get themeLight => 'Parchment';

  @override
  String get themeDark => 'Candlelight';

  @override
  String get tongueSection => 'Tongue';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutCaption => 'the making of it';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open-source licences';

  @override
  String get shareGloss => 'Share Gloss';

  @override
  String get followTheMaker => 'Follow the maker';

  @override
  String couldNotOpenLink(String label) {
    return 'Could not open $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Read explanations in $language';
  }

  @override
  String get readExplanationsCaption =>
      'The word itself is always read in English.';

  @override
  String noVoiceInstalled(String language) {
    return 'This device has no $language voice installed.';
  }
}
