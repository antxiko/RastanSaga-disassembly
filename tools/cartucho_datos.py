"""Lo que tools/cartucho.py necesita saber de ESTE cartucho, medido en la ROM.

Separado del trazador para que el trazador no lleve nada de ningun juego.
"""
N = None

# Copias en RAM de los cuatro registros del mapper (p00:403A..404D las
# escribe junto con el registro, y la interrupcion las relee en p00:40A7).
COPIA = (0xD18F, 0xD190, 0xD191, 0xD192)

# (pc, bancos en 4000/6000/8000/A000, porque)
SEMILLAS = [
    (0x4011, (0, 0, 0, 0), "INIT de la cabecera (p00:4002)"),
    (0x406C, (0, N, N, N), "interrupcion: p00:405E pone `jp 0x406C` en H.TIMI"),
]
# Las tareas del planificador (p00:426E). p00:4228 arranca la tarea A con la
# direccion de la tabla p00:429A; p00:405B arranca la 0 desde INIT, con los
# bancos 0/1/2 de INIT puestos (SUPOSICION para las demas: los mismos).
for _i, _pc in enumerate((0x4E14, 0x524F, 0x56F2, 0x5760, 0x5799)):
    SEMILLAS.append((_pc, (0, 1, 2, 0), "tarea %d (tabla p00:429A)" % _i))

# Llamadas que ceden el turno y vuelven en otro cuadro: la interrupcion
# (p00:40A7..40B0) ha repuesto desde la copia las ranuras 6000 y 8000.
VUELVE_CON_COPIA = {0x4255: (1, 2), 0x424E: (1, 2)}

# Saltos indirectos resueltos: (banco, pc del jp (hl)) -> [destinos]
def _tabla(banco, org, ini, n, paso=2, campo=0, desde=0):
    """Las palabras de una tabla de saltos: n entradas de `paso` bytes con la
    direccion en el byte `campo` de cada una, empezando en la entrada `desde`."""
    from os.path import dirname, join
    rom = open(join(dirname(dirname(__file__)), "rastan.rom"), "rb").read()
    o = banco * 0x2000 - org
    return sorted({rom[o + ini + paso * i + campo] | rom[o + ini + paso * i + campo + 1] << 8
                   for i in range(desde, n)})


TABLAS = {
    # p00:4631 es la vuelta de la rutina de texto en linea (p00:4612): el
    # `ex (sp),hl` deja en la pila la direccion de detras del 0. No es un salto
    # a tabla: ya lo sigue TEXTO_EN_LINEA.
    (0, 0x4631): [],
    # p07:8172: E = (ix+0), 1..0x17 (p07:817F `or a / jp z`, p07:8183 `cp 0x18`),
    # tabla de 3 bytes en p07:8404 con la direccion en los bytes 1-2
    (7, 0x819E): _tabla(7, 0x8000, 0x8404, 24, 3, 1, desde=1),
    # p07:844C: lo mismo con la tabla de 4 bytes de p07:8592 (direccion en 2-3)
    (7, 0x847A): _tabla(7, 0x8000, 0x8592, 24, 4, 2, desde=1),
    # p07:8632: (ix+0) entre 0x17 y 0x24, tabla de 14 palabras en p07:864C
    (7, 0x864A): _tabla(7, 0x8000, 0x864C, 14),
    # p07:8C05: BC es el desplazamiento en bytes; la tabla de p07:8C13 acaba
    # donde empieza la siguiente, p07:8C31 (la que lee p07:8BF6): 15 palabras
    (7, 0x8C11): _tabla(7, 0x8000, 0x8C13, 15),
    # p03:604B: indice (ix+0)-1 en la tabla de 32 palabras de p03:60C9; la
    # entrada 33 ya no apunta a codigo (0xDDC9) y detras empieza p03:6109
    (3, 0x605B): sorted({0x645E, 0x6109, 0x67BA, 0x668D, 0x6B59, 0x717D,
                         0x6639, 0x6CDC, 0x70C6, 0x610A, 0x6134, 0x6745,
                         0x61AA, 0x7076, 0x6206, 0x74FC, 0x7368, 0x6E95,
                         0x76F1, 0x78AD}),
}

# Llamadas que no vuelven (sacan la direccion de vuelta de la pila).
NO_VUELVE = set()

# Llamadas que vuelven con otros bancos puestos: dir -> {ranura: banco}
CAMBIA_BANCOS = {}

# Rutinas que llevan una cadena acabada en 0 detras del CALL: p00:4612 la
# recorre con `ex (sp),hl` y vuelve detras del 0 (p00:4630).
TEXTO_EN_LINEA = {0x4612}

# Variables que solo toman los valores de una tabla de la ROM, y que acaban en
# un registro del mapper. D5E9 es el byte +14 de las 24 fichas de fase de
# p02:9035 (p00:56CF lo copia): 0x1C en las fases 0-14 y 0x1E en las 15-23.
# p00:557D mete ese banco en 0x8000 y el siguiente en 0xA000.
VARIABLES = {0xD5E9: (0x1C, 0x1E)}

# Las tablas de saltos son datos: el trazador por bancos (z80trace.py) no debe
# entrar en ellas. (banco, ini, fin, que) -> src/pNN.nocode
ZONAS_TABLA = [
    (3, 0x60C9, 0x6109, "tabla de 32 palabras que salta p03:605B"),
    (7, 0x8407, 0x844C, "tabla de 3 bytes que salta p07:819E (entradas 1-23)"),
    (7, 0x8596, 0x85F2, "tabla de 4 bytes que salta p07:847A (entradas 1-23)"),
    (7, 0x864C, 0x8668, "tabla de 14 palabras que salta p07:864A"),
    (7, 0x8C13, 0x8C31, "tabla de 15 palabras que salta p07:8C11"),
]

# RUTINAS HUERFANAS: codigo que ningun call, jp ni tabla alcanza (no hay ni un
# operando de 16 bits que las apunte: work/apunta.py). Son restos que se
# quedaron en el cartucho; muchas son copias muertas detras de un `jp` (el
# mismo `ld (ix+12h),10h / jp X` dos veces seguidas). Se aceptaron porque, leidas
# desde ahi, acaban en `ret`/`jp` y cada call/jp cae en un inicio de
# instruccion ya conocido (work/huerfanas.py); las cinco ultimas, a ojo.
# Se trazan con el banco de al lado que les toca (PAREJA).
PAREJA = {0: (0, 1, 2, 0), 1: (0, 1, 2, 0), 3: (0, 3, 4, 0), 4: (0, 3, 4, 0),
          5: (0, 5, 2, 0), 6: (0, 6, 7, 0), 7: (0, 6, 7, 0)}
HUERFANAS = [
    "p00:41EC", "p00:4215", "p00:421D", "p00:4313", "p00:4332", "p00:449B",
    "p01:646C", "p03:640F", "p03:6417", "p03:65C2", "p03:672E", "p03:6932",
    "p03:6CC0", "p03:6DC6", "p03:6DFD", "p03:6E8B", "p03:7003", "p03:72D2",
    "p03:7456", "p03:74F2", "p03:7678", "p03:7768", "p03:77E8", "p03:794F",
    "p03:799D", "p03:7A3E", "p03:7C46", "p03:7C74", "p03:7D23", "p03:7E63",
    "p03:7E71", "p03:7E7A", "p04:80C7", "p04:8321", "p04:86A2", "p04:884F",
    "p05:634B", "p06:60B3", "p06:7D8F", "p06:7E50", "p07:82CA",
]
for _h in HUERFANAS:
    _b, _a = int(_h[1:3]), int(_h[4:], 16)
    SEMILLAS.append((_a, PAREJA[_b], "huerfana: nadie la llama"))
