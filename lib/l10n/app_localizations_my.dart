// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'လှပသော ဘာသာစကား၏ အဘိဓာန်';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navLexicon => 'အဘိဓာန်';

  @override
  String get navQuiz => 'မေးခွန်း';

  @override
  String get navSaved => 'သိမ်းထားသည်';

  @override
  String get navLanguages => 'ဘာသာစကားများ';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon အဘိဓာန်မှ ရှားပါး ကြွယ်ဝသော စကားလုံး $count လုံး — အဘိဓာန်ကဲ့သို့ မဟုတ်၊ မိတ်ဆွေကဲ့သို့ ရှင်းပြထားသည်။';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'စကားလုံး $total လုံးအနက် $current လုံး လေ့လာပြီး';
  }

  @override
  String get exploreLexicon => 'အဘိဓာန်ကို လေ့လာရန်';

  @override
  String get startQuiz => 'မေးခွန်း စတင်ရန်';

  @override
  String get wordOfTheDay => 'ယနေ့၏ စကားလုံး';

  @override
  String get readFullEntry => 'အချက်အလက် အပြည့်အစုံ ဖတ်ရန် →';

  @override
  String get lexiconTitle => 'အဘိဓာန်';

  @override
  String get lexiconCaption => 'စုစည်းမှု';

  @override
  String get savedTitle => 'သိမ်းထားသော စကားလုံးများ';

  @override
  String get savedCaption => 'နီးကပ်စွာ ထားရှိ';

  @override
  String get searchHint => 'စကားလုံး ရှာပါ၊ သို့မဟုတ် အဓိပ္ပာယ် ဖော်ပြပါ…';

  @override
  String get clearSearch => 'ရှာဖွေမှု ဖျက်ရန်';

  @override
  String get filterAll => 'အားလုံး';

  @override
  String get noMatches =>
      'မတွေ့သေးပါ — အခြား စကားလုံး သို့မဟုတ် ခံစားချက် စမ်းကြည့်ပါ။';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ခု ကိုက်ညီ',
      one: '၁ ခု ကိုက်ညီ',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ဤနေရာတွင် ဘာမှ မရှိ';

  @override
  String get emptyLexicon => 'အဘိဓာန်၏ ဤထောင့်တွင် ဘာမှ မရှိ။';

  @override
  String get emptySaved =>
      'သိမ်းထားသော စကားလုံး မရှိသေးပါ။ မည်သည့် မှတ်တမ်းတွင်မဆို နှလုံးကို နှိပ်ပါ။';

  @override
  String get tapToReadMore => 'ထပ်ဖတ်ရန် နှိပ်ပါ';

  @override
  String get saveWord => 'စကားလုံး သိမ်းရန်';

  @override
  String get removeFromFavorites => 'အကြိုက်ဆုံးမှ ဖယ်ရှားရန်';

  @override
  String get inPlainWords => 'ရိုးရိုး စကားဖြင့်';

  @override
  String get theDefinition => 'အဓိပ္ပာယ်ဖွင့်ဆိုချက်';

  @override
  String get inASentence => 'ဝါကျတစ်ခုတွင်';

  @override
  String get exampleGlossLabel => 'အခြား စကားဖြင့်';

  @override
  String get save => 'သိမ်းရန်';

  @override
  String get saved => 'သိမ်းပြီး';

  @override
  String get copy => 'ကူးယူရန်';

  @override
  String get copiedToClipboard => 'ကလစ်ဘုတ်သို့ ကူးယူပြီး';

  @override
  String get roots => 'အမြစ်များ';

  @override
  String get quizTitle => 'မေးခွန်း အသေးစား';

  @override
  String get quizCaption => 'အမြစ်ကို သိပြီး အဓိပ္ပာယ် ရွေးပါ';

  @override
  String get quizIntro =>
      'မေးခွန်းတိုင်းတွင် စကားလုံးနှင့် ၎င်း၏ ဇာစ်မြစ် ပြသည်။ ကိုက်ညီသော အဓိပ္ပာယ်ကို ရွေးပါ — ရွေးချယ်စရာ လေးခု၊ တစ်ခုသာ မှန်။';

  @override
  String get howManyWords => 'စကားလုံး မည်မျှ';

  @override
  String get begin => 'စတင်ရန်';

  @override
  String get quizByTheme => 'အကြောင်းအရာအလိုက် မေးခွန်း';

  @override
  String get endQuiz => 'မေးခွန်း ပြီးဆုံးရန်';

  @override
  String questionOf(int index, int length) {
    return 'မေးခွန်း $index / $length';
  }

  @override
  String get whichDefinitionFits => 'မည်သည့် အဓိပ္ပာယ် ကိုက်ညီသနည်း။';

  @override
  String get previous => 'ယခင်';

  @override
  String get next => 'နောက်';

  @override
  String get seeResults => 'ရလဒ် ကြည့်ရန်';

  @override
  String get themeTitle => 'အကြောင်းအရာ';

  @override
  String get chooseASubject => 'အကြောင်းအရာ ရွေးပါ';

  @override
  String get noThemesYet => 'အကြောင်းအရာ မရှိသေးပါ။';

  @override
  String get notEnoughWordsInTheme =>
      'ဤအကြောင်းအရာတွင် စကားလုံး မလုံလောက်သေးပါ။';

  @override
  String get results => 'ရလဒ်';

  @override
  String get perfectPage => 'ပြည့်စုံသော စာမျက်နှာ';

  @override
  String get wellMarked => 'လှပစွာ မှတ်သားထား';

  @override
  String get tryAnotherRound => 'နောက်တစ်ပတ် စမ်းကြည့်ပါ';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'အဓိပ္ပာယ် $score ခု မှန်',
      one: 'အဓိပ္ပာယ် ၁ ခု မှန်',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$total ခုအနက် အဓိပ္ပာယ် $score ခု မှန်သည်။',
      one: '$total ခုအနက် အဓိပ္ပာယ် တစ်ခု မှန်သည်။',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'အလင်း မုဒ်သို့ ပြောင်းရန်';

  @override
  String get switchToDarkMode => 'အမှောင် မုဒ်သို့ ပြောင်းရန်';

  @override
  String get listen => 'နားထောင်ရန်';

  @override
  String get stop => 'ရပ်ရန်';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ဘာသာစကားများ';

  @override
  String get languagesCaption => 'လျှာများ';

  @override
  String get searchLanguages => 'နိုင်ငံ သို့မဟုတ် ဘာသာစကား ရှာပါ…';

  @override
  String get noMatchingLanguages =>
      'ကိုက်ညီသော နိုင်ငံ သို့မဟုတ် ဘာသာစကား မရှိပါ။';

  @override
  String get selectedLanguage => 'ဖတ်နေသည်';

  @override
  String get continentAfrica => 'အာဖရိက';

  @override
  String get continentAsia => 'အာရှ';

  @override
  String get continentEurope => 'ဥရောပ';

  @override
  String get continentAmericas => 'အမေရိက';

  @override
  String get continentOceania => 'သမုဒ္ဒရာဒေသ';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'ထို့အပြင် $variants။';
  }

  @override
  String speechAsIn(String example) {
    return 'ဥပမာ- $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin မှ၊ $originWord။';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form၊ အဓိပ္ပာယ် $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'ရိုးရိုး စကားဖြင့်- $friendly';
  }

  @override
  String get categorySpeech => 'စကားနှင့် စကားအလှ';

  @override
  String get categoryCharacter => 'စရိုက်နှင့် စိတ်သဘော';

  @override
  String get categoryCriticism => 'ဝေဖန်မှုနှင့် စော်ကားမှု';

  @override
  String get categoryVirtue => 'ကောင်းမြတ်မှု';

  @override
  String get categoryVice => 'မကောင်းမှု';

  @override
  String get categoryKnowledge => 'အသိပညာနှင့် အတွေး';

  @override
  String get categoryReligion => 'ဘာသာနှင့် စိတ်ဝိညာဉ်';

  @override
  String get categoryBeginnings => 'အစများ';

  @override
  String get categoryConflict => 'ပဋိပက္ခနှင့် လှည့်စားမှု';

  @override
  String get categoryAppearance => 'အသွင်အပြင်နှင့် အလင်း';

  @override
  String get categoryPeople => 'လူနှင့် အခန်းကဏ္ဍ';

  @override
  String get categoryObjects => 'အရာဝတ္ထုနှင့် ပစ္စည်းများ';

  @override
  String get categoryEmotion => 'ခံစားချက်';

  @override
  String get categoryArchaic => 'ရှေးဟောင်းနှင့် ခေတ်မမီ';

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
