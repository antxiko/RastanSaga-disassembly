"""Que pantalla hay en cada volcado: la que deja en D774 (176 palabras) el
mapa de delante con sus columnas alargadas, contra todas las del cartucho."""
import sys, os, json
exec(open('tools/graficos/fases.py').read().split("if __name__")[0])
huella = {}
for f in range(24):
    fc = ficha(f); nc = fc['ucol'] + 1
    for r in range(fc['ufil'] + 1):
        for c in range(nc):
            wd = w(b2(fc['pant'] + 2 * (r * nc + c), 2))
            if wd & 0xFF == 0xFF or wd == 0:
                continue
            dl, fin = desempaqueta(fc['banco'], wd)
            alarga(fc['banco'], fin, dl)
            k = bytes(b for x in dl[:176] for b in (x & 0xFF, x >> 8))
            huella.setdefault(k, []).append((f, c, r))
def quien(ram):
    k = ram[0xD774 - 0xC000:0xD774 - 0xC000 + 352]
    return huella.get(k)
if __name__ == '__main__':
    D = sys.argv[1]
    for n in sorted(os.listdir(D)):
        if n.endswith('.ram'):
            ram = open(D + '/' + n, 'rb').read()
            print(n, quien(ram), 'RAM:', '%02X %d %d' % (ram[0xD5E5 - 0xC000], ram[0xD5F0 - 0xC000], ram[0xD5F1 - 0xC000]))
