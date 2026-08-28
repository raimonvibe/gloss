// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un léxico de lengua hermosa';

  @override
  String get navHome => 'Inicio';

  @override
  String get navLexicon => 'Léxico';

  @override
  String get navQuiz => 'Cuestionario';

  @override
  String get navSaved => 'Guardadas';

  @override
  String get navLanguages => 'Idiomas';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count palabras raras y ricas del léxico $lexicon — explicadas como lo haría un amigo, no un diccionario.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current de $total palabras exploradas';
  }

  @override
  String get exploreLexicon => 'Explorar el léxico';

  @override
  String get startQuiz => 'Empezar un cuestionario';

  @override
  String get wordOfTheDay => 'palabra del día';

  @override
  String get readFullEntry => 'Leer la entrada completa →';

  @override
  String get lexiconTitle => 'El léxico';

  @override
  String get lexiconCaption => 'la reunión';

  @override
  String get savedTitle => 'Palabras guardadas';

  @override
  String get savedCaption => 'cerca del corazón';

  @override
  String get searchHint => 'Busca una palabra, o describe su sentido…';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get filterAll => 'Todas';

  @override
  String get noMatches =>
      'Aún no hay coincidencias — prueba otra palabra o sentimiento.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n coincidencias',
      one: '1 coincidencia',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nada aquí';

  @override
  String get emptyLexicon => 'Nada en este rincón del léxico.';

  @override
  String get emptySaved =>
      'Aún no hay palabras guardadas. Pulsa el corazón en cualquier entrada.';

  @override
  String get tapToReadMore => 'Pulsa para leer más';

  @override
  String get saveWord => 'Guardar palabra';

  @override
  String get removeFromFavorites => 'Quitar de favoritos';

  @override
  String get inPlainWords => 'en palabras sencillas';

  @override
  String get theDefinition => 'la definición';

  @override
  String get inASentence => 'en una frase';

  @override
  String get exampleGlossLabel => 'dicho de otro modo';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardada';

  @override
  String get copy => 'Copiar';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get roots => 'raíces';

  @override
  String get quizTitle => 'Un pequeño cuestionario';

  @override
  String get quizCaption => 'conoce las raíces, luego elige el sentido';

  @override
  String get quizIntro =>
      'Cada pregunta muestra una palabra y su etimología. Elige la definición que encaja — cuatro opciones, una cierta.';

  @override
  String get howManyWords => 'cuántas palabras';

  @override
  String get begin => 'Empezar';

  @override
  String get quizByTheme => 'Cuestionario por tema';

  @override
  String get endQuiz => 'Terminar cuestionario';

  @override
  String questionOf(int index, int length) {
    return 'Pregunta $index de $length';
  }

  @override
  String get whichDefinitionFits => '¿qué definición encaja?';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Siguiente';

  @override
  String get seeResults => 'Ver resultados';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'elige un asunto';

  @override
  String get noThemesYet => 'Aún no hay temas.';

  @override
  String get notEnoughWordsInTheme =>
      'Aún no hay palabras suficientes en este tema.';

  @override
  String get results => 'Resultados';

  @override
  String get perfectPage => 'una página perfecta';

  @override
  String get wellMarked => 'bien anotado';

  @override
  String get tryAnotherRound => 'Probar otra ronda';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiciones acertadas',
      one: '1 definición acertada',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiciones acertadas, de $total.',
      one: 'Una definición acertada, de $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Cambiar a modo claro';

  @override
  String get switchToDarkMode => 'Cambiar a modo oscuro';

  @override
  String get listen => 'Escuchar';

  @override
  String get stop => 'Detener';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Idiomas';

  @override
  String get languagesCaption => 'las lenguas';

  @override
  String get searchLanguages => 'Busca un país o un idioma…';

  @override
  String get noMatchingLanguages => 'No hay países ni idiomas que coincidan.';

  @override
  String get selectedLanguage => 'Leyendo en';

  @override
  String get continentAfrica => 'África';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'América';

  @override
  String get continentOceania => 'Oceanía';

  @override
  String currentOfTotal(int current, int total) {
    return '$current de $total';
  }

  @override
  String speechAlso(String variants) {
    return 'También $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Como en: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Del $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, significado $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'En palabras sencillas: $friendly';
  }

  @override
  String get categorySpeech => 'Habla y retórica';

  @override
  String get categoryCharacter => 'Carácter y temperamento';

  @override
  String get categoryCriticism => 'Crítica e insulto';

  @override
  String get categoryVirtue => 'Virtud';

  @override
  String get categoryVice => 'Vicio';

  @override
  String get categoryKnowledge => 'Saber y pensamiento';

  @override
  String get categoryReligion => 'Religión y espíritu';

  @override
  String get categoryBeginnings => 'Comienzos';

  @override
  String get categoryConflict => 'Conflicto y engaño';

  @override
  String get categoryAppearance => 'Apariencia y luz';

  @override
  String get categoryPeople => 'Gentes y papeles';

  @override
  String get categoryObjects => 'Objetos y cosas';

  @override
  String get categoryEmotion => 'Emoción';

  @override
  String get categoryArchaic => 'Antiguo y arcaico';
}

/// The translations for Spanish Castilian, as used in Latin America and the Caribbean (`es_419`).
class AppLocalizationsEs419 extends AppLocalizationsEs {
  AppLocalizationsEs419() : super('es_419');

  @override
  String get appTitle => 'Gloss';

  @override
  String get tagline => 'un léxico de lenguaje hermoso';

  @override
  String get navHome => 'Inicio';

  @override
  String get navLexicon => 'Léxico';

  @override
  String get navQuiz => 'Quiz';

  @override
  String get navSaved => 'Guardadas';

  @override
  String get navLanguages => 'Idiomas';

  @override
  String homeBlurb(int count, String lexicon) {
    return '$count palabras raras y ricas del léxico $lexicon — explicadas como las explicaría un amigo, no un diccionario.';
  }

  @override
  String wordsExplored(int current, int total) {
    return '$current de $total palabras exploradas';
  }

  @override
  String get exploreLexicon => 'Explorar el léxico';

  @override
  String get startQuiz => 'Empezar un quiz';

  @override
  String get wordOfTheDay => 'palabra del día';

  @override
  String get readFullEntry => 'Leer la entrada completa →';

  @override
  String get lexiconTitle => 'El léxico';

  @override
  String get lexiconCaption => 'el encuentro';

  @override
  String get savedTitle => 'Palabras guardadas';

  @override
  String get savedCaption => 'bien cerca';

  @override
  String get searchHint => 'Busca una palabra, o describe su significado…';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get filterAll => 'Todas';

  @override
  String get noMatches =>
      'Aún no hay coincidencias — prueba otra palabra o sensación.';

  @override
  String matchCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n coincidencias',
      one: '1 coincidencia',
    );
    return '$_temp0';
  }

  @override
  String get nothingHere => 'nada por aquí';

  @override
  String get emptyLexicon => 'Nada en este rincón del léxico.';

  @override
  String get emptySaved =>
      'Aún no hay palabras guardadas. Toca el corazón en cualquier entrada.';

  @override
  String get tapToReadMore => 'Toca para leer más';

  @override
  String get saveWord => 'Guardar palabra';

  @override
  String get removeFromFavorites => 'Quitar de favoritos';

  @override
  String get inPlainWords => 'en palabras simples';

  @override
  String get theDefinition => 'la definición';

  @override
  String get inASentence => 'en una oración';

  @override
  String get exampleGlossLabel => 'en otras palabras';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardada';

  @override
  String get copy => 'Copiar';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get roots => 'raíces';

  @override
  String get quizTitle => 'Un quiz breve';

  @override
  String get quizCaption => 'conoce las raíces y luego elige el significado';

  @override
  String get quizIntro =>
      'Cada pregunta muestra una palabra y su etimología. Elige la definición que calza — cuatro opciones, una verdadera.';

  @override
  String get howManyWords => 'cuántas palabras';

  @override
  String get begin => 'Empezar';

  @override
  String get quizByTheme => 'Quiz por tema';

  @override
  String get endQuiz => 'Terminar quiz';

  @override
  String questionOf(int index, int length) {
    return 'Pregunta $index de $length';
  }

  @override
  String get whichDefinitionFits => '¿qué definición calza?';

  @override
  String get previous => 'Anterior';

  @override
  String get next => 'Siguiente';

  @override
  String get seeResults => 'Ver resultados';

  @override
  String get themeTitle => 'Tema';

  @override
  String get chooseASubject => 'elige un tema';

  @override
  String get noThemesYet => 'Aún no hay temas.';

  @override
  String get notEnoughWordsInTheme =>
      'Aún no hay suficientes palabras en este tema.';

  @override
  String get results => 'Resultados';

  @override
  String get perfectPage => 'una página perfecta';

  @override
  String get wellMarked => 'bien marcado';

  @override
  String get tryAnotherRound => 'Intentar otra ronda';

  @override
  String definitionsRight(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiciones correctas',
      one: '1 definición correcta',
    );
    return '$_temp0';
  }

  @override
  String definitionsRightSpoken(int score, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score definiciones correctas, de $total.',
      one: 'Una definición correcta, de $total.',
    );
    return '$_temp0';
  }

  @override
  String get switchToLightMode => 'Cambiar a modo claro';

  @override
  String get switchToDarkMode => 'Cambiar a modo oscuro';

  @override
  String get listen => 'Escuchar';

  @override
  String get stop => 'Detener';

  @override
  String get glossIcon => 'Gloss icon';

  @override
  String get languagesTitle => 'Idiomas';

  @override
  String get languagesCaption => 'las lenguas';

  @override
  String get searchLanguages => 'Busca un país o un idioma…';

  @override
  String get noMatchingLanguages => 'No hay países ni idiomas coincidentes.';

  @override
  String get selectedLanguage => 'Leyendo en';

  @override
  String get continentAfrica => 'África';

  @override
  String get continentAsia => 'Asia';

  @override
  String get continentEurope => 'Europa';

  @override
  String get continentAmericas => 'Américas';

  @override
  String get continentOceania => 'Oceanía';

  @override
  String currentOfTotal(int current, int total) {
    return '$current de $total';
  }

  @override
  String speechAlso(String variants) {
    return 'También $variants.';
  }

  @override
  String speechAsIn(String example) {
    return 'Como en: $example';
  }

  @override
  String speechFrom(String origin, String originWord) {
    return 'Del $origin, $originWord.';
  }

  @override
  String speechRoot(String form, String meaning) {
    return '$form, significado $meaning';
  }

  @override
  String speechInPlainWords(String friendly) {
    return 'En palabras simples: $friendly';
  }

  @override
  String get categorySpeech => 'Habla y retórica';

  @override
  String get categoryCharacter => 'Carácter y temperamento';

  @override
  String get categoryCriticism => 'Crítica e insulto';

  @override
  String get categoryVirtue => 'Virtud';

  @override
  String get categoryVice => 'Vicio';

  @override
  String get categoryKnowledge => 'Saber y pensamiento';

  @override
  String get categoryReligion => 'Religión y espíritu';

  @override
  String get categoryBeginnings => 'Comienzos';

  @override
  String get categoryConflict => 'Conflicto y engaño';

  @override
  String get categoryAppearance => 'Apariencia y luz';

  @override
  String get categoryPeople => 'Personas y roles';

  @override
  String get categoryObjects => 'Objetos y cosas';

  @override
  String get categoryEmotion => 'Emoción';

  @override
  String get categoryArchaic => 'Viejo y arcaico';
}
