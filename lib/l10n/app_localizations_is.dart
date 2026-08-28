// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'lexikon fallegs máls';

  @override
  String get navHome => 'Heim';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Próf';

  @override
  String get navSaved => 'Vistað';

  @override
  String get navLanguages => 'Tungumál';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count sjaldgæf, rík orð úr $lexicon-lexikoninu — skýrð eins og vinur myndi skýra þau, ekki orðabók.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current af $total orðum könnuð';
  }

  @override
  String get exploreLexicon => 'Kanna lexikonið';

  @override
  String get startQuiz => 'Byrja próf';

  @override
  String get wordOfTheDay => 'orð dagsins';

  @override
  String get readFullEntry => 'Lesa alla færsluna →';

  @override
  String get lexiconTitle => 'Lexikonið';

  @override
  String get lexiconCaption => 'safnið';

  @override
  String get savedTitle => 'Vistuð orð';

  @override
  String get savedCaption => 'haldið nálægt';

  @override
  String get searchHint => 'Leitaðu að orði, eða lýstu merkingunni…';

  @override
  String get clearSearch => 'Hreinsa leit';

  @override
  String get filterAll => 'Allt';

  @override
  String get noMatches =>
      'Engar samsvaranir enn — prófaðu annað orð eða tilfinningu.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n samsvaranir',
      one: '1 samsvörun',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ekkert hér';

  @override
  String get emptyLexicon => 'Ekkert í þessu horni lexikonsins.';

  @override
  String get emptySaved => 'Engin vistuð orð enn. Ýttu á hjartað við færslu.';

  @override
  String get tapToReadMore => 'Ýttu til að lesa meira';

  @override
  String get saveWord => 'Vista orð';

  @override
  String get removeFromFavorites => 'Fjarlægja úr eftirlæti';

  @override
  String get inPlainWords => 'með einföldum orðum';

  @override
  String get theDefinition => 'skilgreiningin';

  @override
  String get inASentence => 'í setningu';

  @override
  String get exampleGlossLabel => 'með öðrum orðum';

  @override
  String get save => 'Vista';

  @override
  String get saved => 'Vistað';

  @override
  String get copy => 'Afrita';

  @override
  String get copiedToClipboard => 'Afritað á klemmuspjald';

  @override
  String get roots => 'rætur';

  @override
  String get quizTitle => 'Lítið próf';

  @override
  String get quizCaption => 'þekktu ræturnar, veldu svo merkinguna';

  @override
  String get quizIntro =>
      'Hver spurning sýnir orð og uppruna þess. Veldu skilgreininguna sem passar — fjórir kostir, einn sannur.';

  @override
  String get howManyWords => 'hversu mörg orð';

  @override
  String get begin => 'Byrja';

  @override
  String get quizByTheme => 'Próf eftir þema';

  @override
  String get endQuiz => 'Ljúka prófi';

  @override
  String questionOf(int index, int length) {
    return 'Spurning $index af $length';
  }

  @override
  String get whichDefinitionFits => 'hvaða skilgreining passar?';

  @override
  String get previous => 'Fyrri';

  @override
  String get next => 'Næsta';

  @override
  String get seeResults => 'Sjá niðurstöður';

  @override
  String get themeTitle => 'Þema';

  @override
  String get chooseASubject => 'veldu efni';

  @override
  String get noThemesYet => 'Engin þemu enn.';

  @override
  String get notEnoughWordsInTheme => 'Ekki nóg af orðum í þessu þema enn.';

  @override
  String get results => 'Niðurstöður';

  @override
  String get perfectPage => 'fullkomin síða';

  @override
  String get wellMarked => 'fallega merkt';

  @override
  String get tryAnotherRound => 'Prófaðu aðra umferð';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score réttar skilgreiningar',
      one: '1 rétt skilgreining',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score réttar skilgreiningar, af $total.',
      one: 'Ein rétt skilgreining, af $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Skipta yfir í ljóst þema';

  @override
  String get switchToDarkMode => 'Skipta yfir í dökkt þema';

  @override
  String get listen => 'Hlusta';

  @override
  String get stop => 'Stöðva';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Tungumál';

  @override
  String get languagesCaption => 'tungurnar';

  @override
  String get searchLanguages => 'Leitaðu að landi eða tungumáli…';

  @override
  String get noMatchingLanguages => 'Engin samsvarandi lönd eða tungumál.';

  @override
  String get selectedLanguage => 'Lesið á';

  @override
  String get continentAfrica => 'Afríka';

  @override
  String get continentAsia => 'Asía';

  @override
  String get continentEurope => 'Evrópa';

  @override
  String get continentAmericas => 'Ameríka';

  @override
  String get continentOceania => 'Eyjaálfa';

  @override
  String currentOfTotal(int current, int total) {
    return '$current af $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Einnig $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Eins og í: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Úr $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, merking $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Með einföldum orðum: $friendly';
  }

  @override
  String get categorySpeech => 'Tal og mælskulist';

  @override
  String get categoryCharacter => 'Lyndi og skapgerð';

  @override
  String get categoryCriticism => 'Gagnrýni og móðgun';

  @override
  String get categoryVirtue => 'Dygð';

  @override
  String get categoryVice => 'Löstur';

  @override
  String get categoryKnowledge => 'Þekking og hugsun';

  @override
  String get categoryReligion => 'Trú og andi';

  @override
  String get categoryBeginnings => 'Upphaf';

  @override
  String get categoryConflict => 'Átök og svik';

  @override
  String get categoryAppearance => 'Útlit og ljós';

  @override
  String get categoryPeople => 'Fólk og hlutverk';

  @override
  String get categoryObjects => 'Hlutir og greinir';

  @override
  String get categoryEmotion => 'Tilfinning';

  @override
  String get categoryArchaic => 'Gamalt og fornt';

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
