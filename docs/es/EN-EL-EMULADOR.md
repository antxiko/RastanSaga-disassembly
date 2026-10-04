# En el emulador

openMSX con una máquina MSX2 japonesa (`C-BIOS_MSX2_JP`) y el cartucho como
ASCII8. Las sondas se lanzan de una en una.

## Las sondas

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

## Los cotejos

| qué | contra qué | resultado |
|---|---|---|
| el título | la VRAM | 0 bytes distintos |
| las 257 pantallas | la página 0 de la VRAM | 256 a 0; la otra, a 0 sin un objeto que ya se ha recogido |
| las figuras de los actores | sus fichas en la RAM | 622 de 629 enteras; las otras 7, `anima` pillada a medias o fichas que pone otra rutina |
| Rastan | sus fichas en la RAM | 617 de 619 enteras |
| los datos sin dueño | las lecturas del recorrido | ninguna, salvo 16 bytes de la tabla de bloques A2C0 que repinta `p06:6226` |

## Para verlo

Con el byte 0x4010 de una copia de la ROM a 1: 7 y 6 cambian de fase y BS
acaba la partida.
