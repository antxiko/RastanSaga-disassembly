# omsx_vuelca.tcl - Volcados para cotejar: VRAM (128 KB), RAM 0xC000-0xFFFF,
# paleta y registros del VDP en los instantes de RA_T (segundos emulados).
# ESPACIO en los instantes de RA_ESPACIO (por defecto 8 y 12: titulo y
# partida). Cada volcado va a RA_OUT/tNNN.{vram,ram,pal,regs}.
#
#   RA_OUT=<dir> RA_T="20 25" openmsx -machine C-BIOS_MSX2_JP \
#       -cart rastan.rom -romtype ASCII8 -script este.tcl
set OUT $::env(RA_OUT)
file mkdir $OUT
set TS $::env(RA_T)
set ESP [expr {[info exists ::env(RA_ESPACIO)] ? $::env(RA_ESPACIO) : "8 12"}]
proc guarda {nom datos} {
    set f [open "$::OUT/$nom" wb]; puts -nonewline $f $datos; close $f
}
proc vuelca {t} {
    set n [format t%03d $t]
    guarda $n.vram [debug read_block VRAM 0 131072]
    guarda $n.ram [debug read_block memory 0xC000 0x4000]
    guarda $n.pal [debug read_block "VDP palette" 0 32]
    set r ""
    for {set i 0} {$i < 47} {incr i} { append r [format %c [debug read "VDP regs" $i]] }
    guarda $n.regs $r
}
# Rastan mira ESPACIO en el titulo una vez cada 30 cuadros (p00:50C8): 1 s
proc espacio {} { keymatrixdown 8 0x01 ; after time 1.0 { keymatrixup 8 0x01 } }
foreach t $ESP { after time $t espacio }
foreach t $TS { after time $t [list vuelca $t] }
after time [expr {[lindex [lsort -real $TS] end] + 1}] exit
