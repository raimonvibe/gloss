# -*- coding: utf-8 -*-
"""Write tool/_data_zh.py and tool/_data_zh_HK.py from tool/_data_zh_TW.py.

The three Chinese locales are one job and two derivations, which is worth
knowing before treating them as three. Measured on 2026-09-03, over all 670
cells of the shipped generators:

  * `zh` is **exactly** `opencc tw2sp` of `zh_TW` - script and mainland
    vocabulary both (`計程車` -> `出租车`, `印表機` -> `打印机`,
    `專案` -> `项目`). Nought mismatches.
  * `zh_HK` is **exactly** `zh_TW` under the twelve substitutions in [RULES].
    Nought mismatches.

So Taiwan is the base: localise it by hand and run this, and the other two
follow by construction rather than by diligence. That is the lesson
`pt_BR` taught - see CLAUDE.md, "But a pair diff cannot see a word that was
not there" - applied before the work rather than after it.

    python tool/derive_chinese.py --check   # prove the rules still hold
    python tool/derive_chinese.py           # write both, then emit all three

`--check` compares against what is on disk and writes nothing. Run it before
localising `zh_TW`, so that a rule which has quietly stopped holding is found
while the base is still the text the rules were measured on.

**Only the five ROWS fields are derived.** `partOfSpeech` and `origin` come
from `tool/_pos_origin.py`, which already carries Hong Kong's `意大利語` for
Taiwan's `義大利語`, so nothing here needs to know about them.

OpenCC is not in the repo's dependencies and is not needed to build the app;
it is needed to run this. `pip install opencc-python-reimplemented`.
"""
import argparse
import importlib
import io
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import emit_from_data  # noqa: E402

for stream in (sys.stdout, sys.stderr):
    try:
        stream.reconfigure(encoding='utf-8', errors='replace')
    except (AttributeError, ValueError):
        pass

# Taiwan -> Hong Kong, longest first so that 什麼 is settled before 裡.
#
# Every one of these was read off the shipped pair rather than reasoned
# about, and together they reproduce all 670 cells of `_data_zh_HK.py`. The
# first four are vocabulary, the rest are the two orthographic habits that
# separate the two: 裏 for 裡, and 甚麼 for 什麼.
RULES = [
    ('計程車', '的士'),      # taxi
    ('印表機', '打印機'),    # printer
    ('義大利', '意大利'),    # Italy
    ('讓我們', '不如我們'),  # "let us", which Hong Kong softens
    ('什麼', '甚麼'),
    ('公車', '巴士'),        # bus
    ('週日', '星期日'),      # Sunday
    ('飯店', '酒店'),        # hotel
    ('線上', '網上'),        # online
    ('專案', '項目'),        # project
    ('簡訊', '短訊'),        # text message
    ('裡', '裏'),
]


def to_hk(text):
    for taiwan, hong_kong in RULES:
        text = text.replace(taiwan, hong_kong)
    return text


def _converter():
    try:
        import opencc
    except ImportError:
        sys.exit('opencc is missing: pip install opencc-python-reimplemented')
    return opencc.OpenCC('tw2sp').convert


def _rows(locale):
    return [list(row) for row in
            importlib.import_module('_data_%s' % locale).ROWS]


def _render(header, rows):
    """The same layout localize_gloss.py writes, so the three agree on disk."""
    out = list(header)
    out.append('ROWS = [')
    for row in rows:
        cells = [json.dumps(cell, ensure_ascii=False) for cell in row]
        out.append('    (%s,' % cells[0])
        out.append('     %s,' % cells[1])
        out.append('     %s,' % cells[2])
        out.append('     %s, %s),' % (cells[3], cells[4]))
    out.append(']')
    return '\n'.join(out) + '\n'


def _header(locale, fallback):
    path = os.path.join(ROOT, 'tool', '_data_%s.py' % locale)
    if not os.path.exists(path):
        return fallback
    kept = []
    for line in io.open(path, encoding='utf-8').read().split('\n'):
        if not line.startswith('#'):
            break
        kept.append(line)
    return kept or fallback


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--check', action='store_true',
                    help='report and write nothing')
    args = ap.parse_args()

    convert = _converter()
    base = _rows('zh_TW')
    derived = {
        'zh': [[convert(cell) for cell in row] for row in base],
        'zh_HK': [[to_hk(cell) for cell in row] for row in base],
    }

    faults = 0
    for locale, rows in derived.items():
        current = _rows(locale)
        moved = sum(1 for a, b in zip(current, rows) for x, y in zip(a, b)
                    if x != y)
        print('%s: %d of %d cells differ from what is on disk'
              % (locale, moved, len(rows) * 5))
        if args.check and moved:
            faults += moved
    if args.check:
        if faults:
            print('\nthe derivation no longer reproduces the shipped files. '
                  'If zh_TW has just been localised that is expected; if it '
                  'has not, a rule has stopped holding.')
        else:
            print('\nboth derivations reproduce what ships, cell for cell')
        return

    for locale, rows in derived.items():
        path = os.path.join(ROOT, 'tool', '_data_%s.py' % locale)
        header = _header(locale, ['# derived from _data_zh_TW.py'])
        with io.open(path, 'w', encoding='utf-8', newline='\n') as fh:
            fh.write(_render(header, rows))
        # Read it back, like localize_gloss.py does: a file that imports and
        # holds the rows we meant is worth more than one that looks right.
        readback = [list(row) for row in
                    importlib.reload(
                        importlib.import_module('_data_%s' % locale)).ROWS]
        if readback != rows:
            sys.exit('_data_%s.py read back differently' % locale)
        print('  wrote tool/_data_%s.py' % locale)

    # And the written record, derived the same way, so that
    # english_in_translation.py knows `mathesis` is allowed to stand in these
    # two as well and localize_gloss.py --check can be run over them. This is
    # what pt_BR does with Portugal's text: generate the variant from the base
    # through the same rules, so the two agree by construction.
    base_source = os.path.join(ROOT, 'tool', 'gloss_local_zh_TW.json')
    if os.path.exists(base_source):
        given = json.load(io.open(base_source, encoding='utf-8'))
        for locale, change in (('zh', convert), ('zh_HK', to_hk)):
            out = {
                '_note': 'Derived from gloss_local_zh_TW.json by '
                         'tool/derive_chinese.py. Do not edit: edit Taiwan '
                         'and re-derive.',
                'english_ok': given.get('english_ok', []),
            }
            for key in ('glosses', 'friendly', 'definitions'):
                if key in given:
                    out[key] = {wid: change(text)
                                for wid, text in given[key].items()}
            path = os.path.join(ROOT, 'tool', 'gloss_local_%s.json' % locale)
            with io.open(path, 'w', encoding='utf-8', newline='\n') as fh:
                json.dump(out, fh, ensure_ascii=False, indent=2)
                fh.write('\n')
            print('  wrote tool/gloss_local_%s.json' % locale)

    for locale in ('zh_TW', 'zh', 'zh_HK'):
        emit_from_data.emit(locale)


if __name__ == '__main__':
    main()
