#!/usr/bin/env python3
"""Las instrucciones que aun no llevan comentario, rutina a rutina, con su
direccion: la lista de trabajo de la segunda pasada.

Uso: sin_comentar.py <banco> [desde] [hasta]
"""
import re
import sys

b = int(sys.argv[1])
a0 = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0
a1 = int(sys.argv[3], 16) if len(sys.argv) > 3 else 0x10000
for ln in open("src/rastan_p%02d.asm" % b, encoding="utf-8"):
    m = re.match(r"^([A-Za-z_]\w*):", ln)
    if m:
        lab = m.group(1)
        continue
    m = re.match(r"^\t(.*?)\s*;([0-9a-f]{4})(\s+;.*)?$", ln.rstrip("\n"))
    if not m:
        continue
    a = int(m.group(2), 16)
    if a0 <= a < a1:
        ins = re.sub(r"\s+", " ", m.group(1))
        print("%04X %s%s" % (a, "  " if m.group(3) else "* ", ins + (m.group(3) or "")[:60]))
