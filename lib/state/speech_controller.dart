import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  final english = <({String name, String locale})>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null || name.isEmpty) continue;
    if (!isEnglishTtsLocale(locale)) continue;
    english.add((name: name, locale: locale));
  }
  if (english.isEmpty) return null;

  int score(({String name, String locale}) voice) {
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
      .replaceAll('"', '&quot;');
  return '<speak xml:lang="en-US">$escaped</speak>';
}

bool get _isAndroid =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

/// flutter_tts rates are 0..1 on Android and read as roughly half speed at
/// 0.5. The shipped default is deliberate — 0.42, for unfamiliar words.
const kMinSpeechRate = 0.25;
const kMaxSpeechRate = 0.75;
const kDefaultSpeechRate = 0.42;

/// One installed English voice the reader may choose between.
class VoiceOption {
  const VoiceOption({required this.name, required this.locale});

  final String name;
  final String locale;

  /// 'en-gb-x-gbb-local' → 'English (United Kingdom)' is beyond us, but the
  /// raw locale plus a tidied name is enough to tell two voices apart.
  String get label {
    final tidy = name.replaceAll('_', ' ').replaceAll('#', ' ').trim();
    return '$tidy · $locale';
  }
}

/// English voices only, sorted so the likeliest pick sits first. The lexicon
/// is English; offering a Dutch voice here would undo the language lock.
List<VoiceOption> englishVoiceOptions(Iterable<Map<dynamic, dynamic>> voices) {
  final seen = <String>{};
  final options = <VoiceOption>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null) continue;
    if (!isEnglishTtsLocale(locale)) continue;
    if (!seen.add(name)) continue;
    options.add(VoiceOption(name: name, locale: normalizeTtsLocale(locale)));
  }
  options.sort((a, b) {
    final byLocale = a.locale.compareTo(b.locale);
    return byLocale != 0 ? byLocale : a.name.compareTo(b.name);
  });
  return options;
}

/// One stretch of speech in one language.
///
/// A [languageTag] of null means English, the lexicon's own language and the
/// only one the lemma may be pronounced in.
class SpeechSegment {
  const SpeechSegment(this.text, {this.languageTag, this.fallback});

  final String text;
  final String? languageTag;

  /// Spoken in English when the device has no voice for [languageTag].
  /// Without one the segment is simply skipped.
  final String? fallback;

  bool get isEnglish => languageTag == null;
}

/// Best installed voice for a BCP-47 tag: an exact locale match first, then
/// any voice for the same language. Offline voices beat network ones.
VoiceOption? pickVoiceForLanguage(
  Iterable<Map<dynamic, dynamic>> voices,
  String languageTag,
) {
  final wanted = normalizeTtsLocale(languageTag);
  final language = wanted.split('-').first;
  final candidates = <VoiceOption>[];
  for (final voice in voices) {
    final name = voice['name']?.toString();
    final locale = voice['locale']?.toString();
    if (name == null || locale == null || name.isEmpty) continue;
    final normalized = normalizeTtsLocale(locale);
    if (normalized != wanted && normalized.split('-').first != language) {
      continue;
    }
    candidates.add(VoiceOption(name: name, locale: normalized));
  }
  if (candidates.isEmpty) return null;

  int score(VoiceOption voice) {
    var value = voice.locale == wanted ? 40 : 20;
    final name = voice.name.toLowerCase();
    if (name.contains('local')) value += 15;
    if (name.contains('network') || name.contains('online')) value -= 10;
    return value;
  }

  candidates.sort((a, b) => score(b).compareTo(score(a)));
  return candidates.first;
}

/// Platform TTS. Tests inject [SilentSpeechEngine].
abstract class SpeechEngine {
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
  TtsSpeechEngine() {
    _ready = _configure();
  }

  final FlutterTts _tts = FlutterTts();
  late final Future<void> _ready;
  var _useEnglishSsml = false;
  String? _preferredVoiceName;
  double _rate = kDefaultSpeechRate;

  Future<void> _configure() async {
    try {
      if (_isIOS) {
        await _tts.setSharedInstance(true);
      }
      if (_isAndroid) {
        await _preferGoogleEngine();
      }
      await _tts.setSpeechRate(_rate);
      await _tts.setPitch(1.0);
      // flutter_tts Android init applies the *device* default voice (Dutch).
      // Lock English after that callback has finished.
      await _lockToEnglish();
    } catch (_) {
      // Linux/desktop and tests may lack a TTS backend.
    }
  }

  Future<void> _preferGoogleEngine() async {
    try {
      final engines = await _tts.getEngines;
      if (engines is! List) return;
      final engine = pickPreferredTtsEngine(engines.map((e) => e.toString()));
      if (engine == null) return;
      await _tts.setEngine(engine);
      _useEnglishSsml = engine.toLowerCase().contains('google');
    } catch (_) {}
  }

  /// Device language (Dutch, etc.) must not drive pronunciation.
  Future<void> _lockToEnglish() async {
    var language = 'en-US';
    try {
      final languages = await _tts.getLanguages;
      if (languages is List) {
        final picked = pickEnglishLanguage(
          languages.map((code) => code.toString()),
        );
        if (picked != null) language = picked;
      }
    } catch (_) {}

    for (final candidate in [language, ...kPreferredEnglishLocales]) {
      try {
        final available = await _tts.isLanguageAvailable(candidate);
        if (available == false) continue;
        final result = await _tts.setLanguage(candidate);
        if (result == 0 || result == false) continue;
        break;
      } catch (_) {}
    }

    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return;
      final english = voices.whereType<Map>();
      final chosen = _chooseVoice(english);
      if (chosen != null) {
        await _tts.setVoice(chosen);
      }
    } catch (_) {}
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
    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return const [];
      return englishVoiceOptions(voices.whereType<Map>());
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<void> applyPreferences({String? voiceName, double? rate}) async {
    await _ready;
    _preferredVoiceName = voiceName;
    if (rate != null) _rate = rate;
    try {
      await _tts.setSpeechRate(_rate);
      await _lockToEnglish();
    } catch (_) {}
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
  Future<void> _speakAndWait(String text) {
    _segmentDone = Completer<void>();
    final waiting = _segmentDone!.future;
    _tts.speak(text);
    return waiting.timeout(
      const Duration(seconds: 90),
      onTimeout: () {},
    );
  }

  @override
  Future<void> speak(String text) async {
    await _ready;
    await _lockToEnglish();
    final utterance = _useEnglishSsml ? wrapEnglishSsml(text) : text;
    await _tts.speak(utterance);
  }

  @override
  Future<void> stop() async {
    await _ready;
    _inSequence = false;
    _finishSegment();
    await _tts.stop();
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
          final utterance =
              _useEnglishSsml ? wrapEnglishSsml(segment.text) : segment.text;
          await _speakAndWait(utterance);
        } else {
          final applied = await _useLanguage(segment.languageTag!);
          if (applied) {
            await _speakAndWait(segment.text);
          } else {
            // Never let the English voice loose on translated text. Say the
            // English version instead, or nothing at all.
            final fallback = segment.fallback;
            if (fallback == null || fallback.trim().isEmpty) continue;
            await _lockToEnglish();
            await _speakAndWait(
              _useEnglishSsml ? wrapEnglishSsml(fallback) : fallback,
            );
          }
        }
        if (!_inSequence) break;
      }
    } catch (_) {
      // A failed segment should not strand the sequence.
    } finally {
      _inSequence = false;
      try {
        await _lockToEnglish();
      } catch (_) {}
      _onDone?.call();
    }
  }

  /// Points the engine at [languageTag]. False when the device has no voice
  /// for it, which is common for the smaller languages in the catalog.
  Future<bool> _useLanguage(String languageTag) async {
    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return false;
      final voice = pickVoiceForLanguage(voices.whereType<Map>(), languageTag);
      if (voice == null) return false;
      await _tts.setLanguage(voice.locale);
      await _tts.setVoice({'name': voice.name, 'locale': voice.locale});
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<VoiceOption?> voiceForLanguage(String languageTag) async {
    await _ready;
    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return null;
      return pickVoiceForLanguage(voices.whereType<Map>(), languageTag);
    } catch (_) {
      return null;
    }
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
    await _engine.stop();
    _activeKey = key;
    _speaking = true;
    notifyListeners();
    try {
      await _engine.speakSegments(wanted);
    } catch (_) {
      _onIdle();
    }
  }

  Future<void> toggle(String key, String text) async {
    if (isSpeakingKey(key)) {
      await stop();
      return;
    }
    await speak(key, text);
  }

  Future<void> speak(String key, String text) async {
    final trimmed = text.trim();
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
