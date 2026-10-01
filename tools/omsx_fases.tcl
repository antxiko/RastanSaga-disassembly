# omsx_fases.tcl - Recorre las fases para cotejar sus primeras pantallas.
# ESPACIO a los 11 s (titulo); desde RA_T0 cada RA_PASO segundos pone
# D910 = 0x81 (bit 0: fase acabada, p00:5303; bit 7: no pierde vida) y
# RA_PASO - 1 s despues vuelca VRAM, RAM, paleta y registros en
# RA_OUT/fNN.*, con NN = numero de volcado. RA_DESDE: fase del primer salto.
#
#   RA_OUT=<dir> RA_N=23 openmsx -machine C-BIOS_MSX2_JP \
#       -cart rastan.rom -romtype ASCII8 -script este.tcl
set OUT $::env(RA_OUT)
file mkdir $OUT
set N $::env(RA_N)
set T0 [expr {[info exists ::env(RA_T0)] ? $::env(RA_T0) : 16}]
set PASO [expr {[info exists ::env(RA_PASO)] ? $::env(RA_PASO) : 4}]
proc guarda {nom datos} {
    set f [open "$::OUT/$nom" wb]; puts -nonewline $f $datos; close $f
}
proc vuelca {n} {
    set n [format f%02d $n]
    guarda $n.vram [debug read_block VRAM 0 131072]
    guarda $n.ram [debug read_block memory 0xC000 0x4000]
    guarda $n.pal [debug read_block "VDP palette" 0 32]
    set r ""
    for {set i 0} {$i < 47} {incr i} { append r [format %c [debug read "VDP regs" $i]] }
    guarda $n.regs $r
}
proc espacio {} { keymatrixdown 8 0x01 ; after time 1.0 { keymatrixup 8 0x01 } }
proc acaba {} { debug write memory 0xD910 0x81 }
# RA_DESDE: antes del primer salto, D5E5 (la fase) = RA_DESDE - 1
set DESDE [expr {[info exists ::env(RA_DESDE)] ? $::env(RA_DESDE) : 0}]
if {$DESDE > 0} {
    after time [expr {$T0 - 0.5}] [list debug write memory 0xD5E5 [expr {$DESDE - 1}]]
}
after time 11 espacio
after time [expr {$T0 - 1}] [list vuelca 0]
for {set i 1} {$i <= $N} {incr i} {
    after time [expr {$T0 + ($i - 1) * $PASO}] acaba
    after time [expr {$T0 + $i * $PASO - 1}] [list vuelca $i]
}
after time [expr {$T0 + $N * $PASO + 1}] exit
