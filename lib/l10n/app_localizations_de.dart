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
  String get navStudy => 'Study';

  @override
  String get studyTitle => 'The study';

  @override
  String get studyCaption => 'reading, voice, and light';

  @override
  String get readingSection => 'Reading';

  @override
  String get readingCaption => 'how the page sits';

  @override
  String get textSize => 'Text size';

  @override
  String get textSizeSample => 'Edulcorate — to sweeten, to soften.';

  @override
  String get smaller => 'Smaller';

  @override
  String get larger => 'Larger';

  @override
  String get autoplayPronunciation => 'Read a word aloud when it opens';

  @override
  String get reduceMotion => 'Calm the ornaments';

  @override
  String get reduceMotionCaption => 'fewer flourishes and gradients';

  @override
  String get voiceSection => 'Voice';

  @override
  String get voiceCaption => 'how Gloss reads aloud';

  @override
  String get chooseVoice => 'Voice';

  @override
  String get voiceDefault => 'Chosen for you';

  @override
  String get noOtherVoices =>
      'No other English voices are installed on this device.';

  @override
  String get speechPace => 'Pace';

  @override
  String get slower => 'Slower';

  @override
  String get faster => 'Faster';

  @override
  String get hearIt => 'Hear it';

  @override
  String get lightSection => 'Light';

  @override
  String get lightCaption => 'parchment or candlelight';

  @override
  String get themeSystem => 'Match device';

  @override
  String get themeLight => 'Parchment';

  @override
  String get themeDark => 'Candlelight';

  @override
  String get tongueSection => 'Tongue';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutCaption => 'the making of it';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open-source licences';

  @override
  String get shareGloss => 'Share Gloss';

  @override
  String get followTheMaker => 'Follow the maker';

  @override
  String couldNotOpenLink(String label) {
    return 'Could not open $label.';
  }
}
