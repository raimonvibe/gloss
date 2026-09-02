# -*- coding: utf-8 -*-
"""Write an IPA pronunciation into every word, derived from its respelling.

Google's Android engine cannot say the words this lexicon is about: it holds
almost none of them and invents a reading from the spelling. A device probe on
2026-09-02 established that the engine honours SSML `<phoneme alphabet="ipa">`,
which the received wisdom said it would not, so the app can hand it the sound
instead of a spelling.

The IPA is derived from the respelling rather than fetched, for three reasons:
the respelling is what the page shows and so is the app's own authority; the
inflected forms in lib/models/spoken_forms.dart have respellings and no
dictionary entry; and eighteen of the 134 have no Wiktionary entry at all.

It was checked against Wiktionary all the same, and that check earned its keep:
it found five rule bugs (`eh` keeping its h, `tch`, `ye`, unstressed `-ar`,
unstressed `-ed`). What remains are rhotic and US/UK differences and the handful
of attested variants the pronunciation audit already knew about.

    python tool/emit_ipa.py            # rewrites assets/data/words.json
    python tool/emit_ipa.py --check    # fails if anything is out of date
"""
import io, json, re, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from _respelling_ipa import respelling_ipa

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORDS = os.path.join(ROOT, 'assets', 'data', 'words.json')

def main(check):
    raw = io.open(WORDS, encoding='utf-8').read()
    data = json.loads(raw)
    stale = []
    for word in data['words']:
        want = respelling_ipa(word['pronunciation'])
        if word.get('ipa') != want:
            stale.append(word['word'])
            word['ipa'] = want
    if check:
        if stale:
            print('out of date: %s' % ', '.join(stale))
            return 1
        print('every word carries the IPA its respelling implies')
        return 0
    out = json.dumps(data, ensure_ascii=False, indent=2) + '\n'
    io.open(WORDS, 'w', encoding='utf-8', newline='\n').write(out)
    print('wrote IPA for %d words (%d changed)' % (len(data['words']), len(stale)))
    return 0

if __name__ == '__main__':
    sys.exit(main('--check' in sys.argv))
