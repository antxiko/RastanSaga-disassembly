#!/bin/sh
# lanza_vuelca.sh <dir> "<instantes>" ["<espacios>"]: UN openMSX con
# tools/omsx_vuelca.tcl; deja <dir>/fin.txt al acabar.
R=$(cd "$(dirname "$0")/.." && pwd)
D=$R/$1
mkdir -p $D
cd $R && RA_OUT=$D RA_T="$2" RA_ESPACIO="${3:-8 12}" timeout 600 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart rastan.rom -romtype ASCII8 -script tools/omsx_vuelca.tcl > $D/log.txt 2>&1
echo hecho > $D/fin.txt
