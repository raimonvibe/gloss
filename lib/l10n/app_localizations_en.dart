// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'a lexicon of lovely language';

  @override
  String get navHome => 'Home';

  @override
  String get navLexicon => 'Lexicon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Saved';

  @override
  String get navLanguages => 'Languages';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count rare, rich words from the $lexicon lexicon — explained the way a friend would explain them, not a dictionary.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current of $total words explored';
  }

  @override
  String get exploreLexicon => 'Explore the lexicon';

  @override
  String get startQuiz => 'Start a quiz';

  @override
  String get wordOfTheDay => 'word of the day';

  @override
  String get readFullEntry => 'Read the full entry →';

  @override
  String get lexiconTitle => 'The lexicon';

  @override
  String get lexiconCaption => 'the gathering';

  @override
  String get savedTitle => 'Saved words';

  @override
  String get savedCaption => 'kept close';

  @override
  String get searchHint => 'Search a word, or describe its meaning…';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get filterAll => 'All';

  @override
  String get noMatches => 'No matches yet — try a different word or feeling.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n matches',
      one: '1 match',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nothing here';

  @override
  String get emptyLexicon => 'Nothing in this corner of the lexicon.';

  @override
  String get emptySaved => 'No saved words yet. Tap the heart on any entry.';

  @override
  String get tapToReadMore => 'Tap to read more';

  @override
  String get saveWord => 'Save word';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get inPlainWords => 'in plain words';

  @override
  String get theDefinition => 'the definition';

  @override
  String get inASentence => 'in a sentence';

  @override
  String get exampleGlossLabel => 'in other words';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String get copy => 'Copy';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get roots => 'roots';

  @override
  String get quizTitle => 'A little quiz';

  @override
  String get quizCaption => 'know the roots, then choose the meaning';

  @override
  String get quizIntro =>
      'Each question shows a word and its etymology. Pick the definition that fits — four choices, one true.';

  @override
  String get howManyWords => 'how many words';

  @override
  String get begin => 'Begin';

  @override
  String get quizByTheme => 'Quiz by theme';

  @override
  String get endQuiz => 'End quiz';

  @override
  String questionOf(int index, int length) {
    return 'Question $index of $length';
  }

  @override
  String get whichDefinitionFits => 'which definition fits?';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get seeResults => 'See results';

  @override
  String get themeTitle => 'Theme';

  @override
  String get chooseASubject => 'choose a subject';

  @override
  String get noThemesYet => 'No themes yet.';

  @override
  String get notEnoughWordsInTheme => 'Not enough words in this theme yet.';

  @override
  String get results => 'Results';

  @override
  String get perfectPage => 'a perfect page';

  @override
  String get wellMarked => 'well marked';

  @override
  String get tryAnotherRound => 'Try another round';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definitions right',
      one: '1 definition right',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definitions right, of $total.',
      one: 'One definition right, of $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Switch to light mode';

  @override
  String get switchToDarkMode => 'Switch to dark mode';

  @override
  String get listen => 'Listen';

  @override
  String get stop => 'Stop';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Languages';

  @override
  String get languagesCaption => 'the tongues';

  @override
  String get searchLanguages => 'Search a country or language…';

  @override
  String get noMatchingLanguages => 'No matching countries or languages.';

  @override
  String get selectedLanguage => 'Reading in';

  @override
  String get continentAfrica => 'Africa';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europe';

  @override
  String get continentAmericas => 'Americas';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current of $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Also $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'As in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'From $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, meaning $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In plain words: $friendly';
  }

  @override
  String get categorySpeech => 'Speech & Rhetoric';

  @override
  String get categoryCharacter => 'Character & Temperament';

  @override
  String get categoryCriticism => 'Criticism & Insult';

  @override
  String get categoryVirtue => 'Virtue';

  @override
  String get categoryVice => 'Vice';

  @override
  String get categoryKnowledge => 'Knowledge & Thought';

  @override
  String get categoryReligion => 'Religion & Spirit';

  @override
  String get categoryBeginnings => 'Beginnings';

  @override
  String get categoryConflict => 'Conflict & Deceit';

  @override
  String get categoryAppearance => 'Appearance & Light';

  @override
  String get categoryPeople => 'People & Roles';

  @override
  String get categoryObjects => 'Objects & Things';

  @override
  String get categoryEmotion => 'Emotion';

  @override
  String get categoryArchaic => 'Old & Archaic';

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

  @override
  String get memorySection => 'Memory';

  @override
  String get memoryCaption => 'what Gloss keeps';

  @override
  String get forgetProgress => 'Forget my progress';

  @override
  String get forgetProgressBody =>
      'The words you have explored will be unmarked. Your saved words stay.';

  @override
  String get clearSavedWords => 'Clear saved words';

  @override
  String get clearSavedWordsBody =>
      'The words you have kept will be removed. Your progress stays.';

  @override
  String get cancel => 'Cancel';

  @override
  String get forget => 'Forget';

  @override
  String get clear => 'Clear';

  @override
  String get progressForgotten => 'Progress forgotten.';

  @override
  String get savedWordsCleared => 'Saved words cleared.';
}
