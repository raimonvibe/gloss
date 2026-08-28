// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'พจนานุกรมแห่งภาษาอันงดงาม';

  @override
  String get navHome => 'หน้าหลัก';

  @override
  String get navLexicon => 'พจนานุกรม';

  @override
  String get navQuiz => 'แบบทดสอบ';

  @override
  String get navSaved => 'ที่บันทึกไว้';

  @override
  String get navLanguages => 'ภาษา';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count คำหายากและงดงามจากพจนานุกรม $lexicon — อธิบายอย่างที่เพื่อนจะอธิบาย ไม่ใช่ดิกชันนารี';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'สำรวจแล้ว $current จาก $total คำ';
  }

  @override
  String get exploreLexicon => 'สำรวจพจนานุกรม';

  @override
  String get startQuiz => 'เริ่มแบบทดสอบ';

  @override
  String get wordOfTheDay => 'คำประจำวัน';

  @override
  String get readFullEntry => 'อ่านรายการเต็ม →';

  @override
  String get lexiconTitle => 'พจนานุกรม';

  @override
  String get lexiconCaption => 'การรวบรวม';

  @override
  String get savedTitle => 'คำที่บันทึกไว้';

  @override
  String get savedCaption => 'เก็บไว้ใกล้ใจ';

  @override
  String get searchHint => 'ค้นหาคำ หรือบรรยายความหมาย…';

  @override
  String get clearSearch => 'ล้างการค้นหา';

  @override
  String get filterAll => 'ทั้งหมด';

  @override
  String get noMatches => 'ยังไม่พบ — ลองคำหรือความรู้สึกอื่น';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n รายการ',
      one: '1 รายการ',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ไม่มีอะไรที่นี่';

  @override
  String get emptyLexicon => 'มุมนี้ของพจนานุกรมยังว่างเปล่า';

  @override
  String get emptySaved => 'ยังไม่มีคำที่บันทึก แตะหัวใจที่รายการใดก็ได้';

  @override
  String get tapToReadMore => 'แตะเพื่ออ่านต่อ';

  @override
  String get saveWord => 'บันทึกคำ';

  @override
  String get removeFromFavorites => 'นำออกจากรายการโปรด';

  @override
  String get inPlainWords => 'เป็นคำง่าย ๆ';

  @override
  String get theDefinition => 'คำจำกัดความ';

  @override
  String get inASentence => 'ในประโยค';

  @override
  String get exampleGlossLabel => 'กล่าวอีกอย่าง';

  @override
  String get save => 'บันทึก';

  @override
  String get saved => 'บันทึกแล้ว';

  @override
  String get copy => 'คัดลอก';

  @override
  String get copiedToClipboard => 'คัดลอกไปยังคลิปบอร์ดแล้ว';

  @override
  String get roots => 'รากศัพท์';

  @override
  String get quizTitle => 'แบบทดสอบเล็ก ๆ';

  @override
  String get quizCaption => 'รู้จักราก แล้วเลือกความหมาย';

  @override
  String get quizIntro =>
      'แต่ละข้อแสดงคำและรากศัพท์ เลือกคำจำกัดความที่เข้ากัน — สี่ตัวเลือก มีหนึ่งข้อถูก';

  @override
  String get howManyWords => 'กี่คำ';

  @override
  String get begin => 'เริ่ม';

  @override
  String get quizByTheme => 'แบบทดสอบตามหัวข้อ';

  @override
  String get endQuiz => 'จบแบบทดสอบ';

  @override
  String questionOf(int index, int length) {
    return 'ข้อ $index จาก $length';
  }

  @override
  String get whichDefinitionFits => 'คำจำกัดความใดเข้ากัน?';

  @override
  String get previous => 'ก่อนหน้า';

  @override
  String get next => 'ถัดไป';

  @override
  String get seeResults => 'ดูผล';

  @override
  String get themeTitle => 'หัวข้อ';

  @override
  String get chooseASubject => 'เลือกหัวข้อ';

  @override
  String get noThemesYet => 'ยังไม่มีหัวข้อ';

  @override
  String get notEnoughWordsInTheme => 'หัวข้อนี้ยังมีคำไม่พอ';

  @override
  String get results => 'ผล';

  @override
  String get perfectPage => 'หน้ากระดาษที่สมบูรณ์';

  @override
  String get wellMarked => 'ทำเครื่องหมายไว้งาม';

  @override
  String get tryAnotherRound => 'ลองอีกรอบ';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'คำจำกัดความถูก $score ข้อ',
      one: 'คำจำกัดความถูก 1 ข้อ',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'คำจำกัดความถูก $score ข้อ จาก $total.',
      one: 'คำจำกัดความถูกหนึ่งข้อ จาก $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'สลับเป็นโหมดสว่าง';

  @override
  String get switchToDarkMode => 'สลับเป็นโหมดมืด';

  @override
  String get listen => 'ฟัง';

  @override
  String get stop => 'หยุด';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ภาษา';

  @override
  String get languagesCaption => 'ลิ้นต่าง ๆ';

  @override
  String get searchLanguages => 'ค้นหาประเทศหรือภาษา…';

  @override
  String get noMatchingLanguages => 'ไม่พบประเทศหรือภาษาที่ตรงกัน';

  @override
  String get selectedLanguage => 'กำลังอ่านเป็น';

  @override
  String get continentAfrica => 'แอฟริกา';

  @override
  String get continentAsia => 'เอเชีย';

  @override
  String get continentEurope => 'ยุโรป';

  @override
  String get continentAmericas => 'อเมริกา';

  @override
  String get continentOceania => 'โอเชียเนีย';

  @override
  String currentOfTotal(int current, int total) {
    return '$current จาก $total';
  }

  @override
  String speechAlso(String variants) {
    return 'รวมทั้ง $variants';
  }

  @override
  String speechAsIn(String example) {
    return 'เช่น: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'จาก $origin, $originWord';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form หมายถึง $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'เป็นคำง่าย ๆ: $friendly';
  }

  @override
  String get categorySpeech => 'วาจาและวาทศิลป์';

  @override
  String get categoryCharacter => 'นิสัยและอารมณ์';

  @override
  String get categoryCriticism => 'คำวิจารณ์และคำดูถูก';

  @override
  String get categoryVirtue => 'คุณธรรม';

  @override
  String get categoryVice => 'ความชั่ว';

  @override
  String get categoryKnowledge => 'ความรู้และความคิด';

  @override
  String get categoryReligion => 'ศาสนาและจิตวิญญาณ';

  @override
  String get categoryBeginnings => 'จุดเริ่มต้น';

  @override
  String get categoryConflict => 'ความขัดแย้งและการหลอกลวง';

  @override
  String get categoryAppearance => 'รูปลักษณ์และแสง';

  @override
  String get categoryPeople => 'ผู้คนและบทบาท';

  @override
  String get categoryObjects => 'วัตถุและสิ่งของ';

  @override
  String get categoryEmotion => 'อารมณ์';

  @override
  String get categoryArchaic => 'เก่าแก่และโบราณ';

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
