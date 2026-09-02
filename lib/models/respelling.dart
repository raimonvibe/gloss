/// A respelling as a voice should hear it.
///
/// The 134 respellings mark stress in capitals — `HEB-ih-tood`,
/// `PYOO-tuh-tiv`, `ee-DUL-cor-ate`. That is a convention for the eye, and no
/// text-to-speech engine reads stress out of it; what an engine does with a
/// short run of capitals is spell it, so the guide that was meant to teach
/// *hebetude* says "aitch ee bee" and then "tood". Every voice in the app was
/// doing this, on every word with a one-syllable stress, because the capitals
/// reached the engine exactly as they were written.
///
/// So the voice is handed the syllables in lower case. The page keeps the
/// capitals it was written with — this is only what goes to the engine.
///
/// Hyphens are turned into spaces for the same class of reason: a voice reads
/// a hyphen as a pause, or as the word "dash", and neither belongs in the
/// middle of a word being sounded out.
String spokenRespelling(String respelling) {
  return respelling
      .split(_between)
      .where((syllable) => syllable.isNotEmpty)
      .map(_unshout)
      .map(spokenSyllable)
      .join(' ');
}

/// The syllables an engine spells instead of saying, and the spelling to hand
/// it in place of each.
///
/// Lower case was half the problem. The other half is that a syllable is not a
/// word: an engine handed one guesses from the spelling, and for a fragment it
/// has never seen the guess is often the letter names. `ih` comes out
/// "eye-aitch", so *hebetude* was read "heb eye-aitch tood"; `uk` comes out
/// "U.K.", so *paroxysm* was read "par U.K. siz um"; `cor`, `par`, `ret` and
/// twenty others go the same way. Forty-eight of the 134 respellings had at
/// least one syllable in them that was being spelled rather than said.
///
/// **No rule about the spelling predicts which ones.** `par` is spelled and
/// `tuh` is not; `ih` is spelled and `dih` is not. It is a property of the
/// engine's dictionary, not of English, so the table below is not reasoned
/// out — it is measured. `tool/probe_respellings.ps1` asks a speech engine
/// what it does with every syllable in the lexicon and writes its verdicts to
/// `tool/respelling_probe.json`; every entry here answers a verdict in that
/// file, and every replacement was chosen by reading back the phonemes the
/// engine gives it against a calibration word (`bit` for /ɪ/, `bat` for /æ/,
/// `but` for /ʌ/, and so on).
///
/// The comment on each line is the sound the replacement was measured to
/// produce, and the word it was measured against.
const Map<String, String> _spokenSyllables = {
  // Two-letter fragments read as letter names.
  'ak': 'ack', //   /ak/ as in back      Actuate
  'ap': 'app', //   /ap/ as in cap       Aporetic, Apposite
  // 'ee' is deliberately NOT substituted. SAPI reads it as two beats and
  // `eeh` as one, so the table sent `eeh` — and Google's Android engine
  // spells that, "ee ee aitch", heard in *Emendation* on a phone. `ee` is
  // the safer bet even when an engine spells it, because the letter E is
  // already the sound the syllable wants; `eeh` adds an H that is audibly
  // wrong. Where the desktop probe and the reader's phone disagree, the
  // phone wins.
  'ek': 'eck', //   /ek/ as in deck      Expatiate, Extant, Excoriate, Execrate
  'ig': 'ihg', //   /ig/ as in big       Ignavia
  'ih': 'ihh', //   /i/  as in bit       13 words, Hebetude among them
  'im': 'ihmm', //  /im/ as in him       Inimical, Imbroglio
  'ir': 'ihhr', //  /ir/ as in mirror    Irrefragable
  'ob': 'obb', //   /ob/ as in rob       Obloquy
  'od': 'odd', //   /od/ as in odd       Theodicy
  'ol': 'awl', //   /awl/ as in all      Neologism
  'uk': 'uck', //   /uk/ as in luck      Paroxysm — was read "U.K."

  // Longer fragments the engine has no entry for.
  'cor': 'core', // /kor/ as in core     Edulcorate
  'guh': 'gah', //  /gah/ as in ah       Nugatory
  'koh': 'koe', //  /koh/ as in toe      Inchoative, Pococurante
  'luh': 'lah', //  /lah/ as in ah       Effloresce, Obloquy
  'pab': 'pabb', // /pab/ as in cab      Pabulum
  'par': 'parre', // /par/ as in bat + r Parry, Parsimony, Paroxysm
  'pid': 'pidd', // /pid/ as in bid      Torpid
  'ret': 'rett', // /ret/ as in bet      Aporetic
  'rih': 'rihh', // /ri/  as in rip      Redound
  'vid': 'vidd', // /vid/ as in bid      Invidious

  // A lone `y` is a vowel to a reader and a consonant to the rules.
  'sy': 'sigh', //  /sy/ as in sigh      Sciolist — was read "ess-why"
  'vy': 'vye', //   /vy/ as in my        Vituperation — was read "vee-why"
  //
  // These three the probe's engine reads correctly, and `pie`/`fie`/`tie` come
  // out as the very same audio, byte for byte. They are here because the
  // engine on a reader's phone is a different one: *pietistic* was reported
  // from a device opening on the letter "pee", which is the fault above in an
  // engine this probe cannot reach. A replacement that is an ordinary English
  // word is the one thing no engine has to guess at, so it costs nothing here
  // and settles it there.
  'py': 'pie', //   /py/ as in pie       Pietistic
  'fy': 'fie', //   /fy/ as in pie       Fructify, Reify
  'ty': 'tie', //   /ty/ as in pie       Tyro
};

/// The syllable as the voice should be given it. A syllable no engine has been
/// caught spelling comes back untouched.
String spokenSyllable(String syllable) =>
    _spokenSyllables[syllable] ?? syllable;

/// Whatever separates one syllable from the next: the hyphens the respellings
/// are written with, and the spaces the two-word ones already carry.
final RegExp _between = RegExp(r'[-\s]+');

/// Lower-case a syllable that is shouted, and leave every other one alone.
///
/// A syllable already in lower case comes back untouched, so this is safe to
/// run over a respelling that never shouted in the first place.
String _unshout(String syllable) =>
    syllable == syllable.toUpperCase() ? syllable.toLowerCase() : syllable;
