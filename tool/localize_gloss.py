# -*- coding: utf-8 -*-
"""Put the English headword of a translated field into the reader's language.

It began with `exampleGloss`, which had always kept the English headword
standing inside it - the Dutch for *Soporific* read "De **soporific** dreun van
de lezing" - and now reads "De **slaapverwekkende** dreun van de lezing".

`exampleGloss` was never the only field this can happen in, and on 2026-09-03 a
reader met it under *in gewone woorden* instead: "aan een **ineluctable**
uitkomst wring je je niet los". So this carries three fields now, from one file
per locale, under the same checks:

    glosses      -> exampleGloss     the example sentence
    friendly     -> friendly         the plain-words explanation
    definitions  -> definition       the definition

`tool/english_in_translation.py` is what says which of them a locale still owes.

    python tool/localize_gloss.py --locale nl --check   # say what would change
    python tool/localize_gloss.py --locale nl           # write it

Each map holds the **whole new text** per word id rather than a word to swap
in. Swapping a word in mechanically cannot work across sixty languages - the
local word has to be inflected for the slot it lands in, and agreement, case
and word order differ - so the text is written out and this checks it rather
than builds it.

What it checks, before writing anything:

  * every id is a real word, and every one of the 134 is accounted for
  * no English form of the headword is left standing, except where the file
    says so - two Dutch words genuinely are the English ones (*mathesis*,
    *imbroglio*, both in Van Dale)
  * the quotations that ARE the specimen are still there, letter for letter,
    wherever the English field itself carries one. "Between you and I" is the
    thing being examined, and translating it would leave the entry showing
    nothing. See tool/gloss_english.py.
  * the text still ends in a full stop, question mark or closing quote, and
    its quotation marks still pair up

**A mention is not a use, and only `friendly` and `definition` may carry one.**
An explanation sometimes names an English word *as* English - *Dint* survives
in the phrase "by dint of", *Fricaseed* is the misspelling of "fricasseed",
*Ingenuous* is the word sixty explanations tell apart from "ingenious" - and
translating those empties the sentence out. English inside quotation marks is
allowed in those two fields for that reason. An example **sentence** has no
such business: there the local word does the work, quoted or not.

**Where a locale has a tool/_data_<locale>.py, that file is the source** and
this refuses to touch the overlay, because the next `emit_from_data.py` would
throw the edit away. 23 of the 60 locales have no such file - nl, de, fr, es,
it, pt, ru, pl, uk and the rest of Europe - and for those the overlay is the
artefact and this writes it directly.

**Ten of those 23 have a `tool/_words_<locale>.py` all the same**, which is a
second generator nobody had noticed: `write_words_western.py` builds nl, de,
fr, es, it, pl, pt and the three regional variants from those files. They were
already stale by the whole of the example-sentence work - 130 to 134 rows each
in nl, de, fr, es and it - so a single run of that script would have quietly
undone all six locales. This rewrites `_words_<locale>.py` alongside the
overlay so the two cannot drift again. It only ever rewrites a file it can
reproduce byte for byte from its own current contents first: `_words_es_419`,
`_words_fr_CA` and `_words_pt_BR` derive their rows from a base locale by
substitution rather than listing them, and are left alone.
"""
import argparse
import importlib
import io
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import english_in_translation  # noqa: E402
import gloss_english  # noqa: E402

# The map in `gloss_local_<locale>.json`, the overlay field it writes, and the
# English field it answers to. `glosses` keeps its name because six locales
# already carry one.
CARRIES = (
    ('glosses', 'exampleGloss', 'example'),
    ('friendly', 'friendly', 'friendly'),
    ('definitions', 'definition', 'def'),
)

# Where the local word does the work whatever the punctuation. See the note on
# mentions above.
NO_MENTIONS = {'exampleGloss'}

# The position of each field in a `tool/_words_<locale>.py` row, which is
# (definition, friendly, exampleGloss, root1, root2).
WORDS_PY_SLOT = {'definition': 0, 'friendly': 1, 'exampleGloss': 2}

# The seven that cannot be translated, and why: each one is the phenomenon
# itself rather than something a person happened to say. Kept in step with the
# guard in test/text_quality_test.dart.
SPECIMENS = {
    'amphiboly': 'Visiting relatives can be tiring',
    'euphonious': 'Murmuring brook',
    'tautology': 'It is what it is',
    'solecism': 'Between you and I',
    'laconism': 'Molon labe',
    'metonymy': 'Wall Street had a rough day',
    'specious': "Everyone's doing it",
}

# How many missing ids are worth naming before the list becomes a census.
_NAME_GAPS = 20

_QUOTES = re.compile(r'["“”„«»]')


def _blank(text, phrase):
    """`text` with `phrase` replaced by spaces, so what is left can be read."""
    at = text.lower().index(phrase.lower())
    return text[:at] + ' ' * len(phrase) + text[at + len(phrase):]


def _check(wid, field, text, english, forms, allowed, faults):
    """Everything that can be decided about one new piece of text."""
    if not text.strip():
        faults.append('%s.%s: empty' % (wid, field))
        return

    # The specimen quotation is required only where the English field itself
    # carries one: `amphiboly`'s example *and* its plain-words line both quote
    # "Visiting relatives can be tiring", where `euphonious` quotes "Murmuring
    # brook" in the example alone.
    outside = text
    phrase = SPECIMENS.get(wid)
    if phrase and english and phrase.lower() in english.lower():
        if phrase.lower() not in text.lower():
            faults.append('%s.%s: the specimen %r was translated away'
                          % (wid, field, phrase))
        else:
            outside = _blank(outside, phrase)
    elif phrase and phrase.lower() in outside.lower():
        outside = _blank(outside, phrase)

    if wid not in allowed:
        for match in gloss_english._pattern(forms[wid]).finditer(outside):
            quoted = english_in_translation._quoted(outside, match.start(),
                                                    match.end())
            if quoted and field not in NO_MENTIONS:
                continue
            faults.append('%s.%s: English left standing: %r%s'
                          % (wid, field, match.group(0),
                             ' (quoting it does not help here)'
                             if quoted else ''))

    if len(_QUOTES.findall(text)) % 2:
        faults.append('%s.%s: a quotation never closes' % (wid, field))
    if text != text.strip() or '  ' in text:
        faults.append('%s.%s: stray space' % (wid, field))
    if '\\' in text:
        faults.append('%s.%s: a stray escape' % (wid, field))
    # What counts as the end of a sentence, across sixty languages. German
    # closes a quotation with the character Dutch opens one with („…“ against
    # „…”), Japanese and Chinese end on 。, Hindi on ।, Urdu on ۔, Armenian
    # on ։. A list built from English habits rejects correct text in half of
    # them - which is how this first ran.
    if text[-1] not in '.!?…”“"’»«›」』。！？।॥۔؟։':
        faults.append('%s.%s: does not end on a full stop, it ends on %r'
                      % (wid, field, text[-1]))


def _words_py(locale):
    """`tool/_words_<locale>.py`, if it is a plain table this can rewrite.

    Returns the path and the header line, or (None, None). The test is that
    the file can be reproduced byte for byte from the table it defines: the
    three regional variants build their rows from a base locale instead of
    listing them, and fail it.
    """
    path = os.path.join(ROOT, 'tool', '_words_%s.py' % locale)
    if not os.path.exists(path):
        return None, None
    source = io.open(path, encoding='utf-8').read()
    module = importlib.import_module('_words_%s' % locale)
    header = source.split('\n')[0]
    if _render(header, module.WORDS) != source:
        return None, None
    return path, header


def _render(header, table):
    out = [header, 'WORDS = {']
    for wid, row in table.items():
        out.append('    "%s": (' % wid)
        for cell in row:
            out.append('        "%s",'
                       % cell.replace('\\', '\\\\').replace('"', '\\"'))
        out.append('    ),')
    out.append('}')
    return '\n'.join(out) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--locale', required=True)
    ap.add_argument('--check', action='store_true',
                    help='report and write nothing')
    args = ap.parse_args()
    locale = args.locale

    generated = os.path.join(ROOT, 'tool', '_data_%s.py' % locale)
    if os.path.exists(generated):
        sys.exit('%s is generated from tool/_data_%s.py - edit that and run '
                 'emit_from_data.py, or this edit is thrown away on the next '
                 'emit' % (locale, locale))

    source = os.path.join(ROOT, 'tool', 'gloss_local_%s.json' % locale)
    if not os.path.exists(source):
        sys.exit('no %s' % source)
    given = json.load(io.open(source, encoding='utf-8'))

    overlay_path = os.path.join(ROOT, 'assets/l10n/words_%s.json' % locale)
    overlay = json.load(io.open(overlay_path, encoding='utf-8'))

    words, forms = gloss_english.english_forms()
    by_id = {w['id']: w for w in words}
    # Words whose local rendering *is* the English one. Named in the file so
    # that "English left standing" stays an error everywhere else.
    allowed = set(given.get('english_ok', []))

    faults = []
    written = {}
    for key, field, english_field in CARRIES:
        new = given.get(key)
        if not new:
            continue
        unknown = set(new) - set(by_id)
        if unknown:
            faults.append('%s: ids that are not words: %s'
                          % (key, sorted(unknown)))
        changed = 0
        for wid, text in new.items():
            row = overlay['words'].get(wid)
            if row is None:
                faults.append('%s.%s is not in the overlay' % (wid, field))
                continue
            _check(wid, field, text, by_id[wid].get(english_field, ''),
                   forms, allowed, faults)
            if row.get(field) != text:
                changed += 1
        written[field] = new
        missing = [w['id'] for w in words if w['id'] not in new]
        print('%s: %s, %d of %d given, %d different from what ships'
              % (locale, field, len(new), len(words), changed))
        # A field carried for a handful of words is the ordinary case now, so
        # name the gaps only while they are still a list rather than a census.
        if missing and len(missing) <= _NAME_GAPS:
            print('  not given (%d, left as they are): %s'
                  % (len(missing), ', '.join(missing)))
        elif missing:
            print('  not given: %d, left as they are' % len(missing))

    if not written:
        sys.exit('%s carries none of %s'
                 % (source, ', '.join(k for k, _, _ in CARRIES)))
    if allowed:
        print('  English allowed to stand (the local word is the same): %s'
              % ', '.join(sorted(allowed)))

    if faults:
        print('\n%d fault(s), nothing written:' % len(faults))
        for f in faults:
            print('  ' + f)
        sys.exit(1)
    print('  checks pass')

    if args.check:
        print('  --check, so nothing written')
        return

    for field, new in written.items():
        for wid, text in new.items():
            overlay['words'][wid][field] = text
    with io.open(overlay_path, 'w', encoding='utf-8', newline='\n') as fh:
        json.dump(overlay, fh, ensure_ascii=False, indent=2)
        fh.write('\n')
    print('  written to assets/l10n/words_%s.json' % locale)

    # And the second generator, so a `write_words_western.py` run cannot undo
    # any of this. See the note at the top.
    path, header = _words_py(locale)
    if path is None:
        return
    module = importlib.import_module('_words_%s' % locale)
    table = {wid: list(row) for wid, row in module.WORDS.items()}
    for field, new in written.items():
        slot = WORDS_PY_SLOT[field]
        for wid, text in new.items():
            if wid in table:
                table[wid][slot] = text
    # Everything else in the overlay too, so the file stops being stale in
    # ways this run did not cause.
    for wid, row in table.items():
        overlay_row = overlay['words'].get(wid)
        if not overlay_row:
            continue
        for field, slot in WORDS_PY_SLOT.items():
            row[slot] = overlay_row.get(field, row[slot])
        row[3:5] = overlay_row.get('rootMeanings', row[3:5])
    with io.open(path, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(_render(header, table))
    print('  and to tool/_words_%s.py, which write_words_western.py reads'
          % locale)


if __name__ == '__main__':
    main()
