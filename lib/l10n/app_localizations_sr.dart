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
  String get navStudy => 'Кабинет';

  @override
  String get studyTitle => 'Кабинет';

  @override
  String get studyCaption => 'читање, глас и светлост';

  @override
  String get readingSection => 'Читање';

  @override
  String get readingCaption => 'како страница належе';

  @override
  String get textSize => 'Величина текста';

  @override
  String get textSizeSample => 'Edulcorate — заслaдити, ублажити.';

  @override
  String get smaller => 'Мање';

  @override
  String get larger => 'Веће';

  @override
  String get autoplayPronunciation => 'Прочитај реч наглас при отварању';

  @override
  String get reduceMotion => 'Смири украсе';

  @override
  String get reduceMotionCaption => 'мање витица и прелива';

  @override
  String get voiceSection => 'Глас';

  @override
  String get voiceCaption => 'како Gloss чита наглас';

  @override
  String get chooseVoice => 'Глас';

  @override
  String get voiceDefault => 'Изабран за вас';

  @override
  String get noOtherVoices =>
      'На овом уређају нису инсталирани други енглески гласови.';

  @override
  String get speechPace => 'Темпо';

  @override
  String get slower => 'Спорије';

  @override
  String get faster => 'Брже';

  @override
  String get hearIt => 'Послушај';

  @override
  String get lightSection => 'Светлост';

  @override
  String get lightCaption => 'пергамент или светлост свеће';

  @override
  String get themeSystem => 'Према уређају';

  @override
  String get themeLight => 'Пергамент';

  @override
  String get themeDark => 'Светлост свеће';

  @override
  String get tongueSection => 'Језик';

  @override
  String get aboutSection => 'О апликацији';

  @override
  String get aboutCaption => 'како је настало';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Лиценце отвореног кода';

  @override
  String get shareGloss => 'Подели Gloss';

  @override
  String get followTheMaker => 'Прати аутора';

  @override
  String couldNotOpenLink(String label) {
    return 'Није могуће отворити $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Читај објашњења на језику $language';
  }

  @override
  String get readExplanationsCaption => 'Сама реч се увек чита на енглеском.';

  @override
  String noVoiceInstalled(String language) {
    return 'Овај уређај нема инсталиран глас за језик $language.';
  }

  @override
  String get memorySection => 'Памћење';

  @override
  String get memoryCaption => 'шта Gloss чува';

  @override
  String get forgetProgress => 'Заборави мој напредак';

  @override
  String get forgetProgressBody =>
      'Речима које сте истражили биће уклоњена ознака. Сачуване речи остају.';

  @override
  String get clearSavedWords => 'Обриши сачуване речи';

  @override
  String get clearSavedWordsBody =>
      'Речи које сте сачували биће уклоњене. Ваш напредак остаје.';

  @override
  String get cancel => 'Одустани';

  @override
  String get forget => 'Заборави';

  @override
  String get clear => 'Обриши';

  @override
  String get progressForgotten => 'Напредак заборављен.';

  @override
  String get savedWordsCleared => 'Сачуване речи обрисане.';

  @override
  String get contactTitle => 'Пишите творцу';

  @override
  String get contactCaption => 'писмо, ако желите';

  @override
  String get contactBlurb =>
      'Gloss прави један човек. Реч која вам недостаје, грешка коју сте нашли, ред који вам се допао — све стиже на исти сто.';

  @override
  String get contactLetterSection => 'Писмо';

  @override
  String get contactName => 'Ваше име';

  @override
  String get contactNameHint => 'Име којим ћемо вас поздравити';

  @override
  String get contactEmail => 'Ваша е-пошта';

  @override
  String get contactEmailHint => 'Где вас одговор може наћи';

  @override
  String contactEmailTypo(String domain) {
    return 'Да ли сте мислили $domain?';
  }

  @override
  String get contactReason => 'Разлог поруке';

  @override
  String get reasonWord => 'Реч коју треба додати';

  @override
  String get reasonProblem => 'Нешто није у реду';

  @override
  String get reasonQuestion => 'Питање';

  @override
  String get reasonPraise => 'Повратна реч';

  @override
  String get reasonOther => 'Нешто друго';

  @override
  String get contactPriority => 'Колико је хитно';

  @override
  String get priorityLow => 'Ниска';

  @override
  String get priorityNormal => 'Уобичајена';

  @override
  String get priorityHigh => 'Висока';

  @override
  String get contactMessage => 'Ваша порука';

  @override
  String get contactMessageHint => 'Пишите колико год желите, или сасвим мало…';

  @override
  String get contactHumanCheck => 'Једна реч пре слања';

  @override
  String contactHumanQuestion(String word) {
    return 'Које значење припада речи $word?';
  }

  @override
  String get contactHumanRetry => 'Не то. Ево друге речи.';

  @override
  String get contactDetails => 'Приложи податке о апликацији';

  @override
  String get contactDetailsCaption =>
      'Верзија, језик, светло и величина текста, да се грешка пре нађе.';

  @override
  String get contactSend => 'Пошаљи писмо';

  @override
  String get contactCopyLetter => 'Копирај писмо';

  @override
  String get contactDraftRestored => 'Овде је чекало непослато писмо.';

  @override
  String get contactNoMailApp =>
      'Ниједна апликација за пошту није одговорила, писмо је остало у остави.';

  @override
  String get contactNeedName => 'Име, да одговор зна кога поздравља.';

  @override
  String get contactNeedEmail => 'Адреса до које одговор може стићи.';

  @override
  String get contactNeedMessage => 'Бар ред или два.';

  @override
  String get contactSent => 'Ваше писмо је на путу. Хвала.';

  @override
  String get contactSendFailed =>
      'Писмо сада није могло да се пошаље. У остави је и остаје овде.';

  @override
  String get contactSendByMail => 'Уместо тога користи апликацију за пошту';
}
