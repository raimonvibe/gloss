// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексикон прекрасной речи';

  @override
  String get navHome => 'Главная';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Викторина';

  @override
  String get navSaved => 'Сохранённое';

  @override
  String get navLanguages => 'Языки';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count редких, богатых слов из лексикона $lexicon — объяснённых так, как объяснил бы друг, а не словарь.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'изучено $current из $total слов';
  }

  @override
  String get exploreLexicon => 'Открыть лексикон';

  @override
  String get startQuiz => 'Начать викторину';

  @override
  String get wordOfTheDay => 'слово дня';

  @override
  String get readFullEntry => 'Читать всю статью →';

  @override
  String get lexiconTitle => 'Лексикон';

  @override
  String get lexiconCaption => 'собрание';

  @override
  String get savedTitle => 'Сохранённые слова';

  @override
  String get savedCaption => 'близко к сердцу';

  @override
  String get searchHint => 'Ищите слово или опишите его смысл…';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String get filterAll => 'Все';

  @override
  String get noMatches =>
      'Пока нет совпадений — попробуйте другое слово или чувство.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n совпадений',
      one: '1 совпадение',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'здесь ничего нет';

  @override
  String get emptyLexicon => 'В этом уголке лексикона ничего нет.';

  @override
  String get emptySaved =>
      'Пока нет сохранённых слов. Нажмите сердце на любой статье.';

  @override
  String get tapToReadMore => 'Нажмите, чтобы читать дальше';

  @override
  String get saveWord => 'Сохранить слово';

  @override
  String get removeFromFavorites => 'Убрать из избранного';

  @override
  String get inPlainWords => 'простыми словами';

  @override
  String get theDefinition => 'определение';

  @override
  String get inASentence => 'в предложении';

  @override
  String get exampleGlossLabel => 'иными словами';

  @override
  String get save => 'Сохранить';

  @override
  String get saved => 'Сохранено';

  @override
  String get copy => 'Копировать';

  @override
  String get copiedToClipboard => 'Скопировано в буфер';

  @override
  String get roots => 'корни';

  @override
  String get quizTitle => 'Небольшая викторина';

  @override
  String get quizCaption => 'узнайте корни, затем выберите смысл';

  @override
  String get quizIntro =>
      'Каждый вопрос показывает слово и его этимологию. Выберите определение, которое подходит — четыре выбора, один верный.';

  @override
  String get howManyWords => 'сколько слов';

  @override
  String get begin => 'Начать';

  @override
  String get quizByTheme => 'Викторина по теме';

  @override
  String get endQuiz => 'Завершить викторину';

  @override
  String questionOf(int index, int length) {
    return 'Вопрос $index из $length';
  }

  @override
  String get whichDefinitionFits => 'какое определение подходит?';

  @override
  String get previous => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get seeResults => 'Смотреть результаты';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'выберите предмет';

  @override
  String get noThemesYet => 'Пока нет тем.';

  @override
  String get notEnoughWordsInTheme => 'В этой теме пока недостаточно слов.';

  @override
  String get results => 'Результаты';

  @override
  String get perfectPage => 'безупречная страница';

  @override
  String get wellMarked => 'хорошо отмечено';

  @override
  String get tryAnotherRound => 'Попробовать ещё раунд';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score верных определений',
      one: '1 верное определение',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score верных определений из $total.',
      one: 'Одно верное определение из $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Перейти к светлой теме';

  @override
  String get switchToDarkMode => 'Перейти к тёмной теме';

  @override
  String get listen => 'Слушать';

  @override
  String get stop => 'Стоп';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Языки';

  @override
  String get languagesCaption => 'языки';

  @override
  String get searchLanguages => 'Ищите страну или язык…';

  @override
  String get noMatchingLanguages => 'Нет подходящих стран или языков.';

  @override
  String get selectedLanguage => 'Чтение на';

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
    return '$current из $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Также $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Как в: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Из $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значение $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Простыми словами: $friendly';
  }

  @override
  String get categorySpeech => 'Речь и риторика';

  @override
  String get categoryCharacter => 'Характер и темперамент';

  @override
  String get categoryCriticism => 'Критика и оскорбление';

  @override
  String get categoryVirtue => 'Добродетель';

  @override
  String get categoryVice => 'Порок';

  @override
  String get categoryKnowledge => 'Знание и мысль';

  @override
  String get categoryReligion => 'Религия и дух';

  @override
  String get categoryBeginnings => 'Начала';

  @override
  String get categoryConflict => 'Конфликт и обман';

  @override
  String get categoryAppearance => 'Облик и свет';

  @override
  String get categoryPeople => 'Люди и роли';

  @override
  String get categoryObjects => 'Предметы и вещи';

  @override
  String get categoryEmotion => 'Эмоция';

  @override
  String get categoryArchaic => 'Старое и архаичное';
}
