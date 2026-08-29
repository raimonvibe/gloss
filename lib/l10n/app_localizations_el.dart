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
  String get navStudy => 'Γραφείο';

  @override
  String get studyTitle => 'Το γραφείο';

  @override
  String get studyCaption => 'ανάγνωση, φωνή και φως';

  @override
  String get readingSection => 'Ανάγνωση';

  @override
  String get readingCaption => 'πώς κάθεται η σελίδα';

  @override
  String get textSize => 'Μέγεθος κειμένου';

  @override
  String get textSizeSample => 'Edulcorate — να γλυκάνει, να απαλύνει.';

  @override
  String get smaller => 'Μικρότερο';

  @override
  String get larger => 'Μεγαλύτερο';

  @override
  String get autoplayPronunciation =>
      'Ανάγνωση της λέξης φωναχτά με το άνοιγμα';

  @override
  String get reduceMotion => 'Γαλήνεψε τα στολίδια';

  @override
  String get reduceMotionCaption => 'λιγότερες καμπύλες και διαβαθμίσεις';

  @override
  String get voiceSection => 'Φωνή';

  @override
  String get voiceCaption => 'πώς διαβάζει φωναχτά το Gloss';

  @override
  String get chooseVoice => 'Φωνή';

  @override
  String get voiceDefault => 'Επιλεγμένη για εσάς';

  @override
  String get noOtherVoices =>
      'Δεν υπάρχουν άλλες αγγλικές φωνές εγκατεστημένες σε αυτή τη συσκευή.';

  @override
  String get speechPace => 'Ρυθμός';

  @override
  String get slower => 'Πιο αργά';

  @override
  String get faster => 'Πιο γρήγορα';

  @override
  String get hearIt => 'Άκουσέ τη';

  @override
  String get lightSection => 'Φως';

  @override
  String get lightCaption => 'περγαμηνή ή φως κεριού';

  @override
  String get themeSystem => 'Όπως η συσκευή';

  @override
  String get themeLight => 'Περγαμηνή';

  @override
  String get themeDark => 'Φως κεριού';

  @override
  String get tongueSection => 'Γλώσσα';

  @override
  String get aboutSection => 'Σχετικά';

  @override
  String get aboutCaption => 'πώς φτιάχτηκε';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Άδειες ανοιχτού κώδικα';

  @override
  String get shareGloss => 'Κοινοποίηση του Gloss';

  @override
  String get followTheMaker => 'Ακολουθήστε τον δημιουργό';

  @override
  String couldNotOpenLink(String label) {
    return 'Δεν ήταν δυνατό το άνοιγμα του $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Ανάγνωση των επεξηγήσεων στα $language';
  }

  @override
  String get readExplanationsCaption =>
      'Η ίδια η λέξη διαβάζεται πάντα στα αγγλικά.';

  @override
  String noVoiceInstalled(String language) {
    return 'Αυτή η συσκευή δεν έχει εγκατεστημένη φωνή $language.';
  }

  @override
  String get memorySection => 'Μνήμη';

  @override
  String get memoryCaption => 'τι κρατά το Gloss';

  @override
  String get forgetProgress => 'Ξέχνα την πρόοδό μου';

  @override
  String get forgetProgressBody =>
      'Οι λέξεις που εξερευνήσατε θα πάψουν να είναι σημειωμένες. Οι αποθηκευμένες λέξεις μένουν.';

  @override
  String get clearSavedWords => 'Καθαρισμός αποθηκευμένων λέξεων';

  @override
  String get clearSavedWordsBody =>
      'Οι λέξεις που κρατήσατε θα αφαιρεθούν. Η πρόοδός σας μένει.';

  @override
  String get cancel => 'Άκυρο';

  @override
  String get forget => 'Ξέχνα';

  @override
  String get clear => 'Καθαρισμός';

  @override
  String get progressForgotten => 'Η πρόοδος ξεχάστηκε.';

  @override
  String get savedWordsCleared => 'Οι αποθηκευμένες λέξεις καθαρίστηκαν.';
}
