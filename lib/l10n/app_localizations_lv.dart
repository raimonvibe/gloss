// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'skaistas valodas leksikons';

  @override
  String get navHome => 'Sākums';

  @override
  String get navLexicon => 'Leksikons';

  @override
  String get navQuiz => 'Viktorīna';

  @override
  String get navSaved => 'Saglabātais';

  @override
  String get navLanguages => 'Valodas';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count reti, bagāti vārdi no $lexicon leksikona — izskaidroti tā, kā to darītu draugs, ne vārdnīca.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'izpētīti $current no $total vārdiem';
  }

  @override
  String get exploreLexicon => 'Izpētīt leksikonu';

  @override
  String get startQuiz => 'Sākt viktorīnu';

  @override
  String get wordOfTheDay => 'dienas vārds';

  @override
  String get readFullEntry => 'Lasīt visu šķirkli →';

  @override
  String get lexiconTitle => 'Leksikons';

  @override
  String get lexiconCaption => 'krājums';

  @override
  String get savedTitle => 'Saglabātie vārdi';

  @override
  String get savedCaption => 'turēti tuvu';

  @override
  String get searchHint => 'Meklējiet vārdu vai aprakstiet tā nozīmi…';

  @override
  String get clearSearch => 'Notīrīt meklēšanu';

  @override
  String get filterAll => 'Visi';

  @override
  String get noMatches =>
      'Vēl nav atbilstību — mēģiniet citu vārdu vai sajūtu.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n atbilstības',
      one: '1 atbilstība',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'šeit nekā nav';

  @override
  String get emptyLexicon => 'Šajā leksikona stūrī nekā nav.';

  @override
  String get emptySaved =>
      'Vēl nav saglabātu vārdu. Pieskarieties sirdij pie jebkura šķirkļa.';

  @override
  String get tapToReadMore => 'Pieskarieties, lai lasītu tālāk';

  @override
  String get saveWord => 'Saglabāt vārdu';

  @override
  String get removeFromFavorites => 'Noņemt no izlases';

  @override
  String get inPlainWords => 'vienkāršiem vārdiem';

  @override
  String get theDefinition => 'definīcija';

  @override
  String get inASentence => 'teikumā';

  @override
  String get exampleGlossLabel => 'citādi sakot';

  @override
  String get save => 'Saglabāt';

  @override
  String get saved => 'Saglabāts';

  @override
  String get copy => 'Kopēt';

  @override
  String get copiedToClipboard => 'Kopēts starpliktuvē';

  @override
  String get roots => 'saknes';

  @override
  String get quizTitle => 'Maza viktorīna';

  @override
  String get quizCaption => 'pazīsti saknes, tad izvēlies nozīmi';

  @override
  String get quizIntro =>
      'Katrs jautājums rāda vārdu un tā etimoloģiju. Izvēlieties piemēroto definīciju — četras izvēles, viena patiesa.';

  @override
  String get howManyWords => 'cik vārdu';

  @override
  String get begin => 'Sākt';

  @override
  String get quizByTheme => 'Viktorīna pēc tēmas';

  @override
  String get endQuiz => 'Beigt viktorīnu';

  @override
  String questionOf(int index, int length) {
    return 'Jautājums $index no $length';
  }

  @override
  String get whichDefinitionFits => 'kura definīcija der?';

  @override
  String get previous => 'Iepriekšējais';

  @override
  String get next => 'Nākamais';

  @override
  String get seeResults => 'Skatīt rezultātus';

  @override
  String get themeTitle => 'Tēma';

  @override
  String get chooseASubject => 'izvēlieties priekšmetu';

  @override
  String get noThemesYet => 'Tēmu vēl nav.';

  @override
  String get notEnoughWordsInTheme =>
      'Šajā tēmā vēl nav pietiekami daudz vārdu.';

  @override
  String get results => 'Rezultāti';

  @override
  String get perfectPage => 'pilnīga lapa';

  @override
  String get wellMarked => 'skaisti atzīmēts';

  @override
  String get tryAnotherRound => 'Mēģiniet vēl vienu raundu';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pareizas definīcijas',
      one: '1 pareiza definīcija',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pareizas definīcijas no $total.',
      one: 'Viena pareiza definīcija no $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Pārslēgties uz gaišo režīmu';

  @override
  String get switchToDarkMode => 'Pārslēgties uz tumšo režīmu';

  @override
  String get listen => 'Klausīties';

  @override
  String get stop => 'Apturēt';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Valodas';

  @override
  String get languagesCaption => 'valodas';

  @override
  String get searchLanguages => 'Meklējiet valsti vai valodu…';

  @override
  String get noMatchingLanguages => 'Nav atbilstošu valstu vai valodu.';

  @override
  String get selectedLanguage => 'Lasīšana';

  @override
  String get continentAfrica => 'Āfrika';

  @override
  String get continentAsia => 'Āzija';

  @override
  String get continentEurope => 'Eiropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Okeānija';

  @override
  String currentOfTotal(int current, int total) {
    return '$current no $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Arī $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kā: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'No $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, nozīme $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Vienkāršiem vārdiem: $friendly';
  }

  @override
  String get categorySpeech => 'Runa un retorika';

  @override
  String get categoryCharacter => 'Raksturs un temperaments';

  @override
  String get categoryCriticism => 'Kritika un apvainojums';

  @override
  String get categoryVirtue => 'Tikums';

  @override
  String get categoryVice => 'Netikums';

  @override
  String get categoryKnowledge => 'Zināšanas un doma';

  @override
  String get categoryReligion => 'Reliģija un gars';

  @override
  String get categoryBeginnings => 'Sākumi';

  @override
  String get categoryConflict => 'Konflikts un maldināšana';

  @override
  String get categoryAppearance => 'Izskats un gaisma';

  @override
  String get categoryPeople => 'Cilvēki un lomas';

  @override
  String get categoryObjects => 'Priekšmeti un lietas';

  @override
  String get categoryEmotion => 'Emocija';

  @override
  String get categoryArchaic => 'Senais un arhaiskais';

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
