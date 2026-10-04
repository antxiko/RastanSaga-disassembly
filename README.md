# Rastan Saga — a commented disassembly

*(También en [castellano](README.es.md).)*

A commented disassembly of ***Rastan Saga***, Taito, 1988, for the **MSX2**:
a 256 KB MegaROM with the ASCII8 mapper, thirty-two banks of 8 KB.

**The site**: https://antxiko.github.io/RastanSaga-disassembly/

| | |
|---|---|
| explained | 100% (29,820 bytes of code, 232,324 of data) |
| commented | 46.1% of the instructions |
| routines | 1,406, none below 10% |
| reassembly | the ROM, byte for byte |
| pictures | drawn from the ROM and checked against openMSX |

## What is here

- The listing of the thirty-two banks (`src/rastan_pNN.asm`), generated from
  the binary and the notes, which reassembles the exact ROM.
- The seven rounds, the 257 screens of the 24 stages, built from their maps
  with their enemies and bosses.
- Rastan in his three layers, the 37 actor types, the five bosses, the dragon
  stage the game skips, the throne and the ending.
- The checks against openMSX and the tests (`make test`).

## How to reproduce it

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own image of the cartridge** as `rastan.rom` in the root:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

The details, in [Getting started](docs/GETTING-STARTED.md).

## Notice

The game belongs to Taito; this is only the analysis, the comments and the
tools. The ROM is not distributed. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
