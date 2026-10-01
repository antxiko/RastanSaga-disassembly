"""Tiles y bloques como los pinta el cartucho: tile t = banco 16 + t//256 (la
VRAM guarda los bancos 0x10-0x19 seguidos, p01:6077); bloque de 16x16 =
4 palabras de tile de una tabla en filas de 8 bloques (p00:4777)."""
from PIL import Image
exec(open('tools/graficos/figuras.py').read().replace('\nmain()\n', '\n'))
def pal_de(raw):
    pal=[]
    for i in range(16):
        a,c=raw[2*i],raw[2*i+1]; pal.append(tuple(v*255//7 for v in ((a>>4)&7,c&7,a&7)))
    return pal
def _vram_tiles():
    """La zona de tiles como la deja carga_graficos (p01:6077): bancos 0x10-0x11
    a VRAM 0xC000 y 0x12-0x19 a las paginas 2 y 3, de 16 KB en 16 KB con
    LDIRVM de 0x3FFF bytes: el ultimo byte de cada 16 KB se queda a 0."""
    v=bytearray(0x2000*10)
    for k in range(5):
        trozo=ROM[(16+2*k)*0x2000:(18+2*k)*0x2000]
        v[k*0x4000:k*0x4000+0x3FFF]=trozo[:0x3FFF]
    return bytes(v)
VRAM_TILES=_vram_tiles()
def tile_px(t):
    r=t; ty,tx=divmod(r,32)
    out=[]
    for y in range(8):
        fila=[]
        for x in range(4):
            v=VRAM_TILES[(ty*8+y)*128+tx*4+x]; fila+= [v>>4, v&15]
        out.append(fila)
    return out
def pon_tile(img,pal,t,X,Y,transp=False):
    px=tile_px(t)
    for y in range(8):
        for x in range(8):
            c=px[y][x]
            if transp and c==0: continue
            img.putpixel((X+x,Y+y),pal[c])
def bloque_tiles(tabla_bytes_fn, b):
    """tabla_bytes_fn(off,n) lee la tabla; b = numero de bloque."""
    off=(b&0xF8)*8+(b&7)*4
    q=tabla_bytes_fn(off,4); r=tabla_bytes_fn(off+32,4)
    return [w(q,0),w(q,2),w(r,0),w(r,2)]
def pon_bloque(img,pal,tabla_fn,b,X,Y,transp=False):
    tl,tr,bl,br=bloque_tiles(tabla_fn,b)
    pon_tile(img,pal,tl,X,Y,transp); pon_tile(img,pal,tr,X+8,Y,transp)
    pon_tile(img,pal,bl,X,Y+8,transp); pon_tile(img,pal,br,X+8,Y+8,transp)
