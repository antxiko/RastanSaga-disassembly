#!/bin/sh
# lanza_fases.sh <dir> <n> [desde] [paso]: UN openMSX con tools/omsx_fases.tcl (n pasos de
# fase); deja <dir>/fin.txt al acabar.
R=$(cd "$(dirname "$0")/.." && pwd)
D=$R/$1
mkdir -p $D
cd $R && RA_OUT=$D RA_N="$2" RA_DESDE="${3:-0}" RA_PASO="${4:-4}" timeout 900 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart rastan.rom -romtype ASCII8 -script tools/omsx_fases.tcl > $D/log.txt 2>&1
echo hecho > $D/fin.txt
