#!/bin/sh
# lanza_truco.sh: UN openMSX con tools/omsx_truco.tcl sobre work/truco/rastan_4010.rom
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R && RA_OUT=work/truco timeout 600 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP -cart work/truco/rastan_4010.rom -romtype ASCII8 -script tools/omsx_truco.tcl > work/truco/log.txt 2>&1
echo hecho > work/truco/fin.txt
