// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'әдемі тіл лексиконы';

  @override
  String get navHome => 'Басты бет';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Сұрақнама';

  @override
  String get navSaved => 'Сақталған';

  @override
  String get navLanguages => 'Тілдер';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon лексиконынан $count сирек, бай сөз — сөздікше емес, дос түсіндіргендей.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total сөздің $current-і зерттелді';
  }

  @override
  String get exploreLexicon => 'Лексиконды зерттеу';

  @override
  String get startQuiz => 'Сұрақнама бастау';

  @override
  String get wordOfTheDay => 'күннің сөзі';

  @override
  String get readFullEntry => 'Толық мақаланы оқу →';

  @override
  String get lexiconTitle => 'Лексикон';

  @override
  String get lexiconCaption => 'жинақ';

  @override
  String get savedTitle => 'Сақталған сөздер';

  @override
  String get savedCaption => 'жүрекке жақын';

  @override
  String get searchHint => 'Сөз іздеңіз немесе мағынасын сипаттаңыз…';

  @override
  String get clearSearch => 'Іздеуді тазалау';

  @override
  String get filterAll => 'Барлығы';

  @override
  String get noMatches =>
      'Әлі сәйкестік жоқ — басқа сөз немесе сезім байқап көріңіз.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n сәйкестік',
      one: '1 сәйкестік',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'мұнда ештеңе жоқ';

  @override
  String get emptyLexicon => 'Лексиконның осы бұрышында ештеңе жоқ.';

  @override
  String get emptySaved =>
      'Әлі сақталған сөз жоқ. Кез келген мақаладағы жүрекшені түртіңіз.';

  @override
  String get tapToReadMore => 'Әрі қарай оқу үшін түртіңіз';

  @override
  String get saveWord => 'Сөзді сақтау';

  @override
  String get removeFromFavorites => 'Таңдаулыдан шығару';

  @override
  String get inPlainWords => 'қарапайым сөзбен';

  @override
  String get theDefinition => 'анықтама';

  @override
  String get inASentence => 'сөйлемде';

  @override
  String get exampleGlossLabel => 'басқаша айтқанда';

  @override
  String get save => 'Сақтау';

  @override
  String get saved => 'Сақталды';

  @override
  String get copy => 'Көшіру';

  @override
  String get copiedToClipboard => 'Алмасу буферіне көшірілді';

  @override
  String get roots => 'түбірлер';

  @override
  String get quizTitle => 'Кішкентай сұрақнама';

  @override
  String get quizCaption => 'түбірлерді біл, сосын мағынаны таңда';

  @override
  String get quizIntro =>
      'Әр сұрақ сөз бен оның этимологиясын көрсетеді. Жарасатын анықтаманы таңдаңыз — төрт нұсқа, біреуі дұрыс.';

  @override
  String get howManyWords => 'қанша сөз';

  @override
  String get begin => 'Бастау';

  @override
  String get quizByTheme => 'Тақырып бойынша сұрақнама';

  @override
  String get endQuiz => 'Сұрақнаманы аяқтау';

  @override
  String questionOf(int index, int length) {
    return 'Сұрақ $index / $length';
  }

  @override
  String get whichDefinitionFits => 'қай анықтама жарасады?';

  @override
  String get previous => 'Алдыңғы';

  @override
  String get next => 'Келесі';

  @override
  String get seeResults => 'Нәтижелерді көру';

  @override
  String get themeTitle => 'Тақырып';

  @override
  String get chooseASubject => 'пән таңдаңыз';

  @override
  String get noThemesYet => 'Әлі тақырып жоқ.';

  @override
  String get notEnoughWordsInTheme => 'Бұл тақырыпта әлі жеткілікті сөз жоқ.';

  @override
  String get results => 'Нәтижелер';

  @override
  String get perfectPage => 'кемел бет';

  @override
  String get wellMarked => 'әдемі белгіленген';

  @override
  String get tryAnotherRound => 'Тағы бір айналым байқап көріңіз';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score дұрыс анықтама',
      one: '1 дұрыс анықтама',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score дұрыс анықтама, $total ішінен.',
      one: 'Бір дұрыс анықтама, $total ішінен.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Жарық режимге өту';

  @override
  String get switchToDarkMode => 'Қараңғы режимге өту';

  @override
  String get listen => 'Тыңдау';

  @override
  String get stop => 'Тоқтату';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Тілдер';

  @override
  String get languagesCaption => 'тілдер';

  @override
  String get searchLanguages => 'Ел немесе тіл іздеңіз…';

  @override
  String get noMatchingLanguages => 'Сәйкес ел немесе тіл жоқ.';

  @override
  String get selectedLanguage => 'Оқу тілі';

  @override
  String get continentAfrica => 'Африка';

  @override
  String get continentAsia => 'Азия';

  @override
  String get continentEurope => 'Еуропа';

  @override
  String get continentAmericas => 'Америка';

  @override
  String get continentOceania => 'Океания';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Сондай-ақ $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Мысалы: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin тілінен, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, мағынасы $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Қарапайым сөзбен: $friendly';
  }

  @override
  String get categorySpeech => 'Сөйлеу және риторика';

  @override
  String get categoryCharacter => 'Мінез және темперамент';

  @override
  String get categoryCriticism => 'Сын және қорлау';

  @override
  String get categoryVirtue => 'Ізгілік';

  @override
  String get categoryVice => 'Кемшілік';

  @override
  String get categoryKnowledge => 'Білім және ой';

  @override
  String get categoryReligion => 'Дін және рух';

  @override
  String get categoryBeginnings => 'Бастаулар';

  @override
  String get categoryConflict => 'Қақтығыс және алдау';

  @override
  String get categoryAppearance => 'Кескін және жарық';

  @override
  String get categoryPeople => 'Адамдар және рөлдер';

  @override
  String get categoryObjects => 'Заттар мен нәрселер';

  @override
  String get categoryEmotion => 'Эмоция';

  @override
  String get categoryArchaic => 'Ескі және архаикалық';
}
