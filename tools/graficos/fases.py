"""Las fases montadas pantalla a pantalla como p00:5461.

Ficha de fase (p02:9035, 16 B): +0 tabla de pantallas (banco 2), +2 tabla
de bloques (banco 27 en 0xA000), +4/+5 ultima columna/fila, +6/+7 salida,
+8 fondo de la fila 0, +A fondo de las demas, +C paleta, +E banco de mapas,
+F donde sale Rastan. Pantalla = 11 x 16 bloques desde y = 0x20: fondo
opaco, delante transparente, columnas alargadas (p00:55C5) y otra vez delante.
"""
import sys
exec(open('tools/graficos/tiles.py').read())


def b2(a, n=1):
    o = 2 * 0x2000 + (a - 0x8000)
    return ROM[o:o + n]


def ficha(f):
    d = b2(0x9035 + 16 * f, 16)
    return dict(pant=w(d, 0), bloq=w(d, 2), ucol=d[4], ufil=d[5], scol=d[6],
                sfil=d[7], fondo0=w(d, 8), fondo=w(d, 10), pal=w(d, 12),
                banco=d[14], sale=d[15])


def mapa_byte(bm, a):
    """Byte del mapa en a: bm en 0x8000, bm+1 en 0xA000."""
    b = bm if a < 0xA000 else bm + 1
    return ROM[b * 0x2000 + (a & 0x1FFF)]


def desempaqueta(bm, a):
    out = []
    while True:
        e, d = mapa_byte(bm, a), mapa_byte(bm, a + 1)
        if e & d == 0xEF:
            return out, a
        if d == 0xD0:
            e2, d2 = mapa_byte(bm, a + 2), mapa_byte(bm, a + 3)
            out += [e2 | d2 << 8] * (e if e else 256)
            a += 4
        else:
            out.append(e | d << 8)
            a += 2


def alarga(bm, a, delante):
    """Devuelve la direccion del 0xFF que acaba la lista."""
    a += 2
    while mapa_byte(bm, a) != 0xFF:
        cas = mapa_byte(bm, a)
        p1 = (mapa_byte(bm, a + 1) | mapa_byte(bm, a + 2) << 8) + 0x8000 & 0xFFFF
        p2 = (mapa_byte(bm, a + 3) | mapa_byte(bm, a + 4) << 8) + 0x9000 & 0xFFFF
        alto = mapa_byte(bm, a + 5)
        delante[cas] = p1
        delante[cas + 1] = p2
        for k in range(1, (alto if alto else 256) + 1):
            for j in (0, 1):
                if cas + 16 * k + j < len(delante):
                    delante[cas + 16 * k + j] = delante[cas + 16 * (k - 1) + j]
        a += 6
    return a


def actores(bm, a):
    """p00:58F9 desde el 0xFF de las columnas: enemigos, objetos, especial."""
    pos = lambda v: ((v & 0x0F) * 16, (v & 0xF0) + 0x20)
    h = a + 1
    ene, obj, esp = [], [], None
    for _ in range(8):
        v = mapa_byte(bm, h)
        if v == 0xFF:
            continue
        ene.append((pos(v), mapa_byte(bm, h + 1)))
        h += 2
    h += 1
    for _ in range(3):
        v = mapa_byte(bm, h)
        if v == 0xFF:
            continue
        obj.append((pos(v), mapa_byte(bm, h + 1)))
        h += 2
    h += 1
    v = mapa_byte(bm, h)
    if v != 0xFF:
        esp = (pos(v), mapa_byte(bm, h + 1))
    return ene, obj, esp


def pinta_lista(img, pal, tabla, lista, X, Y, transp):
    for i, wd in enumerate(lista[:176]):
        if wd & 0xFF == 0xFF:
            continue
        pon_bloque(img, pal, tabla, wd & 0xFF, X + 16 * (i % 16), Y + 16 * (i // 16), transp)


def decorado(img, pal, ene, cuadro, X, Y):
    """p05:6543: codigo con bit 7 = trozo animado: (codigo & 0xF) * 16 de
    ancho, 8 de alto, desde x = 0 de la tira de p00:584B (fila 0: tiles
    0x216/0x217; fila 1: 0x226/0x227) a (x, y + 8)."""
    k = -1
    for (x, y), cod in ene:
        if not cod & 0x80:
            continue
        k += 1
        cu = cuadro[k % len(cuadro)] if isinstance(cuadro, (list, tuple)) else cuadro
        if cu is None:
            continue
        ancho = (cod & 0x0F) * 16
        base = 0x216 if cu == 0 else 0x226
        tmp = Image.new('RGB', (ancho + 8, 8))
        for i in range(0, ancho, 8):
            pon_tile(tmp, pal, base + (i // 8) % 2, i, 0)
        img.paste(tmp.crop((0, 0, ancho, 8)), (X + x, Y + y - 0x20 + 8))


def b5(a, n=1):
    o = 5 * 0x2000 + (a - 0x6000)
    return ROM[o:o + n]


def puertas(img, pal, ene, estado, X, Y):
    """p05:60CF: tipo 0x1F (codigo con p00:57D3 -> tipo 0x1F). 2 filas x 4
    tiles en (x, y + 0x10); bit 0 de la pose: 0 derecha (p05:629E abierta,
    62AE cerrada), 1 izquierda (627E abierta, 628E cerrada)."""
    for (x, y), cod in ene:
        if cod & 0x80:
            continue
        pose, tipo = p00(0x57D3 + 2 * (cod - 1), 2)
        if tipo != 0x1F or estado is None:
            continue
        lista = {(0, 1): 0x629E, (0, 0): 0x62AE, (1, 1): 0x627E, (1, 0): 0x628E}[(pose & 1, estado)]
        for k in range(8):
            pon_tile(img, pal, w(b5(lista + 2 * k, 2)), X + x + 8 * (k % 4), Y + y - 0x20 + 0x10 + 8 * (k // 4))


def pantalla(f, col, fil, img=None, X=0, Y=0, cuadro=None, puerta=None, especial=True):
    fc = ficha(f)
    pal = pal_de(b2(fc['pal'], 32))
    tabla = lambda off, n: ROM[27 * 0x2000 + (fc['bloq'] - 0xA000) + off:][:n]
    if img is None:
        img = Image.new('RGB', (256, 176), pal[0])
    fondo = fc['fondo0'] if fil == 0 else fc['fondo']
    if fondo:
        lista, _ = desempaqueta(fc['banco'], fondo)
        pinta_lista(img, pal, tabla, lista, X, Y, False)
    wd = w(b2(fc['pant'] + 2 * (fil * (fc['ucol'] + 1) + col), 2))
    if wd & 0xFF == 0xFF:
        return img, wd
    delante, fin = desempaqueta(fc['banco'], wd)
    pinta_lista(img, pal, tabla, delante, X, Y, True)
    ff = alarga(fc['banco'], fin, delante)
    pinta_lista(img, pal, tabla, delante, X, Y, True)
    ene, obj, esp = actores(fc['banco'], ff)
    if esp and especial:
        (x, y), cual = esp
        b = p00(0x48E7 + cual - 1)[0]
        pon_bloque(img, pal, lambda off, n: p00(0x5BC3 + off, n), b, X + x, Y + y - 0x20, True)
    if cuadro is not None:
        decorado(img, pal, ene, cuadro, X, Y)
    puertas(img, pal, ene, puerta, X, Y)
    pantalla.actores = (ene, obj, esp)
    return img, wd


def fase(f):
    fc = ficha(f)
    nc, nf = fc['ucol'] + 1, fc['ufil'] + 1
    pal = pal_de(b2(fc['pal'], 32))
    img = Image.new('RGB', (nc * 260, nf * 180), (40, 40, 48))
    for fil in range(nf):
        for col in range(nc):
            X, Y = col * 260, fil * 180
            wd = w(b2(fc['pant'] + 2 * (fil * nc + col), 2))
            if wd & 0xFF == 0xFF or wd == 0:
                continue
            for y in range(176):
                for x in range(256):
                    img.putpixel((X + x, Y + y), pal[0])
            pantalla(f, col, fil, img, X, Y)
    return img, fc


if __name__ == '__main__':
    for a in sys.argv[1:]:
        f = int(a, 0)
        img, fc = fase(f)
        img.save('work/g/fase%02X.png' % f)
        print('fase %02X' % f, {k: (hex(v) if isinstance(v, int) else v) for k, v in fc.items()}, img.size)
