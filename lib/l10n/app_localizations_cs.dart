// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'lexikon krásné řeči';

  @override
  String get navHome => 'Domů';

  @override
  String get navLexicon => 'Lexikon';

  @override
  String get navQuiz => 'Kvíz';

  @override
  String get navSaved => 'Uložené';

  @override
  String get navLanguages => 'Jazyky';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count vzácných, bohatých slov z lexikonu $lexicon — vysvětlených tak, jak by je vyložil přítel, ne slovník.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'prozkoumáno $current z $total slov';
  }

  @override
  String get exploreLexicon => 'Prozkoumat lexikon';

  @override
  String get startQuiz => 'Začít kvíz';

  @override
  String get wordOfTheDay => 'slovo dne';

  @override
  String get readFullEntry => 'Číst celý záznam →';

  @override
  String get lexiconTitle => 'Lexikon';

  @override
  String get lexiconCaption => 'sbírka';

  @override
  String get savedTitle => 'Uložená slova';

  @override
  String get savedCaption => 'poblíž srdce';

  @override
  String get searchHint => 'Hledej slovo, nebo popiš jeho význam…';

  @override
  String get clearSearch => 'Vymazat hledání';

  @override
  String get filterAll => 'Vše';

  @override
  String get noMatches => 'Zatím žádné shody — zkus jiné slovo nebo pocit.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n shod',
      one: '1 shoda',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nic tu není';

  @override
  String get emptyLexicon => 'V tomto koutě lexikonu nic není.';

  @override
  String get emptySaved =>
      'Zatím žádná uložená slova. Klepni na srdce u kteréhokoli záznamu.';

  @override
  String get tapToReadMore => 'Klepni pro další čtení';

  @override
  String get saveWord => 'Uložit slovo';

  @override
  String get removeFromFavorites => 'Odebrat z oblíbených';

  @override
  String get inPlainWords => 'prostými slovy';

  @override
  String get theDefinition => 'definice';

  @override
  String get inASentence => 've větě';

  @override
  String get exampleGlossLabel => 'jinými slovy';

  @override
  String get save => 'Uložit';

  @override
  String get saved => 'Uloženo';

  @override
  String get copy => 'Kopírovat';

  @override
  String get copiedToClipboard => 'Zkopírováno do schránky';

  @override
  String get roots => 'kořeny';

  @override
  String get quizTitle => 'Malý kvíz';

  @override
  String get quizCaption => 'poznej kořeny, pak vyber význam';

  @override
  String get quizIntro =>
      'Každá otázka ukáže slovo a jeho etymologii. Vyber definici, která sedí — čtyři volby, jedna pravdivá.';

  @override
  String get howManyWords => 'kolik slov';

  @override
  String get begin => 'Začít';

  @override
  String get quizByTheme => 'Kvíz podle tématu';

  @override
  String get endQuiz => 'Ukončit kvíz';

  @override
  String questionOf(int index, int length) {
    return 'Otázka $index z $length';
  }

  @override
  String get whichDefinitionFits => 'která definice sedí?';

  @override
  String get previous => 'Předchozí';

  @override
  String get next => 'Další';

  @override
  String get seeResults => 'Zobrazit výsledky';

  @override
  String get themeTitle => 'Téma';

  @override
  String get chooseASubject => 'vyber předmět';

  @override
  String get noThemesYet => 'Zatím žádná témata.';

  @override
  String get notEnoughWordsInTheme => 'V tomto tématu zatím není dost slov.';

  @override
  String get results => 'Výsledky';

  @override
  String get perfectPage => 'dokonalá stránka';

  @override
  String get wellMarked => 'pěkně označeno';

  @override
  String get tryAnotherRound => 'Zkus další kolo';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správných definic',
      one: '1 správná definice',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správných definic z $total.',
      one: 'Jedna správná definice z $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Přepnout na světlý režim';

  @override
  String get switchToDarkMode => 'Přepnout na tmavý režim';

  @override
  String get listen => 'Poslouchat';

  @override
  String get stop => 'Zastavit';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jazyky';

  @override
  String get languagesCaption => 'jazyky';

  @override
  String get searchLanguages => 'Hledej zemi nebo jazyk…';

  @override
  String get noMatchingLanguages => 'Žádné odpovídající země ani jazyky.';

  @override
  String get selectedLanguage => 'Čtení v jazyce';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asie';

  @override
  String get continentEurope => 'Evropa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceánie';

  @override
  String currentOfTotal(int current, int total) {
    return '$current z $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Také $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Jako v: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Z $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, význam $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Prostými slovy: $friendly';
  }

  @override
  String get categorySpeech => 'Řeč a rétorika';

  @override
  String get categoryCharacter => 'Povaha a temperament';

  @override
  String get categoryCriticism => 'Kritika a urážka';

  @override
  String get categoryVirtue => 'Ctnost';

  @override
  String get categoryVice => 'Neřest';

  @override
  String get categoryKnowledge => 'Vědění a myšlení';

  @override
  String get categoryReligion => 'Náboženství a duch';

  @override
  String get categoryBeginnings => 'Počátky';

  @override
  String get categoryConflict => 'Konflikt a klam';

  @override
  String get categoryAppearance => 'Vzhled a světlo';

  @override
  String get categoryPeople => 'Lidé a role';

  @override
  String get categoryObjects => 'Předměty a věci';

  @override
  String get categoryEmotion => 'Emoce';

  @override
  String get categoryArchaic => 'Staré a archaické';

  @override
  String get navStudy => 'Pracovna';

  @override
  String get studyTitle => 'Pracovna';

  @override
  String get studyCaption => 'čtení, hlas a světlo';

  @override
  String get readingSection => 'Čtení';

  @override
  String get readingCaption => 'jak stránka sedí';

  @override
  String get textSize => 'Velikost písma';

  @override
  String get textSizeSample => 'Edulcorate — osladit, zjemnit.';

  @override
  String get smaller => 'Menší';

  @override
  String get larger => 'Větší';

  @override
  String get autoplayPronunciation => 'Přečíst slovo nahlas při otevření';

  @override
  String get reduceMotion => 'Zklidnit ozdoby';

  @override
  String get reduceMotionCaption => 'méně ornamentů a přechodů';

  @override
  String get voiceSection => 'Hlas';

  @override
  String get voiceCaption => 'jak Gloss čte nahlas';

  @override
  String get chooseVoice => 'Hlas';

  @override
  String get voiceDefault => 'Vybráno pro vás';

  @override
  String get noOtherVoices =>
      'V tomto zařízení nejsou nainstalovány žádné další anglické hlasy.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Pomaleji';

  @override
  String get faster => 'Rychleji';

  @override
  String get hearIt => 'Poslechnout';

  @override
  String get lightSection => 'Světlo';

  @override
  String get lightCaption => 'pergamen nebo světlo svíce';

  @override
  String get themeSystem => 'Podle zařízení';

  @override
  String get themeLight => 'Pergamen';

  @override
  String get themeDark => 'Světlo svíce';

  @override
  String get tongueSection => 'Jazyk';

  @override
  String get aboutSection => 'O aplikaci';

  @override
  String get aboutCaption => 'jak to vzniklo';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licence otevřeného zdroje';

  @override
  String get shareGloss => 'Sdílet Gloss';

  @override
  String get followTheMaker => 'Sledujte autora';

  @override
  String couldNotOpenLink(String label) {
    return 'Nepodařilo se otevřít $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Číst vysvětlivky v jazyce $language';
  }

  @override
  String get readExplanationsCaption => 'Samotné slovo se vždy čte anglicky.';

  @override
  String noVoiceInstalled(String language) {
    return 'Toto zařízení nemá nainstalovaný hlas pro jazyk $language.';
  }

  @override
  String get memorySection => 'Paměť';

  @override
  String get memoryCaption => 'co si Gloss pamatuje';

  @override
  String get forgetProgress => 'Zapomenout můj pokrok';

  @override
  String get forgetProgressBody =>
      'Slovům, která jste prozkoumali, bude odebrána značka. Uložená slova zůstanou.';

  @override
  String get clearSavedWords => 'Vymazat uložená slova';

  @override
  String get clearSavedWordsBody =>
      'Slova, která jste si uložili, budou odstraněna. Váš pokrok zůstane.';

  @override
  String get cancel => 'Zrušit';

  @override
  String get forget => 'Zapomenout';

  @override
  String get clear => 'Vymazat';

  @override
  String get progressForgotten => 'Pokrok zapomenut.';

  @override
  String get savedWordsCleared => 'Uložená slova vymazána.';
}
