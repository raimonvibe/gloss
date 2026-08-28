// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'معجم للغة الآسرة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLexicon => 'المعجم';

  @override
  String get navQuiz => 'اختبار';

  @override
  String get navSaved => 'المحفوظات';

  @override
  String get navLanguages => 'اللغات';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count كلمة نادرة ثرية من معجم $lexicon — تُشرح كما يشرحها صديق، لا كما يشرحها قاموس.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'استُكشفت $current من $total كلمة';
  }

  @override
  String get exploreLexicon => 'استكشف المعجم';

  @override
  String get startQuiz => 'ابدأ اختباراً';

  @override
  String get wordOfTheDay => 'كلمة اليوم';

  @override
  String get readFullEntry => 'اقرأ المدخل كاملاً →';

  @override
  String get lexiconTitle => 'المعجم';

  @override
  String get lexiconCaption => 'المجموعة';

  @override
  String get savedTitle => 'الكلمات المحفوظة';

  @override
  String get savedCaption => 'قريبة من القلب';

  @override
  String get searchHint => 'ابحث عن كلمة، أو صِف معناها…';

  @override
  String get clearSearch => 'امسح البحث';

  @override
  String get filterAll => 'الكل';

  @override
  String get noMatches => 'لا نتائج بعد — جرّب كلمة أو إحساساً آخر.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نتائج',
      one: 'نتيجة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'لا شيء هنا';

  @override
  String get emptyLexicon => 'لا شيء في هذه الزاوية من المعجم.';

  @override
  String get emptySaved => 'لا كلمات محفوظة بعد. اضغط القلب على أي مدخل.';

  @override
  String get tapToReadMore => 'اضغط للقراءة المزيد';

  @override
  String get saveWord => 'احفظ الكلمة';

  @override
  String get removeFromFavorites => 'أزل من المفضّلات';

  @override
  String get inPlainWords => 'بكلمات بسيطة';

  @override
  String get theDefinition => 'التعريف';

  @override
  String get inASentence => 'في جملة';

  @override
  String get exampleGlossLabel => 'بعبارة أخرى';

  @override
  String get save => 'حفظ';

  @override
  String get saved => 'محفوظ';

  @override
  String get copy => 'نسخ';

  @override
  String get copiedToClipboard => 'نُسخ إلى الحافظة';

  @override
  String get roots => 'الجذور';

  @override
  String get quizTitle => 'اختبار صغير';

  @override
  String get quizCaption => 'اعرف الجذور، ثم اختر المعنى';

  @override
  String get quizIntro =>
      'كل سؤال يعرض كلمة وأصلها. اختر التعريف المناسب — أربعة خيارات، واحد صحيح.';

  @override
  String get howManyWords => 'كم كلمة';

  @override
  String get begin => 'ابدأ';

  @override
  String get quizByTheme => 'اختبار حسب الموضوع';

  @override
  String get endQuiz => 'إنهاء الاختبار';

  @override
  String questionOf(int index, int length) {
    return 'السؤال $index من $length';
  }

  @override
  String get whichDefinitionFits => 'أي تعريف يناسب؟';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get seeResults => 'عرض النتائج';

  @override
  String get themeTitle => 'الموضوع';

  @override
  String get chooseASubject => 'اختر موضوعاً';

  @override
  String get noThemesYet => 'لا موضوعات بعد.';

  @override
  String get notEnoughWordsInTheme => 'لا تكفي الكلمات في هذا الموضوع بعد.';

  @override
  String get results => 'النتائج';

  @override
  String get perfectPage => 'صفحة كاملة';

  @override
  String get wellMarked => 'علامة طيبة';

  @override
  String get tryAnotherRound => 'جرّب جولة أخرى';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score تعريفات صحيحة',
      one: 'تعريف واحد صحيح',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score تعريفات صحيحة، من أصل $total.',
      one: 'تعريف واحد صحيح، من أصل $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'التبديل إلى الوضع الفاتح';

  @override
  String get switchToDarkMode => 'التبديل إلى الوضع الداكن';

  @override
  String get listen => 'استمع';

  @override
  String get stop => 'توقف';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'اللغات';

  @override
  String get languagesCaption => 'الألسنة';

  @override
  String get searchLanguages => 'ابحث عن بلد أو لغة…';

  @override
  String get noMatchingLanguages => 'لا بلدان أو لغات مطابقة.';

  @override
  String get selectedLanguage => 'القراءة بـ';

  @override
  String get continentAfrica => 'أفريقيا';

  @override
  String get continentAsia => 'آسيا';

  @override
  String get continentEurope => 'أوروبا';

  @override
  String get continentAmericas => 'الأمريكتان';

  @override
  String get continentOceania => 'أوقيانوسيا';

  @override
  String currentOfTotal(int current, int total) {
    return '$current من $total';
  }

  @override
  String speechAlso(String variants) {
    return 'وأيضاً $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'كما في: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'من $origin، $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form، بمعنى $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'بكلمات بسيطة: $friendly';
  }

  @override
  String get categorySpeech => 'الكلام والبلاغة';

  @override
  String get categoryCharacter => 'الطبع والمزاج';

  @override
  String get categoryCriticism => 'النقد والإهانة';

  @override
  String get categoryVirtue => 'الفضيلة';

  @override
  String get categoryVice => 'الرذيلة';

  @override
  String get categoryKnowledge => 'المعرفة والفكر';

  @override
  String get categoryReligion => 'الدين والروح';

  @override
  String get categoryBeginnings => 'البدايات';

  @override
  String get categoryConflict => 'النزاع والخداع';

  @override
  String get categoryAppearance => 'المظهر والنور';

  @override
  String get categoryPeople => 'الناس والأدوار';

  @override
  String get categoryObjects => 'الأشياء والمواد';

  @override
  String get categoryEmotion => 'العاطفة';

  @override
  String get categoryArchaic => 'القديم والمهجور';

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
