#!/bin/sh
# lanza_huerfanas.sh <modo>: UN openMSX con tools/omsx_huerfanas.tcl
# (modo pantallas o jefes); deja work/huerf/huerfanas_<modo>.txt.
R=$(cd "$(dirname "$0")/.." && pwd)
D=$R/work/huerf
mkdir -p $D
cd $R && python3 tools/huerfanas.py lista > /dev/null
cd $R && RA_OUT=$D RA_MODO=$1 RA_HUERFANAS=work/huerfanas.txt RA_PLAN=work/g/plan_pantallas.tcl timeout 2400 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart rastan.rom -romtype ASCII8 -script tools/omsx_huerfanas.tcl > $D/log_$1.txt 2>&1
echo hecho > $D/fin_$1.txt
