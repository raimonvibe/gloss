// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ein Lexikon lieblicher Sprache';

  @override
  String get navHome => 'Start';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Gespeichert';

  @override
  String get navLanguages => 'Sprachen';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count seltene, reiche Wörter aus dem $lexicon-Lexikon — erklärt, wie ein Freund sie erklären würde, nicht ein Wörterbuch.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current von $total Wörtern erkundet';
  }

  @override
  String get exploreLexicon => 'Das Lexikon erkunden';

  @override
  String get startQuiz => 'Ein Quiz beginnen';

  @override
  String get wordOfTheDay => 'Wort des Tages';

  @override
  String get readFullEntry => 'Den ganzen Eintrag lesen →';

  @override
  String get lexiconTitle => 'Das Lexikon';

  @override
  String get lexiconCaption => 'die Sammlung';

  @override
  String get savedTitle => 'Gespeicherte Wörter';

  @override
  String get savedCaption => 'nahe gehalten';

  @override
  String get searchHint => 'Suche ein Wort, oder beschreibe seine Bedeutung…';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get filterAll => 'Alle';

  @override
  String get noMatches =>
      'Noch keine Treffer — versuche ein anderes Wort oder Gefühl.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Treffer',
      one: '1 Treffer',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'hier nichts';

  @override
  String get emptyLexicon => 'In dieser Ecke des Lexikons ist nichts.';

  @override
  String get emptySaved =>
      'Noch keine gespeicherten Wörter. Tippe auf das Herz bei einem Eintrag.';

  @override
  String get tapToReadMore => 'Tippen, um weiterzulesen';

  @override
  String get saveWord => 'Wort speichern';

  @override
  String get removeFromFavorites => 'Aus den Favoriten entfernen';

  @override
  String get inPlainWords => 'in schlichten Worten';

  @override
  String get theDefinition => 'die Definition';

  @override
  String get inASentence => 'in einem Satz';

  @override
  String get exampleGlossLabel => 'anders gesagt';

  @override
  String get save => 'Speichern';

  @override
  String get saved => 'Gespeichert';

  @override
  String get copy => 'Kopieren';

  @override
  String get copiedToClipboard => 'In die Zwischenablage kopiert';

  @override
  String get roots => 'Wurzeln';

  @override
  String get quizTitle => 'Ein kleines Quiz';

  @override
  String get quizCaption => 'die Wurzeln kennen, dann die Bedeutung wählen';

  @override
  String get quizIntro =>
      'Jede Frage zeigt ein Wort und seine Etymologie. Wähle die passende Definition — vier Möglichkeiten, eine wahr.';

  @override
  String get howManyWords => 'wie viele Wörter';

  @override
  String get begin => 'Beginnen';

  @override
  String get quizByTheme => 'Quiz nach Thema';

  @override
  String get endQuiz => 'Quiz beenden';

  @override
  String questionOf(int index, int length) {
    return 'Frage $index von $length';
  }

  @override
  String get whichDefinitionFits => 'welche Definition passt?';

  @override
  String get previous => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get seeResults => 'Ergebnisse ansehen';

  @override
  String get themeTitle => 'Thema';

  @override
  String get chooseASubject => 'ein Thema wählen';

  @override
  String get noThemesYet => 'Noch keine Themen.';

  @override
  String get notEnoughWordsInTheme =>
      'In diesem Thema noch nicht genug Wörter.';

  @override
  String get results => 'Ergebnisse';

  @override
  String get perfectPage => 'eine makellose Seite';

  @override
  String get wellMarked => 'schön vermerkt';

  @override
  String get tryAnotherRound => 'Noch eine Runde';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score richtige Definitionen',
      one: '1 richtige Definition',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score richtige Definitionen, von $total.',
      one: 'Eine richtige Definition, von $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Zum hellen Modus wechseln';

  @override
  String get switchToDarkMode => 'Zum dunklen Modus wechseln';

  @override
  String get listen => 'Hören';

  @override
  String get stop => 'Stopp';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Sprachen';

  @override
  String get languagesCaption => 'die Zungen';

  @override
  String get searchLanguages => 'Suche ein Land oder eine Sprache…';

  @override
  String get noMatchingLanguages => 'Keine passenden Länder oder Sprachen.';

  @override
  String get selectedLanguage => 'Lesen auf';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asien';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Ozeanien';

  @override
  String currentOfTotal(int current, int total) {
    return '$current von $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Auch $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Wie in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Aus $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, Bedeutung $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In schlichten Worten: $friendly';
  }

  @override
  String get categorySpeech => 'Rede & Rhetorik';

  @override
  String get categoryCharacter => 'Charakter & Temperament';

  @override
  String get categoryCriticism => 'Kritik & Beleidigung';

  @override
  String get categoryVirtue => 'Tugend';

  @override
  String get categoryVice => 'Laster';

  @override
  String get categoryKnowledge => 'Wissen & Denken';

  @override
  String get categoryReligion => 'Religion & Geist';

  @override
  String get categoryBeginnings => 'Anfänge';

  @override
  String get categoryConflict => 'Konflikt & Täuschung';

  @override
  String get categoryAppearance => 'Erscheinung & Licht';

  @override
  String get categoryPeople => 'Menschen & Rollen';

  @override
  String get categoryObjects => 'Gegenstände & Dinge';

  @override
  String get categoryEmotion => 'Gefühl';

  @override
  String get categoryArchaic => 'Alt & archaisch';

  @override
  String get navStudy => 'Kabinett';

  @override
  String get studyTitle => 'Die Studierstube';

  @override
  String get studyCaption => 'Lesen, Stimme und Licht';

  @override
  String get readingSection => 'Lesen';

  @override
  String get readingCaption => 'wie die Seite sitzt';

  @override
  String get textSize => 'Schriftgröße';

  @override
  String get textSizeSample => 'Edulcorate — versüßen, mildern.';

  @override
  String get smaller => 'Kleiner';

  @override
  String get larger => 'Größer';

  @override
  String get autoplayPronunciation => 'Ein Wort beim Öffnen vorlesen';

  @override
  String get reduceMotion => 'Zierrat beruhigen';

  @override
  String get reduceMotionCaption => 'weniger Schnörkel und Verläufe';

  @override
  String get voiceSection => 'Stimme';

  @override
  String get voiceCaption => 'wie Gloss vorliest';

  @override
  String get chooseVoice => 'Stimme';

  @override
  String get voiceDefault => 'Für dich gewählt';

  @override
  String get noOtherVoices =>
      'Auf diesem Gerät sind keine weiteren englischen Stimmen installiert.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Langsamer';

  @override
  String get faster => 'Schneller';

  @override
  String get hearIt => 'Anhören';

  @override
  String get lightSection => 'Licht';

  @override
  String get lightCaption => 'Pergament oder Kerzenlicht';

  @override
  String get themeSystem => 'Gerät folgen';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Kerzenlicht';

  @override
  String get tongueSection => 'Zunge';

  @override
  String get aboutSection => 'Über';

  @override
  String get aboutCaption => 'wie es entstand';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open-Source-Lizenzen';

  @override
  String get shareGloss => 'Gloss teilen';

  @override
  String get followTheMaker => 'Dem Macher folgen';

  @override
  String couldNotOpenLink(String label) {
    return '$label konnte nicht geöffnet werden.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Erklärungen auf $language lesen';
  }

  @override
  String get readExplanationsCaption =>
      'Das Wort selbst wird immer auf Englisch gelesen.';

  @override
  String noVoiceInstalled(String language) {
    return 'Auf diesem Gerät ist keine $language-Stimme installiert.';
  }

  @override
  String get memorySection => 'Gedächtnis';

  @override
  String get memoryCaption => 'was Gloss behält';

  @override
  String get forgetProgress => 'Meinen Fortschritt vergessen';

  @override
  String get forgetProgressBody =>
      'Die erkundeten Wörter verlieren ihre Markierung. Ihre gespeicherten Wörter bleiben.';

  @override
  String get clearSavedWords => 'Gespeicherte Wörter löschen';

  @override
  String get clearSavedWordsBody =>
      'Die aufbewahrten Wörter werden entfernt. Ihr Fortschritt bleibt.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get forget => 'Vergessen';

  @override
  String get clear => 'Löschen';

  @override
  String get progressForgotten => 'Fortschritt vergessen.';

  @override
  String get savedWordsCleared => 'Gespeicherte Wörter gelöscht.';

  @override
  String get contactTitle => 'Schreib dem Macher';

  @override
  String get contactCaption => 'ein Brief, wenn du magst';

  @override
  String get contactBlurb =>
      'Gloss wird von einer einzigen Person gemacht. Ein Wort, das dir fehlt, ein Fehler, den du gefunden hast, eine Zeile, die dir gefiel — alles landet auf demselben Schreibtisch.';

  @override
  String get contactLetterSection => 'Der Brief';

  @override
  String get contactName => 'Dein Name';

  @override
  String get contactNameHint => 'Der Name, mit dem du gegrüßt wirst';

  @override
  String get contactEmail => 'Deine E-Mail-Adresse';

  @override
  String get contactEmailHint => 'Wo eine Antwort dich findet';

  @override
  String contactEmailTypo(String domain) {
    return 'Meintest du $domain?';
  }

  @override
  String get contactReason => 'Grund des Schreibens';

  @override
  String get reasonWord => 'Ein Wort für die Sammlung';

  @override
  String get reasonProblem => 'Etwas stimmt nicht';

  @override
  String get reasonQuestion => 'Eine Frage';

  @override
  String get reasonPraise => 'Rückmeldung';

  @override
  String get reasonOther => 'Etwas anderes';

  @override
  String get contactPriority => 'Wie dringend';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get contactMessage => 'Deine Nachricht';

  @override
  String get contactMessageHint =>
      'Schreib so viel oder so wenig, wie du magst…';

  @override
  String get contactHumanCheck => 'Ein Wort, bevor du sendest';

  @override
  String contactHumanQuestion(String word) {
    return 'Welche Bedeutung gehört zu $word?';
  }

  @override
  String get contactHumanRetry => 'Nicht diese. Hier ist ein anderes Wort.';

  @override
  String get contactDetails => 'App-Angaben mitschicken';

  @override
  String get contactDetailsCaption =>
      'Version, Sprache, Licht und Textgröße, damit ein Fehler leichter zu finden ist.';

  @override
  String get contactSend => 'Brief senden';

  @override
  String get contactCopyLetter => 'Brief kopieren';

  @override
  String get contactDraftRestored => 'Hier lag noch ein ungesendeter Brief.';

  @override
  String get contactNoMailApp =>
      'Keine Mail-App hat geantwortet, der Brief liegt in der Zwischenablage.';

  @override
  String get contactNeedName =>
      'Ein Name, damit die Antwort weiß, wen sie grüßt.';

  @override
  String get contactNeedEmail => 'Eine Adresse, die eine Antwort erreicht.';

  @override
  String get contactNeedMessage => 'Wenigstens ein paar Zeilen.';

  @override
  String get contactSent => 'Dein Brief ist unterwegs. Danke.';

  @override
  String get contactSendFailed =>
      'Der Brief ließ sich gerade nicht senden. Er liegt in der Zwischenablage und bleibt hier erhalten.';

  @override
  String get contactSendByMail => 'Stattdessen eine Mail-App verwenden';
}
