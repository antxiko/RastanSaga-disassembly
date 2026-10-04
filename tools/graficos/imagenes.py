"""Todas las imagenes de la web, en docs/imagenes, desde la ROM:
  titulo.png              titulo.py (cotejado a 0 bytes contra openMSX), x2
  ronda_1..7.png          laminas.py
  rastan, actores, jefes  hojas.py
  dragon_fase.png         la fase 0x11 (fases.py), x2
  dragon_cabeza.png       dragon.py, cabeza y cuello, x4
  trono.png, final.png    trono.py y final.py, x4
  creditos.png            el texto del final (p04:8D01) con la fuente del
                          cartucho (p00:4649) y la paleta de la ficha 0x17, x2
Uso: python tools/graficos/imagenes.py
"""
import os
import shutil
import subprocess
import sys
from PIL import Image, ImageChops

OUT = 'docs/imagenes'
PY = sys.executable


def corre(*args):
    subprocess.run([PY] + list(args), check=True, stdout=subprocess.DEVNULL)


def x(n, src, dst):
    im = Image.open(src)
    im.resize((im.width * n, im.height * n), Image.NEAREST).save(os.path.join(OUT, dst))


def creditos():
    g = {}
    exec(open('tools/graficos/tiles.py').read(), g)
    ROM, w = g['ROM'], g['w']
    b2 = lambda a, n: ROM[2 * 0x2000 + (a - 0x8000):][:n]
    pal = g['pal_de'](b2(w(b2(0x9035 + 16 * 0x17 + 12, 2)), 32))
    b4 = lambda a: ROM[4 * 0x2000 + (a - 0x8000)]
    lineas = [b4(0x8D01 + 2 * i) | b4(0x8D02 + 2 * i) << 8 for i in range(54)]
    img = Image.new('RGB', (256, 16 * len(lineas) + 16), pal[0])
    for i, a in enumerate(lineas):
        if b4(a) in (0xFE, 0xFF):
            continue
        xx, a = b4(a), a + 1
        while b4(a):
            c = b4(a)
            t = 0 if c == 0x20 else (c - 0x30 - (6 if c - 0x30 >= 10 else 0)) + 2
            g['pon_tile'](img, pal, t, xx, 16 * i + 8)
            xx += 8
            a += 1
    # sin las lineas en blanco de arriba y de abajo
    fondo = Image.new('RGB', img.size, pal[0])
    caja = ImageChops.difference(img, fondo).getbbox()
    img = img.crop((0, max(0, caja[1] - 8), 256, min(img.height, caja[3] + 8)))
    img.resize((img.width * 2, img.height * 2), Image.NEAREST).save(os.path.join(OUT, 'creditos.png'))


def main():
    os.makedirs(OUT, exist_ok=True)
    os.makedirs('work/g', exist_ok=True)
    corre('tools/graficos/titulo.py')
    x(2, 'work/g/titulo_1x.png', 'titulo.png')
    corre('tools/graficos/laminas.py', OUT)
    corre('tools/graficos/hojas.py', OUT)
    corre('tools/graficos/fases.py', '0x11')
    im = Image.open('work/g/fase11.png').crop((0, 0, 256, 176))
    im.resize((512, 352), Image.NEAREST).save(os.path.join(OUT, 'dragon_fase.png'))
    corre('tools/graficos/dragon.py')
    shutil.copy('work/g/dragon_cabeza_cuello_x4.png', os.path.join(OUT, 'dragon_cabeza.png'))
    corre('tools/graficos/trono.py')
    shutil.copy('work/g/trono_x4.png', os.path.join(OUT, 'trono.png'))
    corre('tools/graficos/final.py')
    shutil.copy('work/g/final_x4.png', os.path.join(OUT, 'final.png'))
    creditos()
    for f in sorted(os.listdir(OUT)):
        im = Image.open(os.path.join(OUT, f))
        print('%-20s %dx%d' % (f, im.width, im.height))


if __name__ == '__main__':
    main()
