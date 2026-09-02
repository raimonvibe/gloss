# Gloss i18n — Claude Code handoff

## Project

- **App:** Gloss — Flutter lexicon of 134 rare English words
- **Repo:** https://github.com/raimonvibe/gloss (`origin/main`)
- **Open work:** [BACKLOG.md](BACKLOG.md)

### Environments

This project is worked on from more than one machine, so **nothing here assumes a
path or a toolchain layout**. Check before you run anything:

```bash
flutter --version || echo "not on PATH - find the SDK first"
python --version || python3 --version
```

Known checkouts:

| Machine | Path | Flutter | Python | Git |
|---|---|---|---|---|
| Linux | `~/Documenten/Mobile Development/003gloss` | **not** on `PATH` — prefix `PATH="$HOME/Documenten/Developer/flutter/bin:$PATH"` | `python3` (no `python`) | yes, since 2026-08-29 |
| Windows | `C:\Users\rober\Documents\My Tableau Repository\Mobile Development\003 Beautiful Words` | on `PATH` | `python` (no `python3`) | yes, since 2026-08-29 |

Both machines moved to a `003` checkout on 2026-08-29, and for the same reason: each
arrived as a snapshot with no `.git` and was **initialised against `origin/main` rather
than cloned**, so that the files already on disk were kept and merely matched against the
remote.

- `003gloss` (Linux) took over from `002Beautiful Words` at `2dc63a1`. Every
  hand-written file matched; only the 57 generated `app_localizations*.dart` differed,
  and a regenerate settled those — see *Verification*.
- `003 Beautiful Words` (Windows) took over from `002 Beautiful Words` at `59ec260`.
  The whole tree matched, the 57 generated files included. Only `pubspec.lock` differed,
  and that is the toolchain rather than work: Windows Flutter 3.41.7 resolves
  `intl 0.20.2` and `meta 1.17.0` where the Linux 3.47.2 that wrote the committed lock
  resolves newer ones. **Leave it dirty; do not commit it** — the next `pub get` on
  either machine writes it back the other way regardless.

The initialise-don't-clone sequence, which moves the branch and leaves every file alone:

```bash
git init -b main
git config core.autocrlf false     # Windows only, and deliberate
git remote add origin https://github.com/raimonvibe/gloss
git fetch origin
git reset --mixed origin/main      # NOT checkout - that would overwrite the tree
git branch --set-upstream-to=origin/main main
```

`core.autocrlf false` is what stops Windows rewriting line endings into every diff. Keep
it if you re-clone.

`android/key.properties` does **not** travel with a checkout — it is gitignored, as is
the keystore it names, and that keystore lives outside the repo. A fresh checkout cannot
build a release bundle until the file is copied across from the previous checkout (or
written from `android/key.properties.example`).

Both `002` copies are still on disk. They are stale, not second working copies — do not
edit them, and do not try to keep them in step. One thing in them is not on the remote:
`002 Beautiful Words` sits on branch `tablet-rail-restyle`, one commit ahead at
`052371b` *"Raise the bundle to 1.0.0+8"*. It touches `pubspec.yaml` and nothing else,
and `1.0.0+9` here supersedes it. Nothing else in either `002` is unpushed.

## Current state (Aug 2026)

**i18n is complete, UI and word overlays both.** The Study page's 37 keys were the
last gap and are now filled in every locale; `flutter gen-l10n` writes an **empty**
`l10n/untranslated.json`, which is the check worth trusting because it is derived
from the ARBs rather than from a list kept by hand.

`test/l10n_catalog_test.dart` exempts no locale — `const incomplete = <String>{};`
is an empty hook kept for future work — and enforces four invariants:

- every non-English translation key resolves to a 134-word overlay with a non-empty
  `friendly`, `exampleGloss`, and two `rootMeanings`
- every locale carries every key in `app_en.arb` (gen-l10n falls back **per key**, so
  a half-translated screen ships in silence — this test is the only thing that catches it)
- placeholders (`{label}`, `{language}`, `{version}`) survive translation
- the headword `Edulcorate` and the product name `Gloss` stay English

### The counts, and why they differ

| Count | What |
|---|---|
| **178** | countries in `l10n/catalog.json` |
| **61** | `translationKey`s — 60 non-English plus `en` |
| **61** | `lib/l10n/app_<key>.arb` — one per translation key, `en` included |
| **60** | `assets/l10n/words_<key>.json` overlays — one per **non-English** key; English is the source and needs none |

Only the overlay count differs now, and only because English needs no overlay.
`test/l10n_catalog_test.dart` asserts both directions — no ARB without a catalog
locale, no catalog locale without an ARB — so a locale can no longer be half-added
the way `zh` was.

## Architecture

**Bilingual-dictionary model:** English lemmas, pronunciation, and root *forms* stay
English. Translate UI chrome + explanations only.

| What | Where |
|------|-------|
| 178 countries → 60 locales | `l10n/catalog.json` |
| Human spec | `l10n/SOURCE.md` |
| Machine source | `l10n/source/ui.json`, `l10n/source/content.json` |
| Hand-written UI translations | `l10n/source/ui_i18n.json` (59 locales; does **not** track `zh`) |
| UI strings | `lib/l10n/app_<key>.arb` → `flutter gen-l10n` |
| Word overlays (134 words) | `assets/l10n/words_<key>.json` |
| Hand-crafted overlay rows | `tool/_data_<key>.py` (134 tuples × 5 fields) |
| POS + origin maps | `tool/_pos_origin.py` (one entry per locale) |
| English word index | `tool/_en_words_src.json` |
| Emit JSON from `_data_*.py` | `python tool/emit_from_data.py <locale>` |
| Bulk translate (API) | `python tool/translate_l10n.py` |

The **ARBs are the source of truth** for UI strings. `ui_i18n.json` is a human working
copy that no tool reads; keep it in step when you can, but never treat it as canonical.

**Read-aloud across two languages:** `lib/state/reading.dart` is the only place that
decides which voice reads what — `readingOf()` for a whole entry, `glanceOf()` for the
short reading a card gives, `quizReadingOf()` for a question and its four answers,
`spokenLine()` for the app's own copy (a score, a heading), `englishCopy` for the
English twin of any ARB string. Screens must not hand a raw `l10n.` string to
`SpeakButton`: that is what gave the quiz results a Dutch sentence in an English accent.

All four readings share one private shape, `_lemmaThen()`: the lemma to the English
voice, the rest to the reader's, the English quoted inside it cut back out, one group
across the lot. The switch reaches every listen button in the app — the detail page had
it to itself until `f62f92e`, so a reader who turned it on met English everywhere else.
`autoplayPronunciation` ("Read a word aloud when it opens") is a **different** switch:
it decides *whether* a page reads itself on arrival, not *which language* it reads in.
The quiz honours it once per question, answers included, and never again when the
answer lands.

A reading is the page, top to bottom, each piece in the language it is written in:
`readingOf()` sends the lemma and its respelling to the English voice, then hands the
rest — part of speech, origin, roots, meaning, the sentence, the gloss — to
`spokenExplanationWith()` in the reader's language. `spokenEntryWith()` is the same page
in English, and doubles as the fallback. Both cover the whole card; a reading that
stopped at the meaning left the origin and the roots unread.

Translated copy also quotes the English lexicon inside
its own sentences — the Dutch for *amphiboly* explains it with "Visiting relatives can
be tiring" in the middle of a Dutch paragraph. `segmentTranslation()` in
`speech_controller.dart` cuts a passage at every term in `WordEntry.quotedEnglish`
(headword, variants, the example, the phrase the example quotes, origin word, root
forms), so each half reaches the voice it belongs to. The pieces share a `group`: when
the device has no voice for the language, `SpeechController` trades the whole passage
for its English fallback once, instead of each piece falling back on its own.
`test/english_narration_test.dart` sweeps six locales of shipped data for English left
inside a local-voice segment.

**The respelling is written for the eye, spoken for the ear.** The 134 respellings mark
stress in capitals — `HEB-ih-tood`, `PYOO-tuh-tiv` — and a text-to-speech engine reads a
short run of capitals as an initialism, so the guide that was meant to teach *hebetude*
spelled it: "aitch ee bee", then "tood". Every word whose stress falls on one short
syllable had the same fault, in every voice and on every listen button, because the
capitals reached the engine as written. `spokenRespelling()` in
`lib/models/respelling.dart` hands the voice the syllables in lower case and separated by
spaces (a hyphen is a pause, or the word "dash"); the page keeps the capitals it was
written with. Everything spoken arrives there through `WordEntry.spokenWord`, so this is
one place, not one per screen. **Do not fix this by lower-casing speech generally** —
`DNA` is in the English example for *irrefragable* and in all sixty overlays as `ADN`,
`DNK`, `DNS`, and it is an initialism that should be spelled.
`test/spoken_respelling_test.dart` sweeps all 134 for capitals a voice would spell, and
checks that no syllable is lost to the reshaping.

Lower case was half of it. The other half is that **a syllable is not a word**: an
engine handed a fragment it has no entry for guesses from the spelling, and the guess is
often the letter names. `ih` comes out "eye-aitch", so `HEB-ih-tood` was read "heb
eye-aitch tood"; `uk` comes out "U.K.", so *paroxysm* was read "par U.K. siz um". Twenty-four
of the 262 syllables in the lexicon were being spelled rather than said, across **48 of
the 134 words**. `_spokenSyllables` in `lib/models/respelling.dart` gives each of them a
spelling the engine says instead — `ihh`, `uck`, `parr`, `core`, `odd`, `sigh`, `vye`.

**No rule about the spelling predicts which fragments those are.** `par` is spelled and
`tuh` is not; `ih` is spelled and `dih` is not; a syllable with no vowel letter in it at
all (`py`, `fy`, `ty`) is said correctly. It is a property of the engine's dictionary, not
of English, so the table is measured rather than reasoned:

```bash
powershell -NoProfile -File tool/probe_respellings.ps1   # Windows only
```

`tool/probe_respellings.ps1` speaks every syllable in `tool/respelling_tokens.txt` twice —
as itself, and as its own letters spaced apart — inside a carrier phrase, and compares the
phonemes Windows SAPI reports through `PhonemeReached`. Matching readings mean the engine
is spelling the token. The verdicts land in `tool/respelling_probe.json`, and
`test/spoken_respelling_test.dart` reads that file: a syllable that has never been probed
fails the suite, and so does one the probe calls spelled that still reaches the voice. That
is what makes word 135 safe rather than lucky.

Two things about the probe are load-bearing:

- **Compare the phoneme multiset, not the sequence.** `PhonemeReached` arrives on the event
  queue and its order jitters against the carrier between runs; the phonemes themselves do
  not. Comparing sequences made two consecutive runs disagree on a dozen tokens.
- **A carrier phrase, not a bare token.** A token alone in an utterance is treated as an
  abbreviation where the same token inside a phrase is not — `par` and `ret` come back
  clean alone and spelled in context.

**The probe's engine is not the reader's engine.** SAPI is Windows; the phone runs Google's.
They spell overlapping but different sets — *pietistic* was reported from a device opening on
the letter "pee" while SAPI says `py` correctly, and byte-identically to `pie`. So treat a
*spelled* verdict as proof and a *said* verdict as only the absence of one, and prefer a
replacement that is an ordinary English word, which no engine has to guess at. `py`, `fy`
and `ty` are in the table for that reason alone.

**"Read the translation aloud" follows the language the reader picked.** It defaulted to
`false` until 2026-09-02, which meant a fresh install spoke English in all sixty: choose
Arabic, press listen, hear English. Preferences are cleared by a reinstall, so this came
back every time the app was installed again, and it looked like a regression each time.

Every translated test seeded `'beautiful-words:read-translation': true`, so the whole suite
was green while the app did this — the default was the one path nothing exercised.
`test/reads_in_the_chosen_language_test.dart` now covers it from the install default in
Dutch and in Arabic, and checks that a reader who turns the switch **off** stays off:
`readTranslationAloudChosen` is what the study shows, `readTranslationAloud` is the
question the reading asks, and only the second one has a default.

**A respelling has two readers, and `spokenRespelling` only reaches one.** It fixes what
`SpeakButton` says. It cannot reach the *screen reader*: the respelling is also drawn on
the page — the word of the day, every lexicon card, the card at the top of a word's page —
and TalkBack and VoiceOver say whatever is drawn. `py-uh-TISS-tik` on screen was read out
letter names and hyphens included, in an app that had just said it correctly out of its
own button. Every site that draws a respelling now passes `semanticsLabel:` with the
spoken form, and `test/spoken_label_test.dart` walks the app with the real 134 words and
fails on one drawn without it. **A new screen that shows a respelling must carry that
label** — the test is what remembers.

**The engine cannot say the words.** This is the one that matters, and it took a device
trace to see. Gloss is a lexicon of *rare* words, so Google's Android engine holds almost
none of them in its dictionary and invents a reading from the spelling: *pietistic* came
out "pi-e-stic". Every respelling fix above is downstream of that — the respelling was
never the disease, it is the cure the app already had.

**`<phoneme alphabet="ipa">` is the fix, and it works.** SSML reaches the engine — the app
has always wrapped English utterances (`_useEnglishSsml`, set when the engine is Google) —
and two device probes settled what it accepts. The first said `<sub alias="...">` was
honoured. The second, after `<sub>` was still heard saying respellings wrong, asked the
question that mattered:

| Sent | Heard |
|---|---|
| `<phoneme alphabet="ipa" ph="ˌiːmɛnˈdeɪʃən">ee men day shun</phoneme>` | **correct** |
| `<sub alias="ee men day shun">Emendation</sub>` | wrong |
| `ee men day shun` | wrong |

The received wisdom is that on-device engines ignore `<phoneme>`. That wisdom also said
they ignore SSML. **Ask the device.**

So the app hands the voice a *sound*, never a spelling. `assets/data/words.json` carries an
`ipa` for every word, and `lib/models/spoken_forms.dart` carries one for every inflected
form. Neither is written by hand: `tool/emit_ipa.py` derives them from the respellings, and
`python tool/emit_ipa.py --check` fails when the two have drifted apart.

**Why derived rather than fetched.** The respelling is what the page shows and so is the
app's own authority; the inflected forms have no dictionary entry; and eighteen of the 134
have no Wiktionary entry at all. It was checked against Wiktionary all the same, and that
check earned its keep — it found five rule bugs (`eh` keeping its h, `tch`, `ye`, unstressed
`-ar`, and an `-ed` rule that fired on *seed*). Of the 116 words Wiktionary knows, the
derived IPA agrees with it on 84; the rest are rhotic and US/UK differences and the handful
of attested variants the pronunciation audit already recorded.

**A respelling that writes a full vowel where the word has a schwa is now a wrong
pronunciation, not a loose one.** *Edulcorate* was `ee-DUL-cor-ate` and *Anchorite* was
`ANG-kor-ite`; both wrote `-or-` for what dictionaries reduce to /ə/. They are
`ee-DUL-kuh-rate` and `ANG-kuh-rite` since 2026-09-02, and the derived IPA followed on its
own — `iːˈdʌlkəreɪt` and `ˈæŋkəraɪt`, which is what Wiktionary and Merriam-Webster both
give. This is the same lesson as `PARR-`: once the IPA is derived from the respelling, the
respelling has to be right rather than merely readable.

Six more were flagged by the pronunciation audit and are **not** errors — ours is an
attested variant in every case, and for four of them it is Merriam-Webster's first:

| Word | Ours | The other reading | Verdict |
|---|---|---|---|
| Irrefragable | ir-eh-**FRAG**-uh-bul | ih-**REF**-ruh-guh-bul | the other is primary in RP and GA |
| Extant | ek-**STANT** | **EK**-stunt | the other is M-W's first |
| Reify | **RAY**-ih-fy | **REE**-uh-fy | ours is M-W's first — keep |
| Patois | **PAT**-wah | puh-**TWAH** | ours is M-W's first — keep |
| Ersatz | AIR-**zahts** | AIR-**zats** | ours is the US reading — keep |
| Pococurante | …-**RAN**-tee | …-**RAHN**-tee | ours is M-W's — keep |

**A doubled r shortens the vowel, on the page and in the fallback.** `PAR-` is the /ɑːr/ of
*bar* and `PARR-` is the /æ/ of *bat* with an r after it. *Parry* and *Paroxysm* were written
`PAR-` and so were being said "par-ee" and "par-ok-sizm"; they are `PARR-` since 2026-09-02,
which the pronunciation audit had flagged against Wiktionary. *Parsimony* keeps `PAR-`
because it really is /ˈpɑːrsɪmoʊni/. The IPA follows the respelling automatically —
`emit_ipa.py` reads the doubled r — and the fallback table maps `par`→`parr` and
`parr`→`parre`, which are the spellings a speech engine reads as those two sounds.

**The respelling rides inside the tag as its text**, so an engine that ignores `<phoneme>`
says exactly what the app said before, and `ssmlToPlainText` gives it the same thing when
it is not handed SSML at all. That is what the 27 substitutions in `respelling.dart` are
for now — a fallback, not the main road. Nineteen of them are invented spellings measured
against Windows SAPI, and the phone disagreed with SAPI on `eeh`, which is why `ee` is no
longer substituted and why the device's verdict overrules the desktop probe's wherever the
two have been heard to differ.

`<phoneme alphabet="ipa">` is a different matter and is **not** supported by the on-device
engines — it is a cloud-API feature (Google Cloud TTS, Polly, Azure). An engine that does
not know a tag speaks its inner text, which is why `<sub>` costs nothing where it is
unsupported, and why reaching for `<phoneme>` would buy nothing here.

**`quotedEnglish` must name every form, not just the headword.** Translated copy keeps the
English word in whatever shape its own sentence needs — the Dutch for *edulcorate* reads
"De redacteur **edulcorated** de harde recensie" — and `segmentTranslation` only cuts out
the terms it is told about. It was told about `Edulcorate`, which does not stand alone
inside `edulcorated`, so the whole sentence went to the Dutch voice and the English word
came out in a Dutch accent. It now lists `spokenForms.keys`, so every inflection and
variant is cut out and handed back to the English voice, where `voiced()` gives it its
phoneme. Heard on a device and fixed on 2026-09-02.

**The mechanism is general across the sixty; its coverage is only as wide as
`kSpokenForms`.** `segmentTranslation` cuts English out of a translated passage identically
in every language, but it cuts only the terms it is told about, so the table has to name
every English word the copy keeps. `tool/find_unsaid_english.py` reads all sixty overlays
and reports standalone words built on a headword's stem that the table does not know:

```bash
python tool/find_unsaid_english.py
```

It found four real ones — *plumb* (quoted alone out of "Plumb line", in all sixty),
*fructifies*, *mortise*, and *ingenious*, which is not an inflection at all but the word
fifty-nine explanations name to tell it apart from *ingenuous*.

**It cannot be a test**, and that is the point of it being a tool. Most of what it reports
is the local language's own vocabulary standing on the same Latin root — Spanish *ingenuo*,
French *mendiant*, Italian *fiducia*, Portuguese *fuligem* — and those correctly stay with
the local voice. Sixty-one such remain, and telling them from real English needs an eye,
not an assertion.

**Every English passage the app speaks goes through `WordEntry.voiced()`.** The headword
at the top of a reading was the easy half; the sentence underneath names the word again,
and often inflected — *edulcorated*, *parried*, *animadversions* — where the headword's own
respelling would say the wrong word. `voiced()` wraps every form it knows, longest first,
whole words only, and the text inside the tag is the text as written, so an engine that
ignores `<sub>` reads exactly what it read before.

`kSpokenForms` in `lib/models/spoken_forms.dart` holds the forms that are not the headword
— 21 of them, the 17 inflections the examples use plus the 4 variants — written in the
same notation as the 134 and put through `spokenRespelling`, so they inherit the measured
substitution table rather than sitting beside it. Two of them (`tid`, `eed`) were caught by
the probe on the way in and replaced with `tidd` and `ihd`; that is the guard working.

The counts are worth keeping: every one of the 134 examples names its own headword, 117 in
the exact form. `test/spoken_forms_test.dart` fails on an example whose form is neither the
headword nor listed, on a form whose respelling brings in an unprobed syllable, on a table
id that is not a word, and on nested markup. So a new word cannot quietly ship a sentence
the voice will mangle.

**Voice the parts, never the assembly.** `voiced()` asserts on a passage that already
carries markup, because run twice it would match a headword inside a tag it wrote a moment
earlier. `spokenEntryWith` therefore voices each part and then joins; `reading.dart` voices
the English segments *after* `segmentTranslation` has cut them, because that cutting finds
its terms by matching `quotedEnglish` against the passage as written and pre-wrapped markup
would hide them.

**Only Google's Android engine is handed SSML.** iOS, desktop and every other Android
engine get plain text, so `ssmlToPlainText` in `lib/models/ssml.dart` turns a `<sub>` back
into its alias for them — the alias is the pronunciation the tag existed to deliver, so
they hear the respelling. A sentinel reaching one of those engines unconverted would be a
control character in the middle of a word, which is worse than the bug this fixes.

**The app writes tags with sentinels, never with brackets.** `wrapEnglishSsml` must escape
the utterance — the lexicon's text carries `&` and quotation marks, and one unescaped
character makes the whole utterance malformed XML, which an engine answers by saying
nothing at all. Escaping cannot tell a tag the app meant from a bracket the data happens
to contain, so `ssml.dart` writes ``, ``, `` and the wrapper turns those
into `<`, `>` and `"` *after* escaping. Data can never reach the parser as markup; the
app's own tags always do.

**English word data (repaired 2026-08-29):** `assets/data/words.json` had been through
one round of escaping too many — 20 `example` fields showed a literal `\"` on screen and
23 `friendly`/`definition` fields were cut off where their quotation began. All 43 were
restored from `tool/_en_words_src.json`, which is the canonical English source and was
never damaged; the 60 overlays never were either. `quiz_and_data_test.dart` now fails on
a backslash or an unclosed quotation in the shipped English text.

**Proofreading the shipped text:** `test/text_quality_test.dart` runs the mechanical
half over all sixty languages — a quotation that closes, a bracket with a partner, no
stray escape, no doubled punctuation, no word typed twice. It is calibrated against the
languages rather than against English: French puts a space before `:` and `?`, quotation
marks close with different characters per language, and Turkish `uzun uzun`, Swahili
`lile lile` and Urdu `ایک ایک` are ordinary reduplication — those twenty-three live in
`_knownReduplication`, each checked by hand. The checks say nothing about grammar, which
no tool can settle for sixty languages; they catch the generation damage that has twice
reached the store.

**The quiz gave its answer away twice over, and the roots were only half of
it.** *Hebetude* was asked with `hebes` "dull, blunt" printed above four definitions of
which one was "Mental dullness or lethargy", against distractors about moralizing,
wisdom and air pressure. Two changes, and the second is the one that matters:

- `EtymologyCard` takes `revealRoots`, and the quiz passes `quiz.hasAnsweredCurrent`, so
  the roots arrive with the rest of the explanation. **The reading had to follow**, or
  the giveaway would simply have moved to the listen button: `spokenQuizPromptWith` and
  `spokenPromptWith` take `withRoots`, and `quizReadingOf` passes `revealed` into both.
  The etymon (`torpidus`) stays in the prompt — it is on the card as the origin chip,
  and it names the word rather than its meaning.
- `_distractorsFor` in `quiz_engine.dart` draws the three wrong answers from words that
  **share a theme**, then from words that share an **origin**, then from anything, each
  band shuffled so a word does not meet the same three every time. Random distractors
  were the root cause: a hint is only decisive when the other three options are nowhere
  near. The lexicon's themes are wide enough for this — 35 in `criticism`, 30 in
  `knowledge`, and 72 of the 134 carry more than one tag — and a theme too thin to fill
  three (`emotion` has one word) falls through to origin on its own.

`test/quiz_gives_less_away_test.dart` covers both, the reading included. Note that
`origin` is localised per locale by `tool/_pos_origin.py`, so comparing origins compares
like with like inside one locale.

**A word's origin has two halves, and each was being said by the wrong mouth.** A Dutch
reader was told *Chicane* comes "van Frans" and then heard **chicaner** read with an
English mouth; the same reader met **Oudengels** and heard one mangled word.

- **The etymon belongs to the language it is written in.** `kOriginVoices` in
  `lib/models/origin_voice.dart` maps a single-language origin to a voice, and
  `reading.dart` re-tags the segment `segmentTranslation` had already cut out for
  English. Three deliberate holes in that table: **compound origins** are excluded,
  because "Latin / Old French" quotes *escutcheon (escuchon)* — the English word and
  then the French — and "Latin / English" quotes *plumbum + line*; **Greek** is excluded
  although nineteen words are Greek, because ours is transliterated (*panēgyrikos*) and a
  Greek voice handed Latin letters spells them; and **Latin is read by an Italian voice**,
  which is the one judgment call — no engine has Latin, eighty-one of the 134 are Latin,
  and Italian is the pronunciation ecclesiastical Latin uses. One line to revert.
  Root forms carrying a gloss or a second language (`racine (radix)`, `caro, carnis`,
  `poco + curante`) keep the English voice; `kMixedForm` is that test.
- **The etymon segment carries its own fallback and no group**, which matters more than it
  looks: a grouped segment takes its whole passage down to English when the device lacks
  the voice (see `_settleGroups`), so a missing French voice would have cost the reader
  their entire Dutch reading. Ungrouped, it falls back alone and everything around it is
  untouched.
- **The count, because "did you do all of them?" deserves a number.** 105 of the 134 have
  their etymon read in its own language; 87 of those have every root form too. The 29 that
  do not are each excluded on purpose: **19 Greek**, transliterated into Latin letters;
  **7 English, Old English and Middle English**, where the English voice is both the right
  one and the only one an engine has; **Frankish** *seneschal*, which no engine speaks; and
  **plumb-line** and **hardihood**, which quote an English word beside the foreign one
  (*plumbum + line*, *hardi + -hood*) so that no single voice is right for the pair.
  `test/spoken_origins_test.dart` holds that census as a set of ids — a word that loses
  its voice, or gains one unexpectedly, fails it.
- **Compound origins were resolved one at a time, not by rule.** The first attempt
  excluded all sixteen; a rule taking the first named language would have been wrong three
  times out of four, because the "Latin / French" words are *mordere* (the Latin) but also
  *demorer*, *mortaise* and *apartenance* (the French). `kEtymonVoiceByWord` is that
  reading, one line per word. Where a word's roots are in a different language from its
  etymon — Latin *morari* under French *demorer* — they follow the etymon: a Latin root in
  a French mouth is a smaller error than the English one it had, and a language per root is
  not something the lexicon records.
- **A macron means transliterated Greek**, wherever it turns up. *splēn* sits under
  "Greek / Latin" and *paidagōgos* under "Italian / Greek", so the origin does not always
  say Greek and `kTransliteratedGreek` is what catches them.
- **Only the translated reading is split this way.** The English-only reading is one
  assembled, already-voiced string, and cutting it at the etymon would mean splitting
  text that contains SSML — *Voice the parts, never the assembly*. An English reader still
  hears *chicaner* in English.

**The name of the origin is a compound in seventeen of the sixty, and the seam is derived
rather than listed.** Dutch writes Old English closed as *Oudengels*, German as
*Altenglisch*, Russian as *древнеанглийский*, and an engine handed a compound it has no
entry for guesses from the spelling. `spoken_origin.dart` finds the seam from the
lexicon's own data: **the language names a locale uses are the simple origin labels it
uses elsewhere**, so a label ending in one of them and longer than it splits exactly
there — *Oud engels*, *Alt englisch*, *древне английский*. Nothing in it knows a word of
any of the sixty, and no locale needs a line of its own; compare `_spokenSyllables`, which
could not be derived and had to be measured one at a time. Scripts written without spaces
are excluded: 古英語 ends in 英語 and is one word to a Japanese voice all the same. The page
always shows the written form — `WordEntry.spokenOrigin` is read by speech alone, and
`WordRepository` works the table out once per locale because the seam needs the whole
lexicon's labels, not one word's. `test/spoken_origins_test.dart` sweeps all sixty and
holds the transformation to one invariant: **a spoken origin may gain spaces and nothing
else.**

**The split is applied where the origin is named, and that is the whole of it only while
no other sentence quotes one of these compounds.** Measured across all sixty overlays and
every spoken field — definition, friendly, example gloss, part of speech, root meanings —
a compound origin word appears in prose **zero times**; the simple labels (*Latijn*,
*latin*, *ladina*) turn up often and need no splitting. A test pins the zero, so a future
gloss that writes "Oudengels" into a sentence fails the suite rather than being read
wrong. Note what that test needed to be correct: `'\p{L}'` in a plain Dart string is not
an escape Dart knows, so the first version handed the engine `p{L}` and matched nothing —
a test that passed because it never looked. `flutter analyze` caught it.

The heart also stands in the word page's own app bar now. The Save pill is at the foot of
the page, behind the roots, the sentence and the gloss, and a reader who already knows
they want the word should not have to read to the end to keep it.

**"Hard to read even after increasing the font size" — the reader had run out of
slider, and the slider was not the whole of it.** `kMaxTextScale` was 1.6; it is 2.0
since 2026-09-02, which `app.dart` had always been prepared to pass through
(`combined.clamp(1.0, 2.0)`). Cormorant Garamond is a small-eyed face — 16pt of it sets
about the size of 14pt of a workaday serif — so this scale carries more weight here than
the same number would elsewhere.

**Every test that asked for 2.0 had been quietly handed 1.6**, so raising the cap was
the first time the app was measured at its own maximum, and three things were waiting
there:

- **The lexicon showed no words at all** on a 320pt phone. Nothing overflowed, so nothing
  failed: the title and its script caption stood 400pt tall on a 640pt screen, the search
  box and chips took what was left, and the `Expanded` list was handed no height. The
  ornament is what gives now — `ScriptCaption` clamps its own scaling at 1.3 and the
  lexicon's page title at 1.4. **The reader's setting is for the words, not for the
  flourish over them.** `test/responsive_test.dart` asserts a word card is on screen.
- **Two sliders with a label at each end** — text size, speech pace — pushed themselves
  off their own row. Both legends moved underneath the slider, two halves of a row that
  wrap rather than shove.
- **The empty lexicon/saved state** could not fit its two centred lines, so it scrolls
  when it must and stays centred when it can.

**The gold was too pale to be read, and it is text as often as it is ornament** — *tap
to read more*, the progress percentage, the origin chip, every `ScriptCaption` heading.
`#A9762F` measured **3.8:1 on a card, 3.6:1 on the page, 3.2:1 on a tag**, all under AA's
4.5. It is `#896026` since 2026-09-02, a deeper bronze that clears 4.5 on every ground it
is drawn against — the gold-tinted chip fill included, which is the tightest of them.
`foregroundMuted` was already 6.5:1 and the dark theme passed throughout.

`test/contrast_test.dart` now holds every colour that carries a word to AA, on all four
grounds, in both themes, so the next hand on the palette hears about it at once. One
colour is deliberately outside it: `cardBorder` measures about 1.8:1, and it is a
hairline around a card rather than something a reader must perceive to follow anything.
It is worth revisiting if the cards are ever given their shadow back — the hairline is
doing that job alone.

**The reading prose went up a point, and its lines were opened out.** Cormorant sets
small for its size, so a card's plain-words line, a definition, an example and its gloss,
a quiz's four options and the theme's own `bodyMedium` are 17pt on a 1.45 line rather
than 16 on 1.35–1.4. Labels, chips, captions and buttons were left alone: this is for the
text a reader reads at length, not for the furniture around it.

**A reading is the page, and that includes the headings over it.** Two were missing and
one was wrong: the definition was read with nothing introducing it, the sentence was
announced as "Zoals in" where the page says *in een zin*, and only *in gewone woorden*
matched. So a reader following along heard the app name a section that was not on the
page and skip two that were. `SpeechTemplates` now composes all three from **the page's
own strings** — `l10n.inPlainWords`, `l10n.theDefinition`, `l10n.inASentence` — rather
than from speech keys of its own, which is what stops them drifting apart again and
needed no new translation, because the page already had the sixty. `speechInPlainWords`
and `speechAsIn` are unused in the ARBs now; they stay there, because taking a key out of
sixty files buys nothing.

**A placeholder is an instruction, and it was being cut off mid-phrase.**
`InputDecoration.hintMaxLines` follows the field's own `maxLines`, which is one for a
search box or a name — so "Zoek een woord, of beschrijf de betekenis…" ended in an
ellipsis, and worse at every step up in text size. `hintLines(context)` in `app_theme.dart`
gives a placeholder **one line until the reader enlarges the type and four after that**:
the search pill keeps the shape it was drawn for at the ordinary size, and at the large
sizes — where nothing on the page is slim any more — the hint wraps and the field grows to
hold it. `test/placeholder_test.dart` checks the policy away from any font (a test face
makes every glyph a full em square, so counting lines here says nothing about a device)
and then that the field really did grow to hold what it allowed.

**A fixed box with type in it is a bug waiting for a reader to turn their text up.** The
quiz's answer badges were a 32pt circle holding a letter that follows the reader's
setting: at 1.6 the letter wanted a 36.5pt circle and at 2.0 a 45pt one, so A, B, C and D
were drawn outside their own circles. The circle is now `scaler.scale(16) * 2`, and the
tick and cross inside it scale with it.

Two things about finding it are worth keeping:

- **Nothing failed, and nothing could have.** A `Container` is not a `Flex`: a child too
  big for it is painted over the edge in silence, the same silence that hid the clipped
  filter strip. Only a reader saw it.
- **A rect will not show it either**, which cost a first attempt at the test. A Container
  with an alignment hands its child *loose* constraints, so the letter's own box is
  clamped to the circle while the glyph is painted past it — the box always fits. The test
  measures the type the letter asks for, with a `TextPainter`, against the circle it was
  given, **and compares the diagonal**: a box only fits a circle if its diagonal does, and
  in the test font every glyph is a full em square, so comparing heights is a tie the bug
  wins. It was checked both ways round — the test fails with the old 32pt box and passes
  with the new one.

The other fixed boxes in the app (42pt for the listen, save, study and light buttons, 44
for the social row) hold **icons**, which do not follow the text size, so they are sound.

**The quiz's top strip is two shapes, not one.** Leave, how far along, save, listen,
light — five things across a phone is one too many. The progress line was handed whatever
the four controls left it, and the controls are a fixed `48 + 3×(42 + 8)` = **198pt** at
every text size, so on a 390pt phone the line had 152pt: "Vraag 3 van 5" wrapped into
three lines inside a bar drawn for one, with the percentage crushed against the edge.
`_QuizHeader` measures with a `LayoutBuilder` and drops the progress line underneath the
controls whenever sharing would crush it — every phone, and a tablet once the text is
large enough. **The floor is measured in type, not pixels** (`_progressFloor` scales 190
by the reader's `textScaler`), because the controls do not grow with the text and the
line beside them does. `test/quiz_header_test.dart` pins both shapes, and note what it
does *not* assert: how many lines the label takes. A test runs in a full-em font, so the
label wraps there at widths where the shipped Cormorant would not — the width the layout
hands it is the part the layout controls.

**A word can be saved wherever it is shown.** The heart lived on the lexicon card
alone, so a reader who met a word as the word of the day, inside a quiz, or in the list
of what they had just been asked had to go and find it again in the lexicon to keep it.
`lib/widgets/favorite_button.dart` is that one control: it wires itself to
`ProgressController`, so a screen has only to name the word it is drawing, and the four
places that draw one cannot fall out of step. It follows `SpeakButton`'s two shapes —
a bare icon inside a card, a gold circle where it stands beside one. The word's own page
keeps its labelled *Save* pill instead. `test/save_from_every_screen_test.dart` saves
from each of the four, and checks the quiz's now four-icon header still fits the
smallest phone at the largest text size.

**Responsive layout:** `lib/theme/layout.dart` owns the breakpoints, gutters, reading
width, and column counts. Read it with `context.layout`, which measures the space the
page was actually handed — `LayoutBoundary` publishes that, because the window is the
wrong ruler once the navigation rail stands beside the page (and because
`setSurfaceSize` in a test does not move `MediaQuery`). Below 840pt the tabs sit along
the bottom; above it they move to a rail. `test/responsive_test.dart` walks every tab
at six window sizes plus the largest text size — an overflow anywhere fails it.

**Spacing is layout, not content.** Where a left-to-right island sits beside translated
text, the air between them must be a gap in the row — never slack inside a fixed-width
box, never spaces typed into the front of a string. Both only work while the page reads
left to right: laid out right to left the box is the right-hand one and its slack falls
on the far side, which is how the Arabic etymology card came to read
`يناضل للخروجeluctari` with nothing between the root and its meaning. Which edge an
`EnglishLemma` stands against is read from `Directionality.of(context)`, not from the
form. `test/layout_fit_test.dart` measures the gap on a right-to-left page.

**Cards carry no shadow.** Impeller draws a blurred `BoxShadow` on `CardSurface` as a
hard-edged rectangle — the blur squares off at the bounding box, leaving every rounded
card inside a grey box with pointed corners, in both themes and at every radius. Flutter's
own rasteriser draws it correctly, so a widget test will not catch this; it was found and
fixed on a device at `d1a5a70`. A stadium shape and moving the decoration out of the
material's ink layer were both tried and neither helped. `brand.cardShadow` is kept but
unread, so restoring the shadow on a renderer that draws it properly is one line.

**The letter to the maker:** Study → About → *Write to the maker* opens
`ContactScreen`, which posts to the **same Formspree form the website's contact
page submits to** (`formspree.io/f/<kFormspreeForm>`), under the website's own
field names, so a letter written on a phone files beside one written in a
browser. `category` and `priority` are sent in **English whatever the page is
written in** — sixty languages of "Something is wrong" would leave an inbox that
cannot be sorted — and `language` says which of the sixty it was. Everything
decidable without a screen lives in `lib/state/contact_letter.dart` and is
tested there: the address shape, the mistyped-domain correction, the letter, the
`mailto:` fallback, the draft.

Three things about it are load-bearing:

- **The clipboard is filled first and always**, before the post. A post fails for
  reasons a reader cannot see, and none of them should cost them what they wrote.
  A refusal keeps the draft and offers the mail composer; only a letter that
  actually arrived clears it.
- **The draft is saved without notifying.** It sits on `SettingsController`
  because that is where the app's one `SharedPreferences` handle is, but a draft
  is not a setting: `notifyListeners` between two keystrokes would rebuild the
  whole app.
- **A release build now needs `INTERNET`**, which used to be debug-only, and a
  `SENDTO`/`mailto` entry in `<queries>` or Android 11+ hides the composer. Play's
  data safety answers turned over with it — see `store/play/GOOGLE-PLAY-CONSOLE.md`,
  which is now the record of that, and the privacy page still needs a paragraph
  about the form.

The study's card, hairline, switch row, link row and light switch live in
`lib/widgets/settings_section.dart` so both pages wear the same furniture. A
placeholder is drawn against the theme rather than by it: the app's
`InputDecorationTheme` has no border and a transparent fill, which suits the one
search box it was written for and leaves a letter's fields as floating text.

**App wiring (done):** `SettingsController` locale persistence, `WordRepository.applyLocale()`,
`LanguagesScreen` (5th tab + Home shortcut), RTL lemma isolation (`EnglishLemma`),
`AppFonts` fallbacks, English TTS lock in `speech_controller.dart`.

## Adding a new locale

1. Add the locale to `l10n/catalog.json` and its POS + origin maps to `tool/_pos_origin.py`
2. Add `lib/l10n/app_<key>.arb` with **every** key from `app_en.arb`, then run `flutter gen-l10n`
3. Write `tool/_data_<key>.py` (see schema below)
4. Emit: `python tool/emit_from_data.py <key>`
5. Run `flutter test test/l10n_catalog_test.dart`
6. Commit only when the user asks

### `_data_<locale>.py` schema

Each file has `ROWS` — a list of **134** tuples in word order (same order as
`tool/_en_words_src.json`):

```python
# (definition, friendly, exampleGloss, root1, root2)
ROWS = [
    ("...", "...", "...", "...", "..."),
    # ...
]
```

- Keep English lemmas inside `exampleGloss` (e.g. `"The editor edulcorated the review."`
  stays; gloss the sentence around it).
- Use a neighbouring language's file as a quality reference (e.g. `tool/_data_th.py`,
  `_data_km.py`, `_data_lo.py`, `_data_my.py` for the SE Asian family).

## Google Translate rate limits — how we handled this before

**Do not keep hammering the free `gtx` endpoint after 429 errors.**

### Option A — Paid API (if available)

```bash
export GOOGLE_TRANSLATE_API_KEY=your_key
python tool/translate_l10n.py --content-only --only lo my
```

`translate_l10n.py` caches to `l10n/cache/` (gitignored), retries 429 with backoff, and
skips locales that already have output.

### Option B — Hand-craft (what produced all 59 locales, and the 37 Study keys)

When Google rate-limited, we **stopped the translate job** and:

1. Wrote `tool/_data_<locale>.py` directly (by hand or via agent), using `content.json`
   and a neighbouring locale as reference
2. Ran `python tool/emit_from_data.py <locale>`

**This is the recommended path.** Lao and Burmese were written this way, from the English
source rather than relayed through Thai. The Study page's 37 UI keys × 60 locales were
written the same way, straight into the ARBs.

### Option C — Machine translate from a neighbouring locale (fallback, slow)

`tool/gen_lo_my_from_th.py` shows the pattern (th → lo, th → my via the free `gtx`
endpoint). It was **not** used for the shipped Lao/Burmese rows — relay translation
degrades the literary "friendly" copy. Only reach for this if Option A/B are unavailable,
and kill the process if 429 persists.

## Verification

This is the single source of truth for how to check the project; [BACKLOG.md](BACKLOG.md)
defers to it.

```bash
# Row count + emit  (use python3 on Linux)
python -c "from tool._data_lo import ROWS; print(len(ROWS))"   # expect 134
python tool/emit_from_data.py <locale>

# Localizations - this must leave l10n/untranslated.json empty
flutter gen-l10n

# On Linux, Flutter is not on PATH:
#   PATH="$HOME/Documenten/Developer/flutter/bin:$PATH" flutter test
flutter analyze
flutter test
```

### The generated l10n files are output, not source

`lib/l10n/app_localizations*.dart` — 57 files — are written by `flutter gen-l10n` from
the ARBs. Nothing should ever edit them by hand, and `gen-l10n` is the only thing that
gets to say what they contain.

Worth knowing, because it cost an hour on 2026-08-29: the `003gloss` snapshot arrived
with all 57 of them differing from `origin/main` at `2dc63a1` — **+125/−68, whitespace
and trailing commas only, not one translated string changed**. Copied working trees can
carry stale generated output like this, and the first `gen-l10n` in a fresh checkout runs
before `pub get` has resolved anything, which is its own way of producing a file that
does not match.

The arbiter is a regenerate on a settled checkout. `flutter gen-l10n` on Linux / 3.47.2
rewrites all 57 and reproduces `origin/main` byte for byte, so a formatting-only diff in
these files is something to throw away rather than commit:

```bash
flutter pub get && flutter gen-l10n
git status --short lib/l10n          # expect nothing, if no ARB changed
git checkout -- 'lib/l10n/app_localizations*.dart'
```

Name the generated files, never the directory: the hand-written `app_<key>.arb` live in
`lib/l10n/` too, and `git checkout -- lib/l10n/` would take sixty locales of translation
down with the reformat.

A diff here that survives a clean regenerate is a real change and belongs in the commit.

### Known-good baseline

A baseline means nothing without the commit it was taken at:

| When | Commit | Machine | Flutter | `analyze` | `test` | `untranslated.json` |
|---|---|---|---|---|---|---|
| 2026-08-29 | `2dc63a1` | Linux | 3.47.2 / Dart 3.13.2 | clean | **133/133** | empty |
| 2026-08-29 | `2dc63a1` | Windows | 3.41.7 | clean | **133/133** | empty |
| 2026-08-29 | `59ec260` | Windows | 3.41.7 | clean | **146/146** | empty |
| 2026-08-29 | `096727e` | Windows | 3.41.7 | clean | **153/153** | empty |
| 2026-08-30 | `36dfbe8` | Windows | 3.41.7 | clean | **166/166** | empty |
| 2026-08-31 | `b800a98` | Windows | 3.41.7 | clean | **177/177** | empty |
| 2026-09-02 | `4f7da5f` | Windows | 3.41.7 | clean | **199/199** | empty |
| 2026-09-02 | `daa0a98` | Windows | 3.41.7 | clean | **206/206** | empty |
| 2026-09-02 | `1333cf1` | Windows | 3.41.7 | clean | **218/218** | empty |
| 2026-09-02 | `a774b84` | Windows | 3.41.7 | clean | **224/224** | empty |

The suite grew from 133 to 146 to 153 to 166 to 177 to 199 to 206 to 218 across those
commits; the number is a fact about the commit, not a constant to hold.

**`english_narration_test.dart` is flaky under full-suite concurrency**, and has been since
before `1333cf1` — the file sweeps sixty locales and one of its cases trips the 30s per-test
timeout when the machine is loaded, while passing on its own in about 20s. It was confirmed
against a stashed tree, so it is not the respelling work. Run the suite in two halves to see
218 green:

```bash
flutter test $(ls test/*.dart | grep -v english_narration)
flutter test test/english_narration_test.dart
```

Raising the timeout on that file would settle it properly.

`flutter build apk --debug` exits 0 on Windows at `2dc63a1`.

`flutter build appbundle --release` exits 0 on Windows at `a774b84` (`1.0.0+16`), writing a
47.9 MB bundle — `versionCode 16`, signed `CN=Gloss, O=Raimonvibe`, `INTERNET` and the
`SENDTO` query both in the merged manifest, and all 134 words carrying their `ipa` in the
shipped `words.json`. The same size as `1.0.0+15`, which is what a change of this shape
should weigh: the IPA is a short string per word against a 47.9 MB bundle.

Before that, `daa0a98` (`1.0.0+15`) wrote 47.9 MB too — the same size as
`4f7da5f` + `1.0.0+14`, which is what a change of this shape should weigh. It was 47.3 MB
from `59ec260` + `1.0.0+9` through `1.0.0+13`; the contact form's `http` dependency is the
difference. Check what came out before uploading —
`keytool -printcert -jarfile app-release.aab` must name `CN=Gloss, O=Raimonvibe` (the
upload key, not a debug key), and
`build/app/intermediates/merged_manifest/release/*/AndroidManifest.xml` carries the
`versionCode` in plain text, which the bundle's own protobuf manifest does not. Grep the
same file for `android.permission.INTERNET`: without it the contact form cannot post, and
nothing in a widget test would tell you, because the debug manifest has always had it.

The Flutter version differs by machine. Record which one you used, **and at which
commit**, when you move the baseline.

## Do not

- Invent native-language lemmas for the 134 English headwords
- Commit `l10n/cache/` or secrets (`.env`, API keys)
- Force-push `main`
- Amend commits unless explicitly requested
- Commit a `gen-l10n` run whose only change is formatting — see *Verification*
- Assume this checkout is a git repo, or that Flutter is on `PATH` — see *Environments*
- Put a blurred shadow back on `CardSurface` without looking at it on a device — see
  *Cards carry no shadow*
- Trust a widget test alone for anything the **renderer** draws; Flutter's test
  rasteriser is not Impeller, and twice it disagreed with the device

## Reference commits

- `5f26ad9` — Main bilingual i18n + language picker
- `6cbecd8` — Khmer overlays + Caucasian/Turkic refresh
- `9076dbb` — Lao + Burmese overlays; all 59 locales complete
- `d77e39f` — Study page (the one that introduced the 37-key gap)
- `f62f92e` — Read-aloud reaches every listen button; the quiz reads its own answers
- `d1a5a70` — Cards lose their shadow (Impeller)
- `2590a5f` — Right-to-left gap between a root and its meaning
