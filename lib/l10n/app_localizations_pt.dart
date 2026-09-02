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
  String get navStudy => 'Gabinete';

  @override
  String get studyTitle => 'O gabinete';

  @override
  String get studyCaption => 'leitura, voz e luz';

  @override
  String get readingSection => 'Leitura';

  @override
  String get readingCaption => 'como a página assenta';

  @override
  String get textSize => 'Tamanho do texto';

  @override
  String get textSizeSample => 'Edulcorate — adoçar, suavizar.';

  @override
  String get smaller => 'Menor';

  @override
  String get larger => 'Maior';

  @override
  String get autoplayPronunciation => 'Ler a palavra em voz alta ao abrir';

  @override
  String get reduceMotion => 'Acalmar os ornamentos';

  @override
  String get reduceMotionCaption => 'menos floreados e gradientes';

  @override
  String get voiceSection => 'Voz';

  @override
  String get voiceCaption => 'como Gloss lê em voz alta';

  @override
  String get chooseVoice => 'Voz';

  @override
  String get voiceDefault => 'Escolhida para si';

  @override
  String get noOtherVoices =>
      'Não há outras vozes em inglês instaladas neste dispositivo.';

  @override
  String get speechPace => 'Ritmo';

  @override
  String get slower => 'Mais lento';

  @override
  String get faster => 'Mais rápido';

  @override
  String get hearIt => 'Ouvir';

  @override
  String get lightSection => 'Luz';

  @override
  String get lightCaption => 'pergaminho ou luz de vela';

  @override
  String get themeSystem => 'Seguir o dispositivo';

  @override
  String get themeLight => 'Pergaminho';

  @override
  String get themeDark => 'Luz de vela';

  @override
  String get tongueSection => 'Língua';

  @override
  String get aboutSection => 'Sobre';

  @override
  String get aboutCaption => 'como foi feito';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licenças de código aberto';

  @override
  String get shareGloss => 'Partilhar Gloss';

  @override
  String get followTheMaker => 'Siga o autor';

  @override
  String couldNotOpenLink(String label) {
    return 'Não foi possível abrir $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Ler as explicações em $language';
  }

  @override
  String get readExplanationsCaption =>
      'A palavra em si é sempre lida em inglês.';

  @override
  String noVoiceInstalled(String language) {
    return 'Este dispositivo não tem uma voz em $language instalada.';
  }

  @override
  String get memorySection => 'Memória';

  @override
  String get memoryCaption => 'o que o Gloss guarda';

  @override
  String get forgetProgress => 'Esquecer o meu progresso';

  @override
  String get forgetProgressBody =>
      'As palavras que explorou deixarão de estar assinaladas. As palavras guardadas ficam.';

  @override
  String get clearSavedWords => 'Limpar palavras guardadas';

  @override
  String get clearSavedWordsBody =>
      'As palavras que guardou serão removidas. O seu progresso fica.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get forget => 'Esquecer';

  @override
  String get clear => 'Limpar';

  @override
  String get progressForgotten => 'Progresso esquecido.';

  @override
  String get savedWordsCleared => 'Palavras guardadas limpas.';

  @override
  String get contactTitle => 'Escreve ao autor';

  @override
  String get contactCaption => 'uma carta, se quiseres';

  @override
  String get contactBlurb =>
      'O Gloss é feito por uma só pessoa. Uma palavra que te falta, um erro que encontraste, uma linha de que gostaste — tudo chega à mesma secretária.';

  @override
  String get contactLetterSection => 'A carta';

  @override
  String get contactName => 'O teu nome';

  @override
  String get contactNameHint => 'O nome com que te saudar';

  @override
  String get contactEmail => 'O teu e-mail';

  @override
  String get contactEmailHint => 'Onde uma resposta te pode encontrar';

  @override
  String contactEmailTypo(String domain) {
    return 'Querias dizer $domain?';
  }

  @override
  String get contactReason => 'Motivo da mensagem';

  @override
  String get reasonWord => 'Uma palavra a acrescentar';

  @override
  String get reasonProblem => 'Algo está errado';

  @override
  String get reasonQuestion => 'Uma pergunta';

  @override
  String get reasonPraise => 'Comentários';

  @override
  String get reasonOther => 'Outra coisa';

  @override
  String get contactPriority => 'Que urgência tem';

  @override
  String get priorityLow => 'Baixa';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get contactMessage => 'A tua mensagem';

  @override
  String get contactMessageHint =>
      'Escreve tanto ou tão pouco quanto quiseres…';

  @override
  String get contactHumanCheck => 'Uma palavra antes de enviares';

  @override
  String contactHumanQuestion(String word) {
    return 'Que significado pertence a $word?';
  }

  @override
  String get contactHumanRetry => 'Esse não. Aqui vai outra palavra.';

  @override
  String get contactDetails => 'Incluir dados da aplicação';

  @override
  String get contactDetailsCaption =>
      'Versão, idioma, luz e tamanho do texto, para um erro se encontrar mais depressa.';

  @override
  String get contactSend => 'Enviar a carta';

  @override
  String get contactCopyLetter => 'Copiar a carta';

  @override
  String get contactDraftRestored => 'Estava aqui uma carta por enviar.';

  @override
  String get contactNoMailApp =>
      'Nenhuma aplicação de correio respondeu, por isso a carta ficou na área de transferência.';

  @override
  String get contactNeedName =>
      'Um nome, para a resposta saber a quem se dirige.';

  @override
  String get contactNeedEmail => 'Um endereço que uma resposta possa alcançar.';

  @override
  String get contactNeedMessage => 'Uma linha ou duas, pelo menos.';

  @override
  String get contactSent => 'A tua carta vai a caminho. Obrigado.';

  @override
  String get contactSendFailed =>
      'A carta não pôde ser enviada agora. Está na área de transferência e fica guardada aqui.';

  @override
  String get contactSendByMail => 'Usar antes uma aplicação de correio';
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

  @override
  String get navStudy => 'Gabinete';

  @override
  String get studyTitle => 'O gabinete';

  @override
  String get studyCaption => 'leitura, voz e luz';

  @override
  String get readingSection => 'Leitura';

  @override
  String get readingCaption => 'como a página se assenta';

  @override
  String get textSize => 'Tamanho do texto';

  @override
  String get textSizeSample => 'Edulcorate — adoçar, suavizar.';

  @override
  String get smaller => 'Menor';

  @override
  String get larger => 'Maior';

  @override
  String get autoplayPronunciation => 'Ler a palavra em voz alta ao abrir';

  @override
  String get reduceMotion => 'Acalmar os ornamentos';

  @override
  String get reduceMotionCaption => 'menos floreios e gradientes';

  @override
  String get voiceSection => 'Voz';

  @override
  String get voiceCaption => 'como Gloss lê em voz alta';

  @override
  String get chooseVoice => 'Voz';

  @override
  String get voiceDefault => 'Escolhida para você';

  @override
  String get noOtherVoices =>
      'Não há outras vozes em inglês instaladas neste dispositivo.';

  @override
  String get speechPace => 'Ritmo';

  @override
  String get slower => 'Mais lento';

  @override
  String get faster => 'Mais rápido';

  @override
  String get hearIt => 'Ouvir';

  @override
  String get lightSection => 'Luz';

  @override
  String get lightCaption => 'pergaminho ou luz de vela';

  @override
  String get themeSystem => 'Seguir o dispositivo';

  @override
  String get themeLight => 'Pergaminho';

  @override
  String get themeDark => 'Luz de vela';

  @override
  String get tongueSection => 'Língua';

  @override
  String get aboutSection => 'Sobre';

  @override
  String get aboutCaption => 'como foi feito';

  @override
  String versionLine(String version) {
    return 'Gloss $version';
  }

  @override
  String get openLicences => 'Licenças de código aberto';

  @override
  String get shareGloss => 'Compartilhar Gloss';

  @override
  String get followTheMaker => 'Siga o autor';

  @override
  String couldNotOpenLink(String label) {
    return 'Não foi possível abrir $label.';
  }

  @override
  String readExplanationsIn(String language) {
    return 'Ler as explicações em $language';
  }

  @override
  String get readExplanationsCaption =>
      'A palavra em si é sempre lida em inglês.';

  @override
  String noVoiceInstalled(String language) {
    return 'Este dispositivo não tem uma voz em $language instalada.';
  }

  @override
  String get memorySection => 'Memória';

  @override
  String get memoryCaption => 'o que o Gloss guarda';

  @override
  String get forgetProgress => 'Esquecer meu progresso';

  @override
  String get forgetProgressBody =>
      'As palavras que você explorou deixarão de estar marcadas. Suas palavras salvas ficam.';

  @override
  String get clearSavedWords => 'Limpar palavras salvas';

  @override
  String get clearSavedWordsBody =>
      'As palavras que você guardou serão removidas. Seu progresso fica.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get forget => 'Esquecer';

  @override
  String get clear => 'Limpar';

  @override
  String get progressForgotten => 'Progresso esquecido.';

  @override
  String get savedWordsCleared => 'Palavras salvas limpas.';

  @override
  String get contactTitle => 'Escreva para o autor';

  @override
  String get contactCaption => 'uma carta, se quiser';

  @override
  String get contactBlurb =>
      'O Gloss é feito por uma só pessoa. Uma palavra que faltou, um erro que você achou, uma linha de que gostou — tudo chega à mesma mesa.';

  @override
  String get contactLetterSection => 'A carta';

  @override
  String get contactName => 'Seu nome';

  @override
  String get contactNameHint => 'O nome com que cumprimentar você';

  @override
  String get contactEmail => 'Seu e-mail';

  @override
  String get contactEmailHint => 'Onde uma resposta pode encontrar você';

  @override
  String contactEmailTypo(String domain) {
    return 'Você quis dizer $domain?';
  }

  @override
  String get contactReason => 'Motivo da mensagem';

  @override
  String get reasonWord => 'Uma palavra para acrescentar';

  @override
  String get reasonProblem => 'Algo está errado';

  @override
  String get reasonQuestion => 'Uma pergunta';

  @override
  String get reasonPraise => 'Comentários';

  @override
  String get reasonOther => 'Outra coisa';

  @override
  String get contactPriority => 'Qual a urgência';

  @override
  String get priorityLow => 'Baixa';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get contactMessage => 'Sua mensagem';

  @override
  String get contactMessageHint => 'Escreva tanto ou tão pouco quanto quiser…';

  @override
  String get contactHumanCheck => 'Uma palavra antes de enviar';

  @override
  String contactHumanQuestion(String word) {
    return 'Qual significado pertence a $word?';
  }

  @override
  String get contactHumanRetry => 'Esse não. Aqui vai outra palavra.';

  @override
  String get contactDetails => 'Incluir dados do aplicativo';

  @override
  String get contactDetailsCaption =>
      'Versão, idioma, luz e tamanho do texto, para um erro ser achado mais rápido.';

  @override
  String get contactSend => 'Enviar a carta';

  @override
  String get contactCopyLetter => 'Copiar a carta';

  @override
  String get contactDraftRestored => 'Havia aqui uma carta não enviada.';

  @override
  String get contactNoMailApp =>
      'Nenhum aplicativo de e-mail respondeu, então a carta ficou na área de transferência.';

  @override
  String get contactNeedName =>
      'Um nome, para a resposta saber a quem cumprimentar.';

  @override
  String get contactNeedEmail => 'Um endereço que uma resposta possa alcançar.';

  @override
  String get contactNeedMessage => 'Uma linha ou duas, pelo menos.';

  @override
  String get contactSent => 'Sua carta está a caminho. Obrigado.';

  @override
  String get contactSendFailed =>
      'A carta não pôde ser enviada agora. Está na área de transferência e fica guardada aqui.';

  @override
  String get contactSendByMail => 'Usar um aplicativo de e-mail';
}
