import sys
from PIL import Image
exec(open('tools/graficos/figuras.py').read().replace('\nmain()\n', '\n'))
b=int(sys.argv[1]); fase=int(sys.argv[2],0) if len(sys.argv)>2 else 0
pal,_=paleta(fase) if fase>=0 else (None,0)
if fase==-1:
    raw=p00(0x5207,32); pal=[]
    for i in range(16):
        a,c=raw[2*i],raw[2*i+1]; pal.append(tuple(v*255//7 for v in ((a>>4)&7,c&7,a&7)))
d=ROM[b*0x2000:(b+1)*0x2000]
im=Image.new('RGB',(256,64))
for i,v in enumerate(d):
    y,x=divmod(i,128); im.putpixel((2*x,y),pal[v>>4]); im.putpixel((2*x+1,y),pal[v&15])
im.resize((256*4,64*4),Image.NEAREST).save('work/g/bm%02d.png'%b)
