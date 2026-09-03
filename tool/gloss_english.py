# -*- coding: utf-8 -*-
"""The English still standing inside the sixty translated example sentences.

`exampleGloss` is the example sentence in the reader's own language, and it
keeps the English headword inside it: the Dutch for *Soporific* reads "De
**soporific** dreun van de lezing". That is the bilingual-dictionary model
working as designed - see CLAUDE.md - and it is also the thing a reader
notices, because the one word the sentence exists to explain is the one word
they cannot read.

Anyone weighing that up needs to know that **there are two kinds of English in
these sentences and only one of them can be translated**:

  headword   The word the entry is about, in whatever shape the sentence needs
             - *soporific*, *edulcorated*, *fructifies*. A translation can
             render it. 7,903 of the 8,040 glosses carry one.

  quotation  A phrase the example puts in quotation marks. Fourteen of the
             134 have one, and they are **not all the same kind of thing** -
             which is the finding worth having before touching any of this.

The sixty translations settle that second question themselves, and they agree
with each other without ever having been told to. Where the quotation *is* the
thing being examined it stays English in every locale; where it is merely
something a person said, about half the locales translate it:

    Visiting relatives can be tiring   amphiboly     60/60 kept
    Murmuring brook                    euphonious    60/60
    Between you and I                  solecism      60/60
    It is what it is                   tautology     60/60
    Molon labe                         laconism      60/60
    Wall Street had a rough day        metonymy      59/60
    Everyone's doing it                specious      58/60
    ------------------------------------------------------------
    I would fain rest here a while     fain          44/60 kept
    You clodpate,                      clodpate      37/60
    who Mom loves best                 invidious     34/60
    the true meaning of friendship     sententious   34/60
    excellent taste                    unctuous      34/60
    come and take them                 laconism      34/60
    why would anyone lie about that?   ingenuous     32/60
    unforeseen challenges              gloze         16/60

The top seven are the specimen: the ambiguity in "Visiting relatives can be
tiring", the redundancy of "It is what it is" and the bad grammar of "Between
you and I" exist in English and nowhere else, so a translation of them shows
the reader nothing. The bottom eight are reported speech and carry no such
weight. Sixty translators converged on that line unprompted, which is better
evidence that it is the right line than any rule this file could assert.

So **the whole sentence in the reader's language is reachable for 127 of the
134**, and for the other 7 everywhere except inside the quotation marks. The
bottom eight are a separate, smaller job: they are a coin flip per locale
today and should be settled one way.

    python tool/gloss_english.py                # the totals
    python tool/gloss_english.py --locale nl    # every row, to work from
    python tool/gloss_english.py --specimens    # the 14 and their quotations
"""
import argparse
import collections
import glob
import io
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# A quotation of two words or more. One word inside quotes is a scare quote or
# a term of art, not a specimen.
_QUOTED = re.compile(r'["“”«»„‘’]'
                     r'(.+?)'
                     r'["“”«»„‘’]')


def english_forms():
    """Every English shape of each word: headword, variants, inflections.

    The inflections come from `kSpokenForms`, which exists so speech can hand
    each of them back to the English voice; the same list is what a gloss may
    be carrying.
    """
    words = json.load(io.open(os.path.join(ROOT, 'assets/data/words.json'),
                              encoding='utf-8'))['words']
    dart = io.open(os.path.join(ROOT, 'lib/models/spoken_forms.dart'),
                   encoding='utf-8').read()
    forms = collections.defaultdict(set)
    table = dart.split('const kSpokenForms')[1].split('const kFormIpa')[0]
    for wid, body in re.findall(r"'([a-z-]+)': \{([^}]*)\}", table):
        forms[wid] |= {f for f, _ in re.findall(r"'([a-z]+)': '([A-Za-z-]+)'",
                                                body)}
    for w in words:
        forms[w['id']] |= ({w['word'].lower()}
                           | {v.lower() for v in w.get('variants', [])})
    return words, forms


def specimens(words):
    """The phrase each example quotes, where it quotes one."""
    out = {}
    for w in words:
        quoted = [q for q in _QUOTED.findall(w['example'])
                  if len(q.split()) >= 2]
        if quoted:
            out[w['id']] = quoted
    return out


def _pattern(forms):
    # Longest first, so `edulcorated` is not matched as `edulcorate` with a
    # stray d after it. Whole words only, in any script: the boundary is
    # "not a letter or a digit", which \b cannot express once the text around
    # it is Greek, Thai or Devanagari.
    ordered = sorted(forms, key=len, reverse=True)
    return re.compile(r'(?<![^\W\d_])(?:%s)(?![^\W\d_])'
                      % '|'.join(re.escape(f) for f in ordered),
                      re.IGNORECASE | re.UNICODE)


def scan():
    words, forms = english_forms()
    quoted = specimens(words)
    rows = []
    for path in sorted(glob.glob(os.path.join(ROOT, 'assets/l10n/words_*.json'))):
        locale = os.path.basename(path)[6:-5]
        overlay = json.load(io.open(path, encoding='utf-8'))['words']
        for w in words:
            row = overlay.get(w['id'])
            if not row:
                continue
            gloss = row.get('exampleGloss') or ''
            # Blank out the specimen quotation before looking for the
            # headword, so "a classic amphiboly" is counted and the quotation
            # it sits beside is not counted twice.
            outside = gloss
            kept = []
            for phrase in quoted.get(w['id'], []):
                if phrase.lower() in outside.lower():
                    kept.append(phrase)
                    at = outside.lower().index(phrase.lower())
                    outside = outside[:at] + ' ' * len(phrase) + \
                        outside[at + len(phrase):]
            hits = _pattern(forms[w['id']]).findall(outside)
            rows.append({
                'locale': locale,
                'id': w['id'],
                'gloss': gloss,
                'english': hits,
                'example': w['example'],
                'specimen_expected': quoted.get(w['id'], []),
                'specimen_kept': kept,
            })
    return words, quoted, rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--locale')
    ap.add_argument('--specimens', action='store_true')
    args = ap.parse_args()

    words, quoted, rows = scan()

    if args.specimens:
        print('%d of the 134 quote English as the specimen:\n' % len(quoted))
        for wid, phrases in quoted.items():
            print('  %-14s %s' % (wid, ' | '.join(phrases)))
        return

    if args.locale:
        mine = [r for r in rows if r['locale'] == args.locale]
        if not mine:
            sys.exit('no overlay for %r' % args.locale)
        for r in mine:
            if not r['english']:
                continue
            print('%s  [%s]' % (r['id'], ', '.join(r['english'])))
            print('   en: %s' % r['example'])
            print('   %s: %s' % (args.locale, r['gloss']))
        print('\n%d of %d glosses in %s carry the headword in English'
              % (sum(1 for r in mine if r['english']), len(mine), args.locale))
        return

    per_locale = collections.Counter()
    per_word = collections.Counter()
    for r in rows:
        if r['english']:
            per_locale[r['locale']] += 1
            per_word[r['id']] += 1
    locales = {r['locale'] for r in rows}
    print('%d locales x %d words = %d glosses'
          % (len(locales), len(words), len(rows)))
    print('  carrying the headword in English: %d (%.0f%%)'
          % (sum(per_locale.values()), 100.0 * sum(per_locale.values()) / len(rows)))
    print('  words that carry it in every locale: %d'
          % sum(1 for w in words if per_word[w['id']] == len(locales)))
    print('  words that never carry it: %d'
          % sum(1 for w in words if per_word[w['id']] == 0))
    print()
    fewest = sorted(per_locale.items(), key=lambda kv: kv[1])[:6]
    print('  locales that already translate some of it:', fewest)

    # How consistently each quoted phrase is left in English. A phrase near
    # 60 is the specimen and must stay; one near 30 is reported speech that
    # half the locales have already translated, and is worth settling.
    kept = collections.Counter()
    seen = collections.Counter()
    for r in rows:
        for phrase in r['specimen_expected']:
            seen[(r['id'], phrase)] += 1
            if phrase in r['specimen_kept']:
                kept[(r['id'], phrase)] += 1
    print()
    print('  quoted phrases, and how many of the sixty keep them in English:')
    ranked = sorted(seen, key=lambda k: -kept[k])
    for key in ranked:
        wid, phrase = key
        mark = 'specimen - must stay' if kept[key] >= 55 else 'reported speech'
        print('    %2d/%d  %-14s %-34s %s'
              % (kept[key], seen[key], wid, phrase[:32], mark))


if __name__ == '__main__':
    main()
