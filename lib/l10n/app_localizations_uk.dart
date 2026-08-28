// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексикон прекрасної мови';

  @override
  String get navHome => 'Головна';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Вікторина';

  @override
  String get navSaved => 'Збережене';

  @override
  String get navLanguages => 'Мови';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count рідкісних, багатих слів із лексикону $lexicon — пояснених так, як пояснив би друг, а не словник.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'досліджено $current з $total слів';
  }

  @override
  String get exploreLexicon => 'Дослідити лексикон';

  @override
  String get startQuiz => 'Почати вікторину';

  @override
  String get wordOfTheDay => 'слово дня';

  @override
  String get readFullEntry => 'Читати весь запис →';

  @override
  String get lexiconTitle => 'Лексикон';

  @override
  String get lexiconCaption => 'зібрання';

  @override
  String get savedTitle => 'Збережені слова';

  @override
  String get savedCaption => 'близько до серця';

  @override
  String get searchHint => 'Шукай слово або опиши його сенс…';

  @override
  String get clearSearch => 'Очистити пошук';

  @override
  String get filterAll => 'Усі';

  @override
  String get noMatches => 'Поки немає збігів — спробуй інше слово чи почуття.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n збігів',
      one: '1 збіг',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'тут нічого немає';

  @override
  String get emptyLexicon => 'У цьому кутку лексикону нічого немає.';

  @override
  String get emptySaved =>
      'Поки немає збережених слів. Торкнися серця на будь-якому записі.';

  @override
  String get tapToReadMore => 'Торкнися, щоб читати далі';

  @override
  String get saveWord => 'Зберегти слово';

  @override
  String get removeFromFavorites => 'Прибрати з улюблених';

  @override
  String get inPlainWords => 'простими словами';

  @override
  String get theDefinition => 'визначення';

  @override
  String get inASentence => 'у реченні';

  @override
  String get exampleGlossLabel => 'іншими словами';

  @override
  String get save => 'Зберегти';

  @override
  String get saved => 'Збережено';

  @override
  String get copy => 'Копіювати';

  @override
  String get copiedToClipboard => 'Скопійовано в буфер';

  @override
  String get roots => 'корені';

  @override
  String get quizTitle => 'Невелика вікторина';

  @override
  String get quizCaption => 'пізнай корені, потім обери сенс';

  @override
  String get quizIntro =>
      'Кожне питання показує слово і його етимологію. Обери визначення, що пасує — чотири вибори, один правдивий.';

  @override
  String get howManyWords => 'скільки слів';

  @override
  String get begin => 'Почати';

  @override
  String get quizByTheme => 'Вікторина за темою';

  @override
  String get endQuiz => 'Завершити вікторину';

  @override
  String questionOf(int index, int length) {
    return 'Питання $index з $length';
  }

  @override
  String get whichDefinitionFits => 'яке визначення пасує?';

  @override
  String get previous => 'Назад';

  @override
  String get next => 'Далі';

  @override
  String get seeResults => 'Переглянути результати';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'обери предмет';

  @override
  String get noThemesYet => 'Поки немає тем.';

  @override
  String get notEnoughWordsInTheme => 'У цій темі поки замало слів.';

  @override
  String get results => 'Результати';

  @override
  String get perfectPage => 'бездоганна сторінка';

  @override
  String get wellMarked => 'гарно позначено';

  @override
  String get tryAnotherRound => 'Спробуй ще один раунд';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score правильних визначень',
      one: '1 правильне визначення',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score правильних визначень з $total.',
      one: 'Одне правильне визначення з $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Перейти до світлого режиму';

  @override
  String get switchToDarkMode => 'Перейти до темного режиму';

  @override
  String get listen => 'Слухати';

  @override
  String get stop => 'Зупинити';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Мови';

  @override
  String get languagesCaption => 'мови';

  @override
  String get searchLanguages => 'Шукай країну або мову…';

  @override
  String get noMatchingLanguages => 'Немає відповідних країн чи мов.';

  @override
  String get selectedLanguage => 'Читання мовою';

  @override
  String get continentAfrica => 'Африка';

  @override
  String get continentAsia => 'Азія';

  @override
  String get continentEurope => 'Європа';

  @override
  String get continentAmericas => 'Америка';

  @override
  String get continentOceania => 'Океанія';

  @override
  String currentOfTotal(int current, int total) {
    return '$current з $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Також $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Як у: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'З $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значення $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Простими словами: $friendly';
  }

  @override
  String get categorySpeech => 'Мовлення і риторика';

  @override
  String get categoryCharacter => 'Характер і темперамент';

  @override
  String get categoryCriticism => 'Критика і образа';

  @override
  String get categoryVirtue => 'Чеснота';

  @override
  String get categoryVice => 'Порок';

  @override
  String get categoryKnowledge => 'Знання і думка';

  @override
  String get categoryReligion => 'Релігія і дух';

  @override
  String get categoryBeginnings => 'Початки';

  @override
  String get categoryConflict => 'Конфлікт і обман';

  @override
  String get categoryAppearance => 'Вигляд і світло';

  @override
  String get categoryPeople => 'Люди і ролі';

  @override
  String get categoryObjects => 'Предмети і речі';

  @override
  String get categoryEmotion => 'Емоція';

  @override
  String get categoryArchaic => 'Старе й архаїчне';

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
