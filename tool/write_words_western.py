#!/usr/bin/env python3
"""Assemble Western-European word overlay JSON from per-locale dicts."""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(Path(__file__).resolve().parent))

from _words_de import WORDS as DE
from _words_es import WORDS as ES
from _words_es_419 import WORDS as ES_419
from _words_fr import WORDS as FR
from _words_fr_CA import WORDS as FR_CA
from _words_it import WORDS as IT
from _words_nl import WORDS as NL
from _words_pl import WORDS as PL
from _words_pt import WORDS as PT
from _words_pt_BR import WORDS as PT_BR

CONTENT = json.loads((ROOT / "l10n/source/content.json").read_text(encoding="utf-8"))
OUT = ROOT / "assets" / "l10n"

POS = {
    "nl": {
        "verb": "werkwoord",
        "adjective": "bijvoeglijk naamwoord",
        "noun": "zelfstandig naamwoord",
        "adverb": "bijwoord",
        "adjective / verb": "bijvoeglijk naamwoord / werkwoord",
        "verb (past tense)": "werkwoord (verleden tijd)",
        "adjective / noun": "bijvoeglijk naamwoord / zelfstandig naamwoord",
    },
    "de": {
        "verb": "Verb",
        "adjective": "Adjektiv",
        "noun": "Substantiv",
        "adverb": "Adverb",
        "adjective / verb": "Adjektiv / Verb",
        "verb (past tense)": "Verb (Präteritum)",
        "adjective / noun": "Adjektiv / Substantiv",
    },
    "fr": {
        "verb": "verbe",
        "adjective": "adjectif",
        "noun": "nom",
        "adverb": "adverbe",
        "adjective / verb": "adjectif / verbe",
        "verb (past tense)": "verbe (passé)",
        "adjective / noun": "adjectif / nom",
    },
    "fr_CA": {
        "verb": "verbe",
        "adjective": "adjectif",
        "noun": "nom",
        "adverb": "adverbe",
        "adjective / verb": "adjectif / verbe",
        "verb (past tense)": "verbe (passé)",
        "adjective / noun": "adjectif / nom",
    },
    "es": {
        "verb": "verbo",
        "adjective": "adjetivo",
        "noun": "sustantivo",
        "adverb": "adverbio",
        "adjective / verb": "adjetivo / verbo",
        "verb (past tense)": "verbo (pasado)",
        "adjective / noun": "adjetivo / sustantivo",
    },
    "es_419": {
        "verb": "verbo",
        "adjective": "adjetivo",
        "noun": "sustantivo",
        "adverb": "adverbio",
        "adjective / verb": "adjetivo / verbo",
        "verb (past tense)": "verbo (pasado)",
        "adjective / noun": "adjetivo / sustantivo",
    },
    "pt": {
        "verb": "verbo",
        "adjective": "adjetivo",
        "noun": "substantivo",
        "adverb": "advérbio",
        "adjective / verb": "adjetivo / verbo",
        "verb (past tense)": "verbo (pretérito)",
        "adjective / noun": "adjetivo / substantivo",
    },
    "pt_BR": {
        "verb": "verbo",
        "adjective": "adjetivo",
        "noun": "substantivo",
        "adverb": "advérbio",
        "adjective / verb": "adjetivo / verbo",
        "verb (past tense)": "verbo (pretérito)",
        "adjective / noun": "adjetivo / substantivo",
    },
    "it": {
        "verb": "verbo",
        "adjective": "aggettivo",
        "noun": "sostantivo",
        "adverb": "avverbio",
        "adjective / verb": "aggettivo / verbo",
        "verb (past tense)": "verbo (passato)",
        "adjective / noun": "aggettivo / sostantivo",
    },
    "pl": {
        "verb": "czasownik",
        "adjective": "przymiotnik",
        "noun": "rzeczownik",
        "adverb": "przysłówek",
        "adjective / verb": "przymiotnik / czasownik",
        "verb (past tense)": "czasownik (czas przeszły)",
        "adjective / noun": "przymiotnik / rzeczownik",
    },
}

ORIGIN = {
    "nl": {
        "Latin": "Latijn",
        "Spanish": "Spaans",
        "French / Latin": "Frans / Latijn",
        "Latin / English": "Latijn / Engels",
        "Italian": "Italiaans",
        "Old French / English": "Oudfrans / Engels",
        "Greek / Latin": "Grieks / Latijn",
        "Italian / Latin": "Italiaans / Latijn",
        "Frankish / Old French": "Frankisch / Oudfrans",
        "French": "Frans",
        "Uncertain / Italian": "Onzeker / Italiaans",
        "English": "Engels",
        "Latin / French": "Latijn / Frans",
        "Latin / Old French": "Latijn / Oudfrans",
        "Old French / Latin": "Oudfrans / Latijn",
        "Old English": "Oudengels",
        "Middle English": "Middelengels",
        "German": "Duits",
        "Italian / Greek": "Italiaans / Grieks",
        "Old French": "Oudfrans",
        "Greek": "Grieks",
        "Italian / French": "Italiaans / Frans",
    },
    "de": {
        "Latin": "Latein",
        "Spanish": "Spanisch",
        "French / Latin": "Französisch / Latein",
        "Latin / English": "Latein / Englisch",
        "Italian": "Italienisch",
        "Old French / English": "Altfranzösisch / Englisch",
        "Greek / Latin": "Griechisch / Latein",
        "Italian / Latin": "Italienisch / Latein",
        "Frankish / Old French": "Fränkisch / Altfranzösisch",
        "French": "Französisch",
        "Uncertain / Italian": "Unsicher / Italienisch",
        "English": "Englisch",
        "Latin / French": "Latein / Französisch",
        "Latin / Old French": "Latein / Altfranzösisch",
        "Old French / Latin": "Altfranzösisch / Latein",
        "Old English": "Altenglisch",
        "Middle English": "Mittelenglisch",
        "German": "Deutsch",
        "Italian / Greek": "Italienisch / Griechisch",
        "Old French": "Altfranzösisch",
        "Greek": "Griechisch",
        "Italian / French": "Italienisch / Französisch",
    },
    "fr": {
        "Latin": "latin",
        "Spanish": "espagnol",
        "French / Latin": "français / latin",
        "Latin / English": "latin / anglais",
        "Italian": "italien",
        "Old French / English": "ancien français / anglais",
        "Greek / Latin": "grec / latin",
        "Italian / Latin": "italien / latin",
        "Frankish / Old French": "francique / ancien français",
        "French": "français",
        "Uncertain / Italian": "incertain / italien",
        "English": "anglais",
        "Latin / French": "latin / français",
        "Latin / Old French": "latin / ancien français",
        "Old French / Latin": "ancien français / latin",
        "Old English": "vieil anglais",
        "Middle English": "moyen anglais",
        "German": "allemand",
        "Italian / Greek": "italien / grec",
        "Old French": "ancien français",
        "Greek": "grec",
        "Italian / French": "italien / français",
    },
    "fr_CA": {
        "Latin": "latin",
        "Spanish": "espagnol",
        "French / Latin": "français / latin",
        "Latin / English": "latin / anglais",
        "Italian": "italien",
        "Old French / English": "ancien français / anglais",
        "Greek / Latin": "grec / latin",
        "Italian / Latin": "italien / latin",
        "Frankish / Old French": "francique / ancien français",
        "French": "français",
        "Uncertain / Italian": "incertain / italien",
        "English": "anglais",
        "Latin / French": "latin / français",
        "Latin / Old French": "latin / ancien français",
        "Old French / Latin": "ancien français / latin",
        "Old English": "vieux anglais",
        "Middle English": "moyen anglais",
        "German": "allemand",
        "Italian / Greek": "italien / grec",
        "Old French": "ancien français",
        "Greek": "grec",
        "Italian / French": "italien / français",
    },
    "es": {
        "Latin": "latín",
        "Spanish": "español",
        "French / Latin": "francés / latín",
        "Latin / English": "latín / inglés",
        "Italian": "italiano",
        "Old French / English": "francés antiguo / inglés",
        "Greek / Latin": "griego / latín",
        "Italian / Latin": "italiano / latín",
        "Frankish / Old French": "fráncico / francés antiguo",
        "French": "francés",
        "Uncertain / Italian": "incierto / italiano",
        "English": "inglés",
        "Latin / French": "latín / francés",
        "Latin / Old French": "latín / francés antiguo",
        "Old French / Latin": "francés antiguo / latín",
        "Old English": "inglés antiguo",
        "Middle English": "inglés medio",
        "German": "alemán",
        "Italian / Greek": "italiano / griego",
        "Old French": "francés antiguo",
        "Greek": "griego",
        "Italian / French": "italiano / francés",
    },
    "es_419": {
        "Latin": "latín",
        "Spanish": "español",
        "French / Latin": "francés / latín",
        "Latin / English": "latín / inglés",
        "Italian": "italiano",
        "Old French / English": "francés antiguo / inglés",
        "Greek / Latin": "griego / latín",
        "Italian / Latin": "italiano / latín",
        "Frankish / Old French": "fráncico / francés antiguo",
        "French": "francés",
        "Uncertain / Italian": "incierto / italiano",
        "English": "inglés",
        "Latin / French": "latín / francés",
        "Latin / Old French": "latín / francés antiguo",
        "Old French / Latin": "francés antiguo / latín",
        "Old English": "inglés antiguo",
        "Middle English": "inglés medio",
        "German": "alemán",
        "Italian / Greek": "italiano / griego",
        "Old French": "francés antiguo",
        "Greek": "griego",
        "Italian / French": "italiano / francés",
    },
    "pt": {
        "Latin": "latim",
        "Spanish": "espanhol",
        "French / Latin": "francês / latim",
        "Latin / English": "latim / inglês",
        "Italian": "italiano",
        "Old French / English": "francês antigo / inglês",
        "Greek / Latin": "grego / latim",
        "Italian / Latin": "italiano / latim",
        "Frankish / Old French": "frâncico / francês antigo",
        "French": "francês",
        "Uncertain / Italian": "incerto / italiano",
        "English": "inglês",
        "Latin / French": "latim / francês",
        "Latin / Old French": "latim / francês antigo",
        "Old French / Latin": "francês antigo / latim",
        "Old English": "inglês antigo",
        "Middle English": "inglês médio",
        "German": "alemão",
        "Italian / Greek": "italiano / grego",
        "Old French": "francês antigo",
        "Greek": "grego",
        "Italian / French": "italiano / francês",
    },
    "pt_BR": {
        "Latin": "latim",
        "Spanish": "espanhol",
        "French / Latin": "francês / latim",
        "Latin / English": "latim / inglês",
        "Italian": "italiano",
        "Old French / English": "francês antigo / inglês",
        "Greek / Latin": "grego / latim",
        "Italian / Latin": "italiano / latim",
        "Frankish / Old French": "frâncico / francês antigo",
        "French": "francês",
        "Uncertain / Italian": "incerto / italiano",
        "English": "inglês",
        "Latin / French": "latim / francês",
        "Latin / Old French": "latim / francês antigo",
        "Old French / Latin": "francês antigo / latim",
        "Old English": "inglês antigo",
        "Middle English": "inglês médio",
        "German": "alemão",
        "Italian / Greek": "italiano / grego",
        "Old French": "francês antigo",
        "Greek": "grego",
        "Italian / French": "italiano / francês",
    },
    "it": {
        "Latin": "latino",
        "Spanish": "spagnolo",
        "French / Latin": "francese / latino",
        "Latin / English": "latino / inglese",
        "Italian": "italiano",
        "Old French / English": "francese antico / inglese",
        "Greek / Latin": "greco / latino",
        "Italian / Latin": "italiano / latino",
        "Frankish / Old French": "francone / francese antico",
        "French": "francese",
        "Uncertain / Italian": "incerto / italiano",
        "English": "inglese",
        "Latin / French": "latino / francese",
        "Latin / Old French": "latino / francese antico",
        "Old French / Latin": "francese antico / latino",
        "Old English": "inglese antico",
        "Middle English": "inglese medio",
        "German": "tedesco",
        "Italian / Greek": "italiano / greco",
        "Old French": "francese antico",
        "Greek": "greco",
        "Italian / French": "italiano / francese",
    },
    "pl": {
        "Latin": "łacina",
        "Spanish": "hiszpański",
        "French / Latin": "francuski / łacina",
        "Latin / English": "łacina / angielski",
        "Italian": "włoski",
        "Old French / English": "starofrancuski / angielski",
        "Greek / Latin": "grecki / łacina",
        "Italian / Latin": "włoski / łacina",
        "Frankish / Old French": "frankijski / starofrancuski",
        "French": "francuski",
        "Uncertain / Italian": "niepewne / włoski",
        "English": "angielski",
        "Latin / French": "łacina / francuski",
        "Latin / Old French": "łacina / starofrancuski",
        "Old French / Latin": "starofrancuski / łacina",
        "Old English": "staroangielski",
        "Middle English": "średnioangielski",
        "German": "niemiecki",
        "Italian / Greek": "włoski / grecki",
        "Old French": "starofrancuski",
        "Greek": "grecki",
        "Italian / French": "włoski / francuski",
    },
}

LOCALES = {
    "nl": NL,
    "de": DE,
    "fr": FR,
    "fr_CA": FR_CA,
    "es": ES,
    "es_419": ES_419,
    "pt": PT,
    "pt_BR": PT_BR,
    "it": IT,
    "pl": PL,
}


def build(locale: str, words_data: dict) -> None:
    out = {"words": {}}
    pos_map = POS[locale]
    origin_map = ORIGIN[locale]
    missing = []
    for entry in CONTENT["words"]:
        wid = entry["id"]
        row = words_data.get(wid)
        if row is None:
            missing.append(wid)
            continue
        definition, friendly, example, r1, r2 = row
        if len(entry["rootMeanings"]) != 2:
            raise SystemExit(f"{wid}: expected 2 roots")
        out["words"][wid] = {
            "partOfSpeech": pos_map[entry["partOfSpeech"]],
            "definition": definition,
            "friendly": friendly,
            "exampleGloss": example,
            "origin": origin_map[entry["origin"]],
            "rootMeanings": [r1, r2],
        }
    if missing:
        raise SystemExit(f"{locale} missing {len(missing)}: {missing[:12]}")
    extra = set(words_data) - {e["id"] for e in CONTENT["words"]}
    if extra:
        raise SystemExit(f"{locale} extra ids: {sorted(extra)[:12]}")
    path = OUT / f"words_{locale}.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(out, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"wrote {path.name} ({len(out['words'])} words)")


def main() -> int:
    for loc, data in LOCALES.items():
        build(loc, data)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
