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
  String get navStudy => 'Kabinet';

  @override
  String get studyTitle => 'Kabinet';

  @override
  String get studyCaption => 'lugemine, hääl ja valgus';

  @override
  String get readingSection => 'Lugemine';

  @override
  String get readingCaption => 'kuidas lehekülg istub';

  @override
  String get textSize => 'Teksti suurus';

  @override
  String get textSizeSample => 'Edulcorate — magustada, pehmendada.';

  @override
  String get smaller => 'Väiksem';

  @override
  String get larger => 'Suurem';

  @override
  String get autoplayPronunciation => 'Loe sõna avamisel valjusti';

  @override
  String get reduceMotion => 'Rahusta ehteid';

  @override
  String get reduceMotionCaption => 'vähem keerdkäike ja üleminekuid';

  @override
  String get voiceSection => 'Hääl';

  @override
  String get voiceCaption => 'kuidas Gloss valjusti loeb';

  @override
  String get chooseVoice => 'Hääl';

  @override
  String get voiceDefault => 'Sinu jaoks valitud';

  @override
  String get noOtherVoices =>
      'Sellesse seadmesse pole paigaldatud teisi ingliskeelseid hääli.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Aeglasemalt';

  @override
  String get faster => 'Kiiremini';

  @override
  String get hearIt => 'Kuula';

  @override
  String get lightSection => 'Valgus';

  @override
  String get lightCaption => 'pärgament või küünlavalgus';

  @override
  String get themeSystem => 'Nagu seadmes';

  @override
  String get themeLight => 'Pärgament';

  @override
  String get themeDark => 'Küünlavalgus';

  @override
  String get tongueSection => 'Keel';

  @override
  String get aboutSection => 'Teave';

  @override
  String get aboutCaption => 'kuidas see valmis';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Avatud lähtekoodi litsentsid';

  @override
  String get shareGloss => 'Jaga Glossi';

  @override
  String get followTheMaker => 'Jälgi autorit';

  @override
  String couldNotOpenLink(String label) {
    return '$label avamine ebaõnnestus.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Loe selgitusi keeles $language';
  }

  @override
  String get readExplanationsCaption =>
      'Sõna ise loetakse alati inglise keeles.';

  @override
  String noVoiceInstalled(String language) {
    return 'Sellel seadmel pole $language häält paigaldatud.';
  }

  @override
  String get memorySection => 'Mälu';

  @override
  String get memoryCaption => 'mida Gloss hoiab';

  @override
  String get forgetProgress => 'Unusta mu edenemine';

  @override
  String get forgetProgressBody =>
      'Uuritud sõnadelt eemaldatakse märge. Sinu salvestatud sõnad jäävad.';

  @override
  String get clearSavedWords => 'Tühjenda salvestatud sõnad';

  @override
  String get clearSavedWordsBody =>
      'Sõnad, mille oled hoidnud, eemaldatakse. Sinu edenemine jääb.';

  @override
  String get cancel => 'Loobu';

  @override
  String get forget => 'Unusta';

  @override
  String get clear => 'Tühjenda';

  @override
  String get progressForgotten => 'Edenemine unustatud.';

  @override
  String get savedWordsCleared => 'Salvestatud sõnad tühjendatud.';
}
