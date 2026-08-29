import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';

const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech & Rhetoric"}],
  "words": [
    {
      "id": "edulcorate",
      "word": "Edulcorate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-DUL-cor-ate",
      "definition": "To sweeten or purify.",
      "friendly": "To take the bitterness out of something.",
      "example": "The editor edulcorated the review.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "edulcorare",
      "roots": [{"form": "dulcis", "meaning": "sweet"}]
    }
  ]
}
''';

/// Parchment and candlelight change over in one frame.
///
/// Material's own theme animation crossfades each colour separately, in sRGB.
/// Between two palettes this far apart that is not a crossfade of the page but
/// sixty crossfades at once: halfway through, the parchment, the cards and the
/// text had all arrived at much the same grey, the page was a fog with its own
/// words invisible inside it, and the three soft blooms behind it slid through
/// the fog as the gradient's stops crossed at their own rates. On the Study
/// page — six stacked cards and a control that changes the theme under your
/// finger — it read as a light moving over the screen.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpApp(WidgetTester tester, SettingsController settings) async {
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();
  }

  Color themeBackground(WidgetTester tester) {
    final context = tester.element(find.byType(Scaffold).first);
    return Theme.of(context).extension<BrandColors>()!.background;
  }

  testWidgets('the page arrives at candlelight in a single frame',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsController(await SharedPreferences.getInstance());
    await pumpApp(tester, settings);
    expect(themeBackground(tester), BrandColors.light.background);

    await settings.setThemeMode(ThemeMode.dark);
    await tester.pump();

    // No half-lit frame in between: the very next frame is candlelight.
    expect(themeBackground(tester), BrandColors.dark.background);
  });

  testWidgets('the settings do not hop when the light changes', (tester) async {
    // A rebuild must not disturb what is already on the page. The row that
    // offers a Dutch voice waits on the engine, and while it waits it is
    // nothing at all — so re-asking on every rebuild took the row out and
    // dropped everything below it up the page for as long as the answer took.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );
    await settings.setLocaleId('nl-NL');

    await tester.binding.setSurfaceSize(const Size(800, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(
          engine: SilentSpeechEngine(
            voices: const [VoiceOption(name: 'nl-x', locale: 'nl-NL')],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The same icon marks the Home shortcut, so aim at the tab itself.
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byIcon(Icons.auto_stories_outlined),
      ),
    );
    await tester.pumpAndSettle();

    final rows = find.byType(SwitchListTile);
    final settled = tester.widgetList(rows).length;
    expect(settled, greaterThan(0));

    await settings.setThemeMode(ThemeMode.dark);
    await tester.pump();

    expect(tester.widgetList(rows).length, settled);
  });

  testWidgets('and back to parchment the same way', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsController(await SharedPreferences.getInstance());
    await settings.setThemeMode(ThemeMode.dark);
    await pumpApp(tester, settings);
    expect(themeBackground(tester), BrandColors.dark.background);

    await settings.setThemeMode(ThemeMode.light);
    await tester.pump();

    expect(themeBackground(tester), BrandColors.light.background);
  });
}
