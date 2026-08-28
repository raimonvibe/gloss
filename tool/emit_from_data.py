#!/usr/bin/env python3
"""Emit assets/l10n/words_<locale>.json from tool/_data_<locale>.py ROWS."""

from __future__ import annotations

import importlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(Path(__file__).resolve().parent))

from _pos_origin import ORIGIN, POS  # noqa: E402

EN = json.loads((ROOT / "tool" / "_en_words_src.json").read_text(encoding="utf-8"))
OUT = ROOT / "assets" / "l10n"


def emit(locale: str) -> None:
    mod = importlib.import_module(f"_data_{locale}")
    rows = mod.ROWS
    if len(rows) != len(EN):
        raise SystemExit(f"{locale}: expected {len(EN)} rows, got {len(rows)}")
    if locale not in POS or locale not in ORIGIN:
        raise SystemExit(f"{locale}: missing POS/ORIGIN maps")
    pos_map = POS[locale]
    origin_map = ORIGIN[locale]
    words = {}
    for src, row in zip(EN, rows):
        if len(row) != 5:
            raise SystemExit(f"{locale} {src['id']}: expected 5 fields, got {len(row)}")
        definition, friendly, gloss, r1, r2 = row
        if src["pos"] not in pos_map:
            raise SystemExit(f"{locale}: missing POS {src['pos']!r}")
        if src["origin"] not in origin_map:
            raise SystemExit(f"{locale}: missing origin {src['origin']!r}")
        if not all(isinstance(x, str) and x.strip() for x in row):
            raise SystemExit(f"{locale}: empty field in {src['id']}")
        words[src["id"]] = {
            "partOfSpeech": pos_map[src["pos"]],
            "definition": definition,
            "friendly": friendly,
            "exampleGloss": gloss,
            "origin": origin_map[src["origin"]],
            "rootMeanings": [r1, r2],
        }
    path = OUT / f"words_{locale}.json"
    path.write_text(
        json.dumps({"words": words}, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"wrote {path.name} ({len(words)} words)")


def main() -> int:
    locales = sys.argv[1:]
    if not locales:
        locales = sorted(
            p.name[6:-3]
            for p in (ROOT / "tool").glob("_data_*.py")
            if p.name.startswith("_data_")
        )
    for locale in locales:
        emit(locale)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
