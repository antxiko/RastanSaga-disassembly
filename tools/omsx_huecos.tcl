# omsx_huecos.tcl - Apunta que direcciones de los huecos del trazado estatico
# EJECUTA de verdad el Z80 (PC == direccion leida) y con que bancos puestos.
# Lee los rangos de RA_HUECOS ("ini fin" en decimal por linea), escribe en
# RA_OUT "pc b4000 b6000 b8000 bA000" una vez por combinacion, y sale a los
# RA_SEGS segundos. RA_ESPACIO: instantes en que pulsar ESPACIO.
set OUT $::env(RA_OUT)
set SEGS [expr {[info exists ::env(RA_SEGS)] ? $::env(RA_SEGS) : 120}]
set ESP [expr {[info exists ::env(RA_ESPACIO)] ? $::env(RA_ESPACIO) : ""}]
set throttle off
set ::visto [dict create]
set ::bloques ""
foreach n [debug list] { if {[string match "*romblocks*" $n] && ![string match "C-BIOS*" $n]} { set ::bloques $n } }
proc banco {a} { return [debug read $::bloques $a] }
proc pasa {} {
    set a $::wp_last_address
    if {[reg PC] != $a} return
    set k "$a [banco 0x4000] [banco 0x6000] [banco 0x8000] [banco 0xA000]"
    if {![dict exists $::visto $k]} { dict set ::visto $k 1 }
}
set f [open $::env(RA_HUECOS) r]
while {[gets $f l] >= 0} {
    if {[llength $l] == 2} { debug set_watchpoint read_mem [list [lindex $l 0] [lindex $l 1]] {} pasa }
}
close $f
proc espacio {} { keymatrixdown 8 0x01 ; after time 0.3 { keymatrixup 8 0x01 } }
foreach t $ESP { after time $t espacio }
# RA_BOT=<segundo>: desde ese instante, cada 0.25 s, una combinacion al azar de
# la fila 8 (espacio, izquierda, arriba, abajo, derecha), con la derecha mas
# probable para que avance.
proc bot {} {
    keymatrixup 8 0xF1
    set m 0
    if {rand() < 0.6} { set m [expr {$m | 0x80}] }
    if {rand() < 0.15} { set m [expr {$m | 0x10}] }
    if {rand() < 0.3} { set m [expr {$m | 0x20}] }
    if {rand() < 0.15} { set m [expr {$m | 0x40}] }
    if {rand() < 0.4} { set m [expr {$m | 0x01}] }
    keymatrixdown 8 $m
    after time 0.25 bot
}
if {[info exists ::env(RA_BOT)] && $::env(RA_BOT) ne ""} { after time $::env(RA_BOT) bot }
# una foto cada 20 s, para saber por donde iba
proc foto {} { screenshot -raw [format "%s_%04d.png" $::OUT [expr {int([machine_info time])}]] ; after time 20 foto }
after time 20 foto
proc fin {} {
    set f [open $::OUT w]
    puts $f "# debuggables: [debug list]"
    puts $f "# romblocks: $::bloques"
    foreach k [dict keys $::visto] { puts $f $k }
    close $f
    exit
}
after time $SEGS fin
