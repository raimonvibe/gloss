#!/usr/bin/env python3
"""Write Android and iOS locale declarations from l10n/catalog.json."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = json.loads((ROOT / "l10n" / "catalog.json").read_text(encoding="utf-8"))

ANDROID = ROOT / "android/app/src/main/res/xml/locales_config.xml"
IOS = ROOT / "ios/Runner/Info.plist"


def android_names() -> list[str]:
    names = ["en"]
    seen = {"en"}
    for loc in CATALOG["locales"]:
        lang = loc["languageCode"]
        country = loc["countryCode"]
        if lang not in seen:
            names.append(lang)
            seen.add(lang)
        if country:
            tag = f"{lang}-{country}"
            if tag not in seen:
                names.append(tag)
                seen.add(tag)
    return names


def main() -> None:
    locales = android_names()
    lines = [
        '<?xml version="1.0" encoding="utf-8"?>',
        '<locale-config xmlns:android="http://schemas.android.com/apk/res/android">',
    ]
    for name in locales:
        lines.append(f'    <locale android:name="{name}" />')
    lines.append("</locale-config>")
    lines.append("")
    ANDROID.write_text("\n".join(lines), encoding="utf-8")

    plist = IOS.read_text(encoding="utf-8")
    lang_codes = []
    seen = set()
    for loc in CATALOG["locales"]:
        code = loc["languageCode"]
        if code not in seen:
            seen.add(code)
            lang_codes.append(code)
    body = "\n".join(f"\t\t<string>{code}</string>" for code in lang_codes)
    start = plist.index("\t<key>CFBundleLocalizations</key>")
    array_start = plist.index("<array>", start)
    array_end = plist.index("</array>", array_start)
    plist = plist[: array_start + len("<array>")] + "\n" + body + "\n\t" + plist[array_end:]
    IOS.write_text(plist, encoding="utf-8")
    print(f"Wrote {len(locales)} Android locales and {len(lang_codes)} iOS languages.")


if __name__ == "__main__":
    main()
