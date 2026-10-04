# omsx_truco.tcl - El interruptor de pruebas de la cabecera (0x4010): con una
# copia de la ROM con ese byte a 1, empieza la partida y pulsa 7, 7, 6 y BS,
# apuntando en RA_OUT/truco.txt la fase (D5E5) y D17D antes y despues de cada una.
set throttle off
set f [open "$::env(RA_OUT)/truco.txt" w]
proc apunta {que} {
    puts $::f [format "%s fase=%02X D17D=%02X" $que [debug read memory 0xD5E5] [debug read memory 0xD17D]]
    flush $::f
}
proc tecla {fila bit} { keymatrixdown $fila $bit ; after time 1.0 [list keymatrixup $fila $bit] }
after time 11 { tecla 8 0x01 }
after time 22 { apunta "al empezar" ; tecla 0 0x80 }
after time 30 { apunta "tras el 7" ; tecla 0 0x80 }
after time 38 { apunta "tras otro 7" ; tecla 0 0x40 }
after time 46 { apunta "tras el 6" ; tecla 7 0x20 }
after time 46.6 { apunta "0,6 s tras pulsar BS" }
after time 54 { apunta "8 s tras BS" }
after time 56 { close $::f ; exit }
