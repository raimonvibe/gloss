/// What a voice should be handed when the page names where a word came from.
///
/// Most of the sixty write "Old English" closed, as one word — Dutch
/// *Oudengels*, German *Altenglisch*, Danish *oldengelsk* — and an engine
/// handed a compound it has no entry for guesses at it from the spelling.
/// A Dutch voice read *Oudengels* as one mangled word where *Oud engels* is
/// two it already knows. This is the same lesson as the respellings: the page
/// keeps the spelling, which is the correct one, and the voice is handed the
/// parts.
///
/// **The seam is derived, not listed.** The language names a locale uses are
/// the simple origin labels it uses elsewhere in the same lexicon — *Engels*,
/// *Frans*, *Latijn* — so a label that ends in one of them and is longer than
/// it is a compound whose seam is exactly there. Nothing here knows a word of
/// Dutch, and nothing has to be written again for the fifty-nine: a locale
/// that already writes the two words apart never matches, and one that
/// compounds differently splits at its own base. Compare `_spokenSyllables`,
/// which could not be derived and had to be measured one at a time.
///
/// **Scripts that do not put spaces between words are left out.** Japanese
/// 古英語 ends in 英語 and is nonetheless one word to a Japanese voice; a
/// space inside it would be an error rather than a hint.
library;

/// Scripts written without spaces between words.
final RegExp _unspaced = RegExp(
  r'[⺀-鿿ꀀ-꓏가-힯豈-﫿'
  r'฀-๿຀-໿ក-៿က-႟ༀ-࿿]',
);

/// The separator a compound origin is written with — "Latin / French".
const _between = ' / ';

/// A base short enough to match by accident is not worth splitting on, and a
/// modifier of one letter is not a modifier.
const _shortestBase = 3;
const _shortestModifier = 2;

/// The spoken form of [label], given every origin label the same locale uses.
///
/// Returns [label] unchanged when there is nothing to split, which is the
/// common case: most origins are one word already.
String spokenOrigin(String label, Set<String> bases) {
  if (label.trim().isEmpty) return label;
  final parts = label.split('/').map((part) => part.trim()).toList();
  final spoken = [for (final part in parts) _splitCompound(part, bases)];
  return parts.length == 1 ? spoken.single : spoken.join(_between);
}

String _splitCompound(String part, Set<String> bases) {
  if (part.isEmpty) return part;
  // Already two words, or a script that does not separate them at all.
  if (part.contains(' ') || _unspaced.hasMatch(part)) return part;

  final lower = part.toLowerCase();
  String? longest;
  for (final base in bases) {
    final candidate = base.trim().toLowerCase();
    if (candidate.length < _shortestBase) continue;
    if (candidate.length >= part.length) continue;
    if (part.length - candidate.length < _shortestModifier) continue;
    if (!lower.endsWith(candidate)) continue;
    if (longest == null || candidate.length > longest.length) {
      longest = candidate;
    }
  }
  if (longest == null) return part;

  final cut = part.length - longest.length;
  return '${part.substring(0, cut)} ${part.substring(cut)}';
}

/// Every origin label in a locale, and the spoken form of each — only those
/// that differ from what is written.
///
/// The bases are drawn from the simple labels: each side of a compound
/// counts, so "Latijn / Engels" contributes *Engels* even in a lexicon whose
/// only plain English word is that one.
Map<String, String> spokenOriginTable(Iterable<String> labels) {
  final all = labels.map((label) => label.trim()).where((l) => l.isNotEmpty);
  final bases = <String>{
    for (final label in all)
      for (final part in label.split('/'))
        if (!part.trim().contains(' ')) part.trim(),
  };
  final table = <String, String>{};
  for (final label in all) {
    final spoken = spokenOrigin(label, bases);
    if (spoken != label) table[label] = spoken;
  }
  return table;
}
