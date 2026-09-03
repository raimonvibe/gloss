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
English. Translate UI chrome + explanations only. **The example sentence's gloss is an
explanation, and since 2026-09-03 it is translated whole** — see *The English inside the
example sentence* below, which is the one place this rule moved.

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

**A doubled vowel is one sound to the eye and two letter names to an engine**, which is
the capitals again in a smaller hat. `ee` is how a respelling writes /iː/ — thirteen of
the 134 open or turn on one, *Edulcorate*, *Eluded*, *Emendation*, *Ineluctable*,
*Excoriate*, *Incipient*, *Invidious*, *Seriatim*, *Prurience*, *Nugatory*, *Minatory*,
*Parry* and *Demi-monde* — and an engine names both letters: "E-E-dul-kuh-rate", reported
from a phone on 2026-09-03 and confirmed on SAPI, which gives two beats of /iː/ where a
lone `e` gives exactly one.

`ee` is `e` now, and **that entry is the only one in the table that does not depend on
which engine is listening.** Everything else there is a spelling some measured engine
happens to say, and carries the risk that the next engine does not — which is exactly
what went wrong the first time this was looked at: the table sent `eeh`, SAPI read it as
one clean beat, and Google's Android engine spelled it "ee ee aitch" (heard in
*Emendation*). The conclusion drawn then was to send the bare `ee` and accept that an
engine might spell it, on the theory that the letter E is near enough the sound. It is
not: two letters are two names.

A lone letter has only one reading anywhere — its name — and **the name of E is /iː/**, so
spelling it and saying it arrive at the same place. That is the general shape of the fix
and the thing to reach for next time: where a syllable is a bare vowel with no consonant
to anchor it, there is no ordinary English word to fall back on, so fall back on the
letter whose *name* is the sound rather than on a spelling that merely looks like it.

It needed one rule in the test to change with it. `heardOnDevice = {'ee'}` was an
exemption saying the phone had overruled the probe; it is `spelledIsTheSound = {'e'}`,
which says something a good deal narrower — **a syllable the probe calls spelled may
reach the voice only when being spelled out loud is the sound it was written for.**

**The probe has no useful verdict about a one-letter token**, which is worth knowing
before trusting one. Its test is whether a token reads the same as its own letters spaced
apart, and for a single letter those are the same string, so the answer is whichever way
the phoneme events land: `e` came back `SPELLED` on one run and `said` on the next. The
exemption is there for that rather than for a verdict. What is stable is the measurement
underneath — the phoneme count in the carrier phrase — and that is what settled the
choice: `ee` is two beats of /iː/ and `e` is one. Re-running the whole probe reproduced
all 24 spelled verdicts and all 281 said ones unchanged, so the instrument is steady
everywhere the question is meaningful.

The same pass closed the gap that let `ee` sit there unnoticed. The sweep asked whether a
*spoken* syllable is in the probe's spelled list, so a replacement the probe had never
been shown answered "no" and passed in silence. Every replacement is in
`tool/respelling_tokens.txt` now and a test says so, which matters because the replacement
is the string that actually reaches a reader's ear.

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

**The word rides inside the tag, not the respelling — and it took a device to see why.**
The reasoning used to be that an engine ignoring `<phoneme>` should hear the respelling,
since that is the pronunciation the tag existed to deliver. It is the opposite. A
respelling is spaced syllables, so those engines said `gair uh lus` — three tokens with a
pause between each — and *Garrulous* was read out a syllable at a time. Reported from a
device on 2026-09-03, and it was every one of the 134 on every engine that is not
Google's, which is most of them: `_useEnglishSsml` is set from the engine name, so iOS,
desktop and Samsung's TTS all get `ssmlToPlainText`.

So `said()` now writes `<phoneme ph="ˈɡɛərələs">Garrulous</phoneme>`. An engine that
honours the tag never reads the inner text at all — it says the IPA, unchanged and exact —
so what is written there is only ever heard by an engine that does not, and for that
engine **one guessed word beats a correctly-spelled-out guide**. The respelling keeps its
two proper readers: the page draws it, and a screen reader is handed `spokenRespelling`
through `semanticsLabel`. What no voice should be handed is a guide written for the eye.
`test/spoken_respelling_test.dart` now sweeps all 134 and requires
`ssmlToPlainText(spokenWord)` to be the word and nothing else.

**That first sweep was not general enough, and saying so is the point.** It covered
`spokenWord` and left the inflected forms and the composed readings unproven — and it left
a real hole: the no-IPA branch of `voiced()` emitted `<sub alias="e dul kuh ray tidd">`,
and `ssmlToPlainText` resolves a `<sub>` to its **alias**, so that branch handed the voice
the syllables by another door, on *every* engine rather than only the ones without SSML.
Unreachable today, because all 25 forms carry an IPA; it is a bare word now, so adding a
form without one costs a plain word instead of a silent regression. The sweep is over every
English utterance the app can build — `spokenWord`, `spokenEntry`, `spokenGlance`,
`spokenPrompt`, both halves of `spokenQuiz`, and `voiced()` over the example — and it was
**checked both ways round**: reverted to the old behaviour it fails, which is the only
evidence that it is a test rather than a decoration.

Two exclusions in it are load-bearing, and the second cost a run. A one-syllable respelling
is often the word (`dint` is spelled `DINT`), and **a two-word headword has a space that is
a word space rather than a syllable gap** — *Lee side* is respelled `LEE-side`, whose spoken
form is exactly the word, and the first draft duly reported it. A respelling counts only
when it differs from the form it stands for.

**`kRespellingVoicing` was a red herring and is no longer one.** It read `probe` — the one
value its own documentation calls "not for shipping" — while nothing had read the constant
since `said()` stopped branching on it. It looks exactly like the cause of any
pronunciation bug and is not. It is set to `sub`, which is what actually ships, and the
enum is kept only for the record of what each shape sounded like. That is what the 27 substitutions in `respelling.dart` are
for now — a fallback, not the main road. Nineteen of them are invented spellings measured
against Windows SAPI, and the phone disagreed with SAPI on `eeh`, which is why `ee` is no
longer substituted and why the device's verdict overrules the desktop probe's wherever the
two have been heard to differ.

`<phoneme alphabet="ipa">` is a different matter and is **not** supported by the on-device
engines — it is a cloud-API feature (Google Cloud TTS, Polly, Azure). An engine that does
not know a tag speaks its inner text, which is why `<sub>` costs nothing where it is
unsupported, and why reaching for `<phoneme>` would buy nothing here.

**The English inside the example sentence, and the two kinds of it.** `exampleGloss` is
the example sentence in the reader's language, and it kept the English headword standing
inside it: the Dutch for *Soporific* read "De **soporific** dreun van de lezing". That was
the bilingual model working as written, and it was also the thing a reader noticed —
**the one word the sentence exists to explain is the one word they cannot read.**
Reported from a device on 2026-09-03. It ran to **7,903 of the 8,040 glosses**, 98%.

The finding that shaped the fix is that **there are two kinds of English in these
sentences and only one of them can be translated**, and that the sixty translations had
already worked this out and agreed with each other without ever being told to:

| quotation | word | left in English |
|---|---|---|
| Visiting relatives can be tiring | amphiboly | **60/60** |
| Murmuring brook | euphonious | **60/60** |
| It is what it is | tautology | **60/60** |
| Between you and I | solecism | **60/60** |
| Molon labe | laconism | **60/60** |
| Wall Street had a rough day | metonymy | 59/60 |
| Everyone's doing it | specious | 58/60 |
| I would fain rest here a while | fain | 44/60 |
| You clodpate, | clodpate | 37/60 |
| the true meaning of friendship | sententious | 34/60 |
| excellent taste | unctuous | 34/60 |
| who Mom loves best | invidious | 34/60 |
| why would anyone lie about that? | ingenuous | 32/60 |
| unforeseen challenges | gloze | 16/60 |

The top seven **are the specimen**: the ambiguity of "Visiting relatives can be tiring",
the redundancy of "It is what it is" and the bad grammar of "Between you and I" exist in
English and nowhere else, so a translation of them shows the reader nothing at all. The
bottom seven are reported speech and carry no such weight. Sixty translators converged on
that line unprompted, which is better evidence that it is the right line than any rule
written here. So **the whole sentence in the reader's language is reachable for 127 of the
134**, and for the other seven everywhere except inside the quotation marks.
`test/text_quality_test.dart` pins those seven in all sixty, because the obvious next pass
would carry them off by accident.

**The sentence is written out, not assembled.** Swapping the local word into the existing
sentence mechanically cannot work across sixty languages — the word has to be inflected
for the slot it lands in, and agreement, case and word order all differ — so
`tool/gloss_local_<locale>.json` holds the whole new sentence per word and
`tool/localize_gloss.py` checks it rather than builds it: every id a real word, no English
form of the headword left standing, the specimen quotation intact letter for letter, the
quotation marks paired, the sentence ending on a stop. Nothing is written if anything
fails.

```bash
python tool/gloss_english.py                     # what is left, and where
python tool/gloss_english.py --locale nl         # a worklist for one locale
python tool/localize_gloss.py --locale nl --check
python tool/localize_gloss.py --locale nl
```

**Six are done — `nl`, `de`, `fr`, `es`, `es_419`, `it` — and 54 are not.** Each diff is
`exampleGloss` lines and nothing else. **7116 of the 8,040 glosses still carry the English
headword.**

**How many exemptions a locale needs is not what you would guess.** French needed five
and Italian two, although Italian is where several of these words came *from*. The reason
is morphology rather than borrowing: Italian inflects almost every loan into a shape of
its own — *sibarita*, *siniscalco*, *canaglia*, *peculato*, *contumelie*, *sagacia*,
*rodomontata*, *parossismo*, *interstizio* — so the check sees a translated word, which it
is. Only a loan that is identical letter for letter needs a decision, and there are few of
those in any language. **`english_ok` should stay a short list in every locale**; if it is
growing past a handful, the sentences are reaching for the borrowing where the language
has a plainer word.

**A locale pair can be nearly free.** `es` and `es_419` shipped with **129 of their 134
glosses identical**, differing only where the region does: *estudiantes* for *alumnos*,
*acera* for *bordillo*, *auto* for *coche*, and an *ustedeo* imperative where Spain uses
*vosotros*. So Latin American Spanish was derived from the peninsular file with those
five carried across, rather than translated again. Look for the same in `pt`/`pt_BR`,
`fr`/`fr_CA` and the three Chinese locales before treating any of them as a fresh job.

**Comparing the pair also found damage that was already in the store.** The `es_419`
gloss for *ontic* read "los númerlo" where it should read "los números" — a word broken
in generation, not a regional form, and invisible to every check the suite has, because
a mangled word is still a word. `text_quality_test.dart` catches a stray escape or an
unclosed quotation; it cannot catch this. **Diffing two locales that ought to agree is a
proofreading tool nobody had used**, and it is worth running over the other near-identical
pairs.

**How much a language has already borrowed decides how much work it is**, and that is
not something to discover halfway through. *mathesis* and *imbroglio* are unchanged in
all three, because the local word *is* the English one — Van Dale, Duden and the Petit
Robert all carry them. German needed no other exemption: *Ersatz*, *Seneschall*,
*Sybarit*, *Paroxysmus* and *Solözismus* are German too but spelled differently, so the
check sees them as translated, which they are. **French needed five**, and could have
needed a dozen: *demi-monde*, *patois* and *sybarite* joined the two, and *canaille*,
*ersatz*, *mordant*, *chicane*, *interstice*, *involution*, *inanition*, *rodomontade*
and *animadversion* were all reworded to the plainer French word instead — *racaille*,
*succédané*, *mordantes*, *s'insinua*, *joint*, *complication*, *épuisement*,
*fanfaronnade*, *remontrances*. **Reword before reaching for `english_ok`**: an
exemption leaves the word with the English voice inside a French sentence, where a
reworded one does not, and half of these borrowings are the rarer word in the local
language anyway.

**German taught the checker something the other 58 will need.** It refused the whole
locale over one sentence: *clodpate* ends on `“`, because German closes a quotation with
the character Dutch opens one with (`„…“` against `„…”`). The list of characters a sentence
may end on had been written from English and Dutch habits, so it rejected correct German.
It now also allows `。` and `！？` for Japanese and Chinese, `।॥` for Hindi, `۔؟` for Urdu and
Arabic, and `։` for Armenian — each of which would have failed the same way. Worth
expecting one of these per script family, and worth noticing that **the check failing is
the tool working**: nothing was written, and the fault was in the rule rather than in the
text.

**Two traps for whoever does the next locale.** `emit_from_data.py` is the source of truth
for the **37** locales that have a `tool/_data_<locale>.py`, so an edit to their overlay
JSON is thrown away by the next emit — `localize_gloss.py` refuses to touch those and says
so. The other **23** (nl, de, fr, es, it, pt, ru, pl, uk and the rest of Europe) have no
such file and the overlay is the artefact. And a word whose local form equals the English
one still reaches `segmentTranslation`, so it is handed to the English voice inside a
sentence that is otherwise local — true today for *mathesis* and *imbroglio* in Dutch, a
small wart rather than a bug, and the reason `english_ok` is a list you have to write
rather than a rule.

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
  English. Two deliberate holes in that table: **compound origins** are excluded,
  because "Latin / Old French" quotes *escutcheon (escuchon)* — the English word and
  then the French — and "Latin / English" quotes *plumbum + line*; and **Latin is read
  by an Italian voice**, which is the one judgment call — no engine has Latin,
  eighty-one of the 134 are Latin, and Italian is the pronunciation ecclesiastical
  Latin uses. One line to revert. Root forms carrying a gloss or a second language
  (`racine (radix)`, `caro, carnis`, `poco + curante`) keep the English voice;
  `kMixedForm` is that test.
- **Greek is handed to the voice in Greek letters, not in ours.** This was the third
  hole in that table until 2026-09-03, and closing it is the same move the app makes
  everywhere else: the page shows one thing and the voice is handed another. Twenty-two
  of the 134 come from Greek and every one was read with an English mouth — a Dutch
  reader was told *Mathesis* comes "van Grieks" and then heard *mathesis* said as an
  English word. The old reasoning was sound as far as it went (ours is transliterated,
  *panēgyrikos*, *mathēsis*, *anachōrētēs*, and a Greek voice handed Latin letters
  spells them) but the conclusion was not: the lexicon does not have to hand the voice
  what the page shows. `kGreekScript` in `origin_voice.dart` writes each etymon and root
  form out in Greek, and `spokenEtymonFor` returns the letters along with the voice.
  Four things about it are deliberate:
  - **It cannot be a row in `kOriginVoices`,** which is keyed on the origin label, for
    two reasons at once. *splenetic* is "Greek / Latin" and *pedantic* is "Italian /
    Greek", so the label does not always say Greek; and the transliteration is what
    would then reach the Greek voice, which is the very thing that made this look
    impossible. It is per form, and the form carries its own spelling.
  - **The accents are monotonic and the voice is a modern one,** so *μάθησις* comes out
    "MA-thi-sis" rather than the classical reading. That is the same trade as Latin in
    an Italian mouth: the nearest living voice, not a perfect one, and a great deal
    nearer than English. A device with no Greek voice falls back to exactly what it
    said before.
  - **A form in the table is only Greek in a word that has Greek in it.** The table is
    keyed on the form alone and *pro-* is Greek in *proleptical* and Spanish in
    *pronunciamento* — which is where the first version sent a Spanish prefix to a
    Greek mouth. The guard is the origin naming Greek, or a macron in the form itself.
  - **A prefix loses its hyphen** (*amphi-* is spoken *αμφι*), because a voice handed a
    trailing hyphen either pauses or says "dash". What is not Greek is not in the table:
    *-ic* and *-etic* are English suffixes on Greek stems, *spleneticus* and *pedante*
    are Latin and Italian and have their own voices, *paidagōgos (Greek)* is two
    languages in one string like `racine (radix)`, *theodicy (Leibniz)* names its
    coiner, and *a-* is two letters, which `segmentTranslation` never cuts out of a
    passage anyway. A sweep in `spoken_origins_test.dart` names those exclusions one by
    one and fails on any other Greek form that has no Greek spelling, so word 135 is
    safe rather than lucky.
- **The etymon segment carries its own fallback and no group**, which matters more than it
  looks: a grouped segment takes its whole passage down to English when the device lacks
  the voice (see `_settleGroups`), so a missing French voice would have cost the reader
  their entire Dutch reading. Ungrouped, it falls back alone and everything around it is
  untouched.
- **The count, because "did you do all of them?" deserves a number.** 124 of the 134 have
  their etymon read in its own language; 105 of those have every root form too. It was
  105 and 87 before Greek was let in. The 10 that do not are each excluded on purpose:
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
- **A macron means transliterated Greek**, nearly wherever it turns up. *splēn* sits
  under "Greek / Latin" and *paidagōgos* under "Italian / Greek", so the origin does not
  always say Greek and `kTransliteratedGreek` is what catches them. The exception is Old
  English, which writes one too — *lee-side* is *hlēo + side* — and it costs nothing,
  because Old English has no voice for the macron to route it to. The Greek sweep in
  `spoken_origins_test.dart` names *hlēo* for that reason.
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

**A reading is the page, and that includes the headings over it.** Three were missing and
one was wrong: the definition was read with nothing introducing it, the sentence was
announced as "Zoals in" where the page says *in een zin*, the translated gloss under the
sentence arrived with no heading at all — so a reader heard the English sentence, then a
sentence in their own language, and was never told the second was the first said again —
and only *in gewone woorden* matched. So a reader following along heard the app name a
section that was not on the page and skip the ones that were. `SpeechTemplates` now
composes all four from **the page's own strings** — `l10n.inPlainWords`,
`l10n.theDefinition`, `l10n.inASentence`, `l10n.exampleGlossLabel` — rather
than from speech keys of its own, which is what stops them drifting apart again and
needed no new translation, because the page already had the sixty. `speechInPlainWords`
and `speechAsIn` are unused in the ARBs now; they stay there, because taking a key out of
sixty files buys nothing. The gloss was the last of the four and the easiest to miss:
its text was being read all along, so nothing was silent — it simply arrived unannounced.

**Every heading on a word's page is set in the script face, at one size, on one margin —
and *in other words* took two goes to get there.** The label over the translated gloss was
a plain 12pt line in the body font while *in plain words*, *the definition* and *in a
sentence* above it were all `ScriptCaption`; it showed the moment the other three started
being read aloud by their own names. The first fix put it in the script face at 22 and
left it where it was, indented inside the quotation's gold rule, on the theory that it
belongs under the sentence rather than beside it. A reader saw the result and said the
page did not sit straight, which is exactly right: **two heading sizes on two different
left edges within a few lines of each other is what "not level" looks like**, and no
single element was wrong enough to point at. The gloss is a section like the three above
it now — its own `_Section`, 26pt, on the page's own margin, with the same air over it —
and the gold rule marks the quotation and nothing else. `widget_test.dart` checks all four
are drawn in `AppFonts.tangerineFamily`, at one font size, from one `dx`. Note what that
test needs: the page prefers the repository's copy of a word over the entry it was handed,
so the fixture entry has to carry an id the repository does **not** know or the gloss
never appears.

**`quiz_gives_less_away_test` was failing about one full run in three, and it was not a
flake.** The quiz shuffles unseeded, so a different question comes up first each run, and
when *Paroxysm* did, the reading said its etymon — *par-oxys-mos* — which carries the root
form *oxys* inside it. A `contains` check called that a leaked root. The assertion matches
whole words now. Two lessons in one: an intermittent failure in a suite that shuffles is a
collision until proven otherwise, and *the first theory (async speech not settling) was
wrong and a wait loop written for it was taken back out* rather than left in as a charm.

**A Material chip cannot hold a translated phrase, and it fails silently.** The five
reasons for writing were `ChoiceChip`s, and a chip is built for a short label: `RawChip`
puts a `DefaultTextStyle` with `maxLines: 1, softWrap: false` around whatever it is
handed, so "Een woord om toe te voegen" lost its tail at twice the type **inside a chip
that was itself exactly the right width**. Nothing overflowed and no rectangle was wrong.

Turning wrapping on did not fix it either, and the way it failed is worth remembering: a
chip works its own width out from what the label asks for, and a label that may wrap asks
for almost nothing — the chip put four lines of two characters against its right-hand
edge. The app already had the answer for its own pills, twice over: `ButtonLabel` shrinks
a step at a time and takes another line only when shrinking runs out, and `pillRadius`
stops the rounded ends curving in over that line. `_ReasonPill` is those two, and it is
the same furniture a category pill on a word's page has always worn.

Measured while there, because "Ukrainian runs long" was the guess: the longest reason
label of the sixty is **Hungarian** (*Egy szó, amit érdemes hozzátenni*, 32 characters),
then Russian and Georgian; **Ukrainian is mid-pack at 24**. All five are in the test, and
the assertion is `RenderParagraph.didExceedMaxLines` rather than a rectangle — a label
that shrinks before it wraps makes every width comparison meaningless, and only the
paragraph knows whether it ran out of lines.

**That fixed the cut tail and left the group crooked, which a reader saw before any test
did.** Three things were still wrong at once and no single one of them was wrong enough
to point at: the label was centred, so "voegen" sat under the middle of "Een woord om toe
te" with the icon stranded in the gap; the pills were in a `Wrap`, so each was the width
of its own words and the long one had stretched the full width while the four short ones
had not, leaving the icons in a ragged column; and `ButtonLabel` shrinks a step at a time
to hold one line, which set **three type sizes in one column of five — 15, 14.5 and 13,
measured**.

The fix is general and needs no per-language tuning, which is the point: **a wrapping row
of hugging pills gives every one of the sixty a different set of line breaks and a
different set of widths.** In any language whose longest reason wraps — Dutch, Hungarian,
Russian, Georgian — the group goes crooked, and the four that do not wrap go crooked
around it. Uniform rows have one answer for all sixty: one width, one column of icons,
one left edge for the labels, one type size, and a second line that starts under the
first. So the five are a column of full-width rows rather than a `Wrap`, the label is set
from the start (`ButtonLabel` takes a `textAlign` now, still centred everywhere else),
and `minScale` is **1.0** — never shrink, wrap instead. A row has the width already, so a
second line costs nothing and one type size is worth more than one line.

It is also what the rest of the letter does: the name, the address, the message and the
priority control are all `double.infinity` wide inside a form whose width `pagePadding`
has already capped, so full-width rows line the reasons up with the fields above and
below them rather than only with each other. The test measures one `left`, one `width`
and one `fontSize` across the five in Hungarian, Russian, Georgian, Ukrainian and Dutch —
and `textAlign`, which is the half a rect cannot show, because the box is the same
whichever way the lines inside it were set.

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

**A `ShaderMask` masks a rectangle, and a glyph is not inside its rectangle.**
*Splenetic* was drawn with a white sliver under the tail of its **p** — reported from a
device on 2026-09-03. `RenderShaderMask` sets `maskRect` to the child's layout box and
the engine draws the shader over that rect and nothing else, so ink the child paints
outside its box composites through exactly as the child drew it. For a gradient that is
the worst possible failure mode, because the child of a gradient mask is painted flat
`Colors.white` so `BlendMode.modulate` can tint it: escaped ink is not the wrong colour,
it is **pure white on a dark page**.

Text leaves its box all the time and a display face leaves it most. The headword is set
at `height: 1.05`, tighter than Cormorant's own ascent plus descent, so every headword
with a descender in it wore this. Descenders are only the common case — the same happens
above a line (an accent on a capital), past the right edge (an italic's overhang), and
around a font icon drawn to its own metrics rather than to the em it was asked for.

So the fix is not in the headword, it is in the mask. `lib/widgets/gradient_mask.dart`
is `RenderShaderMask` with one line changed: **the mask rect is inflated by the child's
own height**, which no glyph's ink ever exceeds, while the shader is still built from the
child's real box so every colour lands exactly where it did. Inflating costs nothing —
the child's layer is transparent everywhere it did not paint, and both `modulate` and
`srcIn` leave a transparent destination transparent. It reaches all four masks in the
app: the headword, the app's own name, a quiz score, and the Instagram mark in the
social row.

**Layout had to stay untouched, and that ruled out the obvious fix.** Measuring the text
here — a `LayoutBuilder`, a `TextPainter` — would have let the box grow to hold the ink,
but `FitToWidth` wraps two of the four call sites and the lexicon puts an
`IntrinsicHeight` around a row of cards to level them; a `LayoutBuilder` cannot answer an
intrinsic query. That is written down in `fit_to_width.dart`, where it was learned the
first time, and it is why the mask grows rather than the box.

**Unlike the shadow below, this one a test can see.** `test/gradient_mask_test.dart`
renders through a `RepaintBoundary`, reads the pixels back and counts pure white: 91 of
them before, 0 after, with the same 35,500 pixels of ink either way. Two things make it
worth trusting. It draws in **Tangerine**, the one display face in the bundle — Cormorant
is fetched at runtime and a test gets a fallback — and Tangerine's descenders are longer
than Cormorant's, so what escapes there escapes here. And it is **checked both ways
round**: a companion case draws the same word through Flutter's own `ShaderMask` and
fails if it does *not* find white, because a pixel test that cannot fail is worth nothing.
That case is also where the first draft of the test was wrong — it forgot to paint its
child white, so it found nothing and proved nothing.

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

- **Render the headword in the local language inside `exampleGloss`.** This reversed on
  2026-09-03: the Dutch used to read "De redacteur **edulcorated** de harde recensie" and
  now reads "De redacteur **verzachtte** de harde recensie". The seven quotations that
  *are* the specimen still stay English — see *The English inside the example sentence*.
  Only Dutch has been done; the other 59 still keep the English word.
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
| 2026-09-02 | `54ecdce` | Windows | 3.41.7 | clean | **321/321** | empty |
| 2026-09-03 | `a71fff9` | Windows | 3.41.7 | clean | **334/334** | empty |
| 2026-09-03 | `5e27617` | Windows | 3.41.7 | clean | **336/336** | empty |

The suite grew from 133 to 146 to 153 to 166 to 177 to 199 to 206 to 218 to 224 to 321 to
334 to 336 across those commits; the number is a fact about the commit, not a constant to
hold. The 336 is the two halves added together — 309 and 27.

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

`flutter build appbundle --release` exits 0 on Windows at `1.0.0+18`, writing a **47.9 MB**
bundle — `versionCode 18`, signed `CN=Gloss, OU=Mobile, O=Raimonvibe, L=Amsterdam`,
`INTERNET` and the `SENDTO` query both in the merged manifest. Six locales now read their
example sentences wholly in their own language, and every word is handed to the voice as a
word rather than as its syllables. The same 47.9 MB as `1.0.0+17`: six locales of rewritten
sentences replace six locales of sentences, so a bundle cannot tell the difference. **Not
uploaded** — the version code moves when it is.

Before that, `flutter build appbundle --release` exited 0 on Windows at `54ecdce` (`1.0.0+17`), writing a
47.9 MB bundle — `versionCode 17`, signed `CN=Gloss, O=Raimonvibe`, `INTERNET` and the
`SENDTO` query both in the merged manifest, 134 words each carrying their `ipa`, all 60
overlays and the Tangerine face inside the bundle. Built twice at this version, at
`a571fcd` and again at `54ecdce` once the gloss label had been put back into the script
face; the version code stays at 17 because neither bundle was uploaded. The same size as `1.0.0+16`: a session of layout, colour and
speech-routing work adds nothing a bundle can weigh.

Before that, at `a774b84` (`1.0.0+16`) it wrote a
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

- Invent native-language lemmas for the 134 English headwords — the headword, its
  respelling and its root forms are English on every screen. Rendering the word *inside a
  translated example sentence* is a different thing and is now wanted; see *The English
  inside the example sentence*
- Translate one of the seven specimen quotations ("Between you and I", "It is what it
  is") — `text_quality_test.dart` fails on it, and rightly
- Commit `l10n/cache/` or secrets (`.env`, API keys)
- Force-push `main`
- Amend commits unless explicitly requested
- Commit a `gen-l10n` run whose only change is formatting — see *Verification*
- Assume this checkout is a git repo, or that Flutter is on `PATH` — see *Environments*
- Put a blurred shadow back on `CardSurface` without looking at it on a device — see
  *Cards carry no shadow*
- Reach for a bare `ShaderMask` — use `GradientMask`, which is the same thing with room
  for the ink; see *A `ShaderMask` masks a rectangle*
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
