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
  String get navStudy => 'Cabinet';

  @override
  String get studyTitle => 'Le cabinet de travail';

  @override
  String get studyCaption => 'lecture, voix et lumière';

  @override
  String get readingSection => 'Lecture';

  @override
  String get readingCaption => 'comment la page se pose';

  @override
  String get textSize => 'Taille du texte';

  @override
  String get textSizeSample => 'Edulcorate — adoucir, édulcorer.';

  @override
  String get smaller => 'Plus petit';

  @override
  String get larger => 'Plus grand';

  @override
  String get autoplayPronunciation =>
      'Lire un mot à voix haute à son ouverture';

  @override
  String get reduceMotion => 'Apaiser les ornements';

  @override
  String get reduceMotionCaption => 'moins de fioritures et de dégradés';

  @override
  String get voiceSection => 'Voix';

  @override
  String get voiceCaption => 'comment Gloss lit à voix haute';

  @override
  String get chooseVoice => 'Voix';

  @override
  String get voiceDefault => 'Choisie pour vous';

  @override
  String get noOtherVoices =>
      'Aucune autre voix anglaise n\'est installée sur cet appareil.';

  @override
  String get speechPace => 'Allure';

  @override
  String get slower => 'Plus lent';

  @override
  String get faster => 'Plus vite';

  @override
  String get hearIt => 'L\'entendre';

  @override
  String get lightSection => 'Lumière';

  @override
  String get lightCaption => 'parchemin ou chandelle';

  @override
  String get themeSystem => 'Suivre l\'appareil';

  @override
  String get themeLight => 'Parchemin';

  @override
  String get themeDark => 'Chandelle';

  @override
  String get tongueSection => 'Langue';

  @override
  String get aboutSection => 'À propos';

  @override
  String get aboutCaption => 'comment il fut fait';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licences open source';

  @override
  String get shareGloss => 'Partager Gloss';

  @override
  String get followTheMaker => 'Suivre l\'auteur';

  @override
  String couldNotOpenLink(String label) {
    return 'Impossible d\'ouvrir $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Lire les explications en $language';
  }

  @override
  String get readExplanationsCaption =>
      'Le mot lui-même est toujours lu en anglais.';

  @override
  String noVoiceInstalled(String language) {
    return 'Cet appareil n\'a aucune voix $language installée.';
  }

  @override
  String get memorySection => 'Mémoire';

  @override
  String get memoryCaption => 'ce que Gloss retient';

  @override
  String get forgetProgress => 'Oublier ma progression';

  @override
  String get forgetProgressBody =>
      'Les mots que vous avez explorés ne seront plus marqués. Vos mots gardés restent.';

  @override
  String get clearSavedWords => 'Effacer les mots gardés';

  @override
  String get clearSavedWordsBody =>
      'Les mots que vous avez gardés seront retirés. Votre progression reste.';

  @override
  String get cancel => 'Annuler';

  @override
  String get forget => 'Oublier';

  @override
  String get clear => 'Effacer';

  @override
  String get progressForgotten => 'Progression oubliée.';

  @override
  String get savedWordsCleared => 'Mots gardés effacés.';

  @override
  String get contactTitle => 'Écrire à l\'auteur';

  @override
  String get contactCaption => 'une lettre, si vous voulez';

  @override
  String get contactBlurb =>
      'Gloss est fait par une seule personne. Un mot qui vous manque, une erreur que vous avez trouvée, une phrase qui vous a plu — tout arrive sur le même bureau.';

  @override
  String get contactLetterSection => 'La lettre';

  @override
  String get contactName => 'Votre nom';

  @override
  String get contactNameHint => 'Le nom par lequel vous saluer';

  @override
  String get contactEmail => 'Votre adresse e-mail';

  @override
  String get contactEmailHint => 'Où une réponse peut vous trouver';

  @override
  String contactEmailTypo(String domain) {
    return 'Vouliez-vous dire $domain ?';
  }

  @override
  String get contactReason => 'Motif du message';

  @override
  String get reasonWord => 'Un mot à ajouter';

  @override
  String get reasonProblem => 'Quelque chose ne va pas';

  @override
  String get reasonQuestion => 'Une question';

  @override
  String get reasonPraise => 'Retour';

  @override
  String get reasonOther => 'Autre chose';

  @override
  String get contactPriority => 'Degré d\'urgence';

  @override
  String get priorityLow => 'Faible';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Élevé';

  @override
  String get contactMessage => 'Votre message';

  @override
  String get contactMessageHint =>
      'Écrivez autant ou aussi peu que vous voulez…';

  @override
  String get contactHumanCheck => 'Un mot avant d\'envoyer';

  @override
  String contactHumanQuestion(String word) {
    return 'Quel sens appartient à $word ?';
  }

  @override
  String get contactHumanRetry => 'Pas celui-là. Voici un autre mot.';

  @override
  String get contactDetails => 'Joindre les détails de l\'app';

  @override
  String get contactDetailsCaption =>
      'Version, langue, lumière et taille du texte, pour retrouver une erreur plus vite.';

  @override
  String get contactSend => 'Envoyer la lettre';

  @override
  String get contactCopyLetter => 'Copier la lettre';

  @override
  String get contactDraftRestored => 'Une lettre non envoyée attendait ici.';

  @override
  String get contactNoMailApp =>
      'Aucune application de courrier n\'a répondu ; la lettre est dans le presse-papiers.';

  @override
  String get contactNeedName => 'Un nom, pour que la réponse sache qui saluer.';

  @override
  String get contactNeedEmail => 'Une adresse qu\'une réponse peut atteindre.';

  @override
  String get contactNeedMessage => 'Une ligne ou deux, au moins.';

  @override
  String get contactSent => 'Votre lettre est en route. Merci.';

  @override
  String get contactSendFailed =>
      'La lettre n\'a pas pu être envoyée pour l\'instant. Elle est dans le presse-papiers et reste ici.';

  @override
  String get contactSendByMail => 'Utiliser plutôt une application de courrier';
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

  @override
  String get navStudy => 'Cabinet';

  @override
  String get studyTitle => 'Le cabinet de travail';

  @override
  String get studyCaption => 'lecture, voix et lumière';

  @override
  String get readingSection => 'Lecture';

  @override
  String get readingCaption => 'comment la page se pose';

  @override
  String get textSize => 'Taille du texte';

  @override
  String get textSizeSample => 'Edulcorate — adoucir, édulcorer.';

  @override
  String get smaller => 'Plus petit';

  @override
  String get larger => 'Plus grand';

  @override
  String get autoplayPronunciation =>
      'Lire un mot à voix haute à son ouverture';

  @override
  String get reduceMotion => 'Apaiser les ornements';

  @override
  String get reduceMotionCaption => 'moins de fioritures et de dégradés';

  @override
  String get voiceSection => 'Voix';

  @override
  String get voiceCaption => 'comment Gloss lit à voix haute';

  @override
  String get chooseVoice => 'Voix';

  @override
  String get voiceDefault => 'Choisie pour vous';

  @override
  String get noOtherVoices =>
      'Aucune autre voix anglaise n\'est installée sur cet appareil.';

  @override
  String get speechPace => 'Allure';

  @override
  String get slower => 'Plus lent';

  @override
  String get faster => 'Plus vite';

  @override
  String get hearIt => 'L\'entendre';

  @override
  String get lightSection => 'Lumière';

  @override
  String get lightCaption => 'parchemin ou chandelle';

  @override
  String get themeSystem => 'Suivre l\'appareil';

  @override
  String get themeLight => 'Parchemin';

  @override
  String get themeDark => 'Chandelle';

  @override
  String get tongueSection => 'Langue';

  @override
  String get aboutSection => 'À propos';

  @override
  String get aboutCaption => 'comment il fut fait';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licences à code ouvert';

  @override
  String get shareGloss => 'Partager Gloss';

  @override
  String get followTheMaker => 'Suivre l\'auteur';

  @override
  String couldNotOpenLink(String label) {
    return 'Impossible d\'ouvrir $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Lire les explications en $language';
  }

  @override
  String get readExplanationsCaption =>
      'Le mot lui-même est toujours lu en anglais.';

  @override
  String noVoiceInstalled(String language) {
    return 'Cet appareil n\'a aucune voix $language installée.';
  }

  @override
  String get memorySection => 'Mémoire';

  @override
  String get memoryCaption => 'ce que Gloss retient';

  @override
  String get forgetProgress => 'Oublier ma progression';

  @override
  String get forgetProgressBody =>
      'Les mots que vous avez explorés ne seront plus marqués. Vos mots gardés restent.';

  @override
  String get clearSavedWords => 'Effacer les mots gardés';

  @override
  String get clearSavedWordsBody =>
      'Les mots que vous avez gardés seront retirés. Votre progression reste.';

  @override
  String get cancel => 'Annuler';

  @override
  String get forget => 'Oublier';

  @override
  String get clear => 'Effacer';

  @override
  String get progressForgotten => 'Progression oubliée.';

  @override
  String get savedWordsCleared => 'Mots gardés effacés.';

  @override
  String get contactTitle => 'Écrire à l\'auteur';

  @override
  String get contactCaption => 'une lettre, si vous voulez';

  @override
  String get contactBlurb =>
      'Gloss est fait par une seule personne. Un mot qui vous manque, une erreur que vous avez trouvée, une phrase qui vous a plu — tout arrive sur le même bureau.';

  @override
  String get contactLetterSection => 'La lettre';

  @override
  String get contactName => 'Votre nom';

  @override
  String get contactNameHint => 'Le nom par lequel vous saluer';

  @override
  String get contactEmail => 'Votre courriel';

  @override
  String get contactEmailHint => 'Où une réponse peut vous trouver';

  @override
  String contactEmailTypo(String domain) {
    return 'Vouliez-vous dire $domain ?';
  }

  @override
  String get contactReason => 'Motif du message';

  @override
  String get reasonWord => 'Un mot à ajouter';

  @override
  String get reasonProblem => 'Quelque chose ne va pas';

  @override
  String get reasonQuestion => 'Une question';

  @override
  String get reasonPraise => 'Commentaires';

  @override
  String get reasonOther => 'Autre chose';

  @override
  String get contactPriority => 'Degré d\'urgence';

  @override
  String get priorityLow => 'Faible';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Élevé';

  @override
  String get contactMessage => 'Votre message';

  @override
  String get contactMessageHint =>
      'Écrivez autant ou aussi peu que vous voulez…';

  @override
  String get contactHumanCheck => 'Un mot avant d\'envoyer';

  @override
  String contactHumanQuestion(String word) {
    return 'Quel sens appartient à $word ?';
  }

  @override
  String get contactHumanRetry => 'Pas celui-là. Voici un autre mot.';

  @override
  String get contactDetails => 'Joindre les détails de l\'appli';

  @override
  String get contactDetailsCaption =>
      'Version, langue, lumière et taille du texte, pour retrouver une erreur plus vite.';

  @override
  String get contactSend => 'Envoyer la lettre';

  @override
  String get contactCopyLetter => 'Copier la lettre';

  @override
  String get contactDraftRestored => 'Une lettre non envoyée attendait ici.';

  @override
  String get contactNoMailApp =>
      'Aucune application de courriel n\'a répondu ; la lettre est dans le presse-papiers.';

  @override
  String get contactNeedName => 'Un nom, pour que la réponse sache qui saluer.';

  @override
  String get contactNeedEmail => 'Une adresse qu\'une réponse peut atteindre.';

  @override
  String get contactNeedMessage => 'Une ligne ou deux, au moins.';

  @override
  String get contactSent => 'Votre lettre est en route. Merci.';

  @override
  String get contactSendFailed =>
      'La lettre n\'a pas pu être envoyée pour l\'instant. Elle est dans le presse-papiers et reste ici.';

  @override
  String get contactSendByMail => 'Utiliser plutôt une application de courriel';
}
