#!/usr/bin/env python3
"""Mete en src/pNN.notes las notas escritas a mano en work/notas_pNN.txt.

Las notas a mano se escriben por tandas en un fichero de trabajo (una linea
por nota, con el mismo formato que las .notes: L, C o B) y aqui se pasan a una
seccion delimitada de la nota del banco, que esta herramienta reescribe
entera. Asi se pueden rehacer sin tocar lo demas. Lo que haya en esta
seccion manda sobre anota.py (que salta las direcciones con nota a mano).

Uso: mete_notas.py <banco>...
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INI = "# --- A MANO, POR TANDAS (seccion que reescribe tools/mete_notas.py desde work/notas_pNN.txt) ---"
FIN = "# --- fin de las notas por tandas ---"


def mete(p):
    fuente = os.path.join(RAIZ, "work", "notas_p%02d.txt" % p)
    lineas = [ln.rstrip("\n") for ln in open(fuente, encoding="utf-8")
              if ln.strip() and not ln.startswith("#")]
    ruta = os.path.join(RAIZ, "src", "p%02d.notes" % p)
    viejas = open(ruta, encoding="utf-8").read().split("\n")
    nuevas, dentro = [], False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    # la seccion va justo detras de la cabecera, antes que las automaticas
    corte = next((i for i, ln in enumerate(nuevas) if ln.startswith("# --- ") and "A MANO" not in ln
                  and "biblioteca" not in ln), len(nuevas))
    nuevas = nuevas[:corte] + [INI] + lineas + [FIN, ""] + nuevas[corte:]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")
    print("p%02d: %d notas" % (p, len(lineas)))


if __name__ == "__main__":
    for b in sys.argv[1:]:
        mete(int(b))
