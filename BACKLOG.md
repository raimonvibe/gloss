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

Where it stands (**re-measured 2026-09-04**, and the tools agree with the list):

| | |
|---|---|
| done | **42** locales: `nl`, `de`, `fr`, `fr_CA`, `es`, `es_419`, `it`, `pt`, `pt_BR`, `pl`, `ru`, `uk`, `cs`, `sk`, `hr`, `sr`, `sl`, `bg`, `mk`, `el`, `ro`, `hu`, `nb`, `be`, `da`, `sv`, `af`, `is`, `et`, `fi`, `lt`, `lv`, `sq`, `zh_TW`, `zh`, `zh_HK`, `tr`, `az`, `kk`, `ky`, **`id`, `ms`** |
| left | **18** locales — 2,387 of the 8,040 glosses, 30% |
| never | the 7 quotations that **are** the specimen, in all 60 |

**Every word left reads exactly `bare 18`**, which is worth more than the total: the
remaining English is spread evenly over 18 whole locales rather than pooled in a few, so no
locale is half-done and none of the 42 has quietly regressed. The other three fields are
the same 18 and move with them — **157** bare uses in `friendly`, **12** in `definition`,
**2** in `rootMeanings`.

The two tools disagree by 48 and that is not a fault: `gloss_english.py` counts **3,231**
because it counts mentions along with uses, and `english_in_translation.py` counts **3,183**
because it sorts them apart. A mention is the fix rather than the bug — see *A mention is
not a use* in [CLAUDE.md](CLAUDE.md). Take the bare number.

**The tool reaches every locale now.** `localize_gloss.py` used to refuse the 37 with a
`tool/_data_<locale>.py`; it writes the generator and re-emits, so the remaining 24 are the
same job as the first 36 and every check carries over. What is left is writing, not
plumbing: **~132 sentences and 8–11 `friendly` lines per locale**, the same shape every
time.

The 24 that remain, and the pairs worth measuring before assuming they are separate jobs:

**The Turkic four are done, 2026-09-04, and the diff said what it was going to cost
before a word was written.** Over all 134 words x 3 prose fields, **every one of the six
pairs shares ZERO identical cells.** `tr`/`az` scores 0.63 mean similarity and `kk`/`ky`
0.54 — and those numbers are the *languages* being close, not the files agreeing. It is the
`bg`/`mk` case, not the Chinese one: four separate jobs, no derivation available. **Run the
diff anyway — it costs four minutes and it is the only thing that can tell the two cases
apart.**

Three things came out of doing them that the count did not predict:

- **Kazakh and Kyrgyz had never had their reported speech translated at all.** `clodpate`
  kept both halves of its English joke, and `sententious`, `unctuous`, `reify`, `laconism`,
  `proleptical`, `invidious`, `ingenuous`, `cant`, `rodomontade` and `gloze` each kept
  their quotation. Turkish and Azerbaijani had already done these. **The English sweep
  counts the headword, so a locale can owe a third more than its number says.**
- **Azerbaijani had drifted into Turkish**, exactly as `nb` drifted into Danish and `af`
  into Dutch: its `trenchant` line read *Laf kalabalığını kesir*, which is Turkish. Third
  time this project has met it, and no check here can see it — the drifted phrase is real
  words in the other language. **A locale written beside its big sibling drifts into the
  sibling.**
- **Both Cyrillic locales carried broken rows** that no sweep can see, because a broken
  Kazakh sentence is still Kazakh words: `kk/mordant` said the critics loved the readers,
  `kk/sagacity` lost its possessive, `ky/anchorite` put the hermit in a biological cell,
  and both kept the English preposition *by dint of* bodily inside `dint`. All found by
  rewriting the row, which is the only way any of them is ever found.

**`id`/`ms` was the case in between, and it is the one worth learning from.** 34 of 402
prose cells identical at **0.86** mean similarity — far closer than the Turkic four, far
short of the Chinese three. **The ratio is not what decides it; the shape of the difference
is.** Taking every word-level substitution between the two files gives **338 substitutions
in 277 distinct types** — a long tail. `pt_BR` was derivable because its difference was
nine rules applied over and over; this is a different word in nearly every row, and the ten
recurring pairs (*adalah*/*ialah*, *tak*/*tidak*, *dari*/*daripada*, *setelah*/*selepas*,
*film*/*filem*) cover well under a fifth of it.

**So count substitution *types*, not identical cells, when the ratio comes out high.** Two
files can be 0.86 alike and still need writing twice.

The pair was also **measured again afterwards as a drift guard** — the `az`-into-Turkish
fault from the same session — and came back 32/402 at 0.85, so the two stayed as distinct
as they started rather than collapsing into each other. **Worth doing on every pair from
here: it is four lines, and it is the only check that would catch the drift.**

| group | locales |
|---|---|
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

## 4. Serbian: the ijekavian is done, the Croatian vocabulary is not

**Done 2026-09-04** by `python tool/ekavize_sr.py` — **112 cells**, 52 `friendly`,
37 `definition`, 23 `rootMeanings`, and **zero** `exampleGloss`. What is left in the locale
is below.

This entry was wrong twice before it was right, and both are worth keeping, because each
was written from reading the code and corrected by measuring the data.

**It named the wrong file.** `partOfSpeech` and `origin` were said to be Croatian labels in
`tool/_pos_origin.py`. **`sr` has no entry in that table at all** — it covers only the 37
locales with a `tool/_data_<locale>.py`, and Serbian has neither a `_data_sr.py` nor a
`_words_sr.py`. The labels live in the overlay and were **already ekavian**: *придев* not
*pridjev*, *прошло време* not *prošlo vrijeme*, *италијански* not *talijanski*, *немачки*
not *njemački*. A mechanical transliteration would have given *придјев* and *талијански*.
Two fields listed as outstanding needed nothing.

**And it convicted the wrong field.** The correction said the ijekavian was in
`exampleGloss`, `friendly` and `definition` alike. It was not in `exampleGloss` — **not one
of the 134 sentences** — and the 22 reflex tokens found there were all inflectional noise.
The 2026-09-03 rewrite did produce correct ekavian in everything it wrote. **The ijekavian
survived exactly where that rewrite never reached**: the 125 `friendly` and 132 `definition`
rows the record does not hold, and `rootMeanings`, which `localize_gloss.py` does not carry
at all. That is a fact about coverage, not about care — and it is checkable in advance, by
comparing what `tool/gloss_local_<locale>.json` holds against what the overlay has.

**The map is decided, not derived, and about a third of the sweep is noise.** `ије` is an
ordinary inflectional ending, so *није*, *касније*, *нације*, *перорације* and *цикорије*
match a naive search and are already correct; so do *набијеним* (набити) and *увијене*
(увити), where the `ије` is not a reflex at all. `KEEP` in the tool names all of them, so a
later reader can tell a decision from an oversight.

**Two shapes of the reflex have no `је` in them, and the first sweep saw neither.** Jat
before *o* gives *дио* where ekavian has *део* — *сваки дио* was sitting in the middle of an
otherwise converted sentence — and jekavian jotation gives *ођедном* and *ђеце* for
*одједном* and *деце*. Widening the detector then forced 47 more tokens to be ruled on, of
which 5 were real. **A reflex sweep is only as wide as its pattern, and the pattern was
wrong twice.**

**Four tokens cross from spelling into vocabulary, where a blind conversion is worse than
none.** *умјетна* ekavizes to *уметна*, which means **inserted** — the definition of
*ersatz* would have read "an inserted or worse replacement". *лијечнички* gives *лечнички*,
which is not a word. Serbian says *вештачка* and *лекарски*; *повијесно* wants *историјски*
and *протурјечност* wants *противречност*. This is the `los númerlo` fault in another
language: a real-looking word that no check in this project can see.

**The tool's readback guard caught its own output twice**, and that is the part worth
copying. *лицемерје* and *одједном* are the correct ekavian forms and both contain a
consonant + `је`, so the sweep flags what the tool just wrote. A converter whose output its
own detector rejects is telling you something true; the answer was to name them, not to
loosen the detector. **Check every new replacement against the pattern before adding it.**

### What is still wrong in Serbian

**The Croatian vocabulary is done too**, 2026-09-04, in the same tool — now
`tool/serbianize_sr.py`, renamed because it no longer only ekavizes. **41 cells**, 21
`friendly` and 20 `definition`, on top of the 112 the reflex pass changed.

**A doublet cannot be swept for, and that is the difference from the reflexes.** There is
no letter that makes *знаност* Croatian. Two passes with a candidate stem list called the
file clean; *строј*, *умак*, *точно* and *скупина* were all found afterwards, by reading
the rows the tool had already changed. **A doublet list is a reading, not a measurement,
and it is never provably finished** — so treat the table as what has been found, not as
what is there.

**Three of them changed the meaning rather than the register**, which is why this half
mattered more than its cell count suggests:

| word | Croatian | but in Serbian it means |
|---|---|---|
| зрак | air | **a ray of light** |
| строј | machine | **a military formation** |
| умак | sauce | (the stem *умакнути*, to escape) |

So the shipped Serbian described a braggart as "готово сам врућ **зрак**" — almost pure hot
*ray* — and *actuate* as "да се **строј** укључи", that the *formation* switches on. Both
parse. Both were green in the suite. **A wrong word that is still a word is the failure
mode this locale keeps producing**, and it is the same one as *los númerlo* and *Mençant*.

**Two repairs in the pass were neither reflex nor doublet.** `inanition` read *Слаб,
исцеђен стан* — a weak drained *apartment*, where the English is "state"; it is *Слабо,
исцеђено стање* now, and note that the fix had to move both adjectives, because *стање* is
neuter where *стан* is masculine. The same row's definition read *Исрпљеност*, which is not
a word — Serbian is *исцрпљеност*. Both were found by reading rows the tool had already
touched.

**Expect more of that last kind, and expect nothing here to find them.** A word broken in
generation usually still looks like a word. **A full proofread of Serbian by someone
reading it as Serbian is a separate job and is not done.**

**The tool's own detector flagged four of its own replacements** — *лицемерје*, *одједном*,
*такође*, *исцеђено* — each a correct Serbian word containing a consonant + `је`. They were
found one at a time across three runs before the obvious check was written down:

```python
[v for v in WORDS.values() if REFLEX.search(v)]   # every one must be in KEEP
```

### Still outstanding

**English transliterated letter by letter**, the same fault as the 23 headwords found on
2026-09-03: *Схакеспеарова Мацбетха* in `incarnadine`, which should be *Шекспиров Магбет*.
Sweep for the class rather than fixing the one.

**Roughly ten Croatian fragments in Latin script**, inside quotation marks the rewrites did
not look at: *„Bog je ljubav“*, *„Bog je pravedan“* (`cataphatic`), *„izvršio odlazak“*
(`periphrastic`), *„Bijela kuća objavila“* and *„kruna“* (`metonymy`), *„na zrak“*
(`pneumatic`), *„lošem“* (`solecism`), *„liže“* (`lambent`). These are **not** English
mentions and must not be treated as ones — they are Croatian example phrases that should be
Serbian Cyrillic.

`lib/models/spoken_origin.dart` derives the compound-origin seam **from the locale's own
origin labels**, so those labels are read by the voice as well as drawn on the page. They
turned out to be correct, but that is why they would have mattered.

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
- **This file carries one deliberate CR, and text-mode Python eats it.** The `newline`
  bullet above demonstrates a CRLF by containing one, and `pathlib.read_text()` applies
  universal-newline translation, so any edit made by reading this file as text and writing
  it back silently converts it to a plain newline — destroying the only example of the
  thing the bullet is about. It happened twice on 2026-09-04, the second time an hour
  after being written down. **Edit this file with `read_bytes`/`write_bytes`**, and count the
  CRLFs afterwards — there should still be exactly one. Writing that check down
  here put a third one in, because the escape in it was interpreted rather than
  shown, which is the same trap wearing a hat.
- **`kRespellingVoicing` is kept for the record and read by nothing.** It looks exactly like
  the cause of any pronunciation bug and is not. See CLAUDE.md.

## 7. Where the next session picks up

Written 2026-09-03, at the end of a long session.

**The bundle.** `1.0.0+21` is built and verified twice — the second time at `0ce8105`, — see *Known-good baseline* in
[CLAUDE.md](CLAUDE.md) for the size, the signature and what was checked inside it. It is
**not uploaded**; bump the version code when it is. (`+18`, `+19` and `+20` were all built
and never uploaded — those codes are spent, not lost.)

**The branch.** Everything is on `the-respelling-is-for-the-ear`, and **it is merged.**
`origin/main` is at `67d06a1`, the merge of PR #19 from this branch, and
`git rev-list --count origin/main..HEAD` is **0** — every commit here is already upstream.
Local `main` is 60 behind and has simply not been pulled; it is a stale pointer rather than
a second line of work, and `git checkout main && git pull` settles it.

This file said *"nothing is merged to `main`"* until 2026-09-04, and it was true the day it
was written. **A sentence about where the work sits goes stale the moment someone merges**,
and nothing in the repo updates it — so check it against `git` before trusting it, the way
the counts above are checked against the tool that measures them.

**The obvious next move** is the four Turkic locales, measured against each other first.

## 8. Documentation drifts from the machine it was written on

Both this file and CLAUDE.md previously hard-coded one machine's paths, one Flutter
install, `python3`, and a test count — all of which were wrong on the second machine or
had gone stale. CLAUDE.md now describes **both** environments and owns the verification
commands; this file defers to it.

Worth keeping that way: when a baseline moves, update CLAUDE.md's *Verification* section
and say which machine produced it.

---

## 9. The store listing, and the privacy page it is checked against

Found on 2026-09-04 by auditing for work this file does not carry. Both items are on the
release path and **both live outside this repo**, which is why nothing here sees them and
why they fell out of the backlog in the first place.

**The privacy policy contradicts the Data safety declaration.**
`store/play/GOOGLE-PLAY-CONSOLE.md` records the answers already prepared for Play: Name,
Email address and *Messages -> Other in-app messages*, **Collected**, optional, with
Formspree as a processor and deletion by mail to info@raimonvibe.com. The page at
`/apps/gloss/privacy` **predates the contact form and says none of it.** Play checks the
declaration against the live page, and that same document lists the mismatch as a known
rejection cause — *"Data safety says you collect data when you do not (or the reverse)"*.

It needs one paragraph: what the form sends, that Formspree processes it, and how to ask
for it to be deleted. The source is in **another repository** —
[raimonvibe/website-editorial-eu](https://github.com/raimonvibe/website-editorial-eu) —
live at `/apps/gloss/privacy`. This is the one item that blocks the upload §7 is waiting
on.

**The screenshots may still have transparent backgrounds.** The same document names
`removebg` files as a known Gloss rejection cause. They live under
`Pictures\Gloss-images\play-phone-screenshots\`, outside the repo, so whether it was ever
fixed **cannot be determined from here** — this is a note to look, not a confirmed fault.
The feature graphic is in the repo (`store/play/graphics/`) and is the right size.

**Where this leaves the release.** The bundle is built and verified (§7), the privacy page
is not written, and the screenshots are unchecked. Nothing in the app has to change for
either.
