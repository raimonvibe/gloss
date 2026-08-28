import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'beautiful-words:theme';

class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs) {
    _themeMode = _parse(_prefs.getString(_themeKey));
  }

  final SharedPreferences _prefs;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    await _prefs.setString(_themeKey, mode.name);
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
