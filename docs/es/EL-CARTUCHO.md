# El cartucho

| | |
|---|---|
| título | *Rastan Saga*, Taito, 1988 |
| máquina | MSX2 (V9938), SCREEN 5 |
| tamaño | 262.144 bytes: 32 bancos de 8 KB |
| mapper | ASCII8 |
| sonido | PSG, tres canales |
| sha256 | `03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e` |

La cabecera es `AB` con INIT en 0x4011. El byte 0x4010 es el interruptor del
truco de pruebas (ver [Hallazgos](HALLAZGOS.md)).

## El mapper

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

## Qué hay en cada banco

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

## La VRAM

La pantalla que se ve es la página 0. Los tiles (bancos 0x10-0x19) se copian
al empezar a 0xC000 y a las páginas 2 y 3 (`p01:6077`). Los sprites van en
modo 2: colores en 0x8400, atributos en 0x8600 y patrones en 0x8800; cada
patrón se copia desde la ROM cuando cambia (`p00:4534`).

## La RAM que importa

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
