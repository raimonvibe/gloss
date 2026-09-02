import 'respelling.dart';

/// How one English form is said: its sound, and the spelling to fall back on.
///
/// The sound is what an engine that honours `<phoneme>` is given. The
/// respelling is the tag's inner text, which is what an engine that does not
/// honour it says instead — the same thing the app said before phonemes.
class SpokenForm {
  const SpokenForm({required this.ipa, required this.respelling});

  final String ipa;
  final String respelling;
}

/// The other English forms of a headword that the app says out loud, and how
/// each of them is pronounced.
///
/// The engine cannot say the 134 headwords — see `kRespellingVoicing` — and it
/// cannot say their inflections either. `<sub>` fixes the headword because
/// every entry carries a respelling for it. Nothing in the data carries one
/// for *edulcorated*, and the headword's own respelling is the wrong thing to
/// say in its place: it would say "edulcorate" over a sentence that reads
/// "edulcorated".
///
/// So these are written by hand, in the same notation as the 134, and go
/// through [spokenRespelling] like everything else — which is what keeps them
/// inside the measured substitution table rather than beside it.
///
/// There are few of them and they cannot grow unnoticed. Every one of the 134
/// examples uses its own headword; 117 use the exact form and need nothing
/// here. `test/spoken_forms_test.dart` fails on an example whose form is
/// neither the headword nor listed below, so a new word cannot quietly ship a
/// sentence the voice will mangle.
///
/// Keyed by entry id, then by the form as it is written in the sentence.
const kSpokenForms = <String, Map<String, String>>{
  // Plumb line — PLUM line. Sixty translations quote the first word alone.
  'plumb-line': {
    'plumb': 'PLUM',
  },
  // Mortised — MOR-tist. The translations quote the plain verb.
  'mortised': {
    'mortise': 'MOR-tiss',
  },
  // Ingenuous — in-JEN-yoo-us. Not an inflection: the explanations name the
  // word it is confused with, in English, in fifty-nine languages.
  'ingenuous': {
    'ingenious': 'in-JEE-nee-us',
  },
  // Edulcorate — ee-DUL-kuh-rate
  'edulcorate': {
    'edulcorated': 'ee-DUL-kuh-ray-tidd',
  },
  // Fructify — FRUK-tih-fy
  'fructify': {
    'fructified': 'FRUK-tih-fide',
    'fructifies': 'FRUK-tih-fize',
  },
  // Fricaseed — FRIK-uh-seed
  'fricaseed': {
    'fricasseed': 'FRIK-uh-seed',
    'fricassee': 'FRIK-uh-see',
  },
  // Reify — RAY-ih-fy
  'reify': {
    'reifies': 'RAY-ih-fize',
  },
  // Deracinate — dee-RASS-ih-nate
  'deracinate': {
    'deracinated': 'dee-RASS-ih-nay-tidd',
  },
  // Actuate — AK-choo-ate
  'actuate': {
    'actuated': 'AK-choo-ay-tidd',
  },
  // Effloresce — ef-luh-RESS
  'effloresce': {
    'effloresced': 'ef-luh-REST',
  },
  // Parry — PARR-ee
  'parry': {
    'parried': 'PARR-ihd',
  },
  // Excoriate — ek-SKOR-ee-ate
  'excoriate': {
    'excoriated': 'ek-SKOR-ee-ay-tidd',
  },
  // Adduce — uh-DOOSS
  'adduce': {
    'adduced': 'uh-DOOST',
  },
  // Execrate — EK-sih-krate
  'execrate': {
    'execrated': 'EK-sih-kray-tidd',
  },
  // Demur — dih-MER
  'demur': {
    'demurred': 'dih-MERD',
  },
  // Emendation — ee-men-DAY-shun
  'emendation': {
    'emendations': 'ee-men-DAY-shunz',
  },
  // Chicane — shih-KAYN
  'chicane': {
    'chicaned': 'shih-KAYND',
  },
  // Animadversion — an-ih-mad-VER-zhun
  'animadversion': {
    'animadversions': 'an-ih-mad-VER-zhunz',
  },
  // Slake — SLAYK
  'slake': {
    'slaked': 'SLAYKT',
  },
  // Appurtenance — uh-PER-tuh-nuns
  'appurtenance': {
    'appurtenances': 'uh-PER-tuh-nun-siz',
  },
  // Pabulum — PAB-yoo-lum
  'pabulum': {
    'pablum': 'PAB-lum',
  },
  // Cant — KANT
  'cant': {
    'canting': 'KAN-ting',
  },
  // Pococurante — poh-koh-kyoo-RAN-tee
  'pococurante': {
    'pococurantism': 'poh-koh-kyoo-RAN-tiz-um',
  },
};

/// The respelling for [form] of the entry [id], already sounded out, or null
/// when there is nothing written for it.
String? spokenFormOf(String id, String form) {
  final written = kSpokenForms[id]?[form.toLowerCase()];
  return written == null ? null : spokenRespelling(written);
}

/// The sound of each form above, derived from its respelling by the same rules
/// `tool/emit_ipa.py` uses on the headwords.
///
/// Written out rather than computed at run time, so that the derivation lives
/// in one language and one place; `test/spoken_forms_test.dart` checks the two
/// tables stay in step.
const kFormIpa = <String, Map<String, String>>{
  'plumb-line': {
    'plumb': 'ˈplʌm',
  },
  'mortised': {
    'mortise': 'ˈmɔːrtɪs',
  },
  'ingenuous': {
    'ingenious': 'ɪnˈdʒiːniːəs',
  },
  'edulcorate': {
    'edulcorated': 'iːˈdʌlkəreɪtɪd',
  },
  'fructify': {
    'fructified': 'ˈfrʌktɪfaɪd',
    'fructifies': 'ˈfrʌktɪfaɪz',
  },
  'fricaseed': {
    'fricasseed': 'ˈfrɪkəsiːd',
    'fricassee': 'ˈfrɪkəsiː',
  },
  'reify': {
    'reifies': 'ˈreɪɪfaɪz',
  },
  'deracinate': {
    'deracinated': 'diːˈræsɪneɪtɪd',
  },
  'actuate': {
    'actuated': 'ˈæktʃuːeɪtɪd',
  },
  'effloresce': {
    'effloresced': 'ɛfləˈrɛst',
  },
  'parry': {
    'parried': 'ˈpærɪd',
  },
  'excoriate': {
    'excoriated': 'ɛkˈskɔːriːeɪtɪd',
  },
  'adduce': {
    'adduced': 'əˈduːst',
  },
  'execrate': {
    'execrated': 'ˈɛksɪkreɪtɪd',
  },
  'demur': {
    'demurred': 'dɪˈmɜːrd',
  },
  'emendation': {
    'emendations': 'iːmɛnˈdeɪʃənz',
  },
  'chicane': {
    'chicaned': 'ʃɪˈkeɪnd',
  },
  'animadversion': {
    'animadversions': 'ænɪmædˈvɜːrʒənz',
  },
  'slake': {
    'slaked': 'ˈsleɪkt',
  },
  'appurtenance': {
    'appurtenances': 'əˈpɜːrtənənsɪz',
  },
  'pabulum': {
    'pablum': 'ˈpæbləm',
  },
  'cant': {
    'canting': 'ˈkæntɪŋ',
  },
  'pococurante': {
    'pococurantism': 'poʊkoʊkjuːˈræntɪzəm',
  },
};

/// The sound of [form] of the entry [id], derived from its respelling the same
/// way `tool/emit_ipa.py` derives the headwords'.
String? ipaOfForm(String id, String form) {
  final written = kSpokenForms[id]?[form.toLowerCase()];
  return written == null ? null : kFormIpa[id]?[form.toLowerCase()];
}
