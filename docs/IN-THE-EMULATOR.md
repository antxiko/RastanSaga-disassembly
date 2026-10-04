# In the emulator

openMSX with a Japanese MSX2 machine (`C-BIOS_MSX2_JP`) and the cartridge as
ASCII8. The probes are run one at a time.

## The probes

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

## The checks

| what | against what | result |
|---|---|---|
| the title | VRAM | 0 bytes different |
| the 257 screens | VRAM page 0 | 256 at 0; the other, at 0 without an object already picked up |
| the actors' figures | their records in RAM | 622 of 629 whole; the other 7, `anima` caught halfway or records set by another routine |
| Rastan | his records in RAM | 617 of 619 whole |
| the data with no owner | the reads during the run | none, except 16 bytes of block table A2C0 that `p06:6226` repaints |

## To see it

With byte 0x4010 of a copy of the ROM set to 1: 7 and 6 change stage and BS
ends the game.
