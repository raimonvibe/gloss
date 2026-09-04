# -*- coding: utf-8 -*-
"""Turn what is left of the ijekavian in Serbian into ekavian.

    python tool/ekavize_sr.py --check    # say what would change
    python tool/ekavize_sr.py            # write it

**Serbian was transliterated from Croatian rather than written**, and the
2026-09-03 rewrite that fixed its English and most of its Croatian vocabulary
left the jat reflexes standing: ijekavian *ријеч* for *реч*, *човјек* for
*човек*, *свјетло* for *светло*. Nothing in the suite can see it, because an
ijekavian word is a real word and every test was green over all of them.

**The map is measured and decided one token at a time, not derived.** A rule
that rewrote every consonant + `је` would be wrong about a quarter of what it
matched, in two different ways:

- **`ије` is also an ordinary inflectional ending.** *није*, *касније*,
  *нације*, *перорације*, *цикорије*, *најчистијем*, *речитије* and
  *клијентовом* all match a naive search and are already correct ekavian. So do
  *одјекнула* (од + јекнути) and *божје* (божји). `KEEP` holds them, so that a
  later reader can tell a decision from an oversight.
- **`ијен`/`је` is not always a reflex at all.** *набијеним* (набити),
  *увијене* (увити) and *наречјем* (наречје) are spelled that way in both
  varieties.

**Four tokens cross from spelling into vocabulary, and a blind conversion gets
them wrong** - this is the part a substitution table cannot reason its way to:

    ijekavian        blind ekavian                 what Serbian says
    умјетна          уметна - means "inserted"     вештачка
    лијечнички       лечнички - not a word         лекарски
    повијесно        повесно - strained            историјски
    протурјечност    протуречност - not a word     противречност

*Умјетна или лошија замјена* would have become "an **inserted** or worse
replacement" in the definition of *ersatz*: the `los numerlo` fault in another
language, a real-looking word that no check in this project can see.

**Every substitution is anchored on a word boundary**, for the reason
`_words_es_419.py` learned the hard way - a bare substring rule fires inside a
longer word and leaves damage that reads like a typo.

The record and the overlay are written from the same map in one pass, so
`tool/gloss_local_sr.json` and `assets/l10n/words_sr.json` agree by
construction rather than by diligence - the `pt_BR` lesson, applied up front.

What this tool deliberately does **not** touch, because one job stays one job:
the Croatian vocabulary still in the locale (*обрана*, *успркос*, *такођер*,
*упораба*, *раби*, *којему*, *точку*), and the letter-by-letter
transliterations of English (*Схакеспеарова Мацбетха* for Шекспиров Магбет).
Those are in BACKLOG.md. `такођер` is the one of them the sweep happens to
match, so it is named in `OUT_OF_SCOPE` and reported on every run rather than
being quietly skipped.
"""

import argparse
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OVERLAY = os.path.join(ROOT, 'assets', 'l10n', 'words_sr.json')
RECORD = os.path.join(ROOT, 'tool', 'gloss_local_sr.json')

# The four fields Serbian's overlay carries as prose. `partOfSpeech` and
# `origin` were measured on 2026-09-04 and are already ekavian, so they are
# deliberately not in this list.
FIELDS = ('exampleGloss', 'friendly', 'definition', 'rootMeanings')

# ijekavian -> ekavian, lower case. Case is restored where it is applied.
EKAVIAN = {
    # the jat reflex proper
    'ријеч': 'реч', 'ријечи': 'речи', 'ријечима': 'речима',
    'претјерано': 'претерано', 'претјеран': 'претеран',
    'претјерана': 'претерана', 'претјеривању': 'претеривању',
    'човјек': 'човек',
    'свјетло': 'светло',
    'прије': 'пре',
    'вјетар': 'ветар', 'вјетра': 'ветра',
    'вјештини': 'вештини', 'вјешто': 'вешто',
    'замјене': 'замене', 'замјена': 'замена',
    'замјенска': 'заменска', 'замјерке': 'замерке',
    'лијеност': 'лењост', 'лијености': 'лењости',
    'мјесни': 'месни', 'мјери': 'мери', 'мјеру': 'меру', 'мјеста': 'места',
    'намјерно': 'намерно', 'намјерна': 'намерна',
    'намијењено': 'намењено',
    'напријед': 'напред',
    'примједба': 'примедба', 'примјер': 'пример',
    'пријекор': 'прекор',
    'тијесно': 'тесно',
    'тјелесно': 'телесно', 'тјелесне': 'телесне',
    'бијес': 'бес', 'бијеснога': 'беснога',
    'двије': 'две',
    'дијелити': 'делити',
    'живјели': 'живели',
    'завјет': 'завет',
    'заповиједања': 'заповедања',
    'застарјело': 'застарело', 'застарјео': 'застарео',
    'исцијеђен': 'исцеђен',
    'колосијеку': 'колосеку',
    'лицемјерје': 'лицемерје',
    'лијечења': 'лечења',
    'медвјед': 'медвед',
    'мијења': 'мења', 'мијењају': 'мењају',
    'неизбјежан': 'неизбежан',
    'неријешену': 'нерешену',
    'обје': 'обе',
    'одријешеном': 'одрешеном', 'одријешену': 'одрешену',
    'одсјек': 'одсек',
    'оклијевати': 'оклевати', 'оклијевање': 'оклевање',
    'предсједника': 'председника',
    'преживјети': 'преживети',
    'пријеваром': 'преваром',
    'пријетећи': 'претећи', 'пријетити': 'претити', 'пријетњи': 'претњи',
    'промјена': 'промена',
    'проповијед': 'проповед',
    'пјевни': 'певни',
    'сврбјети': 'сврбети',
    'свјеже': 'свеже',
    'смијех': 'смех',
    'смјелост': 'смелост', 'смјестити': 'сместити',
    'сусједним': 'суседним',
    'сједне': 'седне',
    'умјерен': 'умерен',
    'цвјетати': 'цветати',
    'цјелину': 'целину',
    'цјепидлачити': 'цепидлачити',

    # the four that are vocabulary rather than spelling - see the docstring
    'умјетна': 'вештачка',
    'лијечнички': 'лекарски',
    'повијесно': 'историјски',
    'протурјечност': 'противречност',

    # The reflex that has no `је` in it at all, and so was invisible to the
    # first sweep: jat before `o` gives ijekavian `ио` where ekavian has `ео`.
    # `сваки дио` sat in the middle of an otherwise converted sentence.
    'дио': 'део',
    'донио': 'донео',
    # jekavian jotation, дј -> ђ: one step further from ekavian than the rest
    'ођедном': 'одједном',
    'ђеце': 'деце',
    'штеђети': 'штедети',
}

# Matched by the reflex sweep and correct as they stand.
KEEP = {
    'није', 'касније', 'лаконије', 'иједног', 'клијентовом', 'нације',
    'најчистијем', 'одјекнула', 'перорације', 'пијетистичко', 'прекрије',
    'речитије', 'сомелијеру', 'цикорије', 'божје',
    'набијеним', 'увијене', 'наречјем',
    # `лицемерје` is the *ekavian* form this tool writes, and `рје` in it
    # matches REFLEX all the same - the `је` is the neuter suffix on лицемер,
    # not a jat reflex. Without this the readback guard rejects the tool's own
    # output. Any future replacement ending in a consonant + `је` needs the
    # same line.
    'лицемерје',
    # and `одједном`, this tool's own replacement for `ођедном`, for the same
    # reason: `дје` in it is a prefix meeting a stem, not a reflex. Two of
    # these in one table is the pattern, not the coincidence - check every new
    # replacement against REFLEX before adding it.
    'одједном',

    # The `-ио` past participles, which look like the `дио`/`донио` reflex and
    # are not: a verb whose stem has no jat is spelled this way in both
    # varieties. Only a verb with jat in it - донијети/донети, видјети/видети -
    # takes `-ео` in ekavian. Reviewed one at a time on 2026-09-04.
    'био', 'водио', 'засладио', 'заслужио', 'изгубио', 'изненадио',
    'искоренио', 'исправио', 'испратио', 'обојио', 'објавио', 'одморио',
    'опростио', 'платио', 'погодио', 'подносио', 'положио', 'прелио',
    'препустио', 'прогласио', 'пузио', 'радио', 'размотрио', 'родио',
    'свалио', 'узнемирио', 'усудио', 'ухватио', 'хвалио',

    # `ђе` inside an ordinary word, which the ођедном/ђеце rule must not reach
    'дође', 'нађе', 'пређе', 'прође', 'уђе', 'чађе', 'грађе', 'оруђе',
    'наређења', 'непредвиђеним', 'подређени', 'рођен', 'суђење', 'погођен',
    'разређено', 'уграђено', 'утврђен', 'исцеђен', 'насмешио',
}

# Caught by the sweep, genuinely wrong, and deliberately not this tool's job.
# `такођер` is Croatian for `такође` - vocabulary rather than a jat reflex, and
# the same class as `обрана`, `успркос`, `упораба` and `раби`, which the sweep
# does not happen to match. Filing it under KEEP would be a lie, since KEEP
# means correct; it gets its own name so the count stays honest and so the run
# says out loud what it is walking past.
OUT_OF_SCOPE = {
    'такођер',
}

# `је` after a consonant is the common reflex; `ио`-final and `ђе` are the two
# shapes the first sweep missed entirely, and both are in here so that an
# undecided one stops the run rather than passing in silence.
REFLEX = re.compile(r'[бвгдзклмнпрстцчшђћжс]је|ије|љје|њје|ио$|ђе')
TOKEN = re.compile(r'[Ѐ-ӿ]+')

# one alternation, longest first, so `ријечима` is not eaten by `ријеч`, and
# anchored either side so it can only ever match a whole word
_SUB = re.compile(
    r'(?<![Ѐ-ӿ])(%s)(?![Ѐ-ӿ])'
    % '|'.join(sorted(EKAVIAN, key=len, reverse=True)),
    re.IGNORECASE)


def _match_case(source, replacement):
    """Give `replacement` the capitalisation `source` was written with."""
    if source[:1].isupper():
        return replacement[:1].upper() + replacement[1:]
    return replacement


def convert(text):
    """Apply the map to one string, whole words only."""
    if not isinstance(text, str):
        return text, 0
    tally = [0]

    def swap(match):
        word = match.group(0)
        target = EKAVIAN.get(word.lower())
        if target is None:
            return word
        tally[0] += 1
        return _match_case(word, target)

    return _SUB.sub(swap, text), tally[0]


def walk(value):
    """Convert a string, or every string in a list."""
    if isinstance(value, list):
        total, out = 0, []
        for item in value:
            new, count = walk(item)
            out.append(new)
            total += count
        return out, total
    return convert(value)


def unresolved(blob):
    """Reflex tokens in `blob` that are neither mapped nor deliberately kept."""
    left = set()
    for token in TOKEN.findall(blob):
        low = token.lower()
        if (REFLEX.search(low) and low not in KEEP and low not in EKAVIAN
                and low not in OUT_OF_SCOPE):
            left.add(low)
    return left


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true',
                        help='report what would change and write nothing')
    args = parser.parse_args()
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')

    with open(OVERLAY, encoding='utf-8') as handle:
        overlay = json.load(handle)
    with open(RECORD, encoding='utf-8') as handle:
        record = json.load(handle)

    # Every reflex token must have been decided one way or the other. A token
    # nobody has ruled on stops the run rather than being silently skipped.
    both = (json.dumps(overlay, ensure_ascii=False)
            + json.dumps(record, ensure_ascii=False))
    left = unresolved(both)
    if left:
        sys.exit('undecided reflex tokens; add each to EKAVIAN or to KEEP:\n  '
                 + '\n  '.join(sorted(left)))

    rows = (overlay['words']
            if isinstance(overlay, dict) and 'words' in overlay else overlay)
    items = (list(rows.items()) if isinstance(rows, dict)
             else [(row.get('id'), row) for row in rows])

    words, cells = 0, []
    for word_id, row in items:
        for field in FIELDS:
            if field not in row:
                continue
            new, count = walk(row[field])
            if count:
                cells.append('%s/%s' % (word_id, field))
                words += count
                row[field] = new

    rec_words, rec_cells = 0, []
    for key in ('glosses', 'friendly', 'definitions'):
        table = record.get(key)
        if not isinstance(table, dict):
            continue
        for word_id, text in list(table.items()):
            new, count = walk(text)
            if count:
                rec_cells.append('%s/%s' % (word_id, key))
                rec_words += count
                table[word_id] = new

    walked_past = sorted(t for t in OUT_OF_SCOPE
                         if t in {x.lower() for x in TOKEN.findall(both)})
    if walked_past:
        print('left alone, wrong but not this job: %s' % ', '.join(walked_past))
    print('overlay : %d words in %d cells' % (words, len(cells)))
    print('record  : %d words in %d cells' % (rec_words, len(rec_cells)))
    if args.check:
        for cell in cells:
            print('   ', cell)
        return

    # LF and a trailing newline, the way every other overlay is written -
    # `emit_from_data.py` wrote CRLF here once and turned a 142-cell edit into
    # a 2,956-line diff.
    # A file this pass did not change is left exactly as it was. Rewriting it
    # would re-flow the JSON and put a formatting-only diff in the commit -
    # `english_ok` came back as a three-line array the first time round, in a
    # file whose content had not moved at all.
    for path, blob, count in ((OVERLAY, overlay, words),
                              (RECORD, record, rec_words)):
        if not count:
            continue
        text = json.dumps(blob, ensure_ascii=False, indent=2) + '\n'
        with open(path, 'w', encoding='utf-8', newline='\n') as handle:
            handle.write(text)

    # Read back and prove it: no undecided reflex left, and no mapped token
    # still standing anywhere in either file.
    again = ''
    for path in (OVERLAY, RECORD):
        with open(path, encoding='utf-8') as handle:
            again += handle.read()
    still = unresolved(again)
    unconverted = {t.lower() for t in TOKEN.findall(again)
                   if t.lower() in EKAVIAN}
    if still or unconverted:
        sys.exit('read back with reflexes still in it: %s'
                 % sorted(still | unconverted))
    print('read back clean')


if __name__ == '__main__':
    main()
