// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'सुन्दर भाषाको कोश';

  @override
  String get navHome => 'गृह';

  @override
  String get navLexicon => 'कोश';

  @override
  String get navQuiz => 'प्रश्नोत्तरी';

  @override
  String get navSaved => 'सुरक्षित';

  @override
  String get navLanguages => 'भाषाहरू';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon कोशबाट $count दुर्लभ, समृद्ध शब्द — शब्दकोशजस्तो होइन, साथीले जस्तो व्याख्या गरिएका।';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total मध्ये $current शब्द हेरिए';
  }

  @override
  String get exploreLexicon => 'कोश हेर्नुहोस्';

  @override
  String get startQuiz => 'प्रश्नोत्तरी सुरु गर्नुहोस्';

  @override
  String get wordOfTheDay => 'आजको शब्द';

  @override
  String get readFullEntry => 'पूरा प्रविष्टि पढ्नुहोस् →';

  @override
  String get lexiconTitle => 'कोश';

  @override
  String get lexiconCaption => 'सङ्ग्रह';

  @override
  String get savedTitle => 'सुरक्षित शब्दहरू';

  @override
  String get savedCaption => 'नजिक राखिएका';

  @override
  String get searchHint => 'शब्द खोज्नुहोस्, वा अर्थ वर्णन गर्नुहोस्…';

  @override
  String get clearSearch => 'खोज मेट्नुहोस्';

  @override
  String get filterAll => 'सबै';

  @override
  String get noMatches =>
      'अहिलेसम्म मिलान छैन — अर्को शब्द वा भाव प्रयास गर्नुहोस्।';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n मिलान',
      one: '१ मिलान',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'यहाँ केही छैन';

  @override
  String get emptyLexicon => 'कोशको यो कुनामा केही छैन।';

  @override
  String get emptySaved =>
      'अहिलेसम्म सुरक्षित शब्द छैन। कुनै पनि प्रविष्टिमा हृदय छुनुहोस्।';

  @override
  String get tapToReadMore => 'थप पढ्न छुनुहोस्';

  @override
  String get saveWord => 'शब्द सुरक्षित गर्नुहोस्';

  @override
  String get removeFromFavorites => 'मनपर्नेबाट हटाउनुहोस्';

  @override
  String get inPlainWords => 'सरल शब्दमा';

  @override
  String get theDefinition => 'परिभाषा';

  @override
  String get inASentence => 'वाक्यमा';

  @override
  String get exampleGlossLabel => 'अर्को शब्दमा';

  @override
  String get save => 'सुरक्षित गर्नुहोस्';

  @override
  String get saved => 'सुरक्षित';

  @override
  String get copy => 'प्रतिलिपि';

  @override
  String get copiedToClipboard => 'क्लिपबोर्डमा प्रतिलिपि भयो';

  @override
  String get roots => 'मूल';

  @override
  String get quizTitle => 'सानो प्रश्नोत्तरी';

  @override
  String get quizCaption => 'मूल जान्नुहोस्, अनि अर्थ छान्नुहोस्';

  @override
  String get quizIntro =>
      'प्रत्येक प्रश्नले शब्द र यसको व्युत्पत्ति देखाउँछ। मिल्ने परिभाषा छान्नुहोस् — चार विकल्प, एक सत्य।';

  @override
  String get howManyWords => 'कति शब्द';

  @override
  String get begin => 'सुरु गर्नुहोस्';

  @override
  String get quizByTheme => 'विषयअनुसार प्रश्नोत्तरी';

  @override
  String get endQuiz => 'प्रश्नोत्तरी अन्त्य गर्नुहोस्';

  @override
  String questionOf(int index, int length) {
    return 'प्रश्न $index / $length';
  }

  @override
  String get whichDefinitionFits => 'कुन परिभाषा मिल्छ?';

  @override
  String get previous => 'अघिल्लो';

  @override
  String get next => 'अर्को';

  @override
  String get seeResults => 'नतिजा हेर्नुहोस्';

  @override
  String get themeTitle => 'विषय';

  @override
  String get chooseASubject => 'विषय छान्नुहोस्';

  @override
  String get noThemesYet => 'अहिलेसम्म विषय छैन।';

  @override
  String get notEnoughWordsInTheme => 'यो विषयमा अहिले पर्याप्त शब्द छैनन्।';

  @override
  String get results => 'नतिजा';

  @override
  String get perfectPage => 'एउटा निर्दोष पृष्ठ';

  @override
  String get wellMarked => 'राम्रोसँग चिन्हित';

  @override
  String get tryAnotherRound => 'अर्को राउन्ड प्रयास गर्नुहोस्';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score परिभाषा सही',
      one: '१ परिभाषा सही',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score परिभाषा सही, $total मध्ये।',
      one: 'एउटा परिभाषा सही, $total मध्ये।',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'उज्यालो मोडमा जानुहोस्';

  @override
  String get switchToDarkMode => 'अँध्यारो मोडमा जानुहोस्';

  @override
  String get listen => 'सुन्नुहोस्';

  @override
  String get stop => 'रोक्नुहोस्';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'भाषाहरू';

  @override
  String get languagesCaption => 'जिब्राहरू';

  @override
  String get searchLanguages => 'देश वा भाषा खोज्नुहोस्…';

  @override
  String get noMatchingLanguages => 'मिल्ने देश वा भाषा छैन।';

  @override
  String get selectedLanguage => 'पढ्दै';

  @override
  String get continentAfrica => 'अफ्रिका';

  @override
  String get continentAsia => 'एसिया';

  @override
  String get continentEurope => 'युरोप';

  @override
  String get continentAmericas => 'अमेरिका';

  @override
  String get continentOceania => 'ओसिनिया';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'साथै $variants।';
  }

  @override
  String speechAsIn(String example) {
    return 'जस्तै: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin बाट, $originWord।';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, अर्थ $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'सरल शब्दमा: $friendly';
  }

  @override
  String get categorySpeech => 'वाणी र अलङ्कार';

  @override
  String get categoryCharacter => 'स्वभाव र प्रकृति';

  @override
  String get categoryCriticism => 'आलोचना र अपमान';

  @override
  String get categoryVirtue => 'सद्गुण';

  @override
  String get categoryVice => 'अवगुण';

  @override
  String get categoryKnowledge => 'ज्ञान र विचार';

  @override
  String get categoryReligion => 'धर्म र आत्मा';

  @override
  String get categoryBeginnings => 'आरम्भ';

  @override
  String get categoryConflict => 'द्वन्द्व र छल';

  @override
  String get categoryAppearance => 'रूप र प्रकाश';

  @override
  String get categoryPeople => 'मानिस र भूमिका';

  @override
  String get categoryObjects => 'वस्तु र चीजहरू';

  @override
  String get categoryEmotion => 'भावना';

  @override
  String get categoryArchaic => 'पुरानो र प्राचीन';

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
