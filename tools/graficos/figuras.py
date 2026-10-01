"""Pinta las poses de los actores tal como las arma el cartucho.

p00:4C68 tipo -> lista de poses (p00:4CB2..); cada pose -> definicion en el
banco 30 (tipo < 0x18) o 26, en 0x8000. Definicion (p00:5AA5): base de
patrones (2), numero de cuadros (1), lista de cuadros (2 c/u); cuadro =
duracion, n sprites, n x (patron, x, y, juego). Patron: base + (p-1)*32 con
los bancos que diga juego bits 7-6 (p00:4534). Color = p00:4DF4[juego & 0x3F]
(bit 6 = CC: se mezcla con OR con el sprite anterior).
"""
import sys
from PIL import Image, ImageDraw

import os
os.makedirs('work/g', exist_ok=True)
ROM = open('rastan.rom', 'rb').read()
ORG = {0: 0x4000, 1: 0x6000, 2: 0x8000, 3: 0x6000, 4: 0x8000}


def banco(b, addr, n=1):
    base = {0x6000: 0x6000, 0x8000: 0x8000, 0xA000: 0xA000}
    o = b * 0x2000 + (addr & 0x1FFF)
    return ROM[o:o + n]


def p00(a, n=1):
    return ROM[a - 0x4000:a - 0x4000 + n]


def w(bs, i=0):
    return bs[i] | bs[i + 1] << 8


def paleta(fase=0):
    ficha = 2 * 0x2000 + (0x9035 - 0x8000) + fase * 16
    pp = w(ROM, ficha + 0xC)
    # la paleta la lee pon_paleta con los bancos del juego: 0x4000 b0,
    # 0x6000 b3, 0x8000 b2? se prueba donde caiga
    slot = {0x4000: 0, 0x6000: 3, 0x8000: 2, 0xA000: None}[pp & 0xE000]
    o = slot * 0x2000 + (pp & 0x1FFF)
    raw = ROM[o:o + 32]
    pal = []
    for i in range(16):
        a, b = raw[2 * i], raw[2 * i + 1]
        r, bl, g = (a >> 4) & 7, a & 7, b & 7
        pal.append(tuple(v * 255 // 7 for v in (r, g, bl)))
    return pal, pp


def patron(juego, addr):
    sel = juego >> 6
    if sel in (0, 1):
        m = {0x6000: 14, 0x8000: 15}
    elif sel == 2:
        m = {0x6000: 11, 0x8000: 12, 0xA000: 13}
    else:
        m = {0x6000: 8, 0x8000: 9, 0xA000: 10}
    b = m[addr & 0xE000]
    return banco(b, addr, 32), b


def cuadro(defbank, defaddr, k):
    d = banco(defbank, defaddr, 64)
    base = w(d, 0)
    n = d[2]
    fa = w(d, 3 + 2 * k)
    f = banco(defbank, fa, 3 + 4 * 32)
    dur, ns = f[0], f[1]
    spr = []
    o = 2
    for i in range(ns):
        if f[o] == 0xFF:          # sprite vacio: un solo byte (p00:5B74)
            o += 1
            continue
        p, x, y, j = f[o:o + 4]
        o += 4
        spr.append((base + (p - 1) * 32, x, y, j))
    return n, dur, spr


def pinta(spr, pal, tabla_col):
    can = {}
    for (pa, x, y, j) in spr:
        pat, b = patron(j, pa)
        col = tabla_col[j & 0x3F]
        cc = col & 0x40
        c = col & 0x0F
        x = x - 256 if x > 127 else x
        y = y - 256 if y > 127 else y
        for yy in range(16):
            for xx in range(16):
                qd = (0 if xx < 8 else 2) + (0 if yy < 8 else 1)
                if pat[qd * 8 + yy % 8] >> (7 - xx % 8) & 1:
                    k = (x + xx, y + yy + 1)
                    if cc and k in can:
                        can[k] |= c
                    elif cc:
                        can[k] = c
                    elif k not in can:
                        can[k] = c
    return can


def main():
    fase = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    pal, pp = paleta(fase)
    tabla_col = p00(0x4DF4, 32)
    S = 3
    filas = []
    for t in range(1, 38):
        lista = w(p00(0x4C68 + 2 * (t - 1), 2))
        sig = sorted(set(w(p00(0x4C68 + 2 * i, 2)) for i in range(37)) | {0x4DF4})
        fin = min(a for a in sig if a > lista)
        poses = [w(p00(a, 2)) for a in range(lista, fin, 2)]
        db = 30 if t < 0x18 else 26
        celdas = []
        for pi, pd in enumerate(poses):
            if pd == 0:
                continue
            try:
                n, _, _ = cuadro(db, pd, 0)
                for k in range(min(n, 12)):
                    _, dur, spr = cuadro(db, pd, k)
                    celdas.append((pi, k, pinta(spr, pal, tabla_col)))
            except Exception as e:
                celdas.append((pi, -1, {}))
        filas.append((t, db, celdas))
    CW, CH = 72, 72
    maxc = 24
    lin = sum((len(c) + maxc - 1) // maxc or 1 for _, _, c in filas)
    img = Image.new('RGB', (40 + maxc * CW, lin * (CH + 12)), (24, 24, 32))
    dr = ImageDraw.Draw(img)
    y0 = 0
    for t, db, celdas in filas:
        dr.text((2, y0 + 2), 't%02X' % t, fill=(255, 255, 0))
        for i, (pi, k, can) in enumerate(celdas):
            cx = 40 + (i % maxc) * CW
            cy = y0 + (i // maxc) * (CH + 12)
            dr.text((cx, cy), '%d.%d' % (pi, k), fill=(150, 150, 150))
            if not can:
                continue
            xs = [p[0] for p in can]; ys = [p[1] for p in can]
            ox = cx + (CW - (max(xs) - min(xs) + 1)) // 2 - min(xs)
            oy = cy + 10 + (CH - (max(ys) - min(ys) + 1)) // 2 - min(ys)
            for (x, y), c in can.items():
                if 0 <= ox + x < img.width and 0 <= oy + y < img.height:
                    img.putpixel((ox + x, oy + y), pal[c] if c else (60, 60, 70))
        y0 += ((len(celdas) + maxc - 1) // maxc or 1) * (CH + 12)
    img = img.resize((img.width * 2, img.height * 2), Image.NEAREST)
    img.save('work/g/figuras_f%02d.png' % fase)
    print('paleta en %04X' % pp, pal)


main()
