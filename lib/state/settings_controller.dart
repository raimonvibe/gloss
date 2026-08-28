import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/locale_catalog.dart';
import 'speech_controller.dart';

const _themeKey = 'beautiful-words:theme';
const _localeKey = 'beautiful-words:locale';
const _textScaleKey = 'beautiful-words:text-scale';
const _voiceKey = 'beautiful-words:voice';
const _speechRateKey = 'beautiful-words:speech-rate';
const _autoplayKey = 'beautiful-words:autoplay';
const _reduceMotionKey = 'beautiful-words:reduce-motion';

/// Text can grow half again as large before the parchment cards start to
/// clip; below 1.0 the Cormorant body face turns to grit.
const kMinTextScale = 1.0;
const kMaxTextScale = 1.6;

class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs, {LocaleCatalog? catalog})
      : catalog = catalog ?? LocaleCatalog.englishOnly {
    _themeMode = _parse(_prefs.getString(_themeKey));
    _localeId = _prefs.getString(_localeKey);
    _textScale = _clamp(
      _prefs.getDouble(_textScaleKey) ?? 1.0,
      kMinTextScale,
      kMaxTextScale,
    );
    _voiceName = _prefs.getString(_voiceKey);
    _speechRate = _clamp(
      _prefs.getDouble(_speechRateKey) ?? kDefaultSpeechRate,
      kMinSpeechRate,
      kMaxSpeechRate,
    );
    _autoplay = _prefs.getBool(_autoplayKey) ?? false;
    _reduceMotion = _prefs.getBool(_reduceMotionKey) ?? false;
  }

  final SharedPreferences _prefs;
  final LocaleCatalog catalog;
  late ThemeMode _themeMode;
  String? _localeId;
  late double _textScale;
  String? _voiceName;
  late double _speechRate;
  late bool _autoplay;
  late bool _reduceMotion;

  ThemeMode get themeMode => _themeMode;
  String? get savedLocaleId => _localeId;

  double get textScale => _textScale;

  /// Null means "whatever the engine picks", which is still English-locked.
  String? get voiceName => _voiceName;
  double get speechRate => _speechRate;
  bool get autoplayPronunciation => _autoplay;
  bool get reduceMotion => _reduceMotion;

  Future<void> setTextScale(double value) async {
    final next = _clamp(value, kMinTextScale, kMaxTextScale);
    if (next == _textScale) return;
    _textScale = next;
    notifyListeners();
    await _prefs.setDouble(_textScaleKey, next);
  }

  Future<void> setVoiceName(String? name) async {
    if (name == _voiceName) return;
    _voiceName = name;
    notifyListeners();
    if (name == null) {
      await _prefs.remove(_voiceKey);
    } else {
      await _prefs.setString(_voiceKey, name);
    }
  }

  Future<void> setSpeechRate(double value) async {
    final next = _clamp(value, kMinSpeechRate, kMaxSpeechRate);
    if (next == _speechRate) return;
    _speechRate = next;
    notifyListeners();
    await _prefs.setDouble(_speechRateKey, next);
  }

  Future<void> setAutoplayPronunciation(bool value) async {
    if (value == _autoplay) return;
    _autoplay = value;
    notifyListeners();
    await _prefs.setBool(_autoplayKey, value);
  }

  Future<void> setReduceMotion(bool value) async {
    if (value == _reduceMotion) return;
    _reduceMotion = value;
    notifyListeners();
    await _prefs.setBool(_reduceMotionKey, value);
  }

  static double _clamp(double value, double min, double max) =>
      value.isNaN ? min : value.clamp(min, max);

  String localeIdFor(List<Locale> devices) =>
      catalog.resolvedId(_localeId, devices);

  Locale localeFor(List<Locale> devices) =>
      catalog.resolve(_localeId, devices);

  String translationKeyFor(List<Locale> devices) =>
      catalog.translationKeyFor(localeIdFor(devices));

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    await _prefs.setString(_themeKey, mode.name);
  }

  Future<void> setLocaleId(String id) async {
    if (_localeId == id) return;
    _localeId = id;
    notifyListeners();
    await _prefs.setString(_localeKey, id);
  }

  Future<void> cycleTheme(Brightness platformBrightness) async {
    switch (_themeMode) {
      case ThemeMode.system:
        await setThemeMode(
          platformBrightness == Brightness.dark
              ? ThemeMode.light
              : ThemeMode.dark,
        );
      case ThemeMode.light:
        await setThemeMode(ThemeMode.dark);
      case ThemeMode.dark:
        await setThemeMode(ThemeMode.light);
    }
  }

  static ThemeMode _parse(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
