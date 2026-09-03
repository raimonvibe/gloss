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
| English left in translated copy | `python tool/english_in_translation.py` |
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

**"Does that switch still do anything?"** — asked of the shipped app on 2026-09-03, and
worth answering by measurement rather than by reading the code. It does, and it is wired
at exactly one point: `readerLanguageTag` in `reading.dart`, which every reading passes
through. The file above only ever proved that for `readingOf`, the reading a word's own
page gives, and **proving one of the four proves nothing about the other three** — a
screen only has to reach past `reading.dart` to lose the switch, which is what the quiz
results once did. It now walks all four (`readingOf`, `glanceOf`, `quizReadingOf`,
`spokenLine`) in both positions: on, each must carry a Dutch piece; off, every piece must
be English. Between them those four build the six listen buttons and the study's own
voice preview. Checked both ways round — with the switch ignored, all four *off* cases
fail.

Two things that look like the switch failing and are not. The switch **hides itself**
when the device reports no voice for the language, so a visible switch means a voice was
found; and a grouped segment still falls back to English as a whole when the engine
cannot manage the language at speaking time, so a reader can have it on and hear English
anyway. Neither is the preference being ignored.

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

**Thirty-six locales are done — `nl`, `de`, `fr`, `fr_CA`, `es`, `es_419`, `it`, `pt`,
`pt_BR`, `pl`, `ru`, `uk`, `cs`, `sk`, `hr`, `sr`, `sl`, `bg`, `mk`, `el`, `ro`, `hu`,
`nb`, `be`, `da`, `sv`, `af`, `is`, `et`, `fi`, `lt`, `lv`, `sq`, `zh_TW`, `zh`,
`zh_HK`.** **3,183 of the 8,040 glosses still carry the English headword**, and **every
one of them is in one of the 24 locales left that have a `tool/_data_<locale>.py`.**
Every
one of the 24 has had its `friendly` and `definition` fields done in the same pass, so a
diff of one is no longer `exampleGloss` lines alone — see *`exampleGloss` was never the
only field this can happen in* below.

**`localize_gloss.py` reaches the generated locales too, as of 2026-09-03.** It used to
refuse all 37 of them — the next `emit_from_data.py` would have thrown the edit away — and
that refusal, rather than anything about the languages, is why the whole of Asia, the
Middle East, the Nordics and Belarusian still carry the English headword. It writes
`tool/_data_<locale>.py` and re-emits now, so the generator and the overlay cannot
disagree. What is left per locale is the writing: **~132 sentences and 8–11 `friendly`
lines**, the same shape every time, because the fault is inherited from the English rather
than invented locally.

The safety property had to be a different one. The ten `_words_<locale>.py` files are
guarded by reproducing the file byte for byte before touching it, and that cannot work
here: the 37 were written at different times in at least three layouts — one tuple per
line in `zh`, a line per field in `sv`, two fields to a line in `be`. So the file is
rendered in one canonical layout and then **imported again and compared cell by cell
against what was meant**, all 670 of them, with the original put back if the readback
disagrees. The content is proved and only the formatting moves. The renderer was
round-tripped over all 37 before any of them was written: no faults.

**The three Chinese locales were one job and two derivations, and diffing them first is
what showed it.** Measured before a word was written, over all 670 cells of the shipped
generators: **`zh` is exactly `opencc tw2sp` of `zh_TW`** — script and mainland vocabulary
both, *計程車* → *出租车*, *印表機* → *打印机*, *專案* → *项目* — and **`zh_HK` is exactly
`zh_TW` under twelve substitutions**, four of them vocabulary (*巴士*, *的士*, *酒店*,
*打印機*) and the rest the two orthographic habits that separate Hong Kong from Taiwan,
*裏* for *裡* and *甚麼* for *什麼*. Nought mismatches either way.

So Taiwan was written by hand and `tool/derive_chinese.py` produced the other two: the
generator, the overlay **and** the written `gloss_local_*.json` for all three, so they agree
by construction rather than by diligence. That is the `pt_BR` lesson applied *before* the
work instead of after it — and the reason it could be applied is that the derivation was
proved against the shipped files first. `python tool/derive_chinese.py --check` is that
proof, and it is worth running before touching Taiwan again: run against an unlocalised
base it must report nought, and a rule that has quietly stopped holding shows up while the
base is still the text the rules were measured on.

**`opencc` is not a repo dependency and the app does not need it**; the tool does.
`pip install opencc-python-reimplemented`.

One thing the pair diff could not see, and the sweep could: *mathesis* is `english_ok` for
Taiwan, and the two derived locales had no file to say so, so they each showed one flag
that was not a fault. `derive_chinese.py` writes their `gloss_local_*.json` through the same
rules now, which both records the derived text and carries the exemption across.

**The CRLF bug left exactly one fingerprint in the repo, and it was here.**
`assets/l10n/words_zh.json` was the only one of the sixty overlays committed with CRLF —
which fits, because it is the one file that was generated by running a script on Windows.
It is LF now like the other 59, so its diff for this pass reads 2,956 lines where the other
two read 284; underneath, all three moved the same 142 cells.

**Ten of the 37 could not be emitted at all, and nothing said so until one was tried.**
`af`, `be`, `da`, `et`, `fi`, `is`, `lt`, `lv`, `sq` and `sv` have a
`tool/_data_<locale>.py` and **no entry in `tool/_pos_origin.py`**, so
`emit_from_data.py` exits on *"missing POS/ORIGIN maps"* — their shipped overlays must
have been written by some other route, and the maps were never added or were lost. Found
on 2026-09-03 by localising the first of them; the emit refused after the generator had
already been written.

They were **recovered from the shipped overlays rather than translated afresh**, which is
sound here for a reason worth checking before doing it again: across all 134 words in all
ten, every one of the 7 parts of speech and 22 origins maps to exactly one local string,
so there was nothing to choose between. The proof it worked is that re-emitting `be`
changed **`exampleGloss` in 133 rows and `friendly` in 9, and nothing else** —
`partOfSpeech`, `origin` and `rootMeanings` came back byte for byte.

**`emit_from_data.py` wrote CRLF on Windows, and that hid what it had done.** `Path.write_text`
translates newlines unless told not to, so a 142-cell edit to `be` arrived as a **2,956-line
diff** — all 1,478 lines deleted and rewritten — and the repo sets `core.autocrlf false`
on purpose, so nothing downstream would have put it back. It writes `newline="\n"` now and
the same edit reads as 142 insertions and 142 deletions. Worth knowing for two reasons:
every overlay emitted from Windows before 2026-09-03 will have had this, and **a diff far
larger than the edit is a fact about the writer, not about the edit** — the cell-by-cell
comparison had already said only 142 cells moved, which is what made the line count worth
looking into rather than accepting.

**`bg`/`mk` was the last near-twin pair, and it was not cheap.** Measured before starting:
0.80 mean similarity with 101 of 134 above 0.75, which looked like `es`/`es_419` (129
identical) from a distance. It is not. **Zero of the 134 example sentences are identical**,
and zero `friendly` lines are — Bulgarian and Macedonian are close languages whose files
were genuinely written apart, so the second cost as much as the first. The similarity score
was measuring the languages, not the files. **A pair is only cheap when the diff says the
files agree; a number that merely says the languages are close predicts nothing.**

**Ten Slavic locales in a row needed exactly one exemption and the same one**, and it is
now settled rather than predicted. Polish, Czech, Slovak, Croatian and Slovene decline what
they borrow (*panegirykiem*, *teodyceę*, *panegyrik*, *teodiceu*, *sybarita*, *solecismus*,
*panegirik*, *sibarit*, *solecizam*, *solecizem*, *teodiceja*); Russian, Ukrainian, Serbian,
Bulgarian and Macedonian are in another script, so a borrowing arrives transliterated and
cannot be identical to the English form even where it is the same word. *mathesis* survives
both tests because every locale keeps it in Latin letters. **Every Slavic locale in the
lexicon is now done — all eleven of them — and every one needed exactly `mathesis`, by one
of those two routes.**

**It said ten here until 2026-09-03, and the eleventh was Belarusian.** The count was
written from the locales `localize_gloss.py` could reach, and `be` was not one of them
because it has a `tool/_data_be.py` — so a locale that was neither done nor counted sat
inside a claim that everything was done. It was found by counting the remaining rows per
locale rather than by reading this file, which is the general lesson: **a claim of the
form "all of X are done" should be checked against the tool that measures X, not against
the list that produced the claim.** Belarusian duly needed exactly `mathesis`, by the
Cyrillic route, so the prediction held for the one locale it had never seen.

Belarusian also paid the rewrite's usual dividend of proofreading, and the two worst were
agreement faults no check here can see: *гасцінічнай пакоя*, a feminine adjective on a
masculine noun, and *старога цэглянага сцежкі*, two masculine ones on a feminine. Two more
verbs did not agree with the subjects the localisation gave them, and *арандатара нервовай*
mixed a masculine noun with a feminine adjective. All five were found by reading the row in
order to replace it. One fault of a different kind, and worth naming because it was
self-inflicted: a **Latin á typed inside a Cyrillic word** (*праклінáлі*). Nothing in the
project could see it — the English sweeps match whole English words, and a single Latin
letter inside a Cyrillic one is not a word. A mixed-alphabet sweep over the written file is
four lines and catches it; it is worth running on every locale whose script is not Latin.

**Danish and Swedish were the first two of the ten whose maps had to be recovered, and
they came out cheap — 142 cells each, and neither needed an exemption beyond `mathesis`.**
The Nordic borrowings are all spelled their own way (*sybarit*, *seneskal*/*seneskalk*,
*amfiboli*, *lakonisme*/*lakonism*, *teodicé*/*teodicén*), so the check sees a translated
word, which it is — the Italian answer rather than the French one. Danish leans on `nb`
for its shape and must not for its spelling: the finished Norwegian is now correct
Norwegian, and the whole point of the earlier `nb` repair was that the two are not
interchangeable.

**One proofreading catch is the same fault in both, in the same row, and that says
something about where the text came from.** `animadversion` read *rød blæk* in Danish and
*röd bläck* in Swedish — the neuter noun with a common-gender adjective, identically wrong
in two files that were supposedly written apart. It is the *nb*-was-Danish lesson in
miniature: **when two independent locales carry the same error in the same row, they are
not independent.** Worth checking `animadversion` in the remaining Germanic locales before
assuming each needs its own reading.

The rest were ordinary and only a rewrite would have found them. Danish: *uden en eneste
søm* for *et eneste søm* (a nail is neuter), *rygens* for *ryggens*, *lumsk spørgsmål* for
*lumske*, *de rigtige medicin* for *den rigtige medicin*, and *sukkede rejsende* with no
article. Swedish: *paretets privatliv* for *parets* — a word broken in generation, the
`los númerlo` fault again and just as invisible — *det där grodan* for *den där*, *rostade
cikoria* for *rostad*, and `coruscation` written as *Kronljusets* (the candle's) where the
English sentence is about a chandelier, so it is now *Kristallkronans*.

**All ten recovered-map locales are done, and the whole set needed one exemption between
them.** `af`, `be`, `da`, `et`, `fi`, `is`, `lt`, `lv`, `sq` and `sv`, 142 cells each and
`mathesis` the only word any of them kept — the pattern this file has been predicting since
German holds across Germanic, Baltic, Finnic and Albanian alike, because each spells its
borrowings its own way (*sibarīts*, *sübariit*, *sibarit*, *seneskalas*, *lakonism*,
*teodicé*, *amfibolija*). **Finnish cost 118 rather than 142**, exactly the third it was
measured to owe. Two counts that look like failures and are not: `ro` keeps 2 and `sq`
keeps 1, and all three are the same false positive — *plumb* is the Romanian and the
Albanian word for lead, inherited from the Latin *plumbum* the entry is about, so the sweep
is finding the local language's own vocabulary. See *The checker caught one that reading
would not have*.

**Afrikaans repeated the Norwegian lesson exactly.** `nb` was written by something drifting
into Danish; Afrikaans had *Grys luchte* for *Grys lugte* — the Dutch spelling, in a locale
whose nearest neighbour in this repo is the finished Dutch. **A locale written next to its
big sibling drifts into the sibling**, and no check here can see it, because the drifted
word is a real word in the other language. Also *gesny* where the sentence needed *gespot*,
*laat spiral* with the English verb left standing, *ooit welke gegee* carrying Dutch
*welke*, and *laat ruggraat kry* for *laat krimp*, which means nothing at all.

Elsewhere the same class, one to five per locale, all invisible to every check:

- **Icelandic** — *dauð bílastaðla*, which is not a word, for *dauður bílrafgeymir*;
  *í lítilli klefa* for *í litlum klefa*; *óljósar loforð*, a feminine adjective on a
  neuter noun.
- **Estonian** — the `pedantry` row had **no main verb at all** (*rööbastelt kogu
  koosoleku*, "off the rails the whole meeting"), and `redound` put a nominative adjective
  on a genitive noun.
- **Lithuanian** — *mirusi automobilio baterija*, a battery that has literally passed away,
  and *stovėjo kojomis* for *stovėjo ant kojų*.
- **Latvian** — *Karš deracinate*, the English verb left standing uninflected where every
  other row at least declined around it; *bez neviena naglas* for *bez nevienas naglas*;
  and *mūki nepiederēja nekas*, a sentence with no subject.
- **Albanian** — *gramatikënët* for *gramatikanët*, and a `paroxysm` whose article did not
  agree with its noun.

**Expect one to five of these per locale for the 27 that remain, and expect none of them
to be findable by anything except writing the row again.**

**Greek needed no exemption at all, and it is the only locale that has managed that.** The
prediction here was that Greek would take one for the script reason, like the Cyrillic
locales. It took none, and the reason is better than the prediction: **the lexicon's hardest
borrowings are Greek words to begin with.** *amphiboly*, *panegyric*, *theodicy*,
*tautology*, *metonymy*, *laconism*, *solecism*, *euphonious*, *aporetic*, *cataphatic*,
*sybarite*, *anchorite*, *paroxysm* and *mathesis* are simply written out in Greek —
αμφιβολία, πανηγυρικός, θεοδικία, ταυτολογία, μετωνυμία, λακωνισμός, σολοικισμός, εύφωνη,
απορητικός, καταφατική, συβαρίτης, αναχωρητής, παροξυσμός, μάθηση. A locale needs an
exemption when it has borrowed a word and left it unchanged; Greek is being asked to hand
back its own.

**Romanian needed five, which is the French answer for the French reason**, and it is the
long end of the range: *mathesis*, *neologism*, *solecism*, *laconism*, *ontic*. A Romance
language in Latin script has taken these and spelled them identically, so the check cannot
tell the local word from the English one — because they are the same word. Everything that
had a plainer Romanian form was reworded to it first, as this file has said to do since
French: *soporific* → *adormitor*, *subaltern* → *ofițer inferior*, *fiducial* → *reper de
referință*, *integument* → *înveliș*, *paroxysm* → *acces*, *patois* → *grai*, *seriatim* →
*pe rând*. **So the two extremes of the whole job are Greek at nought and Romanian at five,
and both numbers follow from how the language got the word rather than from how careful the
translator was.**

**The checker caught one that reading would not have, and it is the case where an exemption
costs a reader something audible.** Romanian for a plumb line is *fir cu plumb*, and *plumb*
is one of the forms in `quotedEnglish` — so `segmentTranslation` would have cut an ordinary
Romanian word out of a Romanian sentence and handed it to the English voice. Reworded to
*dreptar*, which Romanian already uses metaphorically for a rule one lives by, so the safe
sentence is also the better one. **That is the sharp version of *reword before reaching for
`english_ok`*: an exemption is not merely untidy, it is a word the reader hears in the wrong
mouth.** Two `plumb`s remain in Romanian and correctly so — the definition of *plumb-line*,
where *fir cu plumb* is the term, and the root meaning of Latin *plumbum*, which is *plumb*.
Those are the language's own vocabulary on the same Latin root, and `find_unsaid_english.py`
has always reported that class.

**All nine other Slavic locales sorted use from mention identically without being asked**,
and by the third it stopped being a coincidence: `ru`, `uk`, `cs`, `sk`, `hr`, `sr`, `sl`,
`bg` and `mk` each kept exactly two — *fricaseed* defined as the misspelling of
"fricasseed", *ingenuous* as the word told apart from "ingenious" — and each had written
both **without quotation marks**, which is why the sweep could not tell them from a use.
Quoting is the whole fix and it also hands the word back to the English voice. All nine had
already translated *fain* and *fructify*, which no Romance or Germanic locale had. **A
Slavic locale's worklist is eight, not ten** — it held for West, East and South Slavic
alike, without a single exception in nine tries, so it is a Slavic habit rather than a
regional one.

**A locale can carry its neighbour's grammar, and only rewriting the row finds it.** Every
check in this project reads the sentence for *English*; nothing in it can tell correct
Slovak from Czech spelled Slovak-ly, and the suite was green over both of these. Slovak had
Czech forms standing in it — *aniž by čítala* where Slovak says *bez toho, aby čítala*,
*lhal* for *klamal* — one row that did not agree with itself (*jeden čajový vrecúško*, a
masculine adjective on a neuter noun), and *drelina* in the `dint` explanation, which is
not a Slovak word at all; it is *drina*. Croatian had four rows whose gender did not agree
(*Generalov … zdravica* and *Njegov … zdravica*, both feminine nouns; *Njegovi … e-poruke*,
feminine plural), *ima li brojevi* for *imaju li brojevi*, *zazištale* for brakes that
*zasiktale*, and *gramatike* — grammars — where the sentence means *gramatičare*,
grammarians. All of it was found by reading the row in order to replace it, which is the
argument for rewriting the whole sentence rather than swapping the headword into it: **the
rewrite is also the only proofreading pass these locales have ever had.** Expect a handful
in each of the 37 that remain. Slovene had six rows that did not agree with themselves, a
Croatian *Trebalo je* for *Bilo je treba*, and two non-words (*zazičale*, *vadjenja*).

**Norwegian Bokmål was the worst of them, and it was largely Danish.** Not derived from `da`
— the two share only 4 of 134 rows — but written by something drifting between the
languages: *bedstemors* for *bestemors*, *kalde* for *kalle*, *afsluttede* for *avsluttet*,
*have* for *ha*, *end* for *enn*, *hvad der* for *hva som*, *Jobs Bog* for *Jobs bok*, *tal*
for *tall*, and a dozen more. **Nothing here can see that**: a Danish word is spelled like a
word, it parses, and the whole suite was green over all of it. It had also left every piece
of reported speech in English — *the true meaning of friendship*, *excellent taste*, *who
Mom loves best*, *single-handedly* — where every other Germanic locale had translated them.

**And the `nb` entry in the test's specimen-exemption list was not a loss at all.** The row
read *"Wall Street **hat** a rough day"*, one letter off, and `text_quality_test.dart`
carried `nb/metonymy` as a locale that had translated the specimen away. **Danish has it
right**, so it was never a translation decision — it was a typo, recorded as evidence of a
rule the locale never broke. The same typo sits in the `clodpate` row. Both repaired, and
the exemption removed. **An entry in an exemption list is a claim about the data; read it
before you trust it.** `lo/specious` and `my/specious` stay, and those two are real — Lao
and Burmese render the quotation in their own scripts — but both are `_data_` locales, so
repairing them means editing the generator.

**Serbian was not written; it was transliterated from Croatian, and the transliterator ran
out before it finished.** This is the worst thing found in the shipped data so far, and no
check in the project could see any of it. Three faults at once, measured across the 134:

- **23 rows carried the English headword transliterated letter by letter into Cyrillic** —
  *Пнеуматиц*, *Цатапхатиц*, *Гаррулоус*, *Сопорифиц*, *Анцхорите*. That is worse than the
  English standing there, because the reader gets neither a Serbian word nor a spelling
  they could look up. And **it is invisible to every tool here**: `gloss_english.py` finds
  English by matching English letters, so a headword in Cyrillic is not English to it any
  more. The count of what Serbian owed was 23 too low, in the direction that flatters.
- **Every one of the 23 is the sentence-initial word**, and mid-sentence English was left
  in Latin. That is a mechanism rather than 23 accidents: whatever did this worked on the
  first token of each sentence. Worth knowing, because it says the rest of the file was
  produced the same mechanical way.
- **Text inside the quotation marks was skipped along with the English**, so a Serbian
  reader met Croatian in Latin script — *pobjedu*, *izvrstan ukus*, *dođite i uzmite ih*.
  And the Croatian underneath was left standing throughout (*tijekom*, *njezina*, *obitelj*,
  *tjedan*, *momčad*, *povijest*, *burza*, *kava*, *rubnik*, *kamo*), with ijekavian and
  ekavian mixed inside single rows.

`test/text_quality_test.dart` had recorded one symptom of this as a known exception —
`sr/ingenuous.friendly`, where *ingenious* had been transliterated to *ингениоус*. **That
set is empty now, and it is worth keeping empty**: an exemption there is a reader losing a
word. *disingenuous* in the same entry's definition had gone the same way and is back too.

The three fields this tool carries are rewritten in ekavian Serbian. **`partOfSpeech`,
`origin` and `rootMeanings` are written elsewhere and are still Croatian-flavoured** — that
is a separate job, and it is in BACKLOG.md rather than quietly done here.

**The lesson generalises past Serbian: a locale that was derived rather than written will
not show up in any count.** The sweeps ask "is there English here", and a bad derivation
answers no. `bg`/`mk` is the remaining pair most likely to have been made this way, so
measure it before trusting what it owes — the check is four lines, and the one used here is
in this session's transcript: transliterate the English headword letter by letter into the
target script and look for it with a fuzzy match.

**A doubled root is not a doubled word, and only a reader catches it.** The Ukrainian
`mordant` line read *влучно влучило* and the Czech one *tak trefně trefila* — the same
root twice running, in the same row, in two locales that were translated separately.
`text_quality_test.dart` catches a word typed twice and cannot catch this; both were
repaired by eye while rewriting the row. Worth a look in the remaining locales' `mordant`,
since whatever produced it produced it twice.

**A locale in another script needs no exemption list, and that is a fact about the
alphabet rather than about the language.** Russian took one — *mathesis*, kept in Latin
letters the way every locale keeps it — and could not have needed more: a borrowing
arrives transliterated (*панегирик*, *теодицея*, *сибарит*, *пароксизм*, *сенешаль*,
*анахорет*), so it cannot be identical to the English form even where it is the same
word. Expect the same of `bg`, `mk`, `sr`, `el` and `uk`, and expect the reverse of the
Latin-script Slavic ones — Polish still needed only *mathesis*, but for the other reason,
that it declines what it borrows (*panegirykiem*, *teodyceę*, *sybaryta*, *solecyzm*).

**Russian also sorted into use and mention more cleanly than any locale before it**, and
the two it kept are the two the census predicted: *fricaseed* is defined as the
misspelling of "fricasseed" and *ingenuous* is the word told apart from "ingenious". Both
had simply been written without their quotation marks, so the sweep could not tell them
from a use. Quoting them is the whole fix, and it also hands them back to the English
voice, since `segmentTranslation` cuts on `quotedEnglish`. Russian needed no rewrite for
*fain* or *fructify*: it had already translated both, which no other locale had.

**How many exemptions a locale needs is not what you would guess.** For the sentences,
French needed five and Italian two, although Italian is where several of these words came
*from*. The reason
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
five carried across, rather than translated again.

**`fr_CA` proved the pattern rather than merely repeating it.** Measured against French as
it stood *before* localisation, **123 of the 134 glosses were identical** and eleven
carried a real Québécois difference — *autobus*, *courriels*, *souper*, *fin de semaine*,
*autos d'époque*, *virée en auto*, *compagnie*, *salle à dîner*, *chicaner sur … versus*,
*Ça*, and the passé composé with *on* where France writes the passé simple with *nous*.
Those eleven were written onto the **localised** French sentence rather than onto the old
one, which is the whole trick: derive from the base as it is now, not as the pair last
agreed. The `friendly` fields looked like twelve regional differences and were **two** —
*pneumatic* and *garrulous* — the other ten being France's own rewrites that Canada had
not had yet. **Take the diff apart before trusting its size.**

**`pt_BR` is the third of these, and it found the flaw in the method.** 119 of the 134
glosses were identical and fifteen were regional, in three kinds worth keeping apart —
spelling the orthographic agreement moved (*facto*/*fato*, *prémio*/*prêmio*,
*génio*/*gênio*), plain vocabulary (*autocarro*/*ônibus*, *travões*/*freios*,
*equipa*/*time*, *duche*/*chuveiro*, *em linha*/*online*), and word order and register
(*contou-nos*/*nos contou*, *toda a gente o sabe*/*todo mundo sabe disso*).

**But a pair diff cannot see a word that was not there.** Localising Portugal put
*eufónica*, *ingénua*, *parcimónia* and *abstémios* into sentences that had carried the
English headword instead, and all four are spelled differently in Brazil — so the diff
said "identical" about text that had not been written yet. What found them is the
Brazilian generator's own replacement table **read as an oracle, both ways round**:
Portugal text the rules would change but the overlay had not, and European-only spellings
still standing in the Brazilian file. The second direction also turned up three that
predate this work — *ingenuous* kept *ingénuo* in its `friendly` and its `definition`, and
*panegyric* said *se reformava* where Brazil says *se aposentava*.

All seven are rules in `_words_pt_BR.py` now rather than one-off edits, and
`tool/gloss_local_pt_BR.json` is **generated by running Portugal's text through those same
rules**, so the overlay and the generator agree by construction rather than by diligence.
That is the shape to copy for the next pair.

**Comparing the pair also found damage that was already in the store.** The `es_419`
gloss for *ontic* read "los númerlo" where it should read "los números" — a word broken
in generation, not a regional form, and invisible to every check the suite has, because
a mangled word is still a word. `text_quality_test.dart` catches a stray escape or an
unclosed quotation; it cannot catch this. **Diffing two locales that ought to agree is a
proofreading tool nobody had used**, and it is worth running over the other near-identical
pairs. The same trick found "Mençant" for "Menaçant" in the French definition of
*minatory*, and "à un fin de semaine" for "à une" in Canadian French.

**And then it named the mechanism, which is the part worth keeping.** *los númerlo* is
`("os tiene", "lo tiene")` — a vosotros-to-ustedes rule in `_words_es_419.py`, applied as a
bare substring, firing inside "números tienen". **Spanish plurals end in -os constantly**,
so five of those rules could have bitten the same way at any time, in any row, and the
result would always be a real-looking word that no check can see. Both derived generators
anchor their substitutions on a word boundary now (`re.sub(r'…')`), which changes
exactly one field across the two locales — that one — and forecloses the rest.

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
Arabic, `։` for Armenian, and — since Greek — the semicolon, because **Greek asks a question
with `;`**. Each of those would have failed the same way. Worth expecting one of these per
script family, and worth noticing that **the check failing is the tool working**: nothing
was written, and the fault was in the rule rather than in the text. Five script families in,
the rule has never once been right the first time and has never once been wrong twice.

**Three traps for whoever does the next locale, and the second was found the hard way.**
`emit_from_data.py` is the source of truth for the **37** locales that have a
`tool/_data_<locale>.py`, so an edit to their overlay JSON is thrown away by the next emit
— `localize_gloss.py` refuses to touch those and says so.

**The other 23 were described here as having no generator, and ten of them do.**
`write_words_western.py` builds nl, de, fr, es, it, pl, pt and the three regional variants
from `tool/_words_<locale>.py`, and those files were stale by the whole of the
example-sentence work — **130 to 134 rows each in nl, de, fr, es and it** — so one run of
that script would have silently undone all six locales. Nothing warned, because nothing
knew. `localize_gloss.py` rewrites `_words_<locale>.py` alongside the overlay now, and it
was run over the five to bring them back into step; the overlays did not move, only the
generators. It rewrites only a file it can first reproduce byte for byte from its own
contents, which is what keeps it away from `_words_es_419`, `_words_fr_CA` and
`_words_pt_BR` — those derive their rows from a base locale by substitution rather than
listing them.

**All three of those are in step now, and getting there is a job the next pair will need
too.** Re-deriving left **es_419** differing from its shipped overlay in 11 rows and
**fr_CA** in 122, because their `_OVERRIDES` tables froze the example sentence as it stood
before the base locale was localised — every override still carried the English headword,
and `_words_es_419` still carried *los númerlo* after the overlay had been repaired.
Rewriting each override from the overlay brings both to **0 rows**, and `pt_BR` cost
another ten plus nine replacement rules once Portugal was localised. So: **after localising
a base locale, re-derive its regional variant and diff, or the override table quietly
holds the old text.** The check is four lines — import `_words_<locale>`, compare each row
against `assets/l10n/words_<locale>.json` — and all ten generators are at 0 rows today.

**A substitution that changes gender has to carry the article**, which is the same lesson
`los númerlo` taught in a different costume, and both derived files had a live case of it.
`("week-end", "fin de semaine")` gave Canadian French *à un fin de semaine*, and
`("pequenos negócios", "pequenas empresas")` gave Brazilian *hostil aos pequenas empresas*
— masculine articles left standing in front of feminine nouns, in shipped text. Both rules
now carry the article in a longer pair placed ahead of the general one.

And a word whose local form equals the English one still reaches `segmentTranslation`, so
it is handed to the English voice inside a sentence that is otherwise local — true today
for *mathesis* and *imbroglio* in Dutch, a small wart rather than a bug, and the reason
`english_ok` is a list you have to write rather than a rule.

**`exampleGloss` was never the only field this can happen in, and looking only there is
what hid it.** A reader on 2026-09-03 met the same fault under *in gewone woorden*: the
Dutch for *Ineluctable* read "aan een **ineluctable** uitkomst wring je je niet los". An
overlay has **six** translated fields and any of them can carry an English word.
`tool/english_in_translation.py` sweeps all six in all sixty, where `gloss_english.py`
asked about one:

| field | carrying English | |
|---|---|---|
| `exampleGloss` | 7103 / 8040 | 88% — the large job, see above |
| `friendly` | 645 / 8040 | 8% — **13 words, the same 13 in every locale** |
| `definition` | 131 / 8040 | 2% — 7 words |
| `rootMeanings` | 4 / 16080 | 0% |
| `partOfSpeech` | 0 / 8040 | 0% — written by `tool/_pos_origin.py` |
| `origin` | 0 / 8040 | 0% — written by `tool/_pos_origin.py` |

That is the measurement the work started from. Twenty-three locales on, the **bare** counts
— a use, which is the bug — read **4877**, **322**, **19** and **2**; the totals the tool
prints are higher because they count mentions too, and a mention is the fix rather than the
fault. Every locale that has had its sentences done has had its explanations done in the
same pass, which is why all four columns move together.

**The two generated fields are clean and will stay clean**, which is the useful half of
that table: a label written from a table cannot drift the way a sentence can, so the
hand-written fields are the whole of the exposure.

**A mention is not a use, and the difference is mechanical.** The line the sixty drew
unprompted in the example sentences runs through every field, and here it can be measured
rather than judged: English inside quotation marks is a **mention** — the word named *as*
English — and bare English is a **use**. *Dint* is defined as the force in "by dint of"
(quoted in 60 of 60), *Fricaseed* as the misspelling of "fricasseed", *Ingenuous* as the
word told apart from "ingenious". Those must stay; translating them empties the sentence
out. Sorted that way the 645 come apart cleanly: **nine words are a use in all sixty** —
*trenchant*, *minatory*, *euphonious*, *fiducial*, *ineluctable*, *mordant*, *nugatory*,
*redound*, *fructify* — and the rest is a mention that a few locales wrote without its
quotation marks.

**The fault is inherited, not invented, which is why it is the same nine everywhere.** The
*English* `friendly` uses the headword in its own explanation — "a trenchant comment gets
to the heart of the matter" — and sixty translators carried it across faithfully. No
locale can be blamed for it, and the tool prints the English line beside the local one for
that reason.

**The same 36 are done, and the 24 generated locales left are not.** Ten `friendly` fields each — eight in a
Slavic locale, which had already translated *fain* and *fructify* — written out in
`tool/gloss_local_<locale>.json` and put through the same checks as the sentences;
`localize_gloss.py` carries three fields now (`glosses` → `exampleGloss`, `friendly`,
`definitions` → `definition`) rather than one. It is the same ten words everywhere, because
the fault is inherited rather than invented, so a locale's worklist is
`python tool/english_in_translation.py --locale <id>` and the answer is already known
before you read it.

**Each of the six kept one word in English on purpose, and it is the same word.** *fain*
is the archaic term the line exists to name, so it is quoted rather than translated —
"wie iets „fain" doet", "wer etwas „fain“ tut", "qui fait une chose « fain »", "chi fa
una cosa «fain»", "quien hace algo «fain»". Quoting also puts the word back in the
English voice's hands, since `segmentTranslation` cuts on `quotedEnglish`.

**`english_ok` grew by one word in three of them, and each is a real dictionary entry
rather than a shortcut.** German's *Ersatz* is Duden's own noun and the one English
borrowed, and it stands in the definition of *ersatz* where no other German word will do;
Italian took *demi-monde* from the same French English took it from and has no plainer
term; French *mordant* is the participle of *mordre* and *interstice* is ordinary French,
and both turn up in a definition or a root meaning rather than in a sentence. Everywhere
else the plainer local word was reached for first, which is the rule this file already
states: *nugatory* → *sans effet*, *trenchant* → *incisif*, *fiducial* → *fiduciaire* /
*fiduciaria*, *ineluctable* → *ineludible*.

**The pass repaired one piece of shipped damage, which is the second time diffing has
found some.** The French definition of *minatory* read "Mençant" for "Menaçant" — a word
broken in generation, not a variant, and invisible to every check in the suite for the
same reason *los númerlo* was: a mangled word is still a word. It is in
`tool/gloss_local_fr.json` under `definitions` now, so the repair is recorded where the
next generation will read it.

**Two files hold the English words and they do not use the same key**, which is worth
knowing before "fixing" one against the other. `tool/_en_words_src.json` calls the field
`def`; `assets/data/words.json` calls it `definition`. `gloss_english.english_forms()`
reads the **shipped** file, so `localize_gloss.py`'s `CARRIES` is right to say
`definition`, and a change to `def` silently empties the specimen guard instead of fixing
it. It was changed and changed back on 2026-09-03. `_en_words_src.json` is the canonical
source for repairing damaged English text — see *English word data* below — and is not
what these tools read.

**The tools could not print forty of the sixty.** A Windows console defaults to cp1252,
which has no Polish l-stroke and no Cyrillic at all, so `english_in_translation.py --locale
pl` raised `UnicodeEncodeError` and died **mid-report** — after printing the English line
and before the local one, which is the half you need. It looked like a crash in the sweep
and was the terminal. `_speak_utf8()` in that file and in `localize_gloss.py` reconfigures
`stdout` to UTF-8 with `errors='replace'`, so a console that genuinely cannot draw a glyph
prints a box instead of taking the tool down. Worth remembering as the first thing to check
when a tool works for `nl` and dies for `ru`.

**Only `friendly` and `definition` may carry a mention; an example sentence may not.**
That is a rule in `localize_gloss.py` rather than a matter of taste: an explanation
sometimes has to name an English word, and a sentence never does — there the local word
does the work, quoted or not.

`test/text_quality_test.dart` pins the three mentions in all sixty, the way it already
pins the seven specimen quotations, because the obvious next pass would carry them off by
accident. One exception is named in it: **Serbian transliterated *ingenious* into Cyrillic**
(*ингениоус*), which gives a reader the sound and takes away the spelling — and the
spelling is the whole point of a word you are being told to tell apart.

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

**"Why is *efflorescere* still English?" — the routing was right and the request never
reached the engine.** Reported from a device on 2026-09-03, of the Latin etymon on the
*Effloresce* page in Dutch. Measured first, because the reading is the cheap thing to
check and the phone is not: `readingOf` builds an `it-IT` segment carrying *efflorescere*
for **all 81 Latin words** in the lexicon, and the same for the roots. Nothing above
`speech_controller.dart` was wrong.

Three faults underneath it, and the first is the one that ships the bug:

- **`pickVoiceForLanguage` lower-cased the locale, and `setVoice` compares it exactly.**
  `normalizeTtsLocale` is right for matching — `it_IT` and `it-IT` are the same voice —
  and wrong for a platform call. flutter_tts matches a voice against
  `Locale.toLanguageTag()` on Android and `AVSpeechSynthesisVoice.language` on iOS, and
  both of those say `it-IT`; handed `it-it` the plugin logs "Voice name not found" and
  returns 0. On Android `setLanguage` had already taken, so the engine spoke Italian
  anyway and the fault was invisible. **On iOS it is not invisible**: `setLanguage` sets
  `self.voice = nil`, so a `setVoice` that fails leaves the utterance with no voice at
  all and it is spoken by the **system default** — English on an English-set phone,
  whatever language the app is being read in. `VoiceOption.engineLocale` is the locale as
  the engine spelled it; `locale` stays lower-cased for comparing. **The English lock
  never had this bug** — `pickEnglishVoice` passes the raw string through — which is
  exactly why the English half of every reading was fine and the other half was not.
- **`_useLanguage` never looked at the answers.** It set the language, set the voice, read
  neither result and returned `true`. An engine that refuses a language keeps the voice it
  had, so "granted" and "ignored" reported the same and the etymon was read out by
  whichever voice spoke last. It now asks `isLanguageAvailable`, checks `setLanguage`'s
  result the way `_lockToEnglish` always has, and returns false so the caller reads the
  English instead. A `setVoice` that fails after a `setLanguage` that took is not fatal
  and says so in the trace: the language is right, the particular voice is not.
- **`getVoices` lists voices the phone cannot speak.** Google answers with every language
  it supports, downloaded or not, marking the rest `notInstalled` in `features` — so a
  Dutch phone lists forty Italian voices and "has this device Italian?" answers yes.
  `voiceIsInstalled` reads that field, and the same filter now guards the reader's own
  English voice list, which could offer a voice that would never speak. It is deliberately
  narrow: **iOS reports no `features` at all** — `speechVoices()` lists only what is
  installed — so an absent field means installed.

**A root is written for the eye there too.** The sweep that found the first fault found a
second: `spokenEtymonFor` handed the form as written, so `ex-`, `-osus` and `inter-` went
to an Italian mouth with the hyphen on. **Eighty of the 351 forms that reach a foreign
voice carry one**, which is most of the prefixes and every suffix in the lexicon. The
Greek table never had this fault because its entries were written out by hand as the voice
should say them (*amphi-* is *αμφι*); `spokenEtymonForm` does the same for the rest, ends
only, so *demi-monde* is still spoken whole.

**What is left is a design choice rather than a defect, and it is worth knowing before the
next report.** With the above fixed, a phone with no Italian voice reads the Latin etymon
in **English**, on purpose — that is the documented fallback, and it is now reached
deliberately rather than by accident. But Latin is 81 of the 134, so on a phone that has
only its own language and English, most of the lexicon's etymons still arrive in an English
mouth. Two ways out, neither taken yet: ask the reader to install the Italian voice, or
give Latin a chain of stand-ins (`it` → `es` → `pt` → `ro`) so that any Romance voice on
the device says it before English does.

`_useLanguage` also asked the platform for the whole voice list **once per segment** — a
dozen guarded round trips inside a reading. It is fetched once and dropped when
`applyPreferences` runs, in case the reader went and installed one.

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

**A shrink-to-fit floor written as a fraction of the type grows with the reader.**
`FitToWidth` gives a headword the room it asks for and scales it down to the width it
was handed, no further than `minScale`; past that it stops and lets the line wrap,
because type that small is worse to read than a second line. The floor was 0.62 of the
type **as the reader had grown it**, so at the 2.0 maximum it came to 0.62 × 44pt = 27pt
— half again the size the headword is drawn at by default, and far too high to hold the
longest words on one line. *Circumincession* duly broke in the lexicon with a lone "n"
under it, which is the exact shape of the bug the widget was written to prevent, back
again at the far end of the slider. Reported from a device on 2026-09-03.

The floor is `minScale / textScaler` now, which pins it to the **design** size: whatever
the setting, a line may shrink to 0.62 of the 22pt it was written at and no further. At a
scaler of 1 nothing moves at all. Measured from the screenshot, *Circumincession* needs
about 0.58 of its 44pt at the maximum — under the old floor, over the new one — so it
lands around 25pt, still larger than the same word at the ordinary setting. The floor has
not been removed: below it the line still wraps, which is what the second of the two new
cases pins, and both were **checked both ways round** — reverted to the old behaviour they
report 0.62 where they want 0.45 and 0.31.

`FitToWidth` is a `StatelessWidget` around the render object now, because the floor has to
be read from `MediaQuery` and a render object has no context. The reach is every hero the
app sets this way: the lexicon card, the word page's own headword, the app's name on Home,
the word of the day, and a quiz score.

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
| 2026-09-03 | `80d816d` | Windows | 3.41.7 | clean | **347/347** | empty |
| 2026-09-03 | `ae299ea` | Windows | 3.41.7 | clean | **347/347** | empty |
| 2026-09-03 | `e0be7ad` | Windows | 3.41.7 | clean | **347/347** | empty |
| 2026-09-03 | `a16c927` | Windows | 3.41.7 | clean | **347/347** | empty |
| 2026-09-03 | `5309767` | Windows | 3.41.7 | clean | **347/347** | empty |
| 2026-09-03 | `8a3be0c` | Windows | 3.41.7 | clean | **347/347** | empty |

The suite grew from 133 to 146 to 153 to 166 to 177 to 199 to 206 to 218 to 224 to 321 to
334 to 336 to 347 across those commits; the number is a fact about the commit, not a
constant to hold. The 347 is the two halves added together — 320 and 27.

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

`flutter build appbundle --release` exits 0 on Windows at `1.0.0+20` (`2ebd435`), writing a
**47.9 MB** bundle — `versionCode 20`, `versionName 1.0.0`, signed
`CN=Gloss, OU=Mobile, O=Raimonvibe, L=Amsterdam`, `INTERNET` and the `SENDTO` query both in
the merged manifest, all 60 overlays and the Tangerine face inside it, and all 134 English
words carrying their `ipa`. **Twenty-three locales** now read their example sentences and
their explanations wholly in their own language — every locale `localize_gloss.py` can
reach. Checked by unzipping the bundle rather than by trusting the build: `words_sr.json`,
`words_hu.json` and `words_el.json` inside it carry the rewritten sentences.

**Still 47.9 MB, for the fourth version running.** That is worth knowing before going
looking for what went wrong: rewritten sentences replace sentences of about the same length,
so ten more locales of prose cannot move a bundle whose weight is fonts and engine.

Before that, `flutter build appbundle --release` exited 0 on Windows at `1.0.0+19`, writing a **47.9 MB**
bundle — `versionCode 19`, `versionName 1.0.0`, signed
`CN=Gloss, OU=Mobile, O=Raimonvibe, L=Amsterdam`, `INTERNET` and the `SENDTO` query both in
the merged manifest. **Thirteen locales** now read their example sentences wholly in their
own language, and their explanations too. Still 47.9 MB, for the third version running:
rewritten sentences replace sentences of the same length, so a bundle cannot tell the
difference — which is the useful thing to know about a change of this shape before you go
looking for what went wrong.

**`+18` was built at `5e27617` and never uploaded, and `+19` moved anyway** — asked for on
2026-09-03. That is fine and worth writing down so the gap is not read as a lost build: the
rule in this file is that a version code moves *at least* when a bundle is uploaded, not
that it may never move otherwise. `18` is simply spent.

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
