// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексикон на убав јазик';

  @override
  String get navHome => 'Почетна';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Квиз';

  @override
  String get navSaved => 'Зачувано';

  @override
  String get navLanguages => 'Јазици';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count ретки, богати зборови од лексиконот $lexicon — објаснети како што би објаснил пријател, не речник.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'истражени $current од $total збора';
  }

  @override
  String get exploreLexicon => 'Истражи го лексиконот';

  @override
  String get startQuiz => 'Започни квиз';

  @override
  String get wordOfTheDay => 'збор на денот';

  @override
  String get readFullEntry => 'Прочитај го целиот запис →';

  @override
  String get lexiconTitle => 'Лексиконот';

  @override
  String get lexiconCaption => 'збирката';

  @override
  String get savedTitle => 'Зачувани зборови';

  @override
  String get savedCaption => 'блиску до срцето';

  @override
  String get searchHint => 'Пребарај збор или опиши го неговото значење…';

  @override
  String get clearSearch => 'Исчисти пребарување';

  @override
  String get filterAll => 'Сите';

  @override
  String get noMatches =>
      'Сè уште нема совпаѓања — пробај друг збор или чувство.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n совпаѓања',
      one: '1 совпаѓање',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'тука нема ништо';

  @override
  String get emptyLexicon => 'Во овој агол од лексиконот нема ништо.';

  @override
  String get emptySaved =>
      'Сè уште нема зачувани зборови. Допрете го срцето на кој било запис.';

  @override
  String get tapToReadMore => 'Допрете за да читате повеќе';

  @override
  String get saveWord => 'Зачувај збор';

  @override
  String get removeFromFavorites => 'Отстрани од омилени';

  @override
  String get inPlainWords => 'со прости зборови';

  @override
  String get theDefinition => 'дефиницијата';

  @override
  String get inASentence => 'во реченица';

  @override
  String get exampleGlossLabel => 'со други зборови';

  @override
  String get save => 'Зачувај';

  @override
  String get saved => 'Зачувано';

  @override
  String get copy => 'Копирај';

  @override
  String get copiedToClipboard => 'Копирано во клипборд';

  @override
  String get roots => 'корени';

  @override
  String get quizTitle => 'Мала квиз';

  @override
  String get quizCaption => 'познај ги корените, па избери го значењето';

  @override
  String get quizIntro =>
      'Секое прашање покажува збор и неговата етимологија. Изберете ја дефиницијата што одговара — четири избори, еден вистински.';

  @override
  String get howManyWords => 'колку збора';

  @override
  String get begin => 'Почни';

  @override
  String get quizByTheme => 'Квиз по тема';

  @override
  String get endQuiz => 'Заврши квиз';

  @override
  String questionOf(int index, int length) {
    return 'Прашање $index од $length';
  }

  @override
  String get whichDefinitionFits => 'која дефиниција одговара?';

  @override
  String get previous => 'Претходно';

  @override
  String get next => 'Следно';

  @override
  String get seeResults => 'Види резултати';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'избери предмет';

  @override
  String get noThemesYet => 'Сè уште нема теми.';

  @override
  String get notEnoughWordsInTheme =>
      'Во оваа тема сè уште нема доволно зборови.';

  @override
  String get results => 'Резултати';

  @override
  String get perfectPage => 'совршена страница';

  @override
  String get wellMarked => 'убаво обележано';

  @override
  String get tryAnotherRound => 'Пробај уште една рунда';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score точни дефиниции',
      one: '1 точна дефиниција',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score точни дефиниции, од $total.',
      one: 'Една точна дефиниција, од $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Префрли на светол режим';

  @override
  String get switchToDarkMode => 'Префрли на темен режим';

  @override
  String get listen => 'Слушај';

  @override
  String get stop => 'Запри';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Јазици';

  @override
  String get languagesCaption => 'јазиците';

  @override
  String get searchLanguages => 'Пребарај земја или јазик…';

  @override
  String get noMatchingLanguages => 'Нема соодветни земји или јазици.';

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
    return 'Исто така $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Како во: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Од $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значење $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Со прости зборови: $friendly';
  }

  @override
  String get categorySpeech => 'Говор и реторика';

  @override
  String get categoryCharacter => 'Карактер и темперамент';

  @override
  String get categoryCriticism => 'Критика и навреда';

  @override
  String get categoryVirtue => 'Доблест';

  @override
  String get categoryVice => 'Порок';

  @override
  String get categoryKnowledge => 'Знаење и мисла';

  @override
  String get categoryReligion => 'Религија и дух';

  @override
  String get categoryBeginnings => 'Почетоци';

  @override
  String get categoryConflict => 'Судир и измама';

  @override
  String get categoryAppearance => 'Изглед и светлина';

  @override
  String get categoryPeople => 'Луѓе и улоги';

  @override
  String get categoryObjects => 'Предмети и работи';

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
}
