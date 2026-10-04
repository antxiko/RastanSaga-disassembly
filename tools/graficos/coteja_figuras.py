"""Coteja las figuras de tools/graficos/figuras.py contra los sprites que pinta
el VDP en openMSX (volcados de tools/omsx_sprites.tcl).

Para cada volcado pinta la capa de sprites DOS veces:
  - como el VDP: tabla de atributos y colores de la VRAM (R5/R11, colores
    0x200 antes), patrones de R6, 16x16, 8 por linea, CC = OR con el de
    delante; la y de la tabla + 1;
  - como figuras.py: para cada actor dado de alta en la RAM (8 enemigos en
    DA20 y 6 actores en D933, 38 bytes: +0 tipo, +6/+7 x e y, +0A cuadro,
    +0C/+0D definicion, p00:4A8B), su cuadro con cuadro() y pinta(), en el
    banco 30 (tipo < 0x18) o 26.
y cuenta, actor a actor, cuantos puntos de nuestra figura tienen el mismo
color en la capa del VDP. Un actor que no casa entero sale en la lista.

Uso: python tools/graficos/coteja_figuras.py work/spr
"""
import glob
import os
import sys
exec(open('tools/graficos/figuras.py').read().replace('\nmain()\n', '\n'))


def capa_vdp(spr, regs):
    sat = ((regs[11] & 3) << 15) | ((regs[5] & 0xF8) << 7) | 0x200
    col = sat - 0x200
    pat = (regs[6] & 0x3F) << 11
    v = lambda a: spr[a - 0x8000]
    capa = {}
    lista = []
    for n in range(32):
        y = v(sat + 4 * n)
        if y == 216:
            break
        lista.append((n, y, v(sat + 4 * n + 1), v(sat + 4 * n + 2) & 0xFC))
    for ly in range(212):
        en_linea = 0
        hubo_cc0 = False
        for n, y, x, p in lista:
            top = (y + 1) & 0xFF
            if top > 0xE0:
                top -= 256
            fila = ly - top
            if not 0 <= fila < 16:
                continue
            en_linea += 1
            if en_linea > 8:
                break
            c = v(col + 16 * n + fila)
            cc = c & 0x40
            xx0 = x - (32 if c & 0x80 else 0)
            if cc and not hubo_cc0:
                continue
            if not cc:
                hubo_cc0 = True
            for xx in range(16):
                b = v(pat + p * 8 + (16 if xx >= 8 else 0) + fila)
                if not b >> (7 - xx % 8) & 1:
                    continue
                k = (xx0 + xx, ly)
                if cc and k in capa:
                    capa[k] |= c & 15
                elif k not in capa:
                    capa[k] = c & 15
    return capa


def actores(ram):
    r = lambda a, n=1: ram[a - 0xC000:a - 0xC000 + n]
    out = []
    for base, cuantos in ((0xDA20, 8), (0xD933, 6)):
        for i in range(cuantos):
            a = base + 38 * i
            t = r(a)[0]
            if not t:
                continue
            d = w(r(a + 0x0C, 2))
            if not 0x8000 <= d < 0xA000:
                continue
            out.append(('%04X' % a, t, r(a + 6)[0], r(a + 7)[0], r(a + 0x0A)[0], d, w(r(a + 3, 2))))
    return out


def entradas_vdp(spr, regs):
    """Las entradas de la tabla de atributos: (y, x, patron de 32 bytes, 16 colores)."""
    sat = ((regs[11] & 3) << 15) | ((regs[5] & 0xF8) << 7) | 0x200
    pat = (regs[6] & 0x3F) << 11
    v = lambda a, n=1: spr[a - 0x8000:a - 0x8000 + n]
    out = []
    for n in range(32):
        y, x, p, _ = v(sat + 4 * n, 4)
        if y == 216:
            break
        out.append((y, x, v(pat + (p & 0xFC) * 8, 32), v(sat - 0x200 + 16 * n, 16)))
    return out


def otra_pose(t, en_ram):
    """Si las fichas de la RAM son, enteras, un cuadro de alguna de las poses
    del tipo t (lista de p00:4C68)."""
    listas = [w(p00(0x4C68 + 2 * i, 2)) for i in range(37)]
    sig = sorted(set(listas) | {0x4DF4})
    a = listas[t - 1]
    fin = min(x for x in sig if x > a)
    db = 30 if t < 0x18 else 26
    for pa in range(a, fin, 2):
        d = w(p00(pa, 2))
        if not d:
            continue
        for k in range(banco(db, d, 3)[2]):
            s = cuadro(db, d, k)[2]
            if s and all(e in en_ram for e in s):
                return True
    return False


def jugador(dir_):
    """Rastan: capa 1 = p06:639F[pose] con el estado D8FE, fichas desde D429;
    capa 2 = p06:64B3[pose], estado D900, desde D455; capa 3 (el arma) = la
    tabla de p06:6397 que dice D8F5 & 3, en el mismo cuadro que la capa 1
    (p00:5B95), desde D413. Pose = D8F4 & 0x7F."""
    b6 = lambda a, n: ROM[6 * 0x2000 + (a - 0x6000):][:n]
    tot = ok = 0
    malos = []
    for f in sorted(glob.glob(os.path.join(dir_, '*.ram'))):
        ram = open(f, 'rb').read()
        r = lambda a, n=1: ram[a - 0xC000:a - 0xC000 + n]
        pose, arma = r(0xD8F4)[0] & 0x7F, r(0xD8F5)[0] & 3
        if pose >= 92:
            continue
        # p06:6049: en cuadros alternos vacia_fichas_sprite (p00:4823) borra
        # sus 11 fichas y parpadea; sin fichas no hay nada que cotejar
        if all(w(r(0xD413 + 11 * i, 2)) in (0, 0xFFFF) for i in range(10)):
            continue
        # p06:615C: pose nueva, las dos animaciones a 0xFE hasta el paso siguiente
        if 0xFE in (r(0xD8FE)[0], r(0xD900)[0]):
            continue
        t3 = w(b6(0x6397 + 2 * arma, 2))
        capas = ((1, w(b6(0x639F + 3 * pose, 2)), r(0xD8FE)[0], 0xD429),
                 (2, w(b6(0x64B3 + 3 * pose, 2)), r(0xD900)[0], 0xD455),
                 (3, w(b6(t3 + 2 * pose, 2)), r(0xD8FE)[0], 0xD413))
        bien = True
        for capa, d, k, fp in capas:
            if not d:
                continue
            n = banco(26, d, 3)[2]
            if k >= n:
                bien = False
                malos.append((os.path.basename(f)[:-4], pose, arma, capa, 0, -1))
                continue
            s = cuadro(26, d, k)[2]
            en_ram = [(w(r(fp + 11 * i, 2)), r(fp + 11 * i + 2)[0], r(fp + 11 * i + 3)[0], r(fp + 11 * i + 8)[0]) for i in range(10)]
            nok = sum(1 for e in s if e in en_ram)
            if nok != len(s):
                bien = False
                malos.append((os.path.basename(f)[:-4], pose, arma, capa, nok, len(s)))
        tot += 1
        ok += bien
    return tot, ok, malos


def main():
    """Dos cotejos por actor dado de alta:
    1. sus fichas en la RAM (las que rellena anima, p00:5B16: +0/1 patron,
       +2/+3 x e y relativas, +8 juego; 11 bytes cada una, desde el puntero
       del actor +3/+4) contra el cuadro que lee cuadro() de su definicion
       (+0C/+0D) en su cuadro (+0A): mismo patron, misma x, misma y, mismo
       juego; no depende del instante, porque anima escribe el cuadro y las
       fichas a la vez;
    2. que los 32 bytes de cada patron, sacados con patron() del banco que
       dice el juego, estan en la VRAM de sprites (en la zona de patrones de
       R6), salvo los sprites ocultos."""
    tc = p00(0x4DF4, 32)
    total = casan = fichas = pat_ok = pat_tot = viejas = de_otra_pose = 0
    malos = []
    for f in sorted(glob.glob(os.path.join(sys.argv[1], '*.spr'))):
        n = f[:-4]
        spr = open(f, 'rb').read()
        regs = open(n + '.regs', 'rb').read()
        ram = open(n + '.ram', 'rb').read()
        pbase = ((regs[6] & 0x3F) << 11) - 0x8000
        zona = spr[pbase:pbase + 256 * 8]
        for donde, t, x, y, k, d, fp in actores(ram):
            db = 30 if t < 0x18 else 26
            nc = banco(db, d, 3)[2]
            _, _, s = cuadro(db, d, k % max(nc, 1))
            if not s or not 0xC000 <= fp < 0xFF00:
                continue
            en_ram = []
            al_dia = True
            for i in range(16):
                fi = ram[fp - 0xC000 + 11 * i:fp - 0xC000 + 11 * i + 9]
                en_ram.append((w(fi), fi[2], fi[3], fi[8]))
            # las fichas solo se reescriben al cambiar de cuadro (p00:5ABB); si
            # el actor se ha movido o ha cambiado de pose desde entonces, la
            # ficha guarda la posicion de entonces (+6/+7): esas no se cotejan
            primera = ram[fp - 0xC000:fp - 0xC000 + 9]
            if primera[0:2] == bytes([0xFF, 0xFF]) or (primera[6], primera[7]) != (x, y):
                viejas += 1
                continue
            if en_ram[0][0] == 0 or en_ram[0][2] == 0xFF and en_ram[0][0] == 0:
                viejas += 1                     # sin patron: oculto
                continue
            ok = sum(1 for e in s if e in en_ram)
            total += 1
            fichas += len(s)
            if ok == len(s):
                casan += 1
            elif otra_pose(t, en_ram):
                de_otra_pose += 1               # fichas de la pose anterior (p00:4A8B
                casan += 1                      # cambia +0C sin rehacer las fichas)
            else:
                malos.append((os.path.basename(n), donde, t, d, k, ok, len(s)))
            for pa, sx, sy, j in s:
                pat_tot += 1
                pat_ok += patron(j, pa)[0] in zona
    nv = len(glob.glob(os.path.join(sys.argv[1], '*.spr')))
    print('volcados: %d; actores con las fichas al dia: %d (%d fichas), con todas sus fichas iguales: %d; con fichas de antes, sin cotejar: %d' % (nv, total, fichas, casan, viejas))
    print('  de ellos, %d con las fichas de otra pose de su tipo (la anterior)' % de_otra_pose)
    print('patrones de la ROM presentes en la VRAM de sprites: %d de %d' % (pat_ok, pat_tot))
    for m in malos[:40]:
        print('  %s actor %s tipo %02X def %04X cuadro %d: %d de %d fichas' % m)
    jt, jc, jmalos = jugador(sys.argv[1])
    print('Rastan (tres capas, p06:6134): %d volcados, %d con las tres capas iguales' % (jt, jc))
    for m in jmalos[:20]:
        print('  %s pose %d arma %d capa %d: %d de %d fichas' % m)
    return 0


if __name__ == '__main__':
    sys.exit(main())
