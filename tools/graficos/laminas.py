"""Las siete rondas, una lamina cada una, con todo lo que sale de las tablas:
las fases pantalla a pantalla (fases.py), y encima, en la posicion de salida
que da la lista de cada pantalla (p00:58F9), los enemigos (codigo -> pose y
tipo en p00:57D3), los objetos (su tipo, pose 0; los de tipo 0 y 2 no se
pintan al entrar, p00:5A0D), las puertas (tipo 0x1F, cerradas), el decorado
animado (cuadro 0) y el bloque especial. Cada figura es el cuadro 0 de su
pose (figuras.py: definicion en el banco 30 si el tipo es < 0x18, si no en
el 26). Rastan, de pie, en su sitio de salida (ficha +F) en la pantalla de
salida (ficha +6/+7), que va recuadrada.

Los jefes no estan en las listas: los da de alta la rutina de cada sala de
jefe (p04:8016, 8262, 848E, 8799, 89CE): tipo 1-5, pose 1, en x = 0x96 y la y
que pone cada una; su definicion, por p03:7F76, en el banco 8 (p00:58C3). En
la ronda 7, cada uno en la pantalla que dice p04:8BF4-8C4B.

Rondas (p00:566C): fase / 3 + 1; de la 0x12 a la 0x16, la 7. La 0x11 no se
juega (p00:5318) y no entra.
Salidas: docs/imagenes/ronda_N.png (o el directorio que se diga).
Uso: python tools/graficos/laminas.py [directorio]
"""
import os
import sys
from PIL import ImageDraw
exec(open('tools/graficos/fases.py').read().split("if __name__")[0])

RONDAS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [9, 0xA, 0xB], [0xC, 0xD, 0xE], [0xF, 0x10],
          [0x12, 0x13, 0x14, 0x15, 0x16]]
TC = p00(0x4DF4, 32)
# fase de jefe -> (tipo, y); p04:8030, 827C, 84A8, 87B3, 89E7
JEFE = {2: (1, 0x40), 5: (2, 0x40), 8: (3, 0x30), 0xB: (4, 0x30), 0xE: (5, 0x50)}
# ronda 7: (fase, columna, fila) -> la fase cuyo jefe sale (p04:8BF4-8C4B)
JEFE_R7 = {(0x12, 5, 0): 2, (0x13, 4, 0): 5, (0x14, 5, 0): 8, (0x15, 5, 1): 0xB, (0x16, 3, 0): 0xE}


def jefe(img, pal, t, y, X, Y):
    b3 = lambda a: w(ROM[3 * 0x2000 + (a - 0x6000):][:2])
    d = b3(b3(0x7F76 + 2 * (t - 1)) + 2 * 1)
    pinta_spr(img, pal, cuadro(8, d, 0)[2], 0x96, y, X, Y)
SEP = 4                     # entre pantallas
FONDO = (24, 24, 32)


def figura(img, pal, t, pose, x, y, X, Y):
    """El cuadro 0 de la pose del tipo t, con el actor en (x, y) de pantalla."""
    lista = w(p00(0x4C68 + 2 * (t - 1), 2))
    d = w(p00(lista + 2 * pose, 2))
    if not d:
        return
    db = 30 if t < 0x18 else 26
    pinta_spr(img, pal, cuadro(db, d, 0)[2], x, y, X, Y)


def pinta_spr(img, pal, spr, x, y, X, Y):
    for (px, py), c in pinta(spr, pal, TC).items():
        if not c:
            continue
        xx, yy = X + ((x + px) & 0xFF), Y + y + py - 0x20
        if X <= xx < X + 256 and Y <= yy < Y + 176:
            img.putpixel((xx, yy), pal[c])


def rastan(img, pal, x, y, X, Y):
    """Pose 0, arma 0: capas 3, 1 y 2 de p06:6134, cuadro 0."""
    b6 = lambda a: w(ROM[6 * 0x2000 + (a - 0x6000):][:2])
    spr = []
    for d in (b6(b6(0x6397) + 0), b6(0x639F), b6(0x64B3)):
        if d:
            spr += cuadro(26, d, 0)[2]
    pinta_spr(img, pal, spr, x, y, X, Y)


def lamina(fases_):
    fichas = [ficha(f) for f in fases_]
    anchos = [(fc['ucol'] + 1) * (256 + SEP) for fc in fichas]
    altos = [(fc['ufil'] + 1) * (176 + SEP) + 14 for fc in fichas]
    img = Image.new('RGB', (max(anchos), sum(altos) + 4 * len(fases_)), FONDO)
    dr = ImageDraw.Draw(img)
    Y0 = 0
    for f, fc, alto in zip(fases_, fichas, altos):
        dr.text((2, Y0 + 2), 'fase %02X' % f, fill=(255, 220, 0))
        pal = pal_de(b2(fc['pal'], 32))
        nc = fc['ucol'] + 1
        for fil in range(fc['ufil'] + 1):
            for col in range(nc):
                X, Y = col * (256 + SEP), Y0 + 14 + fil * (176 + SEP)
                wd = w(b2(fc['pant'] + 2 * (fil * nc + col), 2))
                if wd & 0xFF == 0xFF or wd == 0:
                    continue
                for yy in range(176):
                    for xx in range(256):
                        img.putpixel((X + xx, Y + yy), pal[0])
                pantalla(f, col, fil, img, X, Y, cuadro=0, puerta=0)
                ene, obj, esp = pantalla.actores
                for (x, y), cod in ene:
                    if cod & 0x80:
                        continue                    # decorado: ya pintado
                    pose, t = p00(0x57D3 + 2 * (cod - 1), 2)
                    if t != 0x1F:                   # la puerta ya esta
                        figura(img, pal, t, pose, x, y, X, Y)
                for (x, y), t in obj:
                    if t not in (0, 2):
                        figura(img, pal, t, 0, x, y, X, Y)
                cual = f if f in JEFE else JEFE_R7.get((f, col, fil))
                if cual is not None:
                    jefe(img, pal, JEFE[cual][0], JEFE[cual][1], X, Y)
                if (col, fil) == (fc['scol'], fc['sfil']):
                    s = fc['sale']
                    rastan(img, pal, (s & 0x0F) * 16, (s & 0xF0) + 0x20, X, Y)
                    dr.rectangle((X - 2, Y - 2, X + 257, Y + 177), outline=(255, 220, 0), width=2)
        Y0 += alto + 4
    return img


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else 'docs/imagenes'
    os.makedirs(out, exist_ok=True)
    for i, fs in enumerate(RONDAS, 1):
        img = lamina(fs)
        img.save(os.path.join(out, 'ronda_%d.png' % i))
        print('ronda %d: fases %s, %dx%d' % (i, ' '.join('%02X' % f for f in fs), img.width, img.height))


if __name__ == '__main__':
    main()
