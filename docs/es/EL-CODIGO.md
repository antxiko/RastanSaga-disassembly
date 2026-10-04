# El código

## La interrupción es el motor

El arranque pone en H.TIMI un salto a `p00:406C` y desde ahí todo el juego
corre en la interrupción: en cada retrazo vertical, la música, cinco
contadores, los sprites y la paleta al VDP y un turno del planificador.

## Cinco tareas

El planificador reparte el cuadro entre cinco tareas (`p00:429A`) que ceden
el turno ellas mismas (`cede`, `duerme`):

| tarea | qué hace |
|---|---|
| 0 | la principal: presentación, demo y partida, en bucle |
| 1 | la partida, cada dos cuadros: pausa, fin de fase, bordes |
| 2 | Rastan (`p06:6000`) |
| 3 | los enemigos (`p03:6000`) o el jefe (p04) |
| 4 | las cosas de DA20 (`p05:6000`) |

## Los sprites

Cada figura es una definición (`p00:5AA5`): la base de sus patrones, el
número de cuadros y, por cuadro, la duración y los sprites (patrón, x, y,
juego). `anima` escribe una ficha de 11 bytes por sprite; `p00:4534` copia el
patrón a la VRAM con los bancos que dice el juego (bits 7-6: bancos 14-15,
11-13 u 8-10) y el color sale de `p00:4DF4`. Los atributos se copian girando
el primer sprite cada cuadro (`p00:4168`), para que más de ocho en una línea
parpadeen en vez de desaparecer.

## El sonido

Cuatro voces de 25 bytes: tres de música y una de efectos (`p01:617A`). 9
músicas de tres partituras (`p01:64F0`) y 18 efectos (`p01:64CC`). La
partitura lleva notas (duración y tono), silencios, envolventes de volumen y
de tono, saltos, llamadas y repeticiones (`p01:6253`).

## Cómo está hecho el listado

32 módulos, uno por banco, cada uno con su `org`. El código se traza
siguiendo el flujo; los datos los recorre `tools/datos.py` como los recorre
el cartucho, y lo que no recorre nadie se midió en openMSX
(`tools/omsx_lecturas.tcl`). 29.820 bytes de código y 232.324 de datos: el
100 %. 13.982 instrucciones, el 46,1 % comentadas; 1.406 rutinas, ninguna por
debajo del 10 %.
