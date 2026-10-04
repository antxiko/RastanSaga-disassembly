# omsx_sprites.tcl - Recorre todas las pantallas con el plan de
# omsx_pantallas.tcl y en cada volcado guarda en RA_OUT/pNNN.* la zona de
# sprites de la VRAM (0x8000-0xBFFF: colores 0x8400, atributos 0x8600,
# patrones 0xA000), la RAM 0xC000-0xFFFF, la paleta y los registros. Es el
# material de tools/graficos/coteja_figuras.py.
source tools/omsx_pantallas.tcl
proc vuelca {n} {
    if {[string is integer $n]} { set n [format p%03d $n] }
    for {set k 0} {$k < 4} {incr k} {
        after time [expr {0.25 * $k}] [list vuelca_uno $n.$k]
    }
}
proc vuelca_uno {n} {
    guarda $n.spr [debug read_block VRAM 0x8000 0x4000]
    guarda $n.ram [debug read_block memory 0xC000 0x4000]
    guarda $n.pal [debug read_block "VDP palette" 0 32]
    set r ""
    for {set i 0} {$i < 47} {incr i} { append r [format %c [debug read "VDP regs" $i]] }
    guarda $n.regs $r
}
