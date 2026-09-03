import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/ssml.dart';

/// Gloss is an English lexicon. TTS must never follow the phone language.
const kPreferredEnglishLocales = [
  'en-US',
  'en-GB',
  'en-AU',
  'en-IN',
  'en-ZA',
  'en',
];

const kPreferredTtsEngines = [
  'com.google.android.tts',
  'com.google.android.googlequicksearchbox',
];

String normalizeTtsLocale(String raw) =>
    raw.trim().toLowerCase().replaceAll('_', '-');

bool isEnglishTtsLocale(String raw) {
  final locale = normalizeTtsLocale(raw);
  return locale == 'en' || locale.startsWith('en-');
}

bool ttsLanguageLooksAvailable(dynamic result) {
  if (result == true) return true;
  if (result is num) return result >= 0;
  return false;
}

/// Google TTS on Dutch phones, instead of Samsung/OEM Dutch defaults.
String? pickPreferredTtsEngine(Iterable<String> engines) {
  final installed = engines.map((engine) => engine.toString()).toList();
  for (final preferred in kPreferredTtsEngines) {
    for (final engine in installed) {
      if (engine.toLowerCase() == preferred) return engine;
    }
  }
  for (final engine in installed) {
    final name = engine.toLowerCase();
    if (name.contains('google') && name.contains('tts')) return engine;
  }
  return null;
}

/// Best English language code from what the engine actually reports.
String? pickEnglishLanguage(Iterable<String> available) {
  final byNormalized = <String, String>{};
  for (final code in available) {
    byNormalized.putIfAbsent(normalizeTtsLocale(code), () => code);
  }
  for (final preferred in kPreferredEnglishLocales) {
    final match = byNormalized[normalizeTtsLocale(preferred)];
    if (match != null) return match;
  }
  for (final entry in byNormalized.entries) {
    if (isEnglishTtsLocale(entry.key)) return entry.value;
  }
  return null;
}

/// Best installed English voice. Prefers US, then local/offline voices.
Map<String, String>? pickEnglishVoice(Iterable<Map<dynamic, dynamic>> voices) {
  final english = <({String name, String locale, bool installed})>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null || name.isEmpty) continue;
    if (!isEnglishTtsLocale(locale)) continue;
    english.add((name: name, locale: locale, installed: voiceIsInstalled(voice)));
  }
  if (english.isEmpty) return null;

  int score(({String name, String locale, bool installed}) voice) {
    final locale = normalizeTtsLocale(voice.locale);
    final name = voice.name.toLowerCase();
    var value = 0;
    if (locale == 'en-us') {
      value += 40;
    } else if (locale == 'en-gb') {
      value += 30;
    } else if (locale.startsWith('en-')) {
      value += 20;
    } else {
      value += 10;
    }
    if (name.contains('local')) value += 15;
    if (name.contains('network') || name.contains('online')) value -= 10;
    // Prefer a voice the engine says is on the device, never exclude one.
    if (voice.installed) value += 100;
    return value;
  }

  english.sort((a, b) => score(b).compareTo(score(a)));
  final best = english.first;
  return {'name': best.name, 'locale': best.locale};
}

String wrapEnglishSsml(String text) {
  final escaped = text
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      // The app's own tags, written as sentinels so that the escaping above
      // could not touch them — see lib/models/ssml.dart.
      .replaceAll(kSsmlOpen, '<')
      .replaceAll(kSsmlClose, '>')
      .replaceAll(kSsmlQuote, '"');
  return '<speak xml:lang="en-US">$escaped</speak>';
}

/// Debug-only trace of what actually reaches the platform engine.
///
/// The Dart can be provably right and the phone still wrong, and the ways
/// that happens all look identical from here: a stale install, a second
/// checkout, a voice that never locked to English, a screen reader saying
/// the page instead of the app saying the word. This prints the four facts
/// that tell them apart — the engine, whether it is being given SSML, the
/// voice that actually took, and the exact string handed over.
///
/// Debug builds only; `kDebugMode` is a compile-time constant, so this and
/// every call to it are dropped from a release build.
void ttsTrace(String message) {
  if (kDebugMode) debugPrint('[gloss-tts] $message');
}

bool get _isAndroid =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

/// flutter_tts rates are 0..1 on Android and read as roughly half speed at
/// 0.5. The shipped default is deliberate — 0.42, for unfamiliar words.
const kMinSpeechRate = 0.25;
const kMaxSpeechRate = 0.75;
const kDefaultSpeechRate = 0.42;

/// No platform TTS call may block the UI indefinitely. Android parks calls
/// until the engine reports init, and an engine that never binds never
/// reports at all.
const _kTtsCallTimeout = Duration(seconds: 5);
const _kTtsInitTimeout = Duration(seconds: 10);

/// Where an English voice is spoken, in the words a reader would use for it.
///
/// The engine offers a locale and nothing else, and 'en-us' is not an answer
/// to 'which of these forty voices do I want'. Keyed by the normalised locale.
const kEnglishRegionNames = <String, String>{
  'en': 'English',
  'en-au': 'Australian English',
  'en-bd': 'Bangladeshi English',
  'en-ca': 'Canadian English',
  'en-gb': 'British English',
  'en-gh': 'Ghanaian English',
  'en-hk': 'Hong Kong English',
  'en-ie': 'Irish English',
  'en-in': 'Indian English',
  'en-ke': 'Kenyan English',
  'en-ng': 'Nigerian English',
  'en-nz': 'New Zealand English',
  'en-ph': 'Philippine English',
  'en-pk': 'Pakistani English',
  'en-sg': 'Singapore English',
  'en-tz': 'Tanzanian English',
  'en-us': 'American English',
  'en-za': 'South African English',
};

/// Which voice this is, where the engine says at all.
///
/// [unknown] is a real answer and not a failure: plenty of voices carry no
/// gender anywhere in what the engine reports, and a guess dressed up as a
/// label would be worse than the locale we started with.
enum VoiceGender { male, female, unknown }

/// Google's Android names carry the gender inline - 'en-us-x-tpf#female_2-local'
/// - behind a separator. The optional 'fe' is what tells the two apart, and it
/// has to be tried in that order or 'female' matches as 'male'.
final _kGenderInVoiceName = RegExp(
  r'[#_-](fe)?male(?:[_-]?(\d+))?',
  caseSensitive: false,
);

VoiceGender? _declaredVoiceGender(Object? raw) {
  final value = raw?.toString().trim().toLowerCase();
  if (value == null || value.isEmpty) return null;
  if (value == 'male') return VoiceGender.male;
  if (value == 'female') return VoiceGender.female;
  return null;
}

/// One installed English voice the reader may choose between.
class VoiceOption {
  const VoiceOption({
    required this.name,
    required this.locale,
    String? engineLocale,
    this.declaredGender,
    this.ordinal = 1,
  }) : _engineLocale = engineLocale;

  /// The engine's own id. This is what is stored and what is handed back to
  /// the engine, so every label below is presentation and nothing more.
  final String name;
  final String locale;

  final String? _engineLocale;

  /// The locale spelled the way the engine spelled it.
  ///
  /// [locale] is lower-cased so that 'it-IT' and 'it_IT' match each other,
  /// which is what every comparison here wants — and what no platform call
  /// wants. `setVoice` compares locales **exactly** on both platforms:
  /// Android against `Locale.toLanguageTag()` and iOS against
  /// `AVSpeechSynthesisVoice.language`, both of which say 'it-IT'. Handed
  /// 'it-it' the plugin finds no such voice, logs it, and returns 0 — and
  /// on iOS the voice it had just been cleared to null stays null, so the
  /// utterance is spoken by whatever the system default is. That is how a
  /// Latin etymon came to be read in English.
  ///
  /// So: [locale] to compare with, [engineLocale] to speak with.
  String get engineLocale => _engineLocale ?? locale;

  /// What the platform said outright. iOS reports a gender field; Android
  /// does not, and leaves it to be read out of [name].
  final VoiceGender? declaredGender;

  /// Position within this region and gender, counted from one. Fills the
  /// number in 'Male 2' for the voices that carry no number of their own.
  final int ordinal;

  VoiceGender get gender {
    final declared = declaredGender;
    if (declared != null) return declared;
    final match = _kGenderInVoiceName.firstMatch(name);
    if (match == null) return VoiceGender.unknown;
    return match.group(1) == null ? VoiceGender.male : VoiceGender.female;
  }

  /// The number the engine itself gave this voice, where it gave one.
  int? get variant {
    final digits = _kGenderInVoiceName.firstMatch(name)?.group(2);
    return digits == null ? null : int.tryParse(digits);
  }

  /// An offline voice reads with the network off and without sending the
  /// text anywhere; that is worth saying on the label.
  bool get isOffline => name.toLowerCase().contains('local');

  bool get isNetwork {
    final lower = name.toLowerCase();
    return lower.contains('network') || lower.contains('online');
  }

  /// iOS names its voices after people - 'Daniel', 'Moira' - and that name is
  /// better than anything we could build. Android hands back a synthetic id
  /// ('en-gb-x-gbb-local'), which is not a name and must not be shown as one.
  String? get personName {
    var trimmed = name.trim();
    if (trimmed.isEmpty) return null;
    // 'com.apple.voice.compact.en-GB.Daniel' → 'Daniel'.
    if (trimmed.toLowerCase().startsWith('com.apple')) {
      trimmed = trimmed.split('.').last;
    }
    if (trimmed.contains('-x-') || trimmed.contains('#')) return null;
    if (isEnglishTtsLocale(trimmed)) return null;
    if (!RegExp(r'^[A-Za-zÀ-ɏ][A-Za-zÀ-ɏ .-]*$').hasMatch(trimmed)) {
      return null;
    }
    final lower = trimmed.toLowerCase();
    if (lower == 'local' || lower == 'network' || lower == 'online') {
      return null;
    }
    return trimmed;
  }

  String get regionLabel =>
      kEnglishRegionNames[locale] ?? 'English ($locale)';

  String get genderLabel => switch (gender) {
        VoiceGender.male => 'Male',
        VoiceGender.female => 'Female',
        VoiceGender.unknown => 'Voice',
      };

  String? get qualityLabel {
    if (isNetwork) return 'online';
    if (isOffline) return 'offline';
    return null;
  }

  /// 'American English · Male 1 · offline', rather than
  /// 'en-us-x-iob male 1-local · en-us'.
  ///
  /// Deliberately English, like the lemmas and the respelling: every voice in
  /// this list reads the English lexicon, and 'American English' is the name
  /// of the accent it reads it in, not chrome around it.
  String get label {
    final parts = <String>[];
    final person = personName;
    if (person != null) {
      parts.add(person);
      parts.add(regionLabel);
    } else {
      parts.add(regionLabel);
      parts.add('$genderLabel ${variant ?? ordinal}');
    }
    final quality = qualityLabel;
    if (quality != null) parts.add(quality);
    return parts.join(' · ');
  }

  VoiceOption withOrdinal(int value) => VoiceOption(
        name: name,
        locale: locale,
        engineLocale: _engineLocale,
        declaredGender: declaredGender,
        ordinal: value,
      );
}

/// English voices only, sorted so the likeliest pick sits first. The lexicon
/// is English; offering a Dutch voice here would undo the language lock.
///
/// Within a region the male voices lead. Most devices install more female
/// English voices than male ones, and interleaved under opaque ids the male
/// ones read as missing altogether.
List<VoiceOption> englishVoiceOptions(Iterable<Map<dynamic, dynamic>> voices) {
  final seen = <String>{};
  final found = <VoiceOption>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null || name.isEmpty) continue;
    if (!isEnglishTtsLocale(locale)) continue;
    if (!seen.add(name)) continue;
    found.add(
      VoiceOption(
        name: name,
        locale: normalizeTtsLocale(locale),
        engineLocale: locale,
        declaredGender: _declaredVoiceGender(voice['gender']),
      ),
    );
  }
  found.sort((a, b) {
    final byLocale = a.locale.compareTo(b.locale);
    if (byLocale != 0) return byLocale;
    final byGender = a.gender.index.compareTo(b.gender.index);
    if (byGender != 0) return byGender;
    final byVariant = (a.variant ?? 0).compareTo(b.variant ?? 0);
    if (byVariant != 0) return byVariant;
    if (a.isOffline != b.isOffline) return a.isOffline ? -1 : 1;
    return a.name.compareTo(b.name);
  });

  // The number in 'Male 2' counts within one region and one gender, so that
  // it reads as a choice between neighbours rather than an index into forty.
  final counts = <String, int>{};
  return [
    for (final voice in found)
      voice.withOrdinal(
        counts.update(
          '${voice.locale}/${voice.gender.name}',
          (n) => n + 1,
          ifAbsent: () => 1,
        ),
      ),
  ];
}

/// One stretch of speech in one language.
///
/// A [languageTag] of null means English, the lexicon's own language and the
/// only one the lemma may be pronounced in.
class SpeechSegment {
  const SpeechSegment(
    this.text, {
    this.languageTag,
    this.fallback,
    this.group,
  });

  final String text;
  final String? languageTag;

  /// Spoken in English when the device has no voice for [languageTag].
  /// Without one the segment is simply skipped.
  final String? fallback;

  /// The passage this piece belongs to.
  ///
  /// One passage of translated prose comes apart into several segments,
  /// because it quotes English part-way through. They stand or fall
  /// together: if the device cannot speak the language, the whole passage
  /// gives way to its [fallback] once, rather than each piece falling back
  /// on its own and saying the same thing three times over.
  final Object? group;

  bool get isEnglish => languageTag == null;
}

/// Terms shorter than this are not worth cutting a sentence for, and short
/// ones ("e-", "ex-") turn up inside ordinary words.
const _kShortestQuote = 3;

final _wordCharacter = RegExp(r'[\p{L}\p{N}]', unicode: true);

/// Punctuation left dangling once the English is lifted out of a sentence:
/// the opening quote with nothing behind it, the comma that trailed a term,
/// the full stop and closing quote that the next piece begins on.
///
/// A voice handed '.” Dubbelzinnigheid' says the full stop and the quote
/// out loud before it reaches a word. Sentence endings are left alone: a
/// piece may finish on '.', '!' or '?', which is how it should sound.
final _danglingHead = RegExp(r'^[\s.,;:!?…"“”„«»‹›—–-]+');

final _danglingTail = RegExp(r'[\s,;:"“”„«»‹›—–-]+$');

/// What a voice is actually given to say.
///
/// Quotation marks are a mark on the page, not a sound: some engines
/// announce them - 'aanhalingsteken' dropped into the middle of a sentence -
/// and none of them read better for keeping them. Everything the app speaks
/// passes through here, so the page can quote as freely as it likes.
///
/// Apostrophes are left alone. They live inside words.
String asSpoken(String text) => text.replaceAll(_quotationMarks, '').trim();

final _quotationMarks = RegExp(r'["“”„«»‹›]');

/// True when [start]–[end] is not sitting inside a longer word.
bool _standsAlone(String text, int start, int end) {
  final before = start == 0 ? '' : text[start - 1];
  final after = end >= text.length ? '' : text[end];
  return !_wordCharacter.hasMatch(before) && !_wordCharacter.hasMatch(after);
}

/// Cuts one passage of translated prose into the languages it is actually
/// written in.
///
/// Translations quote the English lexicon inside their own sentences — the
/// headword, the sentence it lives in, the roots it came from. The Dutch for
/// *amphiboly* explains it with "Visiting relatives can be tiring" sitting in
/// the middle of the Dutch, and a Dutch voice reads that with a Dutch accent.
/// Every term in [englishTerms] that [text] quotes becomes a segment of its
/// own for the English voice; what is left stays in [languageTag].
///
/// The pieces share a [group], so a device with no voice for [languageTag]
/// hears [fallback] once instead of the passage.
List<SpeechSegment> segmentTranslation(
  String text, {
  required String languageTag,
  required Iterable<String> englishTerms,
  String? fallback,
  Object? group,
}) {
  final body = text.trim();
  if (body.isEmpty) return const [];

  SpeechSegment translated(String part) => SpeechSegment(
        part,
        languageTag: languageTag,
        fallback: fallback,
        group: group,
      );

  // Longest first, so a quoted sentence wins over the headword inside it.
  final terms = englishTerms
      .map((term) => term.trim())
      .where((term) => term.length >= _kShortestQuote)
      .toList()
    ..sort((a, b) => b.length.compareTo(a.length));

  final haystack = body.toLowerCase();
  final claimed = List<bool>.filled(body.length, false);
  final found = <(int, int)>[];
  for (final term in terms) {
    final needle = term.toLowerCase();
    for (var from = 0;;) {
      final at = haystack.indexOf(needle, from);
      if (at < 0) break;
      final end = at + needle.length;
      from = at + 1;
      if (!_standsAlone(body, at, end)) continue;
      if (claimed.getRange(at, end).contains(true)) continue;
      claimed.fillRange(at, end, true);
      found.add((at, end));
    }
  }
  if (found.isEmpty) return [translated(body)];
  found.sort((a, b) => a.$1.compareTo(b.$1));

  final segments = <SpeechSegment>[];
  var cursor = 0;
  // A piece of nothing but a closing quote and a full stop has no words in
  // it. Dropping it saves the engine a voice change that says nothing.
  //
  // What is left over often begins or ends on the punctuation that held the
  // English in place — 'torpere, meaning to be numb' leaves ', meaning to be
  // numb' behind. A voice should open and close on words, not on a comma or
  // a stranded quotation mark.
  //
  // Only what is left over is trimmed. The English lifted out keeps every
  // mark it came with, including the hyphen that makes '-istic' a suffix.
  void addTranslated(String part) {
    final trimmed = part
        .trim()
        .replaceFirst(_danglingHead, '')
        .replaceFirst(_danglingTail, '');
    if (_wordCharacter.hasMatch(trimmed)) segments.add(translated(trimmed));
  }

  for (final (start, end) in found) {
    addTranslated(body.substring(cursor, start));
    segments.add(SpeechSegment(body.substring(start, end), group: group));
    cursor = end;
  }
  addTranslated(body.substring(cursor));
  return segments;
}

/// Whether the engine says this voice's data is on the device.
///
/// Android's `getVoices` answers with every voice the engine knows about,
/// including the languages whose data has never been downloaded — those
/// carry `notInstalled` in their features.
///
/// **This orders the candidates; it never removes them.** It excluded them
/// for a few hours on 2026-09-03 and that was wrong: the version live on Play
/// speaks every language its reader has chosen, on a device whose engine
/// flags some of those voices `notInstalled`, so the flag is not the last
/// word on whether a language will speak — Android can fall back to a network
/// voice, fetch the data, or simply be wrong about it. **A flag that is
/// usually right is a reason to prefer another voice, not a reason to refuse
/// to try.** Losing a language a reader already had is a worse fault than the
/// one this was added to fix.
///
/// The test is deliberately narrow. iOS reports no features at all — its
/// `speechVoices()` lists only what is installed — so an absent field means
/// installed, not missing.
bool voiceIsInstalled(Map<dynamic, dynamic> voice) {
  final features = voice['features']?.toString().toLowerCase();
  if (features == null || features.isEmpty) return true;
  return !features
      .split(RegExp(r'[\t,;\s]+'))
      .contains(_kNotInstalledFeature.toLowerCase());
}

/// Android's `TextToSpeech.Engine.KEY_FEATURE_NOT_INSTALLED`.
const _kNotInstalledFeature = 'notInstalled';

/// Best voice for a BCP-47 tag: an exact locale match first, then any voice
/// for the same language. Installed beats not-installed and offline beats
/// network, but neither is a veto — see [voiceIsInstalled].
///
/// Null only when the engine lists **no** voice for the language at all,
/// which is when the caller reads the English instead.
VoiceOption? pickVoiceForLanguage(
  Iterable<Map<dynamic, dynamic>> voices,
  String languageTag,
) {
  final wanted = normalizeTtsLocale(languageTag);
  final language = wanted.split('-').first;
  final candidates = <(VoiceOption, bool, bool)>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null || name.isEmpty) continue;
    final normalized = normalizeTtsLocale(locale);
    if (normalized != wanted && normalized.split('-').first != language) {
      continue;
    }
    candidates.add((
      // The engine's own spelling of the locale travels with the voice: it
      // is what has to go back to setVoice. See [VoiceOption.engineLocale].
      VoiceOption(name: name, locale: normalized, engineLocale: locale),
      voice['network_required']?.toString().trim() == '1',
      voiceIsInstalled(voice),
    ));
  }
  if (candidates.isEmpty) return null;

  int score((VoiceOption, bool, bool) candidate) {
    final (voice, networkRequired, installed) = candidate;
    var value = voice.locale == wanted ? 40 : 20;
    final name = voice.name.toLowerCase();
    if (name.contains('local')) value += 15;
    if (name.contains('network') || name.contains('online')) value -= 10;
    // What the engine said outright, rather than what its naming implies.
    if (networkRequired) value -= 10;
    // Enough to put every installed voice ahead of every uninstalled one,
    // and not enough to remove either.
    if (installed) value += 100;
    return value;
  }

  candidates.sort((a, b) => score(b).compareTo(score(a)));
  return candidates.first.$1;
}

/// Platform TTS. Tests inject [SilentSpeechEngine].
abstract class SpeechEngine {
  /// False once the platform has shown it has no working TTS engine. Speech
  /// is silent then, and the reader is owed an explanation rather than a
  /// button that does nothing.
  bool get isAvailable;

  void setCompletionHandler(VoidCallback handler);
  void setErrorHandler(void Function(dynamic message) handler);
  Future<void> speak(String text);
  Future<void> stop();

  /// Installed English voices, or empty where the platform has no TTS.
  Future<List<VoiceOption>> englishVoices();

  /// [voiceName] of null returns the engine to its own best English pick.
  Future<void> applyPreferences({String? voiceName, double? rate});

  /// Speaks each segment in turn, switching voice between them, and leaves
  /// the engine locked back to English.
  Future<void> speakSegments(List<SpeechSegment> segments);

  /// The voice this device would use for [languageTag], if it has one.
  Future<VoiceOption?> voiceForLanguage(String languageTag);
}

class TtsSpeechEngine implements SpeechEngine {
  /// The timeouts are injectable so tests can exercise a platform that never
  /// answers without waiting out the real budget.
  TtsSpeechEngine({
    Duration callTimeout = _kTtsCallTimeout,
    Duration initTimeout = _kTtsInitTimeout,
  }) : _callTimeout = callTimeout {
    // A configure() that never finishes must not strand every later call.
    _ready = _configure().timeout(
      initTimeout,
      onTimeout: () => _unavailable = true,
    );
  }

  final FlutterTts _tts = FlutterTts();
  final Duration _callTimeout;
  late final Future<void> _ready;
  var _useEnglishSsml = false;
  var _englishLocked = false;
  var _unavailable = false;
  String? _preferredVoiceName;
  double _rate = kDefaultSpeechRate;

  @override
  bool get isAvailable => !_unavailable;

  /// flutter_tts parks every method call until Android reports the engine
  /// initialised, and hands the reply back only then. A device with no
  /// configured TTS engine never fires that callback, so the future neither
  /// completes nor throws - a bare await on it strands the play button
  /// forever, with no sound and nothing in the log. Every platform call
  /// therefore needs its own way out.
  Future<T?> _guard<T>(Future<T> call) async {
    try {
      return await call.timeout(_callTimeout);
    } on TimeoutException {
      _unavailable = true;
      return null;
    } catch (_) {
      // Linux/desktop and tests may lack a TTS backend.
      return null;
    }
  }

  Future<void> _configure() async {
    if (_isIOS) {
      await _guard(_tts.setSharedInstance(true));
    }
    if (_isAndroid) {
      await _preferGoogleEngine();
    }
    await _guard(_tts.setSpeechRate(_rate));
    await _guard(_tts.setPitch(1.0));
    // flutter_tts Android init applies the *device* default voice (Dutch).
    // Lock English after that callback has finished.
    await _lockToEnglish();
  }

  Future<void> _preferGoogleEngine() async {
    final engines = await _guard(_tts.getEngines);
    if (engines is! List) return;
    final engine = pickPreferredTtsEngine(engines.map((e) => e.toString()));
    if (engine == null) return;
    _useEnglishSsml = engine.toLowerCase().contains('google');
    ttsTrace('engine=$engine ssml=$_useEnglishSsml');
    // setEngine tears the bound TextToSpeech down and builds a new one. On a
    // phone already running Google TTS that throws away a working binding,
    // and every call made before the replacement connects fails with 'not
    // bound to TTS engine' - including the English lock below, which then
    // leaves the device (Dutch) voice in place.
    final current = (await _guard(_tts.getDefaultEngine))?.toString();
    if (current != null && current.toLowerCase() == engine.toLowerCase()) {
      return;
    }
    await _guard(_tts.setEngine(engine));
  }

  /// Device language (Dutch, etc.) must not drive pronunciation.
  ///
  /// Skipped once it has taken. The full lock is nine platform round-trips
  /// and it used to run before every single utterance. [_englishLocked] is
  /// cleared whenever the engine is pointed elsewhere ([_useLanguage]) or the
  /// reader's pick changes ([applyPreferences]).
  Future<void> _lockToEnglish() async {
    if (_englishLocked) return;

    var language = 'en-US';
    final languages = await _guard(_tts.getLanguages);
    if (languages is List) {
      final picked = pickEnglishLanguage(
        languages.map((code) => code.toString()),
      );
      if (picked != null) language = picked;
    }

    var applied = false;
    for (final candidate in [language, ...kPreferredEnglishLocales]) {
      final available = await _guard(_tts.isLanguageAvailable(candidate));
      if (available == false) continue;
      final result = await _guard(_tts.setLanguage(candidate));
      if (result == null || result == 0 || result == false) continue;
      applied = true;
      break;
    }
    // A lock that never took must be retried, not remembered: an engine that
    // is still binding reports every language unavailable.
    if (!applied) {
      ttsTrace('WARNING no English language took — the device voice is still '
          'in charge, and it will read English text in its own language');
      return;
    }
    _englishLocked = true;

    final voices = await _voiceList();
    if (voices == null) return;
    final chosen = _chooseVoice(voices);
    if (chosen != null) {
      ttsTrace('locked to $language, voice=${chosen['name']} '
          '(${chosen['locale']})');
      await _guard(_tts.setVoice(chosen));
    } else {
      ttsTrace('locked to $language, no voice chosen');
    }
  }

  /// The reader's pick when it is still installed and still English,
  /// otherwise the engine's own best guess.
  Map<String, String>? _chooseVoice(Iterable<Map<dynamic, dynamic>> voices) {
    final wanted = _preferredVoiceName;
    if (wanted != null) {
      for (final voice in voices) {
        final name = voice['name']?.toString();
        final locale = voice['locale']?.toString();
        if (name == null || locale == null || name != wanted) continue;
        if (!isEnglishTtsLocale(locale)) break;
        return {'name': name, 'locale': locale};
      }
    }
    return pickEnglishVoice(voices);
  }

  @override
  Future<List<VoiceOption>> englishVoices() async {
    await _ready;
    final voices = await _voiceList();
    if (voices == null) return const [];
    return englishVoiceOptions(voices);
  }

  @override
  Future<void> applyPreferences({String? voiceName, double? rate}) async {
    await _ready;
    _preferredVoiceName = voiceName;
    if (rate != null) _rate = rate;
    // The reader may have gone to the system settings and installed one.
    _cachedVoices = null;
    await _guard(_tts.setSpeechRate(_rate));
    _englishLocked = false;
    await _lockToEnglish();
  }

  VoidCallback? _onDone;
  Completer<void>? _segmentDone;
  var _inSequence = false;

  @override
  void setCompletionHandler(VoidCallback handler) {
    _onDone = handler;
    _tts.setCompletionHandler(_handleDone);
  }

  @override
  void setErrorHandler(void Function(dynamic message) handler) {
    _tts.setErrorHandler((message) {
      // Never leave a sequence waiting on an utterance that failed.
      _finishSegment();
      handler(message);
    });
  }

  void _handleDone() {
    _finishSegment();
    if (!_inSequence) _onDone?.call();
  }

  void _finishSegment() {
    final pending = _segmentDone;
    _segmentDone = null;
    if (pending != null && !pending.isCompleted) pending.complete();
  }

  /// Waits for this utterance before starting the next, so the voice change
  /// between segments does not cut the previous one off. The timeout is a
  /// backstop: some engines never report completion for empty or filtered
  /// text, and a sequence must not hang on that.
  ///
  /// speak() is only awaited for the engine's acknowledgement - the plugin
  /// answers it straight away unless awaitSpeakCompletion is on, which it
  /// never is here. An engine that cannot even take the utterance will not
  /// report it finished either, so waiting out the backstop would freeze the
  /// whole sequence for a minute and a half per segment.
  Future<void> _speakAndWait(String text) async {
    _segmentDone = Completer<void>();
    final waiting = _segmentDone!.future;
    final accepted = await _guard(_tts.speak(text));
    if (accepted == null) {
      _finishSegment();
      return;
    }
    await waiting.timeout(
      const Duration(seconds: 90),
      onTimeout: () {},
    );
  }

  @override
  Future<void> speak(String text) async {
    await _ready;
    await _lockToEnglish();
    final utterance =
        _useEnglishSsml ? wrapEnglishSsml(text) : ssmlToPlainText(text);
    ttsTrace('speak $utterance');
    await _guard(_tts.speak(utterance));
  }

  @override
  Future<void> stop() async {
    await _ready;
    _inSequence = false;
    _finishSegment();
    await _guard(_tts.stop());
  }

  @override
  Future<void> speakSegments(List<SpeechSegment> segments) async {
    await _ready;
    _inSequence = true;
    try {
      for (final segment in segments) {
        if (segment.text.trim().isEmpty) continue;
        if (segment.isEnglish) {
          await _lockToEnglish();
          final utterance = _useEnglishSsml
              ? wrapEnglishSsml(segment.text)
              : ssmlToPlainText(segment.text);
          ttsTrace('segment[en] $utterance');
          await _speakAndWait(utterance);
        } else {
          final applied = await _useLanguage(segment.languageTag!);
          if (applied) {
            ttsTrace('segment[${segment.languageTag}] ${segment.text}');
            await _speakAndWait(segment.text);
          } else {
            // Never let the English voice loose on translated text. Say the
            // English version instead, or nothing at all.
            final fallback = segment.fallback;
            if (fallback == null || fallback.trim().isEmpty) continue;
            await _lockToEnglish();
            await _speakAndWait(
              _useEnglishSsml
                  ? wrapEnglishSsml(fallback)
                  : ssmlToPlainText(fallback),
            );
          }
        }
        if (!_inSequence) break;
      }
    } catch (_) {
      // A failed segment should not strand the sequence.
    } finally {
      _inSequence = false;
      await _lockToEnglish();
      _onDone?.call();
    }
  }

  /// Points the engine at [languageTag]. False when the device has no voice
  /// for it at all, which is common for the smaller languages in the catalog.
  ///
  /// False only when the engine lists no voice for the language at all. That
  /// is deliberately the same bar the shipped app used, and it is a lower bar
  /// than this briefly had: for a few hours on 2026-09-03 a `notInstalled`
  /// flag or an unavailable answer from `setLanguage` was enough to give up
  /// and read the English, which would have taken languages away from a
  /// reader who already had them. **The one thing worse than a word in the
  /// wrong accent is a language that stops speaking.**
  ///
  /// What stays from that pass is the part that cost nothing: the locale is
  /// handed to `setVoice` in the engine's own spelling, and an installed
  /// offline voice is preferred over a listed one. Both are orderings, not
  /// refusals.
  Future<bool> _useLanguage(String languageTag) async {
    final voices = await _voiceList();
    if (voices == null) return false;
    final voice = pickVoiceForLanguage(voices, languageTag);
    if (voice == null) {
      ttsTrace('no voice listed for $languageTag — reading the English');
      return false;
    }
    // The engine's own word on whether it can speak this, which is worth
    // tracing and is **not** worth obeying. It said no for languages the
    // shipped app speaks perfectly well, so a no here is a warning rather
    // than a verdict: Android can reach a network voice, fetch the data, or
    // be wrong. Only a language with no voice listed at all is refused.
    final applied = await _guard(_tts.setLanguage(voice.engineLocale));
    if (applied == null || applied == 0 || applied == false) {
      ttsTrace('${voice.engineLocale} reported unavailable; trying it anyway');
    }
    _englishLocked = false;
    // The locale as the engine spelled it: setVoice compares it exactly.
    final took = await _guard(
      _tts.setVoice({'name': voice.name, 'locale': voice.engineLocale}),
    );
    if (took == null || took == 0 || took == false) {
      // The language took even though this particular voice did not, so the
      // engine will speak it in its own default voice for the language —
      // which is the right language, and that is what matters here.
      ttsTrace('voice ${voice.name} refused; ${voice.engineLocale} stands');
    }
    return true;
  }

  /// The engine's voice list, fetched once.
  ///
  /// [speakSegments] asks for it per segment, and a reading is a dozen of
  /// them: a dozen platform round trips, each one guarded by a five-second
  /// timeout, in the middle of speaking. The list does not change while the
  /// app is in the foreground; [applyPreferences] drops it anyway.
  List<Map<dynamic, dynamic>>? _cachedVoices;

  Future<List<Map<dynamic, dynamic>>?> _voiceList() async {
    final cached = _cachedVoices;
    if (cached != null) return cached;
    final voices = await _guard(_tts.getVoices);
    if (voices is! List) return null;
    return _cachedVoices = voices.whereType<Map>().toList();
  }

  @override
  Future<VoiceOption?> voiceForLanguage(String languageTag) async {
    await _ready;
    final voices = await _voiceList();
    if (voices == null) return null;
    return pickVoiceForLanguage(voices, languageTag);
  }
}

class SilentSpeechEngine implements SpeechEngine {
  SilentSpeechEngine({this.voices = const []});

  String? lastSpoken;
  bool stopped = false;
  VoidCallback? onComplete;

  final List<VoiceOption> voices;
  String? appliedVoiceName;
  double? appliedRate;

  @override
  bool get isAvailable => true;

  @override
  Future<List<VoiceOption>> englishVoices() async => voices;

  @override
  Future<void> applyPreferences({String? voiceName, double? rate}) async {
    appliedVoiceName = voiceName;
    appliedRate = rate;
  }

  @override
  void setCompletionHandler(VoidCallback handler) => onComplete = handler;

  @override
  void setErrorHandler(void Function(dynamic message) handler) {}

  @override
  Future<void> speak(String text) async {
    lastSpoken = text;
    stopped = false;
  }

  @override
  Future<void> stop() async {
    stopped = true;
    lastSpoken = null;
  }

  /// Every segment handed to the engine, in order, as 'tag:text'.
  final List<String> spokenSegments = [];

  @override
  Future<void> speakSegments(List<SpeechSegment> segments) async {
    for (final segment in segments) {
      if (segment.text.trim().isEmpty) continue;
      if (!segment.isEnglish &&
          await voiceForLanguage(segment.languageTag!) == null) {
        final fallback = segment.fallback;
        if (fallback == null || fallback.trim().isEmpty) continue;
        spokenSegments.add('en:$fallback');
        lastSpoken = fallback;
        continue;
      }
      spokenSegments.add('${segment.languageTag ?? 'en'}:${segment.text}');
      lastSpoken = segment.text;
    }
    stopped = false;
  }

  @override
  Future<VoiceOption?> voiceForLanguage(String languageTag) async {
    final language = normalizeTtsLocale(languageTag).split('-').first;
    for (final voice in voices) {
      if (voice.locale.split('-').first == language) return voice;
    }
    return null;
  }
}

class SpeechController extends ChangeNotifier {
  SpeechController({SpeechEngine? engine})
      : _engine = engine ?? TtsSpeechEngine() {
    _engine.setCompletionHandler(_onIdle);
    _engine.setErrorHandler((_) => _onIdle());
  }

  final SpeechEngine _engine;
  bool _speaking = false;
  String? _activeKey;
  List<VoiceOption>? _voices;

  bool get isSpeaking => _speaking;
  String? get activeKey => _activeKey;

  /// Null until [loadVoices] has run at least once.
  List<VoiceOption>? get voices => _voices;

  bool isSpeakingKey(String key) => _speaking && _activeKey == key;

  Future<List<VoiceOption>> loadVoices() async {
    final found = await _engine.englishVoices();
    _voices = found;
    notifyListeners();
    return found;
  }

  Future<void> applyPreferences({String? voiceName, double? rate}) =>
      _engine.applyPreferences(voiceName: voiceName, rate: rate);

  Future<VoiceOption?> voiceForLanguage(String languageTag) =>
      _engine.voiceForLanguage(languageTag);

  Future<void> toggleSegments(String key, List<SpeechSegment> segments) async {
    if (isSpeakingKey(key)) {
      await stop();
      return;
    }
    await speakSegments(key, segments);
  }

  /// Speaks an entry that is part English, part translated. Segments with no
  /// installed voice are dropped by the engine rather than mispronounced.
  Future<void> speakSegments(String key, List<SpeechSegment> segments) async {
    final wanted = [
      for (final segment in segments)
        if (segment.text.trim().isNotEmpty) segment,
    ];
    if (wanted.isEmpty) return;
    final resolved = [
      for (final segment in await _settleGroups(wanted))
        if (asSpoken(segment.text).isNotEmpty)
          SpeechSegment(
            asSpoken(segment.text),
            languageTag: segment.languageTag,
            fallback: segment.fallback == null
                ? null
                : asSpoken(segment.fallback!),
            group: segment.group,
          ),
    ];
    if (resolved.isEmpty) return;
    await _engine.stop();
    _activeKey = key;
    _speaking = true;
    notifyListeners();
    try {
      await _engine.speakSegments(resolved);
    } catch (_) {
      _onIdle();
    }
  }

  /// Decides the fate of each passage before a word of it is spoken.
  ///
  /// A passage cut into pieces around the English it quotes has to be judged
  /// whole: if the device cannot speak its language, the English fallback
  /// stands in for all of it. Deciding piece by piece would say the quoted
  /// English first and then repeat it inside the fallback.
  Future<List<SpeechSegment>> _settleGroups(
    List<SpeechSegment> segments,
  ) async {
    final speakable = <String, bool>{};
    final lost = <Object>{};
    for (final segment in segments) {
      final group = segment.group;
      if (group == null || segment.isEnglish) continue;
      final tag = segment.languageTag!;
      var known = speakable[tag];
      if (known == null) {
        try {
          known = await _engine.voiceForLanguage(tag) != null;
        } catch (_) {
          // Let the engine make its own call segment by segment.
          known = true;
        }
        speakable[tag] = known;
      }
      if (!known) lost.add(group);
    }
    if (lost.isEmpty) return segments;

    final settled = <SpeechSegment>[];
    final replaced = <Object>{};
    for (final segment in segments) {
      final group = segment.group;
      if (group == null || !lost.contains(group)) {
        settled.add(segment);
        continue;
      }
      if (!replaced.add(group)) continue;
      final fallback = segments
          .firstWhere(
            (piece) => piece.group == group && piece.fallback != null,
            orElse: () => const SpeechSegment(''),
          )
          .fallback;
      if (fallback != null && fallback.trim().isNotEmpty) {
        settled.add(SpeechSegment(fallback));
      }
    }
    return settled;
  }

  Future<void> toggle(String key, String text) async {
    if (isSpeakingKey(key)) {
      await stop();
      return;
    }
    await speak(key, text);
  }

  Future<void> speak(String key, String text) async {
    final trimmed = asSpoken(text);
    if (trimmed.isEmpty) return;
    await _engine.stop();
    _activeKey = key;
    _speaking = true;
    notifyListeners();
    try {
      await _engine.speak(trimmed);
    } catch (_) {
      _onIdle();
    }
  }

  Future<void> stop() async {
    if (!_speaking && _activeKey == null) {
      await _engine.stop();
      return;
    }
    _speaking = false;
    _activeKey = null;
    notifyListeners();
    try {
      await _engine.stop();
    } catch (_) {}
  }

  void _onIdle() {
    if (!_speaking && _activeKey == null) return;
    _speaking = false;
    _activeKey = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _engine.stop();
    super.dispose();
  }
}
