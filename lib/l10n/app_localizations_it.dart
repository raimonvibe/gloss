// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un lessico di bella lingua';

  @override
  String get navHome => 'Inizio';

  @override
  String get navLexicon => 'Lessico';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Salvate';

  @override
  String get navLanguages => 'Lingue';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count parole rare e ricche dal lessico $lexicon — spiegate come farebbe un amico, non un dizionario.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current parole esplorate su $total';
  }

  @override
  String get exploreLexicon => 'Esplora il lessico';

  @override
  String get startQuiz => 'Inizia un quiz';

  @override
  String get wordOfTheDay => 'parola del giorno';

  @override
  String get readFullEntry => 'Leggi la voce intera →';

  @override
  String get lexiconTitle => 'Il lessico';

  @override
  String get lexiconCaption => 'la raccolta';

  @override
  String get savedTitle => 'Parole salvate';

  @override
  String get savedCaption => 'tenute vicine';

  @override
  String get searchHint => 'Cerca una parola, o descrivine il senso…';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get filterAll => 'Tutte';

  @override
  String get noMatches =>
      'Ancora nessuna corrispondenza — prova un’altra parola o un altro sentire.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n corrispondenze',
      one: '1 corrispondenza',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'niente qui';

  @override
  String get emptyLexicon => 'Niente in questo angolo del lessico.';

  @override
  String get emptySaved =>
      'Nessuna parola salvata ancora. Tocca il cuore su una voce.';

  @override
  String get tapToReadMore => 'Tocca per leggere oltre';

  @override
  String get saveWord => 'Salva parola';

  @override
  String get removeFromFavorites => 'Rimuovi dai preferiti';

  @override
  String get inPlainWords => 'in parole semplici';

  @override
  String get theDefinition => 'la definizione';

  @override
  String get inASentence => 'in una frase';

  @override
  String get exampleGlossLabel => 'in altre parole';

  @override
  String get save => 'Salva';

  @override
  String get saved => 'Salvata';

  @override
  String get copy => 'Copia';

  @override
  String get copiedToClipboard => 'Copiato negli appunti';

  @override
  String get roots => 'radici';

  @override
  String get quizTitle => 'Un piccolo quiz';

  @override
  String get quizCaption => 'conosci le radici, poi scegli il senso';

  @override
  String get quizIntro =>
      'Ogni domanda mostra una parola e la sua etimologia. Scegli la definizione che calza — quattro scelte, una vera.';

  @override
  String get howManyWords => 'quante parole';

  @override
  String get begin => 'Inizia';

  @override
  String get quizByTheme => 'Quiz per tema';

  @override
  String get endQuiz => 'Termina quiz';

  @override
  String questionOf(int index, int length) {
    return 'Domanda $index di $length';
  }

  @override
  String get whichDefinitionFits => 'quale definizione calza?';

  @override
  String get previous => 'Precedente';

  @override
  String get next => 'Successiva';

  @override
  String get seeResults => 'Vedi i risultati';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'scegli un argomento';

  @override
  String get noThemesYet => 'Ancora nessun tema.';

  @override
  String get notEnoughWordsInTheme =>
      'Non ci sono ancora abbastanza parole in questo tema.';

  @override
  String get results => 'Risultati';

  @override
  String get perfectPage => 'una pagina perfetta';

  @override
  String get wellMarked => 'ben segnato';

  @override
  String get tryAnotherRound => 'Prova un altro giro';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definizioni giuste',
      one: '1 definizione giusta',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definizioni giuste, su $total.',
      one: 'Una definizione giusta, su $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Passa alla modalità chiara';

  @override
  String get switchToDarkMode => 'Passa alla modalità scura';

  @override
  String get listen => 'Ascolta';

  @override
  String get stop => 'Ferma';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Lingue';

  @override
  String get languagesCaption => 'le lingue';

  @override
  String get searchLanguages => 'Cerca un paese o una lingua…';

  @override
  String get noMatchingLanguages => 'Nessun paese o lingua corrispondente.';

  @override
  String get selectedLanguage => 'Lettura in';

  @override
  String get continentAfrica => 'Africa';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Americhe';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current di $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Anche $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Come in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Dal $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, significato $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In parole semplici: $friendly';
  }

  @override
  String get categorySpeech => 'Parola e retorica';

  @override
  String get categoryCharacter => 'Carattere e temperamento';

  @override
  String get categoryCriticism => 'Critica e insulto';

  @override
  String get categoryVirtue => 'Virtù';

  @override
  String get categoryVice => 'Vizio';

  @override
  String get categoryKnowledge => 'Sapere e pensiero';

  @override
  String get categoryReligion => 'Religione e spirito';

  @override
  String get categoryBeginnings => 'Inizi';

  @override
  String get categoryConflict => 'Conflitto e inganno';

  @override
  String get categoryAppearance => 'Aspetto e luce';

  @override
  String get categoryPeople => 'Persone e ruoli';

  @override
  String get categoryObjects => 'Oggetti e cose';

  @override
  String get categoryEmotion => 'Emozione';

  @override
  String get categoryArchaic => 'Antico e arcaico';
}
