// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'kamusi ya lugha nzuri';

  @override
  String get navHome => 'Nyumbani';

  @override
  String get navLexicon => 'Kamusi';

  @override
  String get navQuiz => 'Jaribio';

  @override
  String get navSaved => 'Zilizohifadhiwa';

  @override
  String get navLanguages => 'Lugha';

  @override
  String homeBlurb(int count, String lexicon) {
    return 'Maneno $count adimu na tajiri kutoka kamusi ya $lexicon — yameelezwa kama rafiki anavyoeleza, si kama kamusi.';
  }

  @override
  String wordsExplored(int current, int total) {
    return 'Maneno $current kati ya $total yamechunguzwa';
  }

  @override
  String get exploreLexicon => 'Chunguza kamusi';

  @override
  String get startQuiz => 'Anza jaribio';

  @override
  String get wordOfTheDay => 'neno la siku';

  @override
  String get readFullEntry => 'Soma ingizo lote →';

  @override
  String get lexiconTitle => 'Kamusi';

  @override
  String get lexiconCaption => 'mkusanyiko';

  @override
  String get savedTitle => 'Maneno yaliyohifadhiwa';

  @override
  String get savedCaption => 'yalioshikiliwa karibu';

  @override
  String get searchHint => 'Tafuta neno, au eleza maana yake…';

  @override
  String get clearSearch => 'Futa utafutaji';

  @override
  String get filterAll => 'Zote';

  @override
  String get noMatches => 'Bado hakuna mechi — jaribu neno au hisia nyingine.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'mechi $n',
      one: 'mechi 1',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'hakuna hapa';

  @override
  String get emptyLexicon => 'Hakuna kitu katika kona hii ya kamusi.';

  @override
  String get emptySaved =>
      'Bado hakuna maneno yaliyohifadhiwa. Gusa moyo kwenye ingizo lolote.';

  @override
  String get tapToReadMore => 'Gusa kusoma zaidi';

  @override
  String get saveWord => 'Hifadhi neno';

  @override
  String get removeFromFavorites => 'Ondoa kwenye vipendwa';

  @override
  String get inPlainWords => 'kwa maneno rahisi';

  @override
  String get theDefinition => 'ufafanuzi';

  @override
  String get inASentence => 'katika sentensi';

  @override
  String get exampleGlossLabel => 'kwa maneno mengine';

  @override
  String get save => 'Hifadhi';

  @override
  String get saved => 'Imehifadhiwa';

  @override
  String get copy => 'Nakili';

  @override
  String get copiedToClipboard => 'Imenakiliwa kwenye ubao';

  @override
  String get roots => 'mizizi';

  @override
  String get quizTitle => 'Jaribio dogo';

  @override
  String get quizCaption => 'jua mizizi, kisha chagua maana';

  @override
  String get quizIntro =>
      'Kila swali linaonyesha neno na asili yake. Chagua ufafanuzi unaofaa — chaguzi nne, moja ni kweli.';

  @override
  String get howManyWords => 'maneno mangapi';

  @override
  String get begin => 'Anza';

  @override
  String get quizByTheme => 'Jaribio kwa mada';

  @override
  String get endQuiz => 'Maliza jaribio';

  @override
  String questionOf(int index, int length) {
    return 'Swali $index kati ya $length';
  }

  @override
  String get whichDefinitionFits => 'ufafanuzi upi unaofaa?';

  @override
  String get previous => 'Iliyotangulia';

  @override
  String get next => 'Ifuatayo';

  @override
  String get seeResults => 'Tazama matokeo';

  @override
  String get themeTitle => 'Mada';

  @override
  String get chooseASubject => 'chagua somo';

  @override
  String get noThemesYet => 'Bado hakuna mada.';

  @override
  String get notEnoughWordsInTheme =>
      'Bado hakuna maneno ya kutosha katika mada hii.';

  @override
  String get results => 'Matokeo';

  @override
  String get perfectPage => 'ukurasa mkamilifu';

  @override
  String get wellMarked => 'imetiwa alama vizuri';

  @override
  String get tryAnotherRound => 'Jaribu raundi nyingine';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'ufafanuzi $score sahihi',
      one: 'ufafanuzi 1 sahihi',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'Ufafanuzi $score sahihi, kati ya $total.',
      one: 'Ufafanuzi mmoja sahihi, kati ya $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Badili hali ya mwanga';

  @override
  String get switchToDarkMode => 'Badili hali ya giza';

  @override
  String get listen => 'Sikiliza';

  @override
  String get stop => 'Simamisha';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Lugha';

  @override
  String get languagesCaption => 'ndimi';

  @override
  String get searchLanguages => 'Tafuta nchi au lugha…';

  @override
  String get noMatchingLanguages => 'Hakuna nchi wala lugha zinazolingana.';

  @override
  String get selectedLanguage => 'Unasoma kwa';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Ulaya';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current kati ya $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Pia $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Kama katika: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Kutoka $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, maana $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Kwa maneno rahisi: $friendly';
  }

  @override
  String get categorySpeech => 'Usemi na balagha';

  @override
  String get categoryCharacter => 'Tabia na mwelekeo';

  @override
  String get categoryCriticism => 'Ukosoaji na tusi';

  @override
  String get categoryVirtue => 'Fadhila';

  @override
  String get categoryVice => 'Uovu';

  @override
  String get categoryKnowledge => 'Maarifa na mawazo';

  @override
  String get categoryReligion => 'Dini na roho';

  @override
  String get categoryBeginnings => 'Mwanzo';

  @override
  String get categoryConflict => 'Mgogoro na udanganyifu';

  @override
  String get categoryAppearance => 'Muonekano na nuru';

  @override
  String get categoryPeople => 'Watu na majukumu';

  @override
  String get categoryObjects => 'Vitu na vifaa';

  @override
  String get categoryEmotion => 'Hisia';

  @override
  String get categoryArchaic => 'Kale na cha zamani';

  @override
  String get navStudy => 'Chumba';

  @override
  String get studyTitle => 'Chumba cha kusomea';

  @override
  String get studyCaption => 'kusoma, sauti na mwanga';

  @override
  String get readingSection => 'Kusoma';

  @override
  String get readingCaption => 'jinsi ukurasa unavyokaa';

  @override
  String get textSize => 'Ukubwa wa maandishi';

  @override
  String get textSizeSample => 'Edulcorate — kutia utamu, kulainisha.';

  @override
  String get smaller => 'Ndogo zaidi';

  @override
  String get larger => 'Kubwa zaidi';

  @override
  String get autoplayPronunciation => 'Soma neno kwa sauti linapofunguliwa';

  @override
  String get reduceMotion => 'Tuliza mapambo';

  @override
  String get reduceMotionCaption => 'mapambo na mabadiliko ya rangi machache';

  @override
  String get voiceSection => 'Sauti';

  @override
  String get voiceCaption => 'jinsi Gloss inavyosoma kwa sauti';

  @override
  String get chooseVoice => 'Sauti';

  @override
  String get voiceDefault => 'Imechaguliwa kwa ajili yako';

  @override
  String get noOtherVoices =>
      'Hakuna sauti nyingine za Kiingereza zilizosakinishwa kwenye kifaa hiki.';

  @override
  String get speechPace => 'Mwendo';

  @override
  String get slower => 'Polepole zaidi';

  @override
  String get faster => 'Haraka zaidi';

  @override
  String get hearIt => 'Lisikilize';

  @override
  String get lightSection => 'Mwanga';

  @override
  String get lightCaption => 'ngozi ya kuandikia au mwanga wa mshumaa';

  @override
  String get themeSystem => 'Fuata kifaa';

  @override
  String get themeLight => 'Ngozi ya kuandikia';

  @override
  String get themeDark => 'Mwanga wa mshumaa';

  @override
  String get tongueSection => 'Lugha';

  @override
  String get aboutSection => 'Kuhusu';

  @override
  String get aboutCaption => 'jinsi ilivyotengenezwa';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Leseni za chanzo huria';

  @override
  String get shareGloss => 'Shiriki Gloss';

  @override
  String get followTheMaker => 'Mfuate mtengenezaji';

  @override
  String couldNotOpenLink(String label) {
    return 'Imeshindwa kufungua $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Soma maelezo kwa $language';
  }

  @override
  String get readExplanationsCaption =>
      'Neno lenyewe husomwa kwa Kiingereza kila wakati.';

  @override
  String noVoiceInstalled(String language) {
    return 'Kifaa hiki hakina sauti ya $language iliyosakinishwa.';
  }
}
