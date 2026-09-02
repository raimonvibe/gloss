// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lao (`lo`).
class AppLocalizationsLo extends AppLocalizations {
  AppLocalizationsLo([String locale = 'lo']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'ພົດຈະນານຸກົມຂອງພາສາງາມ';

  @override
  String get navHome => 'ໜ້າຫຼັກ';

  @override
  String get navLexicon => 'ພົດຈະນານຸກົມ';

  @override
  String get navQuiz => 'ແບບທົດສອບ';

  @override
  String get navSaved => 'ບັນທຶກໄວ້';

  @override
  String get navLanguages => 'ພາສາ';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count ຄຳທີ່ຫາຍາກ ແລະ ອຸດົມ ຈາກພົດຈະນານຸກົມ $lexicon — ອະທິບາຍແບບໝູ່ ບໍ່ແມ່ນແບບພົດຈະນານຸກົມ.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'ສຳຫຼວດແລ້ວ $current ຈາກ $total ຄຳ';
  }

  @override
  String get exploreLexicon => 'ສຳຫຼວດພົດຈະນານຸກົມ';

  @override
  String get startQuiz => 'ເລີ່ມແບບທົດສອບ';

  @override
  String get wordOfTheDay => 'ຄຳປະຈຳວັນ';

  @override
  String get readFullEntry => 'ອ່ານລາຍການເຕັມ →';

  @override
  String get lexiconTitle => 'ພົດຈະນານຸກົມ';

  @override
  String get lexiconCaption => 'ການເກັບຮວບຮວມ';

  @override
  String get savedTitle => 'ຄຳທີ່ບັນທຶກໄວ້';

  @override
  String get savedCaption => 'ໃກ້ໃຈ';

  @override
  String get searchHint => 'ຄົ້ນຫາຄຳ ຫຼື ອະທິບາຍຄວາມໝາຍ…';

  @override
  String get clearSearch => 'ລຶບການຄົ້ນຫາ';

  @override
  String get filterAll => 'ທັງໝົດ';

  @override
  String get noMatches => 'ຍັງບໍ່ພົບຜົນ — ລອງຄຳ ຫຼື ຄວາມຮູ້ສຶກອື່ນ.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ຜົນ',
      one: '1 ຜົນ',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ບໍ່ມີຫຍັງທີ່ນີ້';

  @override
  String get emptyLexicon => 'ບໍ່ມີຫຍັງໃນມຸມນີ້ຂອງພົດຈະນານຸກົມ.';

  @override
  String get emptySaved => 'ຍັງບໍ່ມີຄຳທີ່ບັນທຶກ. ແຕະຫົວໃຈໃນລາຍການໃດກໍໄດ້.';

  @override
  String get tapToReadMore => 'ແຕະເພື່ອອ່ານຕໍ່';

  @override
  String get saveWord => 'ບັນທຶກຄຳ';

  @override
  String get removeFromFavorites => 'ເອົາອອກຈາກລາຍການທີ່ມັກ';

  @override
  String get inPlainWords => 'ເປັນຄຳງ່າຍໆ';

  @override
  String get theDefinition => 'ນິຍາມ';

  @override
  String get inASentence => 'ໃນປະໂຫຍກ';

  @override
  String get exampleGlossLabel => 'ອີກຢ່າງໜຶ່ງ';

  @override
  String get save => 'ບັນທຶກ';

  @override
  String get saved => 'ບັນທຶກແລ້ວ';

  @override
  String get copy => 'ສຳເນົາ';

  @override
  String get copiedToClipboard => 'ສຳເນົາໄປຄລິບບອດແລ້ວ';

  @override
  String get roots => 'ຮາກ';

  @override
  String get quizTitle => 'ແບບທົດສອບນ້ອຍໆ';

  @override
  String get quizCaption => 'ຮູ້ຮາກ ແລ້ວເລືອກຄວາມໝາຍ';

  @override
  String get quizIntro =>
      'ແຕ່ລະຄຳຖາມສະແດງຄຳ ແລະ ພົດສະກຳ. ເລືອກນິຍາມທີ່ເໝາະ — ສີ່ຕົວເລືອກ, ໜຶ່ງຖືກ.';

  @override
  String get howManyWords => 'ຈັກຄຳ';

  @override
  String get begin => 'ເລີ່ມ';

  @override
  String get quizByTheme => 'ແບບທົດສອບຕາມຫົວຂໍ້';

  @override
  String get endQuiz => 'ຈົບແບບທົດສອບ';

  @override
  String questionOf(int index, int length) {
    return 'ຄຳຖາມ $index ຈາກ $length';
  }

  @override
  String get whichDefinitionFits => 'ນິຍາມໃດເໝາະ?';

  @override
  String get previous => 'ກ່ອນໜ້າ';

  @override
  String get next => 'ຕໍ່ໄປ';

  @override
  String get seeResults => 'ເບິ່ງຜົນ';

  @override
  String get themeTitle => 'ຫົວຂໍ້';

  @override
  String get chooseASubject => 'ເລືອກຫົວຂໍ້';

  @override
  String get noThemesYet => 'ຍັງບໍ່ມີຫົວຂໍ້.';

  @override
  String get notEnoughWordsInTheme => 'ຫົວຂໍ້ນີ້ຍັງມີຄຳບໍ່ພຽງພໍ.';

  @override
  String get results => 'ຜົນ';

  @override
  String get perfectPage => 'ໜ້າທີ່ສົມບູນ';

  @override
  String get wellMarked => 'ໝາຍໄວ້ງາມ';

  @override
  String get tryAnotherRound => 'ລອງອີກຮອບ';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'ນິຍາມຖືກ $score',
      one: 'ນິຍາມຖືກ 1',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'ນິຍາມຖືກ $score, ຈາກ $total.',
      one: 'ນິຍາມຖືກໜຶ່ງ, ຈາກ $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'ປ່ຽນເປັນໂໝດສະຫວ່າງ';

  @override
  String get switchToDarkMode => 'ປ່ຽນເປັນໂໝດມືດ';

  @override
  String get listen => 'ຟັງ';

  @override
  String get stop => 'ຢຸດ';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'ພາສາ';

  @override
  String get languagesCaption => 'ລີ້ນ';

  @override
  String get searchLanguages => 'ຄົ້ນຫາປະເທດ ຫຼື ພາສາ…';

  @override
  String get noMatchingLanguages => 'ບໍ່ມີປະເທດ ຫຼື ພາສາທີ່ກົງ.';

  @override
  String get selectedLanguage => 'ກຳລັງອ່ານເປັນ';

  @override
  String get continentAfrica => 'ອາຟຣິກາ';

  @override
  String get continentAsia => 'ອາຊີ';

  @override
  String get continentEurope => 'ເອີຣົບ';

  @override
  String get continentAmericas => 'ອາເມລິກາ';

  @override
  String get continentOceania => 'ໂອເຊອານີ';

  @override
  String currentOfTotal(int current, int total) {
    return '$current ຈາກ $total';
  }

  @override
  String speechAlso(String variants) {
    return 'ຍັງມີ $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'ເຊັ່ນ: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'ຈາກ $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, ໝາຍຄວາມວ່າ $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'ເປັນຄຳງ່າຍໆ: $friendly';
  }

  @override
  String get categorySpeech => 'ການກ່າວ ແລະ ວາທະສິນ';

  @override
  String get categoryCharacter => 'ນິໄສ ແລະ ອາລົມ';

  @override
  String get categoryCriticism => 'ການວິຈານ ແລະ ການດູຖູກ';

  @override
  String get categoryVirtue => 'ຄຸນນະທຳ';

  @override
  String get categoryVice => 'ຄວາມຊົ່ວ';

  @override
  String get categoryKnowledge => 'ຄວາມຮູ້ ແລະ ຄວາມຄິດ';

  @override
  String get categoryReligion => 'ສາສະໜາ ແລະ ຈິດວິນຍານ';

  @override
  String get categoryBeginnings => 'ຈຸດເລີ່ມຕົ້ນ';

  @override
  String get categoryConflict => 'ຂໍ້ຂັດແຍ່ງ ແລະ ການຫຼອກລວງ';

  @override
  String get categoryAppearance => 'ຮູບຮ່າງ ແລະ ແສງ';

  @override
  String get categoryPeople => 'ຄົນ ແລະ ບົດບາດ';

  @override
  String get categoryObjects => 'ວັດຖຸ ແລະ ສິ່ງຂອງ';

  @override
  String get categoryEmotion => 'ອາລົມ';

  @override
  String get categoryArchaic => 'ເກົ່າ ແລະ ໂບຮານ';

  @override
  String get navStudy => 'ຫ້ອງອ່ານ';

  @override
  String get studyTitle => 'ຫ້ອງອ່ານໜັງສື';

  @override
  String get studyCaption => 'ການອ່ານ, ສຽງ ແລະ ແສງ';

  @override
  String get readingSection => 'ການອ່ານ';

  @override
  String get readingCaption => 'ໜ້າເຈ້ຍວາງຕົວແນວໃດ';

  @override
  String get textSize => 'ຂະໜາດຕົວອັກສອນ';

  @override
  String get textSizeSample => 'Edulcorate — ເຮັດໃຫ້ຫວານ, ເຮັດໃຫ້ອ່ອນລົງ.';

  @override
  String get smaller => 'ນ້ອຍລົງ';

  @override
  String get larger => 'ໃຫຍ່ຂຶ້ນ';

  @override
  String get autoplayPronunciation => 'ອ່ານຄຳອອກສຽງເມື່ອເປີດ';

  @override
  String get reduceMotion => 'ເຮັດໃຫ້ລວດລາຍງຽບລົງ';

  @override
  String get reduceMotionCaption => 'ລວດລາຍ ແລະ ສີໄລ່ນ້ອຍລົງ';

  @override
  String get voiceSection => 'ສຽງ';

  @override
  String get voiceCaption => 'Gloss ອ່ານອອກສຽງແນວໃດ';

  @override
  String get chooseVoice => 'ສຽງ';

  @override
  String get voiceDefault => 'ເລືອກໃຫ້ທ່ານ';

  @override
  String get noOtherVoices => 'ບໍ່ມີສຽງພາສາອັງກິດອື່ນຕິດຕັ້ງຢູ່ໃນອຸປະກອນນີ້.';

  @override
  String get speechPace => 'ຈັງຫວະ';

  @override
  String get slower => 'ຊ້າລົງ';

  @override
  String get faster => 'ໄວຂຶ້ນ';

  @override
  String get hearIt => 'ຟັງ';

  @override
  String get lightSection => 'ແສງ';

  @override
  String get lightCaption => 'ແຜ່ນໜັງ ຫຼື ແສງທຽນ';

  @override
  String get themeSystem => 'ຕາມອຸປະກອນ';

  @override
  String get themeLight => 'ແຜ່ນໜັງ';

  @override
  String get themeDark => 'ແສງທຽນ';

  @override
  String get tongueSection => 'ພາສາ';

  @override
  String get aboutSection => 'ກ່ຽວກັບ';

  @override
  String get aboutCaption => 'ມັນຖືກສ້າງຂຶ້ນແນວໃດ';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'ໃບອະນຸຍາດແຫຼ່ງເປີດ';

  @override
  String get shareGloss => 'ແບ່ງປັນ Gloss';

  @override
  String get followTheMaker => 'ຕິດຕາມຜູ້ສ້າງ';

  @override
  String couldNotOpenLink(String label) {
    return 'ບໍ່ສາມາດເປີດ $label ໄດ້.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'ອ່ານຄຳອະທິບາຍເປັນພາສາ $language';
  }

  @override
  String get readExplanationsCaption => 'ຄຳສັບເອງຈະຖືກອ່ານເປັນພາສາອັງກິດສະເໝີ.';

  @override
  String noVoiceInstalled(String language) {
    return 'ອຸປະກອນນີ້ບໍ່ມີສຽງ $language ຕິດຕັ້ງໄວ້.';
  }

  @override
  String get memorySection => 'ຄວາມຊົງຈຳ';

  @override
  String get memoryCaption => 'ສິ່ງທີ່ Gloss ເກັບໄວ້';

  @override
  String get forgetProgress => 'ລືມຄວາມກ້າວໜ້າຂອງຂ້ອຍ';

  @override
  String get forgetProgressBody =>
      'ເຄື່ອງໝາຍຂອງຄຳທີ່ທ່ານໄດ້ສຳຫຼວດຈະຖືກລຶບອອກ. ຄຳທີ່ບັນທຶກໄວ້ຍັງຢູ່.';

  @override
  String get clearSavedWords => 'ລຶບຄຳທີ່ບັນທຶກໄວ້';

  @override
  String get clearSavedWordsBody =>
      'ຄຳທີ່ທ່ານເກັບໄວ້ຈະຖືກລຶບອອກ. ຄວາມກ້າວໜ້າຂອງທ່ານຍັງຢູ່.';

  @override
  String get cancel => 'ຍົກເລີກ';

  @override
  String get forget => 'ລືມ';

  @override
  String get clear => 'ລຶບ';

  @override
  String get progressForgotten => 'ລືມຄວາມກ້າວໜ້າແລ້ວ.';

  @override
  String get savedWordsCleared => 'ລຶບຄຳທີ່ບັນທຶກໄວ້ແລ້ວ.';

  @override
  String get contactTitle => 'ຂຽນເຖິງຜູ້ສ້າງ';

  @override
  String get contactCaption => 'ຈົດໝາຍສະບັບໜຶ່ງ ຖ້າທ່ານຢາກ';

  @override
  String get contactBlurb =>
      'Gloss ສ້າງຂຶ້ນໂດຍຄົນຜູ້ດຽວ. ຄຳທີ່ທ່ານຄິດຮອດ, ຂໍ້ຜິດພາດທີ່ທ່ານພົບ, ແຖວທີ່ທ່ານມັກ — ທັງໝົດມາເຖິງໂຕະດຽວກັນ.';

  @override
  String get contactLetterSection => 'ຈົດໝາຍ';

  @override
  String get contactName => 'ຊື່ຂອງທ່ານ';

  @override
  String get contactNameHint => 'ຊື່ທີ່ໃຊ້ທັກທາຍທ່ານ';

  @override
  String get contactEmail => 'ອີເມວຂອງທ່ານ';

  @override
  String get contactEmailHint => 'ບ່ອນທີ່ຄຳຕອບຈະໄປເຖິງທ່ານ';

  @override
  String contactEmailTypo(String domain) {
    return 'ທ່ານໝາຍເຖິງ $domain ບໍ?';
  }

  @override
  String get contactReason => 'ເຫດຜົນທີ່ຂຽນ';

  @override
  String get reasonWord => 'ຄຳໜຶ່ງທີ່ຄວນເພີ່ມ';

  @override
  String get reasonProblem => 'ມີບາງຢ່າງບໍ່ຖືກຕ້ອງ';

  @override
  String get reasonQuestion => 'ຄຳຖາມ';

  @override
  String get reasonPraise => 'ຄຳຕິຊົມ';

  @override
  String get reasonOther => 'ເລື່ອງອື່ນ';

  @override
  String get contactPriority => 'ຮີບດ່ວນປານໃດ';

  @override
  String get priorityLow => 'ຕໍ່າ';

  @override
  String get priorityNormal => 'ທຳມະດາ';

  @override
  String get priorityHigh => 'ສູງ';

  @override
  String get contactMessage => 'ຂໍ້ຄວາມຂອງທ່ານ';

  @override
  String get contactMessageHint => 'ຂຽນຍາວຫຼືສັ້ນຕາມໃຈທ່ານ…';

  @override
  String get contactHumanCheck => 'ອີກຄຳໜຶ່ງກ່ອນສົ່ງ';

  @override
  String contactHumanQuestion(String word) {
    return 'ຄວາມໝາຍໃດເປັນຂອງ $word?';
  }

  @override
  String get contactHumanRetry => 'ບໍ່ແມ່ນຄຳນັ້ນ. ນີ້ແມ່ນອີກຄຳໜຶ່ງ.';

  @override
  String get contactDetails => 'ແນບຂໍ້ມູນຂອງແອັບ';

  @override
  String get contactDetailsCaption =>
      'ລຸ້ນ, ພາສາ, ແສງ ແລະ ຂະໜາດຕົວອັກສອນ, ເພື່ອຫາຂໍ້ຜິດພາດໄດ້ໄວຂຶ້ນ.';

  @override
  String get contactSend => 'ສົ່ງຈົດໝາຍ';

  @override
  String get contactCopyLetter => 'ສຳເນົາຈົດໝາຍ';

  @override
  String get contactDraftRestored => 'ມີຈົດໝາຍທີ່ຍັງບໍ່ໄດ້ສົ່ງລໍຖ້າຢູ່ນີ້.';

  @override
  String get contactNoMailApp =>
      'ບໍ່ມີແອັບອີເມວຕອບຮັບ, ຈົດໝາຍຈຶ່ງຢູ່ໃນຄລິບບອດ.';

  @override
  String get contactNeedName => 'ຊື່ໜຶ່ງ ເພື່ອໃຫ້ຄຳຕອບຮູ້ວ່າຈະທັກໃຜ.';

  @override
  String get contactNeedEmail => 'ທີ່ຢູ່ທີ່ຄຳຕອບໄປເຖິງໄດ້.';

  @override
  String get contactNeedMessage => 'ຢ່າງໜ້ອຍໜຶ່ງຫຼືສອງແຖວ.';

  @override
  String get contactSent => 'ຈົດໝາຍຂອງທ່ານກຳລັງເດີນທາງ. ຂອບໃຈ.';

  @override
  String get contactSendFailed =>
      'ຕອນນີ້ສົ່ງຈົດໝາຍບໍ່ໄດ້. ມັນຢູ່ໃນຄລິບບອດ ແລະ ຍັງເກັບໄວ້ນີ້.';

  @override
  String get contactSendByMail => 'ໃຊ້ແອັບອີເມວແທນ';
}
