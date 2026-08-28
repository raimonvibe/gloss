const fs = require("fs");

const etymology = {
  edulcorate: {
    origin: "Latin",
    originWord: "edulcorare",
    roots: [
      { form: "e-, ex-", meaning: "out, thoroughly" },
      { form: "dulcis", meaning: "sweet" },
    ],
  },
  pietistic: {
    origin: "Latin",
    originWord: "pietas",
    roots: [
      { form: "pietas", meaning: "piety, dutifulness" },
      { form: "-istic", meaning: "having the character of" },
    ],
  },
  amphiboly: {
    origin: "Greek",
    originWord: "amphibolia",
    roots: [
      { form: "amphi-", meaning: "both, on both sides" },
      { form: "ballein", meaning: "to throw" },
    ],
  },
  trenchant: {
    origin: "Old French",
    originWord: "trenchant",
    roots: [
      { form: "trenchier", meaning: "to cut" },
      { form: "-ant", meaning: "doing, having the quality of" },
    ],
  },
  inchoative: {
    origin: "Latin",
    originWord: "inchoare",
    roots: [
      { form: "inchoare", meaning: "to begin, to start" },
      { form: "-ivus", meaning: "tending toward" },
    ],
  },
  panegyric: {
    origin: "Greek",
    originWord: "panēgyrikos",
    roots: [
      { form: "pan-", meaning: "all" },
      { form: "agyris", meaning: "assembly, gathering" },
    ],
  },
  ontic: {
    origin: "Greek",
    originWord: "ōn, ontos",
    roots: [
      { form: "ōn / ontos", meaning: "being, that which exists" },
      { form: "-ic", meaning: "relating to" },
    ],
  },
  fructify: {
    origin: "Latin",
    originWord: "fructificare",
    roots: [
      { form: "fructus", meaning: "fruit" },
      { form: "-ficare", meaning: "to make, to cause" },
    ],
  },
  proleptical: {
    origin: "Greek",
    originWord: "prolēpsis",
    roots: [
      { form: "pro-", meaning: "before" },
      { form: "lambanein", meaning: "to take, to seize" },
    ],
  },
  pneumatic: {
    origin: "Greek",
    originWord: "pneumatikos",
    roots: [
      { form: "pneuma", meaning: "wind, breath, spirit" },
      { form: "-ikos", meaning: "pertaining to" },
    ],
  },
  cataphatic: {
    origin: "Greek",
    originWord: "kataphatikos",
    roots: [
      { form: "kata-", meaning: "down, according to" },
      { form: "phanai", meaning: "to speak, to say" },
    ],
  },
  fiducial: {
    origin: "Latin",
    originWord: "fiducia",
    roots: [
      { form: "fidere", meaning: "to trust" },
      { form: "fiducia", meaning: "trust, confidence" },
    ],
  },
  theodicy: {
    origin: "Greek",
    originWord: "theodicy (Leibniz)",
    roots: [
      { form: "theos", meaning: "god" },
      { form: "dikē", meaning: "justice" },
    ],
  },
  circumincession: {
    origin: "Latin",
    originWord: "circumincessio",
    roots: [
      { form: "circum-", meaning: "around" },
      { form: "incedere", meaning: "to go, to walk" },
    ],
  },
  redound: {
    origin: "Latin",
    originWord: "redundare",
    roots: [
      { form: "re-", meaning: "back, again" },
      { form: "unda", meaning: "wave" },
    ],
  },
  ineluctable: {
    origin: "Latin",
    originWord: "ineluctabilis",
    roots: [
      { form: "in-", meaning: "not" },
      { form: "eluctari", meaning: "to struggle out of" },
    ],
  },
  periphrastic: {
    origin: "Greek",
    originWord: "periphrasis",
    roots: [
      { form: "peri-", meaning: "around" },
      { form: "phrazein", meaning: "to declare, to tell" },
    ],
  },
  hebetude: {
    origin: "Latin",
    originWord: "hebetudo",
    roots: [
      { form: "hebes", meaning: "dull, blunt" },
      { form: "-tudo", meaning: "state or quality" },
    ],
  },
  unpropitious: {
    origin: "Latin",
    originWord: "propitius",
    roots: [
      { form: "un-", meaning: "not" },
      { form: "propitius", meaning: "favorable, gracious" },
    ],
  },
  fricaseed: {
    origin: "French",
    originWord: "fricassée",
    roots: [
      { form: "frire", meaning: "to fry" },
      { form: "casser", meaning: "to break (into pieces)" },
    ],
  },
  ersatz: {
    origin: "German",
    originWord: "Ersatz",
    roots: [
      { form: "er-", meaning: "out, replacement prefix" },
      { form: "setzen", meaning: "to set, to place" },
    ],
  },
  reify: {
    origin: "Latin",
    originWord: "res + -fy",
    roots: [
      { form: "res", meaning: "thing" },
      { form: "-fy (facere)", meaning: "to make" },
    ],
  },
  eluded: {
    origin: "Latin",
    originWord: "eludere",
    roots: [
      { form: "e-, ex-", meaning: "out, away" },
      { form: "ludere", meaning: "to play" },
    ],
  },
  aporetic: {
    origin: "Greek",
    originWord: "aporētikos",
    roots: [
      { form: "a-", meaning: "without" },
      { form: "poros", meaning: "passage, way" },
    ],
  },
  metonymy: {
    origin: "Greek",
    originWord: "metōnymia",
    roots: [
      { form: "meta-", meaning: "change, after" },
      { form: "onyma", meaning: "name" },
    ],
  },
  deracinate: {
    origin: "French / Latin",
    originWord: "déraciner",
    roots: [
      { form: "de-", meaning: "away, off" },
      { form: "racine (radix)", meaning: "root" },
    ],
  },
  euphonious: {
    origin: "Greek",
    originWord: "euphōnos",
    roots: [
      { form: "eu-", meaning: "good, well" },
      { form: "phōnē", meaning: "sound, voice" },
    ],
  },
  putative: {
    origin: "Latin",
    originWord: "putativus",
    roots: [
      { form: "putare", meaning: "to think, to consider" },
      { form: "-ivus", meaning: "having the nature of" },
    ],
  },
  neologism: {
    origin: "Greek",
    originWord: "neologismos",
    roots: [
      { form: "neos", meaning: "new" },
      { form: "logos", meaning: "word, speech" },
    ],
  },
  splenetic: {
    origin: "Greek / Latin",
    originWord: "spleneticus",
    roots: [
      { form: "splēn", meaning: "spleen (seat of anger)" },
      { form: "-etic", meaning: "affected by" },
    ],
  },
  sententious: {
    origin: "Latin",
    originWord: "sententiosus",
    roots: [
      { form: "sententia", meaning: "opinion, maxim" },
      { form: "-osus", meaning: "full of" },
    ],
  },
  garrulous: {
    origin: "Latin",
    originWord: "garrulus",
    roots: [
      { form: "garrire", meaning: "to chatter, to prattle" },
      { form: "-ulus", meaning: "inclined to" },
    ],
  },
  fatuity: {
    origin: "Latin",
    originWord: "fatuitas",
    roots: [
      { form: "fatuus", meaning: "foolish, silly" },
      { form: "-itas", meaning: "state of being" },
    ],
  },
  peroration: {
    origin: "Latin",
    originWord: "peroratio",
    roots: [
      { form: "per-", meaning: "through, to the end" },
      { form: "orare", meaning: "to speak, to plead" },
    ],
  },
  tautology: {
    origin: "Greek",
    originWord: "tautologia",
    roots: [
      { form: "tauto-", meaning: "the same" },
      { form: "logos", meaning: "word, speech" },
    ],
  },
  laconism: {
    origin: "Greek",
    originWord: "Lakōnismos",
    roots: [
      { form: "Lakōn", meaning: "a Spartan of Laconia" },
      { form: "-ismos", meaning: "practice, manner" },
    ],
  },
  pabulum: {
    origin: "Latin",
    originWord: "pabulum",
    roots: [
      { form: "pascere", meaning: "to feed" },
      { form: "-bulum", meaning: "means or instrument" },
    ],
  },
  soporific: {
    origin: "Latin",
    originWord: "soporificus",
    roots: [
      { form: "sopor", meaning: "deep sleep" },
      { form: "-ficus (facere)", meaning: "making, causing" },
    ],
  },
  unctuous: {
    origin: "Latin",
    originWord: "unctuosus",
    roots: [
      { form: "ungere", meaning: "to anoint, to oil" },
      { form: "-osus", meaning: "full of" },
    ],
  },
  captious: {
    origin: "Latin",
    originWord: "captiosus",
    roots: [
      { form: "capere", meaning: "to seize, to take" },
      { form: "captio", meaning: "a trap, a sophism" },
    ],
  },
  torpid: {
    origin: "Latin",
    originWord: "torpidus",
    roots: [
      { form: "torpere", meaning: "to be numb, to be sluggish" },
      { form: "-idus", meaning: "in a state of" },
    ],
  },
  seneschal: {
    origin: "Frankish / Old French",
    originWord: "senescalc",
    roots: [
      { form: "seni-", meaning: "old, senior" },
      { form: "skalk", meaning: "servant" },
    ],
  },
  expatiate: {
    origin: "Latin",
    originWord: "exspatiari",
    roots: [
      { form: "ex-", meaning: "out" },
      { form: "spatium", meaning: "space" },
    ],
  },
  nugatory: {
    origin: "Latin",
    originWord: "nugatorius",
    roots: [
      { form: "nugae", meaning: "trifles, nonsense" },
      { form: "-orius", meaning: "belonging to" },
    ],
  },
  sagacity: {
    origin: "Latin",
    originWord: "sagacitas",
    roots: [
      { form: "sagax", meaning: "keen-scented, shrewd" },
      { form: "-itas", meaning: "quality of" },
    ],
  },
  canaille: {
    origin: "Italian / French",
    originWord: "canaglia",
    roots: [
      { form: "canis", meaning: "dog" },
      { form: "-aille", meaning: "collective, pack" },
    ],
  },
  contumely: {
    origin: "Latin",
    originWord: "contumelia",
    roots: [
      { form: "con-", meaning: "with, thoroughly" },
      { form: "tumere", meaning: "to swell (with pride)" },
    ],
  },
  askance: {
    origin: "Uncertain / Italian",
    originWord: "a schiancio",
    roots: [
      { form: "a", meaning: "at, to" },
      { form: "schiancio", meaning: "slant, bias" },
    ],
  },
  clodpate: {
    origin: "English",
    originWord: "clod + pate",
    roots: [
      { form: "clod", meaning: "lump of earth" },
      { form: "pate", meaning: "head" },
    ],
  },
  actuate: {
    origin: "Latin",
    originWord: "actuare",
    roots: [
      { form: "actus", meaning: "a doing, a driving" },
      { form: "agere", meaning: "to drive, to do" },
    ],
  },
  peculation: {
    origin: "Latin",
    originWord: "peculatio",
    roots: [
      { form: "peculium", meaning: "private property" },
      { form: "pecus", meaning: "cattle, wealth" },
    ],
  },
  "demi-monde": {
    origin: "French",
    originWord: "demi-monde",
    roots: [
      { form: "demi", meaning: "half" },
      { form: "monde", meaning: "world, society" },
    ],
  },
  extant: {
    origin: "Latin",
    originWord: "exstans",
    roots: [
      { form: "ex-", meaning: "out" },
      { form: "stare", meaning: "to stand" },
    ],
  },
  perfidy: {
    origin: "Latin",
    originWord: "perfidia",
    roots: [
      { form: "per-", meaning: "through, against" },
      { form: "fides", meaning: "faith, trust" },
    ],
  },
  patois: {
    origin: "French",
    originWord: "patois",
    roots: [
      { form: "patois", meaning: "rough speech, dialect" },
      { form: "patte (debated)", meaning: "paw — clumsy talk" },
    ],
  },
  prerogative: {
    origin: "Latin",
    originWord: "praerogativa",
    roots: [
      { form: "prae-", meaning: "before" },
      { form: "rogare", meaning: "to ask, to vote" },
    ],
  },
  hardihood: {
    origin: "Old French / English",
    originWord: "hardi + -hood",
    roots: [
      { form: "hardi", meaning: "bold, hardy" },
      { form: "-hood", meaning: "state, condition" },
    ],
  },
  effloresce: {
    origin: "Latin",
    originWord: "efflorescere",
    roots: [
      { form: "ex-", meaning: "out" },
      { form: "florescere", meaning: "to begin to bloom" },
    ],
  },
  "plumb-line": {
    origin: "Latin / English",
    originWord: "plumbum + line",
    roots: [
      { form: "plumbum", meaning: "lead" },
      { form: "line", meaning: "cord, measure" },
    ],
  },
  fain: {
    origin: "Old English",
    originWord: "fægen",
    roots: [
      { form: "fægen", meaning: "glad, joyful" },
      { form: "(archaic adverb)", meaning: "gladly, willingly" },
    ],
  },
  opprobrium: {
    origin: "Latin",
    originWord: "opprobrium",
    roots: [
      { form: "ob-", meaning: "against" },
      { form: "probrum", meaning: "disgrace, reproach" },
    ],
  },
  mordant: {
    origin: "Latin / French",
    originWord: "mordere",
    roots: [
      { form: "mordere", meaning: "to bite" },
      { form: "-ant", meaning: "biting, doing" },
    ],
  },
  pronunciamento: {
    origin: "Spanish",
    originWord: "pronunciamiento",
    roots: [
      { form: "pro-", meaning: "forth" },
      { form: "nuntiare", meaning: "to announce" },
    ],
  },
  sciolist: {
    origin: "Latin",
    originWord: "sciolus",
    roots: [
      { form: "scire", meaning: "to know" },
      { form: "-olus", meaning: "diminutive — a little knower" },
    ],
  },
  dotage: {
    origin: "Middle English",
    originWord: "doten + -age",
    roots: [
      { form: "doten", meaning: "to dote, to be foolish" },
      { form: "-age", meaning: "state or result" },
    ],
  },
  "lee-side": {
    origin: "Old English",
    originWord: "hlēo + side",
    roots: [
      { form: "hlēo", meaning: "shelter, protection" },
      { form: "side", meaning: "flank, face" },
    ],
  },
  parry: {
    origin: "French",
    originWord: "parer",
    roots: [
      { form: "parer", meaning: "to ward off" },
      { form: "parare (Latin)", meaning: "to prepare, to defend" },
    ],
  },
  mephitic: {
    origin: "Latin",
    originWord: "mephitis",
    roots: [
      { form: "mephitis", meaning: "noxious vapor" },
      { form: "-ic", meaning: "having the nature of" },
    ],
  },
  sybarite: {
    origin: "Greek",
    originWord: "Sybaritēs",
    roots: [
      { form: "Sybaris", meaning: "ancient Greek city famed for luxury" },
      { form: "-itēs", meaning: "inhabitant of" },
    ],
  },
  prescind: {
    origin: "Latin",
    originWord: "praescindere",
    roots: [
      { form: "prae-", meaning: "before, away" },
      { form: "scindere", meaning: "to cut" },
    ],
  },
  excoriate: {
    origin: "Latin",
    originWord: "excoriare",
    roots: [
      { form: "ex-", meaning: "off" },
      { form: "corium", meaning: "skin, hide" },
    ],
  },
  adduce: {
    origin: "Latin",
    originWord: "adducere",
    roots: [
      { form: "ad-", meaning: "to, toward" },
      { form: "ducere", meaning: "to lead" },
    ],
  },
  peregrinations: {
    origin: "Latin",
    originWord: "peregrinatio",
    roots: [
      { form: "per-", meaning: "through" },
      { form: "ager", meaning: "field, land (peregrinus: foreigner)" },
    ],
  },
  mendicant: {
    origin: "Latin",
    originWord: "mendicans",
    roots: [
      { form: "mendicare", meaning: "to beg" },
      { form: "mendicus", meaning: "beggar" },
    ],
  },
  munificent: {
    origin: "Latin",
    originWord: "munificus",
    roots: [
      { form: "munus", meaning: "gift, service" },
      { form: "-ficus (facere)", meaning: "making, giving" },
    ],
  },
  inanition: {
    origin: "Latin",
    originWord: "inanitio",
    roots: [
      { form: "inanis", meaning: "empty, void" },
      { form: "-tio", meaning: "the act or result of" },
    ],
  },
  vituperation: {
    origin: "Latin",
    originWord: "vituperatio",
    roots: [
      { form: "vitium", meaning: "fault" },
      { form: "parare", meaning: "to prepare, to furnish" },
    ],
  },
  inimical: {
    origin: "Latin",
    originWord: "inimicalis",
    roots: [
      { form: "in-", meaning: "not" },
      { form: "amicus", meaning: "friend" },
    ],
  },
  invidious: {
    origin: "Latin",
    originWord: "invidiosus",
    roots: [
      { form: "invidia", meaning: "envy" },
      { form: "in- + videre", meaning: "to look upon (with ill will)" },
    ],
  },
  subaltern: {
    origin: "Latin",
    originWord: "subalternus",
    roots: [
      { form: "sub-", meaning: "under" },
      { form: "alternus", meaning: "alternate, other" },
    ],
  },
  execrate: {
    origin: "Latin",
    originWord: "exsecrari",
    roots: [
      { form: "ex-", meaning: "out of" },
      { form: "sacer", meaning: "sacred (to curse out of the sacred)" },
    ],
  },
  integument: {
    origin: "Latin",
    originWord: "integumentum",
    roots: [
      { form: "in-", meaning: "on, over" },
      { form: "tegere", meaning: "to cover" },
    ],
  },
  ingenuous: {
    origin: "Latin",
    originWord: "ingenuus",
    roots: [
      { form: "in-", meaning: "in, native" },
      { form: "gignere", meaning: "to beget (free-born, candid)" },
    ],
  },
  pedantry: {
    origin: "Italian / Latin",
    originWord: "pedanteria",
    roots: [
      { form: "paidagōgos (Greek)", meaning: "tutor of children" },
      { form: "-ry", meaning: "practice or quality" },
    ],
  },
  perscrutation: {
    origin: "Latin",
    originWord: "perscrutatio",
    roots: [
      { form: "per-", meaning: "through, thoroughly" },
      { form: "scrutari", meaning: "to search, to examine" },
    ],
  },
  demur: {
    origin: "Latin / French",
    originWord: "demorer",
    roots: [
      { form: "de-", meaning: "from, away" },
      { form: "morari", meaning: "to delay" },
    ],
  },
  specious: {
    origin: "Latin",
    originWord: "speciosus",
    roots: [
      { form: "species", meaning: "appearance, look" },
      { form: "-osus", meaning: "full of (fair-seeming)" },
    ],
  },
  cant: {
    origin: "Latin",
    originWord: "cantare",
    roots: [
      { form: "cantare", meaning: "to sing (later: singsong jargon)" },
      { form: "cant", meaning: "whining speech of beggars, then hypocrisy" },
    ],
  },
  pusillanimous: {
    origin: "Latin",
    originWord: "pusillanimis",
    roots: [
      { form: "pusillus", meaning: "very small" },
      { form: "animus", meaning: "spirit, courage" },
    ],
  },
  vulpine: {
    origin: "Latin",
    originWord: "vulpinus",
    roots: [
      { form: "vulpes", meaning: "fox" },
      { form: "-inus", meaning: "of or like" },
    ],
  },
  seriatim: {
    origin: "Latin",
    originWord: "seriatim",
    roots: [
      { form: "series", meaning: "row, sequence" },
      { form: "-atim", meaning: "one at a time" },
    ],
  },
  parsimony: {
    origin: "Latin",
    originWord: "parsimonia",
    roots: [
      { form: "parcere", meaning: "to spare, to be frugal" },
      { form: "-monia", meaning: "state or practice" },
    ],
  },
  emendation: {
    origin: "Latin",
    originWord: "emendatio",
    roots: [
      { form: "e-, ex-", meaning: "out of" },
      { form: "mendum", meaning: "fault, error" },
    ],
  },
  abstemious: {
    origin: "Latin",
    originWord: "abstemius",
    roots: [
      { form: "abs-", meaning: "away from" },
      { form: "temetum", meaning: "intoxicating drink" },
    ],
  },
  solecism: {
    origin: "Greek",
    originWord: "soloikismos",
    roots: [
      { form: "Soloi", meaning: "Cilician city known for 'bad' Greek" },
      { form: "-ismos", meaning: "practice, manner" },
    ],
  },
  internecine: {
    origin: "Latin",
    originWord: "internecinus",
    roots: [
      { form: "inter-", meaning: "between, among" },
      { form: "necare", meaning: "to kill" },
    ],
  },
  pococurante: {
    origin: "Italian",
    originWord: "poco + curante",
    roots: [
      { form: "poco", meaning: "little" },
      { form: "curare", meaning: "to care" },
    ],
  },
  imbroglio: {
    origin: "Italian",
    originWord: "imbroglio",
    roots: [
      { form: "im-", meaning: "in" },
      { form: "brogliare", meaning: "to tangle, to confuse" },
    ],
  },
  minatory: {
    origin: "Latin",
    originWord: "minatorius",
    roots: [
      { form: "minari", meaning: "to threaten" },
      { form: "-orius", meaning: "serving to" },
    ],
  },
  obloquy: {
    origin: "Latin",
    originWord: "obloquium",
    roots: [
      { form: "ob-", meaning: "against" },
      { form: "loqui", meaning: "to speak" },
    ],
  },
  paroxysm: {
    origin: "Greek",
    originWord: "paroxysmos",
    roots: [
      { form: "para-", meaning: "beyond" },
      { form: "oxys", meaning: "sharp, acute" },
    ],
  },
  adscititious: {
    origin: "Latin",
    originWord: "adscitus",
    roots: [
      { form: "ad-", meaning: "to, in addition" },
      { form: "sciscere", meaning: "to approve, to take on" },
    ],
  },
  nescience: {
    origin: "Latin",
    originWord: "nescientia",
    roots: [
      { form: "ne-", meaning: "not" },
      { form: "scire", meaning: "to know" },
    ],
  },
  prurience: {
    origin: "Latin",
    originWord: "prurientia",
    roots: [
      { form: "prurire", meaning: "to itch, to long for" },
      { form: "-entia", meaning: "state of" },
    ],
  },
  fuliginous: {
    origin: "Latin",
    originWord: "fuliginosus",
    roots: [
      { form: "fuligo", meaning: "soot" },
      { form: "-osus", meaning: "full of" },
    ],
  },
  gainsay: {
    origin: "Middle English",
    originWord: "gein + say",
    roots: [
      { form: "gegn (Old Norse)", meaning: "against" },
      { form: "say", meaning: "to speak" },
    ],
  },
  ignavia: {
    origin: "Latin",
    originWord: "ignavia",
    roots: [
      { form: "in-", meaning: "not" },
      { form: "gnavus / navus", meaning: "busy, diligent" },
    ],
  },
  escutcheon: {
    origin: "Latin / Old French",
    originWord: "escutcheon (escuchon)",
    roots: [
      { form: "scutum", meaning: "shield" },
      { form: "-cheon", meaning: "diminutive / object" },
    ],
  },
  superannuated: {
    origin: "Latin",
    originWord: "superannuatus",
    roots: [
      { form: "super-", meaning: "beyond" },
      { form: "annus", meaning: "year" },
    ],
  },
  succedanea: {
    origin: "Latin",
    originWord: "succedaneum",
    roots: [
      { form: "sub-", meaning: "in place of" },
      { form: "cedere", meaning: "to go, to yield" },
    ],
  },
  rodomontade: {
    origin: "Italian",
    originWord: "rodomontata",
    roots: [
      { form: "Rodomonte", meaning: "boastful knight in Orlando Furioso" },
      { form: "-ade", meaning: "action, display" },
    ],
  },
  chicane: {
    origin: "French",
    originWord: "chicaner",
    roots: [
      { form: "chicaner", meaning: "to quibble, to trick" },
      { form: "chicane", meaning: "trickery; later a sharp turn" },
    ],
  },
  mathesis: {
    origin: "Greek",
    originWord: "mathēsis",
    roots: [
      { form: "manthanein", meaning: "to learn" },
      { form: "mathēsis", meaning: "the act of learning" },
    ],
  },
  pedantic: {
    origin: "Italian / Greek",
    originWord: "pedante",
    roots: [
      { form: "paidagōgos", meaning: "child-guide, tutor" },
      { form: "-ic", meaning: "having the manner of" },
    ],
  },
  coruscation: {
    origin: "Latin",
    originWord: "coruscatio",
    roots: [
      { form: "coruscare", meaning: "to glitter, to flash" },
      { form: "-tio", meaning: "the act of" },
    ],
  },
  tyro: {
    origin: "Latin",
    originWord: "tiro",
    roots: [
      { form: "tiro", meaning: "recruit, novice" },
      { form: "(military)", meaning: "a raw young soldier" },
    ],
  },
  execrable: {
    origin: "Latin",
    originWord: "exsecrabilis",
    roots: [
      { form: "exsecrari", meaning: "to curse" },
      { form: "-abilis", meaning: "worthy of, able to be" },
    ],
  },
  incarnadine: {
    origin: "Italian / Latin",
    originWord: "incarnadino",
    roots: [
      { form: "in-", meaning: "into" },
      { form: "caro, carnis", meaning: "flesh (flesh-red)" },
    ],
  },
  interstice: {
    origin: "Latin",
    originWord: "interstitium",
    roots: [
      { form: "inter-", meaning: "between" },
      { form: "stare", meaning: "to stand" },
    ],
  },
  animadversion: {
    origin: "Latin",
    originWord: "animadversio",
    roots: [
      { form: "animus", meaning: "mind" },
      { form: "advertere", meaning: "to turn toward" },
    ],
  },
  irrefragable: {
    origin: "Latin",
    originWord: "irrefragabilis",
    roots: [
      { form: "in-", meaning: "not" },
      { form: "refragari", meaning: "to oppose, to resist" },
    ],
  },
  involution: {
    origin: "Latin",
    originWord: "involutio",
    roots: [
      { form: "in-", meaning: "in, inward" },
      { form: "volvere", meaning: "to roll, to turn" },
    ],
  },
  dint: {
    origin: "Old English",
    originWord: "dynt",
    roots: [
      { form: "dynt", meaning: "a blow, a stroke" },
      { form: "by dint of", meaning: "by force of" },
    ],
  },
  mortised: {
    origin: "Latin / French",
    originWord: "mortaise",
    roots: [
      { form: "mortaise", meaning: "a socket, a hole" },
      { form: "morsus (debated)", meaning: "a bite, a grip" },
    ],
  },
  apposite: {
    origin: "Latin",
    originWord: "appositus",
    roots: [
      { form: "ad-", meaning: "to" },
      { form: "ponere", meaning: "to place" },
    ],
  },
  lambent: {
    origin: "Latin",
    originWord: "lambens",
    roots: [
      { form: "lambere", meaning: "to lick" },
      { form: "-ent", meaning: "doing (light that 'licks')" },
    ],
  },
  anchorite: {
    origin: "Greek",
    originWord: "anachōrētēs",
    roots: [
      { form: "ana-", meaning: "back, away" },
      { form: "chōrein", meaning: "to withdraw" },
    ],
  },
  slake: {
    origin: "Old English",
    originWord: "sleacian",
    roots: [
      { form: "sleac", meaning: "slack, loose" },
      { form: "sleacian", meaning: "to slacken, to allay" },
    ],
  },
  acicular: {
    origin: "Latin",
    originWord: "acicula",
    roots: [
      { form: "acus", meaning: "needle" },
      { form: "-cula", meaning: "little" },
    ],
  },
  effete: {
    origin: "Latin",
    originWord: "effetus",
    roots: [
      { form: "ex-", meaning: "out" },
      { form: "fetus", meaning: "fruitful, having borne" },
    ],
  },
  appurtenance: {
    origin: "Latin / French",
    originWord: "apartenance",
    roots: [
      { form: "ad-", meaning: "to" },
      { form: "pertinere", meaning: "to belong" },
    ],
  },
  gloze: {
    origin: "Old French / Latin",
    originWord: "gloser",
    roots: [
      { form: "glosa", meaning: "a gloss, an explanation" },
      { form: "gloser", meaning: "to comment — then to smooth over" },
    ],
  },
  incipient: {
    origin: "Latin",
    originWord: "incipiens",
    roots: [
      { form: "in-", meaning: "on, into" },
      { form: "capere", meaning: "to take (to take up, to begin)" },
    ],
  },
  afflatus: {
    origin: "Latin",
    originWord: "afflatus",
    roots: [
      { form: "ad-", meaning: "to, upon" },
      { form: "flare", meaning: "to blow (a breathing-upon)" },
    ],
  },
};

const base = JSON.parse(fs.readFileSync("/tmp/bw-words-base.json", "utf8"));
const missing = [];
for (const word of base.words) {
  const ety = etymology[word.id];
  if (!ety) {
    missing.push(word.id);
    continue;
  }
  word.origin = ety.origin;
  word.originWord = ety.originWord;
  word.roots = ety.roots;
}

if (missing.length) {
  console.error("Missing etymology:", missing.join(", "));
  process.exit(1);
}

const out = JSON.stringify(base, null, 2);
fs.writeFileSync("assets/data/words.json", out);
console.log(`Wrote ${base.words.length} words with etymology (${out.length} bytes)`);
