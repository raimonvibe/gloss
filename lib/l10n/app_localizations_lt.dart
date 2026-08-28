// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'gražios kalbos leksikonas';

  @override
  String get navHome => 'Pradžia';

  @override
  String get navLexicon => 'Leksikonas';

  @override
  String get navQuiz => 'Viktorina';

  @override
  String get navSaved => 'Išsaugota';

  @override
  String get navLanguages => 'Kalbos';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count retų, turtingų žodžių iš $lexicon leksikono — paaiškintų taip, kaip paaiškintų draugas, ne žodynas.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'tyrinėta $current iš $total žodžių';
  }

  @override
  String get exploreLexicon => 'Tyrinėti leksikoną';

  @override
  String get startQuiz => 'Pradėti viktoriną';

  @override
  String get wordOfTheDay => 'dienos žodis';

  @override
  String get readFullEntry => 'Skaityti visą įrašą →';

  @override
  String get lexiconTitle => 'Leksikonas';

  @override
  String get lexiconCaption => 'rinkinys';

  @override
  String get savedTitle => 'Išsaugoti žodžiai';

  @override
  String get savedCaption => 'laikomi arti';

  @override
  String get searchHint => 'Ieškokite žodžio arba apibūdinkite jo prasmę…';

  @override
  String get clearSearch => 'Išvalyti paiešką';

  @override
  String get filterAll => 'Visi';

  @override
  String get noMatches =>
      'Kol kas nėra atitikmenų — pabandykite kitą žodį ar jausmą.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n atitikmenys',
      one: '1 atitikmuo',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'čia nieko nėra';

  @override
  String get emptyLexicon => 'Šiame leksikono kampe nieko nėra.';

  @override
  String get emptySaved =>
      'Dar nėra išsaugotų žodžių. Palieskite širdelę bet kuriame įraše.';

  @override
  String get tapToReadMore => 'Palieskite, kad skaitytumėte toliau';

  @override
  String get saveWord => 'Išsaugoti žodį';

  @override
  String get removeFromFavorites => 'Pašalinti iš mėgstamų';

  @override
  String get inPlainWords => 'paprastais žodžiais';

  @override
  String get theDefinition => 'apibrėžimas';

  @override
  String get inASentence => 'sakinyje';

  @override
  String get exampleGlossLabel => 'kitaip tariant';

  @override
  String get save => 'Išsaugoti';

  @override
  String get saved => 'Išsaugota';

  @override
  String get copy => 'Kopijuoti';

  @override
  String get copiedToClipboard => 'Nukopijuota į iškarpinę';

  @override
  String get roots => 'šaknys';

  @override
  String get quizTitle => 'Maža viktorina';

  @override
  String get quizCaption => 'pažinkite šaknis, tada rinkitės prasmę';

  @override
  String get quizIntro =>
      'Kiekvienas klausimas rodo žodį ir jo etimologiją. Pasirinkite tinkančią apibrėžtį — keturi pasirinkimai, vienas teisingas.';

  @override
  String get howManyWords => 'kiek žodžių';

  @override
  String get begin => 'Pradėti';

  @override
  String get quizByTheme => 'Viktorina pagal temą';

  @override
  String get endQuiz => 'Baigti viktoriną';

  @override
  String questionOf(int index, int length) {
    return 'Klausimas $index iš $length';
  }

  @override
  String get whichDefinitionFits => 'kuri apibrėžtis tinka?';

  @override
  String get previous => 'Ankstesnis';

  @override
  String get next => 'Kitas';

  @override
  String get seeResults => 'Žiūrėti rezultatus';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'pasirinkite dalyką';

  @override
  String get noThemesYet => 'Temų dar nėra.';

  @override
  String get notEnoughWordsInTheme => 'Šioje temoje dar nepakanka žodžių.';

  @override
  String get results => 'Rezultatai';

  @override
  String get perfectPage => 'tobula pusė';

  @override
  String get wellMarked => 'gražiai pažymėta';

  @override
  String get tryAnotherRound => 'Bandykite dar vieną ratą';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score teisingos apibrėžtys',
      one: '1 teisinga apibrėžtis',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score teisingos apibrėžtys iš $total.',
      one: 'Viena teisinga apibrėžtis iš $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Perjungti į šviesųjį režimą';

  @override
  String get switchToDarkMode => 'Perjungti į tamsųjį režimą';

  @override
  String get listen => 'Klausyti';

  @override
  String get stop => 'Stabdyti';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Kalbos';

  @override
  String get languagesCaption => 'kalbos';

  @override
  String get searchLanguages => 'Ieškokite šalies ar kalbos…';

  @override
  String get noMatchingLanguages => 'Nėra atitinkančių šalių ar kalbų.';

  @override
  String get selectedLanguage => 'Skaitymas';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azija';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Okeanija';

  @override
  String currentOfTotal(int current, int total) {
    return '$current iš $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Taip pat $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kaip: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Iš $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, reikšmė $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Paprastais žodžiais: $friendly';
  }

  @override
  String get categorySpeech => 'Kalba ir retorika';

  @override
  String get categoryCharacter => 'Būdas ir temperamentas';

  @override
  String get categoryCriticism => 'Kritika ir įžeidimas';

  @override
  String get categoryVirtue => 'Dorybė';

  @override
  String get categoryVice => 'Yda';

  @override
  String get categoryKnowledge => 'Žinios ir mintis';

  @override
  String get categoryReligion => 'Religija ir dvasia';

  @override
  String get categoryBeginnings => 'Pradžios';

  @override
  String get categoryConflict => 'Konfliktas ir apgaulė';

  @override
  String get categoryAppearance => 'Išvaizda ir šviesa';

  @override
  String get categoryPeople => 'Žmonės ir vaidmenys';

  @override
  String get categoryObjects => 'Daiktai ir dalykai';

  @override
  String get categoryEmotion => 'Emocija';

  @override
  String get categoryArchaic => 'Sena ir archajiška';

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
