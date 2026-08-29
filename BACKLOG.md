# Gloss — backlog

What is known to be **outstanding**, with the reasoning behind each item. Companion to
[CLAUDE.md](CLAUDE.md), which covers the i18n pipeline, the environments, and how to
verify the project.

Completed items are removed rather than struck through — the point of this file is what
is still open. What was learned from finishing one belongs in CLAUDE.md.

## 1. Settings researched but not yet built

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

## 2. Android toolchain deprecations

`flutter build apk --debug` succeeds today, but Flutter 3.47.2 warns that support will
soon be dropped for all three:

| Component | Now | Wants | Defined in |
|---|---|---|---|
| Gradle | 8.14 | ≥ 9.1.0 | `android/gradle/wrapper/gradle-wrapper.properties` |
| Android Gradle Plugin | 8.11.1 | ≥ 9.0.1 | `android/settings.gradle.kts` |
| Kotlin (KGP) | 2.2.20 | ≥ 2.3.20 | `android/settings.gradle.kts` |

Commit `0dd8e3f` added the Flutter migrator's `android.builtInKotlin=false` and
`android.newDsl=false` to `android/gradle.properties` — those hold the *old* Kotlin/DSL
behaviour, so they belong to the same change. Do the bump on its own: AGP 9 plus the new DSL
tend to shake out signing config and plugin blocks together.

Note the deprecation warning comes from Flutter 3.47.2 (the Linux machine). The Windows
checkout runs 3.41.7 and may not warn at all — that is a difference in the SDK, not in
the project.

## 3. `app_zh.arb` is unreachable, and China is missing from the catalog

`lib/l10n/app_zh.arb` carries a full set of Simplified Chinese UI strings, but **no
catalog locale ever selects it**. `l10n/catalog.json` has no `zh` translation key: its
only Chinese entries are `zh-HK` (Hong Kong) and `zh-TW` (Taiwan, and Macao). The app
builds `supportedLocales` from the catalog (`app.dart`), so `zh` is never resolved.

Two facts that almost certainly belong to the same unfinished thought:

- **China (`CN`) is absent from the 177-country list entirely** — Hong Kong, Macao,
  Taiwan and Singapore are all present
- `app_zh.arb` exists anyway, and `l10n/source/ui_i18n.json` does **not** track `zh`

So this is a half-added locale, not dead weight to delete on sight. Either finish it or
drop it, deliberately:

- **Finish:** add China to `l10n/catalog.json` with `zh` (plus `tool/_pos_origin.py`),
  then write `tool/_data_zh.py` and emit `assets/l10n/words_zh.json`. The overlay test
  requires it — every non-English translation key must have one.
- **Drop:** delete `lib/l10n/app_zh.arb` and re-run `flutter gen-l10n`.

Finishing is the better end state: Simplified Chinese is the largest language currently
missing, and the UI half is already written.

## 4. Documentation drifts from the machine it was written on

Both this file and CLAUDE.md previously hard-coded one machine's paths, one Flutter
install, `python3`, and a test count — all of which were wrong on the second machine or
had gone stale. CLAUDE.md now describes **both** environments and owns the verification
commands; this file defers to it.

Worth keeping that way: when a baseline moves, update CLAUDE.md's *Verification* section
and say which machine produced it.
