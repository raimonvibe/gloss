// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksykon pięknej mowy';

  @override
  String get navHome => 'Start';

  @override
  String get navLexicon => 'Leksykon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Zapisane';

  @override
  String get navLanguages => 'Języki';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count rzadkich, bogatych słów z leksykonu $lexicon — objaśnionych tak, jak zrobiłby to przyjaciel, nie słownik.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'zbadano $current z $total słów';
  }

  @override
  String get exploreLexicon => 'Zbadaj leksykon';

  @override
  String get startQuiz => 'Rozpocznij quiz';

  @override
  String get wordOfTheDay => 'słowo dnia';

  @override
  String get readFullEntry => 'Przeczytaj cały wpis →';

  @override
  String get lexiconTitle => 'Leksykon';

  @override
  String get lexiconCaption => 'zbiór';

  @override
  String get savedTitle => 'Zapisane słowa';

  @override
  String get savedCaption => 'trzymane blisko';

  @override
  String get searchHint => 'Szukaj słowa albo opisz jego znaczenie…';

  @override
  String get clearSearch => 'Wyczyść wyszukiwanie';

  @override
  String get filterAll => 'Wszystkie';

  @override
  String get noMatches =>
      'Na razie brak trafień — spróbuj innego słowa lub uczucia.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n trafień',
      one: '1 trafienie',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nic tu nie ma';

  @override
  String get emptyLexicon => 'W tym zakątku leksykonu nic nie ma.';

  @override
  String get emptySaved =>
      'Nie ma jeszcze zapisanych słów. Dotknij serca przy dowolnym wpisie.';

  @override
  String get tapToReadMore => 'Dotknij, by czytać dalej';

  @override
  String get saveWord => 'Zapisz słowo';

  @override
  String get removeFromFavorites => 'Usuń z ulubionych';

  @override
  String get inPlainWords => 'prostymi słowami';

  @override
  String get theDefinition => 'definicja';

  @override
  String get inASentence => 'w zdaniu';

  @override
  String get exampleGlossLabel => 'innymi słowy';

  @override
  String get save => 'Zapisz';

  @override
  String get saved => 'Zapisano';

  @override
  String get copy => 'Kopiuj';

  @override
  String get copiedToClipboard => 'Skopiowano do schowka';

  @override
  String get roots => 'rdzenie';

  @override
  String get quizTitle => 'Mały quiz';

  @override
  String get quizCaption => 'poznaj rdzenie, potem wybierz znaczenie';

  @override
  String get quizIntro =>
      'Każde pytanie pokazuje słowo i jego etymologię. Wybierz definicję, która pasuje — cztery wybory, jeden prawdziwy.';

  @override
  String get howManyWords => 'ile słów';

  @override
  String get begin => 'Zacznij';

  @override
  String get quizByTheme => 'Quiz według motywu';

  @override
  String get endQuiz => 'Zakończ quiz';

  @override
  String questionOf(int index, int length) {
    return 'Pytanie $index z $length';
  }

  @override
  String get whichDefinitionFits => 'która definicja pasuje?';

  @override
  String get previous => 'Poprzednie';

  @override
  String get next => 'Następne';

  @override
  String get seeResults => 'Zobacz wyniki';

  @override
  String get themeTitle => 'Motyw';

  @override
  String get chooseASubject => 'wybierz temat';

  @override
  String get noThemesYet => 'Nie ma jeszcze motywów.';

  @override
  String get notEnoughWordsInTheme => 'W tym motywie nie ma jeszcze dość słów.';

  @override
  String get results => 'Wyniki';

  @override
  String get perfectPage => 'doskonała karta';

  @override
  String get wellMarked => 'ładnie zaznaczone';

  @override
  String get tryAnotherRound => 'Spróbuj kolejnej rundy';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score trafnych definicji',
      one: '1 trafna definicja',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score trafnych definicji z $total.',
      one: 'Jedna trafna definicja z $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Przełącz na jasny motyw';

  @override
  String get switchToDarkMode => 'Przełącz na ciemny motyw';

  @override
  String get listen => 'Słuchaj';

  @override
  String get stop => 'Zatrzymaj';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Języki';

  @override
  String get languagesCaption => 'języki';

  @override
  String get searchLanguages => 'Szukaj kraju lub języka…';

  @override
  String get noMatchingLanguages => 'Brak pasujących krajów lub języków.';

  @override
  String get selectedLanguage => 'Czytanie w';

  @override
  String get continentAfrica => 'Afryka';

  @override
  String get continentAsia => 'Azja';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Ameryka';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current z $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Także $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Jak w: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Z $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, znaczenie $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Prostymi słowami: $friendly';
  }

  @override
  String get categorySpeech => 'Mowa i retoryka';

  @override
  String get categoryCharacter => 'Charakter i temperament';

  @override
  String get categoryCriticism => 'Krytyka i obelga';

  @override
  String get categoryVirtue => 'Cnota';

  @override
  String get categoryVice => 'Wada';

  @override
  String get categoryKnowledge => 'Wiedza i myśl';

  @override
  String get categoryReligion => 'Religia i duch';

  @override
  String get categoryBeginnings => 'Początki';

  @override
  String get categoryConflict => 'Konflikt i podstęp';

  @override
  String get categoryAppearance => 'Wygląd i światło';

  @override
  String get categoryPeople => 'Ludzie i role';

  @override
  String get categoryObjects => 'Przedmioty i rzeczy';

  @override
  String get categoryEmotion => 'Emocja';

  @override
  String get categoryArchaic => 'Dawne i archaiczne';
}
