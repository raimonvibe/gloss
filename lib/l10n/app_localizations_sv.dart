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
  String get navStudy => 'Studie';

  @override
  String get studyTitle => 'Studerkammaren';

  @override
  String get studyCaption => 'läsning, röst och ljus';

  @override
  String get readingSection => 'Läsning';

  @override
  String get readingCaption => 'hur sidan sitter';

  @override
  String get textSize => 'Textstorlek';

  @override
  String get textSizeSample => 'Edulcorate — att söta, att mildra.';

  @override
  String get smaller => 'Mindre';

  @override
  String get larger => 'Större';

  @override
  String get autoplayPronunciation => 'Läs ett ord högt när det öppnas';

  @override
  String get reduceMotion => 'Lugna utsmyckningen';

  @override
  String get reduceMotionCaption => 'färre krumelurer och toningar';

  @override
  String get voiceSection => 'Röst';

  @override
  String get voiceCaption => 'hur Gloss läser högt';

  @override
  String get chooseVoice => 'Röst';

  @override
  String get voiceDefault => 'Vald åt dig';

  @override
  String get noOtherVoices =>
      'Inga andra engelska röster är installerade på den här enheten.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Långsammare';

  @override
  String get faster => 'Snabbare';

  @override
  String get hearIt => 'Hör det';

  @override
  String get lightSection => 'Ljus';

  @override
  String get lightCaption => 'pergament eller levande ljus';

  @override
  String get themeSystem => 'Följ enheten';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Levande ljus';

  @override
  String get tongueSection => 'Tunga';

  @override
  String get aboutSection => 'Om';

  @override
  String get aboutCaption => 'hur det blev till';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licenser för öppen källkod';

  @override
  String get shareGloss => 'Dela Gloss';

  @override
  String get followTheMaker => 'Följ skaparen';

  @override
  String couldNotOpenLink(String label) {
    return 'Kunde inte öppna $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Läs förklaringar på $language';
  }

  @override
  String get readExplanationsCaption =>
      'Själva ordet läses alltid på engelska.';

  @override
  String noVoiceInstalled(String language) {
    return 'Den här enheten har ingen $language-röst installerad.';
  }

  @override
  String get memorySection => 'Minne';

  @override
  String get memoryCaption => 'vad Gloss behåller';

  @override
  String get forgetProgress => 'Glöm mina framsteg';

  @override
  String get forgetProgressBody =>
      'Orden du har utforskat förlorar sin markering. Dina sparade ord blir kvar.';

  @override
  String get clearSavedWords => 'Rensa sparade ord';

  @override
  String get clearSavedWordsBody =>
      'Orden du har sparat tas bort. Dina framsteg blir kvar.';

  @override
  String get cancel => 'Avbryt';

  @override
  String get forget => 'Glöm';

  @override
  String get clear => 'Rensa';

  @override
  String get progressForgotten => 'Framsteg glömda.';

  @override
  String get savedWordsCleared => 'Sparade ord rensade.';
}
