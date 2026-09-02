import 'dart:io';

import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/app.dart';
import 'package:beautiful_words/branding.dart';
import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/locale_catalog.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/screens/study_screen.dart';
import 'package:beautiful_words/state/progress_controller.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';
import 'package:beautiful_words/widgets/card_surface.dart';
import 'package:beautiful_words/widgets/etymology_card.dart';
import 'package:beautiful_words/widgets/multiple_choice.dart';
import 'package:beautiful_words/widgets/progress_tracker.dart';
import 'package:beautiful_words/widgets/social_row.dart';
import 'package:beautiful_words/widgets/speak_button.dart';
import 'package:beautiful_words/widgets/theme_toggle.dart';

const _sample = WordEntry(
  id: 'edulcorate',
  word: 'Edulcorate',
  partOfSpeech: 'verb',
  pronunciation: 'ee-DUL-cor-ate',
  definition: 'To sweeten or purify.',
  friendly: 'To take the bitterness out.',
  example: 'The editor edulcorated the review.',
  tags: ['speech'],
  origin: 'Latin',
  originWord: 'edulcorare',
  roots: [WordRoot(form: 'dulcis', meaning: 'sweet')],
);

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
    },
    {
      "id": "garrulous",
      "word": "Garrulous",
      "variants": [],
      "partOfSpeech": "adjective",
      "pronunciation": "GAIR-uh-lus",
      "definition": "Excessively talkative.",
      "friendly": "Just won't stop chatting.",
      "example": "The garrulous cab driver talked the whole way.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "garrulus",
      "roots": [{"form": "garrire", "meaning": "to chatter"}]
    },
    {
      "id": "mendicant",
      "word": "Mendicant",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "MEN-dih-kunt",
      "definition": "A beggar, or one living on alms.",
      "friendly": "Someone who lives by asking for charity.",
      "example": "The mendicant friars owned nothing.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "mendicans",
      "roots": [{"form": "mendicare", "meaning": "to beg"}]
    },
    {
      "id": "paroxysm",
      "word": "Paroxysm",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "PARR-uk-siz-um",
      "definition": "A sudden violent outburst.",
      "friendly": "A sudden intense burst of emotion.",
      "example": "A paroxysm of laughter.",
      "tags": ["speech"],
      "origin": "Greek",
      "originWord": "paroxysmos",
      "roots": [{"form": "oxys", "meaning": "sharp"}]
    }
  ]
}
''';

Widget _brandWrap(Widget child) {
  return MaterialApp(
    locale: const Locale('en'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: ThemeData(
      useMaterial3: true,
      extensions: const [BrandColors.light],
    ),
    home: Scaffold(body: child),
  );
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('etymology card shows word, origin, and roots', (tester) async {
    await tester.pumpWidget(_brandWrap(const EtymologyCard(entry: _sample)));
    expect(find.text('Edulcorate'), findsOneWidget);
    expect(find.text('Latin'), findsOneWidget);
    expect(find.text('dulcis'), findsOneWidget);
    expect(find.text('sweet'), findsOneWidget);
  });

  testWidgets('multiple choice marks the right and wrong answers', (tester) async {
    int? selected;
    await tester.pumpWidget(
      _brandWrap(
        StatefulBuilder(
          builder: (context, setState) {
            return MultipleChoice(
              options: const ['Right meaning', 'Wrong one', 'Also wrong', 'No'],
              correctIndex: 0,
              selectedIndex: selected,
              onSelect: (index) => setState(() => selected = index),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Wrong one'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
  });

  testWidgets('progress tracker reports current of total', (tester) async {
    await tester.pumpWidget(
      _brandWrap(const ProgressTracker(current: 3, total: 10, label: '3 of 10')),
    );
    expect(find.text('3 of 10'), findsOneWidget);
    expect(find.text('30%'), findsOneWidget);
  });

  testWidgets('theme toggle persists light and dark preference', (tester) async {
    SharedPreferences.setMockInitialValues({
      'beautiful-words:theme': 'light',
    });
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: settings,
        child: _brandWrap(const ThemeToggle()),
      ),
    );

    expect(settings.themeMode, ThemeMode.light);
    await tester.tap(find.byTooltip('Switch to dark mode'));
    await tester.pumpAndSettle();
    expect(settings.themeMode, ThemeMode.dark);
    expect(prefs.getString('beautiful-words:theme'), 'dark');
  });

  testWidgets('app shell shows the lexicon home', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final engine = SilentSpeechEngine();

    await tester.pumpWidget(
      GlossApp(
        settings: SettingsController(prefs),
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: engine),
      ),
    );
    await tester.pump();

    expect(find.text('Gloss'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Start a quiz'), 400);
    expect(find.text('Start a quiz'), findsOneWidget);
    expect(find.text('Explore the lexicon'), findsOneWidget);
  });

  testWidgets('listen reads the word of the day on demand', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final engine = SilentSpeechEngine();
    final repo = WordRepository.fromJsonString(_fixture);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: SettingsController(prefs),
        progress: ProgressController(prefs),
        repository: repo,
        speech: SpeechController(engine: engine),
      ),
    );
    await tester.pump();
    final listen = find.descendant(
      of: find.ancestor(
        of: find.text('word of the day'),
        matching: find.byType(GildedFrame),
      ),
      matching: find.byTooltip('Listen'),
    );
    await tester.tap(listen);
    await tester.pump();

    expect(engine.lastSpoken, contains(repo.wordOfTheDay().word));
    expect(engine.lastSpoken, contains(repo.wordOfTheDay().friendly));
  });

  testWidgets('quiz by theme lists categories and starts a themed round', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      GlossApp(
        settings: SettingsController(prefs),
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Begin'), findsOneWidget);

    await tester.tap(find.text('Quiz by theme'));
    await tester.pumpAndSettle();
    expect(find.text('Speech & Rhetoric'), findsOneWidget);

    await tester.tap(find.text('Speech & Rhetoric'));
    await tester.pumpAndSettle();
    expect(find.text('which definition fits?'), findsOneWidget);
    expect(find.text('Quiz by theme'), findsNothing);
  });

  testWidgets('theme picker shows an empty state when there are no themes', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    const emptyThemes = '''
{
  "categories": [],
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
    },
    {
      "id": "garrulous",
      "word": "Garrulous",
      "variants": [],
      "partOfSpeech": "adjective",
      "pronunciation": "GAIR-uh-lus",
      "definition": "Excessively talkative.",
      "friendly": "Just won't stop chatting.",
      "example": "The garrulous cab driver talked the whole way.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "garrulus",
      "roots": [{"form": "garrire", "meaning": "to chatter"}]
    },
    {
      "id": "mendicant",
      "word": "Mendicant",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "MEN-dih-kunt",
      "definition": "A beggar, or one living on alms.",
      "friendly": "Someone who lives by asking for charity.",
      "example": "The mendicant friars owned nothing.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "mendicans",
      "roots": [{"form": "mendicare", "meaning": "to beg"}]
    },
    {
      "id": "paroxysm",
      "word": "Paroxysm",
      "variants": [],
      "partOfSpeech": "noun",
      "pronunciation": "PARR-uk-siz-um",
      "definition": "A sudden violent outburst.",
      "friendly": "A sudden intense burst of emotion.",
      "example": "A paroxysm of laughter.",
      "tags": ["speech"],
      "origin": "Greek",
      "originWord": "paroxysmos",
      "roots": [{"form": "oxys", "meaning": "sharp"}]
    }
  ]
}
''';

    await tester.pumpWidget(
      GlossApp(
        settings: SettingsController(prefs),
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(emptyThemes),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quiz by theme'));
    await tester.pumpAndSettle();
    expect(find.text('No themes yet.'), findsOneWidget);
  });

  testWidgets('speak button toggles listen and stop', (tester) async {
    final engine = SilentSpeechEngine();
    final speech = SpeechController(engine: engine);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: speech,
        child: _brandWrap(
          const SpeakButton(speechKey: 'demo', text: 'Edulcorate'),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Listen'));
    await tester.pump();
    expect(engine.lastSpoken, 'Edulcorate');
    expect(speech.isSpeaking, isTrue);
    expect(find.byTooltip('Stop'), findsOneWidget);

    await tester.tap(find.byTooltip('Stop'));
    await tester.pump();
    expect(speech.isSpeaking, isFalse);
  });

  testWidgets('study opens languages, searches, and persists a locale', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final catalog = LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    );
    final settings = SettingsController(prefs, catalog: catalog);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();

    // Languages now lives inside the study rather than on the nav bar.
    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Languages'));
    await tester.pumpAndSettle();
    expect(find.text('the tongues'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Nederlands');
    await tester.pumpAndSettle();
    expect(find.text('Netherlands'), findsWidgets);

    await tester.tap(find.text('Netherlands').first);
    await tester.pumpAndSettle();
    expect(settings.savedLocaleId, 'nl-NL');

    // Pop the pushed languages page before returning to the nav bar.
    // Not pageBack(): it matches on the 'Back' tooltip, which is Dutch now.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Begin een quiz'), 400);
    expect(find.text('Begin een quiz'), findsOneWidget);
  });

  testWidgets('study gathers reading, voice, light, and the maker\'s links', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    // The globe went to the study and stayed there. The light switch came
    // back to the home header, where the reader looked for it.
    expect(find.byType(ThemeToggle), findsOneWidget);
    expect(settings.themeMode, ThemeMode.system);
    await tester.tap(find.byType(ThemeToggle));
    await tester.pumpAndSettle();
    expect(settings.themeMode, isNot(ThemeMode.system));

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    expect(find.text('The study'), findsOneWidget);
    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('Voice'), findsWidgets);
    expect(find.text('Light'), findsOneWidget);
    expect(find.byType(SocialRow), findsOneWidget);

    // Enlarging the text scales the whole app, not just the sample line.
    final before = tester.firstWidget<Text>(find.text('The study'));
    await tester.drag(find.byType(Slider).first, const Offset(200, 0));
    await tester.pumpAndSettle();
    expect(settings.textScale, greaterThan(1.0));
    expect(
      tester.firstWidget<Text>(find.text('The study')).runtimeType,
      before.runtimeType,
    );

    // Calming the ornaments removes the corner flourishes.
    await tester.tap(find.text('Calm the ornaments'));
    await tester.pumpAndSettle();
    expect(settings.reduceMotion, isTrue);
  });

  testWidgets('language continents fold away and search reaches inside', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final catalog = LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    );
    final settings = SettingsController(prefs, catalog: catalog);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Languages'));
    await tester.pumpAndSettle();

    // Every continent header is present, but 177 countries are not: the
    // sections start shut so the list is short enough to scan.
    // Albania heads the European list, so it is on screen whenever the
    // section is open - Netherlands sits 26th of 42 and would not be.
    expect(find.text('Europe'), findsOneWidget);
    expect(find.text('Albania'), findsNothing);

    await tester.tap(find.text('Europe'));
    await tester.pumpAndSettle();
    expect(find.text('Albania'), findsWidgets);

    await tester.tap(find.text('Europe'));
    await tester.pumpAndSettle();
    expect(find.text('Albania'), findsNothing);

    // A match in a shut continent must still surface, or search looks broken.
    await tester.enterText(find.byType(TextField), 'Netherlands');
    await tester.pumpAndSettle();
    expect(find.text('Netherlands'), findsWidgets);
  });

  testWidgets('choosing Dutch names the Netherlands, not Aruba', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final catalog = LocaleCatalog.fromJsonString(
      File('l10n/catalog.json').readAsStringSync(),
    );
    final settings = SettingsController(prefs, catalog: catalog);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Languages'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Nederlands');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Netherlands').first);
    await tester.pumpAndSettle();

    expect(settings.savedLocaleId, 'nl-NL');

    // The card at the top of the picker names the chosen country. Aruba also
    // reads Dutch and sorts first, which is what used to be shown there.
    // Aruba still belongs in the Americas list, so scope this to that card:
    // it is the first CardSurface, sitting above the search field.
    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();
    final selectedCard = find.byType(CardSurface).first;
    expect(
      find.descendant(of: selectedCard, matching: find.text('Netherlands')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: selectedCard, matching: find.text('Aruba')),
      findsNothing,
    );
  });

  testWidgets('theme labels stay on one line at the largest text size', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs);

    // A narrow screen and the biggest text the app allows - three theme
    // labels used to wrap here, splitting words mid-word ('Perkamen/t').
    await tester.binding.setSurfaceSize(const Size(360, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await settings.setTextScale(2.0);

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    final segmented = find.byType(SegmentedButton<ThemeMode>);
    // Light sits well down a page that is very long at this text size, and a
    // ListView only builds what is near the viewport.
    if (segmented.evaluate().isEmpty) {
      await tester.scrollUntilVisible(
        segmented,
        300,
        scrollable: find.byType(Scrollable).last,
        maxScrolls: 60,
      );
      await tester.pumpAndSettle();
    }
    expect(segmented, findsOneWidget);

    for (final label in ['Match device', 'Parchment', 'Candlelight']) {
      final text = find.descendant(of: segmented, matching: find.text(label));
      expect(text, findsOneWidget, reason: '$label missing');

      final widget = tester.widget<Text>(text);
      expect(widget.maxLines, 1, reason: '$label may wrap');
      expect(widget.softWrap, isFalse, reason: '$label may wrap');

      // Scaling down is what keeps a long label whole; without it the label
      // would have to wrap or be cut off.
      expect(
        find.ancestor(of: text, matching: find.byType(FittedBox)),
        findsWidgets,
        reason: '$label cannot shrink to fit',
      );

      // One line of text, however large the reader has set it.
      final box = tester.renderObject<RenderBox>(text);
      expect(
        box.size.height,
        lessThan(60),
        reason: '$label rendered ${box.size.height}px tall - it wrapped',
      );
    }
  });

  testWidgets('clearing progress is confirmed first, and cancel keeps it', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs);
    final progress = ProgressController(prefs);
    await progress.explored.add('edulcorate');
    await progress.favorites.add('edulcorate');

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: progress,
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    final forget = find.text('Forget my progress');
    await tester.scrollUntilVisible(
      forget,
      300,
      scrollable: find.byType(Scrollable).last,
      maxScrolls: 60,
    );
    await tester.pumpAndSettle();

    // Destructive and not undoable, so it must never fire on one tap.
    await tester.tap(forget);
    await tester.pumpAndSettle();
    expect(find.text('Cancel'), findsOneWidget);
    expect(progress.explored.count, 1, reason: 'cleared before confirming');

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(progress.explored.count, 1, reason: 'cancel still cleared it');

    await tester.tap(forget);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Forget'));
    await tester.pumpAndSettle();

    expect(progress.explored.count, 0);
    expect(progress.favorites.count, 1, reason: 'saved words were collateral');
    expect(find.text('Progress forgotten.'), findsOneWidget);
  });

  testWidgets('nothing to clear leaves the rows inert', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsController(prefs);
    final progress = ProgressController(prefs);

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: settings,
        progress: progress,
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    final clear = find.text('Clear saved words');
    await tester.scrollUntilVisible(
      clear,
      300,
      scrollable: find.byType(Scrollable).last,
      maxScrolls: 60,
    );
    await tester.pumpAndSettle();

    // An inert row says "nothing here" more quietly than a dialog that
    // reports it has nothing to do.
    await tester.tap(clear);
    await tester.pumpAndSettle();
    expect(find.text('Cancel'), findsNothing);
  });

  testWidgets('sharing copies the store link and offers the share sheet', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    String? copied;
    Map<Object?, Object?>? sheet;
    final messenger = tester.binding.defaultBinaryMessenger;

    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied = (call.arguments as Map)['text'] as String?;
      }
      return null;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );

    const shareChannel = MethodChannel('dev.fluttercommunity.plus/share');
    messenger.setMockMethodCallHandler(shareChannel, (call) async {
      if (call.method == 'share') sheet = call.arguments as Map<Object?, Object?>;
      return 'dev.fluttercommunity.plus/share/success';
    });
    addTearDown(() => messenger.setMockMethodCallHandler(shareChannel, null));

    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GlossApp(
        settings: SettingsController(prefs),
        progress: ProgressController(prefs),
        repository: WordRepository.fromJsonString(_fixture),
        speech: SpeechController(engine: SilentSpeechEngine()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Study'));
    await tester.pumpAndSettle();

    final share = find.text('Share Gloss');
    await tester.scrollUntilVisible(
      share,
      300,
      scrollable: find.byType(Scrollable).last,
      maxScrolls: 60,
    );
    await tester.pumpAndSettle();
    await tester.tap(share);
    await tester.pumpAndSettle();

    // The link is in hand whatever the reader does with the sheet.
    expect(copied, Branding.storeUrl);
    expect(find.text('Copied to clipboard'), findsOneWidget);

    // And the sheet was offered, carrying that same link.
    expect(sheet, isNotNull);
    expect(sheet!['text'], contains(Branding.storeUrl));
  });

  test('the shared message ends on the link, alone on its line', () {
    final message = shareMessage('a lexicon of lovely language');

    expect(message, contains(Branding.storeName));
    expect(message.split('\n').last, Branding.storeUrl);
  });
}
