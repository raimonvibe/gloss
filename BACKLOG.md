# Gloss — backlog

What is known to be outstanding, with the reasoning behind each item. Companion to
[CLAUDE.md](CLAUDE.md), which covers the i18n pipeline.

## 1. Study page strings are English-only in 60 of 61 locales

**Status:** live gap, biggest item.

The Study page (`d77e39f`) added **37 keys** that exist only in `lib/l10n/app_en.arb`.
`gen-l10n` falls back to English per key, so nothing crashes — but the Study page reads
half-English in Dutch, Thai, Arabic and every other locale. This partially undoes the
"all 59 locales complete" property finished in `9076dbb`.

Missing keys:

```
aboutCaption, aboutSection, autoplayPronunciation, chooseVoice, couldNotOpenLink,
faster, followTheMaker, hearIt, larger, lightCaption, lightSection, navStudy,
noOtherVoices, noVoiceInstalled, openLicences, readExplanationsCaption,
readExplanationsIn, readingCaption, readingSection, reduceMotion, reduceMotionCaption,
shareGloss, slower, smaller, speechPace, studyCaption, studyTitle, textSize,
textSizeSample, themeDark, themeLight, themeSystem, tongueSection, versionLine,
voiceCaption, voiceDefault, voiceSection
```

Same pipeline as the rest of the UI: fill each `lib/l10n/app_<key>.arb`, then
`flutter gen-l10n`. Note `readExplanationsIn` and `versionLine` take placeholders, and
`textSizeSample` is display copy rather than a label.

## 2. Settings researched but not yet built

From the vocabulary-app research done during the Study page design. Four candidates were
put forward; **Reading & motion** and **About & licences** were chosen and shipped. The
other two were deliberately deferred and are still open:

### Data controls — *not built*

Reset quiz progress, and clear saved words, each behind a confirmation dialog. Destructive,
so it was worth being deliberate about. Pure Flutter, no new dependencies — the state already
lives in `SettingsController` and the saved-words store.

### Daily word reminder — *not built*

A notification at an hour the reader picks. The research flagged **daily reminders and text
scaling as the two most-used features** in vocabulary apps. Text scaling shipped; the reminder
did not, because it is the largest lift on the list:

- adds `flutter_local_notifications` + `timezone`
- Android 13 `POST_NOTIFICATIONS` runtime permission
- an iOS entitlement
- exact-alarm handling

Deserves its own commit for that reason.

Sources: [ScoreBeyond](https://scorebeyond.com/best-vocabulary-apps/),
[Brighterly](https://brighterly.com/blog/best-vocabulary-learning-apps/),
[Speed Reading Lounge](https://www.speedreadinglounge.com/vocabulary-apps).

## 3. Android toolchain deprecations

`flutter build apk --debug` succeeds today (verified 2026-08-28, exit 0, 227s), but Flutter
3.47.2 warns that support will soon be dropped for all three:

| Component | Now | Wants | Defined in |
|---|---|---|---|
| Gradle | 8.14.0 | ≥ 9.1.0 | `android/gradle/wrapper/gradle-wrapper.properties` |
| Android Gradle Plugin | 8.11.1 | ≥ 9.0.1 | `android/settings.gradle` |
| Kotlin (KGP) | 2.2.20 | ≥ 2.3.20 | `android/settings.gradle` |

Commit `0dd8e3f` added the Flutter migrator's `android.builtInKotlin=false` and
`android.newDsl=false` to `android/gradle.properties` — those hold the *old* Kotlin/DSL
behaviour, so they belong to the same change. Do the bump on its own: AGP 9 plus the new DSL
tend to shake out signing config and plugin blocks together.

## Verification

Flutter is not on `PATH`:

```bash
PATH="$HOME/Documenten/Developer/flutter/bin:$PATH" flutter test
```

Known-good baseline (2026-08-28, Flutter 3.47.2 / Dart 3.13.2): `flutter analyze` clean,
`flutter test` 63/63, `flutter build apk --debug` exit 0.
