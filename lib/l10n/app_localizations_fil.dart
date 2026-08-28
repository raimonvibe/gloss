// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'isang leksikon ng marikit na wika';

  @override
  String get navHome => 'Tahanan';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Pagsusulit';

  @override
  String get navSaved => 'Naka-save';

  @override
  String get navLanguages => 'Mga wika';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count bihira at mayamang salita mula sa leksikon ng $lexicon — ipinaliwanag gaya ng kaibigan, hindi ng diksiyonaryo.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current sa $total salitang nalibot';
  }

  @override
  String get exploreLexicon => 'Tuklasin ang leksikon';

  @override
  String get startQuiz => 'Magsimula ng pagsusulit';

  @override
  String get wordOfTheDay => 'salita ng araw';

  @override
  String get readFullEntry => 'Basahin ang buong talâ →';

  @override
  String get lexiconTitle => 'Ang leksikon';

  @override
  String get lexiconCaption => 'ang tipon';

  @override
  String get savedTitle => 'Mga naka-save na salita';

  @override
  String get savedCaption => 'itinago sa malapit';

  @override
  String get searchHint => 'Maghanap ng salita, o ilarawan ang kahulugan…';

  @override
  String get clearSearch => 'Burahin ang paghahanap';

  @override
  String get filterAll => 'Lahat';

  @override
  String get noMatches =>
      'Wala pang tugma — subukan ang ibang salita o damdamin.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n na tugma',
      one: '1 tugma',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'walang narito';

  @override
  String get emptyLexicon => 'Walang laman sa sulok na ito ng leksikon.';

  @override
  String get emptySaved =>
      'Wala pang naka-save. I-tap ang puso sa anumang talâ.';

  @override
  String get tapToReadMore => 'I-tap para magbasa pa';

  @override
  String get saveWord => 'I-save ang salita';

  @override
  String get removeFromFavorites => 'Alisin sa paborito';

  @override
  String get inPlainWords => 'sa payak na salita';

  @override
  String get theDefinition => 'ang kahulugan';

  @override
  String get inASentence => 'sa isang pangungusap';

  @override
  String get exampleGlossLabel => 'sa ibang salita';

  @override
  String get save => 'I-save';

  @override
  String get saved => 'Naka-save';

  @override
  String get copy => 'Kopyahin';

  @override
  String get copiedToClipboard => 'Nakopya sa clipboard';

  @override
  String get roots => 'mga ugat';

  @override
  String get quizTitle => 'Isang maliit na pagsusulit';

  @override
  String get quizCaption => 'kilalanin ang ugat, saka piliin ang kahulugan';

  @override
  String get quizIntro =>
      'Bawat tanong ay nagpapakita ng salita at ang etimolohiya nito. Piliin ang kahulugang bagay — apat na pagpipilian, isa ang totoo.';

  @override
  String get howManyWords => 'ilang salita';

  @override
  String get begin => 'Magsimula';

  @override
  String get quizByTheme => 'Pagsusulit ayon sa tema';

  @override
  String get endQuiz => 'Tapusin ang pagsusulit';

  @override
  String questionOf(int index, int length) {
    return 'Tanong $index sa $length';
  }

  @override
  String get whichDefinitionFits => 'alin ang bagay na kahulugan?';

  @override
  String get previous => 'Nakaraan';

  @override
  String get next => 'Susunod';

  @override
  String get seeResults => 'Tingnan ang resulta';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'pumili ng paksa';

  @override
  String get noThemesYet => 'Wala pang tema.';

  @override
  String get notEnoughWordsInTheme =>
      'Hindi pa sapat ang mga salita sa temang ito.';

  @override
  String get results => 'Mga resulta';

  @override
  String get perfectPage => 'isang perpektong pahina';

  @override
  String get wellMarked => 'mahusay na minarkahan';

  @override
  String get tryAnotherRound => 'Subukan ang isa pang round';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score na tamang kahulugan',
      one: '1 tamang kahulugan',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score na tamang kahulugan, sa $total.',
      one: 'Isang tamang kahulugan, sa $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Lumipat sa maliwanag na mode';

  @override
  String get switchToDarkMode => 'Lumipat sa madilim na mode';

  @override
  String get listen => 'Makinig';

  @override
  String get stop => 'Itigil';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Mga wika';

  @override
  String get languagesCaption => 'ang mga dila';

  @override
  String get searchLanguages => 'Maghanap ng bansa o wika…';

  @override
  String get noMatchingLanguages => 'Walang tumutugmang bansa o wika.';

  @override
  String get selectedLanguage => 'Binabasa sa';

  @override
  String get continentAfrica => 'Aprika';

  @override
  String get continentAsia => 'Asya';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oseanya';

  @override
  String currentOfTotal(int current, int total) {
    return '$current sa $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Pati $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Tulad ng: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Mula sa $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, ibig sabihin $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Sa payak na salita: $friendly';
  }

  @override
  String get categorySpeech => 'Pagsasalita at retorika';

  @override
  String get categoryCharacter => 'Pagkatao at ugali';

  @override
  String get categoryCriticism => 'Puna at insulto';

  @override
  String get categoryVirtue => 'Birtud';

  @override
  String get categoryVice => 'Bisyo';

  @override
  String get categoryKnowledge => 'Kaalaman at isip';

  @override
  String get categoryReligion => 'Relihiyon at diwa';

  @override
  String get categoryBeginnings => 'Mga simula';

  @override
  String get categoryConflict => 'Alitan at daya';

  @override
  String get categoryAppearance => 'Anyo at liwanag';

  @override
  String get categoryPeople => 'Tao at gampanin';

  @override
  String get categoryObjects => 'Bagay at kagamitan';

  @override
  String get categoryEmotion => 'Damdamin';

  @override
  String get categoryArchaic => 'Luma at arkaiko';

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
