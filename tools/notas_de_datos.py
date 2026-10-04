#!/usr/bin/env python3
"""Escribe las directivas D de los bytes que el presupuesto da por sin explicar
y que tools/datos.py recorre: cada rango sale con el nombre de la estructura
que lo lee y la rutina que lo hace. Lo que no recorre nadie y es todo 0xFF va
como relleno; lo demas se lista aparte para mirarlo a mano.

Uso: notas_de_datos.py            (ensena las lineas y lo que falta)
     notas_de_datos.py --escribe  (las anade al final de cada src/pNN.notes)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import datos                                   # noqa: E402
from paginas import org, nombre, N_PAGINAS      # noqa: E402
from presupuesto import reparte, SIN_EXPLICAR   # noqa: E402

TEXTO = {
    'tiles': 'Tiles de 8x8 de SCREEN 5 (4 bits por punto, filas de 128 bytes): p01:6077 copia los bancos 0x10-0x19 enteros a la VRAM',
    'patrones_de_sprite': 'Patrones de sprite de 16x16 (32 bytes) que nombra alguna definicion; p00:4534 copia cada uno a la VRAM cuando toca',
    'patrones_sin_definicion': 'Patrones de sprite de 32 bytes que no nombra ninguna definicion recorrida por tools/datos.py; este banco solo lo pone la copia de patrones (p00:4534, y p00:58C3 el 8), y en el recorrido medido no se copia ninguno (tools/omsx_lecturas.tcl por las 257 pantallas)',
    'definiciones_de_sprite': 'Definiciones de sprite (p00:5AA5): base de patrones (2), numero de cuadros (1) y sus direcciones; cuadro = duracion, n sprites, n x (patron, x, y, juego)',
    'definiciones_de_jefe': 'Definiciones de sprite de los jefes, mismo formato (p00:5AA5), con el banco 8 en 0x6000 (p00:58C3); listas en p03:7F76',
    'definiciones_sueltas': 'Con el formato de una definicion de sprite (cabecera y cuadros); ni lista de poses ni puntero llega a ellas y en el recorrido medido no se animan (tools/omsx_lecturas.tcl por las 257 pantallas)',
    'tablas_de_bloques': 'Tabla de bloques de 16x16 de una fase (p00:4777, ficha +2): cuatro palabras de tile por bloque, en filas de 8 bloques (64 bytes)',
    'bloques_sin_pantalla': 'Filas de bloques de una tabla que no pinta el mapa de ninguna pantalla de su fase; ojo: p06:6226 repinta desde la copia del fondo (D5F4) y en el recorrido medido lee los bloques 0x70 y 0x71 de la tabla A2C0 (A640/A644) (tools/omsx_lecturas.tcl por las 257 pantallas)',
    'mapas': 'Mapas de las fases (p00:5461): bloques empaquetados (0xD0 repite, EF EF acaba), columnas alargadas (p00:55C5, hasta 0xFF) y actores (p00:58F9: enemigos, objetos y bloque especial, cada lista con su 0xFF)',
    'fichas_de_fase': 'Las 24 fichas de fase (p00:5655), 16 bytes: pantallas, bloques, tamano, salida, fondos, paleta, banco de mapas y donde sale Rastan',
    'pantallas_de_fase': 'Por fase, la direccion de la lista de cada pantalla, fila a fila (0xFF = no hay); p00:5461',
    'paletas_de_fase': 'Paleta de cada fase, 16 colores de 2 bytes (0RRR0BBB 00000GGG), ficha +0x0C',
    'tabla_de_efectos': 'La partitura de cada uno de los 18 efectos de sonido (p01:63FA)',
    'tabla_de_musicas': 'Las tres partituras (una por voz) de cada una de las 9 musicas (p01:6437)',
    'tabla_de_envolventes_de_volumen': 'Las 11 envolventes de volumen que pide el codigo 0x80 de una partitura (p01:6338)',
    'tabla_de_envolventes_de_tono': 'Las 13 envolventes de tono que pide el codigo 0x81 de una partitura (p01:634F)',
    'envolventes_de_volumen': 'Envolventes de volumen (p01:619B): pasos de 2 bytes (veces/cuadros, cambio) hasta un 0',
    'envolventes_de_tono': 'Envolventes de tono (p01:61F7): pasos de 2 bytes (veces/cuadros, cambio) hasta un 0',
    'envolvente_por_defecto': 'La envolvente a la que apuntan las cuatro cabeceras de voz (+0C y +0E): un paso F0 00 y el 0',
    'partituras': 'Partituras (p01:6253): nota = duracion + tono (2) o silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84 vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador, 0xF0 volumen, 0 fin',
    'sonido_suelto': 'Bytes en la zona del sonido a los que no llega ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido medido (tools/omsx_lecturas.tcl por las 257 pantallas)',
    'relleno': 'Relleno: todo 0xFF',
}
JUNTA = {'mapas_cola_de_fondo': 'mapas', 'mapas_fin_de_especial': 'mapas'}


def sin_dueno(p, ini, fin):
    """Nombre para lo que no recorre nadie."""
    d = datos.ROM[p * 0x2000 + ini:p * 0x2000 + fin]
    if set(d) == {0xFF}:
        return 'relleno'
    if 8 <= p <= 15:
        return 'patrones_sin_definicion'
    if p in (26, 30):
        return 'definiciones_sueltas'
    if p == 27:
        return 'bloques_sin_pantalla'
    if p in (1, 2):
        return 'sonido_suelto'
    return None


def rangos_de(p):
    estado = reparte('work', 'src', p)
    out = []
    i = 0
    while i < 0x2000:
        if estado[i] != SIN_EXPLICAR:
            i += 1
            continue
        n = datos.LEIDO.get((p, i))
        n = JUNTA.get(n, n)
        j = i + 1
        while j < 0x2000 and estado[j] == SIN_EXPLICAR and JUNTA.get(datos.LEIDO.get((p, j)), datos.LEIDO.get((p, j))) == n:
            j += 1
        out.append([i, j, n])
        i = j
    # lo que no tiene dueno: las tiradas de 4 o mas 0xFF son relleno; lo
    # demas (con sus FF sueltos) se nombra por el banco
    res = []
    for i, j, n in out:
        if n:
            res.append([i, j, n])
            continue
        k = i
        trozo = i
        while k < j:
            m = k
            while m < j and datos.ROM[p * 0x2000 + m] == 0xFF:
                m += 1
            if m - k >= 4:
                if trozo < k:
                    res.append([trozo, k, sin_dueno(p, trozo, k)])
                res.append([k, m, 'relleno'])
                trozo = m
            k = max(m, k + 1)
        if trozo < j:
            res.append([trozo, j, sin_dueno(p, trozo, j)])
    fus = []
    for r in res:
        if fus and fus[-1][2] == r[2] and fus[-1][1] == r[0]:
            fus[-1][1] = r[1]
        else:
            fus.append(r)
    return fus


def main():
    datos.fases(); datos.sprites(); datos.tiles(); datos.sonido()
    escribe = '--escribe' in sys.argv
    falta = 0
    for p in range(N_PAGINAS):
        o = org(p)
        lineas = []
        for i, j, n in rangos_de(p):
            if n is None:
                falta += j - i
                print('FALTA %s 0x%04X..0x%04X (%d) %s' % (nombre(p), o + i, o + j - 1, j - i,
                                                         datos.ROM[p * 0x2000 + i:p * 0x2000 + min(j, i + 16)].hex(' ')))
                continue
            lineas.append('D 0x%04X 0x%04X %s_%04X  %s' % (o + i, o + j, n, o + i, TEXTO[n]))
        if not lineas:
            continue
        if escribe:
            path = os.path.join('src', nombre(p) + '.notes')
            with open(path, encoding='utf-8') as f:
                txt = f.read()
            if txt and not txt.endswith('\n'):
                txt += '\n'
            txt += '\n# Datos recorridos por tools/datos.py (tools/notas_de_datos.py)\n' + '\n'.join(lineas) + '\n'
            with open(path, 'w', encoding='utf-8', newline='\n') as f:
                f.write(txt)
        else:
            print('\n'.join(lineas))
    print('sin nombre: %d bytes' % falta)


if __name__ == '__main__':
    main()
