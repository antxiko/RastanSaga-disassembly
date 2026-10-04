#!/usr/bin/env python3
"""Las rutinas y trozos de codigo que las notas dan por no ejecutados
(etiquetas huerfana_*, comentarios "nadie la llama", rangos D "que nadie
ejecuta") y lo que mide de ellos tools/omsx_huerfanas.tcl.

  huerfanas.py lista           escribe work/huerfanas.txt para la sonda:
                               "banco ini fin nombre" (decimal)
  huerfanas.py coteja F...     con los ficheros de la sonda, cuales se
                               ejecutaron y en que PC

Una rutina se da por no ejecutada SOLO con lo medido, y diciendo en que
recorridos (la norma de la serie: "nadie apunta aqui" no es "no se usa").
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from paginas import org, N_PAGINAS   # noqa: E402

MARCAS = re.compile(r'huerfan|nadie la llama|nadie lo|nadie ejecuta|sin uso|no se usa', re.I)


def lista():
    out = []
    for p in range(N_PAGINAS):
        path = 'src/p%02d.notes' % p
        if not os.path.exists(path):
            continue
        etiquetas = {}
        for ln in open(path, encoding='utf-8'):
            t = ln.split()
            if len(t) >= 3 and t[0] == 'L':
                etiquetas[int(t[1], 0)] = t[2]
        vistos = set()
        for ln in open(path, encoding='utf-8'):
            if not MARCAS.search(ln):
                continue
            t = ln.split()
            if t[0] == 'D':
                a, b = int(t[1], 0), int(t[2], 0)
                out.append((p, a, b - 1, t[3]))
            elif t[0] in ('L', 'C', 'B') and t[1].startswith('0x'):
                a = int(t[1], 0)
                if a in vistos:
                    continue
                vistos.add(a)
                out.append((p, a, a, etiquetas.get(a, 'p%02d_%04X' % (p, a))))
    return out


def main():
    if sys.argv[1] == 'lista':
        rs = lista()
        os.makedirs('work', exist_ok=True)
        with open('work/huerfanas.txt', 'w') as f:
            for p, a, b, n in rs:
                f.write('%d %d %d %s\n' % (p, a, b, n))
        print('%d rangos en work/huerfanas.txt' % len(rs))
        return
    vista = {}
    for fich in sys.argv[2:]:
        for ln in open(fich):
            n, pc = ln.split()
            vista.setdefault(n, set()).add(pc)
    rs = lista()
    si = [r for r in rs if r[3] in vista]
    print('%d rangos; se ejecutan en lo medido: %d' % (len(rs), len(si)))
    for p, a, b, n in si:
        print('  p%02d %04X-%04X %-28s PC %s' % (p, a, b, n, ' '.join(sorted(vista[n]))))


if __name__ == '__main__':
    main()
