# Gloss i18n — Claude Code handoff

## Project

- **App:** Gloss — Flutter lexicon of 134 rare English words
- **Repo:** https://github.com/raimonvibe/gloss (`origin/main`)
- **Path:** `/home/raimonvibe/Documenten/Mobile Development/002Beautiful Words`
- **Plan (4 todos):** `~/.cursor/plans/177-language_i18n_5e8cb304.plan.md`

## Current state (Aug 2026)

- **Git:** `main` at `6cbecd8`, synced with `origin/main`
- **i18n is ~99% done.** Only **Lao (`lo`)** and **Burmese (`my`)** word overlays are missing.
- UI ARBs exist (`app_lo.arb`, `app_my.arb`). Without word overlays, explanations fall back to English.
- **57** of **59** word-overlay JSON files exist under `assets/l10n/`.
- Test exemption: `test/l10n_catalog_test.dart` line 101 — `const incomplete = {'lo', 'my'};`
- Untracked file: `tool/gen_lo_my_from_th.py` (fallback translate script; may still be running or failed)

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
| POS + origin maps | `tool/_pos_origin.py` (`lo` and `my` already present) |
| English word index | `tool/_en_words_src.json` |
| Emit JSON from `_data_*.py` | `python3 tool/emit_from_data.py <locale>` |
| Bulk translate (API) | `python3 tool/translate_l10n.py` |

**App wiring (done):** `SettingsController` locale persistence, `WordRepository.applyLocale()`, `LanguagesScreen` (5th tab + Home shortcut), RTL lemma isolation (`EnglishLemma`), `AppFonts` fallbacks, English TTS lock in `speech_controller.dart`.

## Your task: finish `lo` and `my`

Produce:

1. `tool/_data_lo.py`
2. `tool/_data_my.py`
3. `assets/l10n/words_lo.json`
4. `assets/l10n/words_my.json`

Then:

1. Remove `'lo'` and `'my'` from `incomplete` in `test/l10n_catalog_test.dart`
2. Run `flutter test test/l10n_catalog_test.dart`
3. Commit only when the user asks

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
- Use `tool/_data_th.py` or `tool/_data_km.py` as quality references (same SE Asian family).
- Emit: `python3 tool/emit_from_data.py lo my`

## Google Translate rate limits — how we handled this before

**Do not keep hammering the free `gtx` endpoint after 429 errors.**

### Option A — Paid API (if available)

```bash
export GOOGLE_TRANSLATE_API_KEY=your_key
python3 tool/translate_l10n.py --content-only --only lo my
```

`translate_l10n.py` caches to `l10n/cache/` (gitignored), retries 429 with backoff, and skips locales that already have output.

### Option B — Hand-craft (what worked for 57 locales)

When Google rate-limited, we **stopped the translate job** and:

1. Wrote `tool/_data_<locale>.py` directly (by hand or via agent), using `content.json` / `_data_th.py` as reference
2. Ran `python3 tool/emit_from_data.py <locale>`

**This is the recommended path for `lo` and `my`.**

### Option C — Machine translate from Thai (fallback, slow)

```bash
python3 tool/gen_lo_my_from_th.py   # th → lo, th → my (rate-limit prone)
python3 tool/emit_from_data.py lo my
```

Only use if Option A/B are unavailable. Kill the process if 429 persists.

### Historical note — UI strings

When the free API was exhausted early on, UI was filled via `l10n/source/ui_i18n.json` (agent-written) and copied into ARBs — no Google needed. Word overlays used the `_data_*.py` + `emit_from_data.py` pipeline.

## Verification

```bash
# Row count + emit
python3 -c "from tool._data_lo import ROWS; print(len(ROWS))"  # expect 134
python3 tool/emit_from_data.py lo my

# Tests
flutter test test/l10n_catalog_test.dart
```

## Do not

- Invent native-language lemmas for the 134 English headwords
- Commit `l10n/cache/` or secrets (`.env`, API keys)
- Force-push `main`
- Amend commits unless explicitly requested

## Reference commits

- `5f26ad9` — Main bilingual i18n + language picker
- `6cbecd8` — Khmer overlays + Caucasian/Turkic refresh (latest)
