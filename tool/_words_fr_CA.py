"""Canadian French overlays — France base with Quebecois lexical and tonal shifts."""

from copy import deepcopy

from _words_fr import WORDS as _FR

_REPLACEMENTS = (
    ("e-mails", "courriels"),
    ("e-mail", "courriel"),
    ("week-end", "fin de semaine"),
    ("dîner du dimanche", "souper du dimanche"),
    ("chaque dîner", "chaque souper"),
    ("salle à manger", "salle à dîner"),
    ("portable", "cellulaire"),  # if any
    ("petit-déjeuner", "déjeuner"),
    ("parking", "stationnement"),
    ("shopping", "magasinage"),
)

_OVERRIDES = {
    "pneumatic": (
        "Actionné par la pression de l’air ; aussi relatif à l’esprit ou au souffle.",
        "Le plus souvent : mû à l’air comprimé — un marteau-piqueur, un frein d’autobus — mais la même racine grecque parle aussi du souffle et de l’esprit.",
        "Les freins pneumatic sifflèrent quand l’autobus s’arrêta au bord du trottoir.",
        "vent, souffle, esprit",
        "relatif à",
    ),
    "unpropitious": (
        "Peu favorable ; de mauvais augure.",
        "Mauvais signe — des conditions ou un timing qui semblent déjà jouer contre vous avant même d’avoir commencé.",
        "Ciel gris et batterie à plat firent un départ unpropitious pour la virée en auto.",
        "ne pas",
        "favorable, bienveillant",
    ),
    "garrulous": (
        "Excessivement bavard, surtout sur des riens.",
        "N’arrête tout simplement pas de jaser — radote sur des niaiseries longtemps après que les autres n’aient plus rien à dire.",
        "Le chauffeur de taxi garrulous nous a raconté toute sa vie avant même qu’on ait quitté l’aéroport.",
        "bavarder, jacasser",
        "enclin à",
    ),
    "prerogative": (
        "Un droit spécial appartenant à une personne ou à un groupe.",
        "Un privilège qui n’appartient qu’à vous — un droit qui vient avec le rôle, la place ou le rang.",
        "Choisir la destination des vacances familiales, c’est la prerogative de Grandpa, et tout le monde le sait.",
        "avant",
        "demander, voter",
    ),
    "expatiate": (
        "S’étendre longuement, à l’oral ou à l’écrit, sur un sujet.",
        "Vraiment s’élancer sur un thème — en parler ou en écrire sans fin, sous tous les angles.",
        "Parlez-lui d’autos d’époque et il va expatiate pendant une bonne heure.",
        "hors",
        "espace",
    ),
    "cant": (
        "Un discours insincère, hypocrite, souvent moralisateur.",
        "Un parler prêchi-prêcha qui sonne vertueux sans aucun sentiment vrai — une pose morale en pilote automatique.",
        "Il en avait assez du cant d’entreprise sur la « family » d’une compagnie qui ne donnait jamais de congé.",
        "chanter (plus tard : jargon chantant)",
        "parler plaintif des mendiants, puis hypocrisie",
    ),
    "pedantic": (
        "Excessivement attaché aux règles formelles ou aux détails triviaux.",
        "Trop strict sur les petites choses — corriger des minuties techniques qui ne changent rien d’essentiel.",
        "Ça paraissait un peu pedantic de chicaner sur « who » versus « whom » dans un texto.",
        "guide d’enfants, précepteur",
        "ayant la manière de",
    ),
    "slake": (
        "Étancher la soif ; apaiser.",
        "Satisfaire pleinement un désir — le plus souvent la soif, mais au figuré tout besoin profond.",
        "Un verre d’eau froide slaked sa soif après la longue randonnée.",
        "lâche, relâché",
        "détendre, calmer",
    ),
}

WORDS = deepcopy(_FR)
WORDS.update(_OVERRIDES)
for key, row in list(WORDS.items()):
    if key in _OVERRIDES:
        continue
    definition, friendly, example, r1, r2 = row
    for old, new in _REPLACEMENTS:
        definition = definition.replace(old, new)
        friendly = friendly.replace(old, new)
        example = example.replace(old, new)
    WORDS[key] = (definition, friendly, example, r1, r2)
