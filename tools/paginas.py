#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Es un cartucho de 256 KB con el mapper ASCII8: 32 bancos de 8 KB y cuatro
registros, uno por ranura -0x6000 elige el banco de 0x4000-0x5FFF, 0x6800 el de
0x6000-0x7FFF, 0x7000 el de 0x8000-0x9FFF y 0x7800 el de 0xA000-0xBFFF-. El
cartucho escribe siempre en 0x67F8, 0x6FF8, 0x77F8 y 0x7FF8.

Con ASCII8 cualquier banco puede ir en cualquier ranura, asi que el org de
cada banco no sale de una formula: sale de las escrituras al mapper, que
`paginas.py mide <rom>` vuelve a contar. Todas son `ld a,N / ld (copia),a /
ld (registro),a` con N fijo, salvo cuatro pares que leen la copia de RAM y
dos que leen 0xD5E9 (0x1C o 0x1E, de la ficha de fase). Lo que dicen:
  - 0x4000 lleva siempre el banco 0: la unica escritura a 0x67F8 es la de
    INIT (p00:403D), con 0.
  - Cada banco de 1 a 31 entra siempre en la MISMA ranura. Hay una sola
    excepcion: p00:47E5 escribe un 0 en 0x7FF8 (deja el banco 0 tambien en
    0xA000); el banco 0 se ejecuta en 0x4000 y esa copia no se lee.
Si alguna vez aparece un banco en dos ranuras, esta regla deja de valer para
ESE banco y habra que partirlo en dos modulos.

Uso como programa:
    paginas.py org <n>               imprime el org del banco n
    paginas.py lista                 imprime "n org" para los 32
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada banco
    paginas.py mide <rom>            cuenta las escrituras al mapper y las coteja
"""
import os
import re
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 32

R4, R6, R8, RA = 0x4000, 0x6000, 0x8000, 0xA000
# banco -> direccion de ejecucion. Medido, no supuesto: `paginas.py mide`.
ORG = {
    0: R4, 1: R6, 2: R8, 3: R6, 4: R8, 5: R6, 6: R6, 7: R8,
    8: R6, 9: R8, 10: RA, 11: R6, 12: R8, 13: RA, 14: R6, 15: R8,
    16: R8, 17: RA, 18: R8, 19: RA, 20: R8, 21: RA, 22: R8, 23: RA,
    24: R8, 25: RA, 26: R8, 27: RA, 28: R8, 29: RA, 30: R8, 31: RA,
}
REGISTRO = {0x67F8: R4, 0x6FF8: R6, 0x77F8: R8, 0x7FF8: RA}


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p31."""
    return "p%02d" % p


def mide(rom):
    """Las escrituras `ld a,N / ld (copia),a / ld (registro),a` de la ROM."""
    vistas, raras = [], []
    for m in re.finditer(rb"\x32\xf8[\x67\x6f\x77\x7f]", rom):
        o = m.start()
        reg = 0xF8 | rom[o + 2] << 8
        if rom[o - 5] == 0x3E and rom[o - 3] == 0x32:
            vistas.append((o, rom[o - 4], REGISTRO[reg]))
        else:
            raras.append((o, REGISTRO[reg]))
    return vistas, raras


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("%d bancos de %d bytes en %s/" % (N_PAGINAS, TAM_PAGINA, dst))
    elif argv[1] == "mide":
        d = open(argv[2], "rb").read()
        vistas, raras = mide(d)
        malas = [(o, n, r) for o, n, r in vistas if ORG[n] != r and n != 0]
        for o, n, r in vistas:
            print("p%02d:%04X  banco %2d en %#06x%s" % (
                o // TAM_PAGINA, o % TAM_PAGINA + ORG[o // TAM_PAGINA], n, r,
                "" if ORG[n] == r else "   <- NO es su org"))
        for o, r in raras:
            print("p%02d:%04X  banco variable en %#06x" % (
                o // TAM_PAGINA, o % TAM_PAGINA + ORG[o // TAM_PAGINA], r))
        print("%d escrituras con banco fijo, %d variables, %d contra la regla "
              "(sin contar el banco 0 en 0xA000)" % (len(vistas), len(raras), len(malas)))
        if malas:
            sys.exit(1)
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
