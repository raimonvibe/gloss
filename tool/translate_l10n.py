#!/usr/bin/env python3
"""Translate Gloss UI + word explanations into catalog locales.

Uses the public Google Translate endpoint, or Cloud Translation v2 when
GOOGLE_TRANSLATE_API_KEY is set.

  python3 tool/translate_l10n.py
  python3 tool/translate_l10n.py --ui-only
  python3 tool/translate_l10n.py --en-only
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
UI_PATH = ROOT / "l10n" / "source" / "ui.json"
CONTENT_PATH = ROOT / "l10n" / "source" / "content.json"
CATALOG_PATH = ROOT / "l10n" / "catalog.json"
ARB_DIR = ROOT / "lib" / "l10n"
WORDS_DIR = ROOT / "assets" / "l10n"
CACHE_DIR = ROOT / "l10n" / "cache"

UA = "Mozilla/5.0 (compatible; GlossL10n/1.0)"
PLACEHOLDER = re.compile(r"\{[^{}]+\}")
ICU_PLURAL = re.compile(
    r"^\{(\w+),\s*plural,\s*=1\{(.+)\}\s*other\{(.+)\}\}$", re.DOTALL
)
FROZEN = {"appTitle", "glossIcon"}
BATCH_SIZE = 16
DELIM = "\n<@>\n"


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, data) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


def protect(text: str) -> tuple[str, list[str]]:
    tokens: list[str] = []

    def repl(match: re.Match[str]) -> str:
        tokens.append(match.group(0))
        return f"[[{len(tokens) - 1}]]"

    return PLACEHOLDER.sub(repl, text), tokens


def restore(text: str, tokens: list[str]) -> str:
    out = text
    for i, tok in enumerate(tokens):
        for needle in (f"[[{i}]]", f"[{i}]", f"({i})", f"⟦{i}⟧"):
            out = out.replace(needle, tok)
    return out


def gtx_translate(text: str, target: str) -> str:
    query = urllib.parse.urlencode(
        {
            "client": "gtx",
            "sl": "en",
            "tl": target,
            "dt": "t",
            "q": text,
        }
    )
    req = urllib.request.Request(
        f"https://translate.googleapis.com/translate_a/single?{query}",
        headers={"User-Agent": UA},
    )
    with urllib.request.urlopen(req, timeout=45) as resp:
        payload = json.loads(resp.read().decode("utf-8"))
    chunks = payload[0] or []
    return "".join(part[0] for part in chunks if part and part[0])


def v2_translate(texts: list[str], target: str, api_key: str) -> list[str]:
    body = json.dumps(
        {"q": texts, "source": "en", "target": target, "format": "text"}
    ).encode("utf-8")
    req = urllib.request.Request(
        f"https://translation.googleapis.com/language/translate/v2?key={api_key}",
        data=body,
        headers={"Content-Type": "application/json", "User-Agent": UA},
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=45) as resp:
        payload = json.loads(resp.read().decode("utf-8"))
    return [row["translatedText"] for row in payload["data"]["translations"]]


class Translator:
    def __init__(self, google_code: str) -> None:
        self.google_code = google_code
        self.api_key = os.environ.get("GOOGLE_TRANSLATE_API_KEY", "").strip()
        self.cache_path = CACHE_DIR / f"{google_code.replace('-', '_')}.json"
        self.cache: dict[str, str] = {}
        if self.cache_path.exists():
            self.cache = load_json(self.cache_path)
        self._dirty = 0

    def translate(self, text: str) -> str:
        return self.translate_many([text])[0]

    def translate_many(self, texts: list[str]) -> list[str]:
        out = [""] * len(texts)
        pending: list[int] = []
        for i, text in enumerate(texts):
            cached = self.cache.get(text)
            if cached is not None:
                out[i] = cached
            else:
                pending.append(i)
        if not pending:
            return out
        for start in range(0, len(pending), BATCH_SIZE):
            chunk = pending[start : start + BATCH_SIZE]
            raw = [texts[i] for i in chunk]
            translated = self._request_batch(raw)
            for index, source, value in zip(chunk, raw, translated):
                self.cache[source] = value
                out[index] = value
                self._dirty += 1
            self.flush()
            time.sleep(0.8)
        return out

    def _request_batch(self, texts: list[str]) -> list[str]:
        protected: list[str] = []
        token_sets: list[list[str]] = []
        for text in texts:
            guarded, tokens = protect(text)
            protected.append(guarded)
            token_sets.append(tokens)

        delay = 4.0
        last_error: Exception | None = None
        for _ in range(8):
            try:
                if self.api_key:
                    raw = v2_translate(protected, self.google_code, self.api_key)
                else:
                    joined = gtx_translate(DELIM.join(protected), self.google_code)
                    raw = joined.split(DELIM)
                    if len(raw) != len(protected):
                        raw = [
                            gtx_translate(item, self.google_code)
                            for item in protected
                        ]
                restored = [
                    restore(item, tokens).strip() or source
                    for item, tokens, source in zip(raw, token_sets, texts)
                ]
                if len(restored) == len(texts):
                    return restored
            except urllib.error.HTTPError as exc:
                last_error = exc
                if exc.code in {429, 503, 502}:
                    time.sleep(delay)
                    delay = min(delay * 1.8, 90)
                    continue
                raise
            except Exception as exc:  # noqa: BLE001
                last_error = exc
                time.sleep(delay)
                delay = min(delay * 1.8, 90)
        raise RuntimeError(
            f"translate failed for {self.google_code!r}: {last_error}"
        )

    def flush(self) -> None:
        if self._dirty:
            write_json(self.cache_path, self.cache)
            self._dirty = 0


def arb_locale(translation_key: str) -> str:
    return translation_key.replace("_", "-")


def write_arb(translation_key: str, strings: dict, ui: dict) -> None:
    locale = arb_locale(translation_key)
    doc: dict = {"@@locale": locale}
    for key, english in ui["strings"].items():
        value = strings[key]
        doc[key] = value
        if translation_key == "en":
            meta: dict = {}
            if key in ui.get("placeholders", {}):
                meta["placeholders"] = ui["placeholders"][key]
            if key in FROZEN:
                meta["description"] = "Do not translate. Brand name."
            if meta:
                doc[f"@{key}"] = meta
    ARB_DIR.mkdir(parents=True, exist_ok=True)
    write_json(ARB_DIR / f"app_{translation_key}.arb", doc)


def flatten_ui(ui: dict) -> tuple[list[str], list[tuple[str, str | tuple]]]:
    """Return translatable snippets plus a rebuild plan."""
    snippets: list[str] = []
    plan: list[tuple[str, str | tuple]] = []
    for key, english in ui["strings"].items():
        if key in FROZEN:
            plan.append((key, "frozen"))
            continue
        match = ICU_PLURAL.match(english)
        if match:
            var, one, other = match.group(1), match.group(2), match.group(3)
            plan.append((key, ("plural", var, len(snippets), len(snippets) + 1)))
            snippets.extend([one, other])
        else:
            plan.append((key, ("plain", len(snippets))))
            snippets.append(english)
    return snippets, plan


def rebuild_ui(plan, translated: list[str], ui: dict) -> dict[str, str]:
    out: dict[str, str] = {}
    for key, spec in plan:
        english = ui["strings"][key]
        if spec == "frozen":
            out[key] = english
        elif spec[0] == "plain":
            out[key] = translated[spec[1]]
        else:
            _, var, one_i, other_i = spec
            out[key] = (
                f"{{{var}, plural, =1{{{translated[one_i]}}} "
                f"other{{{translated[other_i]}}}}}"
            )
    return out


def flatten_content(content: dict) -> tuple[list[str], list[dict]]:
    snippets: list[str] = []
    plan: list[dict] = []
    for entry in content["words"]:
        start = len(snippets)
        snippets.extend(
            [
                entry["partOfSpeech"],
                entry["definition"],
                entry["friendly"],
                entry["example"],
                entry["origin"],
                *entry["rootMeanings"],
            ]
        )
        plan.append(
            {
                "id": entry["id"],
                "start": start,
                "roots": len(entry["rootMeanings"]),
            }
        )
    return snippets, plan


def rebuild_content(plan: list[dict], translated: list[str]) -> dict:
    words = {}
    for item in plan:
        i = item["start"]
        roots = item["roots"]
        words[item["id"]] = {
            "partOfSpeech": translated[i],
            "definition": translated[i + 1],
            "friendly": translated[i + 2],
            "exampleGloss": translated[i + 3],
            "origin": translated[i + 4],
            "rootMeanings": translated[i + 5 : i + 5 + roots],
        }
    return {"words": words}


def unique_targets(catalog: dict) -> list[dict]:
    seen = set()
    rows = []
    for loc in catalog["locales"]:
        key = loc["translationKey"]
        if key in seen:
            continue
        seen.add(key)
        rows.append(loc)
    return rows


def already_done(key: str, ui_only: bool, content_only: bool) -> bool:
    arb = ARB_DIR / f"app_{key}.arb"
    words = WORDS_DIR / f"words_{key}.json"
    if content_only:
        return words.exists()
    if not arb.exists():
        return False
    if ui_only:
        return True
    return words.exists()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--ui-only", action="store_true")
    parser.add_argument("--content-only", action="store_true")
    parser.add_argument("--en-only", action="store_true")
    parser.add_argument(
        "--only",
        nargs="+",
        help="Limit to these translation keys (e.g. ar ja hi)",
    )
    args = parser.parse_args()

    ui = load_json(UI_PATH)
    content = load_json(CONTENT_PATH)
    catalog = load_json(CATALOG_PATH)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    WORDS_DIR.mkdir(parents=True, exist_ok=True)

    if not args.content_only:
        write_arb("en", ui["strings"], ui)
        if args.en_only:
            print("Wrote lib/l10n/app_en.arb")
            return 0

    targets = [row for row in unique_targets(catalog) if row["translationKey"] != "en"]
    if args.only:
        wanted = set(args.only)
        targets = [row for row in targets if row["translationKey"] in wanted]
    ui_snips, ui_plan = flatten_ui(ui)
    content_snips, content_plan = flatten_content(content)

    print(f"Translating {len(targets)} locales sequentially…")
    for index, row in enumerate(targets, start=1):
        key = row["translationKey"]
        if already_done(key, args.ui_only, args.content_only):
            print(f"[{index}/{len(targets)}] {key} (skip)")
            continue
        translator = Translator(row["googleCode"])
        try:
            if not args.content_only:
                ui_translated = translator.translate_many(ui_snips)
                write_arb(key, rebuild_ui(ui_plan, ui_translated, ui), ui)
            if not args.ui_only:
                content_translated = translator.translate_many(content_snips)
                write_json(
                    WORDS_DIR / f"words_{key}.json",
                    rebuild_content(content_plan, content_translated),
                )
            translator.flush()
            print(f"[{index}/{len(targets)}] {key}")
        except Exception as exc:  # noqa: BLE001
            translator.flush()
            print(f"FAILED {key}: {exc}", file=sys.stderr)
            return 1
        time.sleep(1.2)
    print("Done.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
