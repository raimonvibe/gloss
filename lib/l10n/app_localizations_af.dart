// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '\'n leksikon van lieflike taal';

  @override
  String get navHome => 'Tuis';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Vasvra';

  @override
  String get navSaved => 'Gestoor';

  @override
  String get navLanguages => 'Tale';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count skaars, ryk woorde uit die $lexicon-leksikon — verduidelik soos \'n vriend dit sou doen, nie \'n woordeboek nie.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current van $total woorde verken';
  }

  @override
  String get exploreLexicon => 'Verken die leksikon';

  @override
  String get startQuiz => 'Begin \'n vasvra';

  @override
  String get wordOfTheDay => 'woord van die dag';

  @override
  String get readFullEntry => 'Lees die volle inskrywing →';

  @override
  String get lexiconTitle => 'Die leksikon';

  @override
  String get lexiconCaption => 'die versameling';

  @override
  String get savedTitle => 'Gestoorde woorde';

  @override
  String get savedCaption => 'naby gehou';

  @override
  String get searchHint => 'Soek \'n woord, of beskryf die betekenis…';

  @override
  String get clearSearch => 'Maak soektog skoon';

  @override
  String get filterAll => 'Alles';

  @override
  String get noMatches =>
      'Nog geen treffers nie — probeer \'n ander woord of gevoel.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treffers',
      one: '1 treffer',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'niks hier nie';

  @override
  String get emptyLexicon => 'Niks in hierdie hoek van die leksikon nie.';

  @override
  String get emptySaved =>
      'Nog geen gestoorde woorde nie. Tik op die hartjie by enige inskrywing.';

  @override
  String get tapToReadMore => 'Tik om verder te lees';

  @override
  String get saveWord => 'Stoor woord';

  @override
  String get removeFromFavorites => 'Verwyder uit gunstelinge';

  @override
  String get inPlainWords => 'in eenvoudige woorde';

  @override
  String get theDefinition => 'die definisie';

  @override
  String get inASentence => 'in \'n sin';

  @override
  String get exampleGlossLabel => 'met ander woorde';

  @override
  String get save => 'Stoor';

  @override
  String get saved => 'Gestoor';

  @override
  String get copy => 'Kopieer';

  @override
  String get copiedToClipboard => 'Na die knipbord gekopieer';

  @override
  String get roots => 'wortels';

  @override
  String get quizTitle => '\'n Klein vasvra';

  @override
  String get quizCaption => 'ken die wortels, kies dan die betekenis';

  @override
  String get quizIntro =>
      'Elke vraag toon \'n woord en sy etimologie. Kies die definisie wat pas — vier keuses, een waar.';

  @override
  String get howManyWords => 'hoeveel woorde';

  @override
  String get begin => 'Begin';

  @override
  String get quizByTheme => 'Vasvra per tema';

  @override
  String get endQuiz => 'Beëindig vasvra';

  @override
  String questionOf(int index, int length) {
    return 'Vraag $index van $length';
  }

  @override
  String get whichDefinitionFits => 'watter definisie pas?';

  @override
  String get previous => 'Vorige';

  @override
  String get next => 'Volgende';

  @override
  String get seeResults => 'Sien resultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'kies \'n onderwerp';

  @override
  String get noThemesYet => 'Nog geen temas nie.';

  @override
  String get notEnoughWordsInTheme =>
      'Nog nie genoeg woorde in hierdie tema nie.';

  @override
  String get results => 'Resultate';

  @override
  String get perfectPage => '\'n volmaakte blad';

  @override
  String get wellMarked => 'mooi gemerk';

  @override
  String get tryAnotherRound => 'Probeer nog \'n ronde';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisies reg',
      one: '1 definisie reg',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisies reg, van $total.',
      one: 'Een definisie reg, van $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Skakel oor na ligte modus';

  @override
  String get switchToDarkMode => 'Skakel oor na donker modus';

  @override
  String get listen => 'Luister';

  @override
  String get stop => 'Stop';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Tale';

  @override
  String get languagesCaption => 'die tongvalle';

  @override
  String get searchLanguages => 'Soek \'n land of taal…';

  @override
  String get noMatchingLanguages => 'Geen ooreenstemmende lande of tale nie.';

  @override
  String get selectedLanguage => 'Lees in';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asië';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oseanië';

  @override
  String currentOfTotal(int current, int total) {
    return '$current van $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Ook $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Soos in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Uit $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betekenis $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In eenvoudige woorde: $friendly';
  }

  @override
  String get categorySpeech => 'Spraak & Retoriek';

  @override
  String get categoryCharacter => 'Karakter & Temperament';

  @override
  String get categoryCriticism => 'Kritiek & Belediging';

  @override
  String get categoryVirtue => 'Deug';

  @override
  String get categoryVice => 'Ondeugd';

  @override
  String get categoryKnowledge => 'Kennis & Denke';

  @override
  String get categoryReligion => 'Godsdiens & Gees';

  @override
  String get categoryBeginnings => 'Beginne';

  @override
  String get categoryConflict => 'Stryd & Bedrog';

  @override
  String get categoryAppearance => 'Voorkoms & Lig';

  @override
  String get categoryPeople => 'Mense & Rolle';

  @override
  String get categoryObjects => 'Voorwerpe & Dinge';

  @override
  String get categoryEmotion => 'Emosie';

  @override
  String get categoryArchaic => 'Oud & Argais';
}
