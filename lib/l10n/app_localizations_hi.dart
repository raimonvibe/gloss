// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'सुंदर भाषा का कोश';

  @override
  String get navHome => 'घर';

  @override
  String get navLexicon => 'कोश';

  @override
  String get navQuiz => 'प्रश्नोत्तरी';

  @override
  String get navSaved => 'सहेजे';

  @override
  String get navLanguages => 'भाषाएँ';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$lexicon कोश से $count दुर्लभ, समृद्ध शब्द — शब्दकोश की तरह नहीं, मित्र की तरह समझाए गए।';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$total में से $current शब्द देखे गए';
  }

  @override
  String get exploreLexicon => 'कोश देखें';

  @override
  String get startQuiz => 'प्रश्नोत्तरी शुरू करें';

  @override
  String get wordOfTheDay => 'आज का शब्द';

  @override
  String get readFullEntry => 'पूरी प्रविष्टि पढ़ें →';

  @override
  String get lexiconTitle => 'कोश';

  @override
  String get lexiconCaption => 'संग्रह';

  @override
  String get savedTitle => 'सहेजे शब्द';

  @override
  String get savedCaption => 'पास रखे';

  @override
  String get searchHint => 'कोई शब्द खोजें, या उसका अर्थ बताएँ…';

  @override
  String get clearSearch => 'खोज साफ़ करें';

  @override
  String get filterAll => 'सभी';

  @override
  String get noMatches => 'अभी कोई मेल नहीं — कोई और शब्द या भाव आज़माएँ।';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n मेल',
      one: '1 मेल',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'यहाँ कुछ नहीं';

  @override
  String get emptyLexicon => 'कोश के इस कोने में कुछ नहीं।';

  @override
  String get emptySaved =>
      'अभी कोई सहेजा शब्द नहीं। किसी भी प्रविष्टि पर हृदय छुएँ।';

  @override
  String get tapToReadMore => 'और पढ़ने के लिए छुएँ';

  @override
  String get saveWord => 'शब्द सहेजें';

  @override
  String get removeFromFavorites => 'पसंदीदा से हटाएँ';

  @override
  String get inPlainWords => 'सादी भाषा में';

  @override
  String get theDefinition => 'परिभाषा';

  @override
  String get inASentence => 'एक वाक्य में';

  @override
  String get exampleGlossLabel => 'दूसरे शब्दों में';

  @override
  String get save => 'सहेजें';

  @override
  String get saved => 'सहेजा गया';

  @override
  String get copy => 'प्रतिलिपि';

  @override
  String get copiedToClipboard => 'क्लिपबोर्ड पर प्रतिलिपि हुई';

  @override
  String get roots => 'मूल';

  @override
  String get quizTitle => 'एक छोटी प्रश्नोत्तरी';

  @override
  String get quizCaption => 'मूल जानें, फिर अर्थ चुनें';

  @override
  String get quizIntro =>
      'हर प्रश्न एक शब्द और उसकी व्युत्पत्ति दिखाता है। जो परिभाषा बैठे उसे चुनें — चार विकल्प, एक सत्य।';

  @override
  String get howManyWords => 'कितने शब्द';

  @override
  String get begin => 'शुरू करें';

  @override
  String get quizByTheme => 'विषय अनुसार प्रश्नोत्तरी';

  @override
  String get endQuiz => 'प्रश्नोत्तरी समाप्त करें';

  @override
  String questionOf(int index, int length) {
    return 'प्रश्न $index / $length';
  }

  @override
  String get whichDefinitionFits => 'कौन-सी परिभाषा बैठती है?';

  @override
  String get previous => 'पिछला';

  @override
  String get next => 'अगला';

  @override
  String get seeResults => 'परिणाम देखें';

  @override
  String get themeTitle => 'विषय';

  @override
  String get chooseASubject => 'एक विषय चुनें';

  @override
  String get noThemesYet => 'अभी कोई विषय नहीं।';

  @override
  String get notEnoughWordsInTheme => 'इस विषय में अभी पर्याप्त शब्द नहीं।';

  @override
  String get results => 'परिणाम';

  @override
  String get perfectPage => 'एक निर्दोष पृष्ठ';

  @override
  String get wellMarked => 'सुंदर चिह्नित';

  @override
  String get tryAnotherRound => 'एक और दौर आज़माएँ';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score परिभाषाएँ सही',
      one: '1 परिभाषा सही',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score परिभाषाएँ सही, $total में से।',
      one: 'एक परिभाषा सही, $total में से।',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'हल्के मोड पर जाएँ';

  @override
  String get switchToDarkMode => 'गहरे मोड पर जाएँ';

  @override
  String get listen => 'सुनें';

  @override
  String get stop => 'रोकें';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'भाषाएँ';

  @override
  String get languagesCaption => 'जिह्वाएँ';

  @override
  String get searchLanguages => 'कोई देश या भाषा खोजें…';

  @override
  String get noMatchingLanguages => 'कोई मेल खाता देश या भाषा नहीं।';

  @override
  String get selectedLanguage => 'पढ़ रहे हैं';

  @override
  String get continentAfrica => 'अफ़्रीका';

  @override
  String get continentAsia => 'एशिया';

  @override
  String get continentEurope => 'यूरोप';

  @override
  String get continentAmericas => 'अमेरिका';

  @override
  String get continentOceania => 'ओशिनिया';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'साथ ही $variants।';
  }

  @override
  String speechAsIn(String example) {
    return 'जैसे: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin से, $originWord।';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, अर्थ $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'सादी भाषा में: $friendly';
  }

  @override
  String get categorySpeech => 'वाणी और अलंकार';

  @override
  String get categoryCharacter => 'स्वभाव और प्रकृति';

  @override
  String get categoryCriticism => 'आलोचना और अपमान';

  @override
  String get categoryVirtue => 'सद्गुण';

  @override
  String get categoryVice => 'अवगुण';

  @override
  String get categoryKnowledge => 'ज्ञान और विचार';

  @override
  String get categoryReligion => 'धर्म और आत्मा';

  @override
  String get categoryBeginnings => 'आरंभ';

  @override
  String get categoryConflict => 'संघर्ष और छल';

  @override
  String get categoryAppearance => 'रूप और प्रकाश';

  @override
  String get categoryPeople => 'जन और भूमिकाएँ';

  @override
  String get categoryObjects => 'वस्तुएँ और चीज़ें';

  @override
  String get categoryEmotion => 'भाव';

  @override
  String get categoryArchaic => 'प्राचीन और पुरातन';

  @override
  String get navStudy => 'अध्ययन';

  @override
  String get studyTitle => 'अध्ययन-कक्ष';

  @override
  String get studyCaption => 'पठन, आवाज़ और प्रकाश';

  @override
  String get readingSection => 'पठन';

  @override
  String get readingCaption => 'पृष्ठ कैसे बैठता है';

  @override
  String get textSize => 'पाठ का आकार';

  @override
  String get textSizeSample => 'Edulcorate — मीठा करना, कोमल करना।';

  @override
  String get smaller => 'छोटा';

  @override
  String get larger => 'बड़ा';

  @override
  String get autoplayPronunciation => 'शब्द खुलते ही उसे बोलकर पढ़ें';

  @override
  String get reduceMotion => 'अलंकरण शांत करें';

  @override
  String get reduceMotionCaption => 'कम बेल-बूटे और रंग-ढाल';

  @override
  String get voiceSection => 'आवाज़';

  @override
  String get voiceCaption => 'Gloss कैसे बोलकर पढ़ता है';

  @override
  String get chooseVoice => 'आवाज़';

  @override
  String get voiceDefault => 'आपके लिए चुनी गई';

  @override
  String get noOtherVoices =>
      'इस डिवाइस पर कोई अन्य अंग्रेज़ी आवाज़ स्थापित नहीं है।';

  @override
  String get speechPace => 'गति';

  @override
  String get slower => 'धीमा';

  @override
  String get faster => 'तेज़';

  @override
  String get hearIt => 'सुनें';

  @override
  String get lightSection => 'प्रकाश';

  @override
  String get lightCaption => 'चर्मपत्र या मोमबत्ती की लौ';

  @override
  String get themeSystem => 'डिवाइस के अनुसार';

  @override
  String get themeLight => 'चर्मपत्र';

  @override
  String get themeDark => 'मोमबत्ती की लौ';

  @override
  String get tongueSection => 'भाषा';

  @override
  String get aboutSection => 'परिचय';

  @override
  String get aboutCaption => 'यह कैसे बना';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'मुक्त स्रोत लाइसेंस';

  @override
  String get shareGloss => 'Gloss साझा करें';

  @override
  String get followTheMaker => 'रचयिता को फ़ॉलो करें';

  @override
  String couldNotOpenLink(String label) {
    return '$label नहीं खुल सका।';
  }

  @override
  String readExplanationsIn(String language) {
    return '$language में व्याख्याएँ पढ़ें';
  }

  @override
  String get readExplanationsCaption =>
      'शब्द स्वयं सदा अंग्रेज़ी में ही पढ़ा जाता है।';

  @override
  String noVoiceInstalled(String language) {
    return 'इस डिवाइस पर $language आवाज़ स्थापित नहीं है।';
  }

  @override
  String get memorySection => 'स्मृति';

  @override
  String get memoryCaption => 'Gloss क्या रखता है';

  @override
  String get forgetProgress => 'मेरी प्रगति भूल जाएँ';

  @override
  String get forgetProgressBody =>
      'आपने जो शब्द देखे हैं उनका चिह्न हट जाएगा। आपके सहेजे शब्द बने रहेंगे।';

  @override
  String get clearSavedWords => 'सहेजे शब्द मिटाएँ';

  @override
  String get clearSavedWordsBody =>
      'आपने जो शब्द रखे हैं वे हटा दिए जाएँगे। आपकी प्रगति बनी रहेगी।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get forget => 'भूल जाएँ';

  @override
  String get clear => 'मिटाएँ';

  @override
  String get progressForgotten => 'प्रगति भुला दी गई।';

  @override
  String get savedWordsCleared => 'सहेजे शब्द मिटा दिए गए।';

  @override
  String get contactTitle => 'रचयिता को लिखें';

  @override
  String get contactCaption => 'चाहें तो एक चिट्ठी';

  @override
  String get contactBlurb =>
      'Gloss एक ही व्यक्ति बनाता है। जो शब्द आपको नहीं मिला, जो चूक आपने पकड़ी, जो पंक्ति आपको भाई — सब एक ही मेज़ तक पहुँचता है।';

  @override
  String get contactLetterSection => 'चिट्ठी';

  @override
  String get contactName => 'आपका नाम';

  @override
  String get contactNameHint => 'जिस नाम से आपको पुकारें';

  @override
  String get contactEmail => 'आपका ईमेल';

  @override
  String get contactEmailHint => 'जहाँ उत्तर आप तक पहुँचे';

  @override
  String contactEmailTypo(String domain) {
    return 'क्या आपका मतलब $domain था?';
  }

  @override
  String get contactReason => 'लिखने का कारण';

  @override
  String get reasonWord => 'जोड़ने योग्य एक शब्द';

  @override
  String get reasonProblem => 'कुछ ठीक नहीं है';

  @override
  String get reasonQuestion => 'एक प्रश्न';

  @override
  String get reasonPraise => 'प्रतिक्रिया';

  @override
  String get reasonOther => 'कुछ और';

  @override
  String get contactPriority => 'कितना ज़रूरी';

  @override
  String get priorityLow => 'कम';

  @override
  String get priorityNormal => 'सामान्य';

  @override
  String get priorityHigh => 'अधिक';

  @override
  String get contactMessage => 'आपका संदेश';

  @override
  String get contactMessageHint => 'जितना चाहें उतना लिखें, या थोड़ा ही…';

  @override
  String get contactHumanCheck => 'भेजने से पहले एक शब्द';

  @override
  String contactHumanQuestion(String word) {
    return '$word का अर्थ इनमें से कौन-सा है?';
  }

  @override
  String get contactHumanRetry => 'वह नहीं। यह लीजिए दूसरा शब्द।';

  @override
  String get contactDetails => 'ऐप का विवरण साथ भेजें';

  @override
  String get contactDetailsCaption =>
      'संस्करण, भाषा, रोशनी और अक्षर का आकार, ताकि चूक जल्दी मिले।';

  @override
  String get contactSend => 'चिट्ठी भेजें';

  @override
  String get contactCopyLetter => 'चिट्ठी कॉपी करें';

  @override
  String get contactDraftRestored => 'यहाँ एक बिन भेजी चिट्ठी रखी थी।';

  @override
  String get contactNoMailApp =>
      'किसी मेल ऐप ने उत्तर नहीं दिया, इसलिए चिट्ठी क्लिपबोर्ड में है।';

  @override
  String get contactNeedName =>
      'एक नाम, ताकि उत्तर जान सके किसे संबोधित करना है।';

  @override
  String get contactNeedEmail => 'एक पता जहाँ उत्तर पहुँच सके।';

  @override
  String get contactNeedMessage => 'कम से कम एक-दो पंक्तियाँ।';

  @override
  String get contactSent => 'आपकी चिट्ठी रास्ते में है। धन्यवाद।';

  @override
  String get contactSendFailed =>
      'चिट्ठी अभी भेजी नहीं जा सकी। वह क्लिपबोर्ड में है और यहाँ भी रखी है।';

  @override
  String get contactSendByMail => 'इसके बजाय मेल ऐप इस्तेमाल करें';
}
