// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексикон лепог језика';

  @override
  String get navHome => 'Почетна';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Квиз';

  @override
  String get navSaved => 'Сачувано';

  @override
  String get navLanguages => 'Језици';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count ретких, богатих речи из лексикона $lexicon — објашњених као што би их објаснио пријатељ, не речник.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'истражено $current од $total речи';
  }

  @override
  String get exploreLexicon => 'Истражи лексикон';

  @override
  String get startQuiz => 'Започни квиз';

  @override
  String get wordOfTheDay => 'реч дана';

  @override
  String get readFullEntry => 'Прочитај цео унос →';

  @override
  String get lexiconTitle => 'Лексикон';

  @override
  String get lexiconCaption => 'збирка';

  @override
  String get savedTitle => 'Сачуване речи';

  @override
  String get savedCaption => 'близу срца';

  @override
  String get searchHint => 'Потражи реч или опиши њено значење…';

  @override
  String get clearSearch => 'Очисти претрагу';

  @override
  String get filterAll => 'Све';

  @override
  String get noMatches => 'Још нема поклапања — покушај другу реч или осећај.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n поклапања',
      one: '1 поклапање',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'овде нема ничега';

  @override
  String get emptyLexicon => 'У овом углу лексикона нема ничега.';

  @override
  String get emptySaved =>
      'Још нема сачуваних речи. Додирни срце на било ком уносу.';

  @override
  String get tapToReadMore => 'Додирни да читаш даље';

  @override
  String get saveWord => 'Сачувај реч';

  @override
  String get removeFromFavorites => 'Уклони из омиљених';

  @override
  String get inPlainWords => 'простим речима';

  @override
  String get theDefinition => 'дефиниција';

  @override
  String get inASentence => 'у реченици';

  @override
  String get exampleGlossLabel => 'другим речима';

  @override
  String get save => 'Сачувај';

  @override
  String get saved => 'Сачувано';

  @override
  String get copy => 'Копирај';

  @override
  String get copiedToClipboard => 'Копирано у оставу';

  @override
  String get roots => 'корени';

  @override
  String get quizTitle => 'Мали квиз';

  @override
  String get quizCaption => 'упознај корене, затим изабери значење';

  @override
  String get quizIntro =>
      'Свако питање показује реч и њену етимологију. Изабери дефиницију која пристаје — четири избора, један истинит.';

  @override
  String get howManyWords => 'колико речи';

  @override
  String get begin => 'Почни';

  @override
  String get quizByTheme => 'Квиз по теми';

  @override
  String get endQuiz => 'Заврши квиз';

  @override
  String questionOf(int index, int length) {
    return 'Питање $index од $length';
  }

  @override
  String get whichDefinitionFits => 'која дефиниција пристаје?';

  @override
  String get previous => 'Претходно';

  @override
  String get next => 'Следеће';

  @override
  String get seeResults => 'Погледај резултате';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'изабери предмет';

  @override
  String get noThemesYet => 'Још нема тема.';

  @override
  String get notEnoughWordsInTheme => 'У овој теми још нема довољно речи.';

  @override
  String get results => 'Резултати';

  @override
  String get perfectPage => 'савршена страница';

  @override
  String get wellMarked => 'лепо обележено';

  @override
  String get tryAnotherRound => 'Пробај још једну рунду';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score тачних дефиниција',
      one: '1 тачна дефиниција',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score тачних дефиниција, од $total.',
      one: 'Једна тачна дефиниција, од $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Пређи на светли режим';

  @override
  String get switchToDarkMode => 'Пређи на тамни режим';

  @override
  String get listen => 'Слушај';

  @override
  String get stop => 'Заустави';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Језици';

  @override
  String get languagesCaption => 'језици';

  @override
  String get searchLanguages => 'Потражи земљу или језик…';

  @override
  String get noMatchingLanguages => 'Нема одговарајућих земаља ни језика.';

  @override
  String get selectedLanguage => 'Читање на';

  @override
  String get continentAfrica => 'Африка';

  @override
  String get continentAsia => 'Азија';

  @override
  String get continentEurope => 'Европа';

  @override
  String get continentAmericas => 'Америка';

  @override
  String get continentOceania => 'Океанија';

  @override
  String currentOfTotal(int current, int total) {
    return '$current од $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Такође $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Као у: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Из $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значење $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Простим речима: $friendly';
  }

  @override
  String get categorySpeech => 'Говор и реторика';

  @override
  String get categoryCharacter => 'Карактер и темперамент';

  @override
  String get categoryCriticism => 'Критика и увреда';

  @override
  String get categoryVirtue => 'Врлина';

  @override
  String get categoryVice => 'Порок';

  @override
  String get categoryKnowledge => 'Знање и мисао';

  @override
  String get categoryReligion => 'Вера и дух';

  @override
  String get categoryBeginnings => 'Почеци';

  @override
  String get categoryConflict => 'Сукоб и превара';

  @override
  String get categoryAppearance => 'Изглед и светлост';

  @override
  String get categoryPeople => 'Људи и улоге';

  @override
  String get categoryObjects => 'Предмети и ствари';

  @override
  String get categoryEmotion => 'Емоција';

  @override
  String get categoryArchaic => 'Старо и архаично';

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
