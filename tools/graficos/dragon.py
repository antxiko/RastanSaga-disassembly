"""Lo que la fase del dragon (0x11, la que nunca se juega) tiene en su tabla de
bloques (p27:B740) y ningun mapa usa: los bloques 0x60-0x77, con la paleta de
la propia fase (ficha +C). Todo sale de la ROM; lo unico puesto por nosotros
es la posicion relativa de los bloques (centrados sobre la fila de 4 de la
cabeza; el orden 0x68 -> 0x77 va de arriba abajo).
  0x68-0x69 remate del cuello (tiles 0x6FD-0x700, 0x707-0x709)
  0x6A-0x6D cuello (0x701-0x704), 0x6E-0x6F cuernos y frente (0x705-0x706)
  0x70-0x77 la cabeza: ojos, mandibula y barbilla (0x70A-0x725)
  0x60-0x63 punta de la cola, 0x64-0x67 fauces abiertas (0x6E7-0x6FC)
Salidas: work/g/dragon_cabeza.png (solo la cabeza, 64x64), dragon_cabeza_x4,
dragon_cabeza_cuello_x4.png (0x68-0x77), dragon_cola_fauces_x4.png (0x60-0x67)."""
import os
exec(open('tools/graficos/tiles.py').read())
TABLA = lambda off, n: ROM[27 * 0x2000 + (0xB740 - 0xA000) + off:][:n]
PAL, _ = paleta(0x11)
CABEZA_CUELLO = [[None, 0x68, 0x69, None], [None, 0x6A, 0x6B, None], [None, 0x6C, 0x6D, None],
                 [None, 0x6E, 0x6F, None], [0x70, 0x71, 0x72, 0x73], [None, 0x74, 0x75, None], [None, 0x76, 0x77, None]]


def dibuja(disp):
    im = Image.new('RGB', (16 * len(disp[0]), 16 * len(disp)), PAL[0])
    for j, fila in enumerate(disp):
        for i, b in enumerate(fila):
            if b is not None: pon_bloque(im, PAL, TABLA, b, i * 16, j * 16)
    return im


def comprueba():
    # la ficha de la fase 0x11 apunta a B740 y los 24 bloques tienen tiles del banco 0x17 (0x6E7-0x725)
    f = ROM[2 * 0x2000 + (0x9035 - 0x8000) + 0x11 * 16:][:16]
    assert w(f, 2) == 0xB740, hex(w(f, 2))
    ts = set()
    for b in range(0x60, 0x78): ts.update(t for t in bloque_tiles(TABLA, b) if t not in (0, 0x180))
    assert ts == set(range(0x6E7, 0x726)), sorted('%03X' % t for t in ts ^ set(range(0x6E7, 0x726)))


if __name__ == '__main__':
    comprueba(); os.makedirs('work/g', exist_ok=True)
    cab = dibuja(CABEZA_CUELLO[3:]); cab.save('work/g/dragon_cabeza.png')
    cab.resize((cab.width * 4, cab.height * 4), Image.NEAREST).save('work/g/dragon_cabeza_x4.png')
    todo = dibuja(CABEZA_CUELLO); todo.resize((todo.width * 4, todo.height * 4), Image.NEAREST).save('work/g/dragon_cabeza_cuello_x4.png')
    cola = dibuja([list(range(0x60, 0x68))]); cola.resize((cola.width * 4, 64), Image.NEAREST).save('work/g/dragon_cola_fauces_x4.png')
    print('dragon: cabeza %dx%d, cabeza+cuello %dx%d, cola y fauces 8 bloques; work/g/dragon_*.png' % (cab.width, cab.height, todo.width, todo.height))
