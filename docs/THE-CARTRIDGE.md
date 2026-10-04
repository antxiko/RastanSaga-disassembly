# The cartridge

| | |
|---|---|
| title | *Rastan Saga*, Taito, 1988 |
| machine | MSX2 (V9938), SCREEN 5 |
| size | 262,144 bytes: 32 banks of 8 KB |
| mapper | ASCII8 |
| sound | PSG, three channels |
| sha256 | `03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e` |

The header is `AB` with INIT at 0x4011. Byte 0x4010 is the switch for the
test cheat (see [Findings](FINDINGS.md)).

## The mapper

Four 8 KB windows, each with its register: 0x67F8, 0x6FF8, 0x77F8 and
0x7FF8. There are 54 writes with a fixed bank and 12 with a variable one
(the maps, which come in the stage record), and all of them follow the rule:
each bank always goes to the same window (`tools/paginas.py mide`). The only
exception is bank 0, which `p00:47E0` puts back at 0xA000 after drawing a
block.

| window | banks |
|---|---|
| 0x4000 | 0 |
| 0x6000 | 1, 3, 5, 6, 8, 11, 14 |
| 0x8000 | 2, 4, 7, 9, 12, 15, 16, 18, 20, 22, 24, 26, 28, 30 |
| 0xA000 | 10, 13, 17, 19, 21, 23, 25, 27, 29, 31 |

## What is in each bank

| bank | code | what it holds |
|---|---|---|
| 0 | 5,966 B | start-up, the interrupt, the tasks, the game loop, screens, sprites; the title |
| 1 | 1,128 B | the sound (player, music and effects) and loading the tiles into VRAM |
| 2 | — | more scores, the 24 stage records, their screens and their palettes |
| 3 | 7,536 B | the actors: how each type moves (task 3) and the hand-off to the bosses; their poses |
| 4 | 2,769 B | the five bosses, round 7 and the ending |
| 5 | 1,340 B | the DA20 things: scenery, doors, rocks, drops |
| 6 | 6,722 B | Rastan: the controls, his three layers, the life bar and the status bar |
| 7 | 4,359 B | what Rastan picks up, the points, the collisions and the hits |
| 8-15 | — | sprite patterns (and in 8, the bosses' definitions) |
| 16-25 | — | the tiles, which go to VRAM whole |
| 26 | — | the sprite definitions of Rastan and of types 0x18 onwards |
| 27 | — | the stages' block tables |
| 28-31 | — | the maps; 30 also holds the definitions of types 0x01-0x17 |

## VRAM

The screen on display is page 0. The tiles (banks 0x10-0x19) are copied at
start-up to 0xC000 and to pages 2 and 3 (`p01:6077`). Sprites are in mode 2:
colours at 0x8400, attributes at 0x8600 and patterns at 0x8800; each pattern
is copied from the ROM when it changes (`p00:4534`).

## The RAM that matters

| address | what |
|---|---|
| D5E5 | the stage |
| D5F0 / D5F1 | the screen's column and row |
| D8FC / D8FD | Rastan's x and y |
| D8F4 / D8F5 | his pose and what he carries |
| D910 | game bits: stage over, boss, no life lost |
| D17D | game bits: end, demo |
| D933 | the screen's 6 actors, 38 bytes each |
| DA20 | the 8 enemies, 38 bytes each |
| D413 | the 32 sprite records, 11 bytes |
| D08E | the four sound voices, 25 bytes |
