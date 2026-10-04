#!/usr/bin/env python3
"""Coteja lo que lee de verdad el cartucho (tools/omsx_lecturas.tcl) con lo
que recorre tools/datos.py.

Dos preguntas:
  1. lo medido que datos.py NO recorre (si sale algo, a datos.py le falta una
     estructura);
  2. de lo que datos.py deja sin dueno (patrones sin definicion, definiciones
     sueltas, filas de bloques sin pantalla, sonido suelto), que lee el
     cartucho en la partida medida.
Y quien pone cada banco en el mapper (solo PCs del cartucho, 0x4000-0xBFFF).

Uso: coteja_lecturas.py work/lect/lecturas.txt
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import datos                                    # noqa: E402
import notas_de_datos                           # noqa: E402

SIN_DUENO = {'patrones_sin_definicion', 'definiciones_sueltas', 'bloques_sin_pantalla', 'sonido_suelto'}


def medido(path):
    """(banco, offset) -> letra, a partir de las lecturas de la sonda."""
    datos.LEIDO.clear()
    datos.VISTAS.clear()
    m = {}
    mapper = {}

    def pon(b, a, n, letra):
        for i in range(n):
            off = (a & 0x1FFF) + i
            m.setdefault((b + off // 0x2000, off % 0x2000), letra)

    for ln in open(path):
        p = ln.split()
        if p[0] == 'M':
            pc, ranura, banco = int(p[1], 16), int(p[2], 16), int(p[3])
            if 0x4000 <= pc < 0xC000:
                mapper.setdefault(banco, set()).add(pc)
            continue
        if p[0] == 'X':
            m[('X', p[1])] = 'X'
            continue
        b, a = int(p[1]), int(p[2], 16)
        if p[0] == 'P':
            pon(b, a, 32, 'P')
        elif p[0] == 'S':
            datos.definicion(b, a, 'S')         # la definicion entera, con sus cuadros
        elif p[0] == 'B':
            pon(b, a, 4, 'B'); pon(b, a + 32, 4, 'B')
        elif p[0] == 'T':
            c = datos.ROM[b * 0x2000 + (a & 0x1FFF)]
            n = 1
            if 1 <= c <= 0x7F:
                n = 2 if datos.ROM[b * 0x2000 + (a & 0x1FFF) + 1] & 0x80 else 3
            elif c in (0x80, 0x81):
                n = 2
            elif c in (0x82, 0x83):
                n = 3
            pon(b, a, n, 'T')
        elif p[0] in 'VE':                  # p01:61A9/6205: un 0 vuelve al principio
            pon(b, a, 2 if datos.ROM[b * 0x2000 + (a & 0x1FFF)] else 1, p[0])
    for (b, off), n in datos.LEIDO.items():
        if n != 'patrones_de_sprite':
            m.setdefault((b, off), 'S')
        else:
            m.setdefault((b, off), 'P')
    return m, mapper


def main():
    lect, mapper = medido(sys.argv[1])
    datos.LEIDO.clear(); datos.VISTAS.clear()
    datos.fases(); datos.sprites(); datos.tiles(); datos.sonido()
    recorrido = dict(datos.LEIDO)
    print('== quien pone cada banco (PCs del cartucho)')
    for b in sorted(mapper):
        print('  banco %2d: %s' % (b, ' '.join('%04X' % x for x in sorted(mapper[b]))))
    fuera = {}
    for k, letra in lect.items():
        if k[0] == 'X':
            continue
        if k not in recorrido:
            fuera.setdefault(k[0], []).append(k[1])
    print('== 1. medido y no recorrido por datos.py')
    for b in sorted(fuera):
        offs = sorted(fuera[b])
        print('  banco %2d: %d bytes, de 0x%04X a 0x%04X' % (b, len(offs), offs[0], offs[-1]))
    print('== 2. lo que datos.py deja sin dueno, y si se lee')
    for p in range(32):
        for i, j, n in notas_de_datos.rangos_de(p):
            if n not in SIN_DUENO:
                continue
            leidos = sum(1 for o in range(i, j) if (p, o) in lect)
            print('  p%02d 0x%04X..0x%04X %5d %-24s leidos en la partida: %d' % (
                p, datos.org(p) + i, datos.org(p) + j - 1, j - i, n, leidos))
    print('== ejecucion de p01:6478/647D:', [k[1] for k in lect if k[0] == 'X'] or 'ninguna')


if __name__ == '__main__':
    main()
