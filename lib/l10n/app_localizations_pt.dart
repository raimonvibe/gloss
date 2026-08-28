// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'um léxico de língua bela';

  @override
  String get navHome => 'Início';

  @override
  String get navLexicon => 'Léxico';

  @override
  String get navQuiz => 'Questionário';

  @override
  String get navSaved => 'Guardadas';

  @override
  String get navLanguages => 'Línguas';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count palavras raras e ricas do léxico $lexicon — explicadas como um amigo as explicaria, não um dicionário.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current de $total palavras exploradas';
  }

  @override
  String get exploreLexicon => 'Explorar o léxico';

  @override
  String get startQuiz => 'Começar um questionário';

  @override
  String get wordOfTheDay => 'palavra do dia';

  @override
  String get readFullEntry => 'Ler a entrada completa →';

  @override
  String get lexiconTitle => 'O léxico';

  @override
  String get lexiconCaption => 'a recolha';

  @override
  String get savedTitle => 'Palavras guardadas';

  @override
  String get savedCaption => 'perto do coração';

  @override
  String get searchHint => 'Procure uma palavra, ou descreva o seu sentido…';

  @override
  String get clearSearch => 'Limpar pesquisa';

  @override
  String get filterAll => 'Todas';

  @override
  String get noMatches =>
      'Ainda sem correspondências — experimente outra palavra ou sentimento.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n correspondências',
      one: '1 correspondência',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nada aqui';

  @override
  String get emptyLexicon => 'Nada neste canto do léxico.';

  @override
  String get emptySaved =>
      'Ainda sem palavras guardadas. Toque no coração em qualquer entrada.';

  @override
  String get tapToReadMore => 'Toque para ler mais';

  @override
  String get saveWord => 'Guardar palavra';

  @override
  String get removeFromFavorites => 'Remover dos favoritos';

  @override
  String get inPlainWords => 'em palavras simples';

  @override
  String get theDefinition => 'a definição';

  @override
  String get inASentence => 'numa frase';

  @override
  String get exampleGlossLabel => 'por outras palavras';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardada';

  @override
  String get copy => 'Copiar';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get roots => 'raízes';

  @override
  String get quizTitle => 'Um pequeno questionário';

  @override
  String get quizCaption => 'conheça as raízes, depois escolha o sentido';

  @override
  String get quizIntro =>
      'Cada pergunta mostra uma palavra e a sua etimologia. Escolha a definição que serve — quatro opções, uma verdadeira.';

  @override
  String get howManyWords => 'quantas palavras';

  @override
  String get begin => 'Começar';

  @override
  String get quizByTheme => 'Questionário por tema';

  @override
  String get endQuiz => 'Terminar questionário';

  @override
  String questionOf(int index, int length) {
    return 'Pergunta $index de $length';
  }

  @override
  String get whichDefinitionFits => 'que definição serve?';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Seguinte';

  @override
  String get seeResults => 'Ver resultados';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'escolha um assunto';

  @override
  String get noThemesYet => 'Ainda sem temas.';

  @override
  String get notEnoughWordsInTheme =>
      'Ainda não há palavras suficientes neste tema.';

  @override
  String get results => 'Resultados';

  @override
  String get perfectPage => 'uma página perfeita';

  @override
  String get wellMarked => 'bem assinalado';

  @override
  String get tryAnotherRound => 'Tentar outra ronda';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definições certas',
      one: '1 definição certa',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definições certas, de $total.',
      one: 'Uma definição certa, de $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Mudar para o modo claro';

  @override
  String get switchToDarkMode => 'Mudar para o modo escuro';

  @override
  String get listen => 'Ouvir';

  @override
  String get stop => 'Parar';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Línguas';

  @override
  String get languagesCaption => 'as línguas';

  @override
  String get searchLanguages => 'Procure um país ou uma língua…';

  @override
  String get noMatchingLanguages =>
      'Não há países nem línguas correspondentes.';

  @override
  String get selectedLanguage => 'A ler em';

  @override
  String get continentAfrica => 'África';

  @override
  String get continentAsia => 'Ásia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Américas';

  @override
  String get continentOceania => 'Oceânia';

  @override
  String currentOfTotal(int current, int total) {
    return '$current de $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Também $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Como em: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Do $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, significado $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Em palavras simples: $friendly';
  }

  @override
  String get categorySpeech => 'Fala e retórica';

  @override
  String get categoryCharacter => 'Carácter e temperamento';

  @override
  String get categoryCriticism => 'Crítica e insulto';

  @override
  String get categoryVirtue => 'Virtude';

  @override
  String get categoryVice => 'Vício';

  @override
  String get categoryKnowledge => 'Saber e pensamento';

  @override
  String get categoryReligion => 'Religião e espírito';

  @override
  String get categoryBeginnings => 'Começos';

  @override
  String get categoryConflict => 'Conflito e engano';

  @override
  String get categoryAppearance => 'Aparência e luz';

  @override
  String get categoryPeople => 'Gentes e papéis';

  @override
  String get categoryObjects => 'Objectos e coisas';

  @override
  String get categoryEmotion => 'Emoção';

  @override
  String get categoryArchaic => 'Antigo e arcaico';

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

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'um léxico de linguagem bela';

  @override
  String get navHome => 'Início';

  @override
  String get navLexicon => 'Léxico';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Salvas';

  @override
  String get navLanguages => 'Idiomas';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count palavras raras e ricas do léxico $lexicon — explicadas como um amigo explicaria, não um dicionário.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current de $total palavras exploradas';
  }

  @override
  String get exploreLexicon => 'Explorar o léxico';

  @override
  String get startQuiz => 'Começar um quiz';

  @override
  String get wordOfTheDay => 'palavra do dia';

  @override
  String get readFullEntry => 'Ler a entrada completa →';

  @override
  String get lexiconTitle => 'O léxico';

  @override
  String get lexiconCaption => 'o ajuntamento';

  @override
  String get savedTitle => 'Palavras salvas';

  @override
  String get savedCaption => 'bem pertinho';

  @override
  String get searchHint => 'Busque uma palavra, ou descreva o significado…';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get filterAll => 'Todas';

  @override
  String get noMatches =>
      'Ainda sem correspondências — tente outra palavra ou sentimento.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n correspondências',
      one: '1 correspondência',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nada aqui';

  @override
  String get emptyLexicon => 'Nada neste canto do léxico.';

  @override
  String get emptySaved =>
      'Ainda sem palavras salvas. Toque no coração em qualquer entrada.';

  @override
  String get tapToReadMore => 'Toque para ler mais';

  @override
  String get saveWord => 'Salvar palavra';

  @override
  String get removeFromFavorites => 'Remover dos favoritos';

  @override
  String get inPlainWords => 'em palavras simples';

  @override
  String get theDefinition => 'a definição';

  @override
  String get inASentence => 'numa frase';

  @override
  String get exampleGlossLabel => 'em outras palavras';

  @override
  String get save => 'Salvar';

  @override
  String get saved => 'Salva';

  @override
  String get copy => 'Copiar';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência';

  @override
  String get roots => 'raízes';

  @override
  String get quizTitle => 'Um quizzinho';

  @override
  String get quizCaption => 'conheça as raízes e depois escolha o sentido';

  @override
  String get quizIntro =>
      'Cada pergunta mostra uma palavra e sua etimologia. Escolha a definição que cabe — quatro opções, uma verdadeira.';

  @override
  String get howManyWords => 'quantas palavras';

  @override
  String get begin => 'Começar';

  @override
  String get quizByTheme => 'Quiz por tema';

  @override
  String get endQuiz => 'Encerrar quiz';

  @override
  String questionOf(int index, int length) {
    return 'Pergunta $index de $length';
  }

  @override
  String get whichDefinitionFits => 'qual definição cabe?';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Próxima';

  @override
  String get seeResults => 'Ver resultados';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'escolha um assunto';

  @override
  String get noThemesYet => 'Ainda sem temas.';

  @override
  String get notEnoughWordsInTheme =>
      'Ainda não há palavras suficientes neste tema.';

  @override
  String get results => 'Resultados';

  @override
  String get perfectPage => 'uma página perfeita';

  @override
  String get wellMarked => 'bem marcado';

  @override
  String get tryAnotherRound => 'Tentar outra rodada';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definições certas',
      one: '1 definição certa',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definições certas, de $total.',
      one: 'Uma definição certa, de $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Mudar para o modo claro';

  @override
  String get switchToDarkMode => 'Mudar para o modo escuro';

  @override
  String get listen => 'Ouvir';

  @override
  String get stop => 'Parar';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Idiomas';

  @override
  String get languagesCaption => 'as línguas';

  @override
  String get searchLanguages => 'Busque um país ou um idioma…';

  @override
  String get noMatchingLanguages => 'Nenhum país ou idioma correspondente.';

  @override
  String get selectedLanguage => 'Lendo em';

  @override
  String get continentAfrica => 'África';

  @override
  String get continentAsia => 'Ásia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Américas';

  @override
  String get continentOceania => 'Oceania';

  @override
  String currentOfTotal(int current, int total) {
    return '$current de $total';
  }

  @override
  String speechAlso(String variants) {
    return 'Também $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Como em: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Do $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, significado $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'Em palavras simples: $friendly';
  }

  @override
  String get categorySpeech => 'Fala e retórica';

  @override
  String get categoryCharacter => 'Caráter e temperamento';

  @override
  String get categoryCriticism => 'Crítica e insulto';

  @override
  String get categoryVirtue => 'Virtude';

  @override
  String get categoryVice => 'Vício';

  @override
  String get categoryKnowledge => 'Saber e pensamento';

  @override
  String get categoryReligion => 'Religião e espírito';

  @override
  String get categoryBeginnings => 'Começos';

  @override
  String get categoryConflict => 'Conflito e engano';

  @override
  String get categoryAppearance => 'Aparência e luz';

  @override
  String get categoryPeople => 'Pessoas e papéis';

  @override
  String get categoryObjects => 'Objetos e coisas';

  @override
  String get categoryEmotion => 'Emoção';

  @override
  String get categoryArchaic => 'Antigo e arcaico';
}
