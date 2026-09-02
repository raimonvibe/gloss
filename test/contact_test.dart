import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/data/word_repository.dart';
import 'package:beautiful_words/l10n/app_localizations.dart';
import 'package:beautiful_words/screens/contact_screen.dart';
import 'package:beautiful_words/state/contact_letter.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/theme/brand_colors.dart';

/// The letter to the maker.
///
/// Three of the page's promises are worth a test each: that a mistyped
/// domain is caught before the reply is lost to it, that an unsent letter
/// survives the page being closed, and that Send hands the whole letter to
/// the mail composer rather than a subject line and a shrug.

/// Three words is the fewest the human check can be asked from, and enough
/// for a test to know which answer is the right one.
const _fixture = '''
{
  "categories": [{"id": "speech", "label": "Speech"}],
  "words": [
    {
      "id": "edulcorate",
      "word": "Edulcorate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-DUL-cor-ate",
      "definition": "To sweeten or purify.",
      "friendly": "To take the bitterness out.",
      "example": "The editor edulcorated the review.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "edulcorare",
      "roots": [{"form": "dulcis", "meaning": "sweet"}]
    },
    {
      "id": "eluctate",
      "word": "Eluctate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "ee-LUCK-tate",
      "definition": "To struggle out of.",
      "friendly": "To fight your way clear.",
      "example": "She eluctated from the crowd.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "eluctari",
      "roots": [{"form": "luctari", "meaning": "to wrestle"}]
    },
    {
      "id": "obumbrate",
      "word": "Obumbrate",
      "variants": [],
      "partOfSpeech": "verb",
      "pronunciation": "OB-um-brate",
      "definition": "To overshadow.",
      "friendly": "To throw a shadow over something.",
      "example": "Clouds obumbrated the hill.",
      "tags": ["speech"],
      "origin": "Latin",
      "originWord": "obumbrare",
      "roots": [{"form": "umbra", "meaning": "shade"}]
    }
  ]
}
''';

const _meanings = {
  'Edulcorate': 'To take the bitterness out.',
  'Eluctate': 'To fight your way clear.',
  'Obumbrate': 'To throw a shadow over something.',
};

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('an address is read before it is trusted', () {
    test('a shape that could be an address, and one that could not', () {
      expect(looksLikeEmail('ada@example.com'), isTrue);
      expect(looksLikeEmail('  ada@example.co.uk '), isTrue);
      expect(looksLikeEmail('ada@example'), isFalse);
      expect(looksLikeEmail('ada'), isFalse);
      expect(looksLikeEmail(''), isFalse);
    });

    test('a slip of two letters is offered a correction', () {
      expect(suggestEmailDomain('ada@gmial.com'), 'gmail.com');
      expect(suggestEmailDomain('ada@yaho.com'), 'yahoo.com');
      expect(suggestEmailDomain('ada@hotmial.com'), 'hotmail.com');
    });

    test('an address that is already right is left alone', () {
      expect(suggestEmailDomain('ada@gmail.com'), isNull);
      // Somebody's employer, not a mistyped gmail.
      expect(suggestEmailDomain('ada@raimonvibe.com'), isNull);
      expect(suggestEmailDomain('ada@some-university.ac.uk'), isNull);
      expect(suggestEmailDomain('ada'), isNull);
    });

    test('taking the correction keeps everything before the @', () {
      expect(
        withEmailDomain('Ada.Lovelace@gmial.com', 'gmail.com'),
        'Ada.Lovelace@gmail.com',
      );
    });
  });

  group('the letter', () {
    test('carries the message, the writer, and the filing', () {
      final letter = composeLetter(
        name: 'Ada',
        email: 'ada@example.com',
        reason: 'A question',
        priority: 'Normal',
        message: '  Where does edulcorate come from?  ',
        details: appDetailsLine(
          version: '1.0.0',
          localeId: 'en-US',
          theme: 'parchment',
          textScalePercent: 100,
          platform: 'android',
        ),
      );

      expect(letter, contains('Where does edulcorate come from?'));
      expect(letter, contains('— Ada <ada@example.com>'));
      expect(letter, contains('A question · Normal'));
      expect(letter, contains('Gloss 1.0.0 · en-US · parchment · text 100%'));
    });

    test('leaves the details out when they were not offered', () {
      final letter = composeLetter(
        name: 'Ada',
        email: 'ada@example.com',
        reason: 'Feedback',
        priority: 'Low',
        message: 'Thank you.',
      );
      expect(letter, isNot(contains('Gloss 1.0.0')));
      expect(letter, endsWith('Feedback · Low'));
    });

    test('reaches the composer with its spaces intact', () {
      final uri = contactMailto(
        subject: 'Gloss: Beautiful Words — A question',
        body: 'Line one\nLine two',
      );

      expect(uri.scheme, 'mailto');
      expect(uri.path, kContactAddress);
      // Uri.queryParameters would write a space as '+', which a mail
      // composer prints literally.
      expect(uri.query, isNot(contains('+')));
      expect(uri.queryParameters['subject'], contains('A question'));
      expect(uri.queryParameters['body'], 'Line one\nLine two');
    });
  });

  group('what the form is told', () {
    test('the category and the priority are English, whatever the page is',
        () {
      final fields = formspreeFields(
        name: '  Ada  ',
        email: ' ada@example.com ',
        reason: englishReason(ContactReason.problem),
        priority: englishPriority(ContactPriority.high),
        message: '  De Nederlandse uitleg klopt niet.  ',
        language: 'nl-NL',
      );

      // The website form's own field names, so both file together.
      expect(fields['name'], 'Ada');
      expect(fields['email'], 'ada@example.com');
      expect(fields['category'], 'Something is wrong');
      expect(fields['priority'], 'High');
      // What the reader wrote stays in the reader's language.
      expect(fields['message'], 'De Nederlandse uitleg klopt niet.');
      expect(fields['language'], 'nl-NL');
      expect(fields['_subject'], 'Gloss — Something is wrong');
      expect(fields.containsKey('details'), isFalse);
    });

    test('details ride along only when they were offered', () {
      final fields = formspreeFields(
        name: 'Ada',
        email: 'ada@example.com',
        reason: englishReason(ContactReason.question),
        priority: englishPriority(ContactPriority.normal),
        message: 'Hello.',
        language: 'en-US',
        details: 'Gloss 1.0.0 · en-US · parchment · text 100% · android',
      );
      expect(fields['details'], contains('Gloss 1.0.0'));
    });

    test('the endpoint is the website form', () {
      expect(formspreeEndpoint.host, 'formspree.io');
      expect(formspreeEndpoint.path, '/f/$kFormspreeForm');
    });
  });

  group('an unsent letter', () {
    test('survives being encoded and read back', () {
      const draft = ContactDraft(
        name: 'Ada',
        email: 'ada@example.com',
        reason: ContactReason.problem,
        priority: ContactPriority.high,
        message: 'The Dutch entry reads oddly.',
        includeDetails: true,
      );
      final read = ContactDraft.decode(draft.encode())!;

      expect(read.name, 'Ada');
      expect(read.email, 'ada@example.com');
      expect(read.reason, ContactReason.problem);
      expect(read.priority, ContactPriority.high);
      expect(read.message, 'The Dutch entry reads oddly.');
      expect(read.includeDetails, isTrue);
      expect(read.isEmpty, isFalse);
    });

    test('anything unreadable is simply no draft at all', () {
      expect(ContactDraft.decode(null), isNull);
      expect(ContactDraft.decode(''), isNull);
      expect(ContactDraft.decode('not json'), isNull);
      expect(ContactDraft.decode('[]'), isNull);
      // A stored draft from an older shape keeps what it can.
      expect(ContactDraft.decode('{"name": "Ada"}')?.name, 'Ada');
      expect(
        ContactDraft.decode('{"reason": "invented"}')?.reason,
        ContactReason.question,
      );
    });

    test('is kept out of the way of the settings that notify', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final settings = SettingsController(prefs);
      var notified = 0;
      settings.addListener(() => notified++);

      expect(settings.contactDraft, isNull);
      await settings.saveContactDraft(const ContactDraft(name: 'Ada').encode());
      expect(SettingsController(prefs).contactDraft, contains('Ada'));

      await settings.clearContactDraft();
      expect(settings.contactDraft, isNull);
      // Saving on every pause in the typing must not rebuild the app.
      expect(notified, 0);
    });
  });

  group('the page', () {
    /// What the page put on the clipboard. It copies before it hands the
    /// letter on, so that a composer which never opens still leaves the
    /// reader holding what they wrote.
    final clipboard = <String>[];

    /// Every letter this page posted, and where.
    final posts = <({Uri url, Map<String, String> fields})>[];

    Future<SharedPreferences> openContact(
      WidgetTester tester, {
      Map<String, Object> stored = const {},
      bool formAccepts = true,
      Future<bool> Function(Uri url)? onSend,
      BrandColors palette = BrandColors.light,
      Size size = const Size(420, 2400),
      double textScale = 1.0,
      Locale locale = const Locale('en'),
    }) async {
      SharedPreferences.setMockInitialValues(stored);
      final prefs = await SharedPreferences.getInstance();

      clipboard.clear();
      posts.clear();
      final channels =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      channels.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') {
          clipboard.add((call.arguments as Map)['text'] as String);
        }
        return null;
      });
      addTearDown(
        () => channels.setMockMethodCallHandler(SystemChannels.platform, null),
      );

      final settings = SettingsController(prefs);
      final repo = WordRepository.fromJsonString(_fixture);

      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: settings),
            ChangeNotifierProvider.value(value: repo),
          ],
          child: MaterialApp(
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: ThemeData(
              useMaterial3: true,
              brightness: palette == BrandColors.dark
                  ? Brightness.dark
                  : Brightness.light,
              extensions: [palette],
            ),
            builder: (context, child) {
              final media = MediaQuery.of(context);
              return MediaQuery(
                data: media.copyWith(
                  textScaler: TextScaler.linear(textScale),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: ContactPage(
              onPost: (url, fields) async {
                posts.add((url: url, fields: fields));
                return formAccepts;
              },
              onSend: onSend ?? (_) async => true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return prefs;
    }

    /// The check asks about one of three words; only the test knows which
    /// until the question is on screen.
    Future<void> answerTheCheck(WidgetTester tester) async {
      final lemma = _meanings.keys.firstWhere(
        (word) => find.text('Which meaning belongs to $word?').evaluate().isNotEmpty,
      );
      final answer = find.text(_meanings[lemma]!);
      await tester.ensureVisible(answer);
      await tester.pumpAndSettle();
      await tester.tap(answer);
      await tester.pumpAndSettle();
    }

    Future<void> fillIn(WidgetTester tester) async {
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'Ada');
      await tester.enterText(fields.at(1), 'ada@example.com');
      await tester.enterText(fields.at(2), 'The Dutch entry reads oddly.');
      await tester.pumpAndSettle();
      // Let the autosave's pause elapse, so the draft is on disk.
      await tester.pump(const Duration(milliseconds: 800));
    }

    testWidgets('says what it still needs, and only once asked', (tester) async {
      await openContact(tester);

      // Nothing is wrong before anything has been written.
      expect(find.text('A name, so a reply knows whom to greet.'), findsNothing);

      final send = find.widgetWithText(FilledButton, 'Send the letter');
      await tester.ensureVisible(send);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await tester.pumpAndSettle();

      expect(find.text('A name, so a reply knows whom to greet.'), findsOneWidget);
      expect(find.text('An address a reply can reach.'), findsOneWidget);
      expect(find.text('A line or two, at least.'), findsOneWidget);
    });

    testWidgets('offers a fix for a mistyped domain, and takes it',
        (tester) async {
      await openContact(tester);

      await tester.enterText(find.byType(TextField).at(1), 'ada@gmial.com');
      await tester.pumpAndSettle();

      final chip = find.text('Did you mean gmail.com?');
      expect(chip, findsOneWidget);
      await tester.ensureVisible(chip);
      await tester.pumpAndSettle();
      await tester.tap(chip);
      await tester.pumpAndSettle();

      final field = tester.widget<TextField>(find.byType(TextField).at(1));
      expect(field.controller!.text, 'ada@gmail.com');
      expect(find.text('Did you mean gmail.com?'), findsNothing);
    });

    testWidgets('posts the whole letter to the form', (tester) async {
      final prefs = await openContact(tester);

      await fillIn(tester);
      await answerTheCheck(tester);
      expect(find.byIcon(Icons.verified_outlined), findsOneWidget);

      final send = find.widgetWithText(FilledButton, 'Send the letter');
      await tester.ensureVisible(send);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await tester.pumpAndSettle();

      expect(posts, hasLength(1));
      expect(posts.single.url, formspreeEndpoint);
      expect(posts.single.fields['name'], 'Ada');
      expect(posts.single.fields['email'], 'ada@example.com');
      expect(posts.single.fields['category'], 'A question');
      expect(posts.single.fields['message'], 'The Dutch entry reads oddly.');

      // The clipboard is filled first and unconditionally.
      expect(clipboard.single, contains('— Ada <ada@example.com>'));

      // Sent is the one moment the draft stops being worth keeping.
      expect(prefs.getString('beautiful-words:contact-draft'), isNull);
      expect(find.text('Your letter is on its way. Thank you.'), findsWidgets);
    });

    testWidgets('a letter the form refuses is kept, and can go by mail',
        (tester) async {
      Uri? sent;
      final prefs = await openContact(
        tester,
        formAccepts: false,
        onSend: (url) async {
          sent = url;
          return true;
        },
      );

      await fillIn(tester);
      await answerTheCheck(tester);

      final send = find.widgetWithText(FilledButton, 'Send the letter');
      await tester.ensureVisible(send);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await tester.pumpAndSettle();

      expect(posts, hasLength(1));
      expect(clipboard.single, contains('The Dutch entry reads oddly.'));
      // Nothing arrived, so nothing is thrown away.
      expect(prefs.getString('beautiful-words:contact-draft'), contains('Ada'));
      expect(find.textContaining('would not send just now'), findsWidgets);

      // The way out appears only once the form has refused it.
      final byMail =
          find.widgetWithText(OutlinedButton, 'Use a mail app instead');
      expect(byMail, findsOneWidget);
      await tester.ensureVisible(byMail);
      await tester.pumpAndSettle();
      await tester.tap(byMail);
      await tester.pumpAndSettle();

      expect(sent, isNotNull);
      expect(sent!.scheme, 'mailto');
      expect(sent!.path, kContactAddress);
      expect(sent!.queryParameters['subject'], contains('A question'));
      expect(
        sent!.queryParameters['body'],
        contains('— Ada <ada@example.com>'),
      );
    });

    testWidgets('will not send until the reader has read something',
        (tester) async {
      await openContact(tester);

      await fillIn(tester);
      final send = find.widgetWithText(FilledButton, 'Send the letter');
      await tester.ensureVisible(send);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await tester.pumpAndSettle();

      expect(posts, isEmpty);
      expect(find.text('Not that one. Here is another word.'), findsWidgets);
    });

    testWidgets('an unsent letter is waiting on the next visit',
        (tester) async {
      await openContact(
        tester,
        stored: {
          'beautiful-words:contact-draft': const ContactDraft(
            name: 'Ada',
            email: 'ada@example.com',
            reason: ContactReason.praise,
            message: 'Half a thought, left here.',
          ).encode(),
        },
      );

      expect(find.text('An unsent letter was waiting here.'), findsOneWidget);
      expect(
        tester.widget<TextField>(find.byType(TextField).at(0)).controller!.text,
        'Ada',
      );
      expect(
        tester.widget<TextField>(find.byType(TextField).at(2)).controller!.text,
        'Half a thought, left here.',
      );
    });

    // The page is a column of fields, chips and three buttons, in sixty
    // languages — the shapes that overflow first. An overflow anywhere is
    // reported as an exception, which fails this on its own.
    testWidgets('the letter fits every window, in a long-worded language',
        (tester) async {
      const windows = <String, Size>{
        'small phone': Size(320, 640),
        'phone': Size(390, 844),
        'phone landscape': Size(844, 390),
        'tablet portrait': Size(834, 1112),
        'tablet landscape': Size(1112, 834),
        'desktop': Size(1600, 1000),
      };

      for (final window in windows.entries) {
        await openContact(
          tester,
          size: window.value,
          locale: const Locale('de'),
        );
        expect(
          tester.takeException(),
          isNull,
          reason: 'the letter overflowed a ${window.key}',
        );
      }
    });

    testWidgets('the letter fits a phone at the largest text size',
        (tester) async {
      await openContact(
        tester,
        size: const Size(360, 780),
        textScale: 2.0,
        locale: const Locale('de'),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('every placeholder shows itself in both lights',
        (tester) async {
      for (final palette in [BrandColors.light, BrandColors.dark]) {
        final light = palette == BrandColors.dark ? 'candlelight' : 'parchment';
        await openContact(tester, palette: palette);

        for (final hint in [
          'The name to greet you by',
          'Where a reply can find you',
          'Write as much or as little as you like…',
        ]) {
          final text = find.text(hint);
          expect(text, findsOneWidget, reason: 'missing hint by $light');
          final style = tester.widget<Text>(text).style!;
          // The theme's own hint is muted ink at seven tenths, which is a
          // smudge on parchment and nothing at all by candlelight.
          expect(style.color, palette.foregroundMuted, reason: light);
        }
      }
    });
  });
}
