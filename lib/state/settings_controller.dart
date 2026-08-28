import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/locale_catalog.dart';

const _themeKey = 'beautiful-words:theme';
const _localeKey = 'beautiful-words:locale';

class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs, {LocaleCatalog? catalog})
      : catalog = catalog ?? LocaleCatalog.englishOnly {
    _themeMode = _parse(_prefs.getString(_themeKey));
    _localeId = _prefs.getString(_localeKey);
  }

  final SharedPreferences _prefs;
  final LocaleCatalog catalog;
  late ThemeMode _themeMode;
  String? _localeId;

  ThemeMode get themeMode => _themeMode;
  String? get savedLocaleId => _localeId;

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
