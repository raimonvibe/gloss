// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ලස්සන භාෂාවේ ශබ්දකෝෂය';

  @override
  String get navHome => 'මුල් පිටුව';

  @override
  String get navLexicon => 'ශබ්දකෝෂය';

  @override
  String get navQuiz => 'ප්‍රශ්නාවලිය';

  @override
  String get navSaved => 'සුරකින ලද';

  @override
  String get navLanguages => 'භාෂා';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon ශබ්දකෝෂයෙන් දුර්ලභ, පොහොසත් වචන $countක් — ශබ්දකෝෂයක් මෙන් නොව මිතුරෙකු මෙන් පැහැදිලි කර ඇත.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'වචන $totalකින් $currentක් ගවේෂණය කෙරිණි';
  }

  @override
  String get exploreLexicon => 'ශබ්දකෝෂය ගවේෂණය කරන්න';

  @override
  String get startQuiz => 'ප්‍රශ්නාවලියක් අරඹන්න';

  @override
  String get wordOfTheDay => 'අදේ වචනය';

  @override
  String get readFullEntry => 'සම්පූර්ණ ඇතුළත් කිරීම කියවන්න →';

  @override
  String get lexiconTitle => 'ශබ්දකෝෂය';

  @override
  String get lexiconCaption => 'එකතුව';

  @override
  String get savedTitle => 'සුරකින ලද වචන';

  @override
  String get savedCaption => 'ළඟ තබාගත්';

  @override
  String get searchHint => 'වචනයක් සොයන්න, නැතහොත් තේරුම විස්තර කරන්න…';

  @override
  String get clearSearch => 'සෙවීම මකන්න';

  @override
  String get filterAll => 'සියල්ල';

  @override
  String get noMatches =>
      'තවම ගැලපීම් නැත — වෙනත් වචනයක් හෝ හැඟීමක් උත්සාහ කරන්න.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'ගැලපීම් $n',
      one: 'ගැලපීම 1',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'මෙහි කිසිවක් නැත';

  @override
  String get emptyLexicon => 'ශබ්දකෝෂයේ මෙම කොනේ කිසිවක් නැත.';

  @override
  String get emptySaved =>
      'තවම සුරකින ලද වචන නැත. ඕනෑම ඇතුළත් කිරීමක හදවත තට්ටු කරන්න.';

  @override
  String get tapToReadMore => 'තවත් කියවීමට තට්ටු කරන්න';

  @override
  String get saveWord => 'වචනය සුරකින්න';

  @override
  String get removeFromFavorites => 'ප්‍රියතමයන්ගෙන් ඉවත් කරන්න';

  @override
  String get inPlainWords => 'සරල වචනවලින්';

  @override
  String get theDefinition => 'අර්ථ දැක්වීම';

  @override
  String get inASentence => 'වාක්‍යයක';

  @override
  String get exampleGlossLabel => 'වෙනත් වචනවලින්';

  @override
  String get save => 'සුරකින්න';

  @override
  String get saved => 'සුරකින ලදී';

  @override
  String get copy => 'පිටපත් කරන්න';

  @override
  String get copiedToClipboard => 'ක්ලිප්බෝඩ් වෙත පිටපත් කෙරිණි';

  @override
  String get roots => 'මූල';

  @override
  String get quizTitle => 'කුඩා ප්‍රශ්නාවලියක්';

  @override
  String get quizCaption => 'මූල දැනගෙන, පසුව අර්ථය තෝරන්න';

  @override
  String get quizIntro =>
      'සෑම ප්‍රශ්නයකම වචනයක් සහ එහි නිරුක්තිය පෙන්වයි. ගැලපෙන අර්ථ දැක්වීම තෝරන්න — තේරීම් හතරක්, එකක් සත්‍යයි.';

  @override
  String get howManyWords => 'කොපමණ වචන';

  @override
  String get begin => 'අරඹන්න';

  @override
  String get quizByTheme => 'තේමාව අනුව ප්‍රශ්නාවලිය';

  @override
  String get endQuiz => 'ප්‍රශ්නාවලිය අවසන් කරන්න';

  @override
  String questionOf(int index, int length) {
    return 'ප්‍රශ්නය $index / $length';
  }

  @override
  String get whichDefinitionFits => 'කුමන අර්ථ දැක්වීම ගැලපේද?';

  @override
  String get previous => 'පෙර';

  @override
  String get next => 'ඊළඟ';

  @override
  String get seeResults => 'ප්‍රතිඵල බලන්න';

  @override
  String get themeTitle => 'තේමාව';

  @override
  String get chooseASubject => 'විෂයයක් තෝරන්න';

  @override
  String get noThemesYet => 'තවම තේමා නැත.';

  @override
  String get notEnoughWordsInTheme => 'මෙම තේමාවේ තවම ප්‍රමාණවත් වචන නැත.';

  @override
  String get results => 'ප්‍රතිඵල';

  @override
  String get perfectPage => 'පරිපූර්ණ පිටුවක්';

  @override
  String get wellMarked => 'ලස්සනට සලකුණු කළ';

  @override
  String get tryAnotherRound => 'තවත් වටයක් උත්සාහ කරන්න';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'නිවැරදි අර්ථ දැක්වීම් $score',
      one: 'නිවැරදි අර්ථ දැක්වීම 1',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$totalන් නිවැරදි අර්ථ දැක්වීම් $score.',
      one: '$totalන් නිවැරදි අර්ථ දැක්වීමක්.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'ආලෝක ප්‍රකාරයට මාරු වන්න';

  @override
  String get switchToDarkMode => 'අඳුරු ප්‍රකාරයට මාරු වන්න';

  @override
  String get listen => 'අසන්න';

  @override
  String get stop => 'නවත්වන්න';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'භාෂා';

  @override
  String get languagesCaption => 'දිව';

  @override
  String get searchLanguages => 'රටක් හෝ භාෂාවක් සොයන්න…';

  @override
  String get noMatchingLanguages => 'ගැලපෙන රටවල් හෝ භාෂා නැත.';

  @override
  String get selectedLanguage => 'කියවන්නේ';

  @override
  String get continentAfrica => 'අප්‍රිකාව';

  @override
  String get continentAsia => 'ආසියාව';

  @override
  String get continentEurope => 'යුරෝපය';

  @override
  String get continentAmericas => 'ඇමරිකාව';

  @override
  String get continentOceania => 'ඕෂනියාව';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'එසේම $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'උදාහරණයක්: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin වෙතින්, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, අර්ථය $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'සරල වචනවලින්: $friendly';
  }

  @override
  String get categorySpeech => 'කථාව සහ වාග්විලාසය';

  @override
  String get categoryCharacter => 'චරිතය සහ ස්වභාවය';

  @override
  String get categoryCriticism => 'විවේචනය සහ අපහාසය';

  @override
  String get categoryVirtue => 'ගුණය';

  @override
  String get categoryVice => 'දොස';

  @override
  String get categoryKnowledge => 'දැනුම සහ සිතුවිල්ල';

  @override
  String get categoryReligion => 'ආගම සහ ආත්මය';

  @override
  String get categoryBeginnings => 'ආරම්භ';

  @override
  String get categoryConflict => 'ගැටුම සහ රැවටීම';

  @override
  String get categoryAppearance => 'පෙනුම සහ ආලෝකය';

  @override
  String get categoryPeople => 'මිනිසුන් සහ භූමිකා';

  @override
  String get categoryObjects => 'වස්තු සහ දේවල්';

  @override
  String get categoryEmotion => 'හැඟීම';

  @override
  String get categoryArchaic => 'පැරණි සහ පුරාණ';

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
