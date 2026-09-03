# -*- coding: utf-8 -*-
"""Put the headword of each example sentence into the reader's own language.

`exampleGloss` is the example sentence translated, and it has always kept the
English headword standing inside it - the Dutch for *Soporific* read "De
**soporific** dreun van de lezing". This replaces that with the local word:
"De **slaapverwekkende** dreun van de lezing".

    python tool/localize_gloss.py --locale nl --check   # say what would change
    python tool/localize_gloss.py --locale nl           # write it

It reads `tool/gloss_local_<locale>.json`, whose `glosses` map holds the whole
new sentence per word id rather than a word to swap in. Swapping a word in
mechanically cannot work across sixty languages - the local word has to be
inflected for the slot it lands in, and agreement, case and word order differ -
so the sentence is written out and this checks it rather than builds it.

What it checks, before writing anything:

  * every id is a real word, and every one of the 134 is accounted for
  * no English form of the headword is left standing, except where the file
    says so - two Dutch words genuinely are the English ones (*mathesis*,
    *imbroglio*, both in Van Dale)
  * the seven quotations that ARE the specimen are still there, letter for
    letter. "Between you and I" is the thing being examined, and translating
    it would leave the example showing nothing. See tool/gloss_english.py.
  * the sentence still ends in a full stop, question mark or closing quote,
    and its quotation marks still pair up

**Where a locale has a tool/_data_<locale>.py, that file is the source** and
this refuses to touch the overlay, because the next `emit_from_data.py` would
throw the edit away. 23 of the 60 locales have no such file - nl, de, fr, es,
it, pt, ru, pl, uk and the rest of Europe - and for those the overlay is the
artefact and this writes it directly.
"""
import argparse
import io
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import gloss_english  # noqa: E402

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

_QUOTES = re.compile(r'["“”„«»]')


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
    new = given['glosses']

    overlay_path = os.path.join(ROOT, 'assets/l10n/words_%s.json' % locale)
    overlay = json.load(io.open(overlay_path, encoding='utf-8'))

    words, forms = gloss_english.english_forms()
    by_id = {w['id']: w for w in words}
    # Words whose local rendering *is* the English one. Named in the file so
    # that "English left standing" stays an error everywhere else.
    allowed = set(given.get('english_ok', []))

    faults = []
    unknown = set(new) - set(by_id)
    if unknown:
        faults.append('ids that are not words: %s' % sorted(unknown))

    changed = 0
    for wid, sentence in new.items():
        row = overlay['words'].get(wid)
        if row is None:
            faults.append('%s is not in the overlay' % wid)
            continue
        if not sentence.strip():
            faults.append('%s: empty' % wid)
            continue

        # English left standing. The specimen quotation is blanked out first,
        # so the headword beside it is judged on its own.
        outside = sentence
        phrase = SPECIMENS.get(wid)
        if phrase:
            if phrase.lower() not in sentence.lower():
                faults.append('%s: the specimen %r was translated away'
                              % (wid, phrase))
            else:
                at = outside.lower().index(phrase.lower())
                outside = (outside[:at] + ' ' * len(phrase)
                           + outside[at + len(phrase):])
        left = gloss_english._pattern(forms[wid]).findall(outside)
        if left and wid not in allowed:
            faults.append('%s: English left standing: %s' % (wid, left))

        if _QUOTES.findall(sentence) and len(_QUOTES.findall(sentence)) % 2:
            faults.append('%s: a quotation never closes' % wid)
        if sentence != sentence.strip() or '  ' in sentence:
            faults.append('%s: stray space' % wid)
        if '\\' in sentence:
            faults.append('%s: a stray escape' % wid)
        # What counts as the end of a sentence, across sixty languages. German
        # closes a quotation with the character Dutch opens one with („…“
        # against „…”), Japanese and Chinese end on 。, Hindi on ।, Urdu
        # on ۔, Armenian on ։. A list built from English habits rejects
        # correct text in half of them - which is how this first ran.
        if sentence[-1] not in '.!?…”“"’»«›」』。！？।॥۔؟։':
            faults.append('%s: does not end on a full stop, it ends on %r'
                          % (wid, sentence[-1]))

        if row.get('exampleGloss') != sentence:
            changed += 1

    missing = [w['id'] for w in words if w['id'] not in new]
    print('%s: %d of %d sentences given, %d of them different from what ships'
          % (locale, len(new), len(words), changed))
    if missing:
        print('  not given (%d, left as they are): %s'
              % (len(missing), ', '.join(missing)))
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

    for wid, sentence in new.items():
        overlay['words'][wid]['exampleGloss'] = sentence
    with io.open(overlay_path, 'w', encoding='utf-8', newline='\n') as fh:
        json.dump(overlay, fh, ensure_ascii=False, indent=2)
        fh.write('\n')
    print('  written to assets/l10n/words_%s.json' % locale)


if __name__ == '__main__':
    main()
