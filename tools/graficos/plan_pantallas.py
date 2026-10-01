"""Escribe el plan del recorrido por pantallas para tools/omsx_pantallas.tcl.

Para cada pantalla (fase, col, fila) de verdad: si cambia la fase, D5E5 =
fase - 1 y D910 = 0x81 (p00:5303); luego D5F0/D5F1 en la vecina y Rastan
fuera por el borde (p00:5367: x < 7 izquierda, x >= 0xE2 derecha, y >= 0xAF
abajo), y volcado."""
exec(open('tools/graficos/fases.py').read().split("if __name__")[0])
import json, os
hechas = set(json.load(open('work/g/a_cero.json'))) if os.environ.get('SOLO_FALTAN') else set()
ESPERA_FASE = float(os.environ.get('ESPERA_FASE', 6))
ESPERA_PANT = float(os.environ.get('ESPERA_PANT', 3))
t = 16.0
lin = ['after time 11 espacio']
fase_act = 0
n = 0
idx = []
for f in range(24):
    if f in (0x11, 0x17):
        continue
    fc = ficha(f); nc = fc['ucol'] + 1; nf = fc['ufil'] + 1
    for r in range(nf):
        for c in range(nc):
            wd = w(b2(fc['pant'] + 2 * (r * nc + c), 2))
            if wd & 0xFF == 0xFF or wd == 0:
                continue
            if '%02X,%d,%d' % (f, c, r) in hechas:
                continue
            if f != fase_act or n == 0:
                lin.append('after time %.1f {a_fase %d}' % (t, f))
                t += ESPERA_FASE
                fase_act = f
            if c < fc['ucol']:
                w_ = 'a_pant %d %d %d %d 3 0x80' % (c, r, c + 1, r)
            elif c > 0:
                w_ = 'a_pant %d %d %d %d 0xF0 0x80' % (c, r, c - 1, r)
            elif r > 0:
                w_ = 'a_pant %d %d %d %d 0x80 0xB0' % (c, r, c, r - 1)
            else:
                w_ = ''
            if w_:
                lin.append('after time %.1f {%s}' % (t, w_))
            t += ESPERA_PANT
            lin.append('after time %.1f {vuelca %d}' % (t - 0.5, n))
            idx.append('%d %02X %d %d' % (n, f, c, r))
            n += 1
lin.append('after time %.1f exit' % (t + 1))
open(os.environ.get('PLAN', 'work/g/plan_pantallas') + '.tcl', 'w').write('\n'.join(lin) + '\n')
open(os.environ.get('PLAN', 'work/g/plan_pantallas') + '.txt', 'w').write('\n'.join(idx) + '\n')
print(n, 'pantallas,', t, 's emulados')
