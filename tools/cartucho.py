#!/usr/bin/env python3
"""Trazador de CARTUCHO ENTERO para un MegaROM ASCII8: sigue el flujo de banco
en banco llevando la cuenta de que banco hay en cada ranura.

Por que hace falta: en un MegaROM la direccion 0x8123 no quiere decir nada por
si sola; segun lo ultimo escrito en el registro del mapper ahi puede estar
cualquier banco. Un trazador de un solo banco se para en cuanto el codigo sale
de sus 8 KB. Este no: propaga por cada camino

    (pc, banco en 0x4000/0x6000/0x8000/0xA000, sus copias en RAM, A)

El mapper ASCII8 tiene cuatro registros, uno por ranura de 8 KB:
    0x6000-0x67FF -> 0x4000-0x5FFF     0x7000-0x77FF -> 0x8000-0x9FFF
    0x6800-0x6FFF -> 0x6000-0x7FFF     0x7800-0x7FFF -> 0xA000-0xBFFF
El cartucho guarda una copia de cada uno en RAM (COPIA, abajo) y la
interrupcion mete sus propios bancos y luego devuelve los de la copia: sin
llevar la cuenta de la copia, el trazador se quedaria con los de la
interrupcion puestos.

NO es el trazador que genera el listado -eso lo hace tools/z80trace.py banco a
banco-. Este es el que AVERIGUA en que direccion se ejecuta cada banco y que
entradas tiene cada uno.

Uso:
    cartucho.py <rom> informe            cobertura y lo que queda sin resolver
    cartucho.py <rom> escribe <dir>      escribe <dir>/pNN.entries y pNN.nocode
    cartucho.py <rom> quien <dir hex>    quien salta a esas direcciones
"""
import os
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from z80trace import BASE_LEN, ED_LEN4, IDX_DISP, JP_CC, CALL_CC, JR_CC  # noqa: E402
from cartucho_datos import (SEMILLAS, COPIA, TABLAS, NO_VUELVE,  # noqa: E402
                            CAMBIA_BANCOS, VUELVE_CON_COPIA,
                            TEXTO_EN_LINEA, VARIABLES, ZONAS_TABLA)

TAM = 0x2000
REG_RANURA = {0x6000: 0, 0x6800: 1, 0x7000: 2, 0x7800: 3}

# Opcodes de un byte que NO tocan el acumulador. Todo lo que no este aqui deja
# A "desconocido": equivocarse por ese lado solo deja un cambio de banco sin
# resolver (y sale en el informe); por el otro se inventaria un banco.
NO_TOCA_A = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x09, 0x0B, 0x0C, 0x0D,
             0x0E, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x18, 0x19, 0x1B,
             0x1C, 0x1D, 0x1E, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x28,
             0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x30, 0x31, 0x32, 0x33, 0x34,
             0x35, 0x36, 0x37, 0x38, 0x39, 0x3B, 0x3F}
NO_TOCA_A |= set(range(0x40, 0x78))
NO_TOCA_A |= set(range(0xB8, 0xC0))
NO_TOCA_A |= {0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC7, 0xC8, 0xC9, 0xCA,
              0xCC, 0xCD, 0xCF, 0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD7,
              0xD8, 0xD9, 0xDA, 0xDC, 0xDF, 0xE0, 0xE1, 0xE2, 0xE3, 0xE4,
              0xE5, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xEF, 0xF0, 0xF2,
              0xF3, 0xF4, 0xF5, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFE,
              0xFF}
ED_NO_TOCA_A = {0x41, 0x42, 0x43, 0x45, 0x46, 0x47, 0x49, 0x4A, 0x4B, 0x4D,
                0x4E, 0x4F, 0x51, 0x52, 0x53, 0x56, 0x59, 0x5A, 0x5B, 0x5E,
                0x61, 0x62, 0x63, 0x69, 0x6A, 0x6B, 0x71, 0x72, 0x73, 0x79,
                0x7A, 0x7B, 0xA0, 0xA1, 0xA2, 0xA3, 0xA8, 0xA9, 0xAA, 0xAB,
                0xB0, 0xB1, 0xB2, 0xB3, 0xB8, 0xB9, 0xBA, 0xBB}


def s8(b):
    return b - 256 if b > 127 else b


class Cartucho:
    def __init__(self, rom):
        self.rom = rom
        self.nb = len(rom) // TAM
        self.marca = [bytearray(TAM) for _ in range(self.nb)]
        self.inicios = [set() for _ in range(self.nb)]
        self.bases = defaultdict(set)          # banco -> {direccion de ejecucion}
        self.entradas = defaultdict(dict)      # banco -> {dir: porque}
        self.ciegos = set()                    # (banco, pc, que)
        self.sin_banco = set()                 # (pc) con la ranura desconocida
        self.cambio_sin_resolver = set()       # (banco, pc) escritura con A desconocido
        self.bios = defaultdict(set)           # destino < 0x4000 -> {origen}
        self.ram = defaultdict(set)            # destino >= 0xC000 -> {origen}
        self.visto = set()
        self.inicios_abs = set()               # (banco, pc) inicios de instruccion
        self.ranuras_en = defaultdict(set)     # (banco, offset) -> {ranuras}
        self.cruces = set()                    # instrucciones partidas entre dos bancos
        self.texto = defaultdict(set)          # banco -> offsets de texto en linea
        self.origen = defaultdict(set)         # destino -> {(banco, pc)}, para depurar

    # -------------------------------------------------------------- lectura
    def donde(self, pc, ranuras):
        """(banco, offset) del byte que el Z80 ve en pc, o None."""
        if not 0x4000 <= pc < 0xC000:
            return None
        r = (pc - 0x4000) // TAM
        b = ranuras[r]
        if b is None:
            return None
        return b, pc & (TAM - 1)

    def lee(self, pc, ranuras):
        d = self.donde(pc, ranuras)
        if d is None:
            return None
        return self.rom[d[0] * TAM + d[1]]

    def ilen(self, pc, ranuras):
        op = self.lee(pc, ranuras)
        if op is None:
            return 0
        if op == 0xCB:
            return 2
        if op == 0xED:
            return 4 if self.lee(pc + 1, ranuras) in ED_LEN4 else 2
        if op in (0xDD, 0xFD):
            op2 = self.lee(pc + 1, ranuras)
            if op2 == 0xCB:
                return 4
            if op2 in (0xDD, 0xFD, 0xED):
                return 1
            return 1 + BASE_LEN[op2] + (1 if op2 in IDX_DISP else 0)
        return BASE_LEN[op]

    # -------------------------------------------------------------- traza
    def traza(self):
        pila = []
        for pc, ranuras, porque in SEMILLAS:
            copia = tuple(ranuras)
            pila.append((pc, tuple(ranuras), copia, None))
            d = self.donde(pc, ranuras)
            if d:
                self.entradas[d[0]].setdefault(pc, porque)
        while pila:
            self.camino(*pila.pop(), pila)

    def camino(self, pc, ranuras, copia, a, pila):
        while True:
            clave = (pc, ranuras, copia, a)
            if clave in self.visto:
                return
            self.visto.add(clave)
            d = self.donde(pc, ranuras)
            if d is None:
                if 0x4000 <= pc < 0xC000:
                    self.sin_banco.add(pc)
                return
            banco, off = d
            n = self.ilen(pc, ranuras)
            if n == 0 or any(self.donde(pc + i, ranuras) is None for i in range(n)):
                return
            self.bases[banco].add(pc - off)
            self.inicios[banco].add(off)
            self.inicios_abs.add((banco, pc))
            self.ranuras_en[(banco, off)].add(ranuras)
            for i in range(n):
                bb, oo = self.donde(pc + i, ranuras)
                self.marca[bb][oo] = 1
                if bb != banco:
                    self.cruces.add((banco, pc, bb))
            b = [self.lee(pc + i, ranuras) for i in range(n)]
            op = b[0]
            nxt = pc + n
            w = (b[1] | b[2] << 8) if n >= 3 else None

            def salta(t, porque, r=ranuras, c=copia, aa=a):
                self.origen[t].add((banco, pc))
                if t < 0x4000:
                    self.bios[t].add((banco, pc))
                    return
                if t >= 0xC000:
                    self.ram[t].add((banco, pc))
                    return
                dd = self.donde(t, r)
                if dd is None:
                    self.sin_banco.add(t)
                    return
                if (dd[0] != banco or not (pc - off <= t < pc - off + TAM)
                        or porque.startswith("tabla")):
                    self.entradas[dd[0]].setdefault(t, porque)
                pila.append((t, r, c, aa))

            # ---- efectos sobre A, la copia y las ranuras
            na = None
            if op == 0x3E:
                na = b[1]
            elif op == 0xAF:
                na = 0
            elif op == 0x3C and a is not None:
                na = (a + 1) & 0xFF
            elif op == 0x3D and a is not None:
                na = (a - 1) & 0xFF
            elif op == 0x3A:
                na = copia[COPIA.index(w)] if w in COPIA else None
                if w in VARIABLES:
                    # una variable que solo toma unos pocos valores, sacados de
                    # una tabla de la ROM: se sigue un camino por cada uno
                    na = VARIABLES[w][0]
                    for v in VARIABLES[w][1:]:
                        pila.append((nxt, ranuras, copia, v))
            elif op == 0x32:
                na = a
                if w in COPIA:
                    c = list(copia)
                    c[COPIA.index(w)] = a
                    copia = tuple(c)
                elif 0x6000 <= w < 0x8000:
                    r = list(ranuras)
                    r[REG_RANURA[w & 0xF800]] = a
                    if a is None:
                        self.cambio_sin_resolver.add((banco, pc))
                    ranuras = tuple(r)
            elif op == 0xED:
                na = a if b[1] in ED_NO_TOCA_A else None
            elif op in (0xDD, 0xFD):
                op2 = b[1]
                toca = 0x78 <= op2 <= 0x7F or 0x86 <= op2 <= 0xB6 and (op2 & 7) == 6 and op2 != 0xBE
                na = None if toca else a
            elif op == 0xCB:
                op2 = b[1]
                na = None if (op2 & 7) == 7 and not 0x40 <= op2 < 0x80 else a
            elif op in NO_TOCA_A:
                na = a

            # ---- flujo
            if op == 0xC3:
                salta(w, "jp desde %s" % self.nom(banco, pc), ranuras, copia, na)
                return
            if op in JP_CC:
                salta(w, "jp cc desde %s" % self.nom(banco, pc), ranuras, copia, na)
            elif op == 0xCD or op in CALL_CC:
                salta(w, "call desde %s" % self.nom(banco, pc), ranuras, copia, na)
                if w in NO_VUELVE:
                    return
                if w in TEXTO_EN_LINEA:
                    while self.lee(nxt, ranuras) not in (0, None):
                        self.marca_texto(nxt, ranuras)
                        nxt += 1
                    self.marca_texto(nxt, ranuras)
                    nxt += 1
                if w in VUELVE_CON_COPIA:
                    # vuelve en otro cuadro: la interrupcion ha repuesto las
                    # ranuras que dice VUELVE_CON_COPIA desde la copia
                    r = list(ranuras)
                    for i in VUELVE_CON_COPIA[w]:
                        r[i] = copia[i]
                    ranuras = tuple(r)
                if w in CAMBIA_BANCOS:
                    r = list(ranuras)
                    c = list(copia)
                    for i, v in CAMBIA_BANCOS[w].items():
                        r[i] = v
                        c[i] = v
                    ranuras, copia = tuple(r), tuple(c)
                na = None
            elif op == 0x18:
                salta(nxt + s8(b[1]), "jr desde %s" % self.nom(banco, pc), ranuras, copia, na)
                return
            elif op in JR_CC or op == 0x10:
                salta(nxt + s8(b[1]), "jr cc desde %s" % self.nom(banco, pc), ranuras, copia, na)
            elif op == 0xC9:
                # `ex (sp),hl / ret` y `push rr / ret` son saltos indirectos
                # disfrazados de vuelta: se apuntan como puntos ciegos
                prev = self.lee(pc - 1, ranuras)
                if prev == 0xD9 and self.lee(pc - 2, ranuras) in (0xE5, 0xD5, 0xC5):
                    # `push rr / exx / ret`: el mismo salto con los registros cambiados
                    pc -= 1
                    prev = self.lee(pc - 1, ranuras)
                if (banco, pc - 1) in TABLAS:
                    # una tabla conocida: se sigue aunque este `ret` se haya
                    # visitado antes por otro camino (el `visto` no lo distingue)
                    for t in TABLAS[(banco, pc - 1)]:
                        salta(t, "tabla de %s" % self.nom(banco, pc - 1), ranuras, copia, None)
                elif prev in (0xE3, 0xE5, 0xD5, 0xC5) and (banco, pc - 1) in self.inicios_abs:
                    self.ciegos.add((banco, pc - 1, "%s / ret" % {
                        0xE3: "ex (sp),hl", 0xE5: "push hl", 0xD5: "push de",
                        0xC5: "push bc"}[prev]))
                return
            elif op == 0xE9 or (op in (0xDD, 0xFD) and b[1] == 0xE9):
                clave_t = (banco, pc)
                if clave_t in TABLAS:
                    for t in TABLAS[clave_t]:
                        salta(t, "tabla de %s" % self.nom(banco, pc), ranuras, copia, None)
                else:
                    self.ciegos.add((banco, pc, "jp (hl)"))
                return
            elif op == 0xED and b[1] in (0x45, 0x4D):
                return
            elif op in (0xC7, 0xCF, 0xD7, 0xDF, 0xE7, 0xEF, 0xF7, 0xFF):
                self.bios[op & 0x38].add((banco, pc))
                na = None
            # el codigo sigue de largo y entra en el banco de la ranura de al
            # lado: para el trazado por bancos eso es una entrada
            dn = self.donde(nxt, ranuras)
            if dn and dn[0] != banco:
                self.entradas[dn[0]].setdefault(
                    nxt, "%s sigue de largo (el codigo cruza la frontera de banco)"
                    % self.nom(banco, pc))
            pc, a = nxt, na

    def marca_texto(self, pc, ranuras):
        d = self.donde(pc, ranuras)
        if d:
            self.texto[d[0]].add(d[1])

    @staticmethod
    def nom(banco, pc):
        return "p%02d:%04X" % (banco, pc)

    # -------------------------------------------------------------- informes
    def informe(self):
        tot = 0
        for bk in range(self.nb):
            n = sum(self.marca[bk])
            tot += n
            bs = " ".join("%04X" % x for x in sorted(self.bases[bk])) or "-"
            print("p%02d  codigo %5d B (%5.1f%%)  se ejecuta en %s  entradas de fuera %d"
                  % (bk, n, 100 * n / TAM, bs, len(self.entradas[bk])))
        print("total codigo: %d B de %d" % (tot, len(self.rom)))
        print("cambios de banco con A desconocido: %d" % len(self.cambio_sin_resolver))
        for bk, pc in sorted(self.cambio_sin_resolver):
            print("   ", self.nom(bk, pc))
        print("saltos a una ranura sin banco conocido: %d" % len(self.sin_banco))
        for pc in sorted(self.sin_banco)[:30]:
            print("    %04X" % pc)
        print("instrucciones partidas entre bancos: %s" % " ".join(
            "%s->p%02d" % (self.nom(b, p), b2) for b, p, b2 in sorted(self.cruces)))
        print("puntos ciegos: %d" % len(self.ciegos))
        for bk, pc, q in sorted(self.ciegos):
            print("   ", self.nom(bk, pc), q)
        print("llamadas a RAM: %d destinos" % len(self.ram))
        for t, ors in sorted(self.ram.items()):
            print("    %04X  desde %s" % (t, " ".join(self.nom(*o) for o in sorted(ors)[:4])))
        print("llamadas a BIOS: %s" % " ".join("%04X" % t for t in sorted(self.bios)))


def escribe(c, dst):
    """src/pNN.entries y src/pNN.nocode de los 32 bancos."""
    for bk in range(c.nb):
        with open(os.path.join(dst, "p%02d.entries" % bk), "w", encoding="utf-8", newline="\n") as f:
            f.write("# Puntos de entrada del banco %d. Los escribe tools/cartucho.py\n" % bk)
            f.write("# (`make semillas`), que sigue el flujo por el cartucho entero\n")
            f.write("# llevando la cuenta de los bancos. Los saltos dentro del propio\n")
            f.write("# banco los encuentra z80trace.py solo.\n")
            if not c.entradas[bk]:
                f.write("# Ninguno: en este banco no se ejecuta nada.\n")
            if c.texto[bk]:
                for r in sorted(TEXTO_EN_LINEA):
                    f.write("!texto %#06x   # detras del call, una cadena acabada en 0\n" % r)
            for t, q in sorted(c.entradas[bk].items()):
                f.write("%#06x   # %s\n" % (t, q))
        with open(os.path.join(dst, "p%02d.nocode" % bk), "w", encoding="utf-8", newline="\n") as f:
            f.write("# Zonas del banco %d donde el trazador NO puede entrar: las tablas\n" % bk)
            f.write("# de saltos (tools/cartucho_datos.py, ZONAS_TABLA).\n")
            for b2, a, z, q in ZONAS_TABLA:
                if b2 == bk:
                    f.write("%#06x %#06x   %s\n" % (a, z, q))


def main(argv):
    if len(argv) < 3:
        sys.exit(__doc__)
    rom = open(argv[1], "rb").read()
    c = Cartucho(rom)
    c.traza()
    if argv[2] == "informe":
        c.informe()
    elif argv[2] == "quien":
        for x in argv[3:]:
            t = int(x, 16)
            print("%04X <- %s" % (t, " ".join(c.nom(*o) for o in sorted(c.origen[t]))))
    elif argv[2] == "escribe":
        escribe(c, argv[3])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
