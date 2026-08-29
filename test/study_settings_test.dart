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

    test('reads the gender and the number out of a Google voice id', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-iob#male_2-local', 'locale': 'en-US'},
        {'name': 'en-us-x-tpf#female_1-local', 'locale': 'en-US'},
      ]);

      expect(options.map((v) => v.gender), [
        VoiceGender.male,
        VoiceGender.female,
      ]);
      expect(options.map((v) => v.variant), [2, 1]);
    });

    test("'female' is not read as 'male'", () {
      const voice = VoiceOption(
        name: 'en-us-x-tpf#female_3-local',
        locale: 'en-us',
      );

      expect(voice.gender, VoiceGender.female);
      expect(voice.variant, 3);
    });

    test('a voice with no gender anywhere is never given one', () {
      const voice = VoiceOption(name: 'en-gb-x-gba-local', locale: 'en-gb');

      expect(voice.gender, VoiceGender.unknown);
      expect(voice.label, 'British English · Voice 1 · offline');
    });

    test('the platform may say the gender itself, as iOS does', () {
      final options = englishVoiceOptions([
        {'name': 'Daniel', 'locale': 'en-GB', 'gender': 'male'},
      ]);

      expect(options.single.gender, VoiceGender.male);
      // A person's name beats anything we could build out of the locale.
      expect(options.single.label, 'Daniel · British English');
    });

    test('names the region, not the locale', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-iob#male_1-local', 'locale': 'en-US'},
        {'name': 'en-au-x-aua-local', 'locale': 'en-AU'},
        {'name': 'en-in-x-ene-local', 'locale': 'en-IN'},
      ]);

      expect(options.map((v) => v.regionLabel), [
        'Australian English',
        'Indian English',
        'American English',
      ]);
    });

    test('an unknown English region still reads as English', () {
      const voice = VoiceOption(name: 'en-xx-x-abc-local', locale: 'en-xx');

      expect(voice.regionLabel, 'English (en-xx)');
    });

    test('numbers the unnamed voices within their own region', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-sfg-local', 'locale': 'en-US'},
        {'name': 'en-us-x-tpc-local', 'locale': 'en-US'},
        {'name': 'en-gb-x-gba-local', 'locale': 'en-GB'},
      ]);

      expect(options.map((v) => v.label), [
        'British English · Voice 1 · offline',
        'American English · Voice 1 · offline',
        'American English · Voice 2 · offline',
      ]);
    });

    test('male voices lead their region, so they are not lost among the rest', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-tpf#female_1-local', 'locale': 'en-US'},
        {'name': 'en-us-x-sfg-local', 'locale': 'en-US'},
        {'name': 'en-us-x-tpf#female_2-local', 'locale': 'en-US'},
        {'name': 'en-us-x-iob#male_1-local', 'locale': 'en-US'},
      ]);

      expect(options.map((v) => v.gender), [
        VoiceGender.male,
        VoiceGender.female,
        VoiceGender.female,
        VoiceGender.unknown,
      ]);
    });

    test('says which voices read without the network', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-iob#male_1-network', 'locale': 'en-US'},
        {'name': 'en-us-x-iob#male_1-local', 'locale': 'en-US'},
      ]);

      // The offline twin comes first, and each says which it is.
      expect(options.map((v) => v.label), [
        'American English · Male 1 · offline',
        'American English · Male 1 · online',
      ]);
    });

    test('the label never shows the raw engine id it was built from', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-iob#male_1-local', 'locale': 'en-US'},
        {'name': 'en-gb-x-gba-local', 'locale': 'en-GB'},
        {'name': 'com.apple.voice.compact.en-US.Samantha', 'locale': 'en-US'},
      ]);

      for (final voice in options) {
        expect(
          voice.label,
          isNot(contains('-x-')),
          reason: '${voice.label} still shows the engine id',
        );
        expect(voice.label, isNot(contains('#')));
        expect(voice.label, isNot(contains('com.apple')));
      }
    });

    test('the stored preference stays the engine id, not the label', () {
      final options = englishVoiceOptions([
        {'name': 'en-us-x-iob#male_1-local', 'locale': 'en-US'},
      ]);

      // The label is presentation. Storing it would break the engine lookup.
      expect(options.single.name, 'en-us-x-iob#male_1-local');
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
