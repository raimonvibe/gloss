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
headword standing inside it — "De **soporific** dreun van de lezing". **All 23 locales this
tool can reach are done**; the other 37 still carry it, and every one of them is a locale
with a `tool/_data_<locale>.py`. See *The English inside the example sentence* in
[CLAUDE.md](CLAUDE.md) for the whole reasoning and for what must not be translated.

Where it stands:

| | |
|---|---|
| done | all **23** locales with no `_data_` generator: `nl`, `de`, `fr`, `fr_CA`, `es`, `es_419`, `it`, `pt`, `pt_BR`, `pl`, `ru`, `uk`, `cs`, `sk`, `hr`, `sr`, `sl`, `bg`, `mk`, `el`, `ro`, `hu`, `nb` |
| left | the **37** generated locales — 4,913 of the 8,040 glosses |
| never | the 7 quotations that **are** the specimen, in all 60 |

**This tool's half of the job is finished.** `tool/localize_gloss.py` refuses the remaining
37 on purpose: they are generated from `tool/_data_<locale>.py`, so an overlay edit is
thrown away by the next `emit_from_data.py`. Finishing them is a **different job** — edit
134 five-field tuples per locale and re-emit — and it is worth planning rather than
continuing into. Two things to decide first:

- **Whether to widen `localize_gloss.py` to write the generators**, the way it already
  rewrites `_words_<locale>.py` alongside the overlay for the ten western locales. That
  would make the remaining 37 the same job as the 23, and the checks would carry over
  unchanged. It is the obvious move and nobody has costed it.
- **The three Chinese locales are still worth diffing** before treating them as three jobs.

**Every cheap locale is spent.** `bg`/`mk` was the last near-twin pair and it was not cheap:
0.80 mean similarity looked promising, but **zero of the 134 example sentences were
identical** — the score was measuring how close the languages are, not how close the files
were. A pair only saves work when the diff says the files already agree.

**Two specimen quotations are still lost, and both are in generated locales.** `lo/specious`
and `my/specious` render "Everyone's doing it" in Lao and Burmese script, which empties the
entry out; `test/text_quality_test.dart` names them. Repairing them means editing
`tool/_data_lo.py` and `_data_my.py`. A third, `nb/metonymy`, turned out to be a typo rather
than a loss and is fixed.

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
  `localize_gloss.py` refuses those and says so. The other 23 — the rest of Europe — have no
  such file, and 19 of those 23 are now done.
- **Check for a derived locale before trusting what it owes.** Serbian had been
  transliterated from Croatian, and 23 of its rows carried the English headword rendered in
  Cyrillic, where no sweep here could see it: the count of what Serbian owed was 23 too low.
  Transliterate the English headword letter by letter into the target script and look for it
  with a fuzzy match. `bg` and `mk` were both checked this way and are clean.
- **Go by who can read the result, not by coverage.** A wrong translation is worse than the
  English word standing there: `soporific` in a Turkish sentence is visibly foreign and
  honest about being the headword, while a plausible-but-wrong Turkish word teaches the
  wrong meaning and looks perfectly fine. Nothing in the suite can catch that, and this
  project has shipped generation damage twice.
- **The cost is not the reason to skimp.** Measured: about 7k tokens in and 3k out per
  locale, so roughly 600k for all 59. That is a modest job — reach for a strong model
  rather than a cheap router.

## 4. Serbian's other three fields are still Croatian

Found on 2026-09-03 while localising `sr`, and scoped out of that pass on purpose so that
one job stayed one job.

**Serbian was never written — it was transliterated from Croatian**, mechanically and
unfinished. `exampleGloss`, `friendly` and `definition` are rewritten in ekavian Serbian
now, because those are the three fields `tool/localize_gloss.py` carries. The other three
are written elsewhere and were not touched:

| field | written by | state |
|---|---|---|
| `partOfSpeech` | `tool/_pos_origin.py` | Croatian labels |
| `origin` | `tool/_pos_origin.py` | Croatian labels |
| `rootMeanings` | the overlay | Croatian wording, ijekavian in places |

The tell to look for, and it is the same one that found the 23 transliterated headwords:
Croatian words that are not Serbian — *tijekom*, *njezina*, *obitelj*, *tjedan*, *momčad*,
*povijest*, *burza*, *kava*, *izvješće*, *rubnik*, *kamo*, *opće* — and ijekavian reflexes
(*vjeđama*, *pjesnik*, *propovijedi*) where the rest of the row is ekavian.

`origin` and `partOfSpeech` are the cheap half: they are a small closed table per locale in
`_pos_origin.py`, not 134 sentences. Note that `lib/models/spoken_origin.dart` derives the
compound-origin seam **from the locale's own origin labels**, so correcting them there is
also correcting what the voice says.

**Worth checking the other derived-looking locales the same way before trusting their
counts.** A locale that was derived rather than written does not show up in any sweep here,
because the sweeps ask "is there English in this row" and a bad derivation answers no.

## 5. Where the next session picks up

Written 2026-09-03, at the end of a long session. Everything below is pushed to
`the-respelling-is-for-the-ear`; nothing is merged to `main` and nothing is uploaded to
Play.

**The bundle.** `1.0.0+19` is the current version — 47.9 MB, signed `CN=Gloss,
O=Raimonvibe`, `INTERNET` and the `SENDTO` query both in the merged manifest. It is **not
uploaded**; bump the version code when it is. (`+18` was built and never uploaded, and `+19`
moved anyway — the gap is spent, not lost.)

**What wants a device, not a test.** Two changes in this session can only be judged by ear
and neither has been:

- **The Greek etymons** now go to a Greek voice in Greek letters (*μάθησις*). A phone with
  no Greek TTS data falls back to exactly what it said before, so if nothing changed,
  check the voice is installed before assuming the code is wrong.
- **Every word is now handed to the voice as a word** rather than as its syllables. On
  Google's engine this is unchanged — it reads the IPA either way. It is the other engines
  that changed, and *those* are the ones to listen on. Samsung's TTS is the case that was
  reported.

**One thing worth deciding.** `_useEnglishSsml` in `speech_controller.dart` is true only
when the engine name contains "google", so every other engine is handed plain text and
never sees `<phoneme>` at all. Widening that would give more phones the IPA. It was left
alone because whether another engine honours the tag is a device question, and this project
has been wrong twice about what engines support.

## 6. Documentation drifts from the machine it was written on

Both this file and CLAUDE.md previously hard-coded one machine's paths, one Flutter
install, `python3`, and a test count — all of which were wrong on the second machine or
had gone stale. CLAUDE.md now describes **both** environments and owns the verification
commands; this file defers to it.

Worth keeping that way: when a baseline moves, update CLAUDE.md's *Verification* section
and say which machine produced it.
