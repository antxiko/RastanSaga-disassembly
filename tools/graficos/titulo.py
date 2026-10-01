exec(open('tools/graficos/tiles.py').read())
import os
pal=pal_de(p00(0x5207,32))
if os.environ.get('INDICES'): pal=[(i,i,i) for i in range(16)]
img=Image.new('RGB',(256,212),pal[0])
tabla=lambda off,n: p00(0x5D27+off,n)
for f in range(7):
    for c in range(9):
        n=w(p00(0x5189+2*(f*9+c),2))
        if n&0xFF==0xFF: continue
        pon_bloque(img,pal,tabla,n,0x40+16*c,0x10+16*f,True)
img.resize((768,636),Image.NEAREST).save('work/g/titulo.png')
# rotulo de TAITO (p00:5025): 2 filas x 10 tiles desde (0x58, 0xA0), opaco
for f in range(2):
    for c in range(10):
        pon_tile(img,pal,w(p00(0x5227+2*(f*10+c),2)),0x58+8*c,0xA0+8*f)
def texto(s,x,y):
    for i,ch in enumerate(s):
        c=ord(ch)
        t=0 if c==0x20 else ((c-0x30-(6 if c-0x30>=10 else 0))+2)
        pon_tile(img,pal,t,x+8*i,y)
texto('@ TAITO CORPORATION 1988',0x20,0xB8)
texto('ALL RIGHTS RESERVED',0x38,0xC0)
texto('PUSH SPACE KEY',0x40,0x88)
img.save('work/g/titulo_idx.png' if os.environ.get('INDICES') else 'work/g/titulo_1x.png')
img.resize((768,636),Image.NEAREST).save('work/g/titulo.png')
