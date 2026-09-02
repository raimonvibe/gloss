// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon lepega jezika';

  @override
  String get navHome => 'Domov';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kvizi';

  @override
  String get navSaved => 'Shranjeno';

  @override
  String get navLanguages => 'Jeziki';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count redkih, bogatih besed iz leksikona $lexicon — razloženih, kakor bi jih razložil prijatelj, ne slovar.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'raziskanih $current od $total besed';
  }

  @override
  String get exploreLexicon => 'Raziskuj leksikon';

  @override
  String get startQuiz => 'Začni kviz';

  @override
  String get wordOfTheDay => 'beseda dneva';

  @override
  String get readFullEntry => 'Preberi celoten vnos →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'zbirka';

  @override
  String get savedTitle => 'Shranjene besede';

  @override
  String get savedCaption => 'blizu srca';

  @override
  String get searchHint => 'Išči besedo ali opiši njen pomen…';

  @override
  String get clearSearch => 'Počisti iskanje';

  @override
  String get filterAll => 'Vse';

  @override
  String get noMatches => 'Še ni zadetkov — poskusi drugo besedo ali občutek.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n zadetkov',
      one: '1 zadetek',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'tu ni ničesar';

  @override
  String get emptyLexicon => 'V tem kotu leksikona ni ničesar.';

  @override
  String get emptySaved =>
      'Še ni shranjenih besed. Tapni srce pri katerem koli vnosu.';

  @override
  String get tapToReadMore => 'Tapni za nadaljnje branje';

  @override
  String get saveWord => 'Shrani besedo';

  @override
  String get removeFromFavorites => 'Odstrani iz priljubljenih';

  @override
  String get inPlainWords => 'preprostimi besedami';

  @override
  String get theDefinition => 'definicija';

  @override
  String get inASentence => 'v stavku';

  @override
  String get exampleGlossLabel => 'z drugimi besedami';

  @override
  String get save => 'Shrani';

  @override
  String get saved => 'Shranjeno';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copiedToClipboard => 'Kopirano na odložišče';

  @override
  String get roots => 'korenine';

  @override
  String get quizTitle => 'Majhen kviz';

  @override
  String get quizCaption => 'spoznaj korenine, nato izberi pomen';

  @override
  String get quizIntro =>
      'Vsako vprašanje pokaže besedo in njeno etimologijo. Izberi definicijo, ki se poda — štiri izbire, ena resnična.';

  @override
  String get howManyWords => 'koliko besed';

  @override
  String get begin => 'Začni';

  @override
  String get quizByTheme => 'Kviz po temi';

  @override
  String get endQuiz => 'Končaj kviz';

  @override
  String questionOf(int index, int length) {
    return 'Vprašanje $index od $length';
  }

  @override
  String get whichDefinitionFits => 'katera definicija se poda?';

  @override
  String get previous => 'Prejšnje';

  @override
  String get next => 'Naslednje';

  @override
  String get seeResults => 'Poglej rezultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'izberi predmet';

  @override
  String get noThemesYet => 'Še ni tem.';

  @override
  String get notEnoughWordsInTheme => 'V tej temi še ni dovolj besed.';

  @override
  String get results => 'Rezultati';

  @override
  String get perfectPage => 'popolna stran';

  @override
  String get wellMarked => 'lepo označeno';

  @override
  String get tryAnotherRound => 'Poskusi še en krog';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pravilnih definicij',
      one: '1 pravilna definicija',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pravilnih definicij od $total.',
      one: 'Ena pravilna definicija od $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Preklopi na svetli način';

  @override
  String get switchToDarkMode => 'Preklopi na temni način';

  @override
  String get listen => 'Poslušaj';

  @override
  String get stop => 'Ustavi';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jeziki';

  @override
  String get languagesCaption => 'jeziki';

  @override
  String get searchLanguages => 'Išči državo ali jezik…';

  @override
  String get noMatchingLanguages => 'Ni ujemajočih se držav ali jezikov.';

  @override
  String get selectedLanguage => 'Branje v';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azija';

  @override
  String get continentEurope => 'Evropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanija';

  @override
  String currentOfTotal(int current, int total) {
    return '$current od $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Tudi $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kot v: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Iz $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, pomen $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Preprostimi besedami: $friendly';
  }

  @override
  String get categorySpeech => 'Govor in retorika';

  @override
  String get categoryCharacter => 'Značaj in temperament';

  @override
  String get categoryCriticism => 'Kritika in žalitev';

  @override
  String get categoryVirtue => 'Krepost';

  @override
  String get categoryVice => 'Pregreha';

  @override
  String get categoryKnowledge => 'Znanje in misel';

  @override
  String get categoryReligion => 'Vera in duh';

  @override
  String get categoryBeginnings => 'Začetki';

  @override
  String get categoryConflict => 'Konflikt in prevara';

  @override
  String get categoryAppearance => 'Videz in svetloba';

  @override
  String get categoryPeople => 'Ljudje in vloge';

  @override
  String get categoryObjects => 'Predmeti in stvari';

  @override
  String get categoryEmotion => 'Čustvo';

  @override
  String get categoryArchaic => 'Staro in arhaično';

  @override
  String get navStudy => 'Kabinet';

  @override
  String get studyTitle => 'Kabinet';

  @override
  String get studyCaption => 'branje, glas in svetloba';

  @override
  String get readingSection => 'Branje';

  @override
  String get readingCaption => 'kako sede stran';

  @override
  String get textSize => 'Velikost besedila';

  @override
  String get textSizeSample => 'Edulcorate — osladiti, omehčati.';

  @override
  String get smaller => 'Manjše';

  @override
  String get larger => 'Večje';

  @override
  String get autoplayPronunciation => 'Preberi besedo na glas ob odprtju';

  @override
  String get reduceMotion => 'Umiri okrasje';

  @override
  String get reduceMotionCaption => 'manj okraskov in prelivov';

  @override
  String get voiceSection => 'Glas';

  @override
  String get voiceCaption => 'kako Gloss bere na glas';

  @override
  String get chooseVoice => 'Glas';

  @override
  String get voiceDefault => 'Izbran za vas';

  @override
  String get noOtherVoices =>
      'V tej napravi ni nameščenih drugih angleških glasov.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Počasneje';

  @override
  String get faster => 'Hitreje';

  @override
  String get hearIt => 'Poslušaj';

  @override
  String get lightSection => 'Svetloba';

  @override
  String get lightCaption => 'pergament ali svetloba sveče';

  @override
  String get themeSystem => 'Po napravi';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Svetloba sveče';

  @override
  String get tongueSection => 'Jezik';

  @override
  String get aboutSection => 'O aplikaciji';

  @override
  String get aboutCaption => 'kako je nastalo';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licence odprte kode';

  @override
  String get shareGloss => 'Deli Gloss';

  @override
  String get followTheMaker => 'Sledi avtorju';

  @override
  String couldNotOpenLink(String label) {
    return 'Ni bilo mogoče odpreti $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Beri razlage v jeziku $language';
  }

  @override
  String get readExplanationsCaption =>
      'Sama beseda se vedno prebere v angleščini.';

  @override
  String noVoiceInstalled(String language) {
    return 'Ta naprava nima nameščenega glasu za jezik $language.';
  }

  @override
  String get memorySection => 'Spomin';

  @override
  String get memoryCaption => 'kaj Gloss hrani';

  @override
  String get forgetProgress => 'Pozabi moj napredek';

  @override
  String get forgetProgressBody =>
      'Besedam, ki ste jih raziskali, bo odstranjena oznaka. Shranjene besede ostanejo.';

  @override
  String get clearSavedWords => 'Počisti shranjene besede';

  @override
  String get clearSavedWordsBody =>
      'Besede, ki ste jih shranili, bodo odstranjene. Vaš napredek ostane.';

  @override
  String get cancel => 'Prekliči';

  @override
  String get forget => 'Pozabi';

  @override
  String get clear => 'Počisti';

  @override
  String get progressForgotten => 'Napredek pozabljen.';

  @override
  String get savedWordsCleared => 'Shranjene besede počiščene.';

  @override
  String get contactTitle => 'Pišite ustvarjalcu';

  @override
  String get contactCaption => 'pismo, če želite';

  @override
  String get contactBlurb =>
      'Gloss dela en sam človek. Beseda, ki vam manjka, napaka, ki ste jo našli, vrstica, ki vam je bila všeč — vse pride na isto mizo.';

  @override
  String get contactLetterSection => 'Pismo';

  @override
  String get contactName => 'Vaše ime';

  @override
  String get contactNameHint => 'Ime, s katerim vas pozdravimo';

  @override
  String get contactEmail => 'Vaš e-naslov';

  @override
  String get contactEmailHint => 'Kam lahko pride odgovor';

  @override
  String contactEmailTypo(String domain) {
    return 'Ste mislili $domain?';
  }

  @override
  String get contactReason => 'Razlog za sporočilo';

  @override
  String get reasonWord => 'Beseda, ki jo velja dodati';

  @override
  String get reasonProblem => 'Nekaj ni v redu';

  @override
  String get reasonQuestion => 'Vprašanje';

  @override
  String get reasonPraise => 'Odziv';

  @override
  String get reasonOther => 'Nekaj drugega';

  @override
  String get contactPriority => 'Kako nujno';

  @override
  String get priorityLow => 'Nizka';

  @override
  String get priorityNormal => 'Običajna';

  @override
  String get priorityHigh => 'Visoka';

  @override
  String get contactMessage => 'Vaše sporočilo';

  @override
  String get contactMessageHint => 'Napišite toliko ali tako malo, kot želite…';

  @override
  String get contactHumanCheck => 'Ena beseda pred pošiljanjem';

  @override
  String contactHumanQuestion(String word) {
    return 'Kateri pomen pripada besedi $word?';
  }

  @override
  String get contactHumanRetry => 'Ta ne. Tukaj je druga beseda.';

  @override
  String get contactDetails => 'Priloži podatke o aplikaciji';

  @override
  String get contactDetailsCaption =>
      'Različica, jezik, svetloba in velikost besedila, da se napaka najde prej.';

  @override
  String get contactSend => 'Pošlji pismo';

  @override
  String get contactCopyLetter => 'Kopiraj pismo';

  @override
  String get contactDraftRestored => 'Tu je čakalo neposlano pismo.';

  @override
  String get contactNoMailApp =>
      'Nobena poštna aplikacija ni odgovorila, pismo je ostalo v odložišču.';

  @override
  String get contactNeedName => 'Ime, da odgovor ve, koga nagovarja.';

  @override
  String get contactNeedEmail => 'Naslov, do katerega pride odgovor.';

  @override
  String get contactNeedMessage => 'Vsaj vrstica ali dve.';

  @override
  String get contactSent => 'Vaše pismo je na poti. Hvala.';

  @override
  String get contactSendFailed =>
      'Pisma zdaj ni bilo mogoče poslati. Je v odložišču in ostaja tukaj.';

  @override
  String get contactSendByMail => 'Namesto tega uporabi poštno aplikacijo';
}
