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
/// **Greek is deliberately absent, and is handled a form at a time
/// instead.** Ours is transliterated — *panēgyrikos*, *mathēsis*,
/// *anachōrētēs* — and a Greek voice handed Latin letters spells them or
/// refuses, so an entry here keyed on the origin label would send the
/// transliteration to a Greek mouth and make things worse. [kGreekScript]
/// gives each form the Greek letters instead, and that is what the voice is
/// handed. Twenty-one words come from Greek and two of them (*splenetic*,
/// *pedantic*) do not say so in their origin, which is the other reason this
/// cannot be a row in this table.
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

/// An etymological form as a voice should be handed it.
///
/// [text] is not always the form as written: Greek is drawn transliterated
/// and spoken in Greek letters. Everywhere else the two are the same string.
class SpokenEtymon {
  const SpokenEtymon(this.text, this.languageTag);

  final String text;
  final String languageTag;
}

/// The voice for Greek, once the Greek is written in Greek letters.
const kGreekVoice = 'el-GR';

/// The origin label that says a word has Greek in it.
///
/// Two of the twenty-two do not say Greek on their own — *splenetic* is
/// "Greek / Latin" and *pedantic* is "Italian / Greek" — so this is a
/// `contains`, not an equality.
const kGreekOrigin = 'Greek';

/// The lexicon's Greek etymons and root forms, in the alphabet they were
/// written in.
///
/// Twenty-one of the 134 words come from Greek, and every one of them was
/// read out with an English mouth: a Dutch reader was told *Mathesis* comes
/// "van Grieks" and then heard *mathesis* as an English word. The reason was
/// good as far as it went — the page writes Greek transliterated into Latin
/// letters, *mathēsis*, *panēgyrikos*, *anachōrētēs*, and a Greek voice
/// handed Latin letters spells them or refuses — but the conclusion was
/// wrong. The lexicon does not have to hand the voice what the page shows.
/// It never does anywhere else: a respelling is drawn in capitals and spoken
/// in lower case, a compound origin is drawn closed and spoken in its parts.
/// So the Greek is written out here in Greek, and the transliteration stays
/// where it belongs, on the page.
///
/// Three things about this table are deliberate.
///
/// **The accents are monotonic**, which is how modern Greek writes ancient
/// words, because a modern Greek voice is the only Greek voice an engine
/// has. It will say *μάθησις* with modern phonology — "MA-thi-sis" rather
/// than the classical reading — which is the same trade the table above
/// makes when it gives Latin to an Italian mouth: the nearest living voice,
/// not a perfect one. It is a great deal nearer than English.
///
/// **A prefix loses its hyphen.** The page writes *amphi-* and *kata-*
/// because that is what a root is; a voice handed a trailing hyphen either
/// pauses or says "dash". This is the spoken form, so it is written without.
///
/// **What is not Greek is not here.** *-ic* and *-etic* are English suffixes
/// on Greek stems, *spleneticus* and *pedante* are Latin and Italian and
/// have their own voices already, and *theodicy (Leibniz)* is a coinage
/// naming its coiner. They keep the voices they had.
///
/// Every entry falls back to the English reading on a device with no Greek
/// voice, so nothing here can make a reading worse than it was. Keys are
/// lower case; lookup lower-cases the form it is given.
const kGreekScript = <String, String>{
  // amphiboly
  'amphibolia': 'αμφιβολία',
  'amphi-': 'αμφι',
  'ballein': 'βάλλειν',
  // panegyric
  'panēgyrikos': 'πανηγυρικός',
  'pan-': 'παν',
  'agyris': 'άγυρις',
  // ontic
  'ōn, ontos': 'ων, όντος',
  'ōn / ontos': 'ων, όντος',
  // proleptical
  'prolēpsis': 'πρόληψις',
  'pro-': 'προ',
  'lambanein': 'λαμβάνειν',
  // pneumatic
  'pneumatikos': 'πνευματικός',
  'pneuma': 'πνεύμα',
  '-ikos': 'ικός',
  // cataphatic
  'kataphatikos': 'καταφατικός',
  'kata-': 'κατα',
  'phanai': 'φάναι',
  // theodicy
  'theos': 'θεός',
  'dikē': 'δίκη',
  // periphrastic
  'periphrasis': 'περίφρασις',
  'peri-': 'περι',
  'phrazein': 'φράζειν',
  // aporetic
  'aporētikos': 'απορητικός',
  'poros': 'πόρος',
  // metonymy
  'metōnymia': 'μετωνυμία',
  'meta-': 'μετα',
  'onyma': 'όνυμα',
  // euphonious
  'euphōnos': 'εύφωνος',
  'eu-': 'ευ',
  'phōnē': 'φωνή',
  // neologism
  'neologismos': 'νεολογισμός',
  'neos': 'νέος',
  'logos': 'λόγος',
  // splenetic
  'splēn': 'σπλήν',
  // tautology
  'tautologia': 'ταυτολογία',
  'tauto-': 'ταυτο',
  // laconism
  'lakōnismos': 'Λακωνισμός',
  'lakōn': 'Λάκων',
  '-ismos': 'ισμός',
  // sybarite
  'sybaritēs': 'Συβαρίτης',
  'sybaris': 'Σύβαρις',
  '-itēs': 'ίτης',
  // solecism
  'soloikismos': 'σολοικισμός',
  'soloi': 'Σόλοι',
  // paroxysm
  'paroxysmos': 'παροξυσμός',
  'para-': 'παρα',
  'oxys': 'οξύς',
  // mathesis
  'mathēsis': 'μάθησις',
  'manthanein': 'μανθάνειν',
  // pedantic
  'paidagōgos': 'παιδαγωγός',
  // anchorite
  'anachōrētēs': 'αναχωρητής',
  'ana-': 'ανα',
  'chōrein': 'χωρείν',
};

/// An etymological form as a voice should be handed it, hyphen and all.
///
/// The page writes a root as a root — *ex-*, *-osus*, *inter-* — because
/// that is what tells a reader which end the word attaches to. A voice
/// handed the hyphen either pauses on it or says the word for it, so
/// *effloresce* was read out "ex trattino, out" by the Italian voice the
/// Latin had just been given.
///
/// The Greek table above has never had this fault, because its entries were
/// written out by hand as the voice should say them and every hyphen was
/// dropped on the way in — *amphi-* is *αμφι*. Everything else is the form
/// as written, so it needs the same thing doing to it here: **eighty of the
/// three hundred and fifty-one forms that reach a foreign voice carry a
/// hyphen**, which is most of the prefixes and every suffix in the lexicon.
///
/// Only the ends are trimmed. *demi-monde* is a French word with a hyphen
/// in the middle of it and is spoken whole.
String spokenEtymonForm(String form) {
  final trimmed = form.trim();
  var start = 0;
  var end = trimmed.length;
  while (start < end && trimmed.codeUnitAt(start) == 0x2D) {
    start++;
  }
  while (end > start && trimmed.codeUnitAt(end - 1) == 0x2D) {
    end--;
  }
  final inner = trimmed.substring(start, end);
  // A form that is nothing but hyphens is not a word; leave it as it was
  // and let the caller's own emptiness checks deal with it.
  return inner.isEmpty ? trimmed : inner;
}
