// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'kauniin kielen leksikko';

  @override
  String get navHome => 'Koti';

  @override
  String get navLexicon => 'Leksikko';

  @override
  String get navQuiz => 'Tietovisa';

  @override
  String get navSaved => 'Tallennetut';

  @override
  String get navLanguages => 'Kielet';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count harvinaista, rikasta sanaa $lexicon-leksikosta — selitettyinä niin kuin ystävä selittäisi, ei sanakirja.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current / $total sanaa tutkittu';
  }

  @override
  String get exploreLexicon => 'Tutki leksikkoa';

  @override
  String get startQuiz => 'Aloita tietovisa';

  @override
  String get wordOfTheDay => 'päivän sana';

  @override
  String get readFullEntry => 'Lue koko artikkeli →';

  @override
  String get lexiconTitle => 'Leksikko';

  @override
  String get lexiconCaption => 'kokoelma';

  @override
  String get savedTitle => 'Tallennetut sanat';

  @override
  String get savedCaption => 'lähellä pidetyt';

  @override
  String get searchHint => 'Etsi sanaa tai kuvaile sen merkitystä…';

  @override
  String get clearSearch => 'Tyhjennä haku';

  @override
  String get filterAll => 'Kaikki';

  @override
  String get noMatches =>
      'Ei osumia vielä — kokeile toista sanaa tai tunnetta.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n osumaa',
      one: '1 osuma',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'ei mitään täällä';

  @override
  String get emptyLexicon => 'Tässä leksikon nurkassa ei ole mitään.';

  @override
  String get emptySaved =>
      'Ei vielä tallennettuja sanoja. Napauta sydäntä missä tahansa artikkelissa.';

  @override
  String get tapToReadMore => 'Napauta lukeaksesi lisää';

  @override
  String get saveWord => 'Tallenna sana';

  @override
  String get removeFromFavorites => 'Poista suosikeista';

  @override
  String get inPlainWords => 'selkokielellä';

  @override
  String get theDefinition => 'määritelmä';

  @override
  String get inASentence => 'lauseessa';

  @override
  String get exampleGlossLabel => 'toisin sanoen';

  @override
  String get save => 'Tallenna';

  @override
  String get saved => 'Tallennettu';

  @override
  String get copy => 'Kopioi';

  @override
  String get copiedToClipboard => 'Kopioitu leikepöydälle';

  @override
  String get roots => 'juuret';

  @override
  String get quizTitle => 'Pieni tietovisa';

  @override
  String get quizCaption => 'tunne juuret, valitse sitten merkitys';

  @override
  String get quizIntro =>
      'Jokainen kysymys näyttää sanan ja sen etymologian. Valitse määritelmä, joka sopii — neljä vaihtoehtoa, yksi tosi.';

  @override
  String get howManyWords => 'kuinka monta sanaa';

  @override
  String get begin => 'Aloita';

  @override
  String get quizByTheme => 'Tietovisa teeman mukaan';

  @override
  String get endQuiz => 'Lopeta tietovisa';

  @override
  String questionOf(int index, int length) {
    return 'Kysymys $index / $length';
  }

  @override
  String get whichDefinitionFits => 'mikä määritelmä sopii?';

  @override
  String get previous => 'Edellinen';

  @override
  String get next => 'Seuraava';

  @override
  String get seeResults => 'Näytä tulokset';

  @override
  String get themeTitle => 'Teema';

  @override
  String get chooseASubject => 'valitse aihe';

  @override
  String get noThemesYet => 'Ei vielä teemoja.';

  @override
  String get notEnoughWordsInTheme =>
      'Tässä teemassa ei ole vielä tarpeeksi sanoja.';

  @override
  String get results => 'Tulokset';

  @override
  String get perfectPage => 'täydellinen sivu';

  @override
  String get wellMarked => 'kauniisti merkitty';

  @override
  String get tryAnotherRound => 'Kokeile uutta kierrosta';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score oikeaa määritelmää',
      one: '1 oikea määritelmä',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score oikeaa määritelmää, $total:stä.',
      one: 'Yksi oikea määritelmä, $total:stä.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Vaihda vaaleaan tilaan';

  @override
  String get switchToDarkMode => 'Vaihda tummaan tilaan';

  @override
  String get listen => 'Kuuntele';

  @override
  String get stop => 'Pysäytä';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Kielet';

  @override
  String get languagesCaption => 'kielet';

  @override
  String get searchLanguages => 'Etsi maata tai kieltä…';

  @override
  String get noMatchingLanguages => 'Ei vastaavia maita tai kieliä.';

  @override
  String get selectedLanguage => 'Lukukieli';

  @override
  String get continentAfrica => 'Afrikka';

  @override
  String get continentAsia => 'Aasia';

  @override
  String get continentEurope => 'Eurooppa';

  @override
  String get continentAmericas => 'Amerikka';

  @override
  String get continentOceania => 'Oseania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Myös $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kuten: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin kielestä, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, merkitys $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Selkokielellä: $friendly';
  }

  @override
  String get categorySpeech => 'Puhe ja retoriikka';

  @override
  String get categoryCharacter => 'Luonne ja temperamentti';

  @override
  String get categoryCriticism => 'Kritiikki ja solvaus';

  @override
  String get categoryVirtue => 'Hyve';

  @override
  String get categoryVice => 'Pahe';

  @override
  String get categoryKnowledge => 'Tieto ja ajatus';

  @override
  String get categoryReligion => 'Uskonto ja henki';

  @override
  String get categoryBeginnings => 'Alut';

  @override
  String get categoryConflict => 'Ristiriita ja petos';

  @override
  String get categoryAppearance => 'Ulkoasu ja valo';

  @override
  String get categoryPeople => 'Ihmiset ja roolit';

  @override
  String get categoryObjects => 'Esineet ja asiat';

  @override
  String get categoryEmotion => 'Tunne';

  @override
  String get categoryArchaic => 'Vanha ja arkaainen';

  @override
  String get navStudy => 'Työhuone';

  @override
  String get studyTitle => 'Työhuone';

  @override
  String get studyCaption => 'lukeminen, ääni ja valo';

  @override
  String get readingSection => 'Lukeminen';

  @override
  String get readingCaption => 'miten sivu asettuu';

  @override
  String get textSize => 'Tekstin koko';

  @override
  String get textSizeSample => 'Edulcorate — makeuttaa, pehmentää.';

  @override
  String get smaller => 'Pienempi';

  @override
  String get larger => 'Suurempi';

  @override
  String get autoplayPronunciation => 'Lue sana ääneen avattaessa';

  @override
  String get reduceMotion => 'Rauhoita koristeet';

  @override
  String get reduceMotionCaption => 'vähemmän kiehkuroita ja liukuvärejä';

  @override
  String get voiceSection => 'Ääni';

  @override
  String get voiceCaption => 'miten Gloss lukee ääneen';

  @override
  String get chooseVoice => 'Ääni';

  @override
  String get voiceDefault => 'Valittu sinulle';

  @override
  String get noOtherVoices =>
      'Tähän laitteeseen ei ole asennettu muita englanninkielisiä ääniä.';

  @override
  String get speechPace => 'Tahti';

  @override
  String get slower => 'Hitaammin';

  @override
  String get faster => 'Nopeammin';

  @override
  String get hearIt => 'Kuuntele';

  @override
  String get lightSection => 'Valo';

  @override
  String get lightCaption => 'pergamentti tai kynttilänvalo';

  @override
  String get themeSystem => 'Laitteen mukaan';

  @override
  String get themeLight => 'Pergamentti';

  @override
  String get themeDark => 'Kynttilänvalo';

  @override
  String get tongueSection => 'Kieli';

  @override
  String get aboutSection => 'Tietoja';

  @override
  String get aboutCaption => 'miten se syntyi';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Avoimen lähdekoodin lisenssit';

  @override
  String get shareGloss => 'Jaa Gloss';

  @override
  String get followTheMaker => 'Seuraa tekijää';

  @override
  String couldNotOpenLink(String label) {
    return 'Kohteen $label avaaminen epäonnistui.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Lue selitykset kielellä $language';
  }

  @override
  String get readExplanationsCaption => 'Itse sana luetaan aina englanniksi.';

  @override
  String noVoiceInstalled(String language) {
    return 'Tässä laitteessa ei ole $language-ääntä asennettuna.';
  }

  @override
  String get memorySection => 'Muisti';

  @override
  String get memoryCaption => 'mitä Gloss säilyttää';

  @override
  String get forgetProgress => 'Unohda edistymiseni';

  @override
  String get forgetProgressBody =>
      'Tutkimiesi sanojen merkintä poistetaan. Tallennetut sanasi säilyvät.';

  @override
  String get clearSavedWords => 'Tyhjennä tallennetut sanat';

  @override
  String get clearSavedWordsBody =>
      'Säilyttämäsi sanat poistetaan. Edistymisesi säilyy.';

  @override
  String get cancel => 'Peruuta';

  @override
  String get forget => 'Unohda';

  @override
  String get clear => 'Tyhjennä';

  @override
  String get progressForgotten => 'Edistyminen unohdettu.';

  @override
  String get savedWordsCleared => 'Tallennetut sanat tyhjennetty.';
}
