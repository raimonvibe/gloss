// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ლამაზი ენის ლექსიკონი';

  @override
  String get navHome => 'მთავარი';

  @override
  String get navLexicon => 'ლექსიკონი';

  @override
  String get navQuiz => 'ქვიზი';

  @override
  String get navSaved => 'შენახული';

  @override
  String get navLanguages => 'ენები';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon-ის ლექსიკონიდან $count იშვიათი, მდიდარი სიტყვა — ახსნილი ისე, როგორც მეგობარი ახსნიდა, არა ლექსიკონი.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'განხილულია $current სიტყვა $total-დან';
  }

  @override
  String get exploreLexicon => 'ლექსიკონის დათვალიერება';

  @override
  String get startQuiz => 'ქვიზის დაწყება';

  @override
  String get wordOfTheDay => 'დღის სიტყვა';

  @override
  String get readFullEntry => 'სრული ჩანაწერის კითხვა →';

  @override
  String get lexiconTitle => 'ლექსიკონი';

  @override
  String get lexiconCaption => 'კრებული';

  @override
  String get savedTitle => 'შენახული სიტყვები';

  @override
  String get savedCaption => 'გულთან ახლოს';

  @override
  String get searchHint => 'მოძებნე სიტყვა, ან აღწერე მისი მნიშვნელობა…';

  @override
  String get clearSearch => 'ძიების გასუფთავება';

  @override
  String get filterAll => 'ყველა';

  @override
  String get noMatches => 'ჯერ არაფერი ემთხვევა — სცადე სხვა სიტყვა ან განცდა.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n დამთხვევა',
      one: '1 დამთხვევა',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'აქ არაფერია';

  @override
  String get emptyLexicon => 'ლექსიკონის ამ კუთხეში არაფერია.';

  @override
  String get emptySaved =>
      'ჯერ შენახული სიტყვა არ არის. შეეხე გულს ნებისმიერ ჩანაწერზე.';

  @override
  String get tapToReadMore => 'შეეხე, რომ მეტი წაიკითხო';

  @override
  String get saveWord => 'სიტყვის შენახვა';

  @override
  String get removeFromFavorites => 'რჩეულებიდან ამოშლა';

  @override
  String get inPlainWords => 'მარტივი სიტყვებით';

  @override
  String get theDefinition => 'განმარტება';

  @override
  String get inASentence => 'წინადადებაში';

  @override
  String get exampleGlossLabel => 'სხვაგვარად რომ ვთქვათ';

  @override
  String get save => 'შენახვა';

  @override
  String get saved => 'შენახულია';

  @override
  String get copy => 'კოპირება';

  @override
  String get copiedToClipboard => 'დაკოპირდა გაცვლის ბუფერში';

  @override
  String get roots => 'ფესვები';

  @override
  String get quizTitle => 'პატარა ქვიზი';

  @override
  String get quizCaption => 'იცოდე ფესვები, შემდეგ აირჩიე მნიშვნელობა';

  @override
  String get quizIntro =>
      'თითოეული კითხვა აჩვენებს სიტყვას და მის ეტიმოლოგიას. აირჩიე განმარტება, რომელიც ერგება — ოთხი არჩევანი, ერთი ჭეშმარიტი.';

  @override
  String get howManyWords => 'რამდენი სიტყვა';

  @override
  String get begin => 'დაწყება';

  @override
  String get quizByTheme => 'ქვიზი თემის მიხედვით';

  @override
  String get endQuiz => 'ქვიზის დასრულება';

  @override
  String questionOf(int index, int length) {
    return 'კითხვა $index / $length';
  }

  @override
  String get whichDefinitionFits => 'რომელი განმარტება ერგება?';

  @override
  String get previous => 'წინა';

  @override
  String get next => 'შემდეგი';

  @override
  String get seeResults => 'შედეგების ნახვა';

  @override
  String get themeTitle => 'თემა';

  @override
  String get chooseASubject => 'აირჩიე საგანი';

  @override
  String get noThemesYet => 'თემები ჯერ არ არის.';

  @override
  String get notEnoughWordsInTheme => 'ამ თემაში ჯერ საკმარისი სიტყვა არ არის.';

  @override
  String get results => 'შედეგები';

  @override
  String get perfectPage => 'სრულყოფილი გვერდი';

  @override
  String get wellMarked => 'ლამაზად აღნიშნული';

  @override
  String get tryAnotherRound => 'სცადე კიდევ ერთი რაუნდი';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score სწორი განმარტება',
      one: '1 სწორი განმარტება',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score სწორი განმარტება, $total-დან.',
      one: 'ერთი სწორი განმარტება, $total-დან.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'გადართვა ნათელ რეჟიმზე';

  @override
  String get switchToDarkMode => 'გადართვა მუქ რეჟიმზე';

  @override
  String get listen => 'მოსმენა';

  @override
  String get stop => 'შეჩერება';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ენები';

  @override
  String get languagesCaption => 'ენები';

  @override
  String get searchLanguages => 'მოძებნე ქვეყანა ან ენა…';

  @override
  String get noMatchingLanguages => 'შესაბამისი ქვეყანა ან ენა არ არის.';

  @override
  String get selectedLanguage => 'კითხვა';

  @override
  String get continentAfrica => 'აფრიკა';

  @override
  String get continentAsia => 'აზია';

  @override
  String get continentEurope => 'ევროპა';

  @override
  String get continentAmericas => 'ამერიკა';

  @override
  String get continentOceania => 'ოკეანეთი';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'ასევე $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'როგორც: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin-დან, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, მნიშვნელობა $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'მარტივი სიტყვებით: $friendly';
  }

  @override
  String get categorySpeech => 'მეტყველება და რიტორიკა';

  @override
  String get categoryCharacter => 'ხასიათი და ტემპერამენტი';

  @override
  String get categoryCriticism => 'კრიტიკა და შეურაცხყოფა';

  @override
  String get categoryVirtue => 'სათნოება';

  @override
  String get categoryVice => 'მანკი';

  @override
  String get categoryKnowledge => 'ცოდნა და აზრი';

  @override
  String get categoryReligion => 'რელიგია და სული';

  @override
  String get categoryBeginnings => 'დასაწყისები';

  @override
  String get categoryConflict => 'კონფლიქტი და მოტყუება';

  @override
  String get categoryAppearance => 'გარეგნობა და სინათლე';

  @override
  String get categoryPeople => 'ადამიანები და როლები';

  @override
  String get categoryObjects => 'საგნები და ნივთები';

  @override
  String get categoryEmotion => 'ემოცია';

  @override
  String get categoryArchaic => 'ძველი და არქაული';

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
