// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'een lexicon van lieflijke taal';

  @override
  String get navHome => 'Home';

  @override
  String get navLexicon => 'Lexicon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Bewaard';

  @override
  String get navLanguages => 'Talen';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count zeldzame, rijke woorden uit het $lexicon-lexicon — uitgelegd zoals een vriend het zou doen, niet als een woordenboek.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current van $total woorden verkend';
  }

  @override
  String get exploreLexicon => 'Ontdek het lexicon';

  @override
  String get startQuiz => 'Begin een quiz';

  @override
  String get wordOfTheDay => 'woord van de dag';

  @override
  String get readFullEntry => 'Lees het hele lemma →';

  @override
  String get lexiconTitle => 'Het lexicon';

  @override
  String get lexiconCaption => 'de verzameling';

  @override
  String get savedTitle => 'Bewaarde woorden';

  @override
  String get savedCaption => 'dichtbij gehouden';

  @override
  String get searchHint => 'Zoek een woord, of beschrijf de betekenis…';

  @override
  String get clearSearch => 'Wis zoekopdracht';

  @override
  String get filterAll => 'Alles';

  @override
  String get noMatches =>
      'Nog geen treffers — probeer een ander woord of gevoel.';

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
  String get nothingHere => 'niets hier';

  @override
  String get emptyLexicon => 'Niets in deze hoek van het lexicon.';

  @override
  String get emptySaved =>
      'Nog geen bewaarde woorden. Tik op het hartje bij een lemma.';

  @override
  String get tapToReadMore => 'Tik om verder te lezen';

  @override
  String get saveWord => 'Bewaar woord';

  @override
  String get removeFromFavorites => 'Verwijder uit favorieten';

  @override
  String get inPlainWords => 'in gewone woorden';

  @override
  String get theDefinition => 'de definitie';

  @override
  String get inASentence => 'in een zin';

  @override
  String get exampleGlossLabel => 'anders gezegd';

  @override
  String get save => 'Bewaren';

  @override
  String get saved => 'Bewaard';

  @override
  String get copy => 'Kopiëren';

  @override
  String get copiedToClipboard => 'Gekopieerd naar het klembord';

  @override
  String get roots => 'wortels';

  @override
  String get quizTitle => 'Een klein quizje';

  @override
  String get quizCaption => 'ken de wortels, kies dan de betekenis';

  @override
  String get quizIntro =>
      'Elke vraag toont een woord en zijn etymologie. Kies de definitie die past — vier keuzes, één waar.';

  @override
  String get howManyWords => 'hoeveel woorden';

  @override
  String get begin => 'Begin';

  @override
  String get quizByTheme => 'Quiz per thema';

  @override
  String get endQuiz => 'Quiz beëindigen';

  @override
  String questionOf(int index, int length) {
    return 'Vraag $index van $length';
  }

  @override
  String get whichDefinitionFits => 'welke definitie past?';

  @override
  String get previous => 'Vorige';

  @override
  String get next => 'Volgende';

  @override
  String get seeResults => 'Bekijk resultaten';

  @override
  String get themeTitle => 'Thema';

  @override
  String get chooseASubject => 'kies een onderwerp';

  @override
  String get noThemesYet => 'Nog geen thema’s.';

  @override
  String get notEnoughWordsInTheme => 'Nog niet genoeg woorden in dit thema.';

  @override
  String get results => 'Resultaten';

  @override
  String get perfectPage => 'een volmaakte bladzijde';

  @override
  String get wellMarked => 'mooi gemerkt';

  @override
  String get tryAnotherRound => 'Nog een ronde';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definities goed',
      one: '1 definitie goed',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definities goed, van $total.',
      one: 'Eén definitie goed, van $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Schakel naar lichte modus';

  @override
  String get switchToDarkMode => 'Schakel naar donkere modus';

  @override
  String get listen => 'Luisteren';

  @override
  String get stop => 'Stoppen';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Talen';

  @override
  String get languagesCaption => 'de tongen';

  @override
  String get searchLanguages => 'Zoek een land of taal…';

  @override
  String get noMatchingLanguages => 'Geen passende landen of talen.';

  @override
  String get selectedLanguage => 'Lezen in';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Azië';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanië';

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
    return 'Zoals in: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Van $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betekenis $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'In gewone woorden: $friendly';
  }

  @override
  String get categorySpeech => 'Spraak & retorica';

  @override
  String get categoryCharacter => 'Karakter & temperament';

  @override
  String get categoryCriticism => 'Kritiek & belediging';

  @override
  String get categoryVirtue => 'Deugd';

  @override
  String get categoryVice => 'Ondeugd';

  @override
  String get categoryKnowledge => 'Kennis & denken';

  @override
  String get categoryReligion => 'Religie & geest';

  @override
  String get categoryBeginnings => 'Beginnen';

  @override
  String get categoryConflict => 'Conflict & bedrog';

  @override
  String get categoryAppearance => 'Voorkomen & licht';

  @override
  String get categoryPeople => 'Mensen & rollen';

  @override
  String get categoryObjects => 'Voorwerpen & dingen';

  @override
  String get categoryEmotion => 'Emotie';

  @override
  String get categoryArchaic => 'Oud & archaïsch';

  @override
  String get navStudy => 'Studie';

  @override
  String get studyTitle => 'De studeerkamer';

  @override
  String get studyCaption => 'lezen, stem en licht';

  @override
  String get readingSection => 'Lezen';

  @override
  String get readingCaption => 'hoe de bladzijde zit';

  @override
  String get textSize => 'Tekstgrootte';

  @override
  String get textSizeSample => 'Edulcorate — verzoeten, verzachten.';

  @override
  String get smaller => 'Kleiner';

  @override
  String get larger => 'Groter';

  @override
  String get autoplayPronunciation => 'Lees een woord voor bij openen';

  @override
  String get reduceMotion => 'Temper de versieringen';

  @override
  String get reduceMotionCaption => 'minder krullen en kleurverlopen';

  @override
  String get voiceSection => 'Stem';

  @override
  String get voiceCaption => 'hoe Gloss voorleest';

  @override
  String get chooseVoice => 'Stem';

  @override
  String get voiceDefault => 'Voor jou gekozen';

  @override
  String get noOtherVoices =>
      'Er zijn geen andere Engelse stemmen op dit apparaat geïnstalleerd.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Langzamer';

  @override
  String get faster => 'Sneller';

  @override
  String get hearIt => 'Hoor het';

  @override
  String get lightSection => 'Licht';

  @override
  String get lightCaption => 'perkament of kaarslicht';

  @override
  String get themeSystem => 'Volg apparaat';

  @override
  String get themeLight => 'Perkament';

  @override
  String get themeDark => 'Kaarslicht';

  @override
  String get tongueSection => 'Tong';

  @override
  String get aboutSection => 'Over';

  @override
  String get aboutCaption => 'hoe het gemaakt is';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open-source licenties';

  @override
  String get shareGloss => 'Deel Gloss';

  @override
  String get followTheMaker => 'Volg de maker';

  @override
  String couldNotOpenLink(String label) {
    return 'Kon $label niet openen.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Lees uitleg in $language';
  }

  @override
  String get readExplanationsCaption =>
      'Het woord zelf wordt altijd in het Engels gelezen.';

  @override
  String noVoiceInstalled(String language) {
    return 'Dit apparaat heeft geen $language-stem geïnstalleerd.';
  }

  @override
  String get memorySection => 'Geheugen';

  @override
  String get memoryCaption => 'wat Gloss bewaart';

  @override
  String get forgetProgress => 'Vergeet mijn voortgang';

  @override
  String get forgetProgressBody =>
      'De woorden die je hebt verkend, verliezen hun markering. Je bewaarde woorden blijven.';

  @override
  String get clearSavedWords => 'Wis bewaarde woorden';

  @override
  String get clearSavedWordsBody =>
      'De woorden die je hebt bewaard, worden verwijderd. Je voortgang blijft.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get forget => 'Vergeten';

  @override
  String get clear => 'Wissen';

  @override
  String get progressForgotten => 'Voortgang vergeten.';

  @override
  String get savedWordsCleared => 'Bewaarde woorden gewist.';
}
