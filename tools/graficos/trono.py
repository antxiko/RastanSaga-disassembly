"""El trono (presentacion sin usar): 95 tiles de la VRAM, 0x97A-0x9D8 (banco
0x19), sin tabla de colocacion en la ROM (buscada: palabras y bytes de tile y
de bloque, mapas RLE, codigo huerfano). La colocacion es RECONSTRUIDA: la de
la lamina de TCRF (work/g/tcrf.png), cotejada celda a celda contra los tiles
reales (python tools/graficos/trono.py --coteja): las 96 celdas con dibujo
dan cada una un tile distinto del rango, y el unico repetido es la hoja de la
espada (9BC en dos celdas). El negro del fondo no esta en la ROM (no se
guardo ningun tile vacio). Los tiles estan numerados en orden de recorrido
de una hoja de 16 de ancho, no de la imagen: la tabla de abajo no se deduce
de la numeracion.

La paleta NO esta en la ROM: PAL_TCRF son los colores que TCRF se invento
(sacados de la lamina por votos; deja en negro el indice 8, la sombra de la
hoja de la espada); PAL_GRIS es por indice.
Salidas: work/g/trono.png (1x), trono_x4.png, trono_gris_x4.png.
"""
import sys, os
exec(open('tools/graficos/tiles.py').read())
INI, FIN = 0x97A, 0x9D8
_ = None
TRONO = [   # 10 x 12 tiles = 80 x 96 px
    [_,     _,     _,     _,     _,     0x97A, 0x97B, _,     _,     _    ],
    [_,     _,     _,     0x981, 0x982, 0x983, 0x984, 0x985, _,     _    ],
    [_,     _,     _,     0x97C, 0x97D, 0x97E, 0x97F, 0x980, 0x98B, _    ],
    [_,     _,     _,     0x986, 0x987, 0x988, 0x989, 0x98A, 0x998, _    ],
    [0x98C, 0x98D, _,     0x98E, 0x98F, 0x990, 0x991, 0x992, 0x993, _    ],
    [0x999, 0x99A, 0x99B, 0x99C, 0x99D, 0x99E, 0x99F, 0x9A0, 0x9A1, _    ],
    [0x994, 0x995, 0x996, 0x997, 0x9A6, 0x9A7, 0x9A8, 0x9A9, 0x9AA, 0x9AB],
    [0x9A2, 0x9A3, 0x9A4, 0x9A5, 0x9B6, 0x9B7, 0x9B8, 0x9B9, 0x9BA, 0x9BB],
    [0x9AC, 0x9AD, 0x9AE, 0x9AF, 0x9B0, 0x9B1, 0x9B2, 0x9B3, 0x9B4, 0x9B5],
    [0x9BC, 0x9BD, 0x9BE, 0x9BF, 0x9C0, 0x9C1, 0x9C2, 0x9C3, 0x9C4, 0x9C5],
    [0x9BC, 0x9C6, 0x9C7, 0x9C8, 0x9C9, 0x9CA, 0x9CB, 0x9CC, 0x9CD, 0x9CE],
    [0x9CF, 0x9D0, 0x9D1, 0x9D2, 0x9D3, 0x9D4, 0x9D5, 0x9D6, 0x9D7, 0x9D8],
]
W, H = 10, 12
PAL_TCRF = [(0, 0, 0), (50, 41, 140), (247, 178, 146), (245, 142, 111), (172, 107, 78), (104, 75, 47),
            (72, 44, 18), (82, 107, 176), (0, 0, 0), (198, 198, 199), (255, 254, 255), (242, 41, 32),
            (170, 75, 29), (108, 108, 108), (249, 217, 56), (140, 143, 38)]
PAL_GRIS = [(v * 17, v * 17, v * 17) for v in range(16)]


def dibuja(pal):
    im = Image.new('RGB', (W * 8, H * 8), pal[0])
    for j, fila in enumerate(TRONO):
        for i, t in enumerate(fila):
            if t is not None: pon_tile(im, pal, t, i * 8, j * 8)
    return im


def comprueba():
    usados = [t for f in TRONO for t in f if t is not None]
    assert len(usados) == 96, len(usados)
    assert sorted(set(usados)) == list(range(INI, FIN + 1)), 'faltan o sobran tiles del rango'
    rep = [t for t in set(usados) if usados.count(t) > 1]
    assert rep == [0x9BC], rep


def coteja():
    """Identifica el tile de cada celda de la lamina de TCRF entre TODOS los
    tiles de la VRAM (coste de particion: pixeles que no siguen el color
    mayoritario de su indice, mas castigo si dos indices comparten color) y
    lo compara con TRONO. Tambien saca la paleta de la lamina por votos."""
    import numpy as np
    from collections import Counter
    lam = np.asarray(Image.open('work/g/tcrf.png').convert('RGB')).astype(int)
    MX0, MY0 = 41, 394                       # marco negro de la lamina (escala 1,85)
    sx = sy = 1.85; ox, oy = 40.75, 394.25   # ajuste fino (work/g/trono_dp2.py)
    crop = lam[MY0 - 4:MY0 + 190, MX0 - 4:MX0 + 156]
    cnt = Counter(map(tuple, crop.reshape(-1, 3))); cent = []
    for col, n in cnt.most_common():
        col = np.array(col); d = [np.abs(col - c).sum() for c, _ in cent]
        if cent and min(d) < 36: cent[int(np.argmin(d))][1] += n
        else: cent.append([col, n])
    C = np.array([c for c, n in sorted(cent, key=lambda x: -x[1]) if n >= 30]); K = len(C)
    oscuros = [i for i in range(K) if C[i].sum() < 80] + [int(np.argmin(np.abs(C - 89).sum(1)))]
    Q = np.abs(lam[:, :, None, :] - C[None, None]).sum(3).argmin(2)
    xs = np.floor(ox + (np.arange(W * 8) + 0.5) * sx).astype(int); ys = np.floor(oy + (np.arange(H * 8) + 0.5) * sy).astype(int)
    cel = Q[ys][:, xs].reshape(H, 8, W, 8).transpose(0, 2, 1, 3).reshape(H * W, 64)
    negro = np.isin(cel, oscuros).all(1)
    NA = 0xA00; TA = np.array([tile_px(t) for t in range(NA)]).reshape(NA, 64)
    OT = np.zeros((NA, 64, 16)); OT[np.arange(NA)[:, None], np.arange(64)[None, :], TA] = 1
    N = H * W; OC = np.zeros((N, 64, K)); OC[np.arange(N)[:, None], np.arange(64)[None, :], cel] = 1
    Hh = (OT.transpose(0, 2, 1).reshape(NA * 16, 64) @ OC.transpose(1, 0, 2).reshape(64, N * K)).reshape(NA, 16, N, K).transpose(2, 0, 1, 3)
    tam = Hh.sum(3); modo = Hh.argmax(3)
    M = np.zeros_like(Hh); np.put_along_axis(M, modo[..., None], tam[..., None], axis=3)
    coste = (tam - Hh.max(3)).sum(2) + (M.sum(2) - M.max(2)).sum(2)
    malas = 0; votos = np.zeros((16, K))
    for n in range(N):
        j, i = divmod(n, W); t = TRONO[j][i]
        if negro[n] != (t is None): print('  (%d,%d) negro en lamina=%s, en tabla=%s' % (j, i, negro[n], t)); malas += 1; continue
        if t is None: continue
        sub = coste[n, INI:FIN + 1]; mejor = int(sub.argmin()) + INI
        if mejor != t and not (t == 0x9BC and j == 10): print('  (%d,%d) tabla %03X, mejor de la lamina %03X (%d frente a %d)' % (j, i, t, mejor, coste[n, t], sub.min())); malas += 1
        np.add.at(votos, (TA[t], cel[n]), 1)
    print('celdas en desacuerdo con la lamina:', malas)
    mapa = votos.argmax(1)
    print('paleta de la lamina por indice (votos del mayoritario / total):')
    for g in range(16):
        if votos[g].sum(): print('  %X: %-16s %4d / %d' % (g, tuple(int(v) for v in C[mapa[g]]), votos[g].max(), votos[g].sum()))
    return malas


if __name__ == '__main__':
    comprueba()
    os.makedirs('work/g', exist_ok=True)
    im = dibuja(PAL_TCRF); im.save('work/g/trono.png')
    im.resize((W * 32, H * 32), Image.NEAREST).save('work/g/trono_x4.png')
    dibuja(PAL_GRIS).resize((W * 32, H * 32), Image.NEAREST).save('work/g/trono_gris_x4.png')
    print('trono: 10x12 tiles, 95 distintos + 9BC repetido; work/g/trono.png')
    if '--coteja' in sys.argv: sys.exit(1 if coteja() else 0)
