"""Las hojas de figuras de la web, el cuadro 0 de cada pose:
  rastan.png   - Rastan: las combinaciones distintas de sus tres capas
                 (p06:639F, p06:64B3 y el arma de p06:6397, arma 0) en las
                 92 poses, con la paleta de la fase 0;
  actores.png  - los 37 tipos de actor (p00:4C68: poses; definicion en el
                 banco 30 si el tipo es < 0x18, si no en el 26), cada uno con
                 la paleta de la primera fase en cuyas listas sale (enemigo
                 por p00:57D3 u objeto); los que no sale en ninguna lista, con
                 la de la fase 0 y marcados con *;
  jefes.png    - los tipos de jefe 1-5 (p03:7F76, definiciones en el banco
                 8) con la paleta de su sala (fases 2, 5, 8, 0x0B y 0x0E), y
                 el 7, la muerte, con la de la fase 2. El 6 no va: no se sabe
                 donde sale (PREGUNTAS-ABIERTAS).
Uso: python tools/graficos/hojas.py [directorio]
"""
import os
import sys
from PIL import ImageDraw
exec(open('tools/graficos/fases.py').read().split("if __name__")[0])

TC = p00(0x4DF4, 32)
FONDO = (24, 24, 32)


def lienzo(spr, pal):
    """Pinta los sprites en un lienzo ajustado; devuelve la imagen o None."""
    can = pinta(spr, pal, TC)
    can = {p: c for p, c in can.items() if c}
    if not can:
        return None
    xs = [p[0] for p in can]
    ys = [p[1] for p in can]
    im = Image.new('RGB', (max(xs) - min(xs) + 1, max(ys) - min(ys) + 1), FONDO)
    for (x, y), c in can.items():
        im.putpixel((x - min(xs), y - min(ys)), pal[c])
    return im


def hoja(filas, ancho=900):
    """filas = [(rotulo, [imagen, ...])]; una fila por rotulo, partida si no cabe."""
    lineas = []
    for rot, ims in filas:
        lin, x, h = [], 70, 12
        for im in ims:
            if x + im.width > ancho and lin:
                lineas.append((rot, lin, h)); rot = ''; lin, x, h = [], 70, 12
            lin.append((x, im)); x += im.width + 6; h = max(h, im.height)
        lineas.append((rot, lin, h))
    H = sum(h + 8 for _, _, h in lineas) + 4
    ancho = max(x + im.width for _, lin, _ in lineas for x, im in lin) + 6
    out = Image.new('RGB', (ancho, H), FONDO)
    dr = ImageDraw.Draw(out)
    y = 4
    for rot, lin, h in lineas:
        dr.text((4, y + 2), rot, fill=(255, 220, 0))
        for x, im in lin:
            out.paste(im, (x, y + h - im.height))
        y += h + 8
    return out.resize((out.width * 2, out.height * 2), Image.NEAREST)


def paleta_fase(f):
    return pal_de(b2(ficha(f)['pal'], 32))


def primera_fase_de_cada_tipo():
    vista = {}
    for f in range(0x17):
        if f == 0x11:
            continue
        fc = ficha(f)
        for fil in range(fc['ufil'] + 1):
            for col in range(fc['ucol'] + 1):
                wd = w(b2(fc['pant'] + 2 * (fil * (fc['ucol'] + 1) + col), 2))
                if wd & 0xFF == 0xFF or wd == 0:
                    continue
                pantalla(f, col, fil)
                ene, obj, _ = pantalla.actores
                for _, cod in ene:
                    if not cod & 0x80:
                        vista.setdefault(p00(0x57D3 + 2 * (cod - 1) + 1)[0], f)
                for _, t in obj:
                    vista.setdefault(t, f)
    return vista


def rastan():
    pal = paleta_fase(0)
    b6 = lambda a: w(ROM[6 * 0x2000 + (a - 0x6000):][:2])
    t3 = b6(0x6397)
    vistas, ims = set(), []
    for pose in range(92):
        k = (b6(0x639F + 3 * pose), b6(0x64B3 + 3 * pose), b6(t3 + 2 * pose))
        if k in vistas:
            continue
        vistas.add(k)
        spr = []
        for d in (k[2], k[0], k[1]):
            if d:
                spr += cuadro(26, d, 0)[2]
        im = lienzo(spr, pal)
        if im:
            ims.append(im)
    return hoja([('Rastan', ims)]), len(ims)


def hoja_actores():
    vista = primera_fase_de_cada_tipo()
    listas = [w(p00(0x4C68 + 2 * i, 2)) for i in range(37)]
    sig = sorted(set(listas) | {0x4DF4})
    filas = []
    for t in range(1, 38):
        f = vista.get(t, 0)
        pal = paleta_fase(f)
        fin = min(a for a in sig if a > listas[t - 1])
        ims = []
        for a in range(listas[t - 1], fin, 2):
            d = w(p00(a, 2))
            if d:
                im = lienzo(cuadro(30 if t < 0x18 else 26, d, 0)[2], pal)
                if im:
                    ims.append(im)
        if ims:
            filas.append(('tipo %02X%s' % (t, '' if t in vista else '*'), ims))
    return hoja(filas, 1000), len(filas)


def jefes():
    b3 = lambda a: w(ROM[3 * 0x2000 + (a - 0x6000):][:2])
    tablas = [b3(0x7F76 + 2 * i) for i in range(7)] + [0x7FDA]
    filas = []
    for t, f in ((1, 2), (2, 5), (3, 8), (4, 0xB), (5, 0xE), (7, 2)):
        pal = paleta_fase(f)
        ims = []
        for a in range(tablas[t - 1], tablas[t], 2):
            d = b3(a)
            for k in range(banco(8, d, 3)[2] if t == 7 else 1):
                im = lienzo(cuadro(8, d, k)[2], pal)
                if im:
                    ims.append(im)
        filas.append(('jefe %d' % t if t < 7 else 'muerte', ims))
    return hoja(filas, 1000), len(filas)


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else 'docs/imagenes'
    os.makedirs(out, exist_ok=True)
    for nombre, fn in (('rastan', rastan), ('actores', hoja_actores), ('jefes', jefes)):
        im, n = fn()
        im.save(os.path.join(out, nombre + '.png'))
        print('%s.png: %d, %dx%d' % (nombre, n, im.width, im.height))


if __name__ == '__main__':
    main()
