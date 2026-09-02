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
  String get navStudy => 'Aralan';

  @override
  String get studyTitle => 'Ang aralan';

  @override
  String get studyCaption => 'pagbasa, boses, at liwanag';

  @override
  String get readingSection => 'Pagbasa';

  @override
  String get readingCaption => 'kung paano umupo ang pahina';

  @override
  String get textSize => 'Laki ng teksto';

  @override
  String get textSizeSample => 'Edulcorate — pagtamisin, palambutin.';

  @override
  String get smaller => 'Mas maliit';

  @override
  String get larger => 'Mas malaki';

  @override
  String get autoplayPronunciation =>
      'Basahin nang malakas ang salita kapag binuksan';

  @override
  String get reduceMotion => 'Pakalmahin ang mga palamuti';

  @override
  String get reduceMotionCaption => 'mas kaunting kulot at gradasyon';

  @override
  String get voiceSection => 'Boses';

  @override
  String get voiceCaption => 'kung paano bumabasa nang malakas ang Gloss';

  @override
  String get chooseVoice => 'Boses';

  @override
  String get voiceDefault => 'Pinili para sa iyo';

  @override
  String get noOtherVoices =>
      'Walang ibang boseng Ingles na naka-install sa device na ito.';

  @override
  String get speechPace => 'Bilis';

  @override
  String get slower => 'Mas mabagal';

  @override
  String get faster => 'Mas mabilis';

  @override
  String get hearIt => 'Pakinggan';

  @override
  String get lightSection => 'Liwanag';

  @override
  String get lightCaption => 'pergamino o liwanag ng kandila';

  @override
  String get themeSystem => 'Sundan ang device';

  @override
  String get themeLight => 'Pergamino';

  @override
  String get themeDark => 'Liwanag ng kandila';

  @override
  String get tongueSection => 'Wika';

  @override
  String get aboutSection => 'Tungkol';

  @override
  String get aboutCaption => 'kung paano ito ginawa';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Mga lisensyang open source';

  @override
  String get shareGloss => 'Ibahagi ang Gloss';

  @override
  String get followTheMaker => 'Sundan ang lumikha';

  @override
  String couldNotOpenLink(String label) {
    return 'Hindi mabuksan ang $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Basahin ang mga paliwanag sa $language';
  }

  @override
  String get readExplanationsCaption =>
      'Ang salita mismo ay laging binabasa sa Ingles.';

  @override
  String noVoiceInstalled(String language) {
    return 'Walang naka-install na boseng $language sa device na ito.';
  }

  @override
  String get memorySection => 'Alaala';

  @override
  String get memoryCaption => 'kung ano ang iniingatan ng Gloss';

  @override
  String get forgetProgress => 'Kalimutan ang aking progreso';

  @override
  String get forgetProgressBody =>
      'Maaalis ang marka ng mga salitang natuklasan mo. Mananatili ang mga naka-save mong salita.';

  @override
  String get clearSavedWords => 'Burahin ang mga naka-save na salita';

  @override
  String get clearSavedWordsBody =>
      'Aalisin ang mga salitang iningatan mo. Mananatili ang progreso mo.';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get forget => 'Kalimutan';

  @override
  String get clear => 'Burahin';

  @override
  String get progressForgotten => 'Nakalimutan ang progreso.';

  @override
  String get savedWordsCleared => 'Nabura ang mga naka-save na salita.';

  @override
  String get contactTitle => 'Sumulat sa may-akda';

  @override
  String get contactCaption => 'isang liham, kung nais mo';

  @override
  String get contactBlurb =>
      'Isang tao lamang ang gumagawa ng Gloss. Isang salitang hinahanap mo, isang maling nakita mo, isang linyang nagustuhan mo — lahat ay dumarating sa iisang mesa.';

  @override
  String get contactLetterSection => 'Ang liham';

  @override
  String get contactName => 'Ang pangalan mo';

  @override
  String get contactNameHint => 'Ang pangalang ipambabati sa iyo';

  @override
  String get contactEmail => 'Ang email mo';

  @override
  String get contactEmailHint => 'Kung saan ka maaabot ng sagot';

  @override
  String contactEmailTypo(String domain) {
    return '$domain ba ang ibig mong sabihin?';
  }

  @override
  String get contactReason => 'Dahilan ng pagsulat';

  @override
  String get reasonWord => 'Isang salitang idaragdag';

  @override
  String get reasonProblem => 'May mali';

  @override
  String get reasonQuestion => 'Isang tanong';

  @override
  String get reasonPraise => 'Puna';

  @override
  String get reasonOther => 'Iba pang bagay';

  @override
  String get contactPriority => 'Gaano kadalian';

  @override
  String get priorityLow => 'Mababa';

  @override
  String get priorityNormal => 'Karaniwan';

  @override
  String get priorityHigh => 'Mataas';

  @override
  String get contactMessage => 'Ang mensahe mo';

  @override
  String get contactMessageHint =>
      'Sumulat nang mahaba o maikli, ikaw ang bahala…';

  @override
  String get contactHumanCheck => 'Isang salita bago magpadala';

  @override
  String contactHumanQuestion(String word) {
    return 'Aling kahulugan ang nauukol sa $word?';
  }

  @override
  String get contactHumanRetry => 'Hindi iyon. Narito ang ibang salita.';

  @override
  String get contactDetails => 'Isama ang datos ng app';

  @override
  String get contactDetailsCaption =>
      'Bersyon, wika, liwanag at laki ng teksto, upang mas mabilis matagpuan ang mali.';

  @override
  String get contactSend => 'Ipadala ang liham';

  @override
  String get contactCopyLetter => 'Kopyahin ang liham';

  @override
  String get contactDraftRestored => 'May liham dito na hindi naipadala.';

  @override
  String get contactNoMailApp =>
      'Walang app ng email ang tumugon, kaya nasa clipboard ang liham.';

  @override
  String get contactNeedName =>
      'Isang pangalan, upang malaman ng sagot kung sino ang babatiin.';

  @override
  String get contactNeedEmail => 'Isang tirahan na maaabot ng sagot.';

  @override
  String get contactNeedMessage => 'Kahit isa o dalawang linya.';

  @override
  String get contactSent => 'Papunta na ang liham mo. Salamat.';

  @override
  String get contactSendFailed =>
      'Hindi naipadala ang liham ngayon. Nasa clipboard ito at nananatili rito.';

  @override
  String get contactSendByMail => 'Gumamit na lang ng app ng email';
}
