#!/usr/bin/env python3
"""Cruza lo que openMSX vio EJECUTAR (tools/omsx_huecos.tcl) con el trazado
estatico de tools/cartucho.py: imprime las direcciones ejecutadas que el
trazado no tenia como codigo, con su banco, agrupadas en tramos.

Uso: cruza_huecos.py <rom> <volcado> [<volcado> ...]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cartucho import Cartucho  # noqa: E402
from paginas import ORG  # noqa: E402


def lee(paths):
    vistos = set()
    for p in paths:
        for ln in open(p):
            if ln.startswith("#") or not ln.strip():
                continue
            pc, *bs = (int(x) for x in ln.split())
            b = bs[(pc - 0x4000) // 0x2000]
            # el registro del mapper dice que banco TENDRIA la ranura, pero
            # durante el arranque de C-BIOS la ranura es de otra ROM (el logo
            # en 0x8000): un banco fuera de su org no es el cartucho
            if ORG[b] <= pc < ORG[b] + 0x2000:
                vistos.add((b, pc))
    return vistos


def main(argv):
    rom = open(argv[1], "rb").read()
    c = Cartucho(rom)
    c.traza()
    nuevos = sorted((b, pc) for b, pc in lee(argv[2:]) if not c.marca[b][pc & 0x1FFF])
    tramos = []
    for b, pc in nuevos:
        if tramos and tramos[-1][0] == b and pc - tramos[-1][2] <= 4:
            tramos[-1][2] = pc
        else:
            tramos.append([b, pc, pc])
    for b, a, z in tramos:
        print("p%02d:%04X-%04X" % (b, a, z))
    print("%d direcciones ejecutadas fuera del trazado, en %d tramos" % (len(nuevos), len(tramos)))


if __name__ == "__main__":
    main(sys.argv)
