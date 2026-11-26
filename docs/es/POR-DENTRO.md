# Por dentro

## Empezar

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `rastan.rom` en la raíz:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

`make` genera el listado de los 32 bancos, lo reensambla, comprueba que sale
la ROM byte a byte y pasa los tests.

### Qué hace cada paso

| orden | qué hace |
|---|---|
| `make comprueba` | el sha256 de la ROM |
| `make trace` | traza el código de cada banco siguiendo el flujo |
| `make listado` | genera `src/rastan_pNN.asm` desde el binario y las notas |
| `make verify` | reensambla los 32 bancos y los compara con la ROM |
| `make sanity` | ni un byte sin explicar: código trazado o datos con nombre |
| `make densidad` | el porcentaje comentado, banco a banco |
| `make imagenes` | todas las imágenes de la web, desde la ROM |
| `make web` | las páginas y las dos portadas |

### Dónde está cada cosa

| sitio | qué hay |
|---|---|
| `src/pNN.notes` | los nombres, los comentarios y los rangos de datos de cada banco |
| `src/rastan_pNN.asm` | el listado, generado |
| `tools/datos.py` | recorre los datos como el código: dice qué estructura lee cada byte |
| `tools/graficos/` | el título, las fases, las figuras, los secretos |
| `tools/omsx_*.tcl` | las sondas de openMSX |
| `tests/` | los tests |

## El cartucho

| | |
|---|---|
| título | *Rastan Saga*, Taito, 1988 |
| máquina | MSX2 (V9938), SCREEN 5 |
| tamaño | 262.144 bytes: 32 bancos de 8 KB |
| mapper | ASCII8 |
| sonido | PSG, tres canales |
| sha256 | `03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e` |

La cabecera es `AB` con INIT en 0x4011. El byte 0x4010 es el interruptor del
truco de pruebas (ver [Hallazgos](CURIOSIDADES.html)).

### El mapper

Cuatro huecos de 8 KB, cada uno con su registro: 0x67F8, 0x6FF8, 0x77F8 y
0x7FF8. Hay 54 escrituras con banco fijo y 12 con banco variable (los mapas,
que van en la ficha), y todas cumplen la regla: cada banco va siempre al
mismo hueco (`tools/paginas.py mide`). La única excepción es el banco 0, que
`p00:47E0` vuelve a poner en 0xA000 después de pintar un bloque.

| hueco | bancos |
|---|---|
| 0x4000 | 0 |
| 0x6000 | 1, 3, 5, 6, 8, 11, 14 |
| 0x8000 | 2, 4, 7, 9, 12, 15, 16, 18, 20, 22, 24, 26, 28, 30 |
| 0xA000 | 10, 13, 17, 19, 21, 23, 25, 27, 29, 31 |

### Qué hay en cada banco

| banco | código | qué lleva |
|---|---|---|
| 0 | 5.966 B | el arranque, la interrupción, las tareas, la partida, las pantallas, los sprites; el título |
| 1 | 1.128 B | el sonido (intérprete, músicas y efectos) y la carga de los tiles a la VRAM |
| 2 | — | más partituras, las 24 fichas de fase, sus pantallas y sus paletas |
| 3 | 7.536 B | los actores: cómo se mueve cada tipo (tarea 3) y el reparto a los jefes; sus poses |
| 4 | 2.769 B | los cinco jefes, la ronda 7 y el final |
| 5 | 1.340 B | las cosas de DA20: decorado, puertas, piedras, gotas |
| 6 | 6.722 B | Rastan: los mandos, sus tres capas, la barra de vida y el marcador |
| 7 | 4.359 B | lo que coge Rastan, los puntos, los choques y los golpes |
| 8-15 | — | patrones de sprite (y en el 8, las definiciones de los jefes) |
| 16-25 | — | los tiles, que van enteros a la VRAM |
| 26 | — | las definiciones de sprite de Rastan y de los tipos 0x18 en adelante |
| 27 | — | las tablas de bloques de las fases |
| 28-31 | — | los mapas; el 30, además, las definiciones de los tipos 0x01-0x17 |

### La VRAM

La pantalla que se ve es la página 0. Los tiles (bancos 0x10-0x19) se copian
al empezar a 0xC000 y a las páginas 2 y 3 (`p01:6077`). Los sprites van en
modo 2: colores en 0x8400, atributos en 0x8600 y patrones en 0x8800; cada
patrón se copia desde la ROM cuando cambia (`p00:4534`).

### La RAM que importa

| dirección | qué |
|---|---|
| D5E5 | la fase |
| D5F0 / D5F1 | columna y fila de la pantalla |
| D8FC / D8FD | x e y de Rastan |
| D8F4 / D8F5 | su pose y lo que lleva |
| D910 | bits de la partida: fase acabada, jefe, sin perder vida |
| D17D | bits de la partida: fin, demo |
| D933 | los 6 actores de la pantalla, 38 bytes cada uno |
| DA20 | los 8 enemigos, 38 bytes cada uno |
| D413 | las 32 fichas de sprite, 11 bytes |
| D08E | las cuatro voces del sonido, 25 bytes |

## El código

### La interrupción es el motor

El arranque pone en H.TIMI un salto a `p00:406C` y desde ahí todo el juego
corre en la interrupción: en cada retrazo vertical, la música, cinco
contadores, los sprites y la paleta al VDP y un turno del planificador.

### Cinco tareas

El planificador reparte el cuadro entre cinco tareas (`p00:429A`) que ceden
el turno ellas mismas (`cede`, `duerme`):

| tarea | qué hace |
|---|---|
| 0 | la principal: presentación, demo y partida, en bucle |
| 1 | la partida, cada dos cuadros: pausa, fin de fase, bordes |
| 2 | Rastan (`p06:6000`) |
| 3 | los enemigos (`p03:6000`) o el jefe (p04) |
| 4 | las cosas de DA20 (`p05:6000`) |

### Los sprites

Cada figura es una definición (`p00:5AA5`): la base de sus patrones, el
número de cuadros y, por cuadro, la duración y los sprites (patrón, x, y,
juego). `anima` escribe una ficha de 11 bytes por sprite; `p00:4534` copia el
patrón a la VRAM con los bancos que dice el juego (bits 7-6: bancos 14-15,
11-13 u 8-10) y el color sale de `p00:4DF4`. Los atributos se copian girando
el primer sprite cada cuadro (`p00:4168`), para que más de ocho en una línea
parpadeen en vez de desaparecer.

### El sonido

Cuatro voces de 25 bytes: tres de música y una de efectos (`p01:617A`). 9
músicas de tres partituras (`p01:64F0`) y 18 efectos (`p01:64CC`). La
partitura lleva notas (duración y tono), silencios, envolventes de volumen y
de tono, saltos, llamadas y repeticiones (`p01:6253`).

### Cómo está hecho el listado

32 módulos, uno por banco, cada uno con su `org`. El código se traza
siguiendo el flujo; los datos los recorre `tools/datos.py` como los recorre
el cartucho, y lo que no recorre nadie se midió en openMSX
(`tools/omsx_lecturas.tcl`). 29.820 bytes de código y 232.324 de datos: el
100 %. 13.982 instrucciones, el 46,1 % comentadas; 1.406 rutinas, ninguna por
debajo del 10 %.

## En el emulador

openMSX con una máquina MSX2 japonesa (`C-BIOS_MSX2_JP`) y el cartucho como
ASCII8. Las sondas se lanzan de una en una.

### Las sondas

| sonda | qué hace |
|---|---|
| `omsx_pantallas.tcl` | recorre las 257 pantallas y vuelca la VRAM, la RAM y la paleta |
| `omsx_sprites.tcl` | el mismo recorrido, con la zona de sprites de la VRAM: 1.020 volcados |
| `omsx_lecturas.tcl` | apunta qué banco pone cada escritura al mapper y qué patrones, definiciones, bloques y partituras lee el cartucho |
| `omsx_huerfanas.tcl` | si se ejecuta alguno de los 61 trozos de código sin llamada, o se lee alguna de las dos tablas sin puntero localizado |
| `omsx_truco.tcl` | el truco de 0x4010, sobre una copia de la ROM |

"Lo medido" es la suma de dos recorridos: las 257 pantallas una a una, y la
demo, los cinco jefes peleados y muertos en su sala y en la ronda 7, y el
final.

### Los cotejos

| qué | contra qué | resultado |
|---|---|---|
| el título | la VRAM | 0 bytes distintos |
| las 257 pantallas | la página 0 de la VRAM | 256 a 0; la otra, a 0 sin un objeto que ya se ha recogido |
| las figuras de los actores | sus fichas en la RAM | 622 de 629 enteras; las otras 7, `anima` pillada a medias o fichas que pone otra rutina |
| Rastan | sus fichas en la RAM | 617 de 619 enteras |
| los datos sin dueño | las lecturas del recorrido | ninguna, salvo 16 bytes de la tabla de bloques A2C0 que repinta `p06:6226` |

### Para verlo

Con el byte 0x4010 de una copia de la ROM a 1: 7 y 6 cambian de fase y BS
acaba la partida.
