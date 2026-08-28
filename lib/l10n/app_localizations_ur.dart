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
}
