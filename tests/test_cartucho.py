#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM. Si no esta, NO se saltan: se hacen
sobre la ROM que sale de reensamblar el listado publicado (src/*.asm) con
pasmo, que es la misma byte a byte (make verify lo comprueba). Un test que se
salta no comprueba nada.

Cada una corresponde a una afirmacion de las notas o de la web, y todas leen
el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import re
import subprocess
import sys
import tempfile
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, N_PAGINAS, mide          # noqa: E402

ROM = os.path.join(RAIZ, "rastan.rom")
SHA = "03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e"


def carga_rom():
    """La ROM de la raiz o, si no esta, la del listado reensamblado."""
    if os.path.exists(ROM):
        return open(ROM, "rb").read()
    trozos = []
    with tempfile.TemporaryDirectory() as tmp:
        for p in range(N_PAGINAS):
            asm = os.path.join(RAIZ, "src", "rastan_p%02d.asm" % p)
            out = os.path.join(tmp, "p%02d.bin" % p)
            subprocess.run(["pasmo", "--bin", asm, out], check=True,
                           capture_output=True)
            trozos.append(open(out, "rb").read())
    return b"".join(trozos)


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.rom = carga_rom()

    def pb(self, banco, addr, n):
        """n bytes del banco leidos por su direccion de ejecucion."""
        o = banco * TAM_PAGINA + (addr - ORG[banco])
        return self.rom[o:o + n]

    def w(self, banco, addr):
        b = self.pb(banco, addr, 2)
        return b[0] | b[1] << 8

    def test_rom_entera(self):
        self.assertEqual(len(self.rom), 32 * 8192)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_e_init(self):
        # "AB" y INIT en 0x4011
        self.assertEqual(self.pb(0, 0x4000, 4), b"AB\x11\x40")

    def test_ascii8_y_regla_de_org(self):
        # Solo se escribe en los cuatro registros de ASCII8, y cada banco fijo
        # entra en la ranura de su org (el 0 en 0xA000 es la unica excepcion)
        vistas, raras = mide(self.rom)
        self.assertEqual(len(vistas), 54)
        self.assertEqual(len(raras), 12)
        malas = [(o, n, r) for o, n, r in vistas if ORG[n] != r and n != 0]
        self.assertEqual(malas, [])
        # ni una escritura a los registros de Konami (0x5000/0x9000/0xB000)
        for reg in (b"\x32\x00\x50", b"\x32\x00\x90", b"\x32\x00\xb0"):
            self.assertNotIn(reg, self.rom)

    def test_makefile_y_paginas_dicen_lo_mismo(self):
        mk = open(os.path.join(RAIZ, "Makefile"), encoding="utf-8").read()
        for p in range(N_PAGINAS):
            m = re.search(r"^ORG_%02d = (0x[0-9a-f]+)$" % p, mk, re.M)
            self.assertEqual(int(m.group(1), 16), ORG[p], "banco %d" % p)

    def test_msx2_r15(self):
        # La interrupcion lee S#0 tras escribir 0 en R#15: registro del V9938
        self.assertEqual(self.pb(0, 0x4081, 8), bytes.fromhex("3e00ed793e8fed79"))

    def test_tareas(self):
        # p00:4240 lee la tabla de arranques de tarea de p00:429A: cinco
        self.assertEqual(self.pb(0, 0x4240, 3), b"\x21\x9a\x42")
        t = [self.w(0, 0x429A + 2 * i) for i in range(6)]
        self.assertEqual(t, [0x4E14, 0x524F, 0x56F2, 0x5760, 0x5799, 0])

    def test_texto_en_linea(self):
        # p00:4612 `ex (sp),hl` ... `inc hl / ex (sp),hl / ret`: vuelve
        # detras del 0 de la cadena que va pegada al call
        self.assertEqual(self.pb(0, 0x4612, 1), b"\xe3")
        self.assertEqual(self.pb(0, 0x4630, 3), b"\x23\xe3\xc9")
        o = self.rom.index(b"GAME OVER\x00")
        self.assertEqual(self.rom[o - 3:o], b"\xcd\x12\x46")

    def test_fichas_de_fase(self):
        # 24 fichas de 16 bytes en p02:9035 (p00:5693); el byte 14 es el banco
        # que p00:557D pone en 0x8000 (y el siguiente en 0xA000)
        self.assertEqual(self.pb(0, 0x5693, 3), b"\x11\x35\x90")
        bancos = [self.pb(2, 0x9035 + 16 * i + 14, 1)[0] for i in range(24)]
        self.assertEqual(bancos, [0x1C] * 15 + [0x1E] * 9)

    def test_tablas_de_saltos(self):
        # p03:605B salta por la tabla de p03:60C9; la entrada 33 ya no es codigo
        self.assertEqual(self.pb(3, 0x604F, 3), b"\x11\xc9\x60")
        self.assertEqual(self.pb(3, 0x605B, 1), b"\xe9")
        for i in range(32):
            self.assertTrue(0x6000 <= self.w(3, 0x60C9 + 2 * i) < 0x8000)
        # las cuatro de p07 acaban en `ex (sp),hl / ret`
        for pc, tabla in ((0x819E, 0x8404), (0x847A, 0x8592),
                          (0x864A, 0x864C), (0x8C11, 0x8C13)):
            self.assertEqual(self.pb(7, pc, 2), b"\xe3\xc9")
            self.assertIn(bytes([tabla & 255, tabla >> 8]), self.pb(7, pc - 40, 40))


if __name__ == "__main__":
    unittest.main()
