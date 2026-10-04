# Hallazgos

## La fase del dragón que se salta

La fase 0x11 tiene su ficha, su paleta y su pantalla: un dragón alado sobre
el mar, con 130 tiles que no usa ninguna otra. `p00:5318` la salta: de la
0x10 se pasa a la 0x12. Montada desde la ROM.

![La fase 0x11](../imagenes/dragon_fase.png)

![La cabeza del dragón](../imagenes/dragon_cabeza.png)

La cabeza del dragón: bloques 0x60-0x77 de la tabla de la fase 0x11, que su
mapa no usa.

## Un truco de pruebas en la cabecera

El byte 0x4010 vale 0. Puesto a 1, la tecla 7 pasa a la fase siguiente, la 6
a la anterior y BS acaba la partida (`p00:5321`, `p00:5349`); en la
presentación, 4 y 5 cambian la página de VRAM que se ve (`p00:4E41`). Medido
en openMSX con una copia de la ROM con ese byte a 1.

## Un trono sin colocar

95 tiles del banco 0x19 forman un hombre sentado en un trono. No hay tabla
que los coloque ni rutina localizada que los pinte. La colocación es la de la
lámina de The Cutting Room Floor, cotejada tile a tile.

![El trono](../imagenes/trono.png)

## Un final sin pintar

El bárbaro mirando al horizonte, con los bloques 0x2A-0x57 de la tabla del
título. La tabla se corta en 0x6000, al final del banco 0, y las dos últimas
filas de tiles se quedan fuera de ella. Ninguna rutina localizada lo pinta, y
sus bloques no se leen en el recorrido de las 257 pantallas. La paleta no está
en la ROM: es la de The Cutting Room Floor.

![El final](../imagenes/final.png)

## La ronda 6 no tiene jefe

Las rondas salen de la fase (`p00:566C`: fase / 3 + 1). A la 6 le tocan la
0x0F, la 0x10 y la 0x11, y la 0x11 es la que se salta: dos fases y ninguna
sala de jefe. La 0x11 ocupa el sitio de esa sala y, como las cinco salas de
jefe, es de una sola pantalla. Leído en el código.

## El último byte de cada 16 KB

Los tiles se copian a la VRAM de 16 KB en 16 KB con LDIRVM de 0x3FFF bytes
(`p01:6077`): el último byte de cada trozo se queda a 0. Cotejado contra la
VRAM de openMSX.

## Los créditos, tal cual

CONGRATURATIONS, CHARACTOR y SPETIAL THANKS: el texto del final se guarda así
en `p04:8D6D`.

## Puntos que no se dan

La tabla de puntos de los jefes tiene seis palabras (`p07:9709`), pero
`p07:96DD` solo deja pasar los tipos 1 a 5: la sexta, 3000, no se lee.

## Código que no se ejecuta

61 rutinas y trozos de código no tienen llamada ni salto localizado: dos que
encienden y apagan el sonido (`p01:6478`), un fundido de la paleta
(`p00:449B`), una copia HMMC (`p00:4332`), cajas de choque, otra versión del
jefe 5 (`p04:8A9A`)... Ninguno se ejecuta en lo medido (ver
[En el emulador](EN-EL-EMULADOR.md)). En el listado van con su código y esa
frase, no como "sin uso".

Gracias a [The Cutting Room Floor](https://tcrf.net/) por las
láminas del trono y del final.
