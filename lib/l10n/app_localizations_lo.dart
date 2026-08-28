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
}
