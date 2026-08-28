import '../l10n/speech_templates.dart';

class WordRoot {
  const WordRoot({required this.form, required this.meaning});

  final String form;
  final String meaning;

  factory WordRoot.fromJson(Map<String, dynamic> json) {
    return WordRoot(
      form: json['form'] as String,
      meaning: json['meaning'] as String,
    );
  }

  WordRoot withMeaning(String meaning) => WordRoot(form: form, meaning: meaning);
}

class WordOverlay {
  const WordOverlay({
    this.partOfSpeech,
    this.definition,
    this.friendly,
    this.exampleGloss,
    this.origin,
    this.rootMeanings = const [],
  });

  final String? partOfSpeech;
  final String? definition;
  final String? friendly;
  final String? exampleGloss;
  final String? origin;
  final List<String> rootMeanings;

  factory WordOverlay.fromJson(Map<String, dynamic> json) {
    return WordOverlay(
      partOfSpeech: json['partOfSpeech'] as String?,
      definition: json['definition'] as String?,
      friendly: json['friendly'] as String?,
      exampleGloss: json['exampleGloss'] as String?,
      origin: json['origin'] as String?,
      rootMeanings: (json['rootMeanings'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class WordEntry {
  const WordEntry({
    required this.id,
    required this.word,
    required this.partOfSpeech,
    required this.pronunciation,
    required this.definition,
    required this.friendly,
    required this.example,
    required this.tags,
    required this.origin,
    required this.originWord,
    required this.roots,
    this.variants = const [],
    this.exampleGloss,
  });

  final String id;
  final String word;
  final List<String> variants;
  final String partOfSpeech;
  final String pronunciation;
  final String definition;
  final String friendly;
  final String example;
  final String? exampleGloss;
  final List<String> tags;
  final String origin;
  final String originWord;
  final List<WordRoot> roots;

  factory WordEntry.fromJson(Map<String, dynamic> json) {
    return WordEntry(
      id: json['id'] as String,
      word: json['word'] as String,
      variants: (json['variants'] as List<dynamic>? ?? const [])
          .map((e) => e as String)
          .toList(),
      partOfSpeech: json['partOfSpeech'] as String,
      pronunciation: json['pronunciation'] as String,
      definition: json['definition'] as String,
      friendly: json['friendly'] as String,
      example: json['example'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      origin: json['origin'] as String,
      originWord: json['originWord'] as String,
      roots: (json['roots'] as List<dynamic>)
          .map((e) => WordRoot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  WordEntry withOverlay(WordOverlay? overlay) {
    if (overlay == null) return this;
    final meanings = overlay.rootMeanings;
    return WordEntry(
      id: id,
      word: word,
      variants: variants,
      partOfSpeech: overlay.partOfSpeech ?? partOfSpeech,
      pronunciation: pronunciation,
      definition: overlay.definition ?? definition,
      friendly: overlay.friendly ?? friendly,
      example: example,
      exampleGloss: overlay.exampleGloss ?? exampleGloss,
      tags: tags,
      origin: overlay.origin ?? origin,
      originWord: originWord,
      roots: [
        for (var i = 0; i < roots.length; i++)
          roots[i].withMeaning(
            i < meanings.length ? meanings[i] : roots[i].meaning,
          ),
      ],
    );
  }

  String get searchable {
    return [
      word,
      ...variants,
      partOfSpeech,
      pronunciation,
      definition,
      friendly,
      example,
      if (exampleGloss != null) exampleGloss!,
      origin,
      originWord,
      ...tags,
      ...roots.expand((r) => [r.form, r.meaning]),
    ].join(' ').toLowerCase();
  }

  /// Hyphens in respellings make TTS pause; spaces read more naturally.
  String get spokenPronunciation => pronunciation.replaceAll('-', ' ');

  String get spokenWord => '$word. $spokenPronunciation.';

  String get spokenGlance => spokenGlanceWith(SpeechTemplates.english);

  String spokenGlanceWith(SpeechTemplates templates) =>
      '$spokenWord $friendly';

  String get spokenEntry => spokenEntryWith(SpeechTemplates.english);

  String spokenEntryWith(SpeechTemplates templates) {
    final also =
        variants.isEmpty ? '' : ' ${templates.also(variants.join(', '))}';
    return '$spokenWord $partOfSpeech.$also $friendly $definition ${templates.asIn(example)}';
  }

  String get spokenPrompt => spokenPromptWith(SpeechTemplates.english);

  String spokenPromptWith(SpeechTemplates templates) {
    final rootLine = roots
        .map((r) => templates.rootMeaning(r.form, r.meaning))
        .join('. ');
    final rootsPart = rootLine.isEmpty ? '' : ' $rootLine.';
    return '$spokenWord ${templates.fromOrigin(origin, originWord)}$rootsPart';
  }

  String spokenQuiz({required bool revealed, SpeechTemplates? templates}) {
    final copy = templates ?? SpeechTemplates.english;
    if (!revealed) return spokenPromptWith(copy);
    return '${spokenPromptWith(copy)} ${copy.inPlainWords(friendly)}';
  }
}

class WordCategory {
  const WordCategory({required this.id, required this.label});

  final String id;
  final String label;

  factory WordCategory.fromJson(Map<String, dynamic> json) {
    return WordCategory(
      id: json['id'] as String,
      label: json['label'] as String,
    );
  }
}
