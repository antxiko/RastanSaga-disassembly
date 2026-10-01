import sys
from PIL import Image, ImageDraw
exec(open('tools/graficos/figuras.py').read().replace('\nmain()\n', '\n'))
def b3(a,n=1):
    o=3*0x2000+(a-0x6000); return ROM[o:o+n]
fase=int(sys.argv[1],0) if len(sys.argv)>1 else 2
pal,pp=paleta(fase)
tc=p00(0x4DF4,32)
tipos=[w(b3(0x7F76+2*i,2)) for i in range(7)]
lims=tipos[1:]+[0x7FDA]
filas=[]
for t,(a,f) in enumerate(zip(tipos,lims)):
    poses=[w(b3(x,2)) for x in range(a,f,2)]
    cel=[]
    for pi,pd in enumerate(poses):
        n=banco(8,pd,3)[2]
        for k in range(n):
            _,dur,spr=cuadro(8,pd,k)
            cel.append(('%d.%d'%(pi,k),pinta(spr,pal,tc)))
    filas.append((t+1,cel))
CW,CH=120,120; M=14
nf=sum((len(c)+M-1)//M for _,c in filas)
img=Image.new('RGB',(40+M*CW,nf*(CH+12)),(24,24,32)); dr=ImageDraw.Draw(img)
y0=0
for t,cel in filas:
    dr.text((2,y0+2),'J%d'%t,fill=(255,255,0))
    for i,(lab,can) in enumerate(cel):
        cx=40+(i%M)*CW; cy=y0+(i//M)*(CH+12)
        dr.text((cx,cy),lab,fill=(150,150,150))
        if not can: continue
        xs=[p[0] for p in can]; ys=[p[1] for p in can]
        ox=cx+(CW-(max(xs)-min(xs)+1))//2-min(xs); oy=cy+12+(CH-(max(ys)-min(ys)+1))//2-min(ys)
        for (x,y),c in can.items():
            if 0<=ox+x<img.width and 0<=oy+y<img.height: img.putpixel((ox+x,oy+y),pal[c] if c else (60,60,70))
    y0+=((len(cel)+M-1)//M)*(CH+12)
img=img.resize((img.width*2,img.height*2),Image.NEAREST); img.save('work/g/jefes_f%02x.png'%fase); print(img.size, hex(pp))
