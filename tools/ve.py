#!/usr/bin/env python3
"""Desensambla a ojo un trozo de un banco: ve.py <banco> <org> <desde> <hasta>"""
import subprocess
import sys

b, org, a, z = int(sys.argv[1]), int(sys.argv[2], 16), int(sys.argv[3], 16), int(sys.argv[4], 16)
d = open("rastan.rom", "rb").read()[b * 0x2000:(b + 1) * 0x2000]
open("work/_ve.bin", "wb").write(d[a - org:z - org])
out = subprocess.run(["z80dasm", "-a", "-t", "-g", hex(a), "work/_ve.bin"],
                     capture_output=True, text=True).stdout
for ln in out.splitlines()[3:]:
    print(ln.replace("\t\t", "\t")[:72])
