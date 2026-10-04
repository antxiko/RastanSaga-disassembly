# The code

## The interrupt is the engine

Start-up puts a jump to `p00:406C` in H.TIMI, and from then on the whole game
runs in the interrupt: on each vertical retrace, the music, five counters,
the sprites and the palette to the VDP, and one turn of the scheduler.

## Five tasks

The scheduler shares the frame among five tasks (`p00:429A`) that give up
their turn themselves (`cede`, `duerme`):

| task | what it does |
|---|---|
| 0 | the main one: attract sequence, demo and game, in a loop |
| 1 | the game, every two frames: pause, end of stage, edges |
| 2 | Rastan (`p06:6000`) |
| 3 | the enemies (`p03:6000`) or the boss (p04) |
| 4 | the DA20 things (`p05:6000`) |

## The sprites

Each figure is a definition (`p00:5AA5`): the base of its patterns, the
number of frames and, per frame, the duration and the sprites (pattern, x,
y, set). `anima` writes an 11-byte record per sprite; `p00:4534` copies the
pattern to VRAM with the banks the set says (bits 7-6: banks 14-15, 11-13 or
8-10) and the colour comes from `p00:4DF4`. The attributes are copied
rotating the first sprite every frame (`p00:4168`), so that more than eight
on a line flicker instead of disappearing.

## The sound

Four voices of 25 bytes: three for music and one for effects (`p01:617A`). 9
pieces of music with three scores each (`p01:64F0`) and 18 effects
(`p01:64CC`). A score holds notes (duration and tone), rests, volume and tone
envelopes, jumps, calls and repeats (`p01:6253`).

## How the listing is made

32 modules, one per bank, each with its `org`. The code is traced by
following the flow; the data is walked by `tools/datos.py` the way the
cartridge walks it, and whatever nothing walks was measured in openMSX
(`tools/omsx_lecturas.tcl`). 29,820 bytes of code and 232,324 of data: 100%.
13,982 instructions, 46.1% commented; 1,406 routines, none below 10%.
