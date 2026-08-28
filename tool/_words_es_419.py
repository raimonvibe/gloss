"""Latin American Spanish overlays — Spain base with ustedes and regional lexicon."""

from copy import deepcopy

from _words_es import WORDS as _ES

_REPLACEMENTS = (
    ("el coche", "el auto"),
    ("del coche", "del auto"),
    ("coches de época", "autos de época"),
    ("ordenador", "computadora"),
    ("el móvil", "el celular"),
    ("vosotros", "ustedes"),
    ("vuestros", "sus"),
    ("vuestras", "sus"),
    ("vuestro", "su"),
    ("vuestra", "su"),
    ("os apetece", "le apetece"),
    ("os alcanza", "lo alcanza"),
    ("os cubre", "lo cubre"),
    ("os tiene", "lo tiene"),
    ("os hubiera", "le hubiera"),
    ("Pensad en", "Piense en"),
    ("pensad en", "piense en"),
    ("Preguntadle", "Pregúntele"),
)

_OVERRIDES = {
    "panegyric": (
        "Un discurso o escrito formal que alaba a alguien con esplendor.",
        "Un homenaje en toda regla: piense en un elogio fúnebre luminoso o en un discurso que pregone los logros de alguien a los cuatro vientos.",
        "A la profesora que se jubilaba la despidieron con un panegyric de sus estudiantes más cercanos.",
        "todo, entero",
        "asamblea, reunión",
    ),
    "pneumatic": (
        "Accionado por presión de aire; también relativo al espíritu o al aliento.",
        "Lo más habitual: movido por aire comprimido —un taladro, un freno de autobús—, pero la misma raíz griega habla también de aliento y de espíritu.",
        "Los frenos pneumatic silbaron cuando el autobús se detuvo en la acera.",
        "viento, aliento, espíritu",
        "perteneciente a",
    ),
    "unpropitious": (
        "Poco favorable; de mal agüero.",
        "Mal signo: condiciones o un momento que ya parecen ir contra uno antes de haber empezado.",
        "Cielo gris y batería del auto muerta hicieron un arranque unpropitious para el viaje por carretera.",
        "no",
        "favorable, gracioso",
    ),
    "garrulous": (
        "Excesivamente hablador, sobre todo de nimiedades.",
        "No para de platicar: divaga sobre minucias mucho después de que los demás se hayan quedado sin tema.",
        "El taxista garrulous nos contó toda su vida antes de que saliéramos del aeropuerto.",
        "charlar, parlotear",
        "inclinado a",
    ),
    "prerogative": (
        "Un derecho especial de una persona o un grupo.",
        "Un privilegio que es solo suyo: un derecho que llega con el papel, el puesto o el rango.",
        "Elegir el destino de las vacaciones familiares es la prerogative de Grandpa, y todo el mundo lo sabe.",
        "antes",
        "preguntar, votar",
    ),
    "inimical": (
        "Hostil, dañino en sus efectos.",
        "Que trabaja en contra, aunque sea en silencio: condiciones o actitudes poco amigas de sus intereses.",
        "La nueva política era inimical para los pequeños negocios, aunque esa no fuera la intención.",
        "no",
        "amigo",
    ),
    "fain": (
        "De buen grado, con gusto (arcaico).",
        "Un modo antiguo de decir «con gusto» o «de buena gana»: you would fain hacer algo si le apetece.",
        "«I would fain rest here a while», suspiró el viajero.",
        "alegre, gozoso",
        "de buen grado, con gusto",
    ),
    "pedantic": (
        "Excesivamente ocupado con reglas formales o detalles triviales.",
        "Demasiado estricto con lo chico: corregir minucias técnicas que no cambian nada de fondo.",
        "Resultaba un poco pedantic discutir «who» frente a «whom» en un mensaje de texto.",
        "guía de niños, preceptor",
        "que tiene el modo de",
    ),
    "paroxysm": (
        "Un estallido súbito y violento de emoción o de acción.",
        "Un empujón intenso que lo cubre de golpe: un ataque de risa, de ira o de tos como una ola.",
        "La acometió un paroxysm de risa que no podía explicar a nadie más en la sala.",
        "más allá",
        "agudo, acerado",
    ),
    "afflatus": (
        "Inspiración creativa, sobre todo divina.",
        "Un empujón súbito de inspiración más grande que uno: como si la idea le hubiera sido soplada desde otra parte.",
        "El poeta contó que toda la pieza llegó en un burst of afflatus a las tres de la madrugada.",
        "hacia, sobre",
        "soplar (un soplo sobre)",
    ),
}

WORDS = deepcopy(_ES)
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
