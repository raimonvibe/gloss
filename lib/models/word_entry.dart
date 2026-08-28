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
  });

  final String id;
  final String word;
  final List<String> variants;
  final String partOfSpeech;
  final String pronunciation;
  final String definition;
  final String friendly;
  final String example;
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

  String get searchable {
    return [
      word,
      ...variants,
      partOfSpeech,
      pronunciation,
      definition,
      friendly,
      example,
      origin,
      originWord,
      ...tags,
      ...roots.expand((r) => [r.form, r.meaning]),
    ].join(' ').toLowerCase();
  }

  /// Hyphens in respellings make TTS pause; spaces read more naturally.
  String get spokenPronunciation => pronunciation.replaceAll('-', ' ');

  String get spokenWord => '$word. $spokenPronunciation.';

  String get spokenGlance => '$spokenWord $friendly';

  String get spokenEntry {
    final also = variants.isEmpty ? '' : ' Also ${variants.join(', ')}.';
    return '$spokenWord $partOfSpeech.$also $friendly $definition As in: $example';
  }

  /// Quiz prompt: word and roots only — never the definition.
  String get spokenPrompt {
    final rootLine = roots
        .map((r) => '${r.form}, meaning ${r.meaning}')
        .join('. ');
    final rootsPart = rootLine.isEmpty ? '' : ' $rootLine.';
    return '$spokenWord From $origin, $originWord.$rootsPart';
  }

  String spokenQuiz({required bool revealed}) {
    if (!revealed) return spokenPrompt;
    return '$spokenPrompt In plain words: $friendly';
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
