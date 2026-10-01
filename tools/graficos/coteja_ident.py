"""Cotejo de cada volcado contra la pantalla que dice D774 (identifica.py)."""
import sys, os, json, itertools
exec(open('tools/graficos/identifica.py').read().split('if __name__ ==')[0])
pal_real = pal_de
pal_de = lambda raw: [(i, i, i) for i in range(16)]
res = {}
for D in sys.argv[1:]:
    for n in sorted(os.listdir(D)):
        if not n.endswith('.ram'):
            continue
        base = D + '/' + n[:-4]
        ram = open(base + '.ram', 'rb').read(); v = open(base + '.vram', 'rb').read()
        cands = quien(ram)
        if not cands:
            continue
        pv = v[0x20 * 128:0x20 * 128 + 128 * 176]
        for (f, c, r) in cands:
            pantalla(f, c, r)
            nd = sum(1 for _, cod in pantalla.actores[0] if cod & 0x80)
            mejor = None
            for cu, pu in itertools.product(itertools.product((None, 0, 1), repeat=max(nd, 1)), (None, 1)):
                img, _ = pantalla(f, c, r, cuadro=list(cu), puerta=pu)
                mb = img.tobytes()[::3]
                d = sum(1 for i in range(0, len(mb), 2) if (mb[i] << 4 | mb[i + 1]) != pv[i // 2])
                if mejor is None or d < mejor[0]:
                    mejor = (d, (f, c, r), base)
                if d == 0:
                    break
            k = (f, c, r)
            if k not in res or mejor[0] < res[k][0]:
                res[k] = mejor
total = 0
for f in range(24):
    fc = ficha(f); nc = fc['ucol'] + 1
    for r in range(fc['ufil'] + 1):
        for c in range(nc):
            wd = w(b2(fc['pant'] + 2 * (r * nc + c), 2))
            if not (wd & 0xFF == 0xFF or wd == 0):
                total += 1
cero = [k for k, x in res.items() if x[0] == 0]
print('pantallas del cartucho', total, 'vistas', len(res), 'a cero', len(cero))
for k, x in sorted(res.items()):
    if x[0]:
        print('distinta', '%02X %d %d' % k, x[0], x[2])
json.dump(['%02X,%d,%d' % k for k in cero], open('work/g/a_cero.json', 'w'))
