#!/usr/bin/env python3
"""Build _data_lo.py and _data_my.py from Thai rows via Google Translate."""

from __future__ import annotations

import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tool"))

from _data_th import ROWS as TH_ROWS  # noqa: E402

UA = "Mozilla/5.0 (compatible; GlossL10n/1.0)"
DELIM = "\n<@>\n"
BATCH = 4
CACHE = ROOT / "l10n" / "cache"


def gtx(text: str, source: str, target: str) -> str:
    query = urllib.parse.urlencode(
        {"client": "gtx", "sl": source, "tl": target, "dt": "t", "q": text}
    )
    req = urllib.request.Request(
        f"https://translate.googleapis.com/translate_a/single?{query}",
        headers={"User-Agent": UA},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        payload = json.loads(resp.read().decode("utf-8"))
    return "".join(part[0] for part in (payload[0] or []) if part and part[0])


def translate_many(texts: list[str], source: str, target: str, cache: dict) -> list[str]:
    out = [""] * len(texts)
    pending = [i for i, t in enumerate(texts) if t not in cache]
    for i, t in enumerate(texts):
        if t in cache:
            out[i] = cache[t]
    delay = 8.0
    for start in range(0, len(pending), BATCH):
        chunk = pending[start : start + BATCH]
        raw = [texts[i] for i in chunk]
        for attempt in range(12):
            try:
                joined = gtx(DELIM.join(raw), source, target)
                parts = joined.split(DELIM)
                if len(parts) != len(raw):
                    parts = [gtx(t, source, target) for t in raw]
                for idx, src, val in zip(chunk, raw, parts):
                    cache[src] = val.strip() or src
                    out[idx] = cache[src]
                time.sleep(3.5)
                break
            except urllib.error.HTTPError as exc:
                if exc.code == 429:
                    time.sleep(delay)
                    delay = min(delay * 1.5, 120)
                    continue
                raise
        else:
            raise RuntimeError(f"translate failed {source}->{target}")
    return out


def write_data(locale: str, label: str, rows: list[tuple[str, ...]]) -> None:
  path = ROOT / "tool" / f"_data_{locale}.py"
  lines = [
      f"# {label} rows: (definition, friendly, exampleGloss, root1, root2)",
      "ROWS = [",
  ]
  for row in rows:
      parts = []
      for cell in row:
          cell = cell.replace("\\", "\\\\").replace('"', '\\"')
          parts.append(f'"{cell}"')
      lines.append(f"    ({', '.join(parts)}),")
  lines.append("]")
  path.write_text("\n".join(lines) + "\n", encoding="utf-8")
  print(f"wrote {path.name} ({len(rows)} rows)")


def main() -> int:
    flat = [field for row in TH_ROWS for field in row]
    if len(TH_ROWS) != 134:
        raise SystemExit(f"expected 134 Thai rows, got {len(TH_ROWS)}")
    CACHE.mkdir(parents=True, exist_ok=True)
    for locale, label, source, target in (
        ("lo", "Lao", "th", "lo"),
        ("my", "Burmese", "th", "my"),
    ):
        cache_path = CACHE / f"th_to_{locale}.json"
        cache = json.loads(cache_path.read_text(encoding="utf-8")) if cache_path.exists() else {}
        translated = translate_many(flat, source, target, cache)
        cache_path.write_text(
            json.dumps(cache, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )
        rows = [tuple(translated[i : i + 5]) for i in range(0, len(translated), 5)]
        write_data(locale, label, rows)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
