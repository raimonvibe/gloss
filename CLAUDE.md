# Gloss i18n — Claude Code handoff

## Project

- **App:** Gloss — Flutter lexicon of 134 rare English words
- **Repo:** https://github.com/raimonvibe/gloss (`origin/main`)
- **Path:** `/home/raimonvibe/Documenten/Mobile Development/002Beautiful Words`
- **Plan (4 todos, all completed):** `~/.cursor/plans/177-language_i18n_5e8cb304.plan.md`
- **Flutter SDK:** not on `PATH`. Prefix commands with `PATH="$HOME/Documenten/Developer/flutter/bin:$PATH"`

## Current state (Aug 2026)

- **i18n is complete.** All **59** word-overlay JSON files exist under `assets/l10n/`; Lao (`lo`) and Burmese (`my`) landed in `9076dbb`.
- `test/l10n_catalog_test.dart` no longer exempts any locale — `const incomplete = <String>{};` is the empty hook kept for future work.
- Every non-English translation key resolves to a 134-word overlay with a non-empty `friendly`, `exampleGloss`, and two `rootMeanings`.

## Architecture

**Bilingual-dictionary model:** English lemmas, pronunciation, and root *forms* stay English. Translate UI chrome + explanations only.

| What | Where |
|------|-------|
| 177 countries → ~59 locales | `l10n/catalog.json` |
| Human spec | `l10n/SOURCE.md` |
| Machine source | `l10n/source/ui.json`, `l10n/source/content.json` |
| UI strings | `lib/l10n/app_<key>.arb` → `flutter gen-l10n` |
| Word overlays (134 words) | `assets/l10n/words_<key>.json` |
| Hand-crafted overlay rows | `tool/_data_<key>.py` (134 tuples × 5 fields) |
| POS + origin maps | `tool/_pos_origin.py` (one entry per locale) |
| English word index | `tool/_en_words_src.json` |
| Emit JSON from `_data_*.py` | `python3 tool/emit_from_data.py <locale>` |
| Bulk translate (API) | `python3 tool/translate_l10n.py` |

**App wiring (done):** `SettingsController` locale persistence, `WordRepository.applyLocale()`, `LanguagesScreen` (5th tab + Home shortcut), RTL lemma isolation (`EnglishLemma`), `AppFonts` fallbacks, English TTS lock in `speech_controller.dart`.

## Adding a new locale

1. Add the locale to `l10n/catalog.json` and its POS + origin maps to `tool/_pos_origin.py`
2. Add `lib/l10n/app_<key>.arb`, then run `flutter gen-l10n`
3. Write `tool/_data_<key>.py` (see schema below)
4. Emit: `python3 tool/emit_from_data.py <key>`
5. Run `flutter test test/l10n_catalog_test.dart`
6. Commit only when the user asks

### `_data_<locale>.py` schema

Each file has `ROWS` — a list of **134** tuples in word order (same order as `tool/_en_words_src.json`):

```python
# (definition, friendly, exampleGloss, root1, root2)
ROWS = [
    ("...", "...", "...", "...", "..."),
    # ...
]
```

- Keep English lemmas inside `exampleGloss` (e.g. `"The editor edulcorated the review."` stays; gloss the sentence around it).
- Use a neighbouring language's file as a quality reference (e.g. `tool/_data_th.py`, `_data_km.py`, `_data_lo.py`, `_data_my.py` for the SE Asian family).
- Emit: `python3 tool/emit_from_data.py <locale>`

## Google Translate rate limits — how we handled this before

**Do not keep hammering the free `gtx` endpoint after 429 errors.**

### Option A — Paid API (if available)

```bash
export GOOGLE_TRANSLATE_API_KEY=your_key
python3 tool/translate_l10n.py --content-only --only lo my
```

`translate_l10n.py` caches to `l10n/cache/` (gitignored), retries 429 with backoff, and skips locales that already have output.

### Option B — Hand-craft (what produced all 59 locales)

When Google rate-limited, we **stopped the translate job** and:

1. Wrote `tool/_data_<locale>.py` directly (by hand or via agent), using `content.json` and a neighbouring locale as reference
2. Ran `python3 tool/emit_from_data.py <locale>`

**This is the recommended path.** Lao and Burmese were written this way, from the English source rather than relayed through Thai.

### Option C — Machine translate from a neighbouring locale (fallback, slow)

`tool/gen_lo_my_from_th.py` shows the pattern (th → lo, th → my via the free `gtx` endpoint). It was **not** used for the shipped Lao/Burmese rows — relay translation degrades the literary "friendly" copy. Only reach for this if Option A/B are unavailable, and kill the process if 429 persists.

### Historical note — UI strings

When the free API was exhausted early on, UI was filled via `l10n/source/ui_i18n.json` (agent-written) and copied into ARBs — no Google needed. Word overlays used the `_data_*.py` + `emit_from_data.py` pipeline.

## Verification

```bash
# Row count + emit
python3 -c "from tool._data_lo import ROWS; print(len(ROWS))"  # expect 134
python3 tool/emit_from_data.py <locale>

# Tests (Flutter is not on PATH)
PATH="$HOME/Documenten/Developer/flutter/bin:$PATH" flutter test test/l10n_catalog_test.dart
```

## Do not

- Invent native-language lemmas for the 134 English headwords
- Commit `l10n/cache/` or secrets (`.env`, API keys)
- Force-push `main`
- Amend commits unless explicitly requested

## Reference commits

- `5f26ad9` — Main bilingual i18n + language picker
- `6cbecd8` — Khmer overlays + Caucasian/Turkic refresh
- `9076dbb` — Lao + Burmese overlays; all 59 locales complete
