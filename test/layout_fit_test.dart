import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/models/word_entry.dart';
import 'package:beautiful_words/theme/brand_colors.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/etymology_card.dart';
import 'package:beautiful_words/widgets/word_card.dart';

/// The etymology card in all sixty languages, at the smallest phone the app
/// supports and at the largest text size it allows.
///
/// Two things in that card are drawn to a fixed shape and filled with text
/// nobody measured: the headword, which is English and long enough on its own
/// (*Circumincession*), and the origin chips, which are translated and run to
/// 33 characters in Albanian and Belarusian. Both had a way out of their box —
/// the headword by breaking mid-word against the frame, the chip by growing
/// tall enough that the curve of its own pill came in over the words.
///
/// Note the font. A test runs in one whose every glyph is a full em square,
/// half again as wide as the Cormorant and Playfair the app ships, so a label
/// needs far more room here than it does on a device. Anything that holds
/// here holds there.
class _Sample {
  const _Sample(this.key, this.origin, this.partOfSpeech);

  final String key;
  final String origin;
  final String partOfSpeech;
}

/// The worst line each locale has for the two slots, taken from the shipped
/// overlays rather than from a list kept by hand.
List<_Sample> _samples() {
  final samples = <_Sample>[];
  for (final file in Directory('assets/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))) {
    final key = file.uri.pathSegments.last
        .replaceFirst('words_', '')
        .replaceFirst('.json', '');
    final words = (jsonDecode(file.readAsStringSync()) as Map)['words'] as Map;
    var origin = '';
    var pos = '';
    for (final row in words.values) {
      final map = row as Map;
      final o = (map['origin'] ?? '') as String;
      final p = (map['partOfSpeech'] ?? '') as String;
      if (o.length > origin.length) origin = o;
      if (p.length > pos.length) pos = p;
    }
    samples.add(_Sample(key, origin, pos));
  }
  samples.sort((a, b) => a.key.compareTo(b.key));
  return samples;
}

Locale _locale(String key) {
  final parts = key.split('_');
  return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
}

/// The longest headword in the lexicon, wearing one locale's worst labels.
WordEntry _entry(_Sample sample) => WordEntry(
      id: 'circumincession',
      word: 'Circumincession',
      partOfSpeech: sample.partOfSpeech,
      pronunciation: 'sir-cum-in-SESH-un',
      definition: 'The mutual indwelling of the persons of the Trinity.',
      friendly: 'Three that live inside one another.',
      example: 'The homily turned on circumincession.',
      tags: const ['speech'],
      origin: sample.origin,
      originWord: 'circumincessio',
      roots: const [
        WordRoot(form: 'circum', meaning: 'around'),
        WordRoot(form: 'paidagōgos (Greek)', meaning: 'one who leads a child'),
      ],
    );

/// Whether [point] lies inside a rounded rectangle — the pill as it is really
/// drawn, corner radius and all, rather than its bounding box.
bool _insideShape(Rect pill, double radius, Offset point) {
  final r = math.min(radius, math.min(pill.width, pill.height) / 2);
  final core = Rect.fromLTRB(
    pill.left + r,
    pill.top + r,
    pill.right - r,
    pill.bottom - r,
  );
  final nearest = Offset(
    point.dx.clamp(core.left, core.right),
    point.dy.clamp(core.top, core.bottom),
  );
  return (point - nearest).distance <= r + 0.01;
}

/// One card of roots, on the smallest phone the app supports.
Future<void> _pumpRoots(
  WidgetTester tester,
  List<WordRoot> roots, {
  double scale = 1.0,
  Locale locale = const Locale('en'),
}) async {
  await tester.binding.setSurfaceSize(const Size(320, 640));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(scale)),
      child: MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(
          useMaterial3: true,
          extensions: const [BrandColors.light],
        ),
        home: Scaffold(
          body: SingleChildScrollView(
            child: EtymologyCard(
              entry: WordEntry(
                id: 'x',
                word: 'Edulcorate',
                partOfSpeech: 'verb',
                pronunciation: 'ee-DUL-kuh-rate',
                definition: 'd',
                friendly: 'f',
                example: 'e',
                tags: const ['speech'],
                origin: 'Latin',
                originWord: 'edulcorare',
                roots: roots,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  final samples = _samples();

  test('every locale ships an overlay to check', () {
    expect(samples.length, 60);
  });

  for (final scale in <double>[1.0, 2.0]) {
    testWidgets('the card holds its words in every language at ${scale}x',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      for (final sample in samples) {
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: MaterialApp(
              locale: _locale(sample.key),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              theme: ThemeData(
                useMaterial3: true,
                extensions: const [BrandColors.light],
              ),
              home: Scaffold(
                body: SingleChildScrollView(
                  child: EtymologyCard(entry: _entry(sample)),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final where = '${sample.key} at ${scale}x';

        // The headword shrinks to the card rather than breaking against it.
        final card = tester.getRect(find.byType(EtymologyCard));
        final headword = tester.getRect(find.text('Circumincession'));
        expect(headword.left, greaterThanOrEqualTo(card.left),
            reason: 'the headword left the frame in $where');
        expect(headword.right, lessThanOrEqualTo(card.right),
            reason: 'the headword left the frame in $where');

        // A root and its meaning: whichever way round they are laid out,
        // neither may run past the card.
        for (final part in [
          'paidagōgos (Greek)',
          'one who leads a child',
          'circum',
          'around',
        ]) {
          final rect = tester.getRect(find.text(part));
          expect(rect.left, greaterThanOrEqualTo(card.left),
              reason: 'the root "$part" left the frame in $where');
          expect(rect.right, lessThanOrEqualTo(card.right),
              reason: 'the root "$part" left the frame in $where');
        }

        // Both chips: the translated origin, and the English etymon beside it.
        for (final label in [sample.origin, 'circumincessio']) {
          final words = tester.getRect(find.text(label));
          final container = find
              .ancestor(of: find.text(label), matching: find.byType(Container))
              .first;
          final pill = tester.getRect(container);
          final decoration =
              tester.widget<Container>(container).decoration! as BoxDecoration;
          final radius = (decoration.borderRadius!.resolve(TextDirection.ltr))
              .topLeft
              .x;

          for (final corner in [
            words.topLeft,
            words.topRight,
            words.bottomLeft,
            words.bottomRight,
          ]) {
            expect(
              _insideShape(pill, radius, corner),
              isTrue,
              reason: 'the chip "$label" reaches past its pill in $where',
            );
          }
        }
      }
    });
  }

  // The forms used to stand in a column of a fixed 124pt whatever was in it.
  group('a root and its meaning', () {
    testWidgets('share a line while both have room', (tester) async {
      await _pumpRoots(tester, const [
        WordRoot(form: 'dulcis', meaning: 'sweet'),
      ]);

      final form = tester.getRect(find.text('dulcis'));
      final meaning = tester.getRect(find.text('sweet'));
      expect(form.right, lessThanOrEqualTo(meaning.left));
      expect(form.top, closeTo(meaning.top, 4));
    });

    testWidgets('give a long form the whole row rather than a fixed column',
        (tester) async {
      await _pumpRoots(tester, const [
        WordRoot(form: 'paidagōgos (Greek)', meaning: 'one who leads a child'),
      ]);

      final form = tester.getRect(find.text('paidagōgos (Greek)'));
      final meaning = tester.getRect(find.text('one who leads a child'));
      // The column it used to be pinned to was 124pt, and this form never
      // fitted it. It now has the row.
      expect(
        form.width,
        greaterThan(124),
        reason: 'the form was squeezed back into a column (${form.width}px)',
      );
      expect(
        meaning.top,
        greaterThanOrEqualTo(form.bottom - 0.5),
        reason: 'the meaning was left beside a form that fills the row',
      );
    });

    // The form is English and reads left to right wherever it is; on an
    // Arabic page its column is the right-hand one. The air between the two
    // was slack inside that column, which put it on the far side of the
    // form and left the meaning touching it.
    testWidgets('keep the air between them on a right-to-left page',
        (tester) async {
      await _pumpRoots(
        tester,
        const [WordRoot(form: 'eluctari', meaning: 'يناضل للخروج')],
        locale: const Locale('ar'),
      );

      final form = tester.getRect(find.text('eluctari'));
      final meaning = tester.getRect(
        find.text('يناضل للخروج'),
      );

      expect(
        form.left,
        greaterThanOrEqualTo(meaning.right),
        reason: 'the form should stand to the right of its meaning',
      );
      expect(
        form.left - meaning.right,
        greaterThanOrEqualTo(8),
        reason: 'the meaning ran into the form',
      );
      expect(form.top, closeTo(meaning.top, 4));
    });

    testWidgets('stack once the largest text size leaves no room to share',
        (tester) async {
      await _pumpRoots(
        tester,
        const [WordRoot(form: 'dulcis', meaning: 'sweet')],
        scale: 2.0,
      );

      final form = tester.getRect(find.text('dulcis'));
      final meaning = tester.getRect(find.text('sweet'));
      expect(
        meaning.top,
        greaterThanOrEqualTo(form.bottom - 0.5),
        reason: 'the meaning was squeezed in beside the form instead',
      );
      // And with the whole width to itself, it reads on one line.
      expect(meaning.height, lessThan(2 * 16 * 2.0));
    });
  });

  // The lexicon lists the whole 134, and the longest of them broke across
  // two lines in its card — "Circumincessi" above a stranded "on".
  testWidgets('a headword in the lexicon list shrinks rather than breaking',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 780));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    // The card asks who is being read to before it offers to read.
    SharedPreferences.setMockInitialValues(const {});
    final settings = SettingsController(await SharedPreferences.getInstance());

    late TextStyle written;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SpeechController>(
            create: (_) => SpeechController(engine: SilentSpeechEngine()),
          ),
          ChangeNotifierProvider<SettingsController>.value(value: settings),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: ThemeData(
            useMaterial3: true,
            extensions: const [BrandColors.light],
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                written = Theme.of(context).textTheme.titleLarge!;
                return WordCard(
                  entry: _entry(const _Sample('en', 'Latin', 'noun')),
                  isFavorite: false,
                  onOpen: () {},
                  onToggleFavorite: () {},
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final headword = find.text('Circumincession');
    // One line. Two would stand about twice as tall as the type.
    expect(
      tester.getSize(headword).height,
      lessThan(written.fontSize! * 2),
      reason: 'the headword broke across two lines instead of shrinking',
    );
    final card = tester.getRect(find.byType(WordCard));
    final words = tester.getRect(headword);
    expect(words.left, greaterThanOrEqualTo(card.left));
    expect(words.right, lessThanOrEqualTo(card.right));
  });
}
