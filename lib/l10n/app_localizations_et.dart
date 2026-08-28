// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'kauni keele leksikon';

  @override
  String get navHome => 'Kodu';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Viktoriin';

  @override
  String get navSaved => 'Salvestatud';

  @override
  String get navLanguages => 'Keeled';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count haruldast, rikkalikku sõna $lexicon-leksikonist — seletatud nii, nagu sõber seletaks, mitte sõnaraamat.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'uuritud $current / $total sõna';
  }

  @override
  String get exploreLexicon => 'Uuri leksikoni';

  @override
  String get startQuiz => 'Alusta viktoriini';

  @override
  String get wordOfTheDay => 'päeva sõna';

  @override
  String get readFullEntry => 'Loe kogu kirjet →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'kogu';

  @override
  String get savedTitle => 'Salvestatud sõnad';

  @override
  String get savedCaption => 'südame lähedal';

  @override
  String get searchHint => 'Otsi sõna või kirjelda selle tähendust…';

  @override
  String get clearSearch => 'Tühjenda otsing';

  @override
  String get filterAll => 'Kõik';

  @override
  String get noMatches => 'Vastuseid veel pole — proovi teist sõna või tunnet.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n vastet',
      one: '1 vaste',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'siin pole midagi';

  @override
  String get emptyLexicon => 'Selles leksikoni nurgas pole midagi.';

  @override
  String get emptySaved =>
      'Salvestatud sõnu veel pole. Puuduta südameikooni mis tahes kirjel.';

  @override
  String get tapToReadMore => 'Puuduta, et lugeda edasi';

  @override
  String get saveWord => 'Salvesta sõna';

  @override
  String get removeFromFavorites => 'Eemalda lemmikutest';

  @override
  String get inPlainWords => 'lihtsate sõnadega';

  @override
  String get theDefinition => 'definitsioon';

  @override
  String get inASentence => 'lauses';

  @override
  String get exampleGlossLabel => 'teisisõnu';

  @override
  String get save => 'Salvesta';

  @override
  String get saved => 'Salvestatud';

  @override
  String get copy => 'Kopeeri';

  @override
  String get copiedToClipboard => 'Kopeeritud lõikelauale';

  @override
  String get roots => 'juured';

  @override
  String get quizTitle => 'Väike viktoriin';

  @override
  String get quizCaption => 'tunne juuri, siis vali tähendus';

  @override
  String get quizIntro =>
      'Iga küsimus näitab sõna ja selle etümoloogiat. Vali definitsioon, mis sobib — neli valikut, üks tõene.';

  @override
  String get howManyWords => 'mitu sõna';

  @override
  String get begin => 'Alusta';

  @override
  String get quizByTheme => 'Viktoriin teema järgi';

  @override
  String get endQuiz => 'Lõpeta viktoriin';

  @override
  String questionOf(int index, int length) {
    return 'Küsimus $index / $length';
  }

  @override
  String get whichDefinitionFits => 'milline definitsioon sobib?';

  @override
  String get previous => 'Eelmine';

  @override
  String get next => 'Järgmine';

  @override
  String get seeResults => 'Vaata tulemusi';

  @override
  String get themeTitle => 'Teema';

  @override
  String get chooseASubject => 'vali aine';

  @override
  String get noThemesYet => 'Teemasid veel pole.';

  @override
  String get notEnoughWordsInTheme => 'Selles teemas pole veel piisavalt sõnu.';

  @override
  String get results => 'Tulemused';

  @override
  String get perfectPage => 'täiuslik lehekülg';

  @override
  String get wellMarked => 'kenasti märgitud';

  @override
  String get tryAnotherRound => 'Proovi veel üks voor';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score õiget definitsiooni',
      one: '1 õige definitsioon',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score õiget definitsiooni, $total seast.',
      one: 'Üks õige definitsioon, $total seast.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Lülitu heledale režiimile';

  @override
  String get switchToDarkMode => 'Lülitu tumedale režiimile';

  @override
  String get listen => 'Kuula';

  @override
  String get stop => 'Peata';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Keeled';

  @override
  String get languagesCaption => 'keeled';

  @override
  String get searchLanguages => 'Otsi maad või keelt…';

  @override
  String get noMatchingLanguages => 'Vastavaid maid ega keeli pole.';

  @override
  String get selectedLanguage => 'Lugemine keeles';

  @override
  String get continentAfrica => 'Aafrika';

  @override
  String get continentAsia => 'Aasia';

  @override
  String get continentEurope => 'Euroopa';

  @override
  String get continentAmericas => 'Ameerika';

  @override
  String get continentOceania => 'Okeaania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Samuti $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Nagu: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin keelest, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, tähendus $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Lihtsate sõnadega: $friendly';
  }

  @override
  String get categorySpeech => 'Kõne ja retoorika';

  @override
  String get categoryCharacter => 'Iseloom ja temperament';

  @override
  String get categoryCriticism => 'Kriitika ja solvang';

  @override
  String get categoryVirtue => 'Voorus';

  @override
  String get categoryVice => 'Pahe';

  @override
  String get categoryKnowledge => 'Teadmine ja mõte';

  @override
  String get categoryReligion => 'Usk ja vaim';

  @override
  String get categoryBeginnings => 'Algused';

  @override
  String get categoryConflict => 'Konflikt ja pettus';

  @override
  String get categoryAppearance => 'Välimus ja valgus';

  @override
  String get categoryPeople => 'Inimesed ja rollid';

  @override
  String get categoryObjects => 'Esemed ja asjad';

  @override
  String get categoryEmotion => 'Emotsioon';

  @override
  String get categoryArchaic => 'Vana ja arhailine';

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
}
