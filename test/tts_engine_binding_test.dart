import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_words/state/speech_controller.dart';

/// A stand-in for the Android side of flutter_tts, recording every call so a
/// test can assert on what the engine asked the platform to do.
class FakeTtsPlatform {
  FakeTtsPlatform({
    this.defaultEngine = 'com.google.android.tts',
    this.languageAvailable = true,
  });

  static const _channel = MethodChannel('flutter_tts');
  static const _codec = StandardMethodCodec();

  final String defaultEngine;

  /// False is what an engine that is still binding reports for every locale.
  final bool languageAvailable;

  final List<String> calls = [];
  final List<String> languagesTried = [];

  TestDefaultBinaryMessenger get _messenger =>
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  void install() {
    _messenger.setMockMethodCallHandler(_channel, (call) async {
      calls.add(call.method);
      switch (call.method) {
        case 'getEngines':
          return <String>['com.acme.tts', 'com.google.android.tts'];
        case 'getDefaultEngine':
          return defaultEngine;
        case 'getLanguages':
          return <String>['nl-NL', 'en-US', 'en-GB'];
        case 'isLanguageAvailable':
          languagesTried.add(call.arguments as String);
          return languageAvailable;
        case 'getVoices':
          return <Map<String, String>>[
            {'name': 'nl-nl-x-dma-local', 'locale': 'nl-NL'},
            {'name': 'en-us-x-sfg-local', 'locale': 'en-US'},
          ];
        case 'speak':
          // The real engine reports completion asynchronously; without it
          // speakSegments waits on its own 90s backstop.
          Timer.run(_reportSpeakComplete);
          return 1;
        default:
          return 1;
      }
    });
  }

  void _reportSpeakComplete() {
    _messenger.handlePlatformMessage(
      _channel.name,
      _codec.encodeMethodCall(const MethodCall('speak.onComplete')),
      (_) {},
    );
  }

  void remove() => _messenger.setMockMethodCallHandler(_channel, null);

  int countOf(String method) => calls.where((c) => c == method).length;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeTtsPlatform platform;

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  });

  tearDown(() {
    platform.remove();
    debugDefaultTargetPlatformOverride = null;
  });

  test('does not rebuild the engine when Google TTS is already default',
      () async {
    platform = FakeTtsPlatform(defaultEngine: 'com.google.android.tts')
      ..install();

    final engine = TtsSpeechEngine();
    await engine.speak('sesquipedalian');

    // setEngine drops the bound TextToSpeech; every call made before the
    // replacement connects fails with 'not bound to TTS engine', which
    // silently leaves the device (Dutch) voice in place.
    expect(platform.countOf('setEngine'), 0);
    expect(platform.countOf('getDefaultEngine'), 1);
  });

  test('switches engine when the device default is an OEM one', () async {
    platform = FakeTtsPlatform(defaultEngine: 'com.samsung.SMT')..install();

    final engine = TtsSpeechEngine();
    await engine.speak('sesquipedalian');

    expect(platform.countOf('setEngine'), 1);
  });

  test('locks to English once, not before every utterance', () async {
    platform = FakeTtsPlatform()..install();

    final engine = TtsSpeechEngine();
    await engine.speak('one');
    final afterFirst = platform.countOf('isLanguageAvailable');
    await engine.speak('two');
    await engine.speak('three');

    expect(platform.languagesTried.first, 'en-US');
    expect(platform.countOf('isLanguageAvailable'), afterFirst);
    expect(platform.countOf('speak'), 3);
  });

  test('re-locks English after a segment in another language', () async {
    platform = FakeTtsPlatform()..install();

    final engine = TtsSpeechEngine();
    engine.setCompletionHandler(() {});
    await engine.speak('warm up');
    final baseline = platform.countOf('setLanguage');

    await engine.speakSegments(const [
      SpeechSegment('een taal', languageTag: 'nl-NL'),
      SpeechSegment('English again'),
    ]);

    // A Dutch segment moves the engine off English, so the cached lock has
    // to be dropped - otherwise the next lemma is read in Dutch.
    expect(platform.countOf('setLanguage'), greaterThan(baseline));
  });

  test('a lock that never took is retried on the next utterance', () async {
    platform = FakeTtsPlatform(languageAvailable: false)..install();

    final engine = TtsSpeechEngine();
    await engine.speak('one');
    final afterFirst = platform.countOf('isLanguageAvailable');
    await engine.speak('two');

    expect(platform.countOf('isLanguageAvailable'), greaterThan(afterFirst));
  });

  group('a platform that never answers', () {
    // An emulator (or phone) with no default TTS engine configured never
    // fires TextToSpeech.onInit, so flutter_tts parks every call in
    // pendingMethodCalls and replies to none of them. The futures neither
    // complete nor throw.
    const channel = MethodChannel('flutter_tts');
    const short = Duration(milliseconds: 50);

    void installSilentPlatform() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) => Completer<Object?>()
              .future);
    }

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('speak still returns instead of hanging forever', () async {
      installSilentPlatform();
      final engine = TtsSpeechEngine(callTimeout: short, initTimeout: short);

      await engine.speak('sesquipedalian').timeout(const Duration(seconds: 5));

      expect(engine.isAvailable, isFalse);
    });

    test('the play button does not stay stuck on', () async {
      installSilentPlatform();
      final controller = SpeechController(
        engine: TtsSpeechEngine(callTimeout: short, initTimeout: short),
      );

      // speak() awaits engine.stop() before it even sets _speaking, so a
      // hang here left the button dead: no sound, no state change, no log.
      await controller
          .speak('word-of-the-day', 'sesquipedalian')
          .timeout(const Duration(seconds: 5));

      expect(controller.isSpeaking, isTrue);
      await controller.stop().timeout(const Duration(seconds: 5));
      expect(controller.isSpeaking, isFalse);
    });

    test('stop returns even when the engine never bound', () async {
      installSilentPlatform();
      final engine = TtsSpeechEngine(callTimeout: short, initTimeout: short);

      await engine.stop().timeout(const Duration(seconds: 5));
      await engine.speakSegments(
        const [SpeechSegment('one'), SpeechSegment('two')],
      ).timeout(const Duration(seconds: 10));
    });

    test('englishVoices degrades to empty rather than never returning',
        () async {
      installSilentPlatform();
      final engine = TtsSpeechEngine(callTimeout: short, initTimeout: short);

      final voices =
          await engine.englishVoices().timeout(const Duration(seconds: 5));

      expect(voices, isEmpty);
    });
  });
}
