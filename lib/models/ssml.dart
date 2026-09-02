/// Markup the app asks the voice for, written with sentinels instead of
/// angle brackets.
///
/// `wrapEnglishSsml` escapes an utterance before sending it, and it has to:
/// the lexicon's own text carries `&` and quotation marks, and one unescaped
/// character makes the whole utterance malformed XML, which an engine answers
/// by saying nothing at all. But escaping cannot tell a tag the app meant from
/// a bracket the data happens to contain.
///
/// So the app writes its own tags with these three sentinels, and the wrapper
/// turns them back into brackets *after* escaping. Data can never reach the
/// parser as markup; the app's own tags always do. The three characters are
/// C0 controls, which no lexicon entry in any of the sixty languages contains.
const kSsmlOpen = '\u0001';
const kSsmlClose = '\u0002';
const kSsmlQuote = '\u0003';

/// `<sub alias="...">text</sub>` — show [text], say [alias].
///
/// The one tag in SSML written for this exact situation: a word whose
/// spelling and whose pronunciation are different things. Gloss is a lexicon
/// of rare words, so the engine's dictionary does not hold most of them and
/// its letter-to-sound rules make what they will of the spelling — *pietistic*
/// came out "pi-e-stic" on a phone. The respelling beside it on the page is
/// the pronunciation, and this is how to hand the voice that instead.
///
/// An engine that does not support `<sub>` speaks the inner text, so this is
/// no worse than sending the word alone.
String ssmlSub(String alias, String text) =>
    '${kSsmlOpen}sub alias=$kSsmlQuote$alias$kSsmlQuote$kSsmlClose'
    '$text$kSsmlOpen/sub$kSsmlClose';

/// The same utterance for an engine that is not being handed SSML.
///
/// Only Google's Android engine is — `_useEnglishSsml` is set from the engine
/// name, so iOS, desktop and every other Android engine are sent plain text.
/// A sentinel reaching one of those is a control character in the middle of a
/// word, which is worse than the bug this was written to fix.
///
/// A `<sub>` becomes its alias, because the alias is the pronunciation the tag
/// existed to deliver and saying it is the whole point. Any other tag is
/// dropped and its inner text kept, which is what an SSML parser would do with
/// a tag it did not know.
String ssmlToPlainText(String text) {
  return text
      .replaceAllMapped(_sub, (match) => match.group(1)!)
      .replaceAll(_anyTag, '')
      .replaceAll(kSsmlOpen, '')
      .replaceAll(kSsmlClose, '')
      .replaceAll(kSsmlQuote, '');
}

final _sub = RegExp(
  '$kSsmlOpen'
  'sub alias=$kSsmlQuote([^$kSsmlQuote]*)$kSsmlQuote'
  '$kSsmlClose'
  '[^$kSsmlOpen]*'
  '$kSsmlOpen/sub$kSsmlClose',
);

final _anyTag = RegExp('$kSsmlOpen[^$kSsmlClose]*$kSsmlClose');

/// The passage as it is written, with the app's tags taken back off.
///
/// [ssmlToPlainText] keeps the alias, because that is what an engine without
/// SSML should say. This keeps the inner text instead — the words as a reader
/// sees them — which is what a test asserting on the app's copy wants, and
/// what any caller reasoning about the writing rather than the speaking wants.
String ssmlWithoutTags(String text) {
  return text
      .replaceAll(_anyTag, '')
      .replaceAll(kSsmlOpen, '')
      .replaceAll(kSsmlClose, '')
      .replaceAll(kSsmlQuote, '');
}
