"""Brazilian Portuguese overlays — European base with Brazilian lexicon."""

import re
from copy import deepcopy

from _words_pt import WORDS as _PT

_REPLACEMENTS = (
    ("autocarro", "ônibus"),
    ("travões", "freios"),
    ("travão", "freio"),
    ("lancil", "meio-fio"),
    ("no duche", "no chuveiro"),
    ("o duche", "o chuveiro"),
    ("carácter", "caráter"),
    ("o facto de", "o fato de"),
    ("um facto", "um fato"),
    ("génio", "gênio"),
    ("eufónica", "eufônica"),
    ("ingénua", "ingênua"),
    ("ingénuo", "ingênuo"),
    ("parcimónia", "parcimônia"),
    ("abstémios", "abstêmios"),
    ("abstémio", "abstêmio"),
    ("se reformava", "se aposentava"),
    ("Não pára", "Não para"),
    ("prémio", "prêmio"),
    ("prémios", "prêmios"),
    ("A equipa", "O time"),
    ("da equipa", "do time"),
    ("toda a equipa", "todo o time"),
    ("pequeno negócio", "pequena empresa"),
    ("aos pequenos negócios", "às pequenas empresas"),  # the gender goes with it
    ("os pequenos negócios", "as pequenas empresas"),
    ("pequenos negócios", "pequenas empresas"),
    ("em linha", "online"),
    ("realizadores", "diretores"),
    ("bilheteira", "bilheteria"),
    ("telemóvel", "celular"),
    ("comboio", "trem"),
    ("ecrã", "tela"),
    ("à-vontade", "à vontade"),
)

_OVERRIDES = {
    "pneumatic": (
        "Acionado por pressão de ar; também relativo ao espírito ou ao sopro.",
        "O mais comum: movido a ar comprimido — uma furadeira, um freio de ônibus — mas a mesma raiz grega fala também de sopro e de espírito.",
        "Os freios pneumáticos chiavam quando o ônibus parou na calçada.",
        "vento, sopro, espírito",
        "pertencente a",
    ),
    "unpropitious": (
        "Pouco favorável; de mau agouro.",
        "Mau sinal — condições ou um momento que já parecem ir contra você antes mesmo de ter começado.",
        "Céu cinzento e bateria do carro morta fizeram um começo pouco propício para a viagem de estrada.",
        "não",
        "favorável, gracioso",
    ),
    "garrulous": (
        "Excessivamente falante, sobretudo de nadas.",
        "Não para de conversar — divaga sobre miudezas muito depois de os outros terem se calado.",
        "O taxista tagarela nos contou a vida inteira antes de sairmos do aeroporto.",
        "tagarelar, palrar",
        "inclinado a",
    ),
    "eluded": (
        "Escapado ou evitado com jeito.",
        "Escorregar limpo — esquivar-se de algo, muitas vezes com astúcia ou por um triz, seja uma captura, uma pergunta ou uma resposta.",
        "A resposta lhe escapou durante horas até que, de repente, encaixou no chuveiro.",
        "fora, longe",
        "jogar",
    ),
    "actuate": (
        "Pôr em movimento ou em ação; motivar.",
        "Ser a faísca que põe algo para andar — uma máquina que liga ou uma pessoa que enfim age sobre uma ideia.",
        "O medo de perder o contrato impeliu o time inteiro para um fim de semana de hora extra.",
        "um fazer, um impelir",
        "impelir, fazer",
    ),
    "redound": (
        "Ter uma consequência que beneficia alguém ou recai sobre ele.",
        "Quando o crédito (ou a culpa) volta para quem é responsável — as boas ações que revertem em seu nome voltam depois como prêmio.",
        "O sucesso do time reverterá em crédito do técnico calado e trabalhador.",
        "para trás, de novo",
        "onda",
    ),
    "prerogative": (
        "Um direito especial de uma pessoa ou de um grupo.",
        "Um privilégio que é só seu — um direito que vem com o papel, o posto ou o status.",
        "Escolher o destino das férias da família é a prerrogativa do avô, e todo mundo sabe disso.",
        "antes",
        "perguntar, votar",
    ),
    "pedantic": (
        "Excessivamente ocupado com regras formais ou pormenores triviais.",
        "Demasiado rígido com o miúdo — corrigir minúcias técnicas que não mudam nada de fundo.",
        "Soava um pouco pedante discutir «who» contra «whom» numa mensagem de texto.",
        "guia de crianças, preceptor",
        "que tem o modo de",
    ),
    "expatiate": (
        "Falar ou escrever longamente sobre um tema.",
        "Pegar no assunto de verdade — falar ou escrever sem parar, percorrendo o tema de todos os lados.",
        "Pergunte a ele de carros antigos e ele vai discorrer durante uma hora inteira.",
        "fora",
        "espaço",
    ),
}

WORDS = deepcopy(_PT)
WORDS.update(_OVERRIDES)
for key, row in list(WORDS.items()):
    if key in _OVERRIDES:
        continue
    definition, friendly, example, r1, r2 = row
    for old, new in _REPLACEMENTS:
        # On a word boundary, never as a bare substring: "os tiene" -> "lo
        # tiene" fired inside "numeros tienen" and wrote "los numerlo", which
        # shipped. Spanish plurals end in -os constantly, so five of these
        # rules could bite the same way at any time.
        rule = r"\b%s\b" % re.escape(old)
        definition = re.sub(rule, new, definition)
        friendly = re.sub(rule, new, friendly)
        example = re.sub(rule, new, example)
    WORDS[key] = (definition, friendly, example, r1, r2)
