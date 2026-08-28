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

  @override
  void setCompletionHandler(VoidCallback handler) {
    _tts.setCompletionHandler(handler);
  }

  @override
  void setErrorHandler(void Function(dynamic message) handler) {
    _tts.setErrorHandler(handler);
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
    await _tts.stop();
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
