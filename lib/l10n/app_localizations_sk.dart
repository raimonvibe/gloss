// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'lexikón krásnej reči';

  @override
  String get navHome => 'Domov';

  @override
  String get navLexicon => 'Lexikón';

  @override
  String get navQuiz => 'Kvíz';

  @override
  String get navSaved => 'Uložené';

  @override
  String get navLanguages => 'Jazyky';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count vzácnych, bohatých slov z lexikónu $lexicon — vysvetlených tak, ako by ich vyložil priateľ, nie slovník.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'preskúmané $current z $total slov';
  }

  @override
  String get exploreLexicon => 'Preskúmať lexikón';

  @override
  String get startQuiz => 'Začať kvíz';

  @override
  String get wordOfTheDay => 'slovo dňa';

  @override
  String get readFullEntry => 'Čítať celý záznam →';

  @override
  String get lexiconTitle => 'Lexikón';

  @override
  String get lexiconCaption => 'zbierka';

  @override
  String get savedTitle => 'Uložené slová';

  @override
  String get savedCaption => 'blízko srdca';

  @override
  String get searchHint => 'Hľadaj slovo alebo opíš jeho význam…';

  @override
  String get clearSearch => 'Vymazať hľadanie';

  @override
  String get filterAll => 'Všetko';

  @override
  String get noMatches => 'Zatiaľ žiadne zhody — skús iné slovo alebo pocit.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n zhôd',
      one: '1 zhoda',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nič tu nie je';

  @override
  String get emptyLexicon => 'V tomto kúte lexikónu nič nie je.';

  @override
  String get emptySaved =>
      'Zatiaľ žiadne uložené slová. Ťukni na srdce pri ktoromkoľvek zázname.';

  @override
  String get tapToReadMore => 'Ťukni pre ďalšie čítanie';

  @override
  String get saveWord => 'Uložiť slovo';

  @override
  String get removeFromFavorites => 'Odstrániť z obľúbených';

  @override
  String get inPlainWords => 'prostými slovami';

  @override
  String get theDefinition => 'definícia';

  @override
  String get inASentence => 'vo vete';

  @override
  String get exampleGlossLabel => 'inými slovami';

  @override
  String get save => 'Uložiť';

  @override
  String get saved => 'Uložené';

  @override
  String get copy => 'Kopírovať';

  @override
  String get copiedToClipboard => 'Skopírované do schránky';

  @override
  String get roots => 'korene';

  @override
  String get quizTitle => 'Malý kvíz';

  @override
  String get quizCaption => 'poznaj korene, potom vyber význam';

  @override
  String get quizIntro =>
      'Každá otázka ukáže slovo a jeho etymológiu. Vyber definíciu, ktorá sedí — štyri voľby, jedna pravdivá.';

  @override
  String get howManyWords => 'koľko slov';

  @override
  String get begin => 'Začať';

  @override
  String get quizByTheme => 'Kvíz podľa témy';

  @override
  String get endQuiz => 'Ukončiť kvíz';

  @override
  String questionOf(int index, int length) {
    return 'Otázka $index z $length';
  }

  @override
  String get whichDefinitionFits => 'ktorá definícia sedí?';

  @override
  String get previous => 'Predchádzajúce';

  @override
  String get next => 'Ďalšie';

  @override
  String get seeResults => 'Zobraziť výsledky';

  @override
  String get themeTitle => 'Téma';

  @override
  String get chooseASubject => 'vyber predmet';

  @override
  String get noThemesYet => 'Zatiaľ žiadne témy.';

  @override
  String get notEnoughWordsInTheme => 'V tejto téme zatiaľ nie je dosť slov.';

  @override
  String get results => 'Výsledky';

  @override
  String get perfectPage => 'dokonalá strana';

  @override
  String get wellMarked => 'pekne označené';

  @override
  String get tryAnotherRound => 'Skús ďalšie kolo';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správnych definícií',
      one: '1 správna definícia',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score správnych definícií z $total.',
      one: 'Jedna správna definícia z $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Prepnúť na svetlý režim';

  @override
  String get switchToDarkMode => 'Prepnúť na tmavý režim';

  @override
  String get listen => 'Počúvať';

  @override
  String get stop => 'Zastaviť';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Jazyky';

  @override
  String get languagesCaption => 'jazyky';

  @override
  String get searchLanguages => 'Hľadaj krajinu alebo jazyk…';

  @override
  String get noMatchingLanguages => 'Žiadne zodpovedajúce krajiny ani jazyky.';

  @override
  String get selectedLanguage => 'Čítanie v jazyku';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Ázia';

  @override
  String get continentEurope => 'Európa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceánia';

  @override
  String currentOfTotal(int current, int total) {
    return '$current z $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Tiež $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Ako v: $example';
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
    return 'Prostými slovami: $friendly';
  }

  @override
  String get categorySpeech => 'Reč a rétorika';

  @override
  String get categoryCharacter => 'Povaha a temperament';

  @override
  String get categoryCriticism => 'Kritika a urážka';

  @override
  String get categoryVirtue => 'Cnosť';

  @override
  String get categoryVice => 'Neresť';

  @override
  String get categoryKnowledge => 'Vedomosti a myslenie';

  @override
  String get categoryReligion => 'Náboženstvo a duch';

  @override
  String get categoryBeginnings => 'Začiatky';

  @override
  String get categoryConflict => 'Konflikt a klam';

  @override
  String get categoryAppearance => 'Vzhľad a svetlo';

  @override
  String get categoryPeople => 'Ľudia a úlohy';

  @override
  String get categoryObjects => 'Predmety a veci';

  @override
  String get categoryEmotion => 'Emócia';

  @override
  String get categoryArchaic => 'Staré a archaické';

  @override
  String get navStudy => 'Pracovňa';

  @override
  String get studyTitle => 'Pracovňa';

  @override
  String get studyCaption => 'čítanie, hlas a svetlo';

  @override
  String get readingSection => 'Čítanie';

  @override
  String get readingCaption => 'ako sedí strana';

  @override
  String get textSize => 'Veľkosť písma';

  @override
  String get textSizeSample => 'Edulcorate — osladiť, zjemniť.';

  @override
  String get smaller => 'Menšie';

  @override
  String get larger => 'Väčšie';

  @override
  String get autoplayPronunciation => 'Prečítať slovo nahlas pri otvorení';

  @override
  String get reduceMotion => 'Upokojiť ozdoby';

  @override
  String get reduceMotionCaption => 'menej ornamentov a prechodov';

  @override
  String get voiceSection => 'Hlas';

  @override
  String get voiceCaption => 'ako Gloss číta nahlas';

  @override
  String get chooseVoice => 'Hlas';

  @override
  String get voiceDefault => 'Vybrané pre vás';

  @override
  String get noOtherVoices =>
      'V tomto zariadení nie sú nainštalované žiadne ďalšie anglické hlasy.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Pomalšie';

  @override
  String get faster => 'Rýchlejšie';

  @override
  String get hearIt => 'Vypočuť';

  @override
  String get lightSection => 'Svetlo';

  @override
  String get lightCaption => 'pergamen alebo svetlo sviece';

  @override
  String get themeSystem => 'Podľa zariadenia';

  @override
  String get themeLight => 'Pergamen';

  @override
  String get themeDark => 'Svetlo sviece';

  @override
  String get tongueSection => 'Jazyk';

  @override
  String get aboutSection => 'O aplikácii';

  @override
  String get aboutCaption => 'ako to vzniklo';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licencie otvoreného zdroja';

  @override
  String get shareGloss => 'Zdieľať Gloss';

  @override
  String get followTheMaker => 'Sledujte autora';

  @override
  String couldNotOpenLink(String label) {
    return 'Nepodarilo sa otvoriť $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Čítať vysvetlivky v jazyku $language';
  }

  @override
  String get readExplanationsCaption =>
      'Samotné slovo sa vždy číta po anglicky.';

  @override
  String noVoiceInstalled(String language) {
    return 'Toto zariadenie nemá nainštalovaný hlas pre jazyk $language.';
  }

  @override
  String get memorySection => 'Pamäť';

  @override
  String get memoryCaption => 'čo si Gloss pamätá';

  @override
  String get forgetProgress => 'Zabudnúť môj pokrok';

  @override
  String get forgetProgressBody =>
      'Slovám, ktoré ste preskúmali, sa odoberie značka. Uložené slová zostanú.';

  @override
  String get clearSavedWords => 'Vymazať uložené slová';

  @override
  String get clearSavedWordsBody =>
      'Slová, ktoré ste si uložili, budú odstránené. Váš pokrok zostane.';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get forget => 'Zabudnúť';

  @override
  String get clear => 'Vymazať';

  @override
  String get progressForgotten => 'Pokrok zabudnutý.';

  @override
  String get savedWordsCleared => 'Uložené slová vymazané.';
}
