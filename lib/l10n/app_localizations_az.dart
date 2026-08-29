// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'gözəl dilin lüğəti';

  @override
  String get navHome => 'Ana səhifə';

  @override
  String get navLexicon => 'Lüğət';

  @override
  String get navQuiz => 'Test';

  @override
  String get navSaved => 'Saxlanılanlar';

  @override
  String get navLanguages => 'Dillər';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon lüğətindən $count nadir, zəngin söz — lüğət kimi yox, dost izah edirmiş kimi.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total sözdən $current-i kəşf olunub';
  }

  @override
  String get exploreLexicon => 'Lüğəti kəşf et';

  @override
  String get startQuiz => 'Testə başla';

  @override
  String get wordOfTheDay => 'günün sözü';

  @override
  String get readFullEntry => 'Tam məqaləni oxu →';

  @override
  String get lexiconTitle => 'Lüğət';

  @override
  String get lexiconCaption => 'toplanmışlar';

  @override
  String get savedTitle => 'Saxlanılan sözlər';

  @override
  String get savedCaption => 'ürəyə yaxın';

  @override
  String get searchHint => 'Söz axtar, ya da mənasını təsvir et…';

  @override
  String get clearSearch => 'Axtarışı təmizlə';

  @override
  String get filterAll => 'Hamısı';

  @override
  String get noMatches => 'Hələ uyğunluq yoxdur — başqa söz və ya hiss yoxla.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n uyğunluq',
      one: '1 uyğunluq',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'burada heç nə yoxdur';

  @override
  String get emptyLexicon => 'Lüğətin bu küncündə heç nə yoxdur.';

  @override
  String get emptySaved =>
      'Hələ saxlanılan söz yoxdur. İstənilən məqalədə ürəyə toxun.';

  @override
  String get tapToReadMore => 'Daha çox oxumaq üçün toxun';

  @override
  String get saveWord => 'Sözü saxla';

  @override
  String get removeFromFavorites => 'Sevimlilərdən çıxar';

  @override
  String get inPlainWords => 'sadə dillə';

  @override
  String get theDefinition => 'tərif';

  @override
  String get inASentence => 'cümlədə';

  @override
  String get exampleGlossLabel => 'başqa sözlə';

  @override
  String get save => 'Saxla';

  @override
  String get saved => 'Saxlanıldı';

  @override
  String get copy => 'Kopyala';

  @override
  String get copiedToClipboard => 'Buferə kopyalandı';

  @override
  String get roots => 'köklər';

  @override
  String get quizTitle => 'Kiçik bir test';

  @override
  String get quizCaption => 'kökləri öyrən, sonra mənanı seç';

  @override
  String get quizIntro =>
      'Hər sual bir söz və onun etimologiyasını göstərir. Uyğun tərifi seç — dörd variant, biri doğrudur.';

  @override
  String get howManyWords => 'neçə söz';

  @override
  String get begin => 'Başla';

  @override
  String get quizByTheme => 'Mövzuya görə test';

  @override
  String get endQuiz => 'Testi bitir';

  @override
  String questionOf(int index, int length) {
    return 'Sual $index / $length';
  }

  @override
  String get whichDefinitionFits => 'hansı tərif uyğun gəlir?';

  @override
  String get previous => 'Əvvəlki';

  @override
  String get next => 'Növbəti';

  @override
  String get seeResults => 'Nəticələrə bax';

  @override
  String get themeTitle => 'Mövzu';

  @override
  String get chooseASubject => 'mövzu seç';

  @override
  String get noThemesYet => 'Hələ mövzu yoxdur.';

  @override
  String get notEnoughWordsInTheme =>
      'Bu mövzuda hələ kifayət qədər söz yoxdur.';

  @override
  String get results => 'Nəticələr';

  @override
  String get perfectPage => 'mükəmməl bir səhifə';

  @override
  String get wellMarked => 'gözəl işarələnib';

  @override
  String get tryAnotherRound => 'Başqa raund yoxla';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score doğru tərif',
      one: '1 doğru tərif',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score doğru tərif, $total içindən.',
      one: 'Bir doğru tərif, $total içindən.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'İşıqlı rejimə keç';

  @override
  String get switchToDarkMode => 'Qaranlıq rejimə keç';

  @override
  String get listen => 'Dinlə';

  @override
  String get stop => 'Dayandır';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Dillər';

  @override
  String get languagesCaption => 'dillər';

  @override
  String get searchLanguages => 'Ölkə və ya dil axtar…';

  @override
  String get noMatchingLanguages => 'Uyğun ölkə və ya dil yoxdur.';

  @override
  String get selectedLanguage => 'Oxu dili';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asiya';

  @override
  String get continentEurope => 'Avropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Okeaniya';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Həmçinin $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Məsələn: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin dilindən, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, mənası $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Sadə dillə: $friendly';
  }

  @override
  String get categorySpeech => 'Nitq və ritorika';

  @override
  String get categoryCharacter => 'Xarakter və temperament';

  @override
  String get categoryCriticism => 'Tənqid və təhqir';

  @override
  String get categoryVirtue => 'Fəzilət';

  @override
  String get categoryVice => 'Əxlaqsızlıq';

  @override
  String get categoryKnowledge => 'Bilik və düşüncə';

  @override
  String get categoryReligion => 'Din və ruh';

  @override
  String get categoryBeginnings => 'Başlanğıclar';

  @override
  String get categoryConflict => 'Münaqişə və aldatma';

  @override
  String get categoryAppearance => 'Görünüş və işıq';

  @override
  String get categoryPeople => 'İnsanlar və rollar';

  @override
  String get categoryObjects => 'Əşyalar və şeylər';

  @override
  String get categoryEmotion => 'Emosiya';

  @override
  String get categoryArchaic => 'Qədim və arxaik';

  @override
  String get navStudy => 'Kabinet';

  @override
  String get studyTitle => 'Kabinet';

  @override
  String get studyCaption => 'oxu, səs və işıq';

  @override
  String get readingSection => 'Oxu';

  @override
  String get readingCaption => 'səhifə necə oturur';

  @override
  String get textSize => 'Mətn ölçüsü';

  @override
  String get textSizeSample => 'Edulcorate — şirinləşdirmək, yumşaltmaq.';

  @override
  String get smaller => 'Daha kiçik';

  @override
  String get larger => 'Daha böyük';

  @override
  String get autoplayPronunciation => 'Söz açılanda ucadan oxunsun';

  @override
  String get reduceMotion => 'Bəzəkləri sakitləşdir';

  @override
  String get reduceMotionCaption => 'daha az naxış və keçid';

  @override
  String get voiceSection => 'Səs';

  @override
  String get voiceCaption => 'Gloss necə ucadan oxuyur';

  @override
  String get chooseVoice => 'Səs';

  @override
  String get voiceDefault => 'Sizin üçün seçilib';

  @override
  String get noOtherVoices => 'Bu cihazda başqa ingilis səsi quraşdırılmayıb.';

  @override
  String get speechPace => 'Sürət';

  @override
  String get slower => 'Daha yavaş';

  @override
  String get faster => 'Daha sürətli';

  @override
  String get hearIt => 'Dinlə';

  @override
  String get lightSection => 'İşıq';

  @override
  String get lightCaption => 'perqament və ya şam işığı';

  @override
  String get themeSystem => 'Cihaza uyğun';

  @override
  String get themeLight => 'Perqament';

  @override
  String get themeDark => 'Şam işığı';

  @override
  String get tongueSection => 'Dil';

  @override
  String get aboutSection => 'Haqqında';

  @override
  String get aboutCaption => 'necə hazırlanıb';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Açıq mənbə lisenziyaları';

  @override
  String get shareGloss => 'Gloss\'u paylaş';

  @override
  String get followTheMaker => 'Müəllifi izlə';

  @override
  String couldNotOpenLink(String label) {
    return '$label açıla bilmədi.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'İzahları $language dilində oxu';
  }

  @override
  String get readExplanationsCaption => 'Sözün özü həmişə ingiliscə oxunur.';

  @override
  String noVoiceInstalled(String language) {
    return 'Bu cihazda $language səsi quraşdırılmayıb.';
  }
}
