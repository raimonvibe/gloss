// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon lijepe riječi';

  @override
  String get navHome => 'Početna';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kviz';

  @override
  String get navSaved => 'Spremljeno';

  @override
  String get navLanguages => 'Jezici';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count rijetkih, bogatih riječi iz leksikona $lexicon — objašnjenih kako bi ih objasnio prijatelj, ne rječnik.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'istraženo $current od $total riječi';
  }

  @override
  String get exploreLexicon => 'Istraži leksikon';

  @override
  String get startQuiz => 'Započni kviz';

  @override
  String get wordOfTheDay => 'riječ dana';

  @override
  String get readFullEntry => 'Pročitaj cijeli unos →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'zbirka';

  @override
  String get savedTitle => 'Spremljene riječi';

  @override
  String get savedCaption => 'blizu srca';

  @override
  String get searchHint => 'Potraži riječ ili opiši njezino značenje…';

  @override
  String get clearSearch => 'Očisti pretragu';

  @override
  String get filterAll => 'Sve';

  @override
  String get noMatches =>
      'Još nema poklapanja — pokušaj drugu riječ ili osjećaj.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n poklapanja',
      one: '1 poklapanje',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ovdje ništa';

  @override
  String get emptyLexicon => 'U ovom kutu leksikona nema ničega.';

  @override
  String get emptySaved =>
      'Još nema spremljenih riječi. Dodirni srce na bilo kojem unosu.';

  @override
  String get tapToReadMore => 'Dodirni za daljnje čitanje';

  @override
  String get saveWord => 'Spremi riječ';

  @override
  String get removeFromFavorites => 'Ukloni iz omiljenih';

  @override
  String get inPlainWords => 'prostih riječi';

  @override
  String get theDefinition => 'definicija';

  @override
  String get inASentence => 'u rečenici';

  @override
  String get exampleGlossLabel => 'drugim riječima';

  @override
  String get save => 'Spremi';

  @override
  String get saved => 'Spremljeno';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copiedToClipboard => 'Kopirano u međuspremnik';

  @override
  String get roots => 'korijeni';

  @override
  String get quizTitle => 'Mali kviz';

  @override
  String get quizCaption => 'upoznaj korijene, zatim odaberi značenje';

  @override
  String get quizIntro =>
      'Svako pitanje pokazuje riječ i njezinu etimologiju. Odaberi definiciju koja pristaje — četiri izbora, jedan točan.';

  @override
  String get howManyWords => 'koliko riječi';

  @override
  String get begin => 'Počni';

  @override
  String get quizByTheme => 'Kviz po temi';

  @override
  String get endQuiz => 'Završi kviz';

  @override
  String questionOf(int index, int length) {
    return 'Pitanje $index od $length';
  }

  @override
  String get whichDefinitionFits => 'koja definicija pristaje?';

  @override
  String get previous => 'Prethodno';

  @override
  String get next => 'Sljedeće';

  @override
  String get seeResults => 'Pogledaj rezultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'odaberi predmet';

  @override
  String get noThemesYet => 'Još nema tema.';

  @override
  String get notEnoughWordsInTheme => 'U ovoj temi još nema dovoljno riječi.';

  @override
  String get results => 'Rezultati';

  @override
  String get perfectPage => 'savršena stranica';

  @override
  String get wellMarked => 'lijepo zabilježeno';

  @override
  String get tryAnotherRound => 'Pokušaj još jedan krug';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score točnih definicija',
      one: '1 točna definicija',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score točnih definicija, od $total.',
      one: 'Jedna točna definicija, od $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Prijeđi na svijetli način';

  @override
  String get switchToDarkMode => 'Prijeđi na tamni način';

  @override
  String get listen => 'Slušaj';

  @override
  String get stop => 'Zaustavi';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jezici';

  @override
  String get languagesCaption => 'jezici';

  @override
  String get searchLanguages => 'Potraži zemlju ili jezik…';

  @override
  String get noMatchingLanguages => 'Nema odgovarajućih zemalja ni jezika.';

  @override
  String get selectedLanguage => 'Čitanje na';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azija';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanija';

  @override
  String currentOfTotal(int current, int total) {
    return '$current od $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Također $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kao u: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Iz $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, značenje $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Prostih riječi: $friendly';
  }

  @override
  String get categorySpeech => 'Govor i retorika';

  @override
  String get categoryCharacter => 'Karakter i temperament';

  @override
  String get categoryCriticism => 'Kritika i uvreda';

  @override
  String get categoryVirtue => 'Krepost';

  @override
  String get categoryVice => 'Porok';

  @override
  String get categoryKnowledge => 'Znanje i misao';

  @override
  String get categoryReligion => 'Vjera i duh';

  @override
  String get categoryBeginnings => 'Počeci';

  @override
  String get categoryConflict => 'Sukob i prijevara';

  @override
  String get categoryAppearance => 'Izgled i svjetlo';

  @override
  String get categoryPeople => 'Ljudi i uloge';

  @override
  String get categoryObjects => 'Predmeti i stvari';

  @override
  String get categoryEmotion => 'Emocija';

  @override
  String get categoryArchaic => 'Staro i arhaično';
}
