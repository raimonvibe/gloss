// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексикон на хубавия език';

  @override
  String get navHome => 'Начало';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Викторина';

  @override
  String get navSaved => 'Запазени';

  @override
  String get navLanguages => 'Езици';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count редки, богати думи от лексикона $lexicon — обяснени както би ги обяснил приятел, не речник.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'разгледани $current от $total думи';
  }

  @override
  String get exploreLexicon => 'Разгледай лексикона';

  @override
  String get startQuiz => 'Започни викторина';

  @override
  String get wordOfTheDay => 'дума на деня';

  @override
  String get readFullEntry => 'Прочети целия запис →';

  @override
  String get lexiconTitle => 'Лексиконът';

  @override
  String get lexiconCaption => 'сборът';

  @override
  String get savedTitle => 'Запазени думи';

  @override
  String get savedCaption => 'близо до сърцето';

  @override
  String get searchHint => 'Потърси дума или опиши значението ѝ…';

  @override
  String get clearSearch => 'Изчисти търсенето';

  @override
  String get filterAll => 'Всички';

  @override
  String get noMatches =>
      'Още няма съвпадения — опитай друга дума или усещане.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n съвпадения',
      one: '1 съвпадение',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'тук няма нищо';

  @override
  String get emptyLexicon => 'В този ъгъл на лексикона няма нищо.';

  @override
  String get emptySaved =>
      'Още няма запазени думи. Докосни сърцето на който и да е запис.';

  @override
  String get tapToReadMore => 'Докосни, за да четеш още';

  @override
  String get saveWord => 'Запази дума';

  @override
  String get removeFromFavorites => 'Премахни от любими';

  @override
  String get inPlainWords => 'с прости думи';

  @override
  String get theDefinition => 'определението';

  @override
  String get inASentence => 'в изречение';

  @override
  String get exampleGlossLabel => 'с други думи';

  @override
  String get save => 'Запази';

  @override
  String get saved => 'Запазено';

  @override
  String get copy => 'Копирай';

  @override
  String get copiedToClipboard => 'Копирано в клипборда';

  @override
  String get roots => 'корени';

  @override
  String get quizTitle => 'Малка викторина';

  @override
  String get quizCaption => 'познай корените, после избери значението';

  @override
  String get quizIntro =>
      'Всеки въпрос показва дума и нейната етимология. Избери определението, което пасва — четири избора, един верен.';

  @override
  String get howManyWords => 'колко думи';

  @override
  String get begin => 'Започни';

  @override
  String get quizByTheme => 'Викторина по тема';

  @override
  String get endQuiz => 'Приключи викторината';

  @override
  String questionOf(int index, int length) {
    return 'Въпрос $index от $length';
  }

  @override
  String get whichDefinitionFits => 'кое определение пасва?';

  @override
  String get previous => 'Предишен';

  @override
  String get next => 'Следващ';

  @override
  String get seeResults => 'Виж резултатите';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'избери предмет';

  @override
  String get noThemesYet => 'Още няма теми.';

  @override
  String get notEnoughWordsInTheme => 'В тази тема още няма достатъчно думи.';

  @override
  String get results => 'Резултати';

  @override
  String get perfectPage => 'безупречна страница';

  @override
  String get wellMarked => 'добре отбелязано';

  @override
  String get tryAnotherRound => 'Опитай още един кръг';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score верни определения',
      one: '1 вярно определение',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score верни определения от $total.',
      one: 'Едно вярно определение от $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Превключи към светъл режим';

  @override
  String get switchToDarkMode => 'Превключи към тъмен режим';

  @override
  String get listen => 'Слушай';

  @override
  String get stop => 'Спри';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Езици';

  @override
  String get languagesCaption => 'езиците';

  @override
  String get searchLanguages => 'Потърси държава или език…';

  @override
  String get noMatchingLanguages => 'Няма съответстващи държави или езици.';

  @override
  String get selectedLanguage => 'Четене на';

  @override
  String get continentAfrica => 'Африка';

  @override
  String get continentAsia => 'Азия';

  @override
  String get continentEurope => 'Европа';

  @override
  String get continentAmericas => 'Америка';

  @override
  String get continentOceania => 'Океания';

  @override
  String currentOfTotal(int current, int total) {
    return '$current от $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Също $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Както в: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'От $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значение $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'С прости думи: $friendly';
  }

  @override
  String get categorySpeech => 'Реч и реторика';

  @override
  String get categoryCharacter => 'Характер и темперамент';

  @override
  String get categoryCriticism => 'Критика и обида';

  @override
  String get categoryVirtue => 'Добродетел';

  @override
  String get categoryVice => 'Порок';

  @override
  String get categoryKnowledge => 'Знание и мисъл';

  @override
  String get categoryReligion => 'Религия и дух';

  @override
  String get categoryBeginnings => 'Начала';

  @override
  String get categoryConflict => 'Конфликт и измама';

  @override
  String get categoryAppearance => 'Външност и светлина';

  @override
  String get categoryPeople => 'Хора и роли';

  @override
  String get categoryObjects => 'Предмети и неща';

  @override
  String get categoryEmotion => 'Емоция';

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
