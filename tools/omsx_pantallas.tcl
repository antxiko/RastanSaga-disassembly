# omsx_pantallas.tcl - Recorre todas las pantallas para cotejarlas: ejecuta
# el plan de RA_PLAN (lo escribe plan_pantallas.py: en cada pantalla, la
# vecina en D5F0/D5F1 y Rastan fuera por el borde) y vuelca en RA_OUT/pNNN.*
# la pagina 0 de la VRAM, la RAM 0xC000-0xFFFF, la paleta y los registros.
# Sin freno: el tiempo es el emulado.
set OUT $::env(RA_OUT)
file mkdir $OUT
proc guarda {nom datos} {
    set f [open "$::OUT/$nom" wb]; puts -nonewline $f $datos; close $f
}
proc vuelca {n} {
    if {[string is integer $n]} { set n [format p%03d $n] }
    guarda $n.vram [debug read_block VRAM 0 32768]
    guarda $n.ram [debug read_block memory 0xC000 0x4000]
    guarda $n.pal [debug read_block "VDP palette" 0 32]
    set r ""
    for {set i 0} {$i < 47} {incr i} { append r [format %c [debug read "VDP regs" $i]] }
    guarda $n.regs $r
}
proc espacio {} { keymatrixdown 8 0x01 ; after time 1.0 { keymatrixup 8 0x01 } }
# a_fase f: hasta que D5E5 = f, D5E5 = f - 1 y D910 = 0x81 (fase acabada,
# p00:5303), comprobando cada 1,5 s; nueva_pantalla (p00:5430) borra el
# bit 0 si coincide con un cambio de pantalla.
proc a_fase {f {k 0}} {
    if {[debug read memory 0xD5E5] == $f || $k >= 6} return
    if {[debug read memory 0xD5E5] != [expr {($f - 1) & 0xFF}]} {
        debug write memory 0xD5E5 [expr {($f - 1) & 0xFF}]
    }
    debug write memory 0xD910 0x81
    after time 1.5 [list a_fase $f [expr {$k + 1}]]
}
# a_pant c r vc vr x y: la vecina (vc, vr) en D5F0/D5F1 y Rastan en (x, y)
# para que salga por el borde a (c, r); reintenta cada 1,5 s.
proc a_pant {c r vc vr x y {k 0}} {
    if {([debug read memory 0xD5F0] == $c && [debug read memory 0xD5F1] == $r) || $k >= 4} return
    debug write memory 0xD910 0x80
    debug write memory 0xD5F0 $vc
    debug write memory 0xD5F1 $vr
    debug write memory 0xD8FD $y
    debug write memory 0xD8FC $x
    after time 1.5 [list a_pant $c $r $vc $vr $x $y [expr {$k + 1}]]
}
# caza n c r vc vr x y: como a_pant, pero vigila la llegada cada 0,05 s y
# vuelca cinco veces en el primer segundo (pNNN_1..5): para las pantallas de
# paso, en las que Rastan cae enseguida a la de abajo.
proc caza {n c r vc vr x y} {
    debug write memory 0xD910 0x80
    debug write memory 0xD5F0 $vc
    debug write memory 0xD5F1 $vr
    debug write memory 0xD8FD $y
    debug write memory 0xD8FC $x
    after time 0.05 [list caza_espera $n $c $r 0]
}
proc caza_espera {n c r k} {
    if {[debug read memory 0xD5F0] == $c && [debug read memory 0xD5F1] == $r} {
        for {set i 1} {$i <= 5} {incr i} {
            after time [expr {0.2 * $i}] [list vuelca [format p%03d_%d $n $i]]
        }
        return
    }
    if {$k < 60} { after time 0.05 [list caza_espera $n $c $r [expr {$k + 1}]] }
}
# fase_forzada f n: un punto de parada en entra_en_fase (p00:52DF) pone
# D5E5 = f justo antes de leer la ficha, aunque el juego se la salte (la
# 0x11, p00:5318) o no se llegue jugando (la 0x17). Escribe D910 = 0x81
# cada 1,5 s hasta que salte, y vuelca a los 6 s de saltar.
proc fase_forzada {f n} {
    set ::bp_hecho 0
    set ::bp_fase [debug set_bp 0x52DF {} [list fija_fase $f $n]]
    empuja_fase 0
}
proc empuja_fase {k} {
    if {$::bp_hecho || $k >= 8} return
    debug write memory 0xD910 0x81
    after time 1.5 [list empuja_fase [expr {$k + 1}]]
}
proc fija_fase {f n} {
    debug write memory 0xD5E5 $f
    debug remove_bp $::bp_fase
    set ::bp_hecho 1
    after time 6 [list vuelca $n]
}
set throttle off
source $::env(RA_PLAN)
