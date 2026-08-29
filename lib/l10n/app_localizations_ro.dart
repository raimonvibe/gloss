// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un lexicon al limbii frumoase';

  @override
  String get navHome => 'Acasă';

  @override
  String get navLexicon => 'Lexicon';

  @override
  String get navQuiz => 'Chestionar';

  @override
  String get navSaved => 'Salvate';

  @override
  String get navLanguages => 'Limbi';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count cuvinte rare și bogate din lexiconul $lexicon — explicate cum le-ar explica un prieten, nu un dicționar.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current din $total cuvinte cercetate';
  }

  @override
  String get exploreLexicon => 'Explorează lexiconul';

  @override
  String get startQuiz => 'Începe un chestionar';

  @override
  String get wordOfTheDay => 'cuvântul zilei';

  @override
  String get readFullEntry => 'Citește tot articolul →';

  @override
  String get lexiconTitle => 'Lexiconul';

  @override
  String get lexiconCaption => 'culegerea';

  @override
  String get savedTitle => 'Cuvinte salvate';

  @override
  String get savedCaption => 'ținute aproape';

  @override
  String get searchHint => 'Caută un cuvânt sau descrie-i înțelesul…';

  @override
  String get clearSearch => 'Șterge căutarea';

  @override
  String get filterAll => 'Toate';

  @override
  String get noMatches =>
      'Nicio potrivire încă — încearcă alt cuvânt sau alt simțământ.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n potriviri',
      one: '1 potrivire',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nimic aici';

  @override
  String get emptyLexicon => 'Nimic în acest colț al lexiconului.';

  @override
  String get emptySaved =>
      'Niciun cuvânt salvat încă. Atinge inima de pe orice articol.';

  @override
  String get tapToReadMore => 'Atinge pentru a citi mai departe';

  @override
  String get saveWord => 'Salvează cuvântul';

  @override
  String get removeFromFavorites => 'Scoate din favorite';

  @override
  String get inPlainWords => 'pe scurt';

  @override
  String get theDefinition => 'definiția';

  @override
  String get inASentence => 'într-o propoziție';

  @override
  String get exampleGlossLabel => 'altfel spus';

  @override
  String get save => 'Salvează';

  @override
  String get saved => 'Salvat';

  @override
  String get copy => 'Copiază';

  @override
  String get copiedToClipboard => 'Copiat în clipboard';

  @override
  String get roots => 'rădăcini';

  @override
  String get quizTitle => 'Un chestionar mic';

  @override
  String get quizCaption => 'cunoaște rădăcinile, apoi alege înțelesul';

  @override
  String get quizIntro =>
      'Fiecare întrebare arată un cuvânt și etimologia lui. Alege definiția care se potrivește — patru alegeri, una adevărată.';

  @override
  String get howManyWords => 'câte cuvinte';

  @override
  String get begin => 'Începe';

  @override
  String get quizByTheme => 'Chestionar pe temă';

  @override
  String get endQuiz => 'Încheie chestionarul';

  @override
  String questionOf(int index, int length) {
    return 'Întrebarea $index din $length';
  }

  @override
  String get whichDefinitionFits => 'care definiție se potrivește?';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Următor';

  @override
  String get seeResults => 'Vezi rezultatele';

  @override
  String get themeTitle => 'Temă';

  @override
  String get chooseASubject => 'alege un subiect';

  @override
  String get noThemesYet => 'Nicio temă încă.';

  @override
  String get notEnoughWordsInTheme =>
      'Nu sunt încă destule cuvinte în această temă.';

  @override
  String get results => 'Rezultate';

  @override
  String get perfectPage => 'o pagină desăvârșită';

  @override
  String get wellMarked => 'bine însemnat';

  @override
  String get tryAnotherRound => 'Încearcă un alt tur';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiții corecte',
      one: '1 definiție corectă',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiții corecte, din $total.',
      one: 'O definiție corectă, din $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Treci la modul luminos';

  @override
  String get switchToDarkMode => 'Treci la modul întunecat';

  @override
  String get listen => 'Ascultă';

  @override
  String get stop => 'Oprește';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Limbi';

  @override
  String get languagesCaption => 'limbile';

  @override
  String get searchLanguages => 'Caută o țară sau o limbă…';

  @override
  String get noMatchingLanguages => 'Nicio țară sau limbă potrivită.';

  @override
  String get selectedLanguage => 'Citire în';

  @override
  String get continentAfrica => 'Africa';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Americi';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current din $total';
  }

  @override
  String speechAlso(String variants) {
    return 'De asemenea $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Ca în: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Din $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, înseamnă $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Pe scurt: $friendly';
  }

  @override
  String get categorySpeech => 'Vorbire și retorică';

  @override
  String get categoryCharacter => 'Caracter și temperament';

  @override
  String get categoryCriticism => 'Critică și insultă';

  @override
  String get categoryVirtue => 'Virtute';

  @override
  String get categoryVice => 'Viciu';

  @override
  String get categoryKnowledge => 'Cunoaștere și gând';

  @override
  String get categoryReligion => 'Religie și spirit';

  @override
  String get categoryBeginnings => 'Începuturi';

  @override
  String get categoryConflict => 'Conflict și înșelăciune';

  @override
  String get categoryAppearance => 'Înfățișare și lumină';

  @override
  String get categoryPeople => 'Oameni și roluri';

  @override
  String get categoryObjects => 'Obiecte și lucruri';

  @override
  String get categoryEmotion => 'Emoție';

  @override
  String get categoryArchaic => 'Vechi și arhaic';

  @override
  String get navStudy => 'Birou';

  @override
  String get studyTitle => 'Biroul de lucru';

  @override
  String get studyCaption => 'lectură, voce și lumină';

  @override
  String get readingSection => 'Lectură';

  @override
  String get readingCaption => 'cum se așază pagina';

  @override
  String get textSize => 'Mărimea textului';

  @override
  String get textSizeSample => 'Edulcorate — a îndulci, a înmuia.';

  @override
  String get smaller => 'Mai mic';

  @override
  String get larger => 'Mai mare';

  @override
  String get autoplayPronunciation =>
      'Citește cuvântul cu voce tare la deschidere';

  @override
  String get reduceMotion => 'Potolește ornamentele';

  @override
  String get reduceMotionCaption => 'mai puține înflorituri și degradeuri';

  @override
  String get voiceSection => 'Voce';

  @override
  String get voiceCaption => 'cum citește Gloss cu voce tare';

  @override
  String get chooseVoice => 'Voce';

  @override
  String get voiceDefault => 'Aleasă pentru tine';

  @override
  String get noOtherVoices =>
      'Nu există alte voci englezești instalate pe acest dispozitiv.';

  @override
  String get speechPace => 'Ritm';

  @override
  String get slower => 'Mai lent';

  @override
  String get faster => 'Mai repede';

  @override
  String get hearIt => 'Ascultă-l';

  @override
  String get lightSection => 'Lumină';

  @override
  String get lightCaption => 'pergament sau lumânare';

  @override
  String get themeSystem => 'Urmează dispozitivul';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Lumânare';

  @override
  String get tongueSection => 'Limbă';

  @override
  String get aboutSection => 'Despre';

  @override
  String get aboutCaption => 'cum a fost făcut';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licențe open source';

  @override
  String get shareGloss => 'Distribuie Gloss';

  @override
  String get followTheMaker => 'Urmărește autorul';

  @override
  String couldNotOpenLink(String label) {
    return 'Nu s-a putut deschide $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Citește explicațiile în $language';
  }

  @override
  String get readExplanationsCaption =>
      'Cuvântul în sine este citit întotdeauna în engleză.';

  @override
  String noVoiceInstalled(String language) {
    return 'Acest dispozitiv nu are o voce $language instalată.';
  }

  @override
  String get memorySection => 'Memorie';

  @override
  String get memoryCaption => 'ce păstrează Gloss';

  @override
  String get forgetProgress => 'Uită progresul meu';

  @override
  String get forgetProgressBody =>
      'Cuvintele pe care le-ai explorat nu vor mai fi marcate. Cuvintele salvate rămân.';

  @override
  String get clearSavedWords => 'Șterge cuvintele salvate';

  @override
  String get clearSavedWordsBody =>
      'Cuvintele pe care le-ai păstrat vor fi eliminate. Progresul tău rămâne.';

  @override
  String get cancel => 'Anulează';

  @override
  String get forget => 'Uită';

  @override
  String get clear => 'Șterge';

  @override
  String get progressForgotten => 'Progres uitat.';

  @override
  String get savedWordsCleared => 'Cuvinte salvate șterse.';
}
