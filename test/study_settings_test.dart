import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:beautiful_words/branding.dart';
import 'package:beautiful_words/state/settings_controller.dart';
import 'package:beautiful_words/state/speech_controller.dart';
import 'package:beautiful_words/widgets/social_links.dart';

void main() {
  group('reading and voice preferences', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('text scale persists and stays within legible bounds', () async {
      final settings = SettingsController(prefs);
      expect(settings.textScale, 1.0);

      await settings.setTextScale(1.3);
      expect(settings.textScale, 1.3);
      expect(prefs.getDouble('beautiful-words:text-scale'), 1.3);

      await settings.setTextScale(9);
      expect(settings.textScale, kMaxTextScale);
      await settings.setTextScale(0.1);
      expect(settings.textScale, kMinTextScale);

      expect(SettingsController(prefs).textScale, kMinTextScale);
    });

    test('a stored scale outside the range is clamped on load', () async {
      await prefs.setDouble('beautiful-words:text-scale', 4);
      expect(SettingsController(prefs).textScale, kMaxTextScale);
    });

    test('voice choice round-trips, and null clears it', () async {
      final settings = SettingsController(prefs);
      expect(settings.voiceName, isNull);

      await settings.setVoiceName('en-us-x-sfg#female_1-local');
      expect(SettingsController(prefs).voiceName,
          'en-us-x-sfg#female_1-local');

      await settings.setVoiceName(null);
      expect(prefs.containsKey('beautiful-words:voice'), isFalse);
      expect(SettingsController(prefs).voiceName, isNull);
    });

    test('speech rate persists and is clamped', () async {
      final settings = SettingsController(prefs);
      expect(settings.speechRate, kDefaultSpeechRate);

      await settings.setSpeechRate(0.6);
      expect(SettingsController(prefs).speechRate, 0.6);

      await settings.setSpeechRate(5);
      expect(settings.speechRate, kMaxSpeechRate);
    });

    test('autoplay and reduce-motion default off and persist', () async {
      final settings = SettingsController(prefs);
      expect(settings.autoplayPronunciation, isFalse);
      expect(settings.reduceMotion, isFalse);

      await settings.setAutoplayPronunciation(true);
      await settings.setReduceMotion(true);

      final reloaded = SettingsController(prefs);
      expect(reloaded.autoplayPronunciation, isTrue);
      expect(reloaded.reduceMotion, isTrue);
    });
  });

  group('voice list', () {
    test('offers English voices only, so the language lock holds', () {
      final options = englishVoiceOptions([
        {'name': 'nl-nl-x-dma-local', 'locale': 'nl-NL'},
        {'name': 'en-us-x-sfg#male_1-local', 'locale': 'en-US'},
        {'name': 'en-gb-x-gba-local', 'locale': 'en-GB'},
        {'name': 'fr-fr-x-frb-local', 'locale': 'fr-FR'},
      ]);

      expect(options.map((v) => v.locale), ['en-gb', 'en-us']);
      expect(options.every((v) => v.locale.startsWith('en')), isTrue);
    });

    test('drops duplicates and entries missing a name or locale', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-sfg#male_1-local', 'locale': 'en-US'},
        {'name': 'en-us-x-sfg#male_1-local', 'locale': 'en-US'},
        {'locale': 'en-US'},
        {'name': 'en-au-x-aua-local'},
      ]);

      expect(options, hasLength(1));
    });

    test('controller loads voices from the engine', () async {
      final engine = SilentSpeechEngine(
        voices: const [VoiceOption(name: 'en-us-x-sfg', locale: 'en-us')],
      );
      final speech = SpeechController(engine: engine);
      expect(speech.voices, isNull);

      await speech.loadVoices();
      expect(speech.voices, hasLength(1));

      await speech.applyPreferences(voiceName: 'en-us-x-sfg', rate: 0.5);
      expect(engine.appliedVoiceName, 'en-us-x-sfg');
      expect(engine.appliedRate, 0.5);
    });
  });

  group('social links', () {
    test('every link has an https url and a label', () {
      expect(socialLinks, hasLength(9));
      for (final link in socialLinks) {
        expect(link.label, isNotEmpty);
        expect(Uri.parse(link.url).scheme, 'https');
      }
    });

    test('marks with no colour of their own follow the page ink', () {
      const parchmentInk = Color(0xFF3A2C1A);
      final github = socialLinks.firstWhere((l) => l.label == 'GitHub');
      final youtube = socialLinks.firstWhere((l) => l.label == 'YouTube');

      // Would be invisible on parchment if it kept its own black/white.
      expect(github.resolve(parchmentInk), parchmentInk);
      // YouTube red is legible on both themes, so it keeps its brand colour.
      expect(youtube.resolve(parchmentInk), const Color(0xFFFF0000));
    });
  });

  test('the About version matches pubspec', () {
    final pubspec = File('pubspec.yaml').readAsLinesSync();
    final line = pubspec.firstWhere((l) => l.startsWith('version:'));
    final version = line.split(':')[1].trim().split('+').first;
    expect(Branding.version, version);
  });
}
