// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon lepega jezika';

  @override
  String get navHome => 'Domov';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kvizi';

  @override
  String get navSaved => 'Shranjeno';

  @override
  String get navLanguages => 'Jeziki';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count redkih, bogatih besed iz leksikona $lexicon — razloženih, kakor bi jih razložil prijatelj, ne slovar.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'raziskanih $current od $total besed';
  }

  @override
  String get exploreLexicon => 'Raziskuj leksikon';

  @override
  String get startQuiz => 'Začni kviz';

  @override
  String get wordOfTheDay => 'beseda dneva';

  @override
  String get readFullEntry => 'Preberi celoten vnos →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'zbirka';

  @override
  String get savedTitle => 'Shranjene besede';

  @override
  String get savedCaption => 'blizu srca';

  @override
  String get searchHint => 'Išči besedo ali opiši njen pomen…';

  @override
  String get clearSearch => 'Počisti iskanje';

  @override
  String get filterAll => 'Vse';

  @override
  String get noMatches => 'Še ni zadetkov — poskusi drugo besedo ali občutek.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n zadetkov',
      one: '1 zadetek',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'tu ni ničesar';

  @override
  String get emptyLexicon => 'V tem kotu leksikona ni ničesar.';

  @override
  String get emptySaved =>
      'Še ni shranjenih besed. Tapni srce pri katerem koli vnosu.';

  @override
  String get tapToReadMore => 'Tapni za nadaljnje branje';

  @override
  String get saveWord => 'Shrani besedo';

  @override
  String get removeFromFavorites => 'Odstrani iz priljubljenih';

  @override
  String get inPlainWords => 'preprostimi besedami';

  @override
  String get theDefinition => 'definicija';

  @override
  String get inASentence => 'v stavku';

  @override
  String get exampleGlossLabel => 'z drugimi besedami';

  @override
  String get save => 'Shrani';

  @override
  String get saved => 'Shranjeno';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copiedToClipboard => 'Kopirano na odložišče';

  @override
  String get roots => 'korenine';

  @override
  String get quizTitle => 'Majhen kviz';

  @override
  String get quizCaption => 'spoznaj korenine, nato izberi pomen';

  @override
  String get quizIntro =>
      'Vsako vprašanje pokaže besedo in njeno etimologijo. Izberi definicijo, ki se poda — štiri izbire, ena resnična.';

  @override
  String get howManyWords => 'koliko besed';

  @override
  String get begin => 'Začni';

  @override
  String get quizByTheme => 'Kviz po temi';

  @override
  String get endQuiz => 'Končaj kviz';

  @override
  String questionOf(int index, int length) {
    return 'Vprašanje $index od $length';
  }

  @override
  String get whichDefinitionFits => 'katera definicija se poda?';

  @override
  String get previous => 'Prejšnje';

  @override
  String get next => 'Naslednje';

  @override
  String get seeResults => 'Poglej rezultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'izberi predmet';

  @override
  String get noThemesYet => 'Še ni tem.';

  @override
  String get notEnoughWordsInTheme => 'V tej temi še ni dovolj besed.';

  @override
  String get results => 'Rezultati';

  @override
  String get perfectPage => 'popolna stran';

  @override
  String get wellMarked => 'lepo označeno';

  @override
  String get tryAnotherRound => 'Poskusi še en krog';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pravilnih definicij',
      one: '1 pravilna definicija',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pravilnih definicij od $total.',
      one: 'Ena pravilna definicija od $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Preklopi na svetli način';

  @override
  String get switchToDarkMode => 'Preklopi na temni način';

  @override
  String get listen => 'Poslušaj';

  @override
  String get stop => 'Ustavi';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jeziki';

  @override
  String get languagesCaption => 'jeziki';

  @override
  String get searchLanguages => 'Išči državo ali jezik…';

  @override
  String get noMatchingLanguages => 'Ni ujemajočih se držav ali jezikov.';

  @override
  String get selectedLanguage => 'Branje v';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azija';

  @override
  String get continentEurope => 'Evropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanija';

  @override
  String currentOfTotal(int current, int total) {
    return '$current od $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Tudi $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kot v: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Iz $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, pomen $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Preprostimi besedami: $friendly';
  }

  @override
  String get categorySpeech => 'Govor in retorika';

  @override
  String get categoryCharacter => 'Značaj in temperament';

  @override
  String get categoryCriticism => 'Kritika in žalitev';

  @override
  String get categoryVirtue => 'Krepost';

  @override
  String get categoryVice => 'Pregreha';

  @override
  String get categoryKnowledge => 'Znanje in misel';

  @override
  String get categoryReligion => 'Vera in duh';

  @override
  String get categoryBeginnings => 'Začetki';

  @override
  String get categoryConflict => 'Konflikt in prevara';

  @override
  String get categoryAppearance => 'Videz in svetloba';

  @override
  String get categoryPeople => 'Ljudje in vloge';

  @override
  String get categoryObjects => 'Predmeti in stvari';

  @override
  String get categoryEmotion => 'Čustvo';

  @override
  String get categoryArchaic => 'Staro in arhaično';

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
