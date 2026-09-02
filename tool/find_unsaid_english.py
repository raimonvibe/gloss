# -*- coding: utf-8 -*-
"""English words a translation keeps that the app has no way of saying.

The engine cannot pronounce the 134, so every English word that reaches a voice
needs an entry in lib/models/spoken_forms.dart. Three places keep one: the
headword, the English example sentence, and — the one that hid longest — a
translated sentence that quotes the English inside itself. `segmentTranslation`
cuts those out for the English voice, but only the terms `quotedEnglish` names.

This reads all sixty overlays and reports every standalone word that begins with
a headword's stem and is not already known. It cannot be a test, because most of
what it finds is the local language's own vocabulary — Spanish *ingenuo*, French
*mendiant*, Portuguese *fuligem* — which correctly stays with the local voice.
Telling those from real English needs an eye.

    python tool/find_unsaid_english.py
"""
import json, io, re, glob, os, collections

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def main():
    words = json.load(io.open(os.path.join(ROOT, 'assets/data/words.json'),
                              encoding='utf-8'))['words']
    dart = io.open(os.path.join(ROOT, 'lib/models/spoken_forms.dart'),
                   encoding='utf-8').read()
    known = collections.defaultdict(set)
    table = dart.split('const kSpokenForms')[1].split('const kFormIpa')[0]
    for wid, body in re.findall(r"'([a-z-]+)': \{([^}]*)\}", table):
        known[wid] |= {f for f, _ in re.findall(r"'([a-z]+)': '([A-Za-z-]+)'", body)}
    for w in words:
        known[w['id']] |= {w['word'].lower()} | {v.lower() for v in w.get('variants', [])}

    seen = collections.Counter()
    where = {}
    paths = sorted(glob.glob(os.path.join(ROOT, 'assets/l10n/words_*.json')))
    for path in paths:
        loc = os.path.basename(path)[6:-5]
        overlay = json.load(io.open(path, encoding='utf-8'))
        rows = overlay['words'] if isinstance(overlay, dict) and 'words' in overlay else overlay
        rows = rows if isinstance(rows, list) else list(rows.values())
        if len(rows) != len(words):
            continue
        for w, row in zip(words, rows):
            stem = w['word'].lower()[:5]
            if len(stem) < 5 or not isinstance(row, dict):
                continue
            text = ' '.join(v for v in row.values() if isinstance(v, str))
            for m in re.finditer(r'\b(%s[a-zA-Z]*)\b' % re.escape(stem), text, re.I):
                form = m.group(1).lower()
                if form not in known[w['id']]:
                    seen[(w['word'], form)] += 1
                    where.setdefault((w['word'], form), loc)
    print('%d locales, %d forms not in kSpokenForms\n' % (len(paths), len(seen)))
    for (word, form), n in seen.most_common():
        print('  %-16s %-22s %2d locales (first seen in %s)' % (word, form, n, where[(word, form)]))
    print('\nMost of these are the local language, not English. Add only the ones')
    print('that are really English, with a respelling, to kSpokenForms.')

if __name__ == '__main__':
    main()
