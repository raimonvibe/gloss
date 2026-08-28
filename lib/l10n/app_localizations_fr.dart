// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un lexique de belle langue';

  @override
  String get navHome => 'Accueil';

  @override
  String get navLexicon => 'Lexique';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Enregistrés';

  @override
  String get navLanguages => 'Langues';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count mots rares et riches du lexique $lexicon — expliqués comme le ferait un ami, non un dictionnaire.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current mots explorés sur $total';
  }

  @override
  String get exploreLexicon => 'Parcourir le lexique';

  @override
  String get startQuiz => 'Commencer un quiz';

  @override
  String get wordOfTheDay => 'mot du jour';

  @override
  String get readFullEntry => 'Lire l’entrée entière →';

  @override
  String get lexiconTitle => 'Le lexique';

  @override
  String get lexiconCaption => 'le recueil';

  @override
  String get savedTitle => 'Mots enregistrés';

  @override
  String get savedCaption => 'tenus près';

  @override
  String get searchHint => 'Cherchez un mot, ou décrivez son sens…';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get filterAll => 'Tous';

  @override
  String get noMatches =>
      'Pas encore de correspondance — essayez un autre mot ou un autre sentiment.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n correspondances',
      one: '1 correspondance',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'rien ici';

  @override
  String get emptyLexicon => 'Rien dans ce coin du lexique.';

  @override
  String get emptySaved =>
      'Pas encore de mots enregistrés. Touchez le cœur sur une entrée.';

  @override
  String get tapToReadMore => 'Toucher pour lire davantage';

  @override
  String get saveWord => 'Enregistrer le mot';

  @override
  String get removeFromFavorites => 'Retirer des favoris';

  @override
  String get inPlainWords => 'en mots simples';

  @override
  String get theDefinition => 'la définition';

  @override
  String get inASentence => 'dans une phrase';

  @override
  String get exampleGlossLabel => 'autrement dit';

  @override
  String get save => 'Enregistrer';

  @override
  String get saved => 'Enregistré';

  @override
  String get copy => 'Copier';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papiers';

  @override
  String get roots => 'racines';

  @override
  String get quizTitle => 'Un petit quiz';

  @override
  String get quizCaption => 'connaître les racines, puis choisir le sens';

  @override
  String get quizIntro =>
      'Chaque question montre un mot et son étymologie. Choisissez la définition qui convient — quatre choix, un seul vrai.';

  @override
  String get howManyWords => 'combien de mots';

  @override
  String get begin => 'Commencer';

  @override
  String get quizByTheme => 'Quiz par thème';

  @override
  String get endQuiz => 'Terminer le quiz';

  @override
  String questionOf(int index, int length) {
    return 'Question $index sur $length';
  }

  @override
  String get whichDefinitionFits => 'quelle définition convient ?';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get seeResults => 'Voir les résultats';

  @override
  String get themeTitle => 'Thème';

  @override
  String get chooseASubject => 'choisir un sujet';

  @override
  String get noThemesYet => 'Pas encore de thèmes.';

  @override
  String get notEnoughWordsInTheme =>
      'Pas assez de mots dans ce thème pour l’instant.';

  @override
  String get results => 'Résultats';

  @override
  String get perfectPage => 'une page parfaite';

  @override
  String get wellMarked => 'bien marqué';

  @override
  String get tryAnotherRound => 'Tenter une autre manche';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score définitions justes',
      one: '1 définition juste',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score définitions justes, sur $total.',
      one: 'Une définition juste, sur $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Passer en mode clair';

  @override
  String get switchToDarkMode => 'Passer en mode sombre';

  @override
  String get listen => 'Écouter';

  @override
  String get stop => 'Arrêter';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Langues';

  @override
  String get languagesCaption => 'les langues';

  @override
  String get searchLanguages => 'Chercher un pays ou une langue…';

  @override
  String get noMatchingLanguages => 'Aucun pays ni langue correspondants.';

  @override
  String get selectedLanguage => 'Lecture en';

  @override
  String get continentAfrica => 'Afrique';

  @override
  String get continentAsia => 'Asie';

  @override
  String get continentEurope => 'Europe';

  @override
  String get continentAmericas => 'Amériques';

  @override
  String get continentOceania => 'Océanie';

  @override
  String currentOfTotal(int current, int total) {
    return '$current sur $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Aussi $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Comme dans : $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Du $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, sens $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'En mots simples : $friendly';
  }

  @override
  String get categorySpeech => 'Parole et rhétorique';

  @override
  String get categoryCharacter => 'Caractère et tempérament';

  @override
  String get categoryCriticism => 'Critique et insulte';

  @override
  String get categoryVirtue => 'Vertu';

  @override
  String get categoryVice => 'Vice';

  @override
  String get categoryKnowledge => 'Savoir et pensée';

  @override
  String get categoryReligion => 'Religion et esprit';

  @override
  String get categoryBeginnings => 'Commencements';

  @override
  String get categoryConflict => 'Conflit et tromperie';

  @override
  String get categoryAppearance => 'Apparence et lumière';

  @override
  String get categoryPeople => 'Gens et rôles';

  @override
  String get categoryObjects => 'Objets et choses';

  @override
  String get categoryEmotion => 'Émotion';

  @override
  String get categoryArchaic => 'Ancien et archaïque';

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
}

/// The translations for French, as used in Canada (`fr_CA`).
class AppLocalizationsFrCa extends AppLocalizationsFr {
  AppLocalizationsFrCa() : super('fr_CA');

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un lexique de belle langue';

  @override
  String get navHome => 'Accueil';

  @override
  String get navLexicon => 'Lexique';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Enregistrés';

  @override
  String get navLanguages => 'Langues';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count mots rares et riches du lexique $lexicon — expliqués comme le ferait un ami, pas un dictionnaire.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current mots parcourus sur $total';
  }

  @override
  String get exploreLexicon => 'Explorer le lexique';

  @override
  String get startQuiz => 'Lancer un quiz';

  @override
  String get wordOfTheDay => 'mot du jour';

  @override
  String get readFullEntry => 'Lire l’entrée au complet →';

  @override
  String get lexiconTitle => 'Le lexique';

  @override
  String get lexiconCaption => 'le recueil';

  @override
  String get savedTitle => 'Mots enregistrés';

  @override
  String get savedCaption => 'gardés près';

  @override
  String get searchHint => 'Cherchez un mot, ou décrivez-en le sens…';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get filterAll => 'Tous';

  @override
  String get noMatches =>
      'Pas encore de résultat — essayez un autre mot ou un autre sentiment.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n résultats',
      one: '1 résultat',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'rien ici';

  @override
  String get emptyLexicon => 'Rien dans ce coin du lexique.';

  @override
  String get emptySaved =>
      'Pas encore de mots enregistrés. Touchez le cœur sur n’importe quelle entrée.';

  @override
  String get tapToReadMore => 'Toucher pour en lire plus';

  @override
  String get saveWord => 'Enregistrer le mot';

  @override
  String get removeFromFavorites => 'Retirer des favoris';

  @override
  String get inPlainWords => 'en mots simples';

  @override
  String get theDefinition => 'la définition';

  @override
  String get inASentence => 'dans une phrase';

  @override
  String get exampleGlossLabel => 'en d’autres mots';

  @override
  String get save => 'Enregistrer';

  @override
  String get saved => 'Enregistré';

  @override
  String get copy => 'Copier';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papiers';

  @override
  String get roots => 'racines';

  @override
  String get quizTitle => 'Un petit quiz';

  @override
  String get quizCaption => 'connaître les racines, puis choisir le sens';

  @override
  String get quizIntro =>
      'Chaque question montre un mot et son étymologie. Choisissez la définition qui convient — quatre choix, un seul vrai.';

  @override
  String get howManyWords => 'combien de mots';

  @override
  String get begin => 'Commencer';

  @override
  String get quizByTheme => 'Quiz par thème';

  @override
  String get endQuiz => 'Terminer le quiz';

  @override
  String questionOf(int index, int length) {
    return 'Question $index de $length';
  }

  @override
  String get whichDefinitionFits => 'quelle définition convient ?';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get seeResults => 'Voir les résultats';

  @override
  String get themeTitle => 'Thème';

  @override
  String get chooseASubject => 'choisir un sujet';

  @override
  String get noThemesYet => 'Pas encore de thèmes.';

  @override
  String get notEnoughWordsInTheme =>
      'Pas assez de mots dans ce thème pour l’instant.';

  @override
  String get results => 'Résultats';

  @override
  String get perfectPage => 'une page parfaite';

  @override
  String get wellMarked => 'bien noté';

  @override
  String get tryAnotherRound => 'Essayer une autre ronde';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score définitions justes',
      one: '1 définition juste',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score définitions justes, sur $total.',
      one: 'Une définition juste, sur $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Passer en mode clair';

  @override
  String get switchToDarkMode => 'Passer en mode sombre';

  @override
  String get listen => 'Écouter';

  @override
  String get stop => 'Arrêter';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Langues';

  @override
  String get languagesCaption => 'les langues';

  @override
  String get searchLanguages => 'Chercher un pays ou une langue…';

  @override
  String get noMatchingLanguages => 'Aucun pays ni langue correspondants.';

  @override
  String get selectedLanguage => 'Lecture en';

  @override
  String get continentAfrica => 'Afrique';

  @override
  String get continentAsia => 'Asie';

  @override
  String get continentEurope => 'Europe';

  @override
  String get continentAmericas => 'Amériques';

  @override
  String get continentOceania => 'Océanie';

  @override
  String currentOfTotal(int current, int total) {
    return '$current de $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Aussi $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Comme dans : $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Du $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, sens $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'En mots simples : $friendly';
  }

  @override
  String get categorySpeech => 'Parole et rhétorique';

  @override
  String get categoryCharacter => 'Caractère et tempérament';

  @override
  String get categoryCriticism => 'Critique et insulte';

  @override
  String get categoryVirtue => 'Vertu';

  @override
  String get categoryVice => 'Vice';

  @override
  String get categoryKnowledge => 'Savoir et pensée';

  @override
  String get categoryReligion => 'Religion et esprit';

  @override
  String get categoryBeginnings => 'Commencements';

  @override
  String get categoryConflict => 'Conflit et tromperie';

  @override
  String get categoryAppearance => 'Apparence et lumière';

  @override
  String get categoryPeople => 'Gens et rôles';

  @override
  String get categoryObjects => 'Objets et choses';

  @override
  String get categoryEmotion => 'Émotion';

  @override
  String get categoryArchaic => 'Ancien et archaïque';
}
