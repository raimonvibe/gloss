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
  String get navStudy => 'अध्ययन';

  @override
  String get studyTitle => 'अध्ययन कोठा';

  @override
  String get studyCaption => 'पठन, स्वर र उज्यालो';

  @override
  String get readingSection => 'पठन';

  @override
  String get readingCaption => 'पृष्ठ कसरी बस्छ';

  @override
  String get textSize => 'पाठको आकार';

  @override
  String get textSizeSample => 'Edulcorate — गुलियो बनाउनु, नरम पार्नु।';

  @override
  String get smaller => 'सानो';

  @override
  String get larger => 'ठूलो';

  @override
  String get autoplayPronunciation => 'शब्द खुल्दा ठूलो स्वरमा पढ्नुहोस्';

  @override
  String get reduceMotion => 'सजावट शान्त पार्नुहोस्';

  @override
  String get reduceMotionCaption => 'कम बुट्टा र रङको ढाल';

  @override
  String get voiceSection => 'स्वर';

  @override
  String get voiceCaption => 'Gloss कसरी ठूलो स्वरमा पढ्छ';

  @override
  String get chooseVoice => 'स्वर';

  @override
  String get voiceDefault => 'तपाईंका लागि छानिएको';

  @override
  String get noOtherVoices =>
      'यस यन्त्रमा अन्य अङ्ग्रेजी स्वरहरू स्थापना गरिएका छैनन्।';

  @override
  String get speechPace => 'गति';

  @override
  String get slower => 'बिस्तारै';

  @override
  String get faster => 'छिटो';

  @override
  String get hearIt => 'सुन्नुहोस्';

  @override
  String get lightSection => 'उज्यालो';

  @override
  String get lightCaption => 'चर्मपत्र वा मैनबत्तीको उज्यालो';

  @override
  String get themeSystem => 'यन्त्रअनुसार';

  @override
  String get themeLight => 'चर्मपत्र';

  @override
  String get themeDark => 'मैनबत्तीको उज्यालो';

  @override
  String get tongueSection => 'भाषा';

  @override
  String get aboutSection => 'बारेमा';

  @override
  String get aboutCaption => 'यो कसरी बन्यो';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'खुला स्रोत इजाजतपत्रहरू';

  @override
  String get shareGloss => 'Gloss साझा गर्नुहोस्';

  @override
  String get followTheMaker => 'सिर्जनाकारलाई पछ्याउनुहोस्';

  @override
  String couldNotOpenLink(String label) {
    return '$label खोल्न सकिएन।';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language मा व्याख्या पढ्नुहोस्';
  }

  @override
  String get readExplanationsCaption => 'शब्द आफैँ सधैँ अङ्ग्रेजीमा पढिन्छ।';

  @override
  String noVoiceInstalled(String language) {
    return 'यस यन्त्रमा $language स्वर स्थापना गरिएको छैन।';
  }

  @override
  String get memorySection => 'स्मृति';

  @override
  String get memoryCaption => 'Gloss ले के राख्छ';

  @override
  String get forgetProgress => 'मेरो प्रगति बिर्सनुहोस्';

  @override
  String get forgetProgressBody =>
      'तपाईंले हेर्नुभएका शब्दहरूको चिन्ह हट्नेछ। सुरक्षित शब्दहरू रहनेछन्।';

  @override
  String get clearSavedWords => 'सुरक्षित शब्दहरू खाली गर्नुहोस्';

  @override
  String get clearSavedWordsBody =>
      'तपाईंले राख्नुभएका शब्दहरू हटाइनेछन्। तपाईंको प्रगति रहनेछ।';

  @override
  String get cancel => 'रद्द गर्नुहोस्';

  @override
  String get forget => 'बिर्सनुहोस्';

  @override
  String get clear => 'खाली गर्नुहोस्';

  @override
  String get progressForgotten => 'प्रगति बिर्सियो।';

  @override
  String get savedWordsCleared => 'सुरक्षित शब्दहरू खाली गरियो।';

  @override
  String get contactTitle => 'सिर्जकलाई लेख्नुहोस्';

  @override
  String get contactCaption => 'मन लागे एउटा चिठी';

  @override
  String get contactBlurb =>
      'Gloss एक जनाले बनाउँछन्। तपाईंलाई नपुगेको शब्द, तपाईंले भेट्टाएको गल्ती, तपाईंलाई मन परेको हरफ — सबै एउटै टेबलमा आइपुग्छ।';

  @override
  String get contactLetterSection => 'चिठी';

  @override
  String get contactName => 'तपाईंको नाम';

  @override
  String get contactNameHint => 'तपाईंलाई बोलाउने नाम';

  @override
  String get contactEmail => 'तपाईंको इमेल';

  @override
  String get contactEmailHint => 'जवाफले तपाईंलाई भेट्ने ठाउँ';

  @override
  String contactEmailTypo(String domain) {
    return 'तपाईंले $domain भन्न खोज्नुभएको हो?';
  }

  @override
  String get contactReason => 'लेख्नुको कारण';

  @override
  String get reasonWord => 'थप्न लायक एउटा शब्द';

  @override
  String get reasonProblem => 'केही मिलेको छैन';

  @override
  String get reasonQuestion => 'एउटा प्रश्न';

  @override
  String get reasonPraise => 'प्रतिक्रिया';

  @override
  String get reasonOther => 'अरू केही';

  @override
  String get contactPriority => 'कति हतार';

  @override
  String get priorityLow => 'कम';

  @override
  String get priorityNormal => 'सामान्य';

  @override
  String get priorityHigh => 'धेरै';

  @override
  String get contactMessage => 'तपाईंको सन्देश';

  @override
  String get contactMessageHint => 'जति मन लाग्छ त्यति लेख्नुहोस्…';

  @override
  String get contactHumanCheck => 'पठाउनुअघि एउटा शब्द';

  @override
  String contactHumanQuestion(String word) {
    return '$word को अर्थ कुन हो?';
  }

  @override
  String get contactHumanRetry => 'त्यो होइन। यो लिनुहोस् अर्को शब्द।';

  @override
  String get contactDetails => 'एपको विवरण पनि पठाउनुहोस्';

  @override
  String get contactDetailsCaption =>
      'संस्करण, भाषा, उज्यालो र अक्षरको आकार, गल्ती छिटो भेटियोस् भनेर।';

  @override
  String get contactSend => 'चिठी पठाउनुहोस्';

  @override
  String get contactCopyLetter => 'चिठी प्रतिलिपि गर्नुहोस्';

  @override
  String get contactDraftRestored => 'यहाँ नपठाइएको एउटा चिठी पर्खिरहेको थियो।';

  @override
  String get contactNoMailApp =>
      'कुनै मेल एपले जवाफ दिएन, त्यसैले चिठी क्लिपबोर्डमा छ।';

  @override
  String get contactNeedName =>
      'एउटा नाम, जवाफले कसलाई सम्बोधन गर्ने थाहा पाओस्।';

  @override
  String get contactNeedEmail => 'जवाफ पुग्न सक्ने एउटा ठेगाना।';

  @override
  String get contactNeedMessage => 'कम्तीमा एक-दुई हरफ।';

  @override
  String get contactSent => 'तपाईंको चिठी बाटोमा छ। धन्यवाद।';

  @override
  String get contactSendFailed =>
      'चिठी अहिले पठाउन सकिएन। यो क्लिपबोर्डमा छ र यहीँ पनि राखिएको छ।';

  @override
  String get contactSendByMail => 'बरु मेल एप प्रयोग गर्नुहोस्';
}
