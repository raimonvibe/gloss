// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'a szép nyelv lexikona';

  @override
  String get navHome => 'Kezdőlap';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Kvíz';

  @override
  String get navSaved => 'Mentett';

  @override
  String get navLanguages => 'Nyelvek';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count ritka, gazdag szó a $lexicon lexikonból — úgy magyarázva, ahogy egy barát magyarázna, nem egy szótár.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current / $total szó felfedezve';
  }

  @override
  String get exploreLexicon => 'Fedezd fel a lexikont';

  @override
  String get startQuiz => 'Kvíz indítása';

  @override
  String get wordOfTheDay => 'a nap szava';

  @override
  String get readFullEntry => 'A teljes szócikk →';

  @override
  String get lexiconTitle => 'A lexikon';

  @override
  String get lexiconCaption => 'a gyűjtemény';

  @override
  String get savedTitle => 'Mentett szavak';

  @override
  String get savedCaption => 'közel tartva';

  @override
  String get searchHint => 'Keress egy szót, vagy írd le a jelentését…';

  @override
  String get clearSearch => 'Keresés törlése';

  @override
  String get filterAll => 'Mind';

  @override
  String get noMatches => 'Még nincs találat — próbálj másik szót vagy érzést.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n találat',
      one: '1 találat',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'itt semmi sincs';

  @override
  String get emptyLexicon => 'A lexikon e sarkában semmi sincs.';

  @override
  String get emptySaved =>
      'Még nincs mentett szó. Érintsd meg a szívet bármely szócikken.';

  @override
  String get tapToReadMore => 'Érintsd meg a folytatáshoz';

  @override
  String get saveWord => 'Szó mentése';

  @override
  String get removeFromFavorites => 'Eltávolítás a kedvencekből';

  @override
  String get inPlainWords => 'egyszerűen';

  @override
  String get theDefinition => 'a meghatározás';

  @override
  String get inASentence => 'egy mondatban';

  @override
  String get exampleGlossLabel => 'másképpen';

  @override
  String get save => 'Mentés';

  @override
  String get saved => 'Mentve';

  @override
  String get copy => 'Másolás';

  @override
  String get copiedToClipboard => 'Vágólapra másolva';

  @override
  String get roots => 'gyökerek';

  @override
  String get quizTitle => 'Egy kis kvíz';

  @override
  String get quizCaption => 'ismerd a gyökereket, aztán válaszd a jelentést';

  @override
  String get quizIntro =>
      'Minden kérdés egy szót és az etimológiáját mutatja. Válaszd az illő meghatározást — négy lehetőség, egy igaz.';

  @override
  String get howManyWords => 'hány szó';

  @override
  String get begin => 'Kezdés';

  @override
  String get quizByTheme => 'Kvíz téma szerint';

  @override
  String get endQuiz => 'Kvíz befejezése';

  @override
  String questionOf(int index, int length) {
    return '$index. kérdés / $length';
  }

  @override
  String get whichDefinitionFits => 'melyik meghatározás illik?';

  @override
  String get previous => 'Előző';

  @override
  String get next => 'Következő';

  @override
  String get seeResults => 'Eredmények';

  @override
  String get themeTitle => 'Téma';

  @override
  String get chooseASubject => 'válassz tárgyat';

  @override
  String get noThemesYet => 'Még nincsenek témák.';

  @override
  String get notEnoughWordsInTheme => 'Ebben a témában még nincs elég szó.';

  @override
  String get results => 'Eredmények';

  @override
  String get perfectPage => 'tökéletes lap';

  @override
  String get wellMarked => 'szépen jelölve';

  @override
  String get tryAnotherRound => 'Próbálj egy újabb kört';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score helyes meghatározás',
      one: '1 helyes meghatározás',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score helyes meghatározás, $total közül.',
      one: 'Egy helyes meghatározás, $total közül.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Váltás világos módra';

  @override
  String get switchToDarkMode => 'Váltás sötét módra';

  @override
  String get listen => 'Hallgatás';

  @override
  String get stop => 'Leállítás';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Nyelvek';

  @override
  String get languagesCaption => 'a nyelvek';

  @override
  String get searchLanguages => 'Keress országot vagy nyelvet…';

  @override
  String get noMatchingLanguages => 'Nincs illő ország vagy nyelv.';

  @override
  String get selectedLanguage => 'Olvasás';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Ázsia';

  @override
  String get continentEurope => 'Európa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Óceánia';

  @override
  String currentOfTotal(int current, int total) {
    return '$current / $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Szintén $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Mint: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return '$origin nyelvből, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, jelentése $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Egyszerűen: $friendly';
  }

  @override
  String get categorySpeech => 'Beszéd és retorika';

  @override
  String get categoryCharacter => 'Jellem és temperamentum';

  @override
  String get categoryCriticism => 'Kritika és sértés';

  @override
  String get categoryVirtue => 'Erény';

  @override
  String get categoryVice => 'Bűn';

  @override
  String get categoryKnowledge => 'Tudás és gondolat';

  @override
  String get categoryReligion => 'Vallás és lélek';

  @override
  String get categoryBeginnings => 'Kezdetek';

  @override
  String get categoryConflict => 'Konfliktus és csalás';

  @override
  String get categoryAppearance => 'Megjelenés és fény';

  @override
  String get categoryPeople => 'Emberek és szerepek';

  @override
  String get categoryObjects => 'Tárgyak és dolgok';

  @override
  String get categoryEmotion => 'Érzelem';

  @override
  String get categoryArchaic => 'Régi és archaikus';

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
