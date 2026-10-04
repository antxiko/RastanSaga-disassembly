# omsx_lecturas.tcl - Que datos lee de verdad el cartucho. Engancha las
# rutinas que leen cada clase de datos y apunta, sin repetir, en
# RA_OUT/lecturas.txt:
#   M pc ranura banco  cada escritura en un registro del mapper (quien pone que banco)
#   P banco dir        patron de sprite copiado a la VRAM (p00:45BC, HL)
#   S banco dir        definicion de sprite animada (p00:5AA5, IX)
#   B banco dir        entrada de bloque leida (p00:47A2, IX)
#   T banco dir        byte de partitura leido como orden (p01:6259, HL)
#   V banco dir        paso de envolvente de volumen (p01:61A9, HL)
#   E banco dir        paso de envolvente de tono (p01:6205, HL)
#   X pc               ejecucion de p01:6478 / p01:647D
# y luego recorre todas las pantallas con el plan de omsx_pantallas.tcl (sin
# volcados). Escribe el fichero cada 5 s emulados.
set ::visto [dict create]
set ::bloques ""
foreach n [debug list] { if {[string match "*romblocks*" $n] && ![string match "C-BIOS*" $n]} { set ::bloques $n } }
proc banco {a} { return [debug read $::bloques $a] }
proc apunta {k} { if {![dict exists $::visto $k]} { dict set ::visto $k 1 } }
proc dir_de {hi lo} { return [expr {([reg $hi] << 8) | [reg $lo]}] }
proc lee_reg16 {r} { return [reg $r] }
proc en {letra dir} { apunta [format "%s %d %04X" $letra [banco $dir] $dir] }
proc mapper {} {
    apunta [format "M %04X %04X %d" [reg PC] [expr {$::wp_last_address & 0xF800}] $::wp_last_value]
}
debug set_watchpoint write_mem {0x6000 0x7FFF} {} mapper
debug set_bp 0x45BC {[banco 0x4000] == 0} { en P [reg HL] }
debug set_bp 0x5AA5 {[banco 0x4000] == 0} { en S [reg IX] }
debug set_bp 0x47A2 {[banco 0x4000] == 0} { en B [reg IX] }
debug set_bp 0x6259 {[banco 0x6000] == 1} { en T [reg HL] }
debug set_bp 0x61A9 {[banco 0x6000] == 1} { en V [reg HL] }
debug set_bp 0x6205 {[banco 0x6000] == 1} { en E [reg HL] }
debug set_bp 0x6478 {[banco 0x6000] == 1} { apunta "X 6478" }
debug set_bp 0x647D {[banco 0x6000] == 1} { apunta "X 647D" }
proc escribe {} {
    set f [open "$::env(RA_OUT)/lecturas.txt" w]
    foreach k [dict keys $::visto] { puts $f $k }
    close $f
    after time 5 escribe
}
after time 5 escribe
source tools/omsx_pantallas.tcl
proc vuelca {n} {}
