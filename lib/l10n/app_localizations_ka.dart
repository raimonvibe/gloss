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
  String get navStudy => 'კაბინეტი';

  @override
  String get studyTitle => 'კაბინეტი';

  @override
  String get studyCaption => 'კითხვა, ხმა და შუქი';

  @override
  String get readingSection => 'კითხვა';

  @override
  String get readingCaption => 'როგორ ჯდება გვერდი';

  @override
  String get textSize => 'ტექსტის ზომა';

  @override
  String get textSizeSample => 'Edulcorate — დატკბობა, დარბილება.';

  @override
  String get smaller => 'უფრო პატარა';

  @override
  String get larger => 'უფრო დიდი';

  @override
  String get autoplayPronunciation => 'სიტყვის ხმამაღლა წაკითხვა გახსნისას';

  @override
  String get reduceMotion => 'დაამშვიდე მორთულობა';

  @override
  String get reduceMotionCaption => 'ნაკლები ხვეული და გადასვლა';

  @override
  String get voiceSection => 'ხმა';

  @override
  String get voiceCaption => 'როგორ კითხულობს Gloss ხმამაღლა';

  @override
  String get chooseVoice => 'ხმა';

  @override
  String get voiceDefault => 'შერჩეულია თქვენთვის';

  @override
  String get noOtherVoices =>
      'ამ მოწყობილობაზე სხვა ინგლისური ხმები არ არის დაყენებული.';

  @override
  String get speechPace => 'ტემპი';

  @override
  String get slower => 'უფრო ნელა';

  @override
  String get faster => 'უფრო სწრაფად';

  @override
  String get hearIt => 'მოსმენა';

  @override
  String get lightSection => 'შუქი';

  @override
  String get lightCaption => 'პერგამენტი ან სანთლის შუქი';

  @override
  String get themeSystem => 'მოწყობილობის მიხედვით';

  @override
  String get themeLight => 'პერგამენტი';

  @override
  String get themeDark => 'სანთლის შუქი';

  @override
  String get tongueSection => 'ენა';

  @override
  String get aboutSection => 'შესახებ';

  @override
  String get aboutCaption => 'როგორ შეიქმნა';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'ღია კოდის ლიცენზიები';

  @override
  String get shareGloss => 'Gloss-ის გაზიარება';

  @override
  String get followTheMaker => 'მიჰყევით ავტორს';

  @override
  String couldNotOpenLink(String label) {
    return '$label ვერ გაიხსნა.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'განმარტებების წაკითხვა $language ენაზე';
  }

  @override
  String get readExplanationsCaption =>
      'თავად სიტყვა ყოველთვის ინგლისურად იკითხება.';

  @override
  String noVoiceInstalled(String language) {
    return 'ამ მოწყობილობას არ აქვს $language ხმა დაყენებული.';
  }

  @override
  String get memorySection => 'მეხსიერება';

  @override
  String get memoryCaption => 'რას ინახავს Gloss';

  @override
  String get forgetProgress => 'დაივიწყე ჩემი პროგრესი';

  @override
  String get forgetProgressBody =>
      'თქვენ მიერ შესწავლილ სიტყვებს მოეხსნება ნიშანი. შენახული სიტყვები დარჩება.';

  @override
  String get clearSavedWords => 'გაასუფთავე შენახული სიტყვები';

  @override
  String get clearSavedWordsBody =>
      'თქვენ მიერ შენახული სიტყვები წაიშლება. თქვენი პროგრესი დარჩება.';

  @override
  String get cancel => 'გაუქმება';

  @override
  String get forget => 'დავიწყება';

  @override
  String get clear => 'გასუფთავება';

  @override
  String get progressForgotten => 'პროგრესი დავიწყებულია.';

  @override
  String get savedWordsCleared => 'შენახული სიტყვები გასუფთავდა.';
}
