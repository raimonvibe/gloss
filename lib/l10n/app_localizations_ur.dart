// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'خوبصورت زبان کا ذخیرۂ الفاظ';

  @override
  String get navHome => 'گھر';

  @override
  String get navLexicon => 'ذخیرہ';

  @override
  String get navQuiz => 'سوالنامہ';

  @override
  String get navSaved => 'محفوظ';

  @override
  String get navLanguages => 'زبانیں';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon کے ذخیرے سے $count نایاب، بھرپور الفاظ — لغت کی طرح نہیں، دوست کی طرح سمجھائے گئے۔';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total میں سے $current الفاظ دیکھے گئے';
  }

  @override
  String get exploreLexicon => 'ذخیرہ دیکھیں';

  @override
  String get startQuiz => 'سوالنامہ شروع کریں';

  @override
  String get wordOfTheDay => 'آج کا لفظ';

  @override
  String get readFullEntry => 'پوری تحریر پڑھیں →';

  @override
  String get lexiconTitle => 'ذخیرہ';

  @override
  String get lexiconCaption => 'مجموعہ';

  @override
  String get savedTitle => 'محفوظ الفاظ';

  @override
  String get savedCaption => 'قریب رکھے ہوئے';

  @override
  String get searchHint => 'لفظ تلاش کریں، یا اس کا مطلب بیان کریں…';

  @override
  String get clearSearch => 'تلاش صاف کریں';

  @override
  String get filterAll => 'سب';

  @override
  String get noMatches => 'ابھی کوئی میل نہیں — کوئی اور لفظ یا احساس آزمائیں۔';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n میلز',
      one: '1 میل',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'یہاں کچھ نہیں';

  @override
  String get emptyLexicon => 'ذخیرے کے اس کونے میں کچھ نہیں۔';

  @override
  String get emptySaved =>
      'ابھی کوئی محفوظ لفظ نہیں۔ کسی بھی اندراج پر دل کو چھوئیں۔';

  @override
  String get tapToReadMore => 'مزید پڑھنے کے لیے چھوئیں';

  @override
  String get saveWord => 'لفظ محفوظ کریں';

  @override
  String get removeFromFavorites => 'پسندیدہ سے ہٹائیں';

  @override
  String get inPlainWords => 'سادہ الفاظ میں';

  @override
  String get theDefinition => 'تعریف';

  @override
  String get inASentence => 'ایک جملے میں';

  @override
  String get exampleGlossLabel => 'دوسرے الفاظ میں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get saved => 'محفوظ';

  @override
  String get copy => 'نقل کریں';

  @override
  String get copiedToClipboard => 'کلپ بورڈ پر نقل ہو گیا';

  @override
  String get roots => 'جڑیں';

  @override
  String get quizTitle => 'ایک چھوٹا سوالنامہ';

  @override
  String get quizCaption => 'جڑیں جانیں، پھر مطلب چنیں';

  @override
  String get quizIntro =>
      'ہر سوال ایک لفظ اور اس کی اشتقاق دکھاتا ہے۔ جو تعریف فٹ ہو اسے چنیں — چار انتخاب، ایک سچ۔';

  @override
  String get howManyWords => 'کتنے الفاظ';

  @override
  String get begin => 'شروع کریں';

  @override
  String get quizByTheme => 'موضوع کے مطابق سوالنامہ';

  @override
  String get endQuiz => 'سوالنامہ ختم کریں';

  @override
  String questionOf(int index, int length) {
    return 'سوال $index / $length';
  }

  @override
  String get whichDefinitionFits => 'کون سی تعریف فٹ ہوتی ہے؟';

  @override
  String get previous => 'پچھلا';

  @override
  String get next => 'اگلا';

  @override
  String get seeResults => 'نتائج دیکھیں';

  @override
  String get themeTitle => 'موضوع';

  @override
  String get chooseASubject => 'ایک موضوع چنیں';

  @override
  String get noThemesYet => 'ابھی کوئی موضوع نہیں۔';

  @override
  String get notEnoughWordsInTheme => 'اس موضوع میں ابھی کافی الفاظ نہیں۔';

  @override
  String get results => 'نتائج';

  @override
  String get perfectPage => 'ایک کامل صفحہ';

  @override
  String get wellMarked => 'خوب نشان زد';

  @override
  String get tryAnotherRound => 'ایک اور دور آزمائیں';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score تعریفیں درست',
      one: '1 تعریف درست',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score تعریفیں درست، $total میں سے۔',
      one: 'ایک تعریف درست، $total میں سے۔',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'روشن وضع پر جائیں';

  @override
  String get switchToDarkMode => 'تاریک وضع پر جائیں';

  @override
  String get listen => 'سنیں';

  @override
  String get stop => 'روکیں';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'زبانیں';

  @override
  String get languagesCaption => 'زبانیں';

  @override
  String get searchLanguages => 'ملک یا زبان تلاش کریں…';

  @override
  String get noMatchingLanguages => 'کوئی مماثل ملک یا زبان نہیں۔';

  @override
  String get selectedLanguage => 'پڑھ رہے ہیں';

  @override
  String get continentAfrica => 'افریقہ';

  @override
  String get continentAsia => 'ایشیا';

  @override
  String get continentEurope => 'یورپ';

  @override
  String get continentAmericas => 'امریکہ';

  @override
  String get continentOceania => 'اوشیانا';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'نیز $variants۔';
  }

  @override
  String speechAsIn(String example) {
    return 'جیسے: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin سے، $originWord۔';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form، مطلب $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'سادہ الفاظ میں: $friendly';
  }

  @override
  String get categorySpeech => 'کلام اور بلاغت';

  @override
  String get categoryCharacter => 'کردار اور مزاج';

  @override
  String get categoryCriticism => 'تنقید اور توہین';

  @override
  String get categoryVirtue => 'فضیلت';

  @override
  String get categoryVice => 'عیب';

  @override
  String get categoryKnowledge => 'علم اور فکر';

  @override
  String get categoryReligion => 'دین اور روح';

  @override
  String get categoryBeginnings => 'آغاز';

  @override
  String get categoryConflict => 'تنازع اور فریب';

  @override
  String get categoryAppearance => 'صورت اور روشنی';

  @override
  String get categoryPeople => 'لوگ اور کردار';

  @override
  String get categoryObjects => 'اشیاء اور چیزیں';

  @override
  String get categoryEmotion => 'جذبہ';

  @override
  String get categoryArchaic => 'قدیم اور متروک';

  @override
  String get navStudy => 'مطالعہ';

  @override
  String get studyTitle => 'مطالعہ گاہ';

  @override
  String get studyCaption => 'قرأت، آواز اور روشنی';

  @override
  String get readingSection => 'قرأت';

  @override
  String get readingCaption => 'صفحہ کیسے بیٹھتا ہے';

  @override
  String get textSize => 'متن کا سائز';

  @override
  String get textSizeSample => 'Edulcorate — شیریں کرنا، نرم کرنا۔';

  @override
  String get smaller => 'چھوٹا';

  @override
  String get larger => 'بڑا';

  @override
  String get autoplayPronunciation => 'لفظ کھلتے ہی بلند آواز میں پڑھیں';

  @override
  String get reduceMotion => 'آرائش کو تھمائیں';

  @override
  String get reduceMotionCaption => 'کم بیل بوٹے اور رنگوں کی ڈھلوان';

  @override
  String get voiceSection => 'آواز';

  @override
  String get voiceCaption => 'Gloss کیسے بلند آواز میں پڑھتا ہے';

  @override
  String get chooseVoice => 'آواز';

  @override
  String get voiceDefault => 'آپ کے لیے منتخب';

  @override
  String get noOtherVoices => 'اس آلے پر کوئی اور انگریزی آواز نصب نہیں ہے۔';

  @override
  String get speechPace => 'رفتار';

  @override
  String get slower => 'آہستہ';

  @override
  String get faster => 'تیز تر';

  @override
  String get hearIt => 'سنیں';

  @override
  String get lightSection => 'روشنی';

  @override
  String get lightCaption => 'رَق یا شمع کی روشنی';

  @override
  String get themeSystem => 'آلے کے مطابق';

  @override
  String get themeLight => 'رَق';

  @override
  String get themeDark => 'شمع کی روشنی';

  @override
  String get tongueSection => 'زبان';

  @override
  String get aboutSection => 'تعارف';

  @override
  String get aboutCaption => 'یہ کیسے بنا';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'کھلے ماخذ کے لائسنس';

  @override
  String get shareGloss => 'Gloss شیئر کریں';

  @override
  String get followTheMaker => 'بنانے والے کو فالو کریں';

  @override
  String couldNotOpenLink(String label) {
    return '$label کو کھولا نہ جا سکا۔';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language میں وضاحتیں پڑھیں';
  }

  @override
  String get readExplanationsCaption =>
      'لفظ خود ہمیشہ انگریزی میں پڑھا جاتا ہے۔';

  @override
  String noVoiceInstalled(String language) {
    return 'اس آلے پر $language آواز نصب نہیں ہے۔';
  }

  @override
  String get memorySection => 'یادداشت';

  @override
  String get memoryCaption => 'Gloss کیا رکھتا ہے';

  @override
  String get forgetProgress => 'میری پیش رفت بھول جائیں';

  @override
  String get forgetProgressBody =>
      'جو الفاظ آپ نے دیکھے ہیں ان کا نشان ہٹ جائے گا۔ آپ کے محفوظ الفاظ رہیں گے۔';

  @override
  String get clearSavedWords => 'محفوظ الفاظ صاف کریں';

  @override
  String get clearSavedWordsBody =>
      'جو الفاظ آپ نے رکھے ہیں وہ ہٹا دیے جائیں گے۔ آپ کی پیش رفت رہے گی۔';

  @override
  String get cancel => 'منسوخ';

  @override
  String get forget => 'بھول جائیں';

  @override
  String get clear => 'صاف کریں';

  @override
  String get progressForgotten => 'پیش رفت بھلا دی گئی۔';

  @override
  String get savedWordsCleared => 'محفوظ الفاظ صاف کر دیے گئے۔';

  @override
  String get contactTitle => 'بنانے والے کو لکھیں';

  @override
  String get contactCaption => 'اگر آپ چاہیں تو ایک خط';

  @override
  String get contactBlurb =>
      'Gloss ایک ہی شخص بناتا ہے۔ جو لفظ آپ کو نہ ملا، جو غلطی آپ نے پکڑی، جو سطر آپ کو بھائی — سب ایک ہی میز تک پہنچتا ہے۔';

  @override
  String get contactLetterSection => 'خط';

  @override
  String get contactName => 'آپ کا نام';

  @override
  String get contactNameHint => 'وہ نام جس سے آپ کو پکارا جائے';

  @override
  String get contactEmail => 'آپ کا ای میل';

  @override
  String get contactEmailHint => 'جہاں جواب آپ تک پہنچ سکے';

  @override
  String contactEmailTypo(String domain) {
    return 'کیا آپ کی مراد $domain تھی؟';
  }

  @override
  String get contactReason => 'لکھنے کی وجہ';

  @override
  String get reasonWord => 'ایک لفظ جو شامل کیا جائے';

  @override
  String get reasonProblem => 'کچھ درست نہیں';

  @override
  String get reasonQuestion => 'ایک سوال';

  @override
  String get reasonPraise => 'رائے';

  @override
  String get reasonOther => 'کچھ اور';

  @override
  String get contactPriority => 'کتنی جلدی';

  @override
  String get priorityLow => 'کم';

  @override
  String get priorityNormal => 'عام';

  @override
  String get priorityHigh => 'زیادہ';

  @override
  String get contactMessage => 'آپ کا پیغام';

  @override
  String get contactMessageHint => 'جتنا چاہیں لکھیں، یا تھوڑا ہی…';

  @override
  String get contactHumanCheck => 'بھیجنے سے پہلے ایک لفظ';

  @override
  String contactHumanQuestion(String word) {
    return '$word کا مطلب ان میں سے کون سا ہے؟';
  }

  @override
  String get contactHumanRetry => 'وہ نہیں۔ یہ لیجیے دوسرا لفظ۔';

  @override
  String get contactDetails => 'ایپ کی تفصیل ساتھ بھیجیں';

  @override
  String get contactDetailsCaption =>
      'ورژن، زبان، روشنی اور متن کا سائز، تاکہ خرابی جلد مل جائے۔';

  @override
  String get contactSend => 'خط بھیجیں';

  @override
  String get contactCopyLetter => 'خط نقل کریں';

  @override
  String get contactDraftRestored => 'یہاں ایک بغیر بھیجا ہوا خط رکھا تھا۔';

  @override
  String get contactNoMailApp =>
      'کسی میل ایپ نے جواب نہیں دیا، سو خط کلپ بورڈ میں ہے۔';

  @override
  String get contactNeedName => 'ایک نام، تاکہ جواب جانے کہ کسے مخاطب کرنا ہے۔';

  @override
  String get contactNeedEmail => 'ایک پتہ جہاں جواب پہنچ سکے۔';

  @override
  String get contactNeedMessage => 'کم از کم ایک دو سطریں۔';

  @override
  String get contactSent => 'آپ کا خط راستے میں ہے۔ شکریہ۔';

  @override
  String get contactSendFailed =>
      'خط ابھی بھیجا نہ جا سکا۔ وہ کلپ بورڈ میں ہے اور یہاں بھی محفوظ ہے۔';

  @override
  String get contactSendByMail => 'اس کے بجائے میل ایپ استعمال کریں';
}
