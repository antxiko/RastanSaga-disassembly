#!/usr/bin/env python3
"""Pone en el listado lo que ya se sabe, instruccion a instruccion.

No inventa nada: cada comentario sale de una tabla de esta casa y dice que es
lo que toca la instruccion:
  - la RAM con nombre de tools/ram.py (y los campos de sus tablas),
  - los registros del mapper ASCII8 y sus copias en RAM,
  - las llamadas a rutinas de otro banco que ya tienen nombre en las notas.

Lo que sale va a una seccion delimitada de src/pNN.notes que esta herramienta
reescribe entera; lo escrito a mano en la misma direccion manda, y aqui se
salta.

Uso: anota.py [--escribe] [banco ...]
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from paginas import N_PAGINAS                                       # noqa: E402
from ram import RAM                                                  # noqa: E402

SRC = os.path.join(RAIZ, "src")
INI = "# --- ANOTA (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de anota ---"

# Tablas de RAM con registros de tamano fijo: (inicio, n, tamano, que es)
TABLAS = [
    (0xC000, 16, 1, "contador de la tarea %d"),
    (0xC010, 16, 2, "SP guardado de la tarea %d"),
    (0xD193, 32, 4, "atributos del sprite %d"),
    (0xD213, 32, 16, "colores del sprite %d"),
    (0xD413, 32, 11, "ficha de sprite %d"),
    (0xD933, 6, 38, "actor %d"),
    (0xDA20, 8, 38, "enemigo %d"),
]
MAPPER = {0x67F8: "0x4000", 0x6FF8: "0x6000", 0x77F8: "0x8000", 0x7FF8: "0xA000"}

RE_INS = re.compile(r"^\t([a-z].*?)\s*;([0-9a-f]{4})(?:\s+;\s*(.*))?$")
RE_DIR = re.compile(r"\b0([0-9a-f]{4})h\b")


def nombres(banco):
    """{direccion: nombre} de las etiquetas L de las notas de un banco."""
    n = {}
    ruta = os.path.join(RAIZ, "work", "notas_p%02d.txt" % banco)
    if os.path.exists(ruta):
        for ln in open(ruta, encoding="utf-8"):
            if ln.startswith("L "):
                p = ln.split()
                n[int(p[1], 0)] = p[2]
    return n


P00 = nombres(0)
# El banco que hay en la OTRA ranura mientras corre cada banco de codigo: lo
# ponen las tareas (p00:56FB bancos 6 y 7, p00:5769 bancos 3 y 4).
VECINO = {3: 4, 4: 3, 6: 7, 7: 6}


def que_es(a):
    """Texto corto de la direccion de RAM a, o None."""
    if a in RAM:
        return RAM[a][1].split(" (")[0]
    for ini, n, tam, txt in TABLAS:
        if ini <= a < ini + n * tam:
            i, off = divmod(a - ini, tam)
            return (txt % i) + (", byte +%X" % off if off else "")
    return None


def comenta(ins):
    """El comentario que le toca a la instruccion, o None."""
    m = RE_DIR.search(ins)
    if not m:
        return None
    a = int(m.group(1), 16)
    op0 = ins.split(" ")[0]
    if op0 in ("call", "jp") and a in P00:
        return "p00 " + P00[a]
    if op0 in ("call", "jp") and BANCO in VECINO and a in VECINOS:
        return "p%02d %s" % (VECINO[BANCO], VECINOS[a])
    if a in MAPPER and ins.startswith("ld (") and ins.endswith(",a"):
        return "registro del mapper: banco A en " + MAPPER[a]
    t = que_es(a)
    if not t:
        return None
    op, _, args = ins.partition(" ")
    if op == "ld":
        dst, _, src = args.partition(",")
        if dst.startswith("(") and RE_DIR.search(dst):
            return "%s = %s" % (t, src)
        if src.startswith("(") and RE_DIR.search(src):
            return "%s = %s" % (dst, t)
        return "%s -> %s" % (dst, t)
    return t


def lee_listado(p):
    """[(addr, instruccion, comentario)]"""
    out = []
    for ln in open(os.path.join(SRC, "rastan_p%02d.asm" % p), encoding="utf-8"):
        m = RE_INS.match(ln.rstrip("\n"))
        if m:
            out.append((int(m.group(2), 16), m.group(1), m.group(3)))
    return out


def a_mano(p):
    """Direcciones con C escrita fuera de la seccion de anota."""
    c, dentro = set(), False
    ruta = os.path.join(SRC, "p%02d.notes" % p)
    if not os.path.exists(ruta):
        return c
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(INI):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("C "):
            c.add(int(ln.split()[1], 0))
    return c


BANCO, VECINOS = None, {}


def anota(p):
    global BANCO, VECINOS
    BANCO = p
    VECINOS = nombres(VECINO[p]) if p in VECINO else {}
    mano = a_mano(p)
    notas = []
    for a, ins, com in lee_listado(p):
        if a in mano:
            continue
        t = comenta(ins)
        if t:
            notas.append("C %#06x %s" % (a, t))
    return notas


def escribe(p, notas):
    ruta = os.path.join(SRC, "p%02d.notes" % p)
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
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
    while nuevas and not nuevas[-1].strip():
        nuevas.pop()
    nuevas += ["", INI] + notas + [FIN, ""]
    with open(ruta, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(nuevas))


def main(argv):
    esc = "--escribe" in argv
    bancos = [int(x) for x in argv[1:] if not x.startswith("-")] or [
        p for p in range(N_PAGINAS) if os.path.exists(os.path.join(SRC, "rastan_p%02d.asm" % p))]
    tot = 0
    for p in bancos:
        n = anota(p)
        tot += len(n)
        if esc:
            escribe(p, n)
        print("p%02d: %d comentarios de anota" % (p, len(n)))
    print("total: %d" % tot)


if __name__ == "__main__":
    main(sys.argv)
