/// The voice an etymon belongs to.
///
/// The lexicon quotes the word each headword came from — French *chicaner*,
/// German *Ersatz*, Latin *mordere* — and every one of them went to the
/// English voice, because English is where the lexicon's own words go. So a
/// Dutch reader was told the word came "van Frans" and then heard *chicaner*
/// read with an English mouth. The origin is named in the reader's language;
/// the word itself belongs to the language it is written in.
///
/// Three things about this table are deliberate.
///
/// **Only origins that name one language are in it.** A compound origin's
/// etymon is not reliably in either of them: "Latin / Old French" quotes
/// *escutcheon (escuchon)*, which is the English word followed by the French,
/// and "Latin / English" quotes *plumbum + line*. Those keep the English
/// voice, which reads them no worse than it did.
///
/// **Greek is deliberately absent**, though nineteen of the 134 are Greek.
/// Ours is transliterated — *panēgyrikos*, *mathēsis*, *anachōrētēs* — and a
/// Greek voice handed Latin letters spells them or refuses. The
/// transliteration is what the page shows and what an English voice can
/// approximate, so it stays where it is. Greek written in Greek would belong
/// here; that is a data change, not a table entry.
///
/// **Latin is read by an Italian voice**, which is the one judgment call
/// here. No engine has a Latin voice and eighty-one of the 134 words are
/// Latin, so the choice is between an Italian mouth and an English one.
/// Italian is the pronunciation ecclesiastical Latin actually uses, and it
/// says *dulcis* and *mordere* as Latin words rather than as English ones.
/// Change this one line to `null` to put them back with the English voice.
///
/// Every entry falls back to English on a device without the voice, so
/// nothing here can make a reading worse than it was.
const kOriginVoices = <String, String>{
  'Latin': 'it-IT',
  'French': 'fr-FR',
  'Old French': 'fr-FR',
  'Italian': 'it-IT',
  'Spanish': 'es-ES',
  'German': 'de-DE',
};

/// The etymon's language where the origin names more than one.
///
/// Sixteen words have a compound origin, and the language of the word they
/// quote is not something a rule can work out from the pair: all four of the
/// "Latin / French" words are written differently — *mordere* is the Latin,
/// while *demorer*, *mortaise* and *apartenance* are the French. So they are
/// read off one at a time and written down here.
///
/// Three of the sixteen are deliberately absent:
///
/// - **plumb-line** and **hardihood** quote an English word beside the
///   foreign one — *plumbum + line*, *hardi + -hood* — and their root forms
///   are one of each. A voice chosen for the word would be wrong for half of
///   it, and English is right for the half that matters least.
/// - **seneschal** is Frankish, and no engine has a Frankish voice.
///
/// Where a word's roots are in a different language from its etymon — Latin
/// *morari* under French *demorer* — they follow the etymon. A Latin root in
/// a French mouth is a smaller error than the English one it had before, and
/// the alternative is a language per root, which the lexicon does not record.
const kEtymonVoiceByWord = <String, String>{
  'deracinate': 'fr-FR', // déraciner
  'splenetic': 'it-IT', // spleneticus, Latin
  'canaille': 'it-IT', // canaglia
  'askance': 'it-IT', // a schiancio
  'mordant': 'it-IT', // mordere, Latin
  'pedantry': 'it-IT', // pedanteria
  'demur': 'fr-FR', // demorer
  'escutcheon': 'it-IT', // scutum; the etymon itself is a mixed form
  'pedantic': 'it-IT', // pedante
  'incarnadine': 'it-IT', // incarnadino
  'mortised': 'fr-FR', // mortaise
  'appurtenance': 'fr-FR', // apartenance
  'gloze': 'fr-FR', // gloser
};

/// A vowel with a macron, which in this lexicon means transliterated Greek.
///
/// *splēn*, *paidagōgos*, *chōrein* — they sit under words whose origin is
/// not always named as Greek (*splenetic* is "Greek / Latin", *pedantic* is
/// "Italian / Greek"), so the macron is what identifies them. They belong
/// with the English voice for the same reason all our Greek does: the letters
/// are Latin ones and no Greek voice will read them.
final RegExp kTransliteratedGreek = RegExp('[āēīōū]');

/// A form that is not plain enough to hand to another voice.
///
/// The lexicon writes some roots with an English gloss or a second language
/// beside them — `racine (radix)`, `patte (debated)`, `caro, carnis`,
/// `poco + curante` — and those are two languages in one string. They keep
/// the English voice.
final RegExp kMixedForm = RegExp(r'[(),+]');
