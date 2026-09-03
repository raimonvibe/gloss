# -*- coding: utf-8 -*-
"""Every English word left standing inside translated copy, in every field.

`tool/gloss_english.py` asked this question of `exampleGloss` alone, because
that is where it was first noticed. It is not where the problem lives. A
reader on 2026-09-03 met it under *in gewone woorden* instead:

    Het gebeurt hoe dan ook - aan een ineluctable uitkomst wring je je niet
    los.

The word an explanation exists to explain is the one word the reader cannot
read, and `exampleGloss` was never the only place that can happen. An overlay
has six translated fields and any of them can carry an English word; this
sweeps all six, in all sixty locales, and says which.

    python tool/english_in_translation.py               # the census
    python tool/english_in_translation.py --locale nl   # a worklist
    python tool/english_in_translation.py --word fain   # one word, all sixty
    python tool/english_in_translation.py --field friendly

**The census, and what it found.** The problem is nothing like as wide as it
was in the example sentences, and it is not evenly spread either. Measured on
2026-09-03, before any of it was fixed:

    exampleGloss   7103 / 8040   88%    a translation job, see gloss_english.py
    friendly        645 / 8040    8%    13 words, and the same 13 in each locale
    definition      131 / 8040    2%    7 words
    rootMeanings      4 / 16080   0%
    partOfSpeech      0 / 8040    0%    generated from tool/_pos_origin.py
    origin            0 / 8040    0%    generated from tool/_pos_origin.py

The two generated fields are clean and will stay clean, which is worth knowing:
a label written by a table cannot drift the way a sentence can. Everything else
is hand-written, and hand-written is where English survives.

`friendly` is a bounded job where `exampleGloss` is a large one - ten fields
per locale against 134 - and Dutch is the one locale that has had it done, on
the same day and by the same tool. Run this to see what the other 59 still owe.

**Quoted or bare is the line that matters, and it is mechanical.** The same
split `gloss_english.py` found in the example sentences runs through every
field, and here it can be measured rather than judged:

    a mention   The English word named *as* English, inside quotation marks.
                *Dint* is defined as the force in "by dint of" and *Fricaseed*
                as the misspelling of "fricasseed"; *Ingenuous* is the word
                sixty explanations tell apart from "ingenious". These must
                stay English - translating them empties the sentence out.

    a use       The English headword standing bare in a sentence of the
                reader's language, doing the work of a local word: "een
                trenchant opmerking", "een minatory blik". This is the bug.

Sorted that way the 646 come apart cleanly. Nine words are a use in all sixty
(*trenchant*, *minatory*, *euphonious*, *fiducial*, *ineluctable*, *mordant*,
*nugatory*, *redound*, *fructify*), and three are a mention in most and a use
in the rest - which is not a third category but a translation that dropped the
quotation marks its neighbours kept.

**Where it comes from.** In every one of those nine the *English* `friendly`
uses the headword in its own explanation - "a trenchant comment gets to the
heart of the matter" - and the sixty translations carried it across
faithfully. So the fault is inherited rather than invented, which is why it is
the same words everywhere, and why a locale cannot be blamed for it. This
prints the English line beside the local one for that reason.

A hit is not automatically wrong. Where the local word *is* the English one -
*mathesis* and *imbroglio* are both in Van Dale - the sentence is right and the
sweep has nothing to say. Those live in `english_ok` in
`tool/gloss_local_<locale>.json`, and this reads that list so an answered
question stays answered.
"""
import argparse
import collections
import glob
import io
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import gloss_english  # noqa: E402

# Every translated field an overlay carries. The first two are written by
# `tool/_pos_origin.py` from a table and the rest by hand; both are swept, so
# that "the generated ones are clean" stays a measurement rather than a claim.
FIELDS = (
    'partOfSpeech',
    'origin',
    'definition',
    'friendly',
    'exampleGloss',
    'rootMeanings',
)

# The English source field each one answers to, for printing side by side.
ENGLISH_FIELD = {
    'partOfSpeech': 'partOfSpeech',
    'origin': 'origin',
    'definition': 'definition',
    'friendly': 'friendly',
    'exampleGloss': 'example',
    'rootMeanings': None,
}

# Quotation marks, in the shapes the sixty use. German opens where Dutch
# closes and Japanese uses corner brackets, so this cannot be written from
# English habits - the same lesson localize_gloss.py learned about full stops.
QUOTES = ('"“”„‚«»‹›‘’'
          '「」『』＂')

# How far a quotation mark may stand from the word and still be quoting it.
# A citation is a word or a short phrase; a quotation mark half a paragraph
# away belongs to something else.
_REACH = 40

# How many words of a field the census prints before counting the rest.
_ROWS = 15


def _quoted(text, start, end):
    """Is the match at [start, end) inside a pair of quotation marks?"""
    before, after = text[:start], text[end:]
    left = max((before.rfind(q) for q in QUOTES), default=-1)
    right = min([p for p in (after.find(q) for q in QUOTES) if p >= 0],
                default=-1)
    if left < 0 or right < 0:
        return False
    return (len(before) - left) <= _REACH and right <= _REACH


def _allowed_forms():
    """Per locale, the words whose local rendering *is* the English one.

    Read from the `english_ok` list a locale's `gloss_local_*.json` already
    keeps, so a question answered once for the example sentences does not come
    back under a different field.
    """
    out = collections.defaultdict(set)
    for path in glob.glob(os.path.join(ROOT, 'tool/gloss_local_*.json')):
        locale = os.path.basename(path)[len('gloss_local_'):-len('.json')]
        given = json.load(io.open(path, encoding='utf-8'))
        out[locale] = set(given.get('english_ok', []))
    return out


def scan():
    """One row per English word found in a translated field."""
    words, forms = gloss_english.english_forms()
    specimens = gloss_english.specimens(words)
    allowed = _allowed_forms()

    rows = []
    cells = collections.Counter()
    locales = []
    for path in sorted(glob.glob(os.path.join(ROOT,
                                              'assets/l10n/words_*.json'))):
        locale = os.path.basename(path)[len('words_'):-len('.json')]
        locales.append(locale)
        overlay = json.load(io.open(path, encoding='utf-8'))['words']
        for word in words:
            row = overlay.get(word['id'])
            if row is None:
                continue
            pattern = gloss_english._pattern(forms[word['id']])
            for field in FIELDS:
                value = row.get(field) or ''
                values = value if isinstance(value, list) else [value]
                for index, text in enumerate(values):
                    cells[field] += 1
                    # The specimen quotation is blanked out first: it is a
                    # decided question, and the headword beside it has to be
                    # judged on its own. See gloss_english.py.
                    outside = text
                    for phrase in specimens.get(word['id'], []):
                        low = outside.lower()
                        if phrase.lower() in low:
                            at = low.index(phrase.lower())
                            outside = (outside[:at] + ' ' * len(phrase)
                                       + outside[at + len(phrase):])
                    for match in pattern.finditer(outside):
                        rows.append({
                            'locale': locale,
                            'id': word['id'],
                            'field': field,
                            'index': index,
                            'found': match.group(0),
                            'quoted': _quoted(outside, match.start(),
                                              match.end()),
                            'allowed': word['id'] in allowed.get(locale, ()),
                            'text': text,
                            'english': word.get(
                                ENGLISH_FIELD[field] or '', ''),
                        })
    return words, locales, cells, rows


def _verdict(bare, quoted):
    """What a word does across the sixty, in one phrase."""
    if bare and not quoted:
        return "a use - the headword doing a local word's work"
    if quoted and not bare:
        return 'a mention - English named as English, keep it'
    return ('a mention in %d and a use in %d - the quotation marks were '
            'dropped' % (quoted, bare))


def census(words, locales, cells, rows):
    live = [r for r in rows if not r['allowed']]
    print('%d locales x %d words' % (len(locales), len(words)))
    print()
    print('  field            carrying English            of')
    for field in FIELDS:
        hits = len({(r['locale'], r['id'], r['index'])
                    for r in live if r['field'] == field})
        print('    %-14s %8d %14d   %3.0f%%'
              % (field, hits, cells[field], 100.0 * hits / cells[field]))

    print()
    print('  by word, field by field. "bare" is a use and is the bug;')
    print('  "quoted" is a mention and must stay English.')
    per = collections.defaultdict(collections.Counter)
    for r in live:
        per[(r['field'], r['id'])]['quoted' if r['quoted'] else 'bare'] += 1
    for field in sorted(FIELDS,
                        key=lambda f: -sum(sum(per[k].values())
                                           for k in per if k[0] == f)):
        keys = sorted((k for k in per if k[0] == field),
                      key=lambda k: (-per[k]['bare'], -per[k]['quoted'], k))
        if not keys:
            continue
        print('\n  %s  (%d words)' % (field, len(keys)))
        # A field with the whole lexicon in it is a translation job rather
        # than a list to work through, so print the head of it and count the
        # tail. `--field <name>` prints the lot.
        for key in keys[:_ROWS]:
            counts = per[key]
            print('    %-16s bare %4d   quoted %4d   %s'
                  % (key[1], counts['bare'], counts['quoted'],
                     _verdict(counts['bare'], counts['quoted'])))
        if len(keys) > _ROWS:
            print('    ... and %d more words in this field'
                  % (len(keys) - _ROWS))


def worklist(rows, locale=None, word=None, field=None, show_quoted=False):
    picked = [r for r in rows
              if (locale is None or r['locale'] == locale)
              and (word is None or r['id'] == word)
              and (field is None or r['field'] == field)
              and (show_quoted or not r['quoted'])
              and not r['allowed']]
    if not picked:
        print('nothing to do')
        return
    seen = set()
    for r in sorted(picked, key=lambda r: (r['field'], r['id'], r['locale'])):
        key = (r['locale'], r['id'], r['field'], r['index'])
        if key in seen:
            continue
        seen.add(key)
        print('%s  %s.%s  [%s]%s'
              % (r['locale'], r['id'], r['field'], r['found'],
                 '  (quoted)' if r['quoted'] else ''))
        if r['english']:
            print('   en: %s' % r['english'])
        print('   %s: %s' % (r['locale'], r['text']))
        print()
    print('%d field(s) to rewrite' % len(seen))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--locale')
    ap.add_argument('--word')
    ap.add_argument('--field', choices=FIELDS)
    ap.add_argument('--quoted', action='store_true',
                    help='include the mentions, which are meant to be English')
    args = ap.parse_args()

    words, locales, cells, rows = scan()
    if args.locale or args.word or args.field:
        if args.locale and args.locale not in locales:
            sys.exit('no overlay for %r' % args.locale)
        worklist(rows, locale=args.locale, word=args.word, field=args.field,
                 show_quoted=args.quoted)
        return
    census(words, locales, cells, rows)


if __name__ == '__main__':
    main()
