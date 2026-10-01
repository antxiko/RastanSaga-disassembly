"""El final que nunca se ve (el barbaro mirando al horizonte): 176 x 96, 11 x 6
bloques de 16x16 de la tabla del titulo (p00:5D27), bloques 0x2A-0x57, mas
las dos ultimas filas de tiles, que ya no caben: la tabla se corta en 0x6000
(fin del banco 0): los bloques 0x58-0x5D solo tienen la fila de arriba
(tiles 0x952-0x95D en p00:5FE7) y los 0x962-0x979 no estan en ningun bloque.
Tiles: 0x760-0x7A8 (banco 0x17) y 0x8F4-0x979 (banco 0x19). Los bloques
0x34-0x35 (otra punta de la melena, tiles 0x774-0x776, 0x781-0x782) no caben
en la imagen: ver CUADRO_B.

COLOCACION (reconstruida): los bloques 0x36-0x57 van seguidos de 11 en 11 y
las dos filas de abajo siguen la numeracion (hoja de 16 de ancho); la fila
del horizonte (0x2B-0x33) lleva el cielo 0x2B repetido donde lo pone la
lamina de TCRF (work/g/tcrf.png), cotejada celda a celda contra toda la VRAM
(python tools/graficos/final.py --coteja). La paleta NO esta en la ROM:
PAL_TCRF son los colores de la lamina (por votos).
Salidas: work/g/final.png (1x), final_x4.png, final_b_x4.png (cuadro B)."""
import sys, os
exec(open('tools/graficos/tiles.py').read())
tabla = lambda off, n: p00(0x5D27 + off, n)
W, H = 22, 12
BLOQUES = [[0x2A] * 11,
           [0x2B, 0x2B, 0x2C, 0x2D, 0x2E, 0x2B, 0x2F, 0x30, 0x31, 0x32, 0x33],
           list(range(0x36, 0x41)), list(range(0x41, 0x4C)), list(range(0x4C, 0x57)), [0x57] + [None] * 10]
ULTIMAS = [[0x940, 0x941] + list(range(0x952, 0x962)) + [0x972, 0x973, 0x974, 0x975],
           [0x950, 0x951] + list(range(0x962, 0x972)) + [0x976, 0x977, 0x978, 0x979]]
CUADRO_B = {9: 0x34, 10: 0x35}      # en la fila del horizonte, por 0x32 y 0x33
PAL_TCRF = [(181, 114, 47), (251, 180, 146), (250, 144, 110), (177, 108, 76), (106, 74, 42), (72, 40, 8),
            (150, 82, 17), (181, 114, 47), (0, 0, 0), (198, 198, 199), (255, 254, 255), (249, 38, 20),
            (150, 82, 17), (249, 108, 109), (176, 74, 17), (10, 0, 73)]


def tabla_tiles(cuadro_b=False):
    """La imagen como 22 x 12 numeros de tile."""
    T = [[None] * W for _ in range(H)]
    for bj, fila in enumerate(BLOQUES):
        for bi, b in enumerate(fila):
            if cuadro_b and bj == 1 and bi in CUADRO_B: b = CUADRO_B[bi]
            if b is None: continue
            tl, tr, bl, br = bloque_tiles(tabla, b)
            T[2 * bj][2 * bi], T[2 * bj][2 * bi + 1], T[2 * bj + 1][2 * bi], T[2 * bj + 1][2 * bi + 1] = tl, tr, bl, br
    for r in range(2):
        for i, t in enumerate(ULTIMAS[r]): T[10 + r][i] = t
    return T


def dibuja(pal, cuadro_b=False):
    im = Image.new('RGB', (W * 8, H * 8), pal[1])
    for j, fila in enumerate(tabla_tiles(cuadro_b)):
        for i, t in enumerate(fila): pon_tile(im, pal, t, i * 8, j * 8)
    return im


def comprueba():
    T = tabla_tiles(); usados = [t for f in T for t in f]
    assert all(t is not None for t in usados)
    conj = set(range(0x760, 0x7A9)) | set(range(0x8F4, 0x97A))
    fuera = {0x774, 0x775, 0x776, 0x781, 0x782}      # bloques 0x34-0x35
    assert set(usados) - conj == set(), ['%03X' % t for t in set(usados) - conj]
    assert conj - set(usados) == fuera, ['%03X' % t for t in conj - set(usados)]
    # las filas de arriba de 0x58-0x5D estan en la tabla (p00:5FE7): deben coincidir
    assert [w(p00(0x5FE7 + 2 * k, 2)) for k in range(12)] == ULTIMAS[0][2:14]


def coteja():
    import numpy as np
    from collections import Counter
    lam = np.asarray(Image.open('work/g/tcrf.png').convert('RGB')).astype(int)
    sx = sy = 1.85; ox, oy = 233.0, 394.0         # marco del final en la lamina (work/g/lamina_ident.py)
    crop = lam[int(oy) - 4:int(oy) + 190, int(ox) - 4:int(ox) + 340]
    cnt = Counter(map(tuple, crop.reshape(-1, 3))); cent = []
    for col, n in cnt.most_common():
        col = np.array(col); d = [np.abs(col - c).sum() for c, _ in cent]
        if cent and min(d) < 36: cent[int(np.argmin(d))][1] += n
        else: cent.append([col, n])
    C = np.array([c for c, n in sorted(cent, key=lambda x: -x[1]) if n >= 30]); K = len(C)
    Q = np.abs(lam[:, :, None, :] - C[None, None]).sum(3).argmin(2)
    xs = np.floor(ox + (np.arange(W * 8) + 0.5) * sx).astype(int); ys = np.floor(oy + (np.arange(H * 8) + 0.5) * sy).astype(int)
    cel = Q[ys][:, xs].reshape(H, 8, W, 8).transpose(0, 2, 1, 3).reshape(H * W, 64)
    NA = 0xA00; TA = np.array([tile_px(t) for t in range(NA)]).reshape(NA, 64)
    OT = np.zeros((NA, 64, 16), dtype=np.float32); OT[np.arange(NA)[:, None], np.arange(64)[None, :], TA] = 1
    OTf = OT.transpose(0, 2, 1).reshape(NA * 16, 64)
    T = tabla_tiles(); malas = 0
    for n in range(W * H):
        c = cel[n]; OC = np.zeros((64, K), dtype=np.float32); OC[np.arange(64), c] = 1
        Hh = (OTf @ OC).reshape(NA, 16, K); tam = Hh.sum(2); modo = Hh.argmax(2)
        M = np.zeros_like(Hh); np.put_along_axis(M, modo[..., None], tam[..., None], axis=2)
        coste = (tam - Hh.max(2)).sum(1) + (M.sum(1) - M.max(1)).sum(1)
        j, i = divmod(n, W); t = T[j][i]
        iguales = [x for x in range(NA) if (TA[x] == TA[t]).all()]      # tiles identicos (cielo)
        mejor = int(coste.argmin())
        # desacuerdo solo si la lamina da un tile limpio (coste <= 4) y el nuestro no:
        # en el tramado del suelo cualquier tile sale ruidoso y manda la tabla de bloques
        if mejor not in iguales and coste[mejor] <= 4 and coste[t] - coste[mejor] > 4:
            print('  (%2d,%2d) tabla %03X (coste %d), mejor de la lamina %03X (%d)' % (j, i, t, coste[t], mejor, coste[mejor])); malas += 1
    print('celdas en desacuerdo con la lamina:', malas)
    return malas


if __name__ == '__main__':
    comprueba()
    os.makedirs('work/g', exist_ok=True)
    im = dibuja(PAL_TCRF); im.save('work/g/final.png')
    im.resize((W * 32, H * 32), Image.NEAREST).save('work/g/final_x4.png')
    dibuja(PAL_TCRF, True).resize((W * 32, H * 32), Image.NEAREST).save('work/g/final_b_x4.png')
    print('final: 22x12 tiles (11x6 bloques); work/g/final.png')
    if '--coteja' in sys.argv: sys.exit(1 if coteja() else 0)
