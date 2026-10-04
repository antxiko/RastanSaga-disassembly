# Getting started

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own image of the cartridge** as `rastan.rom` in the root:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

`make` generates the listing of the 32 banks, reassembles it, checks that the
ROM comes out byte for byte and runs the tests.

## What each step does

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

## Where everything is

| place | what is there |
|---|---|
| `src/pNN.notes` | each bank's names, comments and data ranges |
| `src/rastan_pNN.asm` | the listing, generated |
| `tools/datos.py` | walks the data the way the code does: says which structure reads each byte |
| `tools/graficos/` | the title, the stages, the figures, the secrets |
| `tools/omsx_*.tcl` | the openMSX probes |
| `tests/` | the tests |
