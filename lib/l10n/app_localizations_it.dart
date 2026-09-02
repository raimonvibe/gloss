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

  @override
  String get navStudy => 'Studio';

  @override
  String get studyTitle => 'Lo studio';

  @override
  String get studyCaption => 'lettura, voce e luce';

  @override
  String get readingSection => 'Lettura';

  @override
  String get readingCaption => 'come si posa la pagina';

  @override
  String get textSize => 'Dimensione del testo';

  @override
  String get textSizeSample => 'Edulcorate — addolcire, ammorbidire.';

  @override
  String get smaller => 'Più piccolo';

  @override
  String get larger => 'Più grande';

  @override
  String get autoplayPronunciation =>
      'Leggi la parola ad alta voce quando si apre';

  @override
  String get reduceMotion => 'Calma gli ornamenti';

  @override
  String get reduceMotionCaption => 'meno svolazzi e sfumature';

  @override
  String get voiceSection => 'Voce';

  @override
  String get voiceCaption => 'come Gloss legge ad alta voce';

  @override
  String get chooseVoice => 'Voce';

  @override
  String get voiceDefault => 'Scelta per te';

  @override
  String get noOtherVoices =>
      'Non ci sono altre voci inglesi installate su questo dispositivo.';

  @override
  String get speechPace => 'Andatura';

  @override
  String get slower => 'Più lento';

  @override
  String get faster => 'Più veloce';

  @override
  String get hearIt => 'Ascoltala';

  @override
  String get lightSection => 'Luce';

  @override
  String get lightCaption => 'pergamena o lume di candela';

  @override
  String get themeSystem => 'Segui il dispositivo';

  @override
  String get themeLight => 'Pergamena';

  @override
  String get themeDark => 'Lume di candela';

  @override
  String get tongueSection => 'Lingua';

  @override
  String get aboutSection => 'Informazioni';

  @override
  String get aboutCaption => 'come è stato fatto';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licenze open source';

  @override
  String get shareGloss => 'Condividi Gloss';

  @override
  String get followTheMaker => 'Segui l\'autore';

  @override
  String couldNotOpenLink(String label) {
    return 'Impossibile aprire $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Leggi le spiegazioni in $language';
  }

  @override
  String get readExplanationsCaption =>
      'La parola stessa viene sempre letta in inglese.';

  @override
  String noVoiceInstalled(String language) {
    return 'Questo dispositivo non ha una voce $language installata.';
  }

  @override
  String get memorySection => 'Memoria';

  @override
  String get memoryCaption => 'ciò che Gloss conserva';

  @override
  String get forgetProgress => 'Dimentica i miei progressi';

  @override
  String get forgetProgressBody =>
      'Le parole che hai esplorato perderanno il segno. Le parole salvate restano.';

  @override
  String get clearSavedWords => 'Cancella le parole salvate';

  @override
  String get clearSavedWordsBody =>
      'Le parole che hai conservato saranno rimosse. I tuoi progressi restano.';

  @override
  String get cancel => 'Annulla';

  @override
  String get forget => 'Dimentica';

  @override
  String get clear => 'Cancella';

  @override
  String get progressForgotten => 'Progressi dimenticati.';

  @override
  String get savedWordsCleared => 'Parole salvate cancellate.';

  @override
  String get contactTitle => 'Scrivi all\'autore';

  @override
  String get contactCaption => 'una lettera, se vuoi';

  @override
  String get contactBlurb =>
      'Gloss è fatto da una sola persona. Una parola che ti manca, un errore che hai trovato, una riga che ti è piaciuta — arriva tutto sulla stessa scrivania.';

  @override
  String get contactLetterSection => 'La lettera';

  @override
  String get contactName => 'Il tuo nome';

  @override
  String get contactNameHint => 'Il nome con cui salutarti';

  @override
  String get contactEmail => 'La tua e-mail';

  @override
  String get contactEmailHint => 'Dove una risposta può trovarti';

  @override
  String contactEmailTypo(String domain) {
    return 'Intendevi $domain?';
  }

  @override
  String get contactReason => 'Motivo del messaggio';

  @override
  String get reasonWord => 'Una parola da aggiungere';

  @override
  String get reasonProblem => 'Qualcosa non va';

  @override
  String get reasonQuestion => 'Una domanda';

  @override
  String get reasonPraise => 'Commenti';

  @override
  String get reasonOther => 'Altro';

  @override
  String get contactPriority => 'Quanto è urgente';

  @override
  String get priorityLow => 'Bassa';

  @override
  String get priorityNormal => 'Normale';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get contactMessage => 'Il tuo messaggio';

  @override
  String get contactMessageHint => 'Scrivi quanto vuoi, o pochissimo…';

  @override
  String get contactHumanCheck => 'Una parola prima di inviare';

  @override
  String contactHumanQuestion(String word) {
    return 'Quale significato appartiene a $word?';
  }

  @override
  String get contactHumanRetry => 'Non quello. Ecco un\'altra parola.';

  @override
  String get contactDetails => 'Allega i dettagli dell\'app';

  @override
  String get contactDetailsCaption =>
      'Versione, lingua, luce e dimensione del testo, così un errore si trova prima.';

  @override
  String get contactSend => 'Invia la lettera';

  @override
  String get contactCopyLetter => 'Copia la lettera';

  @override
  String get contactDraftRestored => 'Qui aspettava una lettera non inviata.';

  @override
  String get contactNoMailApp =>
      'Nessuna app di posta ha risposto, così la lettera è negli appunti.';

  @override
  String get contactNeedName =>
      'Un nome, perché la risposta sappia chi salutare.';

  @override
  String get contactNeedEmail =>
      'Un indirizzo che una risposta possa raggiungere.';

  @override
  String get contactNeedMessage => 'Almeno una riga o due.';

  @override
  String get contactSent => 'La tua lettera è in viaggio. Grazie.';

  @override
  String get contactSendFailed =>
      'La lettera non è stata inviata per ora. È negli appunti e resta qui.';

  @override
  String get contactSendByMail => 'Usa invece un\'app di posta';
}
