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
    this.translationSource,
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

  /// The English entry this one was translated from, if it was.
  ///
  /// Read-aloud is English-only: the lemma cannot be pronounced in another
  /// tongue, and handing translated text to the English-locked voice makes
  /// it mangle the words. Display uses the translated fields; speech reads
  /// from here.
  final WordEntry? translationSource;

  /// This entry's English original — itself when nothing was overlaid.
  WordEntry get english => translationSource ?? this;

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
      translationSource: english,
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

  String get spokenWord => '${english.word}. ${english.spokenPronunciation}.';

  String get spokenGlance => spokenGlanceWith(SpeechTemplates.english);

  String spokenGlanceWith(SpeechTemplates templates) =>
      '$spokenWord ${english.friendly}';

  String get spokenEntry => spokenEntryWith(SpeechTemplates.english);

  /// The whole entry, in the order the page sets it out: what the word is
  /// and how to say it, where it came from, what it is built of, what it
  /// means, and the sentence it lives in.
  ///
  /// A reading that stopped at the meaning left the card at the top of the
  /// page — the origin and the roots — unread.
  String spokenEntryWith(SpeechTemplates templates) {
    final source = english;
    return [
      spokenWord,
      '${source.partOfSpeech}.',
      if (source.variants.isNotEmpty)
        templates.also(source.variants.join(', ')),
      templates.fromOrigin(source.origin, source.originWord),
      source._spokenRootsWith(templates),
      templates.inPlainWords(source.friendly),
      source.definition,
      templates.asIn(source.example),
    ].where((part) => part.isNotEmpty).join(' ');
  }

  /// 'torpere, meaning to be numb. -idus, meaning in a state of.'
  String _spokenRootsWith(SpeechTemplates templates) {
    if (roots.isEmpty) return '';
    final lines =
        roots.map((r) => templates.rootMeaning(r.form, r.meaning)).join('. ');
    return '$lines.';
  }

  /// Everything in this entry that a translation may quote in English.
  ///
  /// Translated copy keeps the lexicon's own words: the headword, the
  /// sentence it lives in, the phrase that sentence puts in quotation marks,
  /// the root forms. Speech uses this to hand each of them back to the
  /// English voice wherever they turn up inside another language.
  List<String> get quotedEnglish {
    final source = english;
    return [
      source.word,
      ...source.variants,
      source.example,
      ..._quotedIn(source.example),
      source.originWord,
      for (final root in source.roots) root.form,
    ];
  }

  /// The same entry in the reader's language, laid out in the same order.
  ///
  /// Empty when nothing was translated, so callers can drop it. What stays
  /// English inside it — the headword, the root forms, the etymon, the
  /// sentence — is cut back out by `segmentTranslation` and handed to the
  /// English voice, so this can quote the lexicon freely.
  String spokenExplanationWith(SpeechTemplates templates) {
    if (translationSource == null) return '';
    return [
      '$partOfSpeech.',
      templates.fromOrigin(origin, originWord),
      _spokenRootsWith(templates),
      templates.inPlainWords(friendly),
      definition,
      templates.asIn(english.example),
      if (exampleGloss != null) exampleGloss!,
    ].where((part) => part.isNotEmpty).join(' ');
  }

  /// The glance a card reads out — what the word means, and no more — in
  /// the reader's language.
  ///
  /// Empty when nothing was translated, so callers can drop it.
  String get spokenGlanceExplanation =>
      translationSource == null ? '' : friendly;

  /// What the quiz card shows before an answer — where the word came from
  /// and what it is built of — in the reader's language.
  ///
  /// The lemma and its respelling are not here: they are English, and the
  /// caller sends them to the English voice. Nor is the meaning, which is
  /// the question. Empty when nothing was translated, so callers can drop it.
  String spokenQuizPromptWith(SpeechTemplates templates) {
    if (translationSource == null) return '';
    return [
      templates.fromOrigin(origin, originWord),
      _spokenRootsWith(templates),
    ].where((part) => part.isNotEmpty).join(' ');
  }

  /// What the word means, in the reader's language.
  ///
  /// Kept apart from the prompt because the quiz withholds it until the
  /// answer is in. Empty when nothing was translated.
  String spokenMeaningWith(SpeechTemplates templates) =>
      translationSource == null ? '' : templates.inPlainWords(friendly);

  String get spokenPrompt => spokenPromptWith(SpeechTemplates.english);

  String spokenPromptWith(SpeechTemplates templates) {
    final source = english;
    final rootLine = source.roots
        .map((r) => templates.rootMeaning(r.form, r.meaning))
        .join('. ');
    final rootsPart = rootLine.isEmpty ? '' : ' $rootLine.';
    return '$spokenWord '
        '${templates.fromOrigin(source.origin, source.originWord)}$rootsPart';
  }

  String spokenQuiz({required bool revealed, SpeechTemplates? templates}) {
    final copy = templates ?? SpeechTemplates.english;
    if (!revealed) return spokenPromptWith(copy);
    return '${spokenPromptWith(copy)} ${copy.inPlainWords(english.friendly)}';
  }
}

/// The phrases an English sentence puts in quotation marks — the part a
/// translation tends to quote rather than translate.
///
/// Backslashes are dropped first, so a stray escape in the data can never
/// hide a quotation from the voice that should be reading it.
Iterable<String> _quotedIn(String text) {
  return _quotation
      .allMatches(text.replaceAll('\\', ''))
      .map((match) => match.group(1)!.trim())
      .where((phrase) => phrase.isNotEmpty);
}

final _quotation = RegExp('["“”„«»](.+?)["“”„«»]');

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
