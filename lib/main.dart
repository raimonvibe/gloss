import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/word_repository.dart';
import 'l10n/locale_catalog.dart';
import 'state/progress_controller.dart';
import 'state/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final catalog = await LocaleCatalog.load();
  final repository = await WordRepository.load();
  final settings = SettingsController(prefs, catalog: catalog);
  await repository.applyLocale(
    settings.translationKeyFor(
      WidgetsBinding.instance.platformDispatcher.locales,
    ),
  );
  runApp(
    GlossApp(
      settings: settings,
      progress: ProgressController(prefs),
      repository: repository,
    ),
  );
}
