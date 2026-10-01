#!/usr/bin/env python3
"""El mapa de la RAM del juego: que guarda cada direccion, sacado del codigo.

Cada entrada dice QUE es y DONDE se ve (la rutina que la escribe o la lee de
forma que no deja dudas). tools/anota.py usa estos nombres para comentar las
instrucciones que las tocan. Lo que no se sabe, no esta: una direccion sin
entrada es una direccion sin explicar, no una adivinanza.

Rangos: (inicio, fin) -> nombre; las sueltas: direccion -> (nombre, texto).
"""

RAM = {
    0xD030: ("tarea_actual", "el contador de la tarea que corre (p00:427D)"),
    0xD032: ("en_interrupcion", "1 mientras la interrupcion hace el trabajo del cuadro (p00:411B)"),
    0xD063: ("sp_tmp", "el SP de la tarea que cede, de paso (p00:4260)"),
    0xD065: ("sp_interrupcion", "el SP de la interrupcion mientras corren las tareas (p00:4271)"),
    0xD067: ("d067", "3 al empezar (p00:4E2A)"),
    0xD178: ("sonido_d178", "peticion de sonido para p01:63E1 (0xFF = ninguna)"),
    0xD17A: ("sonido_d17a", "peticion de sonido para p01:640F (0xFF = ninguna)"),
    0xD17D: ("estado_juego", "bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo"),
    0xD17E: ("contador_0", "contador de cuadros 0 (p00:40BB)"),
    0xD180: ("contador_1", "contador de cuadros 1"),
    0xD181: ("demo_paso", "5 = la demo ha terminado (p00:50C1)"),
    0xD182: ("contador_2", "contador de cuadros 2"),
    0xD184: ("contador_3", "contador de cuadros 3"),
    0xD186: ("contador_4", "contador de cuadros 4"),
    0xD18C: ("primer_sprite", "el sprite por el que se empieza este cuadro (p00:4160)"),
    0xD18D: ("cuenta_tmp", "bytes ya copiados a VRAM, de paso (p00:417E)"),
    0xD18F: ("banco_4000", "copia del registro del mapper de 0x4000"),
    0xD190: ("banco_6000", "copia del registro del mapper de 0x6000"),
    0xD191: ("banco_8000", "copia del registro del mapper de 0x8000"),
    0xD192: ("banco_a000", "copia del registro del mapper de 0xA000"),
    0xD193: ("atributos", "la tabla de atributos de los 32 sprites (4 bytes cada uno)"),
    0xD213: ("colores", "los colores de los 32 sprites (16 bytes cada uno)"),
    0xD413: ("fichas", "las 32 fichas de sprite (11 bytes cada una)"),
    0xD476: ("ficha_9", "la ficha de sprite 9"),
    0xD481: ("ficha_10", "la ficha de sprite 10 (la del jugador de mas)"),
    0xD482: ("ficha_10_1", "ficha 10, byte alto del patron"),
    0xD484: ("ficha_10_y", "ficha 10, y"),
    0xD488: ("ficha_10_7", "ficha 10, byte +7"),
    0xD573: ("mandos", "los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2"),
    0xD574: ("fundido", "48 componentes de color del fundido (p00:449B)"),
    0xD5A4: ("fundido_marcas", "16 marcas de color cambiado del fundido"),
    0xD5B4: ("paleta", "la paleta puesta: 16 colores x 2 bytes"),
    0xD5D4: ("semilla", "la semilla del azar (p00:44DE)"),
    0xD5D6: ("pinta_x", "x donde se pinta (p00:46C9)"),
    0xD5D7: ("pinta_y", "y donde se pinta"),
    0xD5D8: ("pinta_columna", "columna del bloque que se pinta (p00:4711)"),
    0xD5D9: ("pinta_fila", "fila del bloque que se pinta"),
    0xD5DA: ("pinta_x0", "x del principio de la fila (p00:46CC)"),
    0xD5DB: ("pinta_lista", "la lista o la cadena que se esta pintando"),
    0xD5DD: ("sprites_dx", "lo que se suma a la x de los sprites (la x del actor)"),
    0xD5DE: ("sprites_dy", "lo que se suma a la y de los sprites (la y del actor)"),
    0xD5DF: ("en_marcha", "0xFF = el juego corre, 0 = pausa (STOP, p00:52F7)"),
    0xD5E0: ("scroll_v", "el desplazamiento vertical de la pantalla (R#23)"),
    0xD5E1: ("fondo_fila0", "el mapa de fondo de la fila 0 de pantallas (ficha +8)"),
    0xD5E3: ("fondo_filas", "el mapa de fondo de las demas filas (ficha +A)"),
    0xD5E5: ("fase", "la fase (0-0x17)"),
    0xD5E7: ("tabla_pantallas", "la tabla de pantallas de la fase (ficha +0)"),
    0xD5E9: ("banco_mapas", "el banco de los mapas de la fase (ficha +E)"),
    0xD5EA: ("tabla_bloques", "la tabla de bloques de 16x16 de la fase (ficha +2)"),
    0xD5EC: ("tabla_bloques_g", "la tabla de bloques guardada (p00:48B9)"),
    0xD5EE: ("ultima_columna", "la ultima columna de pantallas (ficha +4)"),
    0xD5EF: ("ultima_fila", "la ultima fila de pantallas (ficha +5)"),
    0xD5F0: ("columna", "la columna de la pantalla en que se esta"),
    0xD5F1: ("fila", "la fila de la pantalla en que se esta"),
    0xD5F4: ("mapa_fondo", "el fondo desempaquetado: 11 x 16 bloques"),
    0xD774: ("mapa_delante", "lo de delante desempaquetado: 11 x 16 bloques"),
    0xD8D4: ("d8d4", "32 bytes que se ponen a 0xFF al entrar en una pantalla"),
    0xD8FC: ("jugador_x", "la x de Rastan"),
    0xD8FD: ("jugador_y", "la y de Rastan"),
    0xD913: ("d913", "0x27 al entrar en una pantalla"),
    0xD922: ("jugador_y2", "la y de la ficha 10 del jugador"),
    0xD923: ("jugador_x2", "la x de la ficha 10 del jugador"),
    0xD924: ("d924", "bit 7: el jugador usa la ficha 10 (p00:5717)"),
    0xD92B: ("especial_x", "x del bloque especial de la pantalla"),
    0xD92C: ("especial_y", "y del bloque especial"),
    0xD92D: ("especial", "cual es el bloque especial (0 = ninguno)"),
    0xD92E: ("entrada_x", "x donde aparece el jugador en la pantalla nueva"),
    0xD92F: ("entrada_y", "y donde aparece el jugador"),
    0xD933: ("actores", "los 6 actores de la pantalla (38 bytes cada uno)"),
    0xDA17: ("grupos_sprites", "tres grupos de sprites, dos bits cada uno (p00:4C25)"),
    0xDA18: ("sitios_sprites", "seis sitios de un sprite, un bit cada uno (p00:4C12)"),
    0xDA19: ("sin_sitio", "bit 0: no hay grupo libre, bit 1: no hay sitio libre"),
    0xDA20: ("enemigos", "los 8 enemigos de la pantalla (38 bytes cada uno)"),
}


def nombre(a):
    """(nombre, texto) de la direccion a, o None."""
    return RAM.get(a)
