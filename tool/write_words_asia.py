#!/usr/bin/env python3
"""Assemble word overlay JSON for ja, ko, zh_TW, zh_HK, vi, id, ms, fil, tr, az, kk, ky, sw, hy, ka."""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(Path(__file__).resolve().parent))

from _emit_words_asia import emit

LOCALES = [
    "ja", "ko", "zh_TW", "zh_HK", "vi", "id", "ms", "fil",
    "tr", "az", "kk", "ky", "sw", "hy", "ka",
]


def main() -> None:
    missing = []
    for loc in LOCALES:
        mod = f"_data_{loc}"
        try:
            ns: dict = {}
            exec((Path(__file__).parent / f"{mod}.py").read_text(encoding="utf-8"), ns)
        except FileNotFoundError:
            missing.append(loc)
            continue
        emit(loc, ns["ROWS"])
    if missing:
        raise SystemExit(f"missing data modules: {', '.join(missing)}")


if __name__ == "__main__":
    main()
