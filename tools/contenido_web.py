#!/usr/bin/env python3
"""EL CONTENIDO de la web de este cartucho: lo unico que es de este juego.

md2html.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego ni de ninguna editora: lo leen de aqui.

Todas las cifras de aqui estan medidas sobre este cartucho, con las
herramientas de tools/: CODIGO y DATOS los imprime tools/presupuesto.py
(make sanity) y RUTINAS, INSTRUCCIONES y COMENTARIOS son la suma de los
bancos con codigo en tools/densidad.py (make densidad). Un test las vuelve a
medir.
"""

NOMBRE = "Rastan Saga"
EDITORA = "Taito"
ANIO = 1988
REPOSITORIO = "https://github.com/antxiko/RastanSaga-disassembly"

CODIGO = 29820
DATOS = 232324
RUTINAS = 1406
INSTRUCCIONES = 13982
COMENTARIOS = 6444

# Los bancos con codigo, para volver a medir la densidad (tests/test_web.py)
BANCOS_CON_CODIGO = ("00", "01", "03", "04", "05", "06", "07")


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


PIE_LEGAL = {
    "es": "<em>Rastan Saga</em> lo public&oacute; Taito para MSX2 en 1988, en "
          "un cartucho de 256 KB. Todos los derechos sobre el juego siguen "
          "siendo de sus titulares. Este trabajo es de preservaci&oacute;n, "
          "estudio y documentaci&oacute;n, y la imagen del cartucho no se "
          "distribuye.",
    "en": "<em>Rastan Saga</em> was published by Taito for the MSX2 in 1988, on "
          "a 256 KB cartridge. All rights in the game remain with their "
          "holders. This is preservation, study and documentation work, and "
          "the cartridge image is not distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Rastan Saga - desensamblado comentado",
        claim="Las siete rondas, 255 pantallas montadas desde sus mapas con sus "
              "enemigos y sus jefes, Rastan en sus tres capas, la fase del "
              "drag&oacute;n que el juego se salta y un final que no pinta, todo "
              "dibujado desde la ROM.",
        ficha=["Taito - <b>(c) Taito 1988</b>",
               "MegaROM de <b>256 KB</b> (ASCII8)",
               "<b>MSX2</b>", "Volcado <b>03fa40fa...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las im&aacute;genes "
              "est&aacute;n <b>dibujadas desde los bytes de la ROM</b>: el "
              "t&iacute;tulo, las 257 pantallas de las 24 fases, Rastan, los 37 "
              "tipos de actor y los jefes, con las tablas del cartucho, y "
              "<b>cotejadas contra openMSX</b> en un MSX2 japon&eacute;s: el "
              "t&iacute;tulo y 256 pantallas, sin una diferencia; las figuras, "
              "ficha a ficha. El listado y las cifras se reproducen con "
              "<code>make</code>, y el reensamblado devuelve la ROM <b>byte a "
              "byte</b>.",
    ),
    "en": dict(
        titulo="Rastan Saga - a commented disassembly",
        claim="The seven rounds, 255 screens built from their maps with their "
              "enemies and bosses, Rastan in his three layers, the dragon stage "
              "the game skips and an ending it never draws, all drawn from the "
              "ROM.",
        ficha=["Taito - <b>(c) Taito 1988</b>",
               "A <b>256 KB</b> MegaROM (ASCII8)",
               "<b>MSX2</b>", "Dump <b>03fa40fa...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b>: the title, the 257 screens of the 24 "
              "stages, Rastan, the 37 actor types and the bosses, with the "
              "cartridge's own tables, and <b>checked against openMSX</b> on a "
              "Japanese MSX2: the title and 256 screens without a single "
              "difference; the figures, sprite record by sprite record. The "
              "listing and the numbers are reproducible with <code>make</code>, "
              "and reassembling gives back the ROM <b>byte for byte</b>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("La fase del drag&oacute;n que se salta",
         "<p>La fase 0x11 tiene su ficha, su paleta y su pantalla: un "
         "drag&oacute;n alado sobre el mar, con 130 tiles que no usa ninguna "
         "otra. <code>p00:5318</code> la salta: de la 0x10 se pasa a la "
         "0x12.</p><p>Montada desde la ROM.</p>"),
        ("Un truco de pruebas en la cabecera",
         "<p>El byte 0x4010 vale 0. Puesto a 1, la tecla 7 pasa a la fase "
         "siguiente, la 6 a la anterior y BS acaba la partida "
         "(<code>p00:5321</code>, <code>p00:5349</code>); en la "
         "presentaci&oacute;n, 4 y 5 cambian la p&aacute;gina de VRAM que se ve "
         "(<code>p00:4E41</code>).</p><p>Medido en openMSX con una copia de la "
         "ROM con ese byte a 1.</p>"),
        ("Un trono sin colocar",
         "<p>95 tiles del banco 0x19 forman un hombre sentado en un trono. No "
         "hay tabla que los coloque ni rutina localizada que los pinte.</p>"
         "<p>La colocaci&oacute;n es la de la l&aacute;mina de The Cutting Room "
         "Floor, cotejada tile a tile.</p>"),
        ("Un final sin pintar",
         "<p>El b&aacute;rbaro mirando al horizonte, con los bloques 0x2A-0x57 "
         "de la tabla del t&iacute;tulo. La tabla se corta en 0x6000, al final "
         "del banco 0, y las dos &uacute;ltimas filas de tiles se quedan fuera "
         "de ella. Ninguna rutina localizada lo pinta, y sus bloques no se leen "
         "en el recorrido de las 257 pantallas.</p><p>La paleta no est&aacute; "
         "en la ROM: es la de The Cutting Room Floor.</p>"),
        ("La ronda 6 no tiene jefe",
         "<p>Las rondas salen de la fase (<code>p00:566C</code>: fase / 3 + 1). "
         "A la 6 le tocan la 0x0F, la 0x10 y la 0x11, y la 0x11 es la que se "
         "salta: dos fases y ninguna sala de jefe. La 0x11 ocupa el sitio de "
         "esa sala y, como las cinco salas de jefe, es de una sola "
         "pantalla.</p><p>Le&iacute;do en el c&oacute;digo.</p>"),
        ("El &uacute;ltimo byte de cada 16 KB",
         "<p>Los tiles se copian a la VRAM de 16 KB en 16 KB con LDIRVM de "
         "0x3FFF bytes (<code>p01:6077</code>): el &uacute;ltimo byte de cada "
         "trozo se queda a 0.</p><p>Cotejado contra la VRAM de openMSX.</p>"),
    ],
    "en": [
        ("The dragon stage that gets skipped",
         "<p>Stage 0x11 has its record, its palette and its screen: a winged "
         "dragon over the sea, with 130 tiles no other stage uses. "
         "<code>p00:5318</code> skips it: from 0x10 the game goes to "
         "0x12.</p><p>Built from the ROM.</p>"),
        ("A test cheat in the header",
         "<p>Byte 0x4010 is 0. Set to 1, key 7 goes to the next stage, 6 to "
         "the previous one and BS ends the game (<code>p00:5321</code>, "
         "<code>p00:5349</code>); in the attract sequence, 4 and 5 change the "
         "VRAM page on display (<code>p00:4E41</code>).</p><p>Measured in "
         "openMSX on a copy of the ROM with that byte set to 1.</p>"),
        ("A throne with no layout",
         "<p>95 tiles in bank 0x19 make up a man sitting on a throne. There is "
         "no table that lays them out and no routine found that draws "
         "them.</p><p>The layout is the one in The Cutting Room Floor's "
         "picture, checked tile by tile.</p>"),
        ("An ending never drawn",
         "<p>The barbarian looking at the horizon, with blocks 0x2A-0x57 of "
         "the title's table. The table is cut at 0x6000, at the end of bank 0, "
         "and the last two rows of tiles fall outside it. No routine found "
         "draws it, and its blocks are not read in the run through the 257 "
         "screens.</p><p>The palette is not in the ROM: it is The Cutting Room "
         "Floor's.</p>"),
        ("Round 6 has no boss",
         "<p>The round comes from the stage (<code>p00:566C</code>: stage / 3 "
         "+ 1). Round 6 gets 0x0F, 0x10 and 0x11, and 0x11 is the one that is "
         "skipped: two stages and no boss room. 0x11 sits where that room "
         "would be and, like the five boss rooms, is a single screen.</p>"
         "<p>Read in the code.</p>"),
        ("The last byte of every 16 KB",
         "<p>The tiles go to VRAM 16 KB at a time with an LDIRVM of 0x3FFF "
         "bytes (<code>p01:6077</code>): the last byte of each piece stays at "
         "0.</p><p>Checked against openMSX's VRAM.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "La pantalla de t&iacute;tulo, montada desde la ROM: coincide con la VRAM "
     "de openMSX byte a byte (<code>coteja_titulo.py</code>).",
     "The title screen, built from the ROM: it matches openMSX's VRAM byte for "
     "byte (<code>coteja_titulo.py</code>)."),
    ("ronda_1.png",
     "La ronda 1: el exterior, el castillo y la sala del jefe, con los enemigos "
     "donde salen (<code>p00:58F9</code>), el jefe donde lo pone su rutina "
     "(<code>p04:8016</code>) y Rastan en la pantalla de salida, recuadrada.",
     "Round 1: the outdoors, the castle and the boss room, with the enemies "
     "where they come out (<code>p00:58F9</code>), the boss where its routine "
     "puts it (<code>p04:8016</code>) and Rastan on the starting screen, "
     "framed."),
    ("ronda_7.png",
     "La ronda 7: cinco fases que repiten los cinco jefes, cada uno en una "
     "pantalla concreta (<code>p04:8BF4</code>).",
     "Round 7: five stages that repeat the five bosses, each on a given "
     "screen (<code>p04:8BF4</code>)."),
    ("rastan.png",
     "Rastan: las 48 combinaciones distintas de sus tres capas "
     "(<code>p06:639F</code>, <code>p06:64B3</code> y el arma) en sus 92 "
     "poses, cotejadas ficha a ficha contra openMSX.",
     "Rastan: the 48 different combinations of his three layers "
     "(<code>p06:639F</code>, <code>p06:64B3</code> and the weapon) in his 92 "
     "poses, checked record by record against openMSX."),
    ("actores.png",
     "Los 37 tipos de actor, una pose por figura (<code>p00:4C68</code>), con "
     "la paleta de la primera fase en que salen.",
     "The 37 actor types, one pose per figure (<code>p00:4C68</code>), with "
     "the palette of the first stage they appear in."),
    ("jefes.png",
     "Los cinco jefes (<code>p03:7F76</code>, banco 8) y la muerte.",
     "The five bosses (<code>p03:7F76</code>, bank 8) and their death."),
    ("dragon_fase.png",
     "La fase 0x11, la del drag&oacute;n, que el juego se salta.",
     "Stage 0x11, the dragon's, which the game skips."),
    ("dragon_cabeza.png",
     "La cabeza del drag&oacute;n: bloques 0x60-0x77 de la tabla de la fase "
     "0x11, que su mapa no usa.",
     "The dragon's head: blocks 0x60-0x77 of stage 0x11's table, which its "
     "map does not use."),
    ("trono.png",
     "El trono: 95 tiles sin tabla, colocados como en la l&aacute;mina de The "
     "Cutting Room Floor.",
     "The throne: 95 tiles with no table, laid out as in The Cutting Room "
     "Floor's picture."),
    ("final.png",
     "El final: el b&aacute;rbaro mirando al horizonte.",
     "The ending: the barbarian looking at the horizon."),
    ("creditos.png",
     "El texto del final (<code>p04:8D01</code>) con la fuente del cartucho.",
     "The ending text (<code>p04:8D01</code>) in the cartridge's own font."),
]
