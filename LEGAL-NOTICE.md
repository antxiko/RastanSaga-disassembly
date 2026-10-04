# Legal notice and attribution

*(También disponible [en castellano](AVISO-LEGAL.md).)*

## Who owns what

**The game is not ours.** *Rastan Saga* was published by **Taito** for the
MSX2 in 1988, on a 256 KB cartridge. All rights over the game remain with
their holders.

**What is ours** are this repository's tools, the comments in the listing, the
analysis and the documentation. That is published under the licence in
`LICENSE`.

## What is in this repository

The files `src/rastan_pNN.asm` are the commented disassembly of the
cartridge's thirty-two banks. They are published for the **preservation,
study and documentation** of a title that is part of MSX software history.

The cartridge image (`.rom`) is **not** distributed here. Anyone who wants to
rebuild the listing has to supply their own, and the `Makefile` checks its
sha256 before doing anything.

The pictures in `docs/imagenes/` are neither artwork brought in from outside
nor screen captures: they are drawn by reading the cartridge's own tables, at
the addresses the listing gives, and checked against openMSX dumps. They are
part of the proof that the binary has been read correctly: if it had not, they
would come out as noise.

## What it rests on

Everything stated here comes from reading this binary or measuring it while
it runs, and each statement carries its evidence: the instruction that reads
a piece of data, the table that closes where it should, or the emulator dump.
Whatever is not settled is said to be so.

The layout of the throne and the palette of the throne and the ending come
from [The Cutting Room Floor](https://tcrf.net/)'s pictures, with thanks.

## If you are one of the authors

If you worked on *Rastan Saga* or hold rights over the game, and would rather
this material were not published, **say so and it will be taken down, no
questions asked**. The aim of this work is exactly the opposite of harming
you: it is to record how it was made.
