// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'një leksikon i gjuhës së bukur';

  @override
  String get navHome => 'Kreu';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kuiz';

  @override
  String get navSaved => 'Të ruajtura';

  @override
  String get navLanguages => 'Gjuhë';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count fjalë të rralla e të pasura nga leksikoni $lexicon — shpjeguar siç do t’i shpjegonte një mik, jo një fjalor.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current nga $total fjalë të eksploruara';
  }

  @override
  String get exploreLexicon => 'Eksploro leksikonin';

  @override
  String get startQuiz => 'Fillo një kuiz';

  @override
  String get wordOfTheDay => 'fjala e ditës';

  @override
  String get readFullEntry => 'Lexo zërin e plotë →';

  @override
  String get lexiconTitle => 'Leksikoni';

  @override
  String get lexiconCaption => 'mbledhja';

  @override
  String get savedTitle => 'Fjalë të ruajtura';

  @override
  String get savedCaption => 'mbajtur afër';

  @override
  String get searchHint => 'Kërko një fjalë, ose përshkruaj kuptimin…';

  @override
  String get clearSearch => 'Pastro kërkimin';

  @override
  String get filterAll => 'Të gjitha';

  @override
  String get noMatches =>
      'Nuk ka ende përputhje — provo një fjalë a ndjesi tjetër.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n përputhje',
      one: '1 përputhje',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'asgjë këtu';

  @override
  String get emptyLexicon => 'Asgjë në këtë cep të leksikonit.';

  @override
  String get emptySaved =>
      'Nuk ka ende fjalë të ruajtura. Prek zemrën në çdo zë.';

  @override
  String get tapToReadMore => 'Prek për të lexuar më shumë';

  @override
  String get saveWord => 'Ruaj fjalën';

  @override
  String get removeFromFavorites => 'Hiq nga të preferuarat';

  @override
  String get inPlainWords => 'me fjalë të thjeshta';

  @override
  String get theDefinition => 'përkufizimi';

  @override
  String get inASentence => 'në një fjali';

  @override
  String get exampleGlossLabel => 'ndryshe thënë';

  @override
  String get save => 'Ruaj';

  @override
  String get saved => 'Ruajtur';

  @override
  String get copy => 'Kopjo';

  @override
  String get copiedToClipboard => 'U kopjua në kujtesë';

  @override
  String get roots => 'rrënjë';

  @override
  String get quizTitle => 'Një kuiz i vogël';

  @override
  String get quizCaption => 'njihi rrënjët, pastaj zgjidh kuptimin';

  @override
  String get quizIntro =>
      'Çdo pyetje tregon një fjalë dhe etimologjinë e saj. Zgjidh përkufizimin që i shkon — katër zgjedhje, një e vërtetë.';

  @override
  String get howManyWords => 'sa fjalë';

  @override
  String get begin => 'Fillo';

  @override
  String get quizByTheme => 'Kuiz sipas temës';

  @override
  String get endQuiz => 'Mbaro kuizin';

  @override
  String questionOf(int index, int length) {
    return 'Pyetja $index nga $length';
  }

  @override
  String get whichDefinitionFits => 'cila përkufizim i shkon?';

  @override
  String get previous => 'E mëparshme';

  @override
  String get next => 'E radhës';

  @override
  String get seeResults => 'Shiko rezultatet';

  @override
  String get themeTitle => 'Temë';

  @override
  String get chooseASubject => 'zgjidh një lëndë';

  @override
  String get noThemesYet => 'Nuk ka ende tema.';

  @override
  String get notEnoughWordsInTheme => 'Nuk ka ende mjaft fjalë në këtë temë.';

  @override
  String get results => 'Rezultatet';

  @override
  String get perfectPage => 'një faqe e përkryer';

  @override
  String get wellMarked => 'shënuar bukur';

  @override
  String get tryAnotherRound => 'Provo një raund tjetër';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score përkufizime të sakta',
      one: '1 përkufizim i saktë',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score përkufizime të sakta, nga $total.',
      one: 'Një përkufizim i saktë, nga $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Kalo te mënyra e ndritshme';

  @override
  String get switchToDarkMode => 'Kalo te mënyra e errët';

  @override
  String get listen => 'Dëgjo';

  @override
  String get stop => 'Ndalo';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Gjuhë';

  @override
  String get languagesCaption => 'gjuhët';

  @override
  String get searchLanguages => 'Kërko një vend ose gjuhë…';

  @override
  String get noMatchingLanguages => 'Nuk ka vende ose gjuhë përputhëse.';

  @override
  String get selectedLanguage => 'Duke lexuar në';

  @override
  String get continentAfrica => 'Afrikë';

  @override
  String get continentAsia => 'Azi';

  @override
  String get continentEurope => 'Europë';

  @override
  String get continentAmericas => 'Amerikë';

  @override
  String get continentOceania => 'Oqeani';

  @override
  String currentOfTotal(int current, int total) {
    return '$current nga $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Gjithashtu $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Si në: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Nga $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, kuptim $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Me fjalë të thjeshta: $friendly';
  }

  @override
  String get categorySpeech => 'Fjalë dhe retorikë';

  @override
  String get categoryCharacter => 'Karakter dhe temperament';

  @override
  String get categoryCriticism => 'Kritikë dhe fyerje';

  @override
  String get categoryVirtue => 'Virtyt';

  @override
  String get categoryVice => 'Ves';

  @override
  String get categoryKnowledge => 'Dije dhe mendim';

  @override
  String get categoryReligion => 'Fe dhe shpirt';

  @override
  String get categoryBeginnings => 'Fillime';

  @override
  String get categoryConflict => 'Përplasje dhe mashtrim';

  @override
  String get categoryAppearance => 'Pamje dhe dritë';

  @override
  String get categoryPeople => 'Njerëz dhe role';

  @override
  String get categoryObjects => 'Sendet dhe gjërat';

  @override
  String get categoryEmotion => 'Emocion';

  @override
  String get categoryArchaic => 'I vjetër dhe arkaik';

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
