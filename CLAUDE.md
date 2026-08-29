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
| Linux | `~/Documenten/Mobile Development/002Beautiful Words` | **not** on `PATH` — prefix `PATH="$HOME/Documenten/Developer/flutter/bin:$PATH"` | `python3` | yes |
| Windows | `C:\Users\rober\Documents\My Tableau Repository\Mobile Development\002 Beautiful Words` | on `PATH` | `python` (no `python3`) | **no `.git`** |

The Windows copy has no git history, so `git log`, `git status` and anything
comparing against `origin/main` will fail there. Check before reaching for them.

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

### The three counts, which are all different on purpose

| Count | What |
|---|---|
| **60** | `translationKey`s in `l10n/catalog.json` — 59 non-English plus `en` |
| **59** | `assets/l10n/words_<key>.json` overlays — one per non-English key; English needs none |
| **61** | `lib/l10n/app_<key>.arb` — the 60 above, plus an orphan `app_zh.arb` (see [BACKLOG.md](BACKLOG.md) item 4) |

## Architecture

**Bilingual-dictionary model:** English lemmas, pronunciation, and root *forms* stay
English. Translate UI chrome + explanations only.

| What | Where |
|------|-------|
| 177 countries → ~59 locales | `l10n/catalog.json` |
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

**Known-good baseline (2026-08-29):** `flutter analyze` clean, `flutter test` **81/81**,
`l10n/untranslated.json` empty, `flutter build apk --debug` exit 0.

The Flutter version differs by machine — 3.47.2 / Dart 3.13.2 on Linux, 3.41.7 on
Windows. Record which one you used when you move the baseline.

## Do not

- Invent native-language lemmas for the 134 English headwords
- Commit `l10n/cache/` or secrets (`.env`, API keys)
- Force-push `main`
- Amend commits unless explicitly requested
- Assume this checkout is a git repo, or that Flutter is on `PATH` — see *Environments*

## Reference commits

- `5f26ad9` — Main bilingual i18n + language picker
- `6cbecd8` — Khmer overlays + Caucasian/Turkic refresh
- `9076dbb` — Lao + Burmese overlays; all 59 locales complete
- `d77e39f` — Study page (the one that introduced the 37-key gap)
