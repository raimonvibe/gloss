// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'лексікон прыгожай мовы';

  @override
  String get navHome => 'Галоўная';

  @override
  String get navLexicon => 'Лексікон';

  @override
  String get navQuiz => 'Віктарына';

  @override
  String get navSaved => 'Захаванае';

  @override
  String get navLanguages => 'Мовы';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count рэдкіх, багатых слоў з лексікона $lexicon — растлумачаных як сябар, а не як слоўнік.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'даследавана $current з $total слоў';
  }

  @override
  String get exploreLexicon => 'Даследаваць лексікон';

  @override
  String get startQuiz => 'Пачаць віктарыну';

  @override
  String get wordOfTheDay => 'слова дня';

  @override
  String get readFullEntry => 'Чытаць увесь артыкул →';

  @override
  String get lexiconTitle => 'Лексікон';

  @override
  String get lexiconCaption => 'збор';

  @override
  String get savedTitle => 'Захаваныя словы';

  @override
  String get savedCaption => 'блізка да сэрца';

  @override
  String get searchHint => 'Шукай слова або апішы яго сэнс…';

  @override
  String get clearSearch => 'Ачысціць пошук';

  @override
  String get filterAll => 'Усе';

  @override
  String get noMatches =>
      'Пакуль няма супадзенняў — паспрабуй іншае слова ці пачуццё.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n супадзенняў',
      one: '1 супадзенне',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'тут нічога няма';

  @override
  String get emptyLexicon => 'У гэтым кутку лексікона нічога няма.';

  @override
  String get emptySaved =>
      'Пакуль няма захаваных слоў. Націсні сэрца на любым артыкуле.';

  @override
  String get tapToReadMore => 'Націсні, каб чытаць далей';

  @override
  String get saveWord => 'Захаваць слова';

  @override
  String get removeFromFavorites => 'Прыбраць з улюбёных';

  @override
  String get inPlainWords => 'простымі словамі';

  @override
  String get theDefinition => 'азначэнне';

  @override
  String get inASentence => 'у сказе';

  @override
  String get exampleGlossLabel => 'іншымі словамі';

  @override
  String get save => 'Захаваць';

  @override
  String get saved => 'Захавана';

  @override
  String get copy => 'Капіяваць';

  @override
  String get copiedToClipboard => 'Скапіявана ў буфер';

  @override
  String get roots => 'карані';

  @override
  String get quizTitle => 'Маленькая віктарына';

  @override
  String get quizCaption => 'спазнай карані, потым абяры сэнс';

  @override
  String get quizIntro =>
      'Кожнае пытанне паказвае слова і яго этымалогію. Абяры азначэнне, што пасуе — чатыры варыянты, адзін праўдзівы.';

  @override
  String get howManyWords => 'колькі слоў';

  @override
  String get begin => 'Пачаць';

  @override
  String get quizByTheme => 'Віктарына па тэме';

  @override
  String get endQuiz => 'Скончыць віктарыну';

  @override
  String questionOf(int index, int length) {
    return 'Пытанне $index з $length';
  }

  @override
  String get whichDefinitionFits => 'якое азначэнне пасуе?';

  @override
  String get previous => 'Папярэдняе';

  @override
  String get next => 'Наступнае';

  @override
  String get seeResults => 'Глядзець вынікі';

  @override
  String get themeTitle => 'Тэма';

  @override
  String get chooseASubject => 'абяры прадмет';

  @override
  String get noThemesYet => 'Пакуль няма тэм.';

  @override
  String get notEnoughWordsInTheme => 'У гэтай тэме пакуль замала слоў.';

  @override
  String get results => 'Вынікі';

  @override
  String get perfectPage => 'бездакорная старонка';

  @override
  String get wellMarked => 'добра адзначана';

  @override
  String get tryAnotherRound => 'Паспрабуй яшчэ раўнд';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score правільных азначэнняў',
      one: '1 правільнае азначэнне',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score правільных азначэнняў з $total.',
      one: 'Адно правільнае азначэнне з $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Пераключыцца на светлы рэжым';

  @override
  String get switchToDarkMode => 'Пераключыцца на цёмны рэжым';

  @override
  String get listen => 'Слухаць';

  @override
  String get stop => 'Спыніць';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Мовы';

  @override
  String get languagesCaption => 'мовы';

  @override
  String get searchLanguages => 'Шукай краіну або мову…';

  @override
  String get noMatchingLanguages => 'Няма адпаведных краін ці моў.';

  @override
  String get selectedLanguage => 'Чытанне мовай';

  @override
  String get continentAfrica => 'Афрыка';

  @override
  String get continentAsia => 'Азія';

  @override
  String get continentEurope => 'Еўропа';

  @override
  String get continentAmericas => 'Амерыка';

  @override
  String get continentOceania => 'Акеанія';

  @override
  String currentOfTotal(int current, int total) {
    return '$current з $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Таксама $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Як у: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'З $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, значэнне $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Простымі словамі: $friendly';
  }

  @override
  String get categorySpeech => 'Маўленне і рыторыка';

  @override
  String get categoryCharacter => 'Характар і тэмперамент';

  @override
  String get categoryCriticism => 'Крытыка і абраза';

  @override
  String get categoryVirtue => 'Дабрачыннасць';

  @override
  String get categoryVice => 'Парок';

  @override
  String get categoryKnowledge => 'Веды і думка';

  @override
  String get categoryReligion => 'Рэлігія і дух';

  @override
  String get categoryBeginnings => 'Пачаткі';

  @override
  String get categoryConflict => 'Канфлікт і падман';

  @override
  String get categoryAppearance => 'Выгляд і святло';

  @override
  String get categoryPeople => 'Людзі і ролі';

  @override
  String get categoryObjects => 'Рэчы і прадметы';

  @override
  String get categoryEmotion => 'Эмоцыя';

  @override
  String get categoryArchaic => 'Старое і архаічнае';

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
