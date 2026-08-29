// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'сулуу тил лексикону';

  @override
  String get navHome => 'Башкы бет';

  @override
  String get navLexicon => 'Лексикон';

  @override
  String get navQuiz => 'Суроо';

  @override
  String get navSaved => 'Сакталган';

  @override
  String get navLanguages => 'Тилдер';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon лексиконунан $count сейрек, бай сөз — сөздүкчө эмес, дос түшүндүргөндөй.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total сөздүн $currentи изилденди';
  }

  @override
  String get exploreLexicon => 'Лексиконду изилдөө';

  @override
  String get startQuiz => 'Суроону баштоо';

  @override
  String get wordOfTheDay => 'күндүн сөзү';

  @override
  String get readFullEntry => 'Толук макаланы окуу →';

  @override
  String get lexiconTitle => 'Лексикон';

  @override
  String get lexiconCaption => 'жыйнак';

  @override
  String get savedTitle => 'Сакталган сөздөр';

  @override
  String get savedCaption => 'жүрөккө жакын';

  @override
  String get searchHint => 'Сөз издеңиз же маанисин сүрөттөңүз…';

  @override
  String get clearSearch => 'Издөөнү тазалоо';

  @override
  String get filterAll => 'Баары';

  @override
  String get noMatches =>
      'Азырынча дал келүү жок — башка сөз же сезимди байкап көрүңүз.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дал келүү',
      one: '1 дал келүү',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'бул жерде эч нерсе жок';

  @override
  String get emptyLexicon => 'Лексикондун бул бурчунда эч нерсе жок.';

  @override
  String get emptySaved =>
      'Азырынча сакталган сөз жок. Каалаган макаладагы жүрөкчөнү басыңыз.';

  @override
  String get tapToReadMore => 'Көбүрөөк окуу үчүн басыңыз';

  @override
  String get saveWord => 'Сөздү сактоо';

  @override
  String get removeFromFavorites => 'Сүйүктүүлөрдөн чыгаруу';

  @override
  String get inPlainWords => 'жөнөкөй сөз менен';

  @override
  String get theDefinition => 'аныктама';

  @override
  String get inASentence => 'сүйлөмдө';

  @override
  String get exampleGlossLabel => 'башкача айтканда';

  @override
  String get save => 'Сактоо';

  @override
  String get saved => 'Сакталды';

  @override
  String get copy => 'Көчүрүү';

  @override
  String get copiedToClipboard => 'Алмашуу буферине көчүрүлдү';

  @override
  String get roots => 'тамырлар';

  @override
  String get quizTitle => 'Кичинекей суроо';

  @override
  String get quizCaption => 'тамырларды бил, андан кийин маанини танда';

  @override
  String get quizIntro =>
      'Ар бир суроо сөздү жана анын этимологиясын көрсөтөт. Туура аныктаманы тандаңыз — төрт вариант, бири чын.';

  @override
  String get howManyWords => 'канча сөз';

  @override
  String get begin => 'Баштоо';

  @override
  String get quizByTheme => 'Тема боюнча суроо';

  @override
  String get endQuiz => 'Суроону бүтүрүү';

  @override
  String questionOf(int index, int length) {
    return 'Суроо $index / $length';
  }

  @override
  String get whichDefinitionFits => 'кайсы аныктама туура келет?';

  @override
  String get previous => 'Мурунку';

  @override
  String get next => 'Кийинки';

  @override
  String get seeResults => 'Жыйынтыктарды көрүү';

  @override
  String get themeTitle => 'Тема';

  @override
  String get chooseASubject => 'предмет тандаңыз';

  @override
  String get noThemesYet => 'Азырынча тема жок.';

  @override
  String get notEnoughWordsInTheme => 'Бул темада азырынча жетиштүү сөз жок.';

  @override
  String get results => 'Жыйынтыктар';

  @override
  String get perfectPage => 'кемчиликсиз барак';

  @override
  String get wellMarked => 'кооз белгиленген';

  @override
  String get tryAnotherRound => 'Дагы бир раунд байкап көрүңүз';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score туура аныктама',
      one: '1 туура аныктама',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score туура аныктама, $total ичинен.',
      one: 'Бир туура аныктама, $total ичинен.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Жарык режимге өтүү';

  @override
  String get switchToDarkMode => 'Караңгы режимге өтүү';

  @override
  String get listen => 'Угуу';

  @override
  String get stop => 'Токтотуу';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Тилдер';

  @override
  String get languagesCaption => 'тилдер';

  @override
  String get searchLanguages => 'Өлкө же тил издеңиз…';

  @override
  String get noMatchingLanguages => 'Дал келген өлкө же тил жок.';

  @override
  String get selectedLanguage => 'Окуу тили';

  @override
  String get continentAfrica => 'Африка';

  @override
  String get continentAsia => 'Азия';

  @override
  String get continentEurope => 'Европа';

  @override
  String get continentAmericas => 'Америка';

  @override
  String get continentOceania => 'Океания';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Ошондой эле $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Мисалы: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin тилинен, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, мааниси $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Жөнөкөй сөз менен: $friendly';
  }

  @override
  String get categorySpeech => 'Сүйлөө жана риторика';

  @override
  String get categoryCharacter => 'Мүнөз жана темперамент';

  @override
  String get categoryCriticism => 'Сын жана кордоо';

  @override
  String get categoryVirtue => 'Жакшылык';

  @override
  String get categoryVice => 'Жамандык';

  @override
  String get categoryKnowledge => 'Билим жана ой';

  @override
  String get categoryReligion => 'Дин жана рух';

  @override
  String get categoryBeginnings => 'Башталыштар';

  @override
  String get categoryConflict => 'Чыр жана алдоо';

  @override
  String get categoryAppearance => 'Көрүнүш жана жарык';

  @override
  String get categoryPeople => 'Адамдар жана ролдор';

  @override
  String get categoryObjects => 'Буюмдар жана нерселер';

  @override
  String get categoryEmotion => 'Эмоция';

  @override
  String get categoryArchaic => 'Эски жана архаикалык';

  @override
  String get navStudy => 'Кабинет';

  @override
  String get studyTitle => 'Кабинет';

  @override
  String get studyCaption => 'окуу, үн жана жарык';

  @override
  String get readingSection => 'Окуу';

  @override
  String get readingCaption => 'барак кандай жатат';

  @override
  String get textSize => 'Тексттин өлчөмү';

  @override
  String get textSizeSample => 'Edulcorate — таттуулатуу, жумшартуу.';

  @override
  String get smaller => 'Кичирээк';

  @override
  String get larger => 'Чоңураак';

  @override
  String get autoplayPronunciation => 'Ачылганда сөздү үн чыгарып окуу';

  @override
  String get reduceMotion => 'Кооздукту тынчтандыруу';

  @override
  String get reduceMotionCaption => 'азыраак оюм жана өтмө түс';

  @override
  String get voiceSection => 'Үн';

  @override
  String get voiceCaption => 'Gloss кандай үн чыгарып окуйт';

  @override
  String get chooseVoice => 'Үн';

  @override
  String get voiceDefault => 'Сиз үчүн тандалган';

  @override
  String get noOtherVoices =>
      'Бул түзмөктө башка англис үндөрү орнотулган эмес.';

  @override
  String get speechPace => 'Ыргак';

  @override
  String get slower => 'Жайыраак';

  @override
  String get faster => 'Ыкчамыраак';

  @override
  String get hearIt => 'Угуу';

  @override
  String get lightSection => 'Жарык';

  @override
  String get lightCaption => 'пергамент же шам жарыгы';

  @override
  String get themeSystem => 'Түзмөк боюнча';

  @override
  String get themeLight => 'Пергамент';

  @override
  String get themeDark => 'Шам жарыгы';

  @override
  String get tongueSection => 'Тил';

  @override
  String get aboutSection => 'Колдонмо жөнүндө';

  @override
  String get aboutCaption => 'кантип жасалган';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Ачык булак лицензиялары';

  @override
  String get shareGloss => 'Gloss менен бөлүшүү';

  @override
  String get followTheMaker => 'Авторго жазылыңыз';

  @override
  String couldNotOpenLink(String label) {
    return '$label ачылган жок.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Түшүндүрмөлөрдү $language тилинде окуу';
  }

  @override
  String get readExplanationsCaption => 'Сөздүн өзү дайыма англисче окулат.';

  @override
  String noVoiceInstalled(String language) {
    return 'Бул түзмөктө $language үнү орнотулган эмес.';
  }

  @override
  String get memorySection => 'Эс';

  @override
  String get memoryCaption => 'Gloss эмнени сактайт';

  @override
  String get forgetProgress => 'Прогрессимди унут';

  @override
  String get forgetProgressBody =>
      'Сиз изилдеген сөздөрдүн белгиси алынат. Сакталган сөздөрүңүз калат.';

  @override
  String get clearSavedWords => 'Сакталган сөздөрдү тазалоо';

  @override
  String get clearSavedWordsBody =>
      'Сиз сактаган сөздөр өчүрүлөт. Прогрессиңиз калат.';

  @override
  String get cancel => 'Жокко чыгаруу';

  @override
  String get forget => 'Унутуу';

  @override
  String get clear => 'Тазалоо';

  @override
  String get progressForgotten => 'Прогресс унутулду.';

  @override
  String get savedWordsCleared => 'Сакталган сөздөр тазаланды.';
}
