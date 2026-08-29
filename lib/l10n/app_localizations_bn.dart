// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'সুন্দর ভাষার অভিধান';

  @override
  String get navHome => 'নীড়';

  @override
  String get navLexicon => 'অভিধান';

  @override
  String get navQuiz => 'কুইজ';

  @override
  String get navSaved => 'সংরক্ষিত';

  @override
  String get navLanguages => 'ভাষা';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon অভিধানের $countটি দুর্লভ, সমৃদ্ধ শব্দ — অভিধানের মতো নয়, বন্ধুর মতো ব্যাখ্যা করা।';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$totalটির মধ্যে $currentটি শব্দ ঘুরে দেখা হয়েছে';
  }

  @override
  String get exploreLexicon => 'অভিধান ঘুরে দেখুন';

  @override
  String get startQuiz => 'একটি কুইজ শুরু করুন';

  @override
  String get wordOfTheDay => 'আজকের শব্দ';

  @override
  String get readFullEntry => 'পূর্ণ নিবন্ধ পড়ুন →';

  @override
  String get lexiconTitle => 'অভিধান';

  @override
  String get lexiconCaption => 'সংগ্রহ';

  @override
  String get savedTitle => 'সংরক্ষিত শব্দ';

  @override
  String get savedCaption => 'কাছে রাখা';

  @override
  String get searchHint => 'একটি শব্দ খুঁজুন, বা তার অর্থ বর্ণনা করুন…';

  @override
  String get clearSearch => 'অনুসন্ধান মুছুন';

  @override
  String get filterAll => 'সব';

  @override
  String get noMatches => 'এখনও মিল নেই — অন্য শব্দ বা অনুভূতি চেষ্টা করুন।';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি মিল',
      one: '১টি মিল',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'এখানে কিছু নেই';

  @override
  String get emptyLexicon => 'অভিধানের এই কোণে কিছু নেই।';

  @override
  String get emptySaved =>
      'এখনও সংরক্ষিত শব্দ নেই। যেকোনো নিবন্ধে হৃদয়ে ট্যাপ করুন।';

  @override
  String get tapToReadMore => 'আরও পড়তে ট্যাপ করুন';

  @override
  String get saveWord => 'শব্দ সংরক্ষণ করুন';

  @override
  String get removeFromFavorites => 'প্রিয় তালিকা থেকে সরান';

  @override
  String get inPlainWords => 'সহজ ভাষায়';

  @override
  String get theDefinition => 'সংজ্ঞা';

  @override
  String get inASentence => 'একটি বাক্যে';

  @override
  String get exampleGlossLabel => 'অন্য কথায়';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get saved => 'সংরক্ষিত';

  @override
  String get copy => 'অনুলিপি';

  @override
  String get copiedToClipboard => 'ক্লিপবোর্ডে অনুলিপি হয়েছে';

  @override
  String get roots => 'মূল';

  @override
  String get quizTitle => 'একটি ছোট কুইজ';

  @override
  String get quizCaption => 'মূল জানুন, তারপর অর্থ বেছে নিন';

  @override
  String get quizIntro =>
      'প্রতি প্রশ্নে একটি শব্দ ও তার ব্যুৎপত্তি দেখায়। যে সংজ্ঞা মিলে যায় তা বেছে নিন — চারটি পছন্দ, একটি সত্য।';

  @override
  String get howManyWords => 'কতগুলি শব্দ';

  @override
  String get begin => 'শুরু';

  @override
  String get quizByTheme => 'বিষয় অনুসারে কুইজ';

  @override
  String get endQuiz => 'কুইজ শেষ করুন';

  @override
  String questionOf(int index, int length) {
    return 'প্রশ্ন $index / $length';
  }

  @override
  String get whichDefinitionFits => 'কোন সংজ্ঞা মিলে?';

  @override
  String get previous => 'আগের';

  @override
  String get next => 'পরের';

  @override
  String get seeResults => 'ফলাফল দেখুন';

  @override
  String get themeTitle => 'বিষয়';

  @override
  String get chooseASubject => 'একটি বিষয় বেছে নিন';

  @override
  String get noThemesYet => 'এখনও কোনো বিষয় নেই।';

  @override
  String get notEnoughWordsInTheme => 'এই বিষয়ে এখনও যথেষ্ট শব্দ নেই।';

  @override
  String get results => 'ফলাফল';

  @override
  String get perfectPage => 'একটি নিখুঁত পাতা';

  @override
  String get wellMarked => 'সুন্দরভাবে চিহ্নিত';

  @override
  String get tryAnotherRound => 'আরেক দফা চেষ্টা করুন';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$scoreটি সংজ্ঞা সঠিক',
      one: '১টি সংজ্ঞা সঠিক',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$scoreটি সংজ্ঞা সঠিক, $totalটির মধ্যে।',
      one: 'একটি সংজ্ঞা সঠিক, $totalটির মধ্যে।',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'হালকা মোডে যান';

  @override
  String get switchToDarkMode => 'অন্ধকার মোডে যান';

  @override
  String get listen => 'শুনুন';

  @override
  String get stop => 'থামুন';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ভাষা';

  @override
  String get languagesCaption => 'জিহ্বাগুলি';

  @override
  String get searchLanguages => 'দেশ বা ভাষা খুঁজুন…';

  @override
  String get noMatchingLanguages => 'কোনো মিলিত দেশ বা ভাষা নেই।';

  @override
  String get selectedLanguage => 'পড়ছেন';

  @override
  String get continentAfrica => 'আফ্রিকা';

  @override
  String get continentAsia => 'এশিয়া';

  @override
  String get continentEurope => 'ইউরোপ';

  @override
  String get continentAmericas => 'আমেরিকা';

  @override
  String get continentOceania => 'ওশেনিয়া';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'এছাড়াও $variants।';
  }

  @override
  String speechAsIn(String example) {
    return 'যেমন: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin থেকে, $originWord।';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, অর্থ $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'সহজ ভাষায়: $friendly';
  }

  @override
  String get categorySpeech => 'বাক্ ও অলঙ্কার';

  @override
  String get categoryCharacter => 'চরিত্র ও স্বভাব';

  @override
  String get categoryCriticism => 'সমালোচনা ও অপমান';

  @override
  String get categoryVirtue => 'সদ্গুণ';

  @override
  String get categoryVice => 'দোষ';

  @override
  String get categoryKnowledge => 'জ্ঞান ও চিন্তা';

  @override
  String get categoryReligion => 'ধর্ম ও আত্মা';

  @override
  String get categoryBeginnings => 'সূচনা';

  @override
  String get categoryConflict => 'দ্বন্দ্ব ও প্রতারণা';

  @override
  String get categoryAppearance => 'রূপ ও আলো';

  @override
  String get categoryPeople => 'মানুষ ও ভূমিকা';

  @override
  String get categoryObjects => 'বস্তু ও জিনিস';

  @override
  String get categoryEmotion => 'আবেগ';

  @override
  String get categoryArchaic => 'প্রাচীন ও পুরনো';

  @override
  String get navStudy => 'পাঠকক্ষ';

  @override
  String get studyTitle => 'পাঠকক্ষ';

  @override
  String get studyCaption => 'পাঠ, কণ্ঠ ও আলো';

  @override
  String get readingSection => 'পাঠ';

  @override
  String get readingCaption => 'পাতা কেমন করে বসে';

  @override
  String get textSize => 'লেখার আকার';

  @override
  String get textSizeSample => 'Edulcorate — মিষ্টি করা, কোমল করা।';

  @override
  String get smaller => 'ছোট';

  @override
  String get larger => 'বড়';

  @override
  String get autoplayPronunciation => 'শব্দ খুললেই সশব্দে পড়া হোক';

  @override
  String get reduceMotion => 'অলঙ্করণ শান্ত করুন';

  @override
  String get reduceMotionCaption => 'কম কারুকাজ ও রঙের ঢাল';

  @override
  String get voiceSection => 'কণ্ঠ';

  @override
  String get voiceCaption => 'Gloss কেমন করে সশব্দে পড়ে';

  @override
  String get chooseVoice => 'কণ্ঠ';

  @override
  String get voiceDefault => 'আপনার জন্য বাছাই';

  @override
  String get noOtherVoices =>
      'এই ডিভাইসে অন্য কোনো ইংরেজি কণ্ঠ ইনস্টল করা নেই।';

  @override
  String get speechPace => 'গতি';

  @override
  String get slower => 'ধীরতর';

  @override
  String get faster => 'দ্রুততর';

  @override
  String get hearIt => 'শুনুন';

  @override
  String get lightSection => 'আলো';

  @override
  String get lightCaption => 'চর্মপত্র নাকি মোমের আলো';

  @override
  String get themeSystem => 'ডিভাইস অনুসারে';

  @override
  String get themeLight => 'চর্মপত্র';

  @override
  String get themeDark => 'মোমের আলো';

  @override
  String get tongueSection => 'ভাষা';

  @override
  String get aboutSection => 'সম্পর্কে';

  @override
  String get aboutCaption => 'কীভাবে তৈরি হলো';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'মুক্ত উৎসের লাইসেন্স';

  @override
  String get shareGloss => 'Gloss ভাগ করুন';

  @override
  String get followTheMaker => 'নির্মাতাকে অনুসরণ করুন';

  @override
  String couldNotOpenLink(String label) {
    return '$label খোলা গেল না।';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language ভাষায় ব্যাখ্যা পড়ুন';
  }

  @override
  String get readExplanationsCaption =>
      'শব্দটি নিজে সর্বদা ইংরেজিতেই পড়া হয়।';

  @override
  String noVoiceInstalled(String language) {
    return 'এই ডিভাইসে $language কণ্ঠ ইনস্টল করা নেই।';
  }

  @override
  String get memorySection => 'স্মৃতি';

  @override
  String get memoryCaption => 'Gloss যা রাখে';

  @override
  String get forgetProgress => 'আমার অগ্রগতি ভুলে যাও';

  @override
  String get forgetProgressBody =>
      'আপনি যে শব্দগুলি দেখেছেন সেগুলির চিহ্ন সরানো হবে। সংরক্ষিত শব্দ থেকে যাবে।';

  @override
  String get clearSavedWords => 'সংরক্ষিত শব্দ মুছুন';

  @override
  String get clearSavedWordsBody =>
      'আপনি যে শব্দগুলি রেখেছেন সেগুলি সরানো হবে। আপনার অগ্রগতি থেকে যাবে।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get forget => 'ভুলে যাও';

  @override
  String get clear => 'মুছুন';

  @override
  String get progressForgotten => 'অগ্রগতি ভুলে যাওয়া হয়েছে।';

  @override
  String get savedWordsCleared => 'সংরক্ষিত শব্দ মুছে ফেলা হয়েছে।';
}
