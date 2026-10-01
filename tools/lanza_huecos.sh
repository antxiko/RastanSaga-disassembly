#!/bin/sh
# lanza_huecos.sh <salida> <segundos> ["instantes de ESPACIO"] [segundo del bot]: UN openMSX con
# tools/omsx_huecos.tcl sobre los rangos de work/huecos_cpu.txt.
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R && RA_OUT=$R/$1 RA_SEGS=$2 RA_ESPACIO="$3" RA_BOT=$4 RA_HUECOS=$R/work/huecos_cpu.txt \
  timeout 1800 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP \
  -cart rastan.rom -romtype ASCII8 -script tools/omsx_huecos.tcl > $R/$1.log 2>&1
echo hecho >> $R/$1.log
