// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'leksikon lijepe riječi';

  @override
  String get navHome => 'Početna';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Kviz';

  @override
  String get navSaved => 'Spremljeno';

  @override
  String get navLanguages => 'Jezici';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count rijetkih, bogatih riječi iz leksikona $lexicon — objašnjenih kako bi ih objasnio prijatelj, ne rječnik.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'istraženo $current od $total riječi';
  }

  @override
  String get exploreLexicon => 'Istraži leksikon';

  @override
  String get startQuiz => 'Započni kviz';

  @override
  String get wordOfTheDay => 'riječ dana';

  @override
  String get readFullEntry => 'Pročitaj cijeli unos →';

  @override
  String get lexiconTitle => 'Leksikon';

  @override
  String get lexiconCaption => 'zbirka';

  @override
  String get savedTitle => 'Spremljene riječi';

  @override
  String get savedCaption => 'blizu srca';

  @override
  String get searchHint => 'Potraži riječ ili opiši njezino značenje…';

  @override
  String get clearSearch => 'Očisti pretragu';

  @override
  String get filterAll => 'Sve';

  @override
  String get noMatches =>
      'Još nema poklapanja — pokušaj drugu riječ ili osjećaj.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n poklapanja',
      one: '1 poklapanje',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ovdje ništa';

  @override
  String get emptyLexicon => 'U ovom kutu leksikona nema ničega.';

  @override
  String get emptySaved =>
      'Još nema spremljenih riječi. Dodirni srce na bilo kojem unosu.';

  @override
  String get tapToReadMore => 'Dodirni za daljnje čitanje';

  @override
  String get saveWord => 'Spremi riječ';

  @override
  String get removeFromFavorites => 'Ukloni iz omiljenih';

  @override
  String get inPlainWords => 'prostih riječi';

  @override
  String get theDefinition => 'definicija';

  @override
  String get inASentence => 'u rečenici';

  @override
  String get exampleGlossLabel => 'drugim riječima';

  @override
  String get save => 'Spremi';

  @override
  String get saved => 'Spremljeno';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copiedToClipboard => 'Kopirano u međuspremnik';

  @override
  String get roots => 'korijeni';

  @override
  String get quizTitle => 'Mali kviz';

  @override
  String get quizCaption => 'upoznaj korijene, zatim odaberi značenje';

  @override
  String get quizIntro =>
      'Svako pitanje pokazuje riječ i njezinu etimologiju. Odaberi definiciju koja pristaje — četiri izbora, jedan točan.';

  @override
  String get howManyWords => 'koliko riječi';

  @override
  String get begin => 'Počni';

  @override
  String get quizByTheme => 'Kviz po temi';

  @override
  String get endQuiz => 'Završi kviz';

  @override
  String questionOf(int index, int length) {
    return 'Pitanje $index od $length';
  }

  @override
  String get whichDefinitionFits => 'koja definicija pristaje?';

  @override
  String get previous => 'Prethodno';

  @override
  String get next => 'Sljedeće';

  @override
  String get seeResults => 'Pogledaj rezultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'odaberi predmet';

  @override
  String get noThemesYet => 'Još nema tema.';

  @override
  String get notEnoughWordsInTheme => 'U ovoj temi još nema dovoljno riječi.';

  @override
  String get results => 'Rezultati';

  @override
  String get perfectPage => 'savršena stranica';

  @override
  String get wellMarked => 'lijepo zabilježeno';

  @override
  String get tryAnotherRound => 'Pokušaj još jedan krug';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score točnih definicija',
      one: '1 točna definicija',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score točnih definicija, od $total.',
      one: 'Jedna točna definicija, od $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Prijeđi na svijetli način';

  @override
  String get switchToDarkMode => 'Prijeđi na tamni način';

  @override
  String get listen => 'Slušaj';

  @override
  String get stop => 'Zaustavi';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jezici';

  @override
  String get languagesCaption => 'jezici';

  @override
  String get searchLanguages => 'Potraži zemlju ili jezik…';

  @override
  String get noMatchingLanguages => 'Nema odgovarajućih zemalja ni jezika.';

  @override
  String get selectedLanguage => 'Čitanje na';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azija';

  @override
  String get continentEurope => 'Europa';

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
    return 'Također $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kao u: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Iz $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, značenje $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Prostih riječi: $friendly';
  }

  @override
  String get categorySpeech => 'Govor i retorika';

  @override
  String get categoryCharacter => 'Karakter i temperament';

  @override
  String get categoryCriticism => 'Kritika i uvreda';

  @override
  String get categoryVirtue => 'Krepost';

  @override
  String get categoryVice => 'Porok';

  @override
  String get categoryKnowledge => 'Znanje i misao';

  @override
  String get categoryReligion => 'Vjera i duh';

  @override
  String get categoryBeginnings => 'Počeci';

  @override
  String get categoryConflict => 'Sukob i prijevara';

  @override
  String get categoryAppearance => 'Izgled i svjetlo';

  @override
  String get categoryPeople => 'Ljudi i uloge';

  @override
  String get categoryObjects => 'Predmeti i stvari';

  @override
  String get categoryEmotion => 'Emocija';

  @override
  String get categoryArchaic => 'Staro i arhaično';

  @override
  String get navStudy => 'Radna soba';

  @override
  String get studyTitle => 'Radna soba';

  @override
  String get studyCaption => 'čitanje, glas i svjetlo';

  @override
  String get readingSection => 'Čitanje';

  @override
  String get readingCaption => 'kako stranica sjeda';

  @override
  String get textSize => 'Veličina teksta';

  @override
  String get textSizeSample => 'Edulcorate — zasladiti, ublažiti.';

  @override
  String get smaller => 'Manje';

  @override
  String get larger => 'Veće';

  @override
  String get autoplayPronunciation => 'Pročitaj riječ naglas pri otvaranju';

  @override
  String get reduceMotion => 'Smiri ukrase';

  @override
  String get reduceMotionCaption => 'manje vitica i prijelaza';

  @override
  String get voiceSection => 'Glas';

  @override
  String get voiceCaption => 'kako Gloss čita naglas';

  @override
  String get chooseVoice => 'Glas';

  @override
  String get voiceDefault => 'Odabran za tebe';

  @override
  String get noOtherVoices =>
      'Na ovom uređaju nisu instalirani drugi engleski glasovi.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Sporije';

  @override
  String get faster => 'Brže';

  @override
  String get hearIt => 'Poslušaj';

  @override
  String get lightSection => 'Svjetlo';

  @override
  String get lightCaption => 'pergament ili svjetlo svijeće';

  @override
  String get themeSystem => 'Prati uređaj';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Svjetlo svijeće';

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
  String get openLicences => 'Licencije otvorenog koda';

  @override
  String get shareGloss => 'Podijeli Gloss';

  @override
  String get followTheMaker => 'Prati autora';

  @override
  String couldNotOpenLink(String label) {
    return 'Nije moguće otvoriti $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Čitaj objašnjenja na jeziku $language';
  }

  @override
  String get readExplanationsCaption =>
      'Sama riječ uvijek se čita na engleskom.';

  @override
  String noVoiceInstalled(String language) {
    return 'Ovaj uređaj nema instaliran glas za jezik $language.';
  }

  @override
  String get memorySection => 'Pamćenje';

  @override
  String get memoryCaption => 'što Gloss čuva';

  @override
  String get forgetProgress => 'Zaboravi moj napredak';

  @override
  String get forgetProgressBody =>
      'Riječima koje ste istražili bit će uklonjena oznaka. Spremljene riječi ostaju.';

  @override
  String get clearSavedWords => 'Očisti spremljene riječi';

  @override
  String get clearSavedWordsBody =>
      'Riječi koje ste sačuvali bit će uklonjene. Vaš napredak ostaje.';

  @override
  String get cancel => 'Odustani';

  @override
  String get forget => 'Zaboravi';

  @override
  String get clear => 'Očisti';

  @override
  String get progressForgotten => 'Napredak zaboravljen.';

  @override
  String get savedWordsCleared => 'Spremljene riječi očišćene.';

  @override
  String get contactTitle => 'Pišite tvorcu';

  @override
  String get contactCaption => 'pismo, ako želite';

  @override
  String get contactBlurb =>
      'Gloss radi jedan čovjek. Riječ koja vam nedostaje, pogreška koju ste našli, redak koji vam se svidio — sve stiže na isti stol.';

  @override
  String get contactLetterSection => 'Pismo';

  @override
  String get contactName => 'Vaše ime';

  @override
  String get contactNameHint => 'Ime kojim ćemo vas pozdraviti';

  @override
  String get contactEmail => 'Vaša e-pošta';

  @override
  String get contactEmailHint => 'Gdje vas odgovor može pronaći';

  @override
  String contactEmailTypo(String domain) {
    return 'Jeste li mislili $domain?';
  }

  @override
  String get contactReason => 'Razlog poruke';

  @override
  String get reasonWord => 'Riječ koju treba dodati';

  @override
  String get reasonProblem => 'Nešto nije u redu';

  @override
  String get reasonQuestion => 'Pitanje';

  @override
  String get reasonPraise => 'Povratna informacija';

  @override
  String get reasonOther => 'Nešto drugo';

  @override
  String get contactPriority => 'Koliko je hitno';

  @override
  String get priorityLow => 'Niska';

  @override
  String get priorityNormal => 'Uobičajena';

  @override
  String get priorityHigh => 'Visoka';

  @override
  String get contactMessage => 'Vaša poruka';

  @override
  String get contactMessageHint => 'Pišite koliko god želite, ili sasvim malo…';

  @override
  String get contactHumanCheck => 'Jedna riječ prije slanja';

  @override
  String contactHumanQuestion(String word) {
    return 'Koje značenje pripada riječi $word?';
  }

  @override
  String get contactHumanRetry => 'Ne to. Evo druge riječi.';

  @override
  String get contactDetails => 'Priloži podatke o aplikaciji';

  @override
  String get contactDetailsCaption =>
      'Verzija, jezik, svjetlo i veličina teksta, da se pogreška prije pronađe.';

  @override
  String get contactSend => 'Pošalji pismo';

  @override
  String get contactCopyLetter => 'Kopiraj pismo';

  @override
  String get contactDraftRestored => 'Ovdje je čekalo neposlano pismo.';

  @override
  String get contactNoMailApp =>
      'Nijedna aplikacija za poštu nije odgovorila, pismo je ostalo u međuspremniku.';

  @override
  String get contactNeedName => 'Ime, da odgovor zna koga pozdravlja.';

  @override
  String get contactNeedEmail => 'Adresa do koje odgovor može stići.';

  @override
  String get contactNeedMessage => 'Barem redak ili dva.';

  @override
  String get contactSent => 'Vaše pismo je na putu. Hvala.';

  @override
  String get contactSendFailed =>
      'Pismo se sada nije moglo poslati. U međuspremniku je i ostaje ovdje.';

  @override
  String get contactSendByMail => 'Umjesto toga koristi aplikaciju za poštu';
}
