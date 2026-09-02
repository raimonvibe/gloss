# -*- coding: utf-8 -*-
import re
CONS = [('tch','tʃ'),('sh','ʃ'),('zh','ʒ'),('ch','tʃ'),('th','θ'),('ng','ŋ'),('ck','k'),
        ('ss','s'),('ff','f'),('ll','l'),('tt','t'),('dd','d'),('bb','b'),
        ('gg','ɡ'),('pp','p'),('nn','n'),('mm','m'),('rr','r'),('zz','z'),
        ('kw','kw'),('qu','kw'),('j','dʒ'),('g','ɡ'),('c','k'),('y','j'),
        ('b','b'),('d','d'),('f','f'),('h','h'),('k','k'),('l','l'),('m','m'),
        ('n','n'),('p','p'),('r','r'),('s','s'),('t','t'),('v','v'),('w','w'),
        ('x','ks'),('z','z')]
# A doubled r shortens the vowel before it, the way English spelling does:
# 'parr' is /pær/ where 'par' is /pɑːr/.
VOW_STRESSED = [('arr','ær'),('err','ɛr'),('irr','ɪr'),('orr','ɒr'),('urr','ʌr'),
       ('air','ɛər'),('eer','ɪər'),('oor','ʊər'),('yoo','juː'),('igh','aɪ'),
       ('ye','aɪ'),('ee','iː'),('ea','iː'),('oo','uː'),('oh','oʊ'),('ow','aʊ'),
       ('oy','ɔɪ'),('oi','ɔɪ'),('aw','ɔː'),('ah','ɑː'),('uh','ə'),('ih','ɪ'),
       ('eh','ɛ'),('ay','eɪ'),('ai','eɪ'),('ou','aʊ'),('oa','oʊ'),
       ('er','ɜːr'),('ur','ɜːr'),('ir','ɪr'),('or','ɔːr'),('ar','ɑːr'),
       ('a','æ'),('e','ɛ'),('i','ɪ'),('o','ɒ'),('u','ʌ')]
# Unstressed syllables reduce: -er, -ar, -or all become a schwa with r.
VOW_UNSTRESSED = [(a, b) for a, b in VOW_STRESSED]
for i, (a, b) in enumerate(VOW_UNSTRESSED):
    if a in ('er', 'ur', 'ar'):
        VOW_UNSTRESSED[i] = (a, 'ər')
    elif a == 'u':
        VOW_UNSTRESSED[i] = (a, 'ə')
LONG = {'a':'eɪ','i':'aɪ','o':'oʊ','u':'juː','e':'iː'}

def syllable_ipa(syl, stressed=True):
    s = syl.lower()
    vowels = VOW_STRESSED if stressed else VOW_UNSTRESSED
    # an unstressed -ed is /ɪd/, not /ɛd/
    # An unstressed -ed suffix is /ɪd/, not /ɛd/ — but only where it is a
    # suffix. 'seed' ends in 'ed' and is nothing of the kind.
    if not stressed and (s == 'ed' or
                         (s.endswith('ed') and len(s) > 2 and s[-3] not in 'aeiou')):
        s = s[:-2] + 'ihd'
    m = re.match(r'^([^aeiouy]*)([aeiou])([^aeiouy]+)e$', s)
    long_v = None
    if m and not s.endswith('ye'):
        s = m.group(1) + '\x00' + m.group(3)
        long_v = LONG[m.group(2)]
    elif re.match(r'^[^aeiouy]*y$', s):
        s = s[:-1] + '\x00'
        long_v = 'aɪ'
    out, i = '', 0
    while i < len(s):
        if s[i] == '\x00':
            out += long_v; i += 1; continue
        for pat, ipa in vowels:
            if s.startswith(pat, i):
                out += ipa; i += len(pat); break
        else:
            for pat, ipa in CONS:
                if s.startswith(pat, i):
                    out += ipa; i += len(pat); break
            else:
                out += s[i]; i += 1
    return out

def respelling_ipa(respelling):
    parts = [p for p in re.split(r'[-\s]+', respelling) if p]
    stressed = next((i for i, p in enumerate(parts)
                     if p == p.upper() and re.search('[A-Z]', p)), None)
    return ''.join(('ˈ' if i == stressed else '') + syllable_ipa(p, i == stressed)
                   for i, p in enumerate(parts))
