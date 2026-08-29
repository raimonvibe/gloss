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
  String get navStudy => 'Кабінет';

  @override
  String get studyTitle => 'Кабінет';

  @override
  String get studyCaption => 'читання, голос і світло';

  @override
  String get readingSection => 'Читання';

  @override
  String get readingCaption => 'як лягає сторінка';

  @override
  String get textSize => 'Розмір тексту';

  @override
  String get textSizeSample => 'Edulcorate — підсолодити, пом\'якшити.';

  @override
  String get smaller => 'Дрібніше';

  @override
  String get larger => 'Більше';

  @override
  String get autoplayPronunciation => 'Читати слово вголос під час відкриття';

  @override
  String get reduceMotion => 'Заспокоїти оздоби';

  @override
  String get reduceMotionCaption => 'менше завитків і градієнтів';

  @override
  String get voiceSection => 'Голос';

  @override
  String get voiceCaption => 'як Gloss читає вголос';

  @override
  String get chooseVoice => 'Голос';

  @override
  String get voiceDefault => 'Обраний для вас';

  @override
  String get noOtherVoices =>
      'На цьому пристрої не встановлено інших англійських голосів.';

  @override
  String get speechPace => 'Темп';

  @override
  String get slower => 'Повільніше';

  @override
  String get faster => 'Швидше';

  @override
  String get hearIt => 'Послухати';

  @override
  String get lightSection => 'Світло';

  @override
  String get lightCaption => 'пергамент або світло свічки';

  @override
  String get themeSystem => 'Як на пристрої';

  @override
  String get themeLight => 'Пергамент';

  @override
  String get themeDark => 'Світло свічки';

  @override
  String get tongueSection => 'Мова';

  @override
  String get aboutSection => 'Про застосунок';

  @override
  String get aboutCaption => 'як це зроблено';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Ліцензії відкритого коду';

  @override
  String get shareGloss => 'Поділитися Gloss';

  @override
  String get followTheMaker => 'Стежте за автором';

  @override
  String couldNotOpenLink(String label) {
    return 'Не вдалося відкрити $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Читати пояснення мовою $language';
  }

  @override
  String get readExplanationsCaption =>
      'Саме слово завжди читається англійською.';

  @override
  String noVoiceInstalled(String language) {
    return 'На цьому пристрої немає голосу для мови $language.';
  }
}
