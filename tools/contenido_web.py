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
ESTILO = '\n:root{--tinta:#cfd0d4;--suave:#83868f;--fondo:#000;--panel:#0c0e13;--linea:#23262e;\n  --rojo:#ff897d;--cyan:#65dbef;--verde:#3eb849;--oro:#ded087}\n@media (prefers-color-scheme:light){:root{--tinta:#191a1e;--suave:#5a5d66;--fondo:#e9e7e1;\n  --panel:#f7f6f2;--linea:#d0cdc5;--rojo:#b23f34;--cyan:#1c6b7c;--verde:#2b7734;--oro:#8a7420}}\n:root[data-theme="dark"]{--tinta:#cfd0d4;--suave:#83868f;--fondo:#000;--panel:#0c0e13;\n  --linea:#23262e;--rojo:#ff897d;--cyan:#65dbef;--verde:#3eb849;--oro:#ded087}\n:root[data-theme="light"]{--tinta:#191a1e;--suave:#5a5d66;--fondo:#e9e7e1;--panel:#f7f6f2;\n  --linea:#d0cdc5;--rojo:#b23f34;--cyan:#1c6b7c;--verde:#2b7734;--oro:#8a7420}\n*{box-sizing:border-box}\nbody{margin:0;background:var(--fondo);color:var(--tinta);padding:0 1.25rem 6rem;\n  font:15px/1.7 ui-monospace,"SF Mono",Menlo,Consolas,monospace}\n.w{max-width:1120px;margin:0 auto}\n.n{max-width:68ch}\nh1,h2,h3,h4{font-weight:400;text-wrap:balance}\na{color:var(--cyan)}\nimg{image-rendering:pixelated;max-width:100%;height:auto;display:block}\nheader.top{display:flex;flex-direction:column;align-items:center;gap:1.5rem;\n  padding:4rem 0 2rem;text-align:center}\nheader.top img{width:min(100%,642px)}\n.claim{max-width:60ch;color:var(--suave);font-size:1.05rem}\n.claim b{color:var(--tinta);font-weight:400}\n.ficha{display:flex;flex-wrap:wrap;justify-content:center;gap:0 1.5rem;width:100%;\n  font-size:12px;letter-spacing:.08em;text-transform:uppercase;color:var(--suave);\n  border-top:1px solid var(--linea);border-bottom:1px solid var(--linea);padding:.85rem 0}\n.ficha b{color:var(--rojo);font-weight:400}\nnav{display:flex;flex-wrap:wrap;gap:1.25rem;justify-content:center;padding:1.25rem 0;\n  font-size:12px;letter-spacing:.08em;text-transform:uppercase}\nnav a{color:var(--suave);text-decoration:none;border-bottom:1px solid transparent}\nnav a:hover,nav a:focus{color:var(--tinta);border-bottom-color:var(--rojo)}\nnav.docs{border-top:1px solid var(--linea);border-bottom:1px solid var(--linea);\n  margin-bottom:1rem}\nsection{margin-top:4.5rem;scroll-margin-top:1rem}\nsection>h2{font-size:1rem;letter-spacing:.1em;text-transform:uppercase;\n  border-left:3px solid var(--rojo);padding-left:.9rem;margin:0 0 1.5rem}\n.cifras{display:grid;gap:1px;background:var(--linea);border:1px solid var(--linea);\n  grid-template-columns:repeat(auto-fit,minmax(160px,1fr))}\n.cifra{background:var(--panel);padding:1.1rem}\n.cifra b{display:block;font-size:1.7rem;color:var(--oro);font-weight:400;\n  font-variant-numeric:tabular-nums;line-height:1.2}\n.cifra span{font-size:11px;letter-spacing:.07em;text-transform:uppercase;color:var(--suave)}\n.hall{border-top:1px solid var(--linea);padding-top:1.75rem;margin-top:2.5rem}\n.hall:first-of-type{border-top:0;padding-top:0;margin-top:0}\n.hall h3{margin:0 0 .75rem;font-size:1.15rem;color:var(--rojo)}\n.hall h4{color:var(--oro);margin:1.5rem 0 .5rem;font-size:.95rem}\n.hall p{margin:0 0 1rem}\npre.asm{background:var(--panel);border-left:2px solid var(--verde);margin:1.25rem 0;\n  padding:1rem 1.1rem;overflow-x:auto;font-size:13px;line-height:1.6;color:var(--tinta)}\n.par{display:grid;gap:1.25rem;grid-template-columns:1fr}\n@media(min-width:820px){.par{grid-template-columns:1fr 1fr}}\n.par figure{margin:0}\ntable{border-collapse:collapse;width:100%;margin:1.25rem 0;font-size:13px;display:block;\n  overflow-x:auto}\nth,td{text-align:left;padding:.5rem .75rem;border-bottom:1px solid var(--linea)}\nth{color:var(--suave);font-weight:400;font-size:11px;letter-spacing:.07em;text-transform:uppercase}\ntd.num{font-variant-numeric:tabular-nums;color:var(--oro)}\n.nivel{margin-top:2rem}\n.nivel h3{margin:0 0 .9rem;font-size:.95rem;letter-spacing:.06em;text-transform:uppercase}\n.nivel em{color:var(--cyan);font-style:normal}\n.sep{color:var(--suave);margin:0 .6rem}\n.rejilla{display:grid;gap:.9rem;grid-template-columns:repeat(auto-fill,minmax(250px,1fr))}\n.rejilla figure{margin:0;background:var(--panel);box-shadow:0 0 0 1px var(--linea)}\n.rejilla figcaption{display:flex;justify-content:space-between;padding:.45rem .65rem;\n  font-size:11px;color:var(--suave);border-top:1px solid var(--linea)}\n.dir{font-variant-numeric:tabular-nums;color:var(--verde)}\nfooter{margin-top:5rem;padding-top:1.5rem;border-top:1px solid var(--linea);\n  color:var(--suave);font-size:12px}\n\n/* Aviso de trabajo en curso: tiene que verse antes que las cifras, porque un\n   100% mal leido hace mas dano que no ponerlo. */\n.aviso{background:#3a2a10;border-left:3px solid var(--oro);margin:1.5rem auto;\n  padding:1rem 1.2rem;max-width:900px;border-radius:4px}\n.aviso p{margin:0;color:var(--tinta);font-size:15px;line-height:1.65}\n.galeria{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));\n  gap:1.5rem;margin:1.5rem 0}\n.galeria figure{margin:0}\n.galeria img{width:100%;height:auto;image-rendering:pixelated;\n  border:1px solid var(--linea);border-radius:3px}\n.galeria figcaption{color:var(--suave);font-size:13px;margin-top:.5rem}\naudio{display:block;width:100%;max-width:640px;margin:.75rem 0 1.5rem}\n'

# La portada: las cifras y el pie tal como estaban
for _i, _c in {'es': ([('100 %', 'del binario explicado'), ('1.406', 'rutinas con nombre'), ('46,1 %', 'del listado comentado'), ('29.820', 'bytes de código'), ('232.324', 'bytes de datos'), ('0', 'bytes sin identificar')], 'El cartucho en cifras', 'Esto es trabajo de documentación y preservación: el código y los gráficos siguen siendo de sus autores y de Taito, y la imagen del cartucho no se distribuye.'), 'en': ([('100%', 'of the binary explained'), ('1,406', 'named routines'), ('46.1%', 'of the listing commented'), ('29,820', 'bytes of code'), ('232,324', 'bytes of data'), ('0', 'bytes unidentified')], 'The cartridge in numbers', 'This is documentation and preservation work: the code and artwork still belong to their authors and to Taito, and the cartridge image is not distributed.')}.items():
    PORTADA[_i]["cifras"] = _c[0]
    PORTADA[_i]["h_num"] = _c[1]
    PORTADA[_i]["pie_leg"] = _c[2]

PAGINAS = [
    [('THE-GAME.html', 'EL-JUEGO.html', 'The game', 'El juego',
      'what the game is and how it plays',
      'qu&eacute; es el juego y c&oacute;mo se juega'),
     ('THE-PICTURES.html', 'LAS-IMAGENES.html', 'What the cartridge draws', 'Lo que el cartucho dibuja',
      'every picture drawn from the ROM, with its caption',
      'todas las im&aacute;genes dibujadas desde la ROM, con su pie')],
    [('CURIOSITIES.html', 'CURIOSIDADES.html', 'Curiosities', 'Curiosidades',
      'what turned up when taking it apart, and what is still open',
      'lo que apareci&oacute; al desmontarlo y lo que queda abierto')],
    [('UNDER-THE-HOOD.html', 'POR-DENTRO.html', 'Under the hood', 'Por dentro',
      'getting started, the cartridge, the code and the emulator',
      'empezar, el cartucho, el c&oacute;digo y el emulador')],
]

VIEJAS = {
    'FINDINGS.html': 'CURIOSITIES.html',
    'HALLAZGOS.html': 'CURIOSIDADES.html',
    'GETTING-STARTED.html': 'UNDER-THE-HOOD.html',
    'EMPEZAR.html': 'POR-DENTRO.html',
    'IN-THE-EMULATOR.html': 'UNDER-THE-HOOD.html',
    'EN-EL-EMULADOR.html': 'POR-DENTRO.html',
    'OPEN-QUESTIONS.html': 'CURIOSITIES.html',
    'PREGUNTAS-ABIERTAS.html': 'CURIOSIDADES.html',
    'THE-CARTRIDGE.html': 'UNDER-THE-HOOD.html',
    'EL-CARTUCHO.html': 'POR-DENTRO.html',
    'THE-CODE.html': 'UNDER-THE-HOOD.html',
    'EL-CODIGO.html': 'POR-DENTRO.html',
}
