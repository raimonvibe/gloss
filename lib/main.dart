import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/word_repository.dart';
import 'state/progress_controller.dart';
import 'state/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = await WordRepository.load();
  runApp(
    GlossApp(
      settings: SettingsController(prefs),
      progress: ProgressController(prefs),
      repository: repository,
    ),
  );
}
