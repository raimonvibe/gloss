// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => '\'n leksikon van lieflike taal';

  @override
  String get navHome => 'Tuis';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Vasvra';

  @override
  String get navSaved => 'Gestoor';

  @override
  String get navLanguages => 'Tale';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count skaars, ryk woorde uit die $lexicon-leksikon — verduidelik soos \'n vriend dit sou doen, nie \'n woordeboek nie.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current van $total woorde verken';
  }

  @override
  String get exploreLexicon => 'Verken die leksikon';

  @override
  String get startQuiz => 'Begin \'n vasvra';

  @override
  String get wordOfTheDay => 'woord van die dag';

  @override
  String get readFullEntry => 'Lees die volle inskrywing →';

  @override
  String get lexiconTitle => 'Die leksikon';

  @override
  String get lexiconCaption => 'die versameling';

  @override
  String get savedTitle => 'Gestoorde woorde';

  @override
  String get savedCaption => 'naby gehou';

  @override
  String get searchHint => 'Soek \'n woord, of beskryf die betekenis…';

  @override
  String get clearSearch => 'Maak soektog skoon';

  @override
  String get filterAll => 'Alles';

  @override
  String get noMatches =>
      'Nog geen treffers nie — probeer \'n ander woord of gevoel.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treffers',
      one: '1 treffer',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'niks hier nie';

  @override
  String get emptyLexicon => 'Niks in hierdie hoek van die leksikon nie.';

  @override
  String get emptySaved =>
      'Nog geen gestoorde woorde nie. Tik op die hartjie by enige inskrywing.';

  @override
  String get tapToReadMore => 'Tik om verder te lees';

  @override
  String get saveWord => 'Stoor woord';

  @override
  String get removeFromFavorites => 'Verwyder uit gunstelinge';

  @override
  String get inPlainWords => 'in eenvoudige woorde';

  @override
  String get theDefinition => 'die definisie';

  @override
  String get inASentence => 'in \'n sin';

  @override
  String get exampleGlossLabel => 'met ander woorde';

  @override
  String get save => 'Stoor';

  @override
  String get saved => 'Gestoor';

  @override
  String get copy => 'Kopieer';

  @override
  String get copiedToClipboard => 'Na die knipbord gekopieer';

  @override
  String get roots => 'wortels';

  @override
  String get quizTitle => '\'n Klein vasvra';

  @override
  String get quizCaption => 'ken die wortels, kies dan die betekenis';

  @override
  String get quizIntro =>
      'Elke vraag toon \'n woord en sy etimologie. Kies die definisie wat pas — vier keuses, een waar.';

  @override
  String get howManyWords => 'hoeveel woorde';

  @override
  String get begin => 'Begin';

  @override
  String get quizByTheme => 'Vasvra per tema';

  @override
  String get endQuiz => 'Beëindig vasvra';

  @override
  String questionOf(int index, int length) {
    return 'Vraag $index van $length';
  }

  @override
  String get whichDefinitionFits => 'watter definisie pas?';

  @override
  String get previous => 'Vorige';

  @override
  String get next => 'Volgende';

  @override
  String get seeResults => 'Sien resultate';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'kies \'n onderwerp';

  @override
  String get noThemesYet => 'Nog geen temas nie.';

  @override
  String get notEnoughWordsInTheme =>
      'Nog nie genoeg woorde in hierdie tema nie.';

  @override
  String get results => 'Resultate';

  @override
  String get perfectPage => '\'n volmaakte blad';

  @override
  String get wellMarked => 'mooi gemerk';

  @override
  String get tryAnotherRound => 'Probeer nog \'n ronde';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisies reg',
      one: '1 definisie reg',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definisies reg, van $total.',
      one: 'Een definisie reg, van $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Skakel oor na ligte modus';

  @override
  String get switchToDarkMode => 'Skakel oor na donker modus';

  @override
  String get listen => 'Luister';

  @override
  String get stop => 'Stop';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Tale';

  @override
  String get languagesCaption => 'die tongvalle';

  @override
  String get searchLanguages => 'Soek \'n land of taal…';

  @override
  String get noMatchingLanguages => 'Geen ooreenstemmende lande of tale nie.';

  @override
  String get selectedLanguage => 'Lees in';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asië';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oseanië';

  @override
  String currentOfTotal(int current, int total) {
    return '$current van $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Ook $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Soos in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Uit $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betekenis $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In eenvoudige woorde: $friendly';
  }

  @override
  String get categorySpeech => 'Spraak & Retoriek';

  @override
  String get categoryCharacter => 'Karakter & Temperament';

  @override
  String get categoryCriticism => 'Kritiek & Belediging';

  @override
  String get categoryVirtue => 'Deug';

  @override
  String get categoryVice => 'Ondeugd';

  @override
  String get categoryKnowledge => 'Kennis & Denke';

  @override
  String get categoryReligion => 'Godsdiens & Gees';

  @override
  String get categoryBeginnings => 'Beginne';

  @override
  String get categoryConflict => 'Stryd & Bedrog';

  @override
  String get categoryAppearance => 'Voorkoms & Lig';

  @override
  String get categoryPeople => 'Mense & Rolle';

  @override
  String get categoryObjects => 'Voorwerpe & Dinge';

  @override
  String get categoryEmotion => 'Emosie';

  @override
  String get categoryArchaic => 'Oud & Argais';

  @override
  String get navStudy => 'Studeer';

  @override
  String get studyTitle => 'Die studeerkamer';

  @override
  String get studyCaption => 'lees, stem en lig';

  @override
  String get readingSection => 'Lees';

  @override
  String get readingCaption => 'hoe die bladsy sit';

  @override
  String get textSize => 'Teksgrootte';

  @override
  String get textSizeSample => 'Edulcorate — om te versoet, om te versag.';

  @override
  String get smaller => 'Kleiner';

  @override
  String get larger => 'Groter';

  @override
  String get autoplayPronunciation =>
      'Lees \'n woord hardop wanneer dit oopmaak';

  @override
  String get reduceMotion => 'Kalmeer die versierings';

  @override
  String get reduceMotionCaption => 'minder krulle en kleurvloeie';

  @override
  String get voiceSection => 'Stem';

  @override
  String get voiceCaption => 'hoe Gloss hardop lees';

  @override
  String get chooseVoice => 'Stem';

  @override
  String get voiceDefault => 'Vir jou gekies';

  @override
  String get noOtherVoices =>
      'Geen ander Engelse stemme is op hierdie toestel geïnstalleer nie.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Stadiger';

  @override
  String get faster => 'Vinniger';

  @override
  String get hearIt => 'Hoor dit';

  @override
  String get lightSection => 'Lig';

  @override
  String get lightCaption => 'perkament of kerslig';

  @override
  String get themeSystem => 'Volg toestel';

  @override
  String get themeLight => 'Perkament';

  @override
  String get themeDark => 'Kerslig';

  @override
  String get tongueSection => 'Tong';

  @override
  String get aboutSection => 'Oor';

  @override
  String get aboutCaption => 'hoe dit gemaak is';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Oopbron-lisensies';

  @override
  String get shareGloss => 'Deel Gloss';

  @override
  String get followTheMaker => 'Volg die maker';

  @override
  String couldNotOpenLink(String label) {
    return 'Kon $label nie oopmaak nie.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Lees verduidelikings in $language';
  }

  @override
  String get readExplanationsCaption =>
      'Die woord self word altyd in Engels gelees.';

  @override
  String noVoiceInstalled(String language) {
    return 'Hierdie toestel het geen $language-stem geïnstalleer nie.';
  }

  @override
  String get memorySection => 'Geheue';

  @override
  String get memoryCaption => 'wat Gloss bewaar';

  @override
  String get forgetProgress => 'Vergeet my vordering';

  @override
  String get forgetProgressBody =>
      'Die woorde wat jy verken het, se merke word verwyder. Jou bewaarde woorde bly.';

  @override
  String get clearSavedWords => 'Maak bewaarde woorde skoon';

  @override
  String get clearSavedWordsBody =>
      'Die woorde wat jy bewaar het, word verwyder. Jou vordering bly.';

  @override
  String get cancel => 'Kanselleer';

  @override
  String get forget => 'Vergeet';

  @override
  String get clear => 'Maak skoon';

  @override
  String get progressForgotten => 'Vordering vergeet.';

  @override
  String get savedWordsCleared => 'Bewaarde woorde skoongemaak.';

  @override
  String get contactTitle => 'Skryf aan die maker';

  @override
  String get contactCaption => '\'n brief, as jy wil';

  @override
  String get contactBlurb =>
      'Gloss word deur een persoon gemaak. \'n Woord wat jy mis, \'n fout wat jy gekry het, \'n sin wat jou geval het — dit kom alles op dieselfde lessenaar.';

  @override
  String get contactLetterSection => 'Die brief';

  @override
  String get contactName => 'Jou naam';

  @override
  String get contactNameHint => 'Die naam waarmee jy gegroet word';

  @override
  String get contactEmail => 'Jou e-posadres';

  @override
  String get contactEmailHint => 'Waar \'n antwoord jou kan vind';

  @override
  String contactEmailTypo(String domain) {
    return 'Het jy $domain bedoel?';
  }

  @override
  String get contactReason => 'Rede vir skryf';

  @override
  String get reasonWord => '\'n Woord om by te voeg';

  @override
  String get reasonProblem => 'Iets is verkeerd';

  @override
  String get reasonQuestion => '\'n Vraag';

  @override
  String get reasonPraise => 'Terugvoer';

  @override
  String get reasonOther => 'Iets anders';

  @override
  String get contactPriority => 'Hoe dringend';

  @override
  String get priorityLow => 'Laag';

  @override
  String get priorityNormal => 'Normaal';

  @override
  String get priorityHigh => 'Hoog';

  @override
  String get contactMessage => 'Jou boodskap';

  @override
  String get contactMessageHint => 'Skryf soveel of so min soos jy wil…';

  @override
  String get contactHumanCheck => 'Nog een woord voor jy stuur';

  @override
  String contactHumanQuestion(String word) {
    return 'Watter betekenis hoort by $word?';
  }

  @override
  String get contactHumanRetry =>
      'Nie daardie een nie. Hier is \'n ander woord.';

  @override
  String get contactDetails => 'Stuur programbesonderhede saam';

  @override
  String get contactDetailsCaption =>
      'Weergawe, taal, lig en teksgrootte, sodat \'n fout makliker gevind word.';

  @override
  String get contactSend => 'Stuur die brief';

  @override
  String get contactCopyLetter => 'Kopieer die brief';

  @override
  String get contactDraftRestored => 'Hier het \'n ongestuurde brief gewag.';

  @override
  String get contactNoMailApp =>
      'Geen e-posprogram het geantwoord nie, die brief is op jou knipbord.';

  @override
  String get contactNeedName =>
      '\'n Naam, sodat \'n antwoord weet wie om te groet.';

  @override
  String get contactNeedEmail => '\'n Adres wat \'n antwoord kan bereik.';

  @override
  String get contactNeedMessage => 'Ten minste \'n reël of twee.';

  @override
  String get contactSent => 'Jou brief is op pad. Dankie.';

  @override
  String get contactSendFailed =>
      'Die brief kon nou nie gestuur word nie. Dit is op jou knipbord en bly hier bewaar.';

  @override
  String get contactSendByMail => 'Gebruik eerder \'n e-posprogram';
}
