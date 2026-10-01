#!/usr/bin/env python3
"""El trazado por bancos (z80trace.py, el que hace el listado) y el de cartucho
entero (cartucho.py, el que sabe que banco hay en cada ranura) tienen que
marcar como codigo los MISMOS bytes. Si no, o falta una entrada en un
pNN.entries, o uno de los dos esta leyendo datos como codigo.

Uso: check_bancos.py <rom> <dir_work>
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cartucho import Cartucho  # noqa: E402
from paginas import ORG, N_PAGINAS  # noqa: E402

# Bytes de una instruccion partida entre dos bancos: el trazado por bancos no
# puede verla entera. (banco, offset) que se perdonan, con su porque.
PARTIDAS = {
    (3, 0x1FFF): "p03:7FFF empieza una instruccion que acaba en p04:8000-8001",
    (4, 0x0000): "p04:8000 es el final de la instruccion de p03:7FFF",
    (4, 0x0001): "p04:8001 es el final de la instruccion de p03:7FFF",
}


def main(argv):
    rom = open(argv[1], "rb").read()
    c = Cartucho(rom)
    c.traza()
    malos = 0
    for b in range(N_PAGINAS):
        t = json.load(open(os.path.join(argv[2], "p%02d.trace.json" % b)))
        m = bytearray(0x2000)
        for k, a, z in t["blocks"]:
            if k == "c":
                for i in range(a - ORG[b], z - ORG[b]):
                    m[i] = 1
        dif = [i for i in range(0x2000) if m[i] != c.marca[b][i] and (b, i) not in PARTIDAS]
        if dif:
            malos += 1
            tramos = []
            for i in dif:
                if tramos and i == tramos[-1][1] + 1:
                    tramos[-1][1] = i
                else:
                    tramos.append([i, i])
            print("p%02d: %d bytes distintos: %s" % (b, len(dif), " ".join(
                "%04X-%04X(%s)" % (ORG[b] + x, ORG[b] + y, "solo cartucho" if c.marca[b][x] else "solo banco")
                for x, y in tramos[:12])))
    print("OK: los dos trazados coinciden en los 32 bancos" if not malos
          else "FALLO: %d bancos no coinciden" % malos)
    sys.exit(1 if malos else 0)


if __name__ == "__main__":
    main(sys.argv)
