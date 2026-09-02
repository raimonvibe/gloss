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
  String get navStudy => 'المكتبة';

  @override
  String get studyTitle => 'غرفة المطالعة';

  @override
  String get studyCaption => 'القراءة والصوت والضوء';

  @override
  String get readingSection => 'القراءة';

  @override
  String get readingCaption => 'كيف تستقر الصفحة';

  @override
  String get textSize => 'حجم النص';

  @override
  String get textSizeSample => 'Edulcorate — أن يُحلّي، أن يُلطّف.';

  @override
  String get smaller => 'أصغر';

  @override
  String get larger => 'أكبر';

  @override
  String get autoplayPronunciation => 'اقرأ الكلمة بصوت عالٍ عند فتحها';

  @override
  String get reduceMotion => 'هدّئ الزخارف';

  @override
  String get reduceMotionCaption => 'زخارف وتدرّجات أقل';

  @override
  String get voiceSection => 'الصوت';

  @override
  String get voiceCaption => 'كيف يقرأ Gloss بصوت عالٍ';

  @override
  String get chooseVoice => 'الصوت';

  @override
  String get voiceDefault => 'اختير لك';

  @override
  String get noOtherVoices =>
      'لا توجد أصوات إنجليزية أخرى مثبّتة على هذا الجهاز.';

  @override
  String get speechPace => 'الإيقاع';

  @override
  String get slower => 'أبطأ';

  @override
  String get faster => 'أسرع';

  @override
  String get hearIt => 'استمع إليها';

  @override
  String get lightSection => 'الضوء';

  @override
  String get lightCaption => 'رَقّ أو ضوء شمعة';

  @override
  String get themeSystem => 'حسب الجهاز';

  @override
  String get themeLight => 'رَقّ';

  @override
  String get themeDark => 'ضوء الشمعة';

  @override
  String get tongueSection => 'اللسان';

  @override
  String get aboutSection => 'حول';

  @override
  String get aboutCaption => 'كيف صُنع';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'تراخيص المصدر المفتوح';

  @override
  String get shareGloss => 'شارك Gloss';

  @override
  String get followTheMaker => 'تابع صانعه';

  @override
  String couldNotOpenLink(String label) {
    return 'تعذّر فتح $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'اقرأ الشروح بـ$language';
  }

  @override
  String get readExplanationsCaption =>
      'تُقرأ الكلمة نفسها بالإنجليزية دائمًا.';

  @override
  String noVoiceInstalled(String language) {
    return 'لا يوجد صوت $language مثبّت على هذا الجهاز.';
  }

  @override
  String get memorySection => 'الذاكرة';

  @override
  String get memoryCaption => 'ما يحتفظ به Gloss';

  @override
  String get forgetProgress => 'انسَ تقدّمي';

  @override
  String get forgetProgressBody =>
      'ستُزال العلامة عن الكلمات التي استكشفتها. كلماتك المحفوظة تبقى.';

  @override
  String get clearSavedWords => 'مسح الكلمات المحفوظة';

  @override
  String get clearSavedWordsBody =>
      'ستُحذف الكلمات التي احتفظت بها. تقدّمك يبقى.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get forget => 'انسَ';

  @override
  String get clear => 'مسح';

  @override
  String get progressForgotten => 'نُسي التقدّم.';

  @override
  String get savedWordsCleared => 'مُسحت الكلمات المحفوظة.';

  @override
  String get contactTitle => 'اكتب إلى صانع التطبيق';

  @override
  String get contactCaption => 'رسالة، إن شئت';

  @override
  String get contactBlurb =>
      'يصنع Gloss شخص واحد. كلمة افتقدتها، خطأ وجدته، سطر أعجبك — كل ذلك يصل إلى المكتب نفسه.';

  @override
  String get contactLetterSection => 'الرسالة';

  @override
  String get contactName => 'اسمك';

  @override
  String get contactNameHint => 'الاسم الذي نحييك به';

  @override
  String get contactEmail => 'بريدك الإلكتروني';

  @override
  String get contactEmailHint => 'حيث يجدك الرد';

  @override
  String contactEmailTypo(String domain) {
    return 'هل قصدت $domain؟';
  }

  @override
  String get contactReason => 'سبب الكتابة';

  @override
  String get reasonWord => 'كلمة تستحق الإضافة';

  @override
  String get reasonProblem => 'هناك خطأ ما';

  @override
  String get reasonQuestion => 'سؤال';

  @override
  String get reasonPraise => 'ملاحظات';

  @override
  String get reasonOther => 'شيء آخر';

  @override
  String get contactPriority => 'ما مدى الاستعجال';

  @override
  String get priorityLow => 'منخفض';

  @override
  String get priorityNormal => 'عادي';

  @override
  String get priorityHigh => 'مرتفع';

  @override
  String get contactMessage => 'رسالتك';

  @override
  String get contactMessageHint => 'اكتب ما شئت، طال أو قصر…';

  @override
  String get contactHumanCheck => 'كلمة قبل الإرسال';

  @override
  String contactHumanQuestion(String word) {
    return 'أي معنى ينتمي إلى $word؟';
  }

  @override
  String get contactHumanRetry => 'ليس هذا. إليك كلمة أخرى.';

  @override
  String get contactDetails => 'أرفق تفاصيل التطبيق';

  @override
  String get contactDetailsCaption =>
      'الإصدار واللغة والإضاءة وحجم النص، ليُعثر على الخطأ أسرع.';

  @override
  String get contactSend => 'أرسل الرسالة';

  @override
  String get contactCopyLetter => 'انسخ الرسالة';

  @override
  String get contactDraftRestored => 'كانت هنا رسالة لم تُرسل.';

  @override
  String get contactNoMailApp =>
      'لم يستجب أي تطبيق بريد، فبقيت الرسالة في الحافظة.';

  @override
  String get contactNeedName => 'اسم، ليعرف الرد بمن يبدأ.';

  @override
  String get contactNeedEmail => 'عنوان يستطيع الرد بلوغه.';

  @override
  String get contactNeedMessage => 'سطر أو سطران على الأقل.';

  @override
  String get contactSent => 'رسالتك في طريقها. شكرًا لك.';

  @override
  String get contactSendFailed =>
      'تعذّر إرسال الرسالة الآن. هي في الحافظة ومحفوظة هنا أيضًا.';

  @override
  String get contactSendByMail => 'استخدم تطبيق بريد بدلاً من ذلك';
}
