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

  @override
  String get navStudy => 'Кабинет';

  @override
  String get studyTitle => 'Кабинет';

  @override
  String get studyCaption => 'чтение, голос и свет';

  @override
  String get readingSection => 'Чтение';

  @override
  String get readingCaption => 'как ложится страница';

  @override
  String get textSize => 'Размер текста';

  @override
  String get textSizeSample => 'Edulcorate — подсластить, смягчить.';

  @override
  String get smaller => 'Мельче';

  @override
  String get larger => 'Крупнее';

  @override
  String get autoplayPronunciation => 'Читать слово вслух при открытии';

  @override
  String get reduceMotion => 'Успокоить убранство';

  @override
  String get reduceMotionCaption => 'меньше завитков и градиентов';

  @override
  String get voiceSection => 'Голос';

  @override
  String get voiceCaption => 'как Gloss читает вслух';

  @override
  String get chooseVoice => 'Голос';

  @override
  String get voiceDefault => 'Выбран для вас';

  @override
  String get noOtherVoices =>
      'На этом устройстве не установлены другие английские голоса.';

  @override
  String get speechPace => 'Темп';

  @override
  String get slower => 'Медленнее';

  @override
  String get faster => 'Быстрее';

  @override
  String get hearIt => 'Послушать';

  @override
  String get lightSection => 'Свет';

  @override
  String get lightCaption => 'пергамент или свет свечи';

  @override
  String get themeSystem => 'Как на устройстве';

  @override
  String get themeLight => 'Пергамент';

  @override
  String get themeDark => 'Свет свечи';

  @override
  String get tongueSection => 'Язык';

  @override
  String get aboutSection => 'О приложении';

  @override
  String get aboutCaption => 'как это сделано';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Лицензии открытого кода';

  @override
  String get shareGloss => 'Поделиться Gloss';

  @override
  String get followTheMaker => 'Следите за автором';

  @override
  String couldNotOpenLink(String label) {
    return 'Не удалось открыть $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Читать пояснения на языке $language';
  }

  @override
  String get readExplanationsCaption =>
      'Само слово всегда читается по-английски.';

  @override
  String noVoiceInstalled(String language) {
    return 'На этом устройстве нет голоса для языка $language.';
  }

  @override
  String get memorySection => 'Память';

  @override
  String get memoryCaption => 'что хранит Gloss';

  @override
  String get forgetProgress => 'Забыть мой прогресс';

  @override
  String get forgetProgressBody =>
      'С изученных слов будут сняты отметки. Сохранённые слова останутся.';

  @override
  String get clearSavedWords => 'Очистить сохранённые слова';

  @override
  String get clearSavedWordsBody =>
      'Слова, которые вы сохранили, будут удалены. Ваш прогресс останется.';

  @override
  String get cancel => 'Отмена';

  @override
  String get forget => 'Забыть';

  @override
  String get clear => 'Очистить';

  @override
  String get progressForgotten => 'Прогресс забыт.';

  @override
  String get savedWordsCleared => 'Сохранённые слова очищены.';

  @override
  String get contactTitle => 'Написать автору';

  @override
  String get contactCaption => 'письмо, если хотите';

  @override
  String get contactBlurb =>
      'Gloss делает один человек. Слово, которого вам не хватило, найденная ошибка, понравившаяся строка — всё приходит на один и тот же стол.';

  @override
  String get contactLetterSection => 'Письмо';

  @override
  String get contactName => 'Ваше имя';

  @override
  String get contactNameHint => 'Имя, которым к вам обращаться';

  @override
  String get contactEmail => 'Ваша почта';

  @override
  String get contactEmailHint => 'Куда придёт ответ';

  @override
  String contactEmailTypo(String domain) {
    return 'Вы имели в виду $domain?';
  }

  @override
  String get contactReason => 'Причина письма';

  @override
  String get reasonWord => 'Слово, которое стоит добавить';

  @override
  String get reasonProblem => 'Что-то не так';

  @override
  String get reasonQuestion => 'Вопрос';

  @override
  String get reasonPraise => 'Отзыв';

  @override
  String get reasonOther => 'Что-то ещё';

  @override
  String get contactPriority => 'Насколько срочно';

  @override
  String get priorityLow => 'Низкая';

  @override
  String get priorityNormal => 'Обычная';

  @override
  String get priorityHigh => 'Высокая';

  @override
  String get contactMessage => 'Ваше сообщение';

  @override
  String get contactMessageHint => 'Пишите столько, сколько захотите…';

  @override
  String get contactHumanCheck => 'Одно слово перед отправкой';

  @override
  String contactHumanQuestion(String word) {
    return 'Какое значение принадлежит слову $word?';
  }

  @override
  String get contactHumanRetry => 'Не это. Вот другое слово.';

  @override
  String get contactDetails => 'Добавить сведения о приложении';

  @override
  String get contactDetailsCaption =>
      'Версия, язык, свет и размер текста — так ошибку найти проще.';

  @override
  String get contactSend => 'Отправить письмо';

  @override
  String get contactCopyLetter => 'Скопировать письмо';

  @override
  String get contactDraftRestored => 'Здесь ждало неотправленное письмо.';

  @override
  String get contactNoMailApp =>
      'Почтовое приложение не откликнулось, письмо осталось в буфере обмена.';

  @override
  String get contactNeedName => 'Имя, чтобы ответ знал, к кому обращаться.';

  @override
  String get contactNeedEmail => 'Адрес, до которого дойдёт ответ.';

  @override
  String get contactNeedMessage => 'Хотя бы строку или две.';

  @override
  String get contactSent => 'Ваше письмо в пути. Спасибо.';

  @override
  String get contactSendFailed =>
      'Письмо сейчас не отправилось. Оно в буфере обмена и осталось здесь.';

  @override
  String get contactSendByMail => 'Отправить через почтовое приложение';
}
