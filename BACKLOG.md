# Gloss — backlog

What is known to be **outstanding**, with the reasoning behind each item. Companion to
[CLAUDE.md](CLAUDE.md), which covers the i18n pipeline, the environments, and how to
verify the project.

Completed items are removed rather than struck through — the point of this file is what
is still open. What was learned from finishing one belongs in CLAUDE.md.

## 1. Daily word reminder — *not built*

From the vocabulary-app research done during the Study page design. Four candidates were
put forward; **Reading & motion**, **About & licences** and **Data controls** have all
shipped. This is the last one, and the largest lift.

A notification at an hour the reader picks. The research flagged **daily reminders and text
scaling as the two most-used features** in vocabulary apps. Text scaling shipped; the reminder
did not, because unlike the rest it reaches outside Flutter:

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

## 3. The example sentence's headword, in 59 more languages

`exampleGloss` is the example sentence in the reader's language, and it kept the English
headword standing inside it — "De **soporific** dreun van de lezing". **Dutch, German and
French are done**; the other 57 still carry it. See *The English inside the example sentence* in
[CLAUDE.md](CLAUDE.md) for the whole reasoning and for what must not be translated.

Where it stands:

| | |
|---|---|
| done | `nl` (133 of 134 sentences), `de` (134), `fr` (130) |
| left | the other 57 locales — 7514 of the 8,040 glosses |
| never | the 7 quotations that **are** the specimen, in all 60 |

The machinery is built and the guardrails run without a model in them:

```bash
python tool/gloss_english.py                     # what is left, and where
python tool/gloss_english.py --locale de         # a worklist for one locale
python tool/localize_gloss.py --locale de --check
python tool/localize_gloss.py --locale de
```

Four things to hold on to before doing another:

- **Write the sentence, do not swap the word.** The local word has to be inflected for the
  slot it lands in; agreement, case and word order all differ. The agent writes
  `tool/gloss_local_<locale>.json` and **never** touches `assets/l10n/words_*.json` — the
  Python applier does that, so an unrelated `friendly` field cannot be reworded in passing.
- **37 of the 60 locales have a `tool/_data_<locale>.py`,** which is their source of truth:
  an edit to their overlay is thrown away by the next `emit_from_data.py`.
  `localize_gloss.py` refuses those and says so. The other 23 — `nl`, `de`, `fr`, `es`,
  `it`, `pt`, `ru`, `pl`, `uk` and the rest of Europe — have no such file.
- **Go by who can read the result, not by coverage.** A wrong translation is worse than the
  English word standing there: `soporific` in a Turkish sentence is visibly foreign and
  honest about being the headword, while a plausible-but-wrong Turkish word teaches the
  wrong meaning and looks perfectly fine. Nothing in the suite can catch that, and this
  project has shipped generation damage twice.
- **The cost is not the reason to skimp.** Measured: about 7k tokens in and 3k out per
  locale, so roughly 600k for all 59. That is a modest job — reach for a strong model
  rather than a cheap router.

## 4. Documentation drifts from the machine it was written on

Both this file and CLAUDE.md previously hard-coded one machine's paths, one Flutter
install, `python3`, and a test count — all of which were wrong on the second machine or
had gone stale. CLAUDE.md now describes **both** environments and owns the verification
commands; this file defers to it.

Worth keeping that way: when a baseline moves, update CLAUDE.md's *Verification* section
and say which machine produced it.
