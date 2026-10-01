#!/bin/sh
# lanza_pantallas.sh <dir> <plan.tcl>: UN openMSX con tools/omsx_pantallas.tcl;
# deja <dir>/fin.txt al acabar.
R=$(cd "$(dirname "$0")/.." && pwd)
D=$R/$1
mkdir -p $D
cd $R && RA_OUT=$D RA_PLAN="$2" timeout 1800 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart rastan.rom -romtype ASCII8 -script tools/omsx_pantallas.tcl > $D/log.txt 2>&1
echo hecho > $D/fin.txt
