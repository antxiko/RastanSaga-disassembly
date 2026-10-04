#!/usr/bin/env python3
"""Recorre los datos del cartucho como los recorre el codigo y dice, banco a
banco, que bytes lee cada estructura. Es la prueba de las directivas D de los
bancos de datos: un rango se declara porque una rutina identificada lo lee, no
porque sobre.

Lo que recorre (entre parentesis, la rutina que lo lee):
  - las fichas de fase (p00:5655), sus tablas de pantallas y sus paletas, en el
    banco 2;
  - los mapas (p00:5461, p00:55C5, p00:58F9) en los bancos que dice la ficha;
  - las tablas de bloques del banco 27 (p00:4777), hasta el ultimo bloque que
    pinta alguna pantalla de la fase;
  - las definiciones de sprite (p00:5AA5) de los 37 tipos de actor (bancos 30
    y 26), de las tres capas de Rastan (p06:6134, banco 26), la del arma
    (p00:5732) y las de los jefes
    (p00:58C3, banco 8), y los patrones de 32 bytes que nombran (p00:4534,
    bancos 8-15);
  - los tiles: bancos 0x10-0x19 enteros a la VRAM (p01:6077).

Uso: datos.py [--huecos] [--banco N]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from paginas import org  # noqa: E402

ROM = open('rastan.rom', 'rb').read()
B = 0x2000
LEIDO = {}          # (banco, offset) -> nombre


def w(a):
    return a[0] | a[1] << 8


def marca(b, off, n, nombre):
    for i in range(off, off + n):
        assert 0 <= i < B, (b, hex(off), n, nombre)
        LEIDO.setdefault((b, i), nombre)


def lee(b, addr, n, nombre):
    """Si se pasa del final del banco sigue en el siguiente: en todas las
    ranuras que se leen aqui el banco de la ranura de arriba es b + 1."""
    off = addr & 0x1FFF
    a = min(n, B - off)
    marca(b, off, a, nombre)
    if a < n:
        marca(b + 1, 0, n - a, nombre)
    return ROM[b * B + off:b * B + off + n]


def p00(a, n=1):
    return ROM[a - 0x4000:a - 0x4000 + n]


# --- fases ---------------------------------------------------------------

def mapa(bm, a, n, nombre):
    out = b''
    for i in range(n):
        x = a + i
        out += lee(bm if x < 0xA000 else bm + 1, x, 1, nombre)
    return out


def desempaqueta(bm, a, nombre):
    out = []
    while True:
        e, d = mapa(bm, a, 2, nombre)
        if e & d == 0xEF:
            return out, a
        if d == 0xD0:
            e2, d2 = mapa(bm, a + 2, 2, nombre)
            out += [e2 | d2 << 8] * (e if e else 256)
            a += 4
        else:
            out.append(e | d << 8)
            a += 2


def alarga(bm, a, delante, nombre):
    a += 2
    while mapa(bm, a, 1, nombre)[0] != 0xFF:
        mapa(bm, a, 6, nombre)
        a += 6
    return a


def actores(bm, a, nombre):
    h = a + 1
    for cuantos in (8, 3):
        for _ in range(cuantos):
            if mapa(bm, h, 1, nombre)[0] == 0xFF:
                continue
            mapa(bm, h, 2, nombre)
            h += 2
        mapa(bm, h, 1, nombre)      # p00:59A1 / 59DE: inc hl, el separador (o el 0xFF)
        h += 1
    if mapa(bm, h, 1, nombre)[0] != 0xFF:
        mapa(bm, h, 2, nombre)
        # el bloque especial tambien acaba en 0xFF, como las otras dos
        # listas; p00:59DF solo lee uno y no lo mira
        if mapa(bm, h + 2, 1, 'mapas_fin_de_especial')[0] != 0xFF:
            raise SystemExit('especial en %04X sin 0xFF detras' % h)


TABLAS_BLOQUES = {}     # direccion en el banco 27 -> bloque mas alto


def fases():
    for f in range(24):
        d = lee(2, 0x9035 + 16 * f, 16, 'fichas_de_fase')
        pant, bloq, ucol, ufil = w(d), w(d[2:]), d[4], d[5]
        fondo0, fondo, pal, bm = w(d[8:]), w(d[10:]), w(d[12:]), d[14]
        lee(2, pal, 32, 'paletas_de_fase')
        nc, nf = ucol + 1, ufil + 1
        tabla = lee(2, pant, 2 * nc * nf, 'pantallas_de_fase')
        usados = TABLAS_BLOQUES.setdefault(bloq, set())
        for fo in {fondo0, fondo}:
            if fo:
                l, fin = desempaqueta(bm, fo, 'mapas')
                # el fondo lleva la misma cola que una pantalla (columnas y
                # actores vacios: FF FF FF FF) aunque p00:5461 no la lee
                if mapa(bm, fin + 2, 4, 'mapas_cola_de_fondo') != bytes([0xFF] * 4):
                    raise SystemExit('fondo %04X sin la cola FF' % fo)
                usados.update(x & 0xFF for x in l if x & 0xFF != 0xFF)
        for k in range(nc * nf):
            wd = w(tabla[2 * k:])
            if wd & 0xFF == 0xFF or wd == 0:
                continue
            l, fin = desempaqueta(bm, wd, 'mapas')
            usados.update(x & 0xFF for x in l if x & 0xFF != 0xFF)
            ff = alarga(bm, fin, None, 'mapas')
            actores(bm, ff, 'mapas')
    for a, us in TABLAS_BLOQUES.items():
        n = (max(us) & 0xF8) + 8
        lee(27, a, n * 8, 'tablas_de_bloques')


# --- sprites -------------------------------------------------------------

def banco_patron(j, addr):
    sel = j >> 6
    if sel in (0, 1):
        return {0x6000: 14, 0x8000: 15}[addr & 0xE000]
    if sel == 2:
        return {0x6000: 11, 0x8000: 12, 0xA000: 13}[addr & 0xE000]
    return {0x6000: 8, 0x8000: 9, 0xA000: 10}[addr & 0xE000]


VISTAS = set()


def definicion(db, da, nombre):
    if not da or (db, da) in VISTAS:
        return
    VISTAS.add((db, da))
    h = lee(db, da, 3, nombre)
    base, n = w(h), h[2]
    for k in range(n):
        fa = w(lee(db, da + 3 + 2 * k, 2, nombre))
        dur, ns = lee(db, fa, 2, nombre)
        o = fa + 2
        for _ in range(ns):
            if lee(db, o, 1, nombre)[0] == 0xFF:
                o += 1
                continue
            p, x, y, j = lee(db, o, 4, nombre)
            o += 4
            pa = base + (p - 1) * 32
            lee(banco_patron(j, pa), pa, 32, 'patrones_de_sprite')


def sprites():
    listas = [w(p00(0x4C68 + 2 * i, 2)) for i in range(37)]
    sig = sorted(set(listas) | {0x4DF4})
    for t, lista in enumerate(listas, 1):
        fin = min(a for a in sig if a > lista)
        for a in range(lista, fin, 2):
            definicion(30 if t < 0x18 else 26, w(p00(a, 2)), 'definiciones_de_sprite')
    b6 = lambda a, n: lee(6, a, n, '-')
    for pose in range(92):
        definicion(26, w(ROM[6 * B + 0x039F + 3 * pose:][:2]), 'definiciones_de_sprite')
        definicion(26, w(ROM[6 * B + 0x04B3 + 3 * pose:][:2]), 'definiciones_de_sprite')
        for arma in range(4):
            t3 = w(ROM[6 * B + 0x0397 + 2 * arma:][:2])
            definicion(26, w(ROM[6 * B + (t3 - 0x6000) + 2 * pose:][:2]), 'definiciones_de_sprite')
    definicion(26, 0x963A, 'definiciones_de_sprite')    # el arma: p00:5732, ld ix,0963Ah
    jefes = [w(ROM[3 * B + 0x1F76 + 2 * i:][:2]) for i in range(7)]
    for a, f in zip(jefes, jefes[1:] + [0x7FDA]):
        for x in range(a, f, 2):
            definicion(8, w(ROM[3 * B + (x - 0x6000):][:2]), 'definiciones_de_jefe')


# --- sonido --------------------------------------------------------------

def bs(a, n, nombre):
    """El sonido corre con el banco 1 en 0x6000 y el 2 en 0x8000 (p00:4098)."""
    return lee(1 if a < 0x8000 else 2, a, n, nombre)


ENV_VOL, ENV_TONO = set(), set()


def partitura(a, vistas):
    """p01:6253. Sigue llamadas (0x83) y saltos (0x82) hasta el 0 o el salto."""
    while a not in vistas:
        vistas.add(a)
        c = bs(a, 1, 'partituras')[0]
        if c == 0 or c == 0x84:             # fin, vuelta
            return
        if 1 <= c <= 0x7F:                  # nota: duracion, tono (2) o silencio (1)
            t = bs(a + 1, 1, 'partituras')[0]
            if t & 0x80:
                a += 2
            else:
                bs(a + 2, 1, 'partituras')
                a += 3
        elif c in (0x80, 0x81):             # envolvente de volumen / de tono: numero
            (ENV_VOL if c == 0x80 else ENV_TONO).add(bs(a + 1, 1, 'partituras')[0])
            a += 2
        elif c in (0x82, 0x83):             # salto / llamada: direccion
            d = w(bs(a + 1, 2, 'partituras'))
            partitura(d, vistas)
            if c == 0x82:
                return
            a += 3
        else:                               # 0x85-0xFF: repeticiones, ruido, mezclador, volumen, pausa
            a += 1


def envolvente(a, nombre):
    """p01:619B: pasos de 2 bytes hasta un 0."""
    while bs(a, 1, nombre)[0]:
        bs(a, 2, nombre)
        a += 2


def sonido():
    vistas = set()
    for i in range(18):                     # p01:63FA: efecto * 2 en p01:64CC
        partitura(w(bs(0x64CC + 2 * i, 2, 'tabla_de_efectos')), vistas)
    for i in range(9 * 3):                  # p01:6437: musica * 6 en p01:64F0
        partitura(w(bs(0x64F0 + 2 * i, 2, 'tabla_de_musicas')), vistas)
    # las dos tablas de envolventes (p01:6338 y p01:634F) llegan hasta la
    # primera envolvente: 11 de volumen (hasta 653C) y 13 de tono (hasta 658B)
    for tabla, n, usadas, nombre in ((0x6526, 11, ENV_VOL, 'envolventes_de_volumen'),
                                     (0x6571, 13, ENV_TONO, 'envolventes_de_tono')):
        assert max(usadas) < n, (nombre, max(usadas))
        lee(1, tabla, 2 * n, 'tabla_de_' + nombre)
        for k in range(n):
            envolvente(w(bs(tabla + 2 * k, 2, 'tabla_de_' + nombre)), nombre)
    envolvente(0x64C1, 'envolvente_por_defecto')


def tiles():
    for b in range(0x10, 0x1A):
        marca(b, 0, B, 'tiles')


def rangos(b):
    out = []
    for i in range(B):
        n = LEIDO.get((b, i))
        if out and out[-1][2] == n and out[-1][1] == i:
            out[-1][1] = i + 1
        else:
            out.append([i, i + 1, n])
    return out


def main():
    fases(); sprites(); tiles(); sonido()
    solo = int(sys.argv[sys.argv.index('--banco') + 1]) if '--banco' in sys.argv else None
    for b in range(32):
        if solo is not None and b != solo:
            continue
        o = org(b)
        rs = rangos(b)
        if all(n is None for _, _, n in rs):
            continue
        tot = sum(f - i for i, f, n in rs if n)
        print('banco %2d (0x%04X): %5d de 8192 leidos' % (b, o & 0xFFFF, tot))
        for i, f, n in rs:
            if n is None and '--huecos' not in sys.argv:
                continue
            print('   %04X-%04X %5d  %s' % (o + i & 0xFFFF, (o + f - 1) & 0xFFFF, f - i, n or '·· SIN LEER'))


if __name__ == '__main__':
    main()
