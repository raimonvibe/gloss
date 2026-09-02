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
      .join(' ');
}

/// Whatever separates one syllable from the next: the hyphens the respellings
/// are written with, and the spaces the two-word ones already carry.
final RegExp _between = RegExp(r'[-\s]+');

/// Lower-case a syllable that is shouted, and leave every other one alone.
///
/// A syllable already in lower case comes back untouched, so this is safe to
/// run over a respelling that never shouted in the first place.
String _unshout(String syllable) =>
    syllable == syllable.toUpperCase() ? syllable.toLowerCase() : syllable;
