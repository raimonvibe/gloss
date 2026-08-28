// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'lexikon krásné řeči';

  @override
  String get navHome => 'Domů';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Kvíz';

  @override
  String get navSaved => 'Uložené';

  @override
  String get navLanguages => 'Jazyky';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count vzácných, bohatých slov z lexikonu $lexicon — vysvětlených tak, jak by je vyložil přítel, ne slovník.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'prozkoumáno $current z $total slov';
  }

  @override
  String get exploreLexicon => 'Prozkoumat lexikon';

  @override
  String get startQuiz => 'Začít kvíz';

  @override
  String get wordOfTheDay => 'slovo dne';

  @override
  String get readFullEntry => 'Číst celý záznam →';

  @override
  String get lexiconTitle => 'Lexikon';

  @override
  String get lexiconCaption => 'sbírka';

  @override
  String get savedTitle => 'Uložená slova';

  @override
  String get savedCaption => 'poblíž srdce';

  @override
  String get searchHint => 'Hledej slovo, nebo popiš jeho význam…';

  @override
  String get clearSearch => 'Vymazat hledání';

  @override
  String get filterAll => 'Vše';

  @override
  String get noMatches => 'Zatím žádné shody — zkus jiné slovo nebo pocit.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n shod',
      one: '1 shoda',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nic tu není';

  @override
  String get emptyLexicon => 'V tomto koutě lexikonu nic není.';

  @override
  String get emptySaved =>
      'Zatím žádná uložená slova. Klepni na srdce u kteréhokoli záznamu.';

  @override
  String get tapToReadMore => 'Klepni pro další čtení';

  @override
  String get saveWord => 'Uložit slovo';

  @override
  String get removeFromFavorites => 'Odebrat z oblíbených';

  @override
  String get inPlainWords => 'prostými slovy';

  @override
  String get theDefinition => 'definice';

  @override
  String get inASentence => 've větě';

  @override
  String get exampleGlossLabel => 'jinými slovy';

  @override
  String get save => 'Uložit';

  @override
  String get saved => 'Uloženo';

  @override
  String get copy => 'Kopírovat';

  @override
  String get copiedToClipboard => 'Zkopírováno do schránky';

  @override
  String get roots => 'kořeny';

  @override
  String get quizTitle => 'Malý kvíz';

  @override
  String get quizCaption => 'poznej kořeny, pak vyber význam';

  @override
  String get quizIntro =>
      'Každá otázka ukáže slovo a jeho etymologii. Vyber definici, která sedí — čtyři volby, jedna pravdivá.';

  @override
  String get howManyWords => 'kolik slov';

  @override
  String get begin => 'Začít';

  @override
  String get quizByTheme => 'Kvíz podle tématu';

  @override
  String get endQuiz => 'Ukončit kvíz';

  @override
  String questionOf(int index, int length) {
    return 'Otázka $index z $length';
  }

  @override
  String get whichDefinitionFits => 'která definice sedí?';

  @override
  String get previous => 'Předchozí';

  @override
  String get next => 'Další';

  @override
  String get seeResults => 'Zobrazit výsledky';

  @override
  String get themeTitle => 'Téma';

  @override
  String get chooseASubject => 'vyber předmět';

  @override
  String get noThemesYet => 'Zatím žádná témata.';

  @override
  String get notEnoughWordsInTheme => 'V tomto tématu zatím není dost slov.';

  @override
  String get results => 'Výsledky';

  @override
  String get perfectPage => 'dokonalá stránka';

  @override
  String get wellMarked => 'pěkně označeno';

  @override
  String get tryAnotherRound => 'Zkus další kolo';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správných definic',
      one: '1 správná definice',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správných definic z $total.',
      one: 'Jedna správná definice z $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Přepnout na světlý režim';

  @override
  String get switchToDarkMode => 'Přepnout na tmavý režim';

  @override
  String get listen => 'Poslouchat';

  @override
  String get stop => 'Zastavit';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jazyky';

  @override
  String get languagesCaption => 'jazyky';

  @override
  String get searchLanguages => 'Hledej zemi nebo jazyk…';

  @override
  String get noMatchingLanguages => 'Žádné odpovídající země ani jazyky.';

  @override
  String get selectedLanguage => 'Čtení v jazyce';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asie';

  @override
  String get continentEurope => 'Evropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceánie';

  @override
  String currentOfTotal(int current, int total) {
    return '$current z $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Také $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Jako v: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Z $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, význam $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Prostými slovy: $friendly';
  }

  @override
  String get categorySpeech => 'Řeč a rétorika';

  @override
  String get categoryCharacter => 'Povaha a temperament';

  @override
  String get categoryCriticism => 'Kritika a urážka';

  @override
  String get categoryVirtue => 'Ctnost';

  @override
  String get categoryVice => 'Neřest';

  @override
  String get categoryKnowledge => 'Vědění a myšlení';

  @override
  String get categoryReligion => 'Náboženství a duch';

  @override
  String get categoryBeginnings => 'Počátky';

  @override
  String get categoryConflict => 'Konflikt a klam';

  @override
  String get categoryAppearance => 'Vzhled a světlo';

  @override
  String get categoryPeople => 'Lidé a role';

  @override
  String get categoryObjects => 'Předměty a věci';

  @override
  String get categoryEmotion => 'Emoce';

  @override
  String get categoryArchaic => 'Staré a archaické';

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
