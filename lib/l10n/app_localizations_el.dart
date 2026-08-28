// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ένα λεξικό όμορφης γλώσσας';

  @override
  String get navHome => 'Αρχική';

  @override
  String get navLexicon => 'Λεξικό';

  @override
  String get navQuiz => 'Κουίζ';

  @override
  String get navSaved => 'Αποθηκευμένα';

  @override
  String get navLanguages => 'Γλώσσες';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count σπάνιες, πλούσιες λέξεις από το λεξικό $lexicon — εξηγημένες όπως θα τις εξηγούσε ένας φίλος, όχι ένα λεξικό.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'εξερευνήθηκαν $current από $total λέξεις';
  }

  @override
  String get exploreLexicon => 'Εξερεύνησε το λεξικό';

  @override
  String get startQuiz => 'Ξεκίνα ένα κουίζ';

  @override
  String get wordOfTheDay => 'λέξη της ημέρας';

  @override
  String get readFullEntry => 'Διάβασε όλο το λήμμα →';

  @override
  String get lexiconTitle => 'Το λεξικό';

  @override
  String get lexiconCaption => 'η συλλογή';

  @override
  String get savedTitle => 'Αποθηκευμένες λέξεις';

  @override
  String get savedCaption => 'κοντά στην καρδιά';

  @override
  String get searchHint => 'Αναζήτησε μια λέξη, ή περιέγραψε τη σημασία της…';

  @override
  String get clearSearch => 'Καθαρισμός αναζήτησης';

  @override
  String get filterAll => 'Όλα';

  @override
  String get noMatches =>
      'Δεν υπάρχουν ακόμη αποτελέσματα — δοκίμασε άλλη λέξη ή αίσθηση.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n αποτελέσματα',
      one: '1 αποτέλεσμα',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'τίποτα εδώ';

  @override
  String get emptyLexicon => 'Τίποτα σε αυτή τη γωνιά του λεξικού.';

  @override
  String get emptySaved =>
      'Δεν υπάρχουν ακόμη αποθηκευμένες λέξεις. Πάτα την καρδιά σε οποιοδήποτε λήμμα.';

  @override
  String get tapToReadMore => 'Πάτα για να διαβάσεις περισσότερα';

  @override
  String get saveWord => 'Αποθήκευση λέξης';

  @override
  String get removeFromFavorites => 'Αφαίρεση από τα αγαπημένα';

  @override
  String get inPlainWords => 'με απλά λόγια';

  @override
  String get theDefinition => 'ο ορισμός';

  @override
  String get inASentence => 'σε μια πρόταση';

  @override
  String get exampleGlossLabel => 'με άλλα λόγια';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get saved => 'Αποθηκευμένο';

  @override
  String get copy => 'Αντιγραφή';

  @override
  String get copiedToClipboard => 'Αντιγράφηκε στο πρόχειρο';

  @override
  String get roots => 'ρίζες';

  @override
  String get quizTitle => 'Ένα μικρό κουίζ';

  @override
  String get quizCaption => 'γνώρισε τις ρίζες, ύστερα διάλεξε τη σημασία';

  @override
  String get quizIntro =>
      'Κάθε ερώτηση δείχνει μια λέξη και την ετυμολογία της. Διάλεξε τον ορισμό που ταιριάζει — τέσσερις επιλογές, μία σωστή.';

  @override
  String get howManyWords => 'πόσες λέξεις';

  @override
  String get begin => 'Ξεκίνα';

  @override
  String get quizByTheme => 'Κουίζ ανά θέμα';

  @override
  String get endQuiz => 'Τέλος κουίζ';

  @override
  String questionOf(int index, int length) {
    return 'Ερώτηση $index από $length';
  }

  @override
  String get whichDefinitionFits => 'ποιος ορισμός ταιριάζει;';

  @override
  String get previous => 'Προηγούμενο';

  @override
  String get next => 'Επόμενο';

  @override
  String get seeResults => 'Δες τα αποτελέσματα';

  @override
  String get themeTitle => 'Θέμα';

  @override
  String get chooseASubject => 'διάλεξε θέμα';

  @override
  String get noThemesYet => 'Δεν υπάρχουν ακόμη θέματα.';

  @override
  String get notEnoughWordsInTheme =>
      'Δεν υπάρχουν ακόμη αρκετές λέξεις σε αυτό το θέμα.';

  @override
  String get results => 'Αποτελέσματα';

  @override
  String get perfectPage => 'μια τέλεια σελίδα';

  @override
  String get wellMarked => 'καλά σημειωμένο';

  @override
  String get tryAnotherRound => 'Δοκίμασε άλλον γύρο';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score σωστοί ορισμοί',
      one: '1 σωστός ορισμός',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score σωστοί ορισμοί, από $total.',
      one: 'Ένας σωστός ορισμός, από $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Μετάβαση σε φωτεινή εμφάνιση';

  @override
  String get switchToDarkMode => 'Μετάβαση σε σκοτεινή εμφάνιση';

  @override
  String get listen => 'Άκου';

  @override
  String get stop => 'Σταμάτα';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Γλώσσες';

  @override
  String get languagesCaption => 'οι γλώσσες';

  @override
  String get searchLanguages => 'Αναζήτησε χώρα ή γλώσσα…';

  @override
  String get noMatchingLanguages => 'Δεν υπάρχουν αντίστοιχες χώρες ή γλώσσες.';

  @override
  String get selectedLanguage => 'Ανάγνωση στα';

  @override
  String get continentAfrica => 'Αφρική';

  @override
  String get continentAsia => 'Ασία';

  @override
  String get continentEurope => 'Ευρώπη';

  @override
  String get continentAmericas => 'Αμερική';

  @override
  String get continentOceania => 'Ωκεανία';

  @override
  String currentOfTotal(int current, int total) {
    return '$current από $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Επίσης $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Όπως στο: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Από $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, σημασία $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Με απλά λόγια: $friendly';
  }

  @override
  String get categorySpeech => 'Λόγος και ρητορική';

  @override
  String get categoryCharacter => 'Χαρακτήρας και ιδιοσυγκρασία';

  @override
  String get categoryCriticism => 'Κριτική και προσβολή';

  @override
  String get categoryVirtue => 'Αρετή';

  @override
  String get categoryVice => 'Κακία';

  @override
  String get categoryKnowledge => 'Γνώση και σκέψη';

  @override
  String get categoryReligion => 'Θρησκεία και πνεύμα';

  @override
  String get categoryBeginnings => 'Αρχές';

  @override
  String get categoryConflict => 'Σύγκρουση και απάτη';

  @override
  String get categoryAppearance => 'Εμφάνιση και φως';

  @override
  String get categoryPeople => 'Άνθρωποι και ρόλοι';

  @override
  String get categoryObjects => 'Αντικείμενα και πράγματα';

  @override
  String get categoryEmotion => 'Συναίσθημα';

  @override
  String get categoryArchaic => 'Παλαιό και αρχαϊκό';

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

  @override
  String readExplanationsIn(String language) {
    return 'Read explanations in $language';
  }

  @override
  String get readExplanationsCaption =>
      'The word itself is always read in English.';

  @override
  String noVoiceInstalled(String language) {
    return 'This device has no $language voice installed.';
  }
}
