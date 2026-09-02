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

**`<sub alias="...">` is the fix, and it works.** SSML *is* reaching the engine — the app
has always wrapped English utterances (`_useEnglishSsml`, set when the engine is Google) —
and a probe on the device on 2026-09-02 confirmed the engine honours `<sub>`:

| Sent | Heard |
|---|---|
| `<sub alias="pie uh tiss tik">Pietistic</sub>` | correct |
| `pie uh tiss tik` | correct |
| `Pietistic` | **wrong** — "pi-e-stic" |

So the page keeps the word and the voice is handed the respelling, for all 134 at once.
`kRespellingVoicing` in `lib/models/word_entry.dart` records every shape that was tried
and what the phone said about each; `RespellingVoicing.probe` is the experiment itself,
kept because it is how the next such question gets answered.

`<phoneme alphabet="ipa">` is a different matter and is **not** supported by the on-device
engines — it is a cloud-API feature (Google Cloud TTS, Polly, Azure). An engine that does
not know a tag speaks its inner text, which is why `<sub>` costs nothing where it is
unsupported, and why reaching for `<phoneme>` would buy nothing here.

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

The suite grew from 133 to 146 to 153 to 166 to 177 to 199 to 206 across those commits;
the number is a fact about the commit, not a constant to hold.

`flutter build apk --debug` exits 0 on Windows at `2dc63a1`.

`flutter build appbundle --release` exits 0 on Windows at `daa0a98` (`1.0.0+15`), writing
a 47.9 MB `build/app/outputs/bundle/release/app-release.aab` — the same size as
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
