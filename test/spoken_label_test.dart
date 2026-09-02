import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/models/respelling.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/word_card.dart';

/// A respelling is spoken by more than the app's own voice.
///
/// `spokenRespelling` fixed what [SpeakButton] says. It cannot reach the
/// other reader: the respelling is also *drawn on the page*, and a screen
/// reader — TalkBack, VoiceOver — says whatever is drawn. `py-uh-TISS-tik`
/// on screen is read by TalkBack the way the engine read it before the fix,
/// letter names and hyphens included, in an app that has just said it
/// correctly out of its own button.
///
/// So every place the respelling is drawn carries `semanticsLabel:` with the
/// spoken form, and this test is what keeps a new screen from forgetting.
/// It walks the app with the real 134 words and fails on any respelling
/// drawn without one.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  final respellings = <String>{
    for (final word
        in (jsonDecode(File('assets/data/words.json').readAsStringSync())
            as Map<String, dynamic>)['words'] as List)
      (word as Map<String, dynamic>)['pronunciation'] as String,
  };

  /// Every respelling drawn right now must say how it is spoken.
  void expectEveryRespellingLabelled(WidgetTester tester, String where) {
    var seen = 0;
    for (final text in tester.widgetList<Text>(find.byType(Text))) {
      final drawn = text.data;
      if (drawn == null || !respellings.contains(drawn)) continue;
      seen++;
      expect(
        text.semanticsLabel,
        spokenRespelling(drawn),
        reason: '$where draws "$drawn" with nothing for a screen reader to '
            'say — give the Text a semanticsLabel of its spoken form',
      );
    }
    expect(seen, greaterThan(0), reason: '$where drew no respelling at all');
  }

  testWidgets('every respelling on screen says how it is spoken', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(
      prefs,
      catalog: LocaleCatalog.fromJsonString(
        File('l10n/catalog.json').readAsStringSync(),
      ),
    );
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(
          File('assets/data/words.json').readAsStringSync(),
        ),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    // The word of the day, on the home page.
    expectEveryRespellingLabelled(tester, 'the home page');

    // The cards in the lexicon.
    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    expectEveryRespellingLabelled(tester, 'the lexicon');

    // The card at the top of a word's own page.
    await tester.tap(find.byType(WordCard).first);
    await tester.pumpAndSettle();
    expectEveryRespellingLabelled(tester, "a word's page");
  });
}
