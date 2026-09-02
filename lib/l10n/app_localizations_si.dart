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
  String get navStudy => 'අධ්‍යයනය';

  @override
  String get studyTitle => 'අධ්‍යයන කාමරය';

  @override
  String get studyCaption => 'කියවීම, හඬ සහ එළිය';

  @override
  String get readingSection => 'කියවීම';

  @override
  String get readingCaption => 'පිටුව හිඳින ආකාරය';

  @override
  String get textSize => 'අකුරු ප්‍රමාණය';

  @override
  String get textSizeSample => 'Edulcorate — මිහිරි කිරීම, මෘදු කිරීම.';

  @override
  String get smaller => 'කුඩා';

  @override
  String get larger => 'විශාල';

  @override
  String get autoplayPronunciation => 'වචනය විවෘත වන විට හඬනගා කියවන්න';

  @override
  String get reduceMotion => 'අලංකාර සන්සුන් කරන්න';

  @override
  String get reduceMotionCaption => 'අඩු රටා සහ වර්ණ අනුක්‍රම';

  @override
  String get voiceSection => 'හඬ';

  @override
  String get voiceCaption => 'Gloss හඬනගා කියවන ආකාරය';

  @override
  String get chooseVoice => 'හඬ';

  @override
  String get voiceDefault => 'ඔබ වෙනුවෙන් තෝරන ලද';

  @override
  String get noOtherVoices => 'මෙම උපාංගයේ වෙනත් ඉංග්‍රීසි හඬ ස්ථාපනය කර නැත.';

  @override
  String get speechPace => 'වේගය';

  @override
  String get slower => 'සෙමින්';

  @override
  String get faster => 'වේගවත්';

  @override
  String get hearIt => 'අහන්න';

  @override
  String get lightSection => 'එළිය';

  @override
  String get lightCaption => 'පදම් පත් හෝ ඉටිපන්දම් එළිය';

  @override
  String get themeSystem => 'උපාංගය අනුව';

  @override
  String get themeLight => 'පදම් පත්';

  @override
  String get themeDark => 'ඉටිපන්දම් එළිය';

  @override
  String get tongueSection => 'බස';

  @override
  String get aboutSection => 'පිළිබඳව';

  @override
  String get aboutCaption => 'එය තැනුණු ආකාරය';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'විවෘත මූලාශ්‍ර බලපත්‍ර';

  @override
  String get shareGloss => 'Gloss බෙදාගන්න';

  @override
  String get followTheMaker => 'නිර්මාපකයා අනුගමනය කරන්න';

  @override
  String couldNotOpenLink(String label) {
    return '$label විවෘත කළ නොහැකි විය.';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language බසින් විස්තර කියවන්න';
  }

  @override
  String get readExplanationsCaption =>
      'වචනය සැමවිටම ඉංග්‍රීසියෙන් කියවනු ලැබේ.';

  @override
  String noVoiceInstalled(String language) {
    return 'මෙම උපාංගයේ $language හඬක් ස්ථාපනය කර නැත.';
  }

  @override
  String get memorySection => 'මතකය';

  @override
  String get memoryCaption => 'Gloss තබාගන්නා දේ';

  @override
  String get forgetProgress => 'මගේ ප්‍රගතිය අමතක කරන්න';

  @override
  String get forgetProgressBody =>
      'ඔබ ගවේෂණය කළ වචනවල සලකුණ ඉවත් වේ. ඔබ සුරැකි වචන පවතී.';

  @override
  String get clearSavedWords => 'සුරැකි වචන ඉවත් කරන්න';

  @override
  String get clearSavedWordsBody =>
      'ඔබ තබාගත් වචන ඉවත් කෙරේ. ඔබේ ප්‍රගතිය පවතී.';

  @override
  String get cancel => 'අවලංගු කරන්න';

  @override
  String get forget => 'අමතක කරන්න';

  @override
  String get clear => 'ඉවත් කරන්න';

  @override
  String get progressForgotten => 'ප්‍රගතිය අමතක කෙරිණි.';

  @override
  String get savedWordsCleared => 'සුරැකි වචන ඉවත් කෙරිණි.';

  @override
  String get contactTitle => 'නිර්මාපකයාට ලියන්න';

  @override
  String get contactCaption => 'කැමති නම්, ලිපියක්';

  @override
  String get contactBlurb =>
      'Gloss සාදන්නේ එක් අයෙකි. ඔබට නොලැබුණු වචනයක්, ඔබ සොයාගත් වරදක්, ඔබ ප්‍රිය කළ පේළියක් — සියල්ලම එකම මේසයට එයි.';

  @override
  String get contactLetterSection => 'ලිපිය';

  @override
  String get contactName => 'ඔබේ නම';

  @override
  String get contactNameHint => 'ඔබ අමතන නම';

  @override
  String get contactEmail => 'ඔබේ විද්‍යුත් තැපෑල';

  @override
  String get contactEmailHint => 'පිළිතුරක් ඔබව සොයාගන්නා තැන';

  @override
  String contactEmailTypo(String domain) {
    return 'ඔබ අදහස් කළේ $domain ද?';
  }

  @override
  String get contactReason => 'ලිවීමට හේතුව';

  @override
  String get reasonWord => 'එකතු කළ යුතු වචනයක්';

  @override
  String get reasonProblem => 'යමක් වැරදියි';

  @override
  String get reasonQuestion => 'ප්‍රශ්නයක්';

  @override
  String get reasonPraise => 'ප්‍රතිචාර';

  @override
  String get reasonOther => 'වෙනත් දෙයක්';

  @override
  String get contactPriority => 'කෙතරම් හදිසිද';

  @override
  String get priorityLow => 'අඩු';

  @override
  String get priorityNormal => 'සාමාන්‍ය';

  @override
  String get priorityHigh => 'වැඩි';

  @override
  String get contactMessage => 'ඔබේ පණිවිඩය';

  @override
  String get contactMessageHint => 'කැමති තරම් දිගින් හෝ කෙටියෙන් ලියන්න…';

  @override
  String get contactHumanCheck => 'යැවීමට පෙර එක් වචනයක්';

  @override
  String contactHumanQuestion(String word) {
    return '$word යන්නට අයත් අර්ථය කුමක්ද?';
  }

  @override
  String get contactHumanRetry => 'එය නොවේ. මෙන්න තවත් වචනයක්.';

  @override
  String get contactDetails => 'යෙදුමේ විස්තර ද යවන්න';

  @override
  String get contactDetailsCaption =>
      'අනුවාදය, භාෂාව, ආලෝකය සහ අකුරු ප්‍රමාණය — වරදක් වේගයෙන් සොයාගැනීමට.';

  @override
  String get contactSend => 'ලිපිය යවන්න';

  @override
  String get contactCopyLetter => 'ලිපිය පිටපත් කරන්න';

  @override
  String get contactDraftRestored => 'නොයැවූ ලිපියක් මෙහි රැඳී තිබුණි.';

  @override
  String get contactNoMailApp =>
      'කිසිදු තැපැල් යෙදුමක් පිළිතුරු නොදුන් නිසා ලිපිය පසුරු පුවරුවේ ඇත.';

  @override
  String get contactNeedName => 'නමක්, පිළිතුර කවුරුන් අමතන්නේදැයි දැනගන්නට.';

  @override
  String get contactNeedEmail => 'පිළිතුරක් ළඟා විය හැකි ලිපිනයක්.';

  @override
  String get contactNeedMessage => 'අඩුම තරමේ පේළියක් දෙකක්.';

  @override
  String get contactSent => 'ඔබේ ලිපිය මාර්ගයේ ය. ස්තුතියි.';

  @override
  String get contactSendFailed =>
      'ලිපිය දැන් යැවිය නොහැකි විය. එය පසුරු පුවරුවේ ඇති අතර මෙහිද තබා ඇත.';

  @override
  String get contactSendByMail => 'ඒ වෙනුවට තැපැල් යෙදුමක් භාවිත කරන්න';
}
