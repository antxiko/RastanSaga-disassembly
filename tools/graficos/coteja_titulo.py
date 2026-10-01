import sys
from PIL import Image
D='work/v_titulo/'
mio=Image.open('work/g/titulo_idx.png').convert('RGB')
exec(open('tools/graficos/tiles.py').read())
pal=pal_de(p00(0x5207,32)); inv={(i,i,i):i for i in range(16)}
# mi titulo en bytes de SCREEN 5 (color 0 y 8 son negros: se resuelve por indice 0)
mb=bytearray(128*212)
for y in range(212):
    for x in range(0,256,2):
        a=inv.get(mio.getpixel((x,y)),0); b=inv.get(mio.getpixel((x+1,y)),0)
        mb[y*128+x//2]=a<<4|b
for t in sys.argv[1:]:
    v=open(D+'t%s.vram'%t,'rb').read(); r=open(D+'t%s.regs'%t,'rb').read(); p=open(D+'t%s.pal'%t,'rb').read()
    pagina=(r[2]>>5)&3; sc=r[23]
    pv=v[pagina*0x8000:pagina*0x8000+128*212]
    dif=sum(1 for i in range(128*212) if pv[i]!=mb[i])
    lin=sorted(set(i//128 for i in range(128*212) if pv[i]!=mb[i]))
    print('t%s pagina %d scroll %02X R1 %02X paleta=titulo:%s  bytes distintos %d  lineas %s'%(t,pagina,sc,r[1],p==p00(0x5207,32),dif,(lin[:3],lin[-3:]) if lin else '-'))
    vp=pal_de(p)
    im=Image.new('RGB',(256,212))
    for i in range(128*212):
        y,x=divmod(i,128); im.putpixel((2*x,y),vp[pv[i]>>4]); im.putpixel((2*x+1,y),vp[pv[i]&15])
    im.resize((512,424),Image.NEAREST).save('work/g/v_t%s.png'%t)
