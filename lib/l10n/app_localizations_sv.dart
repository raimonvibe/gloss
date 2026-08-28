// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ett lexikon av ljuvligt språk';

  @override
  String get navHome => 'Hem';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Sparat';

  @override
  String get navLanguages => 'Språk';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count sällsynta, rika ord ur $lexicon-lexikonet — förklarade som en vän skulle göra det, inte en ordbok.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current av $total ord utforskade';
  }

  @override
  String get exploreLexicon => 'Utforska lexikonet';

  @override
  String get startQuiz => 'Starta ett quiz';

  @override
  String get wordOfTheDay => 'dagens ord';

  @override
  String get readFullEntry => 'Läs hela uppslaget →';

  @override
  String get lexiconTitle => 'Lexikonet';

  @override
  String get lexiconCaption => 'samlingen';

  @override
  String get savedTitle => 'Sparade ord';

  @override
  String get savedCaption => 'hållna nära';

  @override
  String get searchHint => 'Sök ett ord, eller beskriv dess betydelse…';

  @override
  String get clearSearch => 'Rensa sökning';

  @override
  String get filterAll => 'Alla';

  @override
  String get noMatches =>
      'Inga träffar än — prova ett annat ord eller en annan känsla.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n träffar',
      one: '1 träff',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ingenting här';

  @override
  String get emptyLexicon => 'Ingenting i den här vrån av lexikonet.';

  @override
  String get emptySaved =>
      'Inga sparade ord än. Tryck på hjärtat vid ett uppslag.';

  @override
  String get tapToReadMore => 'Tryck för att läsa mer';

  @override
  String get saveWord => 'Spara ord';

  @override
  String get removeFromFavorites => 'Ta bort från favoriter';

  @override
  String get inPlainWords => 'med enkla ord';

  @override
  String get theDefinition => 'definitionen';

  @override
  String get inASentence => 'i en mening';

  @override
  String get exampleGlossLabel => 'med andra ord';

  @override
  String get save => 'Spara';

  @override
  String get saved => 'Sparat';

  @override
  String get copy => 'Kopiera';

  @override
  String get copiedToClipboard => 'Kopierat till urklipp';

  @override
  String get roots => 'rötter';

  @override
  String get quizTitle => 'Ett litet quiz';

  @override
  String get quizCaption => 'känn rötterna, välj sedan betydelsen';

  @override
  String get quizIntro =>
      'Varje fråga visar ett ord och dess etymologi. Välj definitionen som passar — fyra val, ett sant.';

  @override
  String get howManyWords => 'hur många ord';

  @override
  String get begin => 'Börja';

  @override
  String get quizByTheme => 'Quiz efter tema';

  @override
  String get endQuiz => 'Avsluta quiz';

  @override
  String questionOf(int index, int length) {
    return 'Fråga $index av $length';
  }

  @override
  String get whichDefinitionFits => 'vilken definition passar?';

  @override
  String get previous => 'Föregående';

  @override
  String get next => 'Nästa';

  @override
  String get seeResults => 'Se resultat';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'välj ett ämne';

  @override
  String get noThemesYet => 'Inga teman än.';

  @override
  String get notEnoughWordsInTheme =>
      'Inte tillräckligt med ord i det här temat än.';

  @override
  String get results => 'Resultat';

  @override
  String get perfectPage => 'en fulländad sida';

  @override
  String get wellMarked => 'fint märkt';

  @override
  String get tryAnotherRound => 'Prova en runda till';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score rätta definitioner',
      one: '1 rätt definition',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score rätta definitioner, av $total.',
      one: 'En rätt definition, av $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Byt till ljust läge';

  @override
  String get switchToDarkMode => 'Byt till mörkt läge';

  @override
  String get listen => 'Lyssna';

  @override
  String get stop => 'Stoppa';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Språk';

  @override
  String get languagesCaption => 'tungorna';

  @override
  String get searchLanguages => 'Sök ett land eller språk…';

  @override
  String get noMatchingLanguages => 'Inga matchande länder eller språk.';

  @override
  String get selectedLanguage => 'Läser på';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asien';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanien';

  @override
  String currentOfTotal(int current, int total) {
    return '$current av $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Också $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Som i: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Från $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betydelse $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Med enkla ord: $friendly';
  }

  @override
  String get categorySpeech => 'Tal och retorik';

  @override
  String get categoryCharacter => 'Karaktär och temperament';

  @override
  String get categoryCriticism => 'Kritik och skymf';

  @override
  String get categoryVirtue => 'Dygd';

  @override
  String get categoryVice => 'Last';

  @override
  String get categoryKnowledge => 'Kunskap och tanke';

  @override
  String get categoryReligion => 'Religion och ande';

  @override
  String get categoryBeginnings => 'Början';

  @override
  String get categoryConflict => 'Konflikt och svek';

  @override
  String get categoryAppearance => 'Utseende och ljus';

  @override
  String get categoryPeople => 'Människor och roller';

  @override
  String get categoryObjects => 'Föremål och ting';

  @override
  String get categoryEmotion => 'Känsla';

  @override
  String get categoryArchaic => 'Gammalt och arkaiskt';

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
