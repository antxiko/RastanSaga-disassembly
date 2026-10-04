# omsx_huerfanas.tcl - Si se ejecutan (o se leen) los trozos que las notas dan
# por huerfanos. Lee RA_HUERFANAS ("banco ini fin nombre", de
# tools/huerfanas.py lista) y pone un watchpoint de lectura en cada rango: si
# el PC es la direccion leida, se ejecuta; si no, se lee como dato. Solo
# cuenta con el banco del rango puesto en su hueco. Escribe en RA_OUT/
# huerfanas_<RA_MODO>.txt "nombre pc" (ejecucion) o "R:nombre pc" (lectura)
# cada 5 s emulados.
#   RA_MODO=pantallas  el recorrido de las 257 pantallas (omsx_pantallas.tcl)
#   RA_MODO=jefes      90 s de demo; luego cada sala de jefe (2, 5, 8, 0x0B,
#                      0x0E y las cinco de la ronda 7) 15 s con el jefe vivo
#                      y Rastan sin perder vida (D910 bit 7), y su vida a 0
set ::visto [dict create]
set ::bloques ""
foreach n [debug list] { if {[string match "*romblocks*" $n] && ![string match "C-BIOS*" $n]} { set ::bloques $n } }
proc banco {a} { return [debug read $::bloques $a] }
proc pasa {b nombre} {
    set a $::wp_last_address
    if {[banco $a] != $b} return
    set pc [reg PC]
    set k [expr {$pc == $a ? "$nombre" : "R:$nombre"}]
    set k [format "%s %04X" $k $pc]
    if {![dict exists $::visto $k]} { dict set ::visto $k 1 }
}
set f [open $::env(RA_HUERFANAS) r]
while {[gets $f l] >= 0} {
    lassign $l b ini fin nombre
    debug set_watchpoint read_mem [list $ini $fin] {} [list pasa $b $nombre]
}
close $f
set ::estado ""
proc escribe {} {
    set f [open "$::env(RA_OUT)/huerfanas_$::env(RA_MODO).txt" w]
    foreach k [dict keys $::visto] { puts $f $k }
    close $f
    # y como va: fase, pantalla, tipo del actor 0 y la vida del jefe
    append ::estado [format "%.0f fase=%02X pant=%d,%d actor0=%02X vida=%04X D17D=%02X
"         [machine_info time] [debug read memory 0xD5E5] [debug read memory 0xD5F0]         [debug read memory 0xD5F1] [debug read memory 0xD933]         [expr {[debug read memory 0xD969] | ([debug read memory 0xD96A] << 8)}]         [debug read memory 0xD17D]]
    set g [open "$::env(RA_OUT)/estado_$::env(RA_MODO).txt" w]
    puts -nonewline $g $::estado
    close $g
    after time 5 escribe
}
after time 5 escribe

if {$::env(RA_MODO) eq "pantallas"} {
    source tools/omsx_pantallas.tcl
    proc vuelca {n} {}
} else {
    set throttle off
    proc espacio {} { keymatrixdown 8 0x01 ; after time 1.0 { keymatrixup 8 0x01 } }
    # a la fase f: D5E5 = f - 1 y D910 bit 0 (fase acabada, p00:5303),
    # reintentando cada 1,5 s hasta que D5E5 = f (como omsx_pantallas.tcl)
    proc a_fase {f {k 0}} {
        if {[debug read memory 0xD5E5] == $f || $k >= 8} return
        if {[debug read memory 0xD5E5] != [expr {($f - 1) & 0xFF}]} {
            debug write memory 0xD5E5 [expr {($f - 1) & 0xFF}]
        }
        debug write memory 0xD910 0x81
        after time 1.5 [list a_fase $f [expr {$k + 1}]]
    }
    # en la ronda 7, el jefe sale en una pantalla concreta (p04:8BF4)
    proc a_pantalla {c r} {
        debug write memory 0xD5F0 $c
        debug write memory 0xD5F1 $r
        debug write memory 0xD8FC 0x80
        debug write memory 0xD8FD 0x80
        debug write memory 0xD910 0x80
    }
    proc sin_perder {} { debug write memory 0xD910 [expr {([debug read memory 0xD910] | 0x80) & 0xFE}] }
    proc mata {} { debug write memory 0xD969 0 ; debug write memory 0xD96A 0 }
    after time 90 espacio
    set t 100
    foreach {fase c r} {2 -1 -1  5 -1 -1  8 -1 -1  11 -1 -1  14 -1 -1  18 5 0  19 4 0  20 5 0  21 5 1  22 3 0} {
        after time $t [list a_fase $fase]
        set t2 [expr {$t + 14}]
        if {$c >= 0} { after time $t2 [list a_pantalla $c $r] ; set t2 [expr {$t2 + 3}] }
        for {set k 0} {$k < 25} {incr k} { after time [expr {$t2 + $k}] sin_perder }
        after time [expr {$t2 + 25}] mata
        after time [expr {$t2 + 26}] mata
        set t [expr {$t2 + 40}]
    }
    after time [expr {$t + 5}] exit
}
