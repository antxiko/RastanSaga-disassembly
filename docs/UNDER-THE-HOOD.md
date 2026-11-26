# Under the hood

## Getting started

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own image of the cartridge** as `rastan.rom` in the root:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

`make` generates the listing of the 32 banks, reassembles it, checks that the
ROM comes out byte for byte and runs the tests.

### What each step does

| target | what it does |
|---|---|
| `make comprueba` | the ROM's sha256 |
| `make trace` | traces each bank's code by following the flow |
| `make listado` | generates `src/rastan_pNN.asm` from the binary and the notes |
| `make verify` | reassembles the 32 banks and compares them with the ROM |
| `make sanity` | not one byte unexplained: traced code or named data |
| `make densidad` | the commented percentage, bank by bank |
| `make imagenes` | every picture on the site, from the ROM |
| `make web` | the pages and both front pages |

### Where everything is

| place | what is there |
|---|---|
| `src/pNN.notes` | each bank's names, comments and data ranges |
| `src/rastan_pNN.asm` | the listing, generated |
| `tools/datos.py` | walks the data the way the code does: says which structure reads each byte |
| `tools/graficos/` | the title, the stages, the figures, the secrets |
| `tools/omsx_*.tcl` | the openMSX probes |
| `tests/` | the tests |

## The cartridge

| | |
|---|---|
| title | *Rastan Saga*, Taito, 1988 |
| machine | MSX2 (V9938), SCREEN 5 |
| size | 262,144 bytes: 32 banks of 8 KB |
| mapper | ASCII8 |
| sound | PSG, three channels |
| sha256 | `03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e` |

The header is `AB` with INIT at 0x4011. Byte 0x4010 is the switch for the
test cheat (see [Findings](CURIOSITIES.html)).

### The mapper

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

### What is in each bank

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

### VRAM

The screen on display is page 0. The tiles (banks 0x10-0x19) are copied at
start-up to 0xC000 and to pages 2 and 3 (`p01:6077`). Sprites are in mode 2:
colours at 0x8400, attributes at 0x8600 and patterns at 0x8800; each pattern
is copied from the ROM when it changes (`p00:4534`).

### The RAM that matters

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

## The code

### The interrupt is the engine

Start-up puts a jump to `p00:406C` in H.TIMI, and from then on the whole game
runs in the interrupt: on each vertical retrace, the music, five counters,
the sprites and the palette to the VDP, and one turn of the scheduler.

### Five tasks

The scheduler shares the frame among five tasks (`p00:429A`) that give up
their turn themselves (`cede`, `duerme`):

| task | what it does |
|---|---|
| 0 | the main one: attract sequence, demo and game, in a loop |
| 1 | the game, every two frames: pause, end of stage, edges |
| 2 | Rastan (`p06:6000`) |
| 3 | the enemies (`p03:6000`) or the boss (p04) |
| 4 | the DA20 things (`p05:6000`) |

### The sprites

Each figure is a definition (`p00:5AA5`): the base of its patterns, the
number of frames and, per frame, the duration and the sprites (pattern, x,
y, set). `anima` writes an 11-byte record per sprite; `p00:4534` copies the
pattern to VRAM with the banks the set says (bits 7-6: banks 14-15, 11-13 or
8-10) and the colour comes from `p00:4DF4`. The attributes are copied
rotating the first sprite every frame (`p00:4168`), so that more than eight
on a line flicker instead of disappearing.

### The sound

Four voices of 25 bytes: three for music and one for effects (`p01:617A`). 9
pieces of music with three scores each (`p01:64F0`) and 18 effects
(`p01:64CC`). A score holds notes (duration and tone), rests, volume and tone
envelopes, jumps, calls and repeats (`p01:6253`).

### How the listing is made

32 modules, one per bank, each with its `org`. The code is traced by
following the flow; the data is walked by `tools/datos.py` the way the
cartridge walks it, and whatever nothing walks was measured in openMSX
(`tools/omsx_lecturas.tcl`). 29,820 bytes of code and 232,324 of data: 100%.
13,982 instructions, 46.1% commented; 1,406 routines, none below 10%.

## In the emulator

openMSX with a Japanese MSX2 machine (`C-BIOS_MSX2_JP`) and the cartridge as
ASCII8. The probes are run one at a time.

### The probes

| probe | what it does |
|---|---|
| `omsx_pantallas.tcl` | goes through the 257 screens and dumps VRAM, RAM and the palette |
| `omsx_sprites.tcl` | the same run, with the sprite area of VRAM: 1,020 dumps |
| `omsx_lecturas.tcl` | logs which bank each mapper write sets and which patterns, definitions, blocks and scores the cartridge reads |
| `omsx_huerfanas.tcl` | whether any of the 61 pieces of code with no call runs, or either of the two tables with no pointer found is read |
| `omsx_truco.tcl` | the 0x4010 cheat, on a copy of the ROM |

"What was measured" is the sum of two runs: the 257 screens one by one, and
the demo, the five bosses fought and killed in their room and in round 7, and
the ending.

### The checks

| what | against what | result |
|---|---|---|
| the title | VRAM | 0 bytes different |
| the 257 screens | VRAM page 0 | 256 at 0; the other, at 0 without an object already picked up |
| the actors' figures | their records in RAM | 622 of 629 whole; the other 7, `anima` caught halfway or records set by another routine |
| Rastan | his records in RAM | 617 of 619 whole |
| the data with no owner | the reads during the run | none, except 16 bytes of block table A2C0 that `p06:6226` repaints |

### To see it

With byte 0x4010 of a copy of the ROM set to 1: 7 and 6 change stage and BS
ends the game.
