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

## 3. The example sentence's headword, in 24 more languages

`exampleGloss` is the example sentence in the reader's language, and it kept the English
headword standing inside it — "De **soporific** dreun van de lezing". See *The English
inside the example sentence* in [CLAUDE.md](CLAUDE.md) for the whole reasoning and for what
must not be translated.

Where it stands (2026-09-03, end of the long session):

| | |
|---|---|
| done | **36** locales: `nl`, `de`, `fr`, `fr_CA`, `es`, `es_419`, `it`, `pt`, `pt_BR`, `pl`, `ru`, `uk`, `cs`, `sk`, `hr`, `sr`, `sl`, `bg`, `mk`, `el`, `ro`, `hu`, `nb`, `be`, `da`, `sv`, `af`, `is`, `et`, `fi`, `lt`, `lv`, `sq`, `zh_TW`, `zh`, `zh_HK` |
| left | **24** locales — 3,183 of the 8,040 glosses, 40% |
| never | the 7 quotations that **are** the specimen, in all 60 |

**The tool reaches every locale now.** `localize_gloss.py` used to refuse the 37 with a
`tool/_data_<locale>.py`; it writes the generator and re-emits, so the remaining 24 are the
same job as the first 36 and every check carries over. What is left is writing, not
plumbing: **~132 sentences and 8–11 `friendly` lines per locale**, the same shape every
time.

The 24 that remain, and the pairs worth measuring before assuming they are separate jobs:

| group | locales |
|---|---|
| Turkic | `tr`, `az`, `kk`, `ky` — **diff these four first** |
| Malay | `id`, `ms` — the other obvious pair |
| Indic | `hi`, `bn`, `ne`, `si`, `ur` |
| SE Asia | `th`, `lo`, `km`, `my`, `vi`, `fil` |
| CJK | `ja`, `ko` |
| Caucasian | `hy`, `ka` |
| other | `ar`, `he`, `sw` |

**Diff before writing — the Chinese three proved the method.** Measured over all 670 cells
before a word was written, `zh` is exactly `opencc tw2sp` of `zh_TW` and `zh_HK` is exactly
`zh_TW` under twelve substitutions. Taiwan was written by hand and
`tool/derive_chinese.py` produced the other two, generators and overlays and written
records alike. **That is three locales for the price of one, and only a diff could have
found it.** But `bg`/`mk` is the warning on the other side: 0.80 mean similarity and **zero
of the 134 sentences identical** — the score was measuring how close the languages are, not
how close the files were. A pair only saves work when the diff says the files already agree.

**Two specimen quotations are still lost, and both are now reachable.** `lo/specious` and
`my/specious` render "Everyone's doing it" in Lao and Burmese script, which empties the
entry out; `test/text_quality_test.dart` names them. They needed `tool/_data_lo.py` and
`_data_my.py` edited by hand when that was written; `localize_gloss.py` can do it now, and
both locales are on the list above anyway. A third, `nb/metonymy`, turned out to be a typo
rather than a loss and is fixed.

**`ro` and `sq` show flags that are not faults.** Romanian keeps two and Albanian one, and
all three are *plumb* — the Romanian and Albanian word for lead, inherited from the same
Latin *plumbum* the entry is about. Do not "fix" them.

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

## 5. Speech: what is waiting on a device, and one design choice

**A Latin etymon is read by an Italian voice, and most phones have no Italian.** Fixed on
2026-09-03 as far as the code can take it: the routing was always right, and three faults
underneath it were not — a lower-cased locale handed to `setVoice`, which compares exactly;
`_useLanguage` reporting success without reading the engine's answer; and `getVoices`
listing voices the phone has never downloaded. See *"Why is efflorescere still English?"*
in [CLAUDE.md](CLAUDE.md).

**What is left is a choice, not a defect.** With those fixed, a phone with no Italian voice
reads the Latin etymon in **English**, on purpose — and Latin is **81 of the 134 words**, so
on a phone carrying only its own language plus English, most of the lexicon's etymons still
arrive in an English mouth. Two ways out, neither taken:

- tell the reader to install the Italian voice, or
- give Latin a chain of stand-ins — `it` → `es` → `pt` → `ro` — so that any Romance voice on
  the device says it before English does. All four pronounce Latin letters roughly
  phonetically; French deliberately is not in the list.

**What wants an ear, not a test.** None of these has been heard on a device:

- **The Greek etymons** go to a Greek voice in Greek letters (*μάθησις*). A phone with no
  Greek TTS data falls back to exactly what it said before, so if nothing changed, check the
  voice is installed before assuming the code is wrong.
- **Every word is handed to the voice as a word** rather than as its syllables. On Google's
  engine this is unchanged — it reads the IPA either way. It is the other engines that
  changed, and *those* are the ones to listen on. Samsung's TTS is the case that was
  reported.
- **A root now reaches a foreign voice without its hyphen** — `ex`, not `ex-`. Eighty of the
  351 routed forms carried one, and a voice says the hyphen out loud.

**One thing worth deciding.** `_useEnglishSsml` in `speech_controller.dart` is true only when
the engine name contains "google", so every other engine is handed plain text and never sees
`<phoneme>` at all. Widening that would give more phones the IPA. It was left alone because
whether another engine honours the tag is a device question, and this project has been wrong
twice about what engines support.

## 6. Small things that are known and not done

- **`test/english_narration_test.dart` is flaky under full-suite concurrency**, and has been
  since before `1333cf1` — it sweeps sixty locales and one case trips the 30s per-test
  timeout on a loaded machine while passing alone in about 20s. The suite is run in two
  halves to work around it. **Raising the timeout on that file would settle it properly**
  and nobody has.
- **`opencc` is a tool dependency now, and not a repo one.** `tool/derive_chinese.py` needs
  `pip install opencc-python-reimplemented`; the app does not, and nothing in `pubspec.yaml`
  changed. A fresh checkout that wants to re-derive Chinese has to install it.
- **Nothing stops a future tool writing CRLF again.** `emit_from_data.py` did, on Windows,
  and left exactly one fingerprint in the repo — `assets/l10n/words_zh.json` was the only
  one of the sixty overlays committed with CRLF, and it is LF now. The fix was one
  `newline="
"`; a test that reads the shipped assets as bytes and fails on `
` would
  stop the next one.
- **`kRespellingVoicing` is kept for the record and read by nothing.** It looks exactly like
  the cause of any pronunciation bug and is not. See CLAUDE.md.

## 7. Where the next session picks up

Written 2026-09-03, at the end of a long session.

**The bundle.** `1.0.0+21` is built and verified twice — the second time at `0ce8105`, — see *Known-good baseline* in
[CLAUDE.md](CLAUDE.md) for the size, the signature and what was checked inside it. It is
**not uploaded**; bump the version code when it is. (`+18`, `+19` and `+20` were all built
and never uploaded — those codes are spent, not lost.)

**The branch.** Everything is on `the-respelling-is-for-the-ear`. Nothing is merged to
`main`.

**The obvious next move** is the four Turkic locales, measured against each other first.

## 8. Documentation drifts from the machine it was written on

Both this file and CLAUDE.md previously hard-coded one machine's paths, one Flutter
install, `python3`, and a test count — all of which were wrong on the second machine or
had gone stale. CLAUDE.md now describes **both** environments and owns the verification
commands; this file defers to it.

Worth keeping that way: when a baseline moves, update CLAUDE.md's *Verification* section
and say which machine produced it.
