"""Rastan en sus poses, con las tres capas de p06:6134.

Capa 1 = p06:639F (3 bytes por pose), capa 2 = p06:64B3, capa 3 (el arma) =
una de las cuatro tablas de p06:6397 segun D8F5 & 3, en el cuadro de la capa
1. Definiciones en el banco 26. Orden de sprites: capa 3 (fichas 0-1), capa 1
(fichas 2-5), capa 2 (fichas 6-).
"""
import sys
from PIL import Image, ImageDraw
exec(open('tools/graficos/figuras.py').read().replace('\nmain()\n', '\n'))


def b6(a, n=1):
    o = 6 * 0x2000 + (a - 0x6000)
    return ROM[o:o + n]


def cuadros(pd):
    if not pd:
        return 0
    return banco(26, pd, 3)[2]


def main():
    arma = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    pal, _ = paleta(0)
    tc = p00(0x4DF4, 32)
    t3 = w(b6(0x6397 + 2 * arma, 2))
    vistas = {}
    orden = []
    for pose in range(92):
        d1 = w(b6(0x639F + 3 * pose, 2))
        d2 = w(b6(0x64B3 + 3 * pose, 2))
        d3 = w(b6(t3 + 2 * pose, 2))
        k = (d1, d2, d3)
        if k in vistas:
            vistas[k].append(pose)
            continue
        vistas[k] = [pose]
        orden.append(k)
    CW, CH = 64, 64
    img = Image.new('RGB', (40 + 24 * CW, 2), (24, 24, 32))
    filas = []
    for k in orden:
        d1, d2, d3 = k
        n1 = cuadros(d1)
        n2 = cuadros(d2)
        celdas = []
        for f in range(max(n1, 1)):
            spr = []
            if d3:
                _, _, s3 = cuadro(26, d3, f % max(cuadros(d3), 1))
                spr += s3
            if d1:
                spr += cuadro(26, d1, f)[2]
            if d2:
                spr += cuadro(26, d2, f % n2)[2]
            celdas.append(pinta(spr, pal, tc))
        filas.append((vistas[k], k, celdas))
    nf = sum((len(c) + 21) // 22 for _, _, c in filas)
    img = Image.new('RGB', (150 + 22 * CW, nf * (CH + 4)), (24, 24, 32))
    dr = ImageDraw.Draw(img)
    y0 = 0
    for poses, k, celdas in filas:
        dr.text((2, y0 + 2), 'poses ' + ','.join('%d' % p for p in poses[:6]), fill=(255, 255, 0))
        dr.text((2, y0 + 14), '%04X %04X %04X' % k, fill=(140, 140, 140))
        for i, can in enumerate(celdas):
            cx = 150 + (i % 22) * CW
            cy = y0 + (i // 22) * (CH + 4)
            for (x, y), c in can.items():
                X, Y = cx + 16 + x, cy + 8 + y
                if 0 <= X < img.width and 0 <= Y < img.height:
                    img.putpixel((X, Y), pal[c] if c else (60, 60, 70))
        y0 += ((len(celdas) + 21) // 22) * (CH + 4)
    img = img.resize((img.width * 2, img.height * 2), Image.NEAREST)
    img.save('work/g/rastan_arma%d.png' % arma)
    print(len(orden), 'combinaciones distintas', img.size)


main()
