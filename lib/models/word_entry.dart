import '../l10n/speech_templates.dart';
import 'origin_voice.dart';
import 'respelling.dart';
import 'spoken_forms.dart';
import 'ssml.dart';

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
    this.ipa = '',
    required this.definition,
    required this.friendly,
    required this.example,
    required this.tags,
    required this.origin,
    required this.originWord,
    required this.roots,
    this.variants = const [],
    this.exampleGloss,
    this.spokenOrigin,
    this.translationSource,
  });

  final String id;
  final String word;
  final List<String> variants;
  final String partOfSpeech;
  final String pronunciation;

  /// The sound of the word, for a voice that cannot read the spelling.
  ///
  /// Derived from [pronunciation] by `tool/emit_ipa.py`, never written by
  /// hand — run that tool after changing a respelling, and
  /// `python tool/emit_ipa.py --check` fails if the two have drifted apart.
  final String ipa;
  final String definition;
  final String friendly;
  final String example;
  final String? exampleGloss;
  final List<String> tags;
  final String origin;

  /// [origin] as a voice should be handed it, when a locale writes it as one
  /// closed compound — Dutch *Oudengels* for *Oud engels*. Null when the two
  /// are the same, which they are for most of the sixty and for English.
  /// The page always shows [origin]; only speech reads this.
  final String? spokenOrigin;

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
      ipa: json['ipa'] as String? ?? '',
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

  /// [spokenOrigin] is the origin as a voice should be handed it, when that
  /// differs from the way the page writes it — see `spoken_origin.dart`.
  WordEntry withOverlay(WordOverlay? overlay, {String? spokenOrigin}) {
    if (overlay == null) return this;
    final meanings = overlay.rootMeanings;
    return WordEntry(
      id: id,
      word: word,
      variants: variants,
      partOfSpeech: overlay.partOfSpeech ?? partOfSpeech,
      pronunciation: pronunciation,
      ipa: ipa,
      definition: overlay.definition ?? definition,
      friendly: overlay.friendly ?? friendly,
      example: example,
      exampleGloss: overlay.exampleGloss ?? exampleGloss,
      tags: tags,
      origin: overlay.origin ?? origin,
      spokenOrigin: spokenOrigin,
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

  /// The respelling as a voice should hear it — see [spokenRespelling].
  ///
  /// Every reading in the app arrives here through [spokenWord], so the
  /// capitals that a voice would spell out are undone in one place.
  String get spokenPronunciation => spokenRespelling(pronunciation);

  /// The word, said.
  ///
  /// The engine cannot read these spellings — it holds almost none of the 134
  /// and invents a reading — so it is handed the sound instead. A device probe
  /// on 2026-09-02 settled which of the three ways of doing that this engine
  /// accepts: `<phoneme>` was right, `<sub>` with a respelling for an alias was
  /// wrong, and the bare respelling was wrong. The received wisdom was that an
  /// on-device engine ignores `<phoneme>`; this one does not.
  ///
  /// The respelling rides inside the tag as its text, so an engine that ignores
  /// `<phoneme>` says what the app said before this and nothing is lost.
  String get spokenWord {
    final source = english;
    return '${source.said(source.word)} ';
  }

  /// [text] said by its sound rather than read off its spelling.
  ///
  /// Falls back to the plain word where there is no IPA, which is what a new
  /// entry looks like before `tool/emit_ipa.py` has been run over it.
  String said(String text) {
    final source = english;
    if (source.ipa.isEmpty) return '$text.';
    return '${ssmlPhoneme(source.ipa, source.spokenPronunciation)}.';
  }

  /// Every English form of this word the app may say, and its respelling.
  ///
  /// The headword itself, its variants, and the inflections the example
  /// sentences use — see [kSpokenForms].
  Map<String, SpokenForm> get spokenForms {
    final source = english;
    return {
      source.word.toLowerCase(): SpokenForm(
        ipa: source.ipa,
        respelling: source.spokenPronunciation,
      ),
      for (final form in kSpokenForms[source.id]?.keys ?? const <String>[])
        form: SpokenForm(
          ipa: ipaOfForm(source.id, form) ?? '',
          respelling: spokenFormOf(source.id, form)!,
        ),
    };
  }

  /// [passage] with every form of this word in it handed to the voice as its
  /// respelling.
  ///
  /// This is the general form of the fix that `spokenWord` applies to the
  /// headword. The engine cannot say these words anywhere — not at the top of
  /// the reading and not in the middle of the sentence that shows them off —
  /// so every English passage the app speaks goes through here first.
  ///
  /// Longest form first, so *edulcorated* is matched before *edulcorate* and
  /// the sentence is not left saying the wrong word. Whole words only, and
  /// the text inside the tag is the text as written, so an engine that
  /// ignores `<sub>` reads exactly what it read before.
  ///
  /// Never run this over a passage that already carries markup: it would
  /// match the headword inside a tag it wrote a moment ago. Assemble first
  /// from voiced parts, or voice the parts — never the assembly.
  String voiced(String passage) {
    if (passage.isEmpty) return passage;
    assert(
      !passage.contains(kSsmlOpen),
      'voiced() was handed a passage that already carries markup',
    );
    final forms = spokenForms;
    final written = forms.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    final pattern = RegExp(
      r'\b(' + written.map(RegExp.escape).join('|') + r')\b',
      caseSensitive: false,
    );
    return passage.replaceAllMapped(pattern, (match) {
      final found = match.group(0)!;
      final sound = forms[found.toLowerCase()]!;
      return sound.ipa.isEmpty
          ? ssmlSub(sound.respelling, found)
          : ssmlPhoneme(sound.ipa, sound.respelling);
    });
  }

  String get spokenGlance => spokenGlanceWith(SpeechTemplates.english);

  String spokenGlanceWith(SpeechTemplates templates) =>
      '$spokenWord ${english.voiced(english.friendly)}';

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
      // spokenWord already carries its own tag; everything after it is plain
      // English that may name the word again, so it is voiced here.
      spokenWord,
      '${source.partOfSpeech}.',
      if (source.variants.isNotEmpty)
        source.voiced(templates.also(source.variants.join(', '))),
      templates.fromOrigin(source.origin, source.originWord),
      source._spokenRootsWith(templates),
      source.voiced(templates.inPlainWords(source.friendly)),
      source.voiced(templates.theDefinition(source.definition)),
      source.voiced(templates.inASentence(source.example)),
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
      // Every form the app knows how to say, the inflections included. A
      // translated sentence keeps the English word in whatever shape it
      // needs — the Dutch for *edulcorate* reads "De redacteur edulcorated
      // de harde recensie" — and an inflection that is not listed here is
      // one the Dutch voice is left holding, in a Dutch accent.
      ...spokenForms.keys,
      source.word,
      ...source.variants,
      source.example,
      ..._quotedIn(source.example),
      source.originWord,
      for (final root in source.roots) root.form,
    ];
  }

  /// The voice [term] belongs to, when it is one of this entry's own
  /// etymological forms and the origin names a single language.
  ///
  /// Null for everything else, which leaves the term with the English voice
  /// it has always had. See [kOriginVoices] for what is in the table and
  /// what is deliberately not.
  String? etymonVoiceFor(String term) {
    // A compound origin names two languages and the etymon is in one of
    // them; which one is written down per word rather than guessed.
    final tag = kOriginVoices[english.origin] ?? kEtymonVoiceByWord[id];
    if (tag == null) return null;
    final needle = term.trim().toLowerCase();
    if (needle.isEmpty ||
        kMixedForm.hasMatch(needle) ||
        kTransliteratedGreek.hasMatch(needle)) {
      return null;
    }
    final source = english;
    for (final form in [
      source.originWord,
      for (final root in source.roots) root.form,
    ]) {
      if (kMixedForm.hasMatch(form)) continue;
      if (form.trim().toLowerCase() == needle) return tag;
    }
    return null;
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
      templates.fromOrigin(spokenOrigin ?? origin, originWord),
      _spokenRootsWith(templates),
      templates.inPlainWords(friendly),
      templates.theDefinition(definition),
      templates.inASentence(english.example),
      if (exampleGloss != null) exampleGloss!,
    ].where((part) => part.isNotEmpty).join(' ');
  }

  /// The glance a card reads out — what the word means, and no more — in
  /// the reader's language.
  ///
  /// Empty when nothing was translated, so callers can drop it.
  String get spokenGlanceExplanation =>
      translationSource == null ? '' : friendly;

  /// What the quiz card shows before an answer — where the word came from,
  /// and once [withRoots] what it is built of — in the reader's language.
  ///
  /// The lemma and its respelling are not here: they are English, and the
  /// caller sends them to the English voice. Nor is the meaning, which is
  /// the question. Empty when nothing was translated, so callers can drop it.
  ///
  /// The roots wait for the answer the same way the card's do. Hiding them
  /// on the page and reading them out a second later would only move the
  /// giveaway to the listen button.
  String spokenQuizPromptWith(
    SpeechTemplates templates, {
    bool withRoots = true,
  }) {
    if (translationSource == null) return '';
    return [
      templates.fromOrigin(spokenOrigin ?? origin, originWord),
      if (withRoots) _spokenRootsWith(templates),
    ].where((part) => part.isNotEmpty).join(' ');
  }

  /// What the word means, in the reader's language.
  ///
  /// Kept apart from the prompt because the quiz withholds it until the
  /// answer is in. Empty when nothing was translated.
  String spokenMeaningWith(SpeechTemplates templates) =>
      translationSource == null ? '' : templates.inPlainWords(friendly);

  String get spokenPrompt => spokenPromptWith(SpeechTemplates.english);

  String spokenPromptWith(SpeechTemplates templates, {bool withRoots = true}) {
    final source = english;
    final rootLine = !withRoots
        ? ''
        : source.roots
            .map((r) => templates.rootMeaning(r.form, r.meaning))
            .join('. ');
    final rootsPart = rootLine.isEmpty ? '' : ' $rootLine.';
    return '$spokenWord '
        '${templates.fromOrigin(source.origin, source.originWord)}$rootsPart';
  }

  String spokenQuiz({required bool revealed, SpeechTemplates? templates}) {
    final copy = templates ?? SpeechTemplates.english;
    // Unanswered, this is the question: the word and where it came from, and
    // not the roots that would answer it.
    if (!revealed) return spokenPromptWith(copy, withRoots: false);
    return '${spokenPromptWith(copy)} '
        '${english.voiced(copy.inPlainWords(english.friendly))}';
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

/// How the respelling is handed to the voice.
///
/// The app was sending `Pietistic. pie uh tiss tik.` — the right string, the
/// device trace proves it — and Google's Android engine still opened the
/// respelling on the letter "pee" while saying the very same sound correctly
/// inside *Pietistic* a moment earlier.
///
/// So the fault is not the spelling of the syllable. `pie` is an ordinary
/// English word and it still came out wrong; what differs is the company it
/// keeps. A neural engine predicts prosody over the whole utterance, and a
/// run of short tokens is read as a rapid unstressed sequence rather than as
/// four words being sounded out, which reduces the vowel. `Pietistic` comes
/// out right because the model has a whole word to work from.
///
/// Which of these an engine reads correctly cannot be reasoned out and
/// cannot be measured from a desktop — Windows SAPI, which
/// `tool/probe_respellings.ps1` asks, is not the engine on the phone and
/// disagrees with it. So this is a switch: set it, `flutter run --debug`,
/// hot-restart with R, and listen. The `[gloss-tts]` trace prints the
/// utterance, so the log says which shape was tried.
enum RespellingVoicing {
  /// `Pietistic. pie uh tiss tik.` — what ships today.
  spaced,

  /// `Pietistic. pie, uh, tiss, tik.` — a comma is a prosodic boundary, so
  /// each syllable is likelier to keep its full vowel.
  commas,

  /// `Pietistic. pie. uh. tiss. tik.` — each syllable its own sentence, which
  /// is the strongest hint an engine takes for a citation form.
  sentences,

  /// `Pietistic. Pietistic.` — no respelling at all. This one cannot be
  /// mispronounced: it is the word the engine already says correctly, which
  /// the trace and the ear both confirm. The respelling stays on the page,
  /// where it was always meant to be read rather than heard.
  twice,

  /// `Pietistic.` — the word, once.
  wordOnly,

  /// `<sub alias="pie uh tiss tik">Pietistic</sub>.` — the page shows the
  /// word, the voice is given the respelling. This is the fix if the engine
  /// honours `<sub>`; an engine that does not speaks the inner text, which is
  /// the word alone, so it is never worse than [wordOnly].
  sub,

  /// `pie uh tiss tik.` — the respelling in place of the word, no markup and
  /// nothing for an engine to support. The fallback if `<sub>` is ignored.
  respellingOnly,

  /// A labelled experiment, for finding out which of the above this engine
  /// can do. Says each candidate in turn behind a number, so one listen
  /// settles it. Not for shipping.
  probe,
}

/// IPA for the handful of words [RespellingVoicing.probe] asks with, taken
/// from Wiktionary's General American transcriptions.
///
/// Only these few, because this is an experiment and not a data model. If the
/// phone turns out to honour `<phoneme>`, IPA belongs in `words.json` for all
/// 134 — it was already fetched once, for the audit in `spoken_forms.dart`'s
/// sibling work — and every invented respelling substitution can go.
const kProbeIpa = <String, String>{
  'emendation': 'ˌiːmɛnˈdeɪʃən',
  'edulcorate': 'əˈdʌlkəɹeɪt',
  'pietistic': 'ˌpaɪɪˈtɪstɪk',
  'hebetude': 'ˈhɛbətuːd',
};

/// The shape in use.
///
/// [sub] ships: the page keeps the word and the voice is handed the
/// respelling, which a device probe confirmed the engine honours.
///
/// What that left behind is the respelling itself. Nineteen of the twenty-seven
/// substitutions in `respelling.dart` are invented spellings — `eeh`, `ihh`,
/// `ihhr` — each a bet about how one engine reads a string that is not a word.
/// They were measured against Windows SAPI, and the phone disagreed: `eeh` came
/// out "ee ee aitch" in *Emendation*. `ihh` stands to fail the same way, in
/// thirteen more.
///
/// [probe] asks the only question that would end that for good: whether the
/// engine honours `<phoneme>`. If it does, IPA replaces every invented spelling
/// and nothing has to guess again.
const kRespellingVoicing = RespellingVoicing.probe;

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
