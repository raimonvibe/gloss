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
  String get navStudy => 'ห้องอ่าน';

  @override
  String get studyTitle => 'ห้องอ่านหนังสือ';

  @override
  String get studyCaption => 'การอ่าน เสียง และแสง';

  @override
  String get readingSection => 'การอ่าน';

  @override
  String get readingCaption => 'หน้ากระดาษวางตัวอย่างไร';

  @override
  String get textSize => 'ขนาดตัวอักษร';

  @override
  String get textSizeSample => 'Edulcorate — ทำให้หวาน ทำให้อ่อนโยน';

  @override
  String get smaller => 'เล็กลง';

  @override
  String get larger => 'ใหญ่ขึ้น';

  @override
  String get autoplayPronunciation => 'อ่านคำออกเสียงเมื่อเปิด';

  @override
  String get reduceMotion => 'ลดทอนลวดลาย';

  @override
  String get reduceMotionCaption => 'ลวดลายและไล่สีน้อยลง';

  @override
  String get voiceSection => 'เสียง';

  @override
  String get voiceCaption => 'Gloss อ่านออกเสียงอย่างไร';

  @override
  String get chooseVoice => 'เสียง';

  @override
  String get voiceDefault => 'เลือกไว้ให้คุณ';

  @override
  String get noOtherVoices => 'ไม่มีเสียงภาษาอังกฤษอื่นติดตั้งอยู่ในอุปกรณ์นี้';

  @override
  String get speechPace => 'จังหวะ';

  @override
  String get slower => 'ช้าลง';

  @override
  String get faster => 'เร็วขึ้น';

  @override
  String get hearIt => 'ฟัง';

  @override
  String get lightSection => 'แสง';

  @override
  String get lightCaption => 'แผ่นหนังหรือแสงเทียน';

  @override
  String get themeSystem => 'ตามอุปกรณ์';

  @override
  String get themeLight => 'แผ่นหนัง';

  @override
  String get themeDark => 'แสงเทียน';

  @override
  String get tongueSection => 'ภาษา';

  @override
  String get aboutSection => 'เกี่ยวกับ';

  @override
  String get aboutCaption => 'สร้างขึ้นมาอย่างไร';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'สัญญาอนุญาตโอเพนซอร์ส';

  @override
  String get shareGloss => 'แบ่งปัน Gloss';

  @override
  String get followTheMaker => 'ติดตามผู้สร้าง';

  @override
  String couldNotOpenLink(String label) {
    return 'ไม่สามารถเปิด $label ได้';
  }

  @override
  String readExplanationsIn(String language) {
    return 'อ่านคำอธิบายเป็นภาษา $language';
  }

  @override
  String get readExplanationsCaption => 'ตัวคำนั้นจะอ่านเป็นภาษาอังกฤษเสมอ';

  @override
  String noVoiceInstalled(String language) {
    return 'อุปกรณ์นี้ไม่มีเสียง $language ติดตั้งอยู่';
  }

  @override
  String get memorySection => 'ความทรงจำ';

  @override
  String get memoryCaption => 'สิ่งที่ Gloss เก็บไว้';

  @override
  String get forgetProgress => 'ลืมความคืบหน้าของฉัน';

  @override
  String get forgetProgressBody =>
      'เครื่องหมายของคำที่คุณสำรวจแล้วจะถูกลบออก คำที่บันทึกไว้ยังคงอยู่';

  @override
  String get clearSavedWords => 'ล้างคำที่บันทึกไว้';

  @override
  String get clearSavedWordsBody =>
      'คำที่คุณเก็บไว้จะถูกลบออก ความคืบหน้าของคุณยังคงอยู่';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get forget => 'ลืม';

  @override
  String get clear => 'ล้าง';

  @override
  String get progressForgotten => 'ลืมความคืบหน้าแล้ว';

  @override
  String get savedWordsCleared => 'ล้างคำที่บันทึกไว้แล้ว';

  @override
  String get contactTitle => 'เขียนถึงผู้สร้าง';

  @override
  String get contactCaption => 'จดหมายสักฉบับ ถ้าคุณอยาก';

  @override
  String get contactBlurb =>
      'Gloss ทำโดยคนเพียงคนเดียว คำที่คุณคิดถึง ข้อผิดพลาดที่คุณพบ บรรทัดที่คุณชอบ — ทั้งหมดมาถึงโต๊ะตัวเดียวกัน';

  @override
  String get contactLetterSection => 'จดหมาย';

  @override
  String get contactName => 'ชื่อของคุณ';

  @override
  String get contactNameHint => 'ชื่อที่ใช้ทักทายคุณ';

  @override
  String get contactEmail => 'อีเมลของคุณ';

  @override
  String get contactEmailHint => 'ที่ที่คำตอบจะไปถึงคุณ';

  @override
  String contactEmailTypo(String domain) {
    return 'คุณหมายถึง $domain หรือเปล่า';
  }

  @override
  String get contactReason => 'เหตุที่เขียน';

  @override
  String get reasonWord => 'คำที่อยากให้เพิ่ม';

  @override
  String get reasonProblem => 'มีบางอย่างผิดพลาด';

  @override
  String get reasonQuestion => 'คำถาม';

  @override
  String get reasonPraise => 'ความเห็น';

  @override
  String get reasonOther => 'เรื่องอื่น';

  @override
  String get contactPriority => 'เร่งด่วนแค่ไหน';

  @override
  String get priorityLow => 'ต่ำ';

  @override
  String get priorityNormal => 'ปกติ';

  @override
  String get priorityHigh => 'สูง';

  @override
  String get contactMessage => 'ข้อความของคุณ';

  @override
  String get contactMessageHint => 'เขียนยาวหรือสั้นก็ได้ตามใจ…';

  @override
  String get contactHumanCheck => 'อีกคำหนึ่งก่อนส่ง';

  @override
  String contactHumanQuestion(String word) {
    return 'ความหมายใดเป็นของ $word';
  }

  @override
  String get contactHumanRetry => 'ไม่ใช่คำนั้น นี่คืออีกคำหนึ่ง';

  @override
  String get contactDetails => 'แนบข้อมูลของแอปด้วย';

  @override
  String get contactDetailsCaption =>
      'รุ่น ภาษา แสง และขนาดตัวอักษร เพื่อให้หาข้อผิดพลาดได้เร็วขึ้น';

  @override
  String get contactSend => 'ส่งจดหมาย';

  @override
  String get contactCopyLetter => 'คัดลอกจดหมาย';

  @override
  String get contactDraftRestored => 'มีจดหมายที่ยังไม่ได้ส่งรออยู่ที่นี่';

  @override
  String get contactNoMailApp => 'ไม่มีแอปอีเมลตอบรับ จดหมายจึงอยู่ในคลิปบอร์ด';

  @override
  String get contactNeedName => 'ชื่อสักชื่อ เพื่อให้คำตอบรู้ว่าจะทักใคร';

  @override
  String get contactNeedEmail => 'ที่อยู่ที่คำตอบไปถึงได้';

  @override
  String get contactNeedMessage => 'อย่างน้อยสักบรรทัดสองบรรทัด';

  @override
  String get contactSent => 'จดหมายของคุณกำลังเดินทาง ขอบคุณ';

  @override
  String get contactSendFailed =>
      'ตอนนี้ส่งจดหมายไม่สำเร็จ จดหมายอยู่ในคลิปบอร์ดและยังเก็บไว้ที่นี่';

  @override
  String get contactSendByMail => 'ใช้แอปอีเมลแทน';
}
