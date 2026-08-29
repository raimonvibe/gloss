// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'գեղեցիկ լեզվի բառարան';

  @override
  String get navHome => 'Գլխավոր';

  @override
  String get navLexicon => 'Բառարան';

  @override
  String get navQuiz => 'Հարցաշար';

  @override
  String get navSaved => 'Պահված';

  @override
  String get navLanguages => 'Լեզուներ';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon բառարանի $count հազվագյուտ, հարուստ բառ — բացատրված ինչպես ընկերը կբացատրեր, ոչ բառարանը։';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'ուսումնասիրվել է $current բառ $total-ից';
  }

  @override
  String get exploreLexicon => 'Ուսումնասիրել բառարանը';

  @override
  String get startQuiz => 'Սկսել հարցաշար';

  @override
  String get wordOfTheDay => 'օրվա բառը';

  @override
  String get readFullEntry => 'Կարդալ ամբողջ հոդվածը →';

  @override
  String get lexiconTitle => 'Բառարանը';

  @override
  String get lexiconCaption => 'հավաքածուն';

  @override
  String get savedTitle => 'Պահված բառեր';

  @override
  String get savedCaption => 'սրտին մոտ';

  @override
  String get searchHint => 'Որոնիր բառ, կամ նկարագրիր նշանակությունը…';

  @override
  String get clearSearch => 'Մաքրել որոնումը';

  @override
  String get filterAll => 'Բոլորը';

  @override
  String get noMatches => 'Դեռ համընկնում չկա — փորձիր այլ բառ կամ զգացում։';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n համընկնում',
      one: '1 համընկնում',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'այստեղ ոչինչ չկա';

  @override
  String get emptyLexicon => 'Բառարանի այս անկյունում ոչինչ չկա։';

  @override
  String get emptySaved => 'Դեռ պահված բառ չկա։ Հպիր սրտին ցանկացած հոդվածում։';

  @override
  String get tapToReadMore => 'Հպիր՝ ավելին կարդալու համար';

  @override
  String get saveWord => 'Պահել բառը';

  @override
  String get removeFromFavorites => 'Հեռացնել նախընտրելիներից';

  @override
  String get inPlainWords => 'պարզ խոսքով';

  @override
  String get theDefinition => 'սահմանումը';

  @override
  String get inASentence => 'նախադասության մեջ';

  @override
  String get exampleGlossLabel => 'այլ կերպ ասած';

  @override
  String get save => 'Պահել';

  @override
  String get saved => 'Պահված';

  @override
  String get copy => 'Պատճենել';

  @override
  String get copiedToClipboard => 'Պատճենվեց սեղմատախտակ';

  @override
  String get roots => 'արմատներ';

  @override
  String get quizTitle => 'Փոքր հարցաշար';

  @override
  String get quizCaption => 'ճանաչիր արմատները, ապա ընտրիր իմաստը';

  @override
  String get quizIntro =>
      'Յուրաքանչյուր հարց ցույց է տալիս բառ և նրա ստուգաբանությունը։ Ընտրիր համապատասխան սահմանումը — չորս տարբերակ, մեկ ճշմարիտ։';

  @override
  String get howManyWords => 'քանի բառ';

  @override
  String get begin => 'Սկսել';

  @override
  String get quizByTheme => 'Հարցաշար ըստ թեմայի';

  @override
  String get endQuiz => 'Ավարտել հարցաշարը';

  @override
  String questionOf(int index, int length) {
    return 'Հարց $index / $length';
  }

  @override
  String get whichDefinitionFits => 'որ սահմանումն է համապատասխանում։';

  @override
  String get previous => 'Նախորդ';

  @override
  String get next => 'Հաջորդ';

  @override
  String get seeResults => 'Տեսնել արդյունքները';

  @override
  String get themeTitle => 'Թեմա';

  @override
  String get chooseASubject => 'ընտրիր առարկա';

  @override
  String get noThemesYet => 'Դեռ թեմա չկա։';

  @override
  String get notEnoughWordsInTheme => 'Այս թեմայում դեռ բավարար բառ չկա։';

  @override
  String get results => 'Արդյունքներ';

  @override
  String get perfectPage => 'կատարյալ էջ';

  @override
  String get wellMarked => 'գեղեցիկ նշված';

  @override
  String get tryAnotherRound => 'Փորձիր ևս մեկ փուլ';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score ճիշտ սահմանում',
      one: '1 ճիշտ սահմանում',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score ճիշտ սահմանում, $total-ից։',
      one: 'Մեկ ճիշտ սահմանում, $total-ից։',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Անցնել լուսավոր ռեժիմ';

  @override
  String get switchToDarkMode => 'Անցնել մութ ռեժիմ';

  @override
  String get listen => 'Լսել';

  @override
  String get stop => 'Կանգնեցնել';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Լեզուներ';

  @override
  String get languagesCaption => 'լեզուները';

  @override
  String get searchLanguages => 'Որոնիր երկիր կամ լեզու…';

  @override
  String get noMatchingLanguages => 'Համապատասխան երկիր կամ լեզու չկա։';

  @override
  String get selectedLanguage => 'Կարդում եք';

  @override
  String get continentAfrica => 'Աֆրիկա';

  @override
  String get continentAsia => 'Ասիա';

  @override
  String get continentEurope => 'Եվրոպա';

  @override
  String get continentAmericas => 'Ամերիկա';

  @override
  String get continentOceania => 'Օվկիանիա';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Նաև $variants։';
  }

  @override
  String speechAsIn(String example) {
    return 'Ինչպես՝ $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin-ից, $originWord։';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, նշանակում է $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Պարզ խոսքով՝ $friendly';
  }

  @override
  String get categorySpeech => 'Խոսք և հռետորություն';

  @override
  String get categoryCharacter => 'Բնավորություն և խառնվածք';

  @override
  String get categoryCriticism => 'Քննադատություն և վիրավորանք';

  @override
  String get categoryVirtue => 'Առաքինություն';

  @override
  String get categoryVice => 'Արատ';

  @override
  String get categoryKnowledge => 'Գիտելիք և միտք';

  @override
  String get categoryReligion => 'Կրոն և հոգի';

  @override
  String get categoryBeginnings => 'Սկիզբներ';

  @override
  String get categoryConflict => 'Հակամարտություն և խաբեություն';

  @override
  String get categoryAppearance => 'Տեսք և լույս';

  @override
  String get categoryPeople => 'Մարդիկ և դերեր';

  @override
  String get categoryObjects => 'Առարկաներ և իրեր';

  @override
  String get categoryEmotion => 'Զգացմունք';

  @override
  String get categoryArchaic => 'Հին և հնացած';

  @override
  String get navStudy => 'Առանձնասենյակ';

  @override
  String get studyTitle => 'Առանձնասենյակը';

  @override
  String get studyCaption => 'ընթերցանություն, ձայն և լույս';

  @override
  String get readingSection => 'Ընթերցանություն';

  @override
  String get readingCaption => 'ինչպես է նստում էջը';

  @override
  String get textSize => 'Տառաչափ';

  @override
  String get textSizeSample => 'Edulcorate — քաղցրացնել, մեղմել։';

  @override
  String get smaller => 'Ավելի փոքր';

  @override
  String get larger => 'Ավելի մեծ';

  @override
  String get autoplayPronunciation => 'Բացվելիս բարձրաձայն կարդալ բառը';

  @override
  String get reduceMotion => 'Հանդարտեցնել զարդերը';

  @override
  String get reduceMotionCaption => 'ավելի քիչ ոլորաններ և անցումներ';

  @override
  String get voiceSection => 'Ձայն';

  @override
  String get voiceCaption => 'ինչպես է Gloss-ը բարձրաձայն կարդում';

  @override
  String get chooseVoice => 'Ձայն';

  @override
  String get voiceDefault => 'Ընտրված է ձեզ համար';

  @override
  String get noOtherVoices => 'Այս սարքում այլ անգլերեն ձայներ տեղադրված չեն։';

  @override
  String get speechPace => 'Տեմպ';

  @override
  String get slower => 'Ավելի դանդաղ';

  @override
  String get faster => 'Ավելի արագ';

  @override
  String get hearIt => 'Լսել';

  @override
  String get lightSection => 'Լույս';

  @override
  String get lightCaption => 'մագաղաթ կամ մոմի լույս';

  @override
  String get themeSystem => 'Ըստ սարքի';

  @override
  String get themeLight => 'Մագաղաթ';

  @override
  String get themeDark => 'Մոմի լույս';

  @override
  String get tongueSection => 'Լեզու';

  @override
  String get aboutSection => 'Ծրագրի մասին';

  @override
  String get aboutCaption => 'ինչպես է ստեղծվել';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Բաց կոդի արտոնագրեր';

  @override
  String get shareGloss => 'Կիսվել Gloss-ով';

  @override
  String get followTheMaker => 'Հետևեք հեղինակին';

  @override
  String couldNotOpenLink(String label) {
    return 'Չհաջողվեց բացել $label։';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Կարդալ բացատրությունները $language լեզվով';
  }

  @override
  String get readExplanationsCaption => 'Բառն ինքը միշտ կարդացվում է անգլերեն։';

  @override
  String noVoiceInstalled(String language) {
    return 'Այս սարքում $language ձայն տեղադրված չէ։';
  }
}
