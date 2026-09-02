// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'et leksikon af yndig tale';

  @override
  String get navHome => 'Hjem';

  @override
  String get navLexicon => 'Leksikon';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Gemt';

  @override
  String get navLanguages => 'Sprog';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count sjældne, rige ord fra $lexicon-leksikonet — forklaret som en ven ville gøre det, ikke en ordbog.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current af $total ord udforsket';
  }

  @override
  String get exploreLexicon => 'Udforsk leksikonet';

  @override
  String get startQuiz => 'Start en quiz';

  @override
  String get wordOfTheDay => 'dagens ord';

  @override
  String get readFullEntry => 'Læs hele opslaget →';

  @override
  String get lexiconTitle => 'Leksikonet';

  @override
  String get lexiconCaption => 'samlingen';

  @override
  String get savedTitle => 'Gemte ord';

  @override
  String get savedCaption => 'holdt nær';

  @override
  String get searchHint => 'Søg et ord, eller beskriv dets betydning…';

  @override
  String get clearSearch => 'Ryd søgning';

  @override
  String get filterAll => 'Alle';

  @override
  String get noMatches =>
      'Ingen træffere endnu — prøv et andet ord eller en anden følelse.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n træffere',
      one: '1 træffer',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'intet her';

  @override
  String get emptyLexicon => 'Intet i denne krog af leksikonet.';

  @override
  String get emptySaved =>
      'Ingen gemte ord endnu. Tryk på hjertet ved et opslag.';

  @override
  String get tapToReadMore => 'Tryk for at læse mere';

  @override
  String get saveWord => 'Gem ord';

  @override
  String get removeFromFavorites => 'Fjern fra favoritter';

  @override
  String get inPlainWords => 'med enkle ord';

  @override
  String get theDefinition => 'definitionen';

  @override
  String get inASentence => 'i en sætning';

  @override
  String get exampleGlossLabel => 'med andre ord';

  @override
  String get save => 'Gem';

  @override
  String get saved => 'Gemt';

  @override
  String get copy => 'Kopiér';

  @override
  String get copiedToClipboard => 'Kopieret til udklipsholderen';

  @override
  String get roots => 'rødder';

  @override
  String get quizTitle => 'En lille quiz';

  @override
  String get quizCaption => 'kend rødderne, vælg så betydningen';

  @override
  String get quizIntro =>
      'Hvert spørgsmål viser et ord og dets etymologi. Vælg den definition, der passer — fire valg, ét sandt.';

  @override
  String get howManyWords => 'hvor mange ord';

  @override
  String get begin => 'Begynd';

  @override
  String get quizByTheme => 'Quiz efter tema';

  @override
  String get endQuiz => 'Afslut quiz';

  @override
  String questionOf(int index, int length) {
    return 'Spørgsmål $index af $length';
  }

  @override
  String get whichDefinitionFits => 'hvilken definition passer?';

  @override
  String get previous => 'Forrige';

  @override
  String get next => 'Næste';

  @override
  String get seeResults => 'Se resultater';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'vælg et emne';

  @override
  String get noThemesYet => 'Ingen temaer endnu.';

  @override
  String get notEnoughWordsInTheme => 'Ikke nok ord i dette tema endnu.';

  @override
  String get results => 'Resultater';

  @override
  String get perfectPage => 'en fuldkommen side';

  @override
  String get wellMarked => 'fint markeret';

  @override
  String get tryAnotherRound => 'Prøv en runde til';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score rigtige definitioner',
      one: '1 rigtig definition',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score rigtige definitioner, af $total.',
      one: 'Én rigtig definition, af $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Skift til lyst tema';

  @override
  String get switchToDarkMode => 'Skift til mørkt tema';

  @override
  String get listen => 'Lyt';

  @override
  String get stop => 'Stop';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Sprog';

  @override
  String get languagesCaption => 'tungerne';

  @override
  String get searchLanguages => 'Søg et land eller sprog…';

  @override
  String get noMatchingLanguages => 'Ingen matchende lande eller sprog.';

  @override
  String get selectedLanguage => 'Læser på';

  @override
  String get continentAfrica => 'Afrika';

  @override
  String get continentAsia => 'Asien';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Amerika';

  @override
  String get continentOceania => 'Oceanien';

  @override
  String currentOfTotal(int current, int total) {
    return '$current af $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Også $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Som i: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Fra $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, betydning $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Med enkle ord: $friendly';
  }

  @override
  String get categorySpeech => 'Tale & retorik';

  @override
  String get categoryCharacter => 'Karakter & temperament';

  @override
  String get categoryCriticism => 'Kritik & fornærmelse';

  @override
  String get categoryVirtue => 'Dyd';

  @override
  String get categoryVice => 'Last';

  @override
  String get categoryKnowledge => 'Viden & tanke';

  @override
  String get categoryReligion => 'Religion & ånd';

  @override
  String get categoryBeginnings => 'Begyndelser';

  @override
  String get categoryConflict => 'Konflikt & bedrag';

  @override
  String get categoryAppearance => 'Udseende & lys';

  @override
  String get categoryPeople => 'Mennesker & roller';

  @override
  String get categoryObjects => 'Genstande & ting';

  @override
  String get categoryEmotion => 'Følelse';

  @override
  String get categoryArchaic => 'Gammelt & arkaisk';

  @override
  String get navStudy => 'Studie';

  @override
  String get studyTitle => 'Studereværelset';

  @override
  String get studyCaption => 'læsning, stemme og lys';

  @override
  String get readingSection => 'Læsning';

  @override
  String get readingCaption => 'hvordan siden sidder';

  @override
  String get textSize => 'Tekststørrelse';

  @override
  String get textSizeSample => 'Edulcorate — at forsøde, at mildne.';

  @override
  String get smaller => 'Mindre';

  @override
  String get larger => 'Større';

  @override
  String get autoplayPronunciation => 'Læs et ord højt, når det åbnes';

  @override
  String get reduceMotion => 'Dæmp udsmykningen';

  @override
  String get reduceMotionCaption => 'færre kruseduller og farveovergange';

  @override
  String get voiceSection => 'Stemme';

  @override
  String get voiceCaption => 'hvordan Gloss læser højt';

  @override
  String get chooseVoice => 'Stemme';

  @override
  String get voiceDefault => 'Valgt til dig';

  @override
  String get noOtherVoices =>
      'Der er ikke installeret andre engelske stemmer på denne enhed.';

  @override
  String get speechPace => 'Tempo';

  @override
  String get slower => 'Langsommere';

  @override
  String get faster => 'Hurtigere';

  @override
  String get hearIt => 'Hør det';

  @override
  String get lightSection => 'Lys';

  @override
  String get lightCaption => 'pergament eller levende lys';

  @override
  String get themeSystem => 'Følg enheden';

  @override
  String get themeLight => 'Pergament';

  @override
  String get themeDark => 'Levende lys';

  @override
  String get tongueSection => 'Tunge';

  @override
  String get aboutSection => 'Om';

  @override
  String get aboutCaption => 'hvordan det blev til';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Open source-licenser';

  @override
  String get shareGloss => 'Del Gloss';

  @override
  String get followTheMaker => 'Følg skaberen';

  @override
  String couldNotOpenLink(String label) {
    return 'Kunne ikke åbne $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Læs forklaringer på $language';
  }

  @override
  String get readExplanationsCaption => 'Selve ordet læses altid på engelsk.';

  @override
  String noVoiceInstalled(String language) {
    return 'Denne enhed har ingen $language-stemme installeret.';
  }

  @override
  String get memorySection => 'Hukommelse';

  @override
  String get memoryCaption => 'hvad Gloss gemmer';

  @override
  String get forgetProgress => 'Glem mine fremskridt';

  @override
  String get forgetProgressBody =>
      'Ordene, du har udforsket, bliver afmærket. Dine gemte ord bliver.';

  @override
  String get clearSavedWords => 'Ryd gemte ord';

  @override
  String get clearSavedWordsBody =>
      'Ordene, du har gemt, bliver fjernet. Dine fremskridt bliver.';

  @override
  String get cancel => 'Annuller';

  @override
  String get forget => 'Glem';

  @override
  String get clear => 'Ryd';

  @override
  String get progressForgotten => 'Fremskridt glemt.';

  @override
  String get savedWordsCleared => 'Gemte ord ryddet.';

  @override
  String get contactTitle => 'Skriv til skaberen';

  @override
  String get contactCaption => 'et brev, hvis du vil';

  @override
  String get contactBlurb =>
      'Gloss er lavet af én person. Et ord du savner, en fejl du fandt, en linje du kunne lide — det hele lander på det samme skrivebord.';

  @override
  String get contactLetterSection => 'Brevet';

  @override
  String get contactName => 'Dit navn';

  @override
  String get contactNameHint => 'Navnet du skal hilses med';

  @override
  String get contactEmail => 'Din e-mail';

  @override
  String get contactEmailHint => 'Hvor et svar kan finde dig';

  @override
  String contactEmailTypo(String domain) {
    return 'Mente du $domain?';
  }

  @override
  String get contactReason => 'Grund til at skrive';

  @override
  String get reasonWord => 'Et ord til samlingen';

  @override
  String get reasonProblem => 'Noget er galt';

  @override
  String get reasonQuestion => 'Et spørgsmål';

  @override
  String get reasonPraise => 'Tilbagemelding';

  @override
  String get reasonOther => 'Noget andet';

  @override
  String get contactPriority => 'Hvor presserende';

  @override
  String get priorityLow => 'Lav';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Høj';

  @override
  String get contactMessage => 'Din besked';

  @override
  String get contactMessageHint =>
      'Skriv så meget eller så lidt, du har lyst til…';

  @override
  String get contactHumanCheck => 'Et ord, før du sender';

  @override
  String contactHumanQuestion(String word) {
    return 'Hvilken betydning hører til $word?';
  }

  @override
  String get contactHumanRetry => 'Ikke den. Her er et andet ord.';

  @override
  String get contactDetails => 'Send app-oplysninger med';

  @override
  String get contactDetailsCaption =>
      'Version, sprog, lys og tekststørrelse, så en fejl er lettere at finde.';

  @override
  String get contactSend => 'Send brevet';

  @override
  String get contactCopyLetter => 'Kopiér brevet';

  @override
  String get contactDraftRestored => 'Her lå et usendt brev.';

  @override
  String get contactNoMailApp =>
      'Ingen mailapp svarede, så brevet ligger i udklipsholderen.';

  @override
  String get contactNeedName => 'Et navn, så svaret ved, hvem det hilser på.';

  @override
  String get contactNeedEmail => 'En adresse, som et svar kan nå.';

  @override
  String get contactNeedMessage => 'Mindst en linje eller to.';

  @override
  String get contactSent => 'Dit brev er på vej. Tak.';

  @override
  String get contactSendFailed =>
      'Brevet kunne ikke sendes lige nu. Det ligger i udklipsholderen og bliver her.';

  @override
  String get contactSendByMail => 'Brug en mailapp i stedet';
}
