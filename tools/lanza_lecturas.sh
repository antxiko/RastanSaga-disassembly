#!/bin/sh
# lanza_lecturas.sh <dir>: UN openMSX con tools/omsx_lecturas.tcl y el plan de
# todas las pantallas; deja <dir>/lecturas.txt y <dir>/fin.txt.
R=$(cd "$(dirname "$0")/.." && pwd)
D=$R/$1
mkdir -p $D
cd $R && RA_OUT=$D RA_PLAN=work/g/plan_pantallas.tcl timeout 2400 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart rastan.rom -romtype ASCII8 -script tools/omsx_lecturas.tcl > $D/log.txt 2>&1
echo hecho > $D/fin.txt
