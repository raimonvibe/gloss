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
  String get navStudy => 'Кабинет';

  @override
  String get studyTitle => 'Кабинетът';

  @override
  String get studyCaption => 'четене, глас и светлина';

  @override
  String get readingSection => 'Четене';

  @override
  String get readingCaption => 'как ляга страницата';

  @override
  String get textSize => 'Размер на текста';

  @override
  String get textSizeSample => 'Edulcorate — да подслади, да смекчи.';

  @override
  String get smaller => 'По-малък';

  @override
  String get larger => 'По-голям';

  @override
  String get autoplayPronunciation => 'Прочитай думата на глас при отваряне';

  @override
  String get reduceMotion => 'Успокой украсата';

  @override
  String get reduceMotionCaption => 'по-малко завъртулки и преливания';

  @override
  String get voiceSection => 'Глас';

  @override
  String get voiceCaption => 'как Gloss чете на глас';

  @override
  String get chooseVoice => 'Глас';

  @override
  String get voiceDefault => 'Избран за вас';

  @override
  String get noOtherVoices =>
      'На това устройство няма инсталирани други английски гласове.';

  @override
  String get speechPace => 'Темпо';

  @override
  String get slower => 'По-бавно';

  @override
  String get faster => 'По-бързо';

  @override
  String get hearIt => 'Чуй я';

  @override
  String get lightSection => 'Светлина';

  @override
  String get lightCaption => 'пергамент или свещ';

  @override
  String get themeSystem => 'Според устройството';

  @override
  String get themeLight => 'Пергамент';

  @override
  String get themeDark => 'Светлина на свещ';

  @override
  String get tongueSection => 'Език';

  @override
  String get aboutSection => 'Относно';

  @override
  String get aboutCaption => 'как е направено';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Лицензи с отворен код';

  @override
  String get shareGloss => 'Сподели Gloss';

  @override
  String get followTheMaker => 'Последвайте автора';

  @override
  String couldNotOpenLink(String label) {
    return '$label не можа да се отвори.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Четене на обясненията на $language';
  }

  @override
  String get readExplanationsCaption =>
      'Самата дума винаги се чете на английски.';

  @override
  String noVoiceInstalled(String language) {
    return 'Това устройство няма инсталиран глас за $language.';
  }

  @override
  String get memorySection => 'Памет';

  @override
  String get memoryCaption => 'какво пази Gloss';

  @override
  String get forgetProgress => 'Забрави напредъка ми';

  @override
  String get forgetProgressBody =>
      'Думите, които сте разгледали, ще бъдат размаркирани. Запазените ви думи остават.';

  @override
  String get clearSavedWords => 'Изчисти запазените думи';

  @override
  String get clearSavedWordsBody =>
      'Думите, които сте запазили, ще бъдат премахнати. Напредъкът ви остава.';

  @override
  String get cancel => 'Отказ';

  @override
  String get forget => 'Забрави';

  @override
  String get clear => 'Изчисти';

  @override
  String get progressForgotten => 'Напредъкът е забравен.';

  @override
  String get savedWordsCleared => 'Запазените думи са изчистени.';

  @override
  String get contactTitle => 'Пишете на създателя';

  @override
  String get contactCaption => 'писмо, ако желаете';

  @override
  String get contactBlurb =>
      'Gloss се прави от един човек. Дума, която ви липсва, грешка, която сте открили, ред, който ви е харесал — всичко стига до едно и също бюро.';

  @override
  String get contactLetterSection => 'Писмото';

  @override
  String get contactName => 'Вашето име';

  @override
  String get contactNameHint => 'Името, с което да ви поздравим';

  @override
  String get contactEmail => 'Вашата поща';

  @override
  String get contactEmailHint => 'Където отговорът да ви намери';

  @override
  String contactEmailTypo(String domain) {
    return 'Имахте предвид $domain?';
  }

  @override
  String get contactReason => 'Причина за писмото';

  @override
  String get reasonWord => 'Дума за добавяне';

  @override
  String get reasonProblem => 'Нещо не е наред';

  @override
  String get reasonQuestion => 'Въпрос';

  @override
  String get reasonPraise => 'Мнение';

  @override
  String get reasonOther => 'Нещо друго';

  @override
  String get contactPriority => 'Колко е спешно';

  @override
  String get priorityLow => 'Ниска';

  @override
  String get priorityNormal => 'Обичайна';

  @override
  String get priorityHigh => 'Висока';

  @override
  String get contactMessage => 'Вашето съобщение';

  @override
  String get contactMessageHint => 'Пишете колкото искате, или съвсем малко…';

  @override
  String get contactHumanCheck => 'Една дума преди да изпратите';

  @override
  String contactHumanQuestion(String word) {
    return 'Кое значение принадлежи на $word?';
  }

  @override
  String get contactHumanRetry => 'Не това. Ето друга дума.';

  @override
  String get contactDetails => 'Приложи данни за приложението';

  @override
  String get contactDetailsCaption =>
      'Версия, език, светлина и размер на текста, за да се намери грешката по-бързо.';

  @override
  String get contactSend => 'Изпрати писмото';

  @override
  String get contactCopyLetter => 'Копирай писмото';

  @override
  String get contactDraftRestored => 'Тук чакаше неизпратено писмо.';

  @override
  String get contactNoMailApp =>
      'Никое пощенско приложение не отговори, затова писмото остана в клипборда.';

  @override
  String get contactNeedName => 'Име, за да знае отговорът кого поздравява.';

  @override
  String get contactNeedEmail => 'Адрес, до който може да стигне отговор.';

  @override
  String get contactNeedMessage => 'Поне ред или два.';

  @override
  String get contactSent => 'Писмото ви е на път. Благодарим.';

  @override
  String get contactSendFailed =>
      'Писмото не можа да се изпрати сега. То е в клипборда и остава тук.';

  @override
  String get contactSendByMail => 'Използвайте вместо това пощенско приложение';
}
