import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/screens/study_screen.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';

/// The study page's "Hear it" tries the voice out.
///
/// It used to speak a line written into the source, in English, whatever the
/// reader had chosen — so the one control that exists to answer "does this
/// voice work?" could not answer it for the reader's own language.
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<SilentSpeechEngine> openStudy(
    WidgetTester tester, {
    required bool readInDutch,
  }) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:locale': 'nl-NL',
      'beautiful-words:read-translation': readInDutch,
    });
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );
    final engine = SilentSpeechEngine(
      voices: const [VoiceOption(name: 'nl-nl-x-dma', locale: 'nl-NL')],
    );
    final repo = (await tester.runAsync(() async {
      final loaded = await WordRepository.load();
      await loaded.applyLocale('nl');
      return loaded;
    }))!;

    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: ProgressController(prefs)),
          ChangeNotifierProvider.value(value: repo),
          ChangeNotifierProvider.value(value: SpeechController(engine: engine)),
        ],
        child: MaterialApp(
          locale: const Locale('nl'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: ThemeData(
            useMaterial3: true,
            extensions: const [BrandColors.light],
          ),
          home: Scaffold(
            body: StudyScreen(
              onShare: (_) async => true,
              onShareText: (_) async => true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final hearIt = find.text(
      AppLocalizations.of(tester.element(find.byType(StudyScreen))).hearIt,
    );
    await tester.scrollUntilVisible(hearIt, 200);
    await tester.tap(hearIt);
    await tester.pumpAndSettle();
    return engine;
  }

  testWidgets('the preview reads a real entry in both voices', (tester) async {
    final engine = await openStudy(tester, readInDutch: true);
    final heard = engine.spokenSegments;

    expect(heard, isNotEmpty, reason: 'the preview said nothing');
    // The lemma is English and stays English, as it does everywhere.
    expect(heard.first, contains('e dul kuh rate'));
    // And the half the switch is about actually reaches the Dutch voice,
    // which is the only way to hear whether that voice works.
    expect(
      heard.where((segment) => segment.startsWith('nl-NL:')),
      isNotEmpty,
      reason: 'the preview never asked for the Dutch voice',
    );
  });

  testWidgets('with the switch off the preview stays English', (tester) async {
    final engine = await openStudy(tester, readInDutch: false);
    final heard = engine.spokenSegments;

    expect(heard, isNotEmpty);
    expect(heard.join(' '), contains('e dul kuh rate'));
    expect(
      heard.where((segment) => segment.startsWith('nl-NL:')),
      isEmpty,
      reason: 'the switch is off; nothing should ask for a Dutch voice',
    );
  });
}
