; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 06 (en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; Etiquetas que no caen en ninguna posicion emitida del listado
; (destinos fuera del binario o dentro de una instruccion).
; ----------------------------------------------------------------------
L_6998:	equ 0x06998
L_699B:	equ 0x0699b
L_699E:	equ 0x0699e
L_69A1:	equ 0x069a1
L_69A4:	equ 0x069a4
L_69A7:	equ 0x069a7

; ======================================================================
; CODIGO 0x6000..0x60be  (190 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; RASTAN, el jugador: lo que la tarea 2 (p00:56F2) hace cada cuadro. Si esta
; muriendo (D90F bit 7) solo cuenta y al final avisa; si no, p06:68A7, la
; animacion, la barra de vida y la puntuacion.
; ----------------------------------------------------------------------
jugador:
	ld a,(0d90fh)		;6000   ; D90F bit 7: muerto
	bit 7,a		;6003
	jp nz,jugador_muerto		;6005
	call mueve_jugador		;6008   ; p06:68A7
	ld a,(0d904h)		;600b   ; la pose y el juego de poses de este cuadro...
	ld (0d8f4h),a		;600e   ; la pose de Rastan para la animacion = a
	ld a,(0d905h)		;6011   ; ...a D8F4/D8F5, los que lee la animacion
	ld (0d8f5h),a		;6014   ; copia de D905 para la animacion y los iconos = a
	ld a,(0d8fch)		;6017   ; a = la x de Rastan
	ld (0d5ddh),a		;601a   ; lo que se suma a la x de los sprites = a
	ld a,(0d8fdh)		;601d   ; a = la y de Rastan
	ld (0d5deh),a		;6020   ; lo que se suma a la y de los sprites = a
	ld hl,0d904h		;6023   ; D904 bit 6: si esta puesto...
	bit 6,(hl)		;6026
	jp z,L_602D		;6028
	res 5,(hl)		;602b   ; ...se borra el bit 5
L_602D:
	call anima_jugador		;602d   ; la animacion de Rastan
	call barra_de_vida		;6030   ; la barra de vida
	call puntuacion		;6033   ; la puntuacion, si ha cambiado
	ld a,080h		;6036   ; D188 = 0x80: la cuenta de la muerte, lista
	ld hl,0d188h		;6038   ; hl -> cuadros que le quedan a la muerte de Rastan
	ld (hl),a			;603b
	ret			;603c
jugador_muerto:
	ld a,(0d8fch)		;603d   ; a = la x de Rastan
	ld (0d5ddh),a		;6040   ; lo que se suma a la x de los sprites = a
	ld a,(0d8fdh)		;6043   ; a = la y de Rastan
	ld (0d5deh),a		;6046   ; lo que se suma a la y de los sprites = a
	ld a,(0d188h)		;6049   ; D188 bit 1: cada dos cuadros...
	bit 1,a		;604c
	jr z,L_6055		;604e
	call anima_jugador		;6050   ; ...se anima...
	jr cuenta_muerte		;6053
L_6055:
	ld ix,0d413h		;6055   ; ...y al otro se borran sus 11 fichas: parpadea
	ld b,00bh		;6059
	call 04823h		;605b   ; p00 vacia_fichas_sprite
cuenta_muerte:
	ld hl,0d188h		;605e   ; D188 - 1...
	dec (hl)			;6061
	ld a,(hl)			;6062
	or a			;6063
	ret nz			;6064   ; ...y al llegar a 0...
	ld hl,0d17dh		;6065   ; ...aviso a la tarea 0 (D17D bit 6)
	set 6,(hl)		;6068
	ret			;606a

; ----------------------------------------------------------------------
; La barra de vida, solo si ha cambiado: en (0x50, 0x14)-(.., 0x1A), una
; linea de color 7 de D91C/2 pixeles y el resto, hasta D91D/2, de color 6.
; ----------------------------------------------------------------------
barra_de_vida:
	ld a,(0d925h)		;606b   ; la vida pintada (D925)...
	ld b,a			;606e
	ld a,(0d91ch)		;606f   ; ...contra la de ahora (D91C)
	cp b			;6072
	ret z			;6073
	ld (0d925h),a		;6074   ; apuntada
	ld a,(0d91ch)		;6077   ; a = la vida de Rastan
	srl a		;607a   ; vida / 2...
	ld h,a			;607c   ; ...pixeles: HL = (0x50 + vida/2, 0x1A)
	ld l,000h		;607d
	ld de,0501ah		;607f
	add hl,de			;6082
	ld de,05014h		;6083   ; DE = (0x50, 0x14)
	ex de,hl			;6086
	push de			;6087
	and a			;6088   ; sin vida: no hay parte llena
	jp z,L_6091		;6089
	ld a,077h		;608c   ; color 7 en los dos pixeles del byte
	call 0440eh		;608e   ; rellena
L_6091:
	ld a,(0d91ch)		;6091   ; lo que falta hasta la vida maxima (D91D)
	srl a		;6094
	ld b,a			;6096
	ld a,(0d91dh)		;6097   ; a = el largo total de la barra
	srl a		;609a
	sub b			;609c
	and a			;609d   ; nada: la barra esta llena
	jp z,L_60B1		;609e
	ld h,a			;60a1   ; la parte vacia...
	ld l,000h		;60a2
	pop de			;60a4
	ld e,01ah		;60a5
	add hl,de			;60a7
	ld e,014h		;60a8
	ld a,066h		;60aa   ; ...de color 6
	ex de,hl			;60ac
	call 0440eh		;60ad   ; rellena
	ret			;60b0
L_60B1:
	pop de			;60b1
	ret			;60b2
huerfana_puntuacion_0:
	exx			;60b3   ; nadie la llama: escribe la puntuacion a 0 en (0x00, 0x18)...
	ld b,000h		;60b4
	exx			;60b6
	ld d,018h		;60b7
	ld e,000h		;60b9
	call 04612h		;60bb   ; p00 escribe_texto

; ----------------------------------------------------------------------
; DATOS texto_cero_2: seis espacios y "0"
;   0x60be..0x60c6  (8 bytes)
DATA_texto_cero_2:
	defb 020h,020h,020h,020h,020h,020h,030h,000h	; 60be        0.

; ======================================================================
; CODIGO 0x60c6..0x6397  (721 bytes)
; ======================================================================


	call lee_puntuacion		;60c6   ; ...y luego la de verdad
	ld l,000h		;60c9
	ld h,018h		;60cb
	ld (0d5dbh),hl		;60cd   ; la lista o la cadena que se esta pintando = hl
	call escribe_puntuacion		;60d0
	ret			;60d3
puntuacion:
	call lee_puntuacion		;60d4   ; la puntuacion y su marca de cambio
	bit 7,b		;60d7   ; bit 7 de D921: ha cambiado?
	ret z			;60d9
	res 7,(ix+02dh)		;60da   ; se borra la marca
	ld l,000h		;60de   ; en (0x00, 0x18)
	ld h,018h		;60e0
	ld (0d5dbh),hl		;60e2   ; la lista o la cadena que se esta pintando = hl
	call escribe_puntuacion		;60e5   ; seis cifras
	ret			;60e8
lee_puntuacion:
	ld ix,0d8f4h		;60e9   ; IX = D8F4: +2A/2B/2C = D91E/D91F/D920, tres bytes BCD
	ld e,(ix+02ah)		;60ed   ; E = las dos cifras de abajo
	ld d,(ix+02bh)		;60f0   ; D = las dos de en medio
	ld c,(ix+02ch)		;60f3   ; C = las dos de arriba
	ld b,(ix+02dh)		;60f6   ; B = D921, la marca
	ret			;60f9
escribe_puntuacion:
	ld h,000h		;60fa   ; H = 0: aun no ha salido ninguna cifra distinta de 0
	ld a,c			;60fc   ; cifra 1 (la de arriba)
	rra			;60fd
	rra			;60fe
	rra			;60ff
	rra			;6100
	push bc			;6101
	call escribe_cifra		;6102
	pop bc			;6105
	ld a,c			;6106   ; cifra 2
	call escribe_cifra		;6107
	ld a,d			;610a   ; cifra 3
	rra			;610b
	rra			;610c
	rra			;610d
	rra			;610e
	call escribe_cifra		;610f
	ld a,d			;6112   ; cifra 4
	call escribe_cifra		;6113
	ld a,e			;6116   ; cifra 5
	rra			;6117
	rra			;6118
	rra			;6119
	rra			;611a
	call escribe_cifra		;611b
	ld a,e			;611e   ; cifra 6 (cae en la rutina)
escribe_cifra:
	and 00fh		;611f   ; la cifra de abajo de A
	jr nz,L_6127		;6121   ; un 0...
	dec h			;6123   ; ...sin ninguna cifra antes: sale un espacio
	inc h			;6124
	jr z,L_612A		;6125
L_6127:
	add a,010h		;6127   ; 0x10 + cifra...
	inc h			;6129   ; (ya ha salido una)
L_612A:
	add a,020h		;612a   ; ...+ 0x20: el codigo ASCII ('0' + cifra, o espacio)
	push hl			;612c
	push de			;612d
	call 04633h		;612e   ; escribe la letra
	pop de			;6131
	pop hl			;6132
	ret			;6133

; ----------------------------------------------------------------------
; Anima a Rastan con tres capas de sprites: la primera en la ficha 2 (tabla
; p06:639F), la segunda en la ficha 6 (tabla p06:64B3) y la tercera en la
; ficha 0 (una de las cuatro tablas de p06:6397, segun D8F5). Las definiciones estan en
; el banco 26 (0x8000). Si la pose (D8F4) o el juego (D8F5) cambian, la
; animacion empieza de cero.
; ----------------------------------------------------------------------
anima_jugador:
	ld a,(0d8f5h)		;6134   ; el juego de poses...
	ld b,a			;6137
	ld a,(0d8f8h)		;6138   ; ...ha cambiado?
	cp b			;613b
	jp nz,juego_nuevo		;613c
	ld a,(0d8f7h)		;613f   ; la pose...
	ld b,a			;6142
	ld a,(0d8f4h)		;6143   ; ...ha cambiado?
	cp b			;6146
	jp z,capa_1		;6147   ; nada nuevo: se sigue
	jp pose_nueva		;614a   ; pose nueva
juego_nuevo:
	ld a,(0d8f5h)		;614d   ; apuntado
	ld (0d8f8h),a		;6150   ; D8F5 del cuadro anterior = a
	call iconos_marcador		;6153   ; p06:6302
pose_nueva:
	ld a,(0d8f4h)		;6156   ; apuntada
	ld (0d8f7h),a		;6159   ; la pose del cuadro anterior = a
	ld a,0feh		;615c   ; las dos animaciones (D8FE y D900) desde el principio
	ld (0d8feh),a		;615e   ; estado de la animacion de la capa 1 = a
	ld (0d900h),a		;6161   ; estado de la animacion de la capa 2 = a
	ld a,001h		;6164
	ld (0d8ffh),a		;6166
	ld (0d901h),a		;6169
capa_1:
	ld a,(0d8f4h)		;616c   ; pose & 0x7F...
	and 07fh		;616f
	ld d,000h		;6171
	ld e,a			;6173
	push de			;6174
	pop hl			;6175
	add hl,hl			;6176   ; ...* 3 + p06:639F
	add hl,de			;6177
	ld de,0639fh		;6178
	add hl,de			;617b
	ld e,(hl)			;617c   ; la definicion
	inc hl			;617d
	ld d,(hl)			;617e
	inc hl			;617f
	ex af,af'			;6180   ; el tercer byte, guardado para la capa 3
	ld a,(hl)			;6181
	push af			;6182
	ex af,af'			;6183
	push de			;6184
	pop ix		;6185
	ld hl,0d429h		;6187   ; a la ficha 2
	ld iy,0d8feh		;618a   ; estado de la animacion: D8FE
	ld a,01ah		;618e   ; banco 26 en 0x8000
	ld (0d191h),a		;6190   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;6193   ; registro del mapper: banco A en 0x8000
	call 05aa5h		;6196   ; un paso
	ex af,af'			;6199   ; A' bit 0: la animacion ha dado la vuelta...
	ld b,a			;619a
	ex af,af'			;619b
	bit 0,b		;619c
	jr z,capa_2		;619e
	ld hl,0d904h		;61a0   ; ...y se borra D904 bit 5
	res 5,(hl)		;61a3
capa_2:
	ld a,(0d8f4h)		;61a5   ; pose * 3 + p06:64B3
	and 07fh		;61a8
	ld d,000h		;61aa
	ld e,a			;61ac
	push de			;61ad
	pop hl			;61ae
	add hl,hl			;61af
	add hl,de			;61b0
	ld de,064b3h		;61b1
	add hl,de			;61b4
	ld e,(hl)			;61b5   ; la definicion
	inc hl			;61b6
	ld d,(hl)			;61b7
	inc hl			;61b8
	ex af,af'			;61b9   ; A' = el tercer byte
	ld a,(hl)			;61ba
	ex af,af'			;61bb
	push de			;61bc
	pop ix		;61bd
	ld hl,0d455h		;61bf   ; a la ficha 6
	ld iy,0d900h		;61c2   ; estado: D900
	ld a,01ah		;61c6   ; banco 26
	ld (0d191h),a		;61c8   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;61cb   ; registro del mapper: banco A en 0x8000
	call 05aa5h		;61ce   ; un paso
	ld a,(0d8f5h)		;61d1   ; la tercera capa: D8F5 & 3...
	and 003h		;61d4
	ld l,a			;61d6
	ld h,000h		;61d7
	add hl,hl			;61d9   ; ...elige una de las cuatro tablas de p06:6397...
	ld de,06397h		;61da
	add hl,de			;61dd
	ld e,(hl)			;61de
	inc hl			;61df
	ld d,(hl)			;61e0
	ld a,(0d8f4h)		;61e1   ; ...y la pose, la definicion
	and 07fh		;61e4
	ld h,000h		;61e6
	ld l,a			;61e8
	add hl,hl			;61e9
	add hl,de			;61ea
	ld e,(hl)			;61eb
	inc hl			;61ec
	ld d,(hl)			;61ed
	push de			;61ee
	pop ix		;61ef
	ex af,af'			;61f1   ; A' = el tercer byte de la capa 1
	pop af			;61f2
	ex af,af'			;61f3
	ld hl,0d413h		;61f4   ; a la ficha 0
	ld iy,0d8feh		;61f7   ; con el estado de la capa 1 (D8FE)
	ld a,01ah		;61fb   ; banco 26
	ld (0d191h),a		;61fd   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;6200   ; registro del mapper: banco A en 0x8000
	call 05b95h		;6203   ; sin avanzar: el mismo cuadro que la capa 1
	ret			;6206

; ----------------------------------------------------------------------
; Repinta los cuatro bloques de fondo (2x2) que tapa el actor IX en su
; posicion de salida (+10 x, +11 y), sacandolos de D5F4.
; ----------------------------------------------------------------------
repinta_fondo_actor:
	push ix		;6207
	ld a,(ix+010h)		;6209   ; x
	ld e,a			;620c
	ld a,(ix+011h)		;620d   ; y - 0x20 (la parte de arriba es el marcador)
	sub 020h		;6210
	ld d,a			;6212
	ld a,e			;6213   ; x / 16 + (y - 0x20): la casilla
	srl a		;6214
	srl a		;6216
	srl a		;6218
	srl a		;621a
	or d			;621c
	ld l,a			;621d
	ld h,000h		;621e
	add hl,hl			;6220   ; * 2: palabra
	push hl			;6221
	ld de,0d5f4h		;6222   ; el bloque de arriba a la izquierda
	add hl,de			;6225
	ld e,(hl)			;6226
	inc hl			;6227
	ld d,(hl)			;6228
	ex de,hl			;6229
	ld a,(ix+010h)		;622a   ; en (x, y)
	ld e,a			;622d
	ld a,(ix+011h)		;622e
	ld d,a			;6231
	exx			;6232   ; opaco
	ld b,000h		;6233
	exx			;6235
	push ix		;6236
	call 04777h		;6238   ; pintado
	pop ix		;623b
	pop hl			;623d
	push hl			;623e
	ld de,0d5f6h		;623f   ; arriba a la derecha (la palabra siguiente)
	add hl,de			;6242
	ld e,(hl)			;6243
	inc hl			;6244
	ld d,(hl)			;6245
	ex de,hl			;6246
	ld a,(ix+010h)		;6247   ; en (x + 16, y)
	add a,010h		;624a
	ld e,a			;624c
	ld a,(ix+011h)		;624d
	ld d,a			;6250
	exx			;6251
	ld b,000h		;6252
	exx			;6254
	push ix		;6255
	call 04777h		;6257   ; pintado
	pop ix		;625a
	pop hl			;625c
	push hl			;625d
	ld de,0d614h		;625e   ; abajo a la izquierda (una fila = 0x20 bytes mas)
	add hl,de			;6261
	ld e,(hl)			;6262
	inc hl			;6263
	ld d,(hl)			;6264
	ex de,hl			;6265
	ld a,(ix+010h)		;6266   ; en (x, y + 16)
	ld e,a			;6269
	ld a,(ix+011h)		;626a
	add a,010h		;626d
	ld d,a			;626f
	exx			;6270
	ld b,000h		;6271
	exx			;6273
	push ix		;6274
	call 04777h		;6276   ; pintado
	pop ix		;6279
	pop hl			;627b
	ld de,0d616h		;627c   ; abajo a la derecha
	add hl,de			;627f
	ld e,(hl)			;6280
	inc hl			;6281
	ld d,(hl)			;6282
	ex de,hl			;6283
	ld a,(ix+010h)		;6284   ; en (x + 16, y + 16)
	add a,010h		;6287
	ld e,a			;6289
	ld a,(ix+011h)		;628a
	add a,010h		;628d
	ld d,a			;628f
	exx			;6290
	ld b,000h		;6291
	exx			;6293
	push ix		;6294
	call 04777h		;6296   ; pintado
	pop ix		;6299
	pop ix		;629b
	ret			;629d
repinta_fondo_especial:
	ld a,(0d92bh)		;629e   ; lo mismo en la posicion del bloque especial
	ld e,a			;62a1
	ld a,(0d92ch)		;62a2   ; a = y del bloque especial
	sub 020h		;62a5
	ld d,a			;62a7
	ld a,e			;62a8   ; x / 16...
	srl a		;62a9
	srl a		;62ab
	srl a		;62ad
	srl a		;62af
	or d			;62b1   ; ...+ (y - 0x20): la casilla
	ld l,a			;62b2
	ld h,000h		;62b3
	add hl,hl			;62b5
	ld de,0d5f4h		;62b6   ; el bloque de fondo de esa casilla
	add hl,de			;62b9
	ld e,(hl)			;62ba
	inc hl			;62bb
	ld d,(hl)			;62bc
	ex de,hl			;62bd
	ld a,(0d92bh)		;62be   ; a = x del bloque especial de la pantalla
	ld e,a			;62c1
	ld a,(0d92ch)		;62c2   ; a = y del bloque especial
	ld d,a			;62c5
	exx			;62c6   ; opaco
	ld b,000h		;62c7
	exx			;62c9
	call 04777h		;62ca   ; pintado
	ld a,(0d92bh)		;62cd   ; y lo de delante en la misma casilla
	ld e,a			;62d0
	ld a,(0d92ch)		;62d1   ; a = y del bloque especial
	sub 020h		;62d4
	ld d,a			;62d6
	ld a,e			;62d7
	srl a		;62d8
	srl a		;62da
	srl a		;62dc
	srl a		;62de
	or d			;62e0
	ld l,a			;62e1
	ld h,000h		;62e2
	add hl,hl			;62e4
	ld de,0d774h		;62e5   ; en D774
	add hl,de			;62e8
	ld e,(hl)			;62e9
	inc hl			;62ea
	ld d,000h		;62eb
	ex de,hl			;62ed
	ld a,l			;62ee   ; 0xFF: no hay nada delante
	cp 0ffh		;62ef
	ret z			;62f1
	ld a,(0d92bh)		;62f2   ; a = x del bloque especial de la pantalla
	ld e,a			;62f5
	ld a,(0d92ch)		;62f6   ; a = y del bloque especial
	ld d,a			;62f9
	exx			;62fa
	ld b,001h		;62fb   ; transparente
	exx			;62fd
	call 04777h		;62fe   ; pintado
	ret			;6301

; ----------------------------------------------------------------------
; Los cinco iconos del marcador, en (0xB0..0xF0, 0x10), segun lo que lleva
; Rastan (D8F5). Son bloques de la tabla de p00:5BC3; el 0x13 es el hueco.
; ----------------------------------------------------------------------
iconos_marcador:
	push ix		;6302
	ld a,(0d8f5h)		;6304   ; bits 0-1...
	and 003h		;6307
	jp nz,L_6312		;6309
	ld hl,00013h		;630c   ; ...a 0: hueco
	jp L_6317		;630f
L_6312:
	add a,019h		;6312   ; ...si no, bloque 0x19 + bits
	ld l,a			;6314
	ld h,000h		;6315
L_6317:
	ld de,010b0h		;6317   ; en (0xB0, 0x10)
	call pinta_icono		;631a
	ld a,(0d8f5h)		;631d   ; bits 2-3: hueco o 0x16 + bits
	and 00ch		;6320
	srl a		;6322
	srl a		;6324
	jp nz,L_632F		;6326
	ld hl,00013h		;6329
	jp L_6334		;632c
L_632F:
	add a,016h		;632f
	ld l,a			;6331
	ld h,000h		;6332
L_6334:
	ld de,010c0h		;6334   ; en (0xC0, 0x10)
	call pinta_icono		;6337
	ld a,(0d8f5h)		;633a   ; bit 5: hueco o 0x16
	bit 5,a		;633d
	ld hl,00013h		;633f
	jp z,L_6348		;6342
	ld hl,00016h		;6345
L_6348:
	ld de,010d0h		;6348   ; en (0xD0, 0x10)
	call pinta_icono		;634b
	ld a,(0d8f5h)		;634e   ; bit 6: hueco o 0x15
	bit 6,a		;6351
	ld hl,00013h		;6353
	jp z,L_635C		;6356
	ld hl,00015h		;6359
L_635C:
	ld de,010e0h		;635c   ; en (0xE0, 0x10)
	call pinta_icono		;635f
	ld a,(0d8f5h)		;6362   ; bit 7: hueco o 0x14
	bit 7,a		;6365
	ld hl,00013h		;6367
	jp z,L_6370		;636a
	ld hl,00014h		;636d
L_6370:
	ld de,010f0h		;6370   ; en (0xF0, 0x10)
	call pinta_icono		;6373
	pop ix		;6376
	ret			;6378
pinta_icono:
	push de			;6379
	push hl			;637a
	ld hl,(0d5eah)		;637b   ; guarda la tabla de bloques de la fase...
	ld (0d5ech),hl		;637e   ; la tabla de bloques guardada = hl
	ld hl,05bc3h		;6381   ; ...y pone la de p00:5BC3
	ld (0d5eah),hl		;6384   ; la tabla de bloques de 16x16 de la fase = hl
	pop hl			;6387
	pop de			;6388
	exx			;6389   ; opaco
	ld b,000h		;638a
	exx			;638c
	call 04777h		;638d   ; pinta el bloque HL en DE
	ld hl,(0d5ech)		;6390   ; devuelve la tabla de la fase
	ld (0d5eah),hl		;6393   ; la tabla de bloques de 16x16 de la fase = hl
	ret			;6396

; ----------------------------------------------------------------------
; DATOS poses_capa3: Las cuatro tablas de la capa 3, una por valor de D8F5 & 3
;   (p06:61D1)
;   0x6397..0x639f  (8 bytes)
DATA_poses_capa3:
	defw 065c7h,0667fh,06737h,067efh	; 6397  -> DATA_poses_capa3_0 DATA_poses_capa3_1 DATA_poses_capa3_2 DATA_poses_capa3_3

; ----------------------------------------------------------------------
; DATOS poses_capa1: Capa 1: por cada pose (92), la definicion de animacion
;   (banco 26) y un byte para la capa 3
;   0x639f..0x64b3  (276 bytes)
DATA_poses_capa1:
	defb 0e6h,08ch,002h	; 639f
	defb 0d5h,08ch,002h	; 63a2
	defb 0e6h,08ch,002h	; 63a5
	defb 0d5h,08ch,002h	; 63a8
	defb 02ah,08fh,002h	; 63ab
	defb 025h,08fh,002h	; 63ae
	defb 039h,08ch,002h	; 63b1
	defb 042h,08ch,002h	; 63b4
	defb 0e6h,08ch,002h	; 63b7
	defb 0d5h,08ch,002h	; 63ba
	defb 039h,08ch,002h	; 63bd
	defb 042h,08ch,002h	; 63c0
	defb 0e6h,08ch,002h	; 63c3
	defb 0d5h,08ch,002h	; 63c6
	defb 0e6h,08ch,002h	; 63c9
	defb 0d5h,08ch,002h	; 63cc
	defb 047h,08fh,000h	; 63cf
	defb 050h,08fh,000h	; 63d2
	defb 047h,08fh,000h	; 63d5
	defb 050h,08fh,000h	; 63d8
	defb 02ah,08fh,002h	; 63db
	defb 025h,08fh,002h	; 63de
	defb 047h,08fh,000h	; 63e1
	defb 050h,08fh,000h	; 63e4
	defb 047h,08fh,000h	; 63e7
	defb 050h,08fh,000h	; 63ea
	defb 0d1h,095h,002h	; 63ed
	defb 0c8h,095h,002h	; 63f0
	defb 000h,000h,000h	; 63f3
	defb 000h,000h,000h	; 63f6
	defb 000h,000h,000h	; 63f9
	defb 000h,000h,000h	; 63fc
	defb 0e6h,08ch,000h	; 63ff
	defb 0d5h,08ch,000h	; 6402
	defb 0e6h,08ch,000h	; 6405
	defb 0d5h,08ch,000h	; 6408
	defb 084h,08eh,000h	; 640b
	defb 073h,08eh,000h	; 640e
	defb 080h,08dh,000h	; 6411
	defb 06fh,08dh,000h	; 6414
	defb 0e6h,08ch,000h	; 6417
	defb 0d5h,08ch,000h	; 641a
	defb 080h,08dh,000h	; 641d
	defb 06fh,08dh,000h	; 6420
	defb 0e6h,08ch,000h	; 6423
	defb 0d5h,08ch,000h	; 6426
	defb 0e6h,08ch,000h	; 6429
	defb 0d5h,08ch,000h	; 642c
	defb 047h,08fh,000h	; 642f
	defb 050h,08fh,000h	; 6432
	defb 047h,08fh,000h	; 6435
	defb 050h,08fh,000h	; 6438
	defb 02ah,08fh,002h	; 643b
	defb 025h,08fh,002h	; 643e
	defb 047h,08fh,000h	; 6441
	defb 050h,08fh,000h	; 6444
	defb 047h,08fh,000h	; 6447
	defb 050h,08fh,000h	; 644a
	defb 0d1h,095h,002h	; 644d
	defb 0c8h,095h,002h	; 6450
	defb 000h,000h,000h	; 6453
	defb 000h,000h,000h	; 6456
	defb 000h,000h,000h	; 6459
	defb 000h,000h,000h	; 645c
	defb 0fbh,08fh,002h	; 645f
	defb 000h,090h,002h	; 6462
	defb 0fbh,08fh,002h	; 6465
	defb 000h,090h,002h	; 6468
	defb 0fbh,08fh,002h	; 646b
	defb 000h,090h,002h	; 646e
	defb 057h,090h,002h	; 6471
	defb 05ch,090h,002h	; 6474
	defb 0a7h,090h,002h	; 6477
	defb 0ach,090h,002h	; 647a
	defb 057h,090h,002h	; 647d
	defb 05ch,090h,002h	; 6480
	defb 0fch,090h,002h	; 6483
	defb 0fch,090h,002h	; 6486
	defb 0fch,090h,002h	; 6489
	defb 0fch,090h,002h	; 648c
	defb 0fbh,08fh,002h	; 648f
	defb 000h,090h,002h	; 6492
	defb 0ach,090h,002h	; 6495
	defb 0a7h,090h,002h	; 6498
	defb 0ach,090h,002h	; 649b
	defb 0a7h,090h,002h	; 649e
	defb 0f7h,090h,002h	; 64a1
	defb 0fch,090h,002h	; 64a4
	defb 0f7h,090h,002h	; 64a7
	defb 0fch,090h,002h	; 64aa
	defb 0fbh,08fh,002h	; 64ad
	defb 000h,090h,002h	; 64b0

; ----------------------------------------------------------------------
; DATOS poses_capa2: Capa 2: por cada pose, la definicion de animacion y un
;   byte
;   0x64b3..0x65c7  (276 bytes)
DATA_poses_capa2:
	defb 014h,08eh,002h	; 64b3
	defb 009h,08eh,002h	; 64b6
	defb 014h,08eh,000h	; 64b9
	defb 009h,08eh,000h	; 64bc
	defb 084h,08eh,002h	; 64bf
	defb 073h,08eh,002h	; 64c2
	defb 093h,08ch,002h	; 64c5
	defb 09ch,08ch,002h	; 64c8
	defb 0cdh,08fh,002h	; 64cb
	defb 0d2h,08fh,002h	; 64ce
	defb 093h,08ch,002h	; 64d1
	defb 09ch,08ch,002h	; 64d4
	defb 0a3h,091h,002h	; 64d7
	defb 0a8h,091h,002h	; 64da
	defb 07ah,091h,002h	; 64dd
	defb 075h,091h,002h	; 64e0
	defb 014h,08eh,002h	; 64e3
	defb 009h,08eh,002h	; 64e6
	defb 0cdh,08fh,002h	; 64e9
	defb 0d2h,08fh,002h	; 64ec
	defb 094h,08fh,002h	; 64ef
	defb 07dh,08fh,002h	; 64f2
	defb 0a3h,091h,002h	; 64f5
	defb 0a8h,091h,002h	; 64f8
	defb 07ah,091h,002h	; 64fb
	defb 075h,091h,002h	; 64fe
	defb 00dh,096h,002h	; 6501
	defb 004h,096h,002h	; 6504
	defb 000h,000h,000h	; 6507
	defb 000h,000h,000h	; 650a
	defb 000h,000h,000h	; 650d
	defb 000h,000h,000h	; 6510
	defb 014h,08eh,002h	; 6513
	defb 009h,08eh,002h	; 6516
	defb 014h,08eh,000h	; 6519
	defb 009h,08eh,000h	; 651c
	defb 02ah,08fh,000h	; 651f
	defb 025h,08fh,000h	; 6522
	defb 093h,08ch,002h	; 6525
	defb 09ch,08ch,002h	; 6528
	defb 0cdh,08fh,002h	; 652b
	defb 0d2h,08fh,002h	; 652e
	defb 093h,08ch,002h	; 6531
	defb 09ch,08ch,002h	; 6534
	defb 0a3h,091h,002h	; 6537
	defb 0a8h,091h,002h	; 653a
	defb 07ah,091h,002h	; 653d
	defb 075h,091h,002h	; 6540
	defb 014h,08eh,002h	; 6543
	defb 009h,08eh,002h	; 6546
	defb 0cdh,08fh,002h	; 6549
	defb 0d2h,08fh,002h	; 654c
	defb 094h,08fh,000h	; 654f
	defb 07dh,08fh,000h	; 6552
	defb 0a3h,091h,002h	; 6555
	defb 0a8h,091h,002h	; 6558
	defb 07ah,091h,002h	; 655b
	defb 075h,091h,002h	; 655e
	defb 00dh,096h,002h	; 6561
	defb 004h,096h,002h	; 6564
	defb 000h,000h,000h	; 6567
	defb 000h,000h,000h	; 656a
	defb 000h,000h,000h	; 656d
	defb 000h,000h,000h	; 6570
	defb 029h,090h,002h	; 6573
	defb 02eh,090h,002h	; 6576
	defb 029h,090h,002h	; 6579
	defb 02eh,090h,002h	; 657c
	defb 029h,090h,002h	; 657f
	defb 02eh,090h,002h	; 6582
	defb 079h,090h,002h	; 6585
	defb 07eh,090h,002h	; 6588
	defb 0dah,090h,002h	; 658b
	defb 0d5h,090h,002h	; 658e
	defb 079h,090h,002h	; 6591
	defb 07eh,090h,002h	; 6594
	defb 025h,091h,002h	; 6597
	defb 02ah,091h,002h	; 659a
	defb 053h,091h,002h	; 659d
	defb 058h,091h,002h	; 65a0
	defb 029h,090h,002h	; 65a3
	defb 02eh,090h,002h	; 65a6
	defb 0dah,090h,002h	; 65a9
	defb 0d5h,090h,002h	; 65ac
	defb 0dah,090h,002h	; 65af
	defb 0d5h,090h,002h	; 65b2
	defb 025h,091h,002h	; 65b5
	defb 025h,091h,002h	; 65b8
	defb 053h,091h,002h	; 65bb
	defb 053h,091h,002h	; 65be
	defb 029h,090h,002h	; 65c1
	defb 02eh,090h,002h	; 65c4

; ----------------------------------------------------------------------
; DATOS poses_capa3_0: Capa 3 con D8F5 & 3 = 0: una definicion por pose
;   0x65c7..0x667f  (184 bytes)
DATA_poses_capa3_0:
	defw 091d6h,091c5h,091d6h,091c5h,091f8h,091e7h,09594h,09594h	; 65c7
	defw 091d6h,091c5h,09594h,09594h,091d6h,091c5h,091d6h,091c5h	; 65d7
	defw 0923eh,09235h,0923eh,09235h,09230h,0922bh,0923eh,09235h	; 65e7
	defw 0923eh,09235h,09594h,09594h,00000h,00000h,00000h,00000h	; 65f7
	defw 091d6h,091c5h,091d6h,091c5h,091f8h,091e7h,0921ah,09209h	; 6607
	defw 091d6h,091c5h,0921ah,09209h,091d6h,091c5h,091d6h,091c5h	; 6617
	defw 0923eh,09235h,0923eh,09235h,09230h,0922bh,0923eh,09235h	; 6627
	defw 0923eh,09235h,09594h,09594h,00000h,00000h,00000h,00000h	; 6637
	defw 09696h,09691h,09696h,09691h,09696h,09691h,09594h,09594h	; 6647
	defw 091d6h,091c5h,09594h,09594h,09696h,09691h,09696h,09691h	; 6657
	defw 09696h,09691h,0923eh,09235h,09696h,09691h,09696h,09691h	; 6667
	defw 09696h,09691h,09594h,09594h	; 6677

; ----------------------------------------------------------------------
; DATOS poses_capa3_1: Capa 3 con D8F5 & 3 = 1
;   0x667f..0x6737  (184 bytes)
DATA_poses_capa3_1:
	defw 09315h,09304h,09315h,09304h,09337h,09326h,09594h,09594h	; 667f
	defw 09315h,09304h,09594h,09594h,09315h,09304h,09315h,09304h	; 668f
	defw 0935bh,09352h,0935bh,09352h,0934dh,09348h,0935bh,09352h	; 669f
	defw 0935bh,09352h,09594h,09594h,00000h,00000h,00000h,00000h	; 66af
	defw 09315h,09304h,09315h,09304h,09337h,09326h,09375h,09364h	; 66bf
	defw 09315h,09304h,09375h,09364h,09315h,09304h,09315h,09304h	; 66cf
	defw 0935bh,09352h,0935bh,09352h,0934dh,09348h,0935bh,09352h	; 66df
	defw 0935bh,09352h,09594h,09594h,00000h,00000h,00000h,00000h	; 66ef
	defw 0967eh,09679h,0967eh,09679h,0967eh,09679h,09594h,09594h	; 66ff
	defw 09315h,09304h,09594h,09594h,0967eh,09679h,0967eh,09679h	; 670f
	defw 0967eh,09679h,09315h,09304h,0967eh,09679h,0967eh,09679h	; 671f
	defw 0967eh,09679h,09594h,09594h	; 672f

; ----------------------------------------------------------------------
; DATOS poses_capa3_2: Capa 3 con D8F5 & 3 = 2
;   0x6737..0x67ef  (184 bytes)
DATA_poses_capa3_2:
	defw 09454h,09443h,09454h,09443h,09476h,09465h,09594h,09594h	; 6737
	defw 09454h,09443h,09594h,09594h,09454h,09443h,09454h,09443h	; 6747
	defw 09490h,09487h,09490h,09487h,0949eh,09499h,09490h,09487h	; 6757
	defw 09490h,09487h,09594h,09594h,00000h,00000h,00000h,00000h	; 6767
	defw 09454h,09443h,09454h,09443h,09476h,09465h,094b4h,094a3h	; 6777
	defw 09454h,09443h,094b4h,094a3h,09454h,09443h,09454h,09443h	; 6787
	defw 09490h,09487h,09490h,09487h,0949eh,09499h,09490h,09487h	; 6797
	defw 09490h,09487h,09594h,09594h,00000h,00000h,00000h,00000h	; 67a7
	defw 09666h,09661h,09666h,09661h,09666h,09661h,09594h,09594h	; 67b7
	defw 09454h,09443h,09594h,09594h,09666h,09661h,09666h,09661h	; 67c7
	defw 09666h,09661h,09454h,09443h,09666h,09661h,09666h,09661h	; 67d7
	defw 09666h,09661h,09594h,09594h	; 67e7

; ----------------------------------------------------------------------
; DATOS poses_capa3_3: Capa 3 con D8F5 & 3 = 3
;   0x67ef..0x68a7  (184 bytes)
DATA_poses_capa3_3:
	defw 08b0bh,08afah,08b0bh,08afah,08b2dh,08b1ch,09594h,09594h	; 67ef
	defw 08b0bh,08afah,09594h,09594h,08b0bh,08afah,08b0bh,08afah	; 67ff
	defw 08b73h,08b6ah,08b73h,08b6ah,08b65h,08b60h,08b73h,08b6ah	; 680f
	defw 08b73h,08b6ah,09594h,09594h,00000h,00000h,00000h,00000h	; 681f
	defw 08b0bh,08afah,08b0bh,08afah,08b2dh,08b1ch,08b4fh,08b3eh	; 682f
	defw 08b0bh,08afah,08b4fh,08b3eh,08b0bh,08afah,08b0bh,08afah	; 683f
	defw 08b73h,08b6ah,08b73h,08b6ah,08b65h,08b60h,08b73h,08b6ah	; 684f
	defw 08b73h,08b6ah,09594h,09594h,00000h,00000h,00000h,00000h	; 685f
	defw 096aeh,096a9h,096aeh,096a9h,096aeh,096a9h,09594h,09594h	; 686f
	defw 08b0bh,08afah,09594h,09594h,096aeh,096a9h,096aeh,096a9h	; 687f
	defw 096aeh,096a9h,08b0bh,08afah,08b0bh,08afah,096aeh,096a9h	; 688f
	defw 096aeh,096a9h,09594h,09594h	; 689f

; ======================================================================
; CODIGO 0x68a7..0x740a  (2915 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El jugador, cada cuadro: cuentas de tiempo de lo que lleva, los mandos,
; sus choques con los actores y los efectos de sonido de lo que le pase.
; ----------------------------------------------------------------------
mueve_jugador:
	ld a,(0d90fh)		;68a7   ; muerto: nada
	bit 7,a		;68aa
	jp nz,nada		;68ac
	push af			;68af
	call lee_mandos_jugador		;68b0   ; p06:6A1F
	pop af			;68b3
	bit 4,a		;68b4   ; D90F bit 4: un rato sin mandos
	jr nz,sin_mandos		;68b6
	ld hl,0d910h		;68b8   ; D910 bit 1: cuenta D913...
	bit 1,(hl)		;68bb
	jr z,cuenta_segundos		;68bd
	ld a,(0d913h)		;68bf   ; a = cuenta del estado del jugador
	dec a			;68c2
	ld (0d913h),a		;68c3   ; cuenta del estado del jugador = a
	jr nz,cuenta_segundos		;68c6
	res 1,(hl)		;68c8   ; ...y al acabar se borra
sin_mandos:
	ld c,a			;68ca
	ld a,(0d913h)		;68cb   ; D913 - 1
	dec a			;68ce
	ld (0d913h),a		;68cf   ; cuenta del estado del jugador = a
	jr z,L_68E0		;68d2   ; a 0: se acaba (p06:68E0)
	cp 03ch		;68d4   ; por debajo de 0x3C se borra el bit 6...
	jr nc,mandos_a_cero		;68d6
	res 6,c		;68d8
	ld a,c			;68da
	ld (0d90fh),a		;68db   ; bit 7 muerto, bit 4 un rato sin mandos = a
	jr cuenta_segundos		;68de
L_68E0:
	res 4,c		;68e0   ; a 0: se borra el bit 4
	ld a,c			;68e2
	ld (0d90fh),a		;68e3   ; bit 7 muerto, bit 4 un rato sin mandos = a
	jr cuenta_segundos		;68e6
mandos_a_cero:
	xor a			;68e8   ; mientras D913 >= 0x3C, como si no tocara nada
	ld (0d573h),a		;68e9   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
cuenta_segundos:
	ld hl,0d927h		;68ec   ; un cuadro mas...
	inc (hl)			;68ef
	ld a,(hl)			;68f0
	cp 03ch		;68f1   ; ...60 cuadros: un segundo
	jr c,mira_actores		;68f3
	ld (hl),000h		;68f5
	ld hl,0d91ah		;68f7   ; al arma le queda un segundo menos...
	ld a,(hl)			;68fa
	or a			;68fb
	jr z,L_6912		;68fc
	dec (hl)			;68fe
	jr nz,L_6912		;68ff
	ld a,(0d905h)		;6901   ; ...y si se acaba: D905 sin los bits 0-1...
	and 0fch		;6904
	ld (0d905h),a		;6906   ; lo que lleva Rastan: bits 0-1, 2-3, 5, 6, 7 = a
	xor a			;6909   ; ...ni arma...
	ld (0d919h),a		;690a   ; el arma que lleva = a
	ld hl,0d905h		;690d   ; ...ni el bit 7
	res 7,(hl)		;6910
L_6912:
	ld hl,0d92ah		;6912   ; D92A: otra cuenta, la del bit 5 de D905
	ld a,(hl)			;6915
	or a			;6916
	jr z,mira_actores		;6917
	dec (hl)			;6919
	jr nz,mira_actores		;691a
	ld hl,0d905h		;691c   ; hl -> lo que lleva Rastan: bits 0-1, 2-3, 5, 6, 7
	res 5,(hl)		;691f
mira_actores:
	xor a			;6921   ; los sucesos de este cuadro, a cero
	ld (0d928h),a		;6922   ; sucesos del jugador en este cuadro: cada bit, un efecto = a
	ld (0d929h),a		;6925
	ld b,003h		;6928   ; los 3 actores de D934 (byte +1)...
	ld de,00026h		;692a
	ld ix,0d934h		;692d   ; ix -> actor 0, byte +1
L_6931:
	ld a,(ix+000h)		;6931   ; ...de tipo 0x16...
	cp 016h		;6934
	jr nz,L_693C		;6936
	res 7,(ix+025h)		;6938   ; ...pierden el bit 7 de +25
L_693C:
	add ix,de		;693c   ; el siguiente, 38 bytes mas alla
	djnz L_6931		;693e
	call botones		;6940   ; los botones (p06:69AF)
	call movimiento		;6943   ; p06:6A37
	call 08104h		;6946   ; p07:8104
	call elige_pose		;6949   ; p06:7A26
	call ataque		;694c   ; p06:7B22
	ld hl,0d904h		;694f   ; D904 bit 6...
	bit 6,(hl)		;6952
	jr z,efecto_de_sucesos		;6954
	res 5,(hl)		;6956   ; ...borra D904 bit 5 y D90F bit 0
	ld hl,0d90fh		;6958   ; hl -> bit 7 muerto, bit 4 un rato sin mandos
	res 0,(hl)		;695b
	ld hl,0d929h		;695d   ; D929 bit 7
	bit 7,(hl)		;6960
	jp z,recorta_mandos		;6962
	ld a,005h		;6965   ; efecto 5, o 0x11 si tambien el bit 5
	bit 5,(hl)		;6967
	jr z,pide_efecto		;6969
	ld a,011h		;696b
	jr pide_efecto		;696d
efecto_de_sucesos:
	ld a,(0d928h)		;696f   ; el bit mas importante de D928 decide el efecto:
	bit 7,a		;6972   ; bit 7 -> 1
	jr nz,efectos		;6974
	bit 6,a		;6976   ; bit 6 -> 2 (los `jr` caen dentro de los `ld bc` de abajo)
	jr nz,$+32		;6978
	bit 3,a		;697a   ; bit 3 -> 6
	jr nz,$+31		;697c
	bit 2,a		;697e   ; bit 2 -> 7
	jr nz,$+30		;6980
	bit 5,a		;6982   ; bit 5 -> 0x0C
	jr nz,$+29		;6984
	bit 4,a		;6986   ; bit 4 -> 3
	jr nz,$+28		;6988
	bit 1,a		;698a   ; bit 1 -> 4
	jr nz,$+27		;698c
	bit 0,a		;698e   ; bit 0 -> 0x10; ninguno: sin efecto
	ret z			;6990
	ld a,010h		;6991
	jr pide_efecto		;6993
efectos:
	ld a,001h		;6995   ; cada `ld bc,0xNN3E` esconde un `ld a,NN`: se entra a mitad
	ld bc,0023eh		;6997
	ld bc,0063eh		;699a
	ld bc,0073eh		;699d
	ld bc,00c3eh		;69a0
	ld bc,0033eh		;69a3
	ld bc,0043eh		;69a6
pide_efecto:
	ld a,a			;69a9   ; (un `ld a,a` que no hace nada)
	ld (0d178h),a		;69aa   ; pide el efecto
	ret			;69ad
nada:
	ret			;69ae

; ----------------------------------------------------------------------
; Los botones. Boton 1 (bit 4 de los mandos): si la accion anterior ya ha
; acabado, suceso del bit 4 (y del 5 con el arma 3).
; ----------------------------------------------------------------------
botones:
	ld a,(0d573h)		;69af   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld b,a			;69b2   ; B = los mandos
	ld a,(0d90fh)		;69b3   ; D90F bit 0: ocupado (p06:6A0A)
	bit 0,a		;69b6
	jp nz,accion_ocupado		;69b8
	bit 4,b		;69bb   ; boton 1?
	jp z,sin_boton_1		;69bd
	ld hl,0d90fh		;69c0   ; D90F bit 5
	set 5,(hl)		;69c3
	ld hl,0d904h		;69c5   ; D904 bit 5: la animacion aun no ha acabado
	bit 5,(hl)		;69c8
	jr nz,fin_botones		;69ca
	ld a,(hl)			;69cc   ; pose 0x14 (bits 1-4): no se puede
	and 01eh		;69cd
	cp 014h		;69cf
	jr z,fin_botones		;69d1
	exx			;69d3
	ld hl,0d928h		;69d4   ; suceso del bit 4 (efecto 3)
	set 4,(hl)		;69d7
	ld a,(0d919h)		;69d9   ; con el arma 3...
	cp 003h		;69dc
	jr nz,L_69E2		;69de
	set 5,(hl)		;69e0   ; ...otro suceso (bit 5)
L_69E2:
	exx			;69e2
	ld hl,0d958h		;69e3   ; los 3 actores: se borra el bit 7 de su +25
	ld de,00026h		;69e6
	ld b,003h		;69e9
L_69EB:
	res 7,(hl)		;69eb
	add hl,de			;69ed
	djnz L_69EB		;69ee
	jr fin_botones		;69f0
sin_boton_1:
	ld hl,0d904h		;69f2   ; D904 bit 5: la animacion sigue...
	bit 5,(hl)		;69f5
	ld hl,0d90fh		;69f7   ; hl -> bit 7 muerto, bit 4 un rato sin mandos
	jr nz,sigue_la_accion		;69fa
	res 5,(hl)		;69fc   ; ...no: D90F bit 5 a 0
	ret			;69fe
sigue_la_accion:
	set 5,(hl)		;69ff   ; D90F bit 5 a 1...
	ld a,(0d573h)		;6a01   ; ...y sin izquierda ni derecha mientras dura
	and 0f3h		;6a04
	ld (0d573h),a		;6a06   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
fin_botones:
	ret			;6a09
accion_ocupado:
	ld hl,0d90fh		;6a0a   ; D90F bit 5 y D904 bit 5 a 1
	set 5,(hl)		;6a0d
	ld hl,0d904h		;6a0f   ; hl -> la pose de Rastan
	set 5,(hl)		;6a12
	ld a,(0d573h)		;6a14   ; mandos: fuera arriba, se fuerza abajo (bit 1)
	and 0fch		;6a17
	or 002h		;6a19
	ld (0d573h),a		;6a1b   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6a1e
lee_mandos_jugador:
	call 042bah		;6a1f   ; los mandos de verdad
	ld a,(0d17dh)		;6a22   ; en la demo (D17D bit 7)...
	bit 7,a		;6a25
	ret z			;6a27
	ld a,(0d181h)		;6a28   ; ...los mandos son inventados: D181 bit 0 -> boton 1...
	add a,a			;6a2b
	add a,a			;6a2c
	add a,a			;6a2d
	add a,a			;6a2e
	and 010h		;6a2f
	or 008h		;6a31   ; ...y siempre a la derecha
	ld (0d573h),a		;6a33   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6a36

; ----------------------------------------------------------------------
; El movimiento de Rastan: HL = (x, y) se va cambiando y al final se
; coloca (p06:7878). Va por estados: D90F bit 3 (agarrado a un actor),
; D90D bit 7, 5 y 4, y el resto (de pie).
; ----------------------------------------------------------------------
movimiento:
	xor a			;6a37   ; D8FA y D8FB a 0
	ld (0d8fah),a		;6a38
	ld (0d8fbh),a		;6a3b
	ld a,(0d8fch)		;6a3e   ; H = x
	ld h,a			;6a41
	ld a,(0d8fdh)		;6a42   ; L = y
	ld l,a			;6a45
	ld a,(0d904h)		;6a46   ; B = la pose
	ld b,a			;6a49
	ld a,(0d573h)		;6a4a   ; C = los mandos
	ld c,a			;6a4d
	ld a,(0d90eh)		;6a4e   ; D90E bit 6: el boton 2 hay que soltarlo antes de volver a usarlo
	bit 6,a		;6a51
	jr z,segun_estado		;6a53
	bit 5,c		;6a55   ; suelto: se borra la marca
	jr nz,boton_2_sigue		;6a57
	res 6,a		;6a59
	ld (0d90eh),a		;6a5b
	jr segun_estado		;6a5e
boton_2_sigue:
	res 5,c		;6a60   ; aun pulsado: no cuenta
	ld a,c			;6a62
	ld (0d573h),a		;6a63   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
segun_estado:
	ld a,(0d90fh)		;6a66   ; D90F bit 3: agarrado (p06:6B1B)
	bit 3,a		;6a69
	jp nz,agarrado		;6a6b
	ld a,(0d90dh)		;6a6e   ; D90D bit 7: p06:71E0
	bit 7,a		;6a71
	jp nz,en_el_aire		;6a73
	bit 5,a		;6a76   ; D90D bit 5: p06:6D1E
	jp nz,trepa		;6a78
	bit 4,a		;6a7b   ; D90D bit 4: en una cuesta, resbala solo
	jr z,de_pie		;6a7d
	bit 2,a		;6a7f   ; bit 2: hacia la izquierda
	jr nz,resbala_izquierda		;6a81
	ld d,002h		;6a83   ; hacia la derecha: medio pixel por cuadro (D906 + 0x80)...
	ld a,(0d906h)		;6a85
	add a,080h		;6a88
	ld (0d906h),a		;6a8a
	jr nc,tras_resbalar		;6a8d
	ld a,h			;6a8f   ; ...sin pasar de x = 0xF0
	cp 0f0h		;6a90
	jr nc,tras_resbalar		;6a92
	inc h			;6a94
	jp tras_resbalar		;6a95
resbala_izquierda:
	ld d,008h		;6a98   ; medio pixel a la izquierda...
	ld a,(0d906h)		;6a9a
	sub 080h		;6a9d
	ld (0d906h),a		;6a9f
	jr nc,tras_resbalar		;6aa2
	ld a,h			;6aa4   ; ...sin pasar de 0
	or a			;6aa5
	jr z,tras_resbalar		;6aa6
	dec h			;6aa8
tras_resbalar:
	ld a,(0d573h)		;6aa9   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6aac
	bit 5,c		;6aad   ; boton 2: p06:7175
	jp nz,salta		;6aaf
	jp mira_delante		;6ab2   ; si no, p06:6E64
de_pie:
	ld a,(0d573h)		;6ab5   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6ab8
	bit 5,b		;6ab9   ; pose con el bit 5: p06:6AD6
	jr nz,recorta_mandos		;6abb
	bit 5,c		;6abd   ; boton 2: p06:7175
	jp nz,salta		;6abf
	ld a,(0d90fh)		;6ac2   ; D90F bit 5 (accion del boton 1): p06:6AF2
	bit 5,a		;6ac5
	jr nz,solo_arriba_abajo		;6ac7
	bit 1,c		;6ac9   ; abajo: p06:7886
	jp nz,orienta		;6acb
	bit 2,a		;6ace   ; D90F bit 2: p06:6B0A
	jp nz,paso_lateral		;6ad0
	jp anda		;6ad3   ; si no, p06:6E25
recorta_mandos:
	ld a,b			;6ad6   ; segun la pose (bits 1-4) solo valen algunos mandos:
	and 01eh		;6ad7
	cp 004h		;6ad9   ; pose 4: solo abajo
	jr z,solo_abajo		;6adb
	cp 010h		;6add   ; poses 0x10, 0x18 y 0x1A: solo arriba
	jr z,solo_arriba		;6adf
	cp 014h		;6ae1   ; pose 0x14: arriba y abajo
	jr z,solo_arriba_abajo		;6ae3
	cp 018h		;6ae5
	jr z,solo_arriba		;6ae7
	cp 01ah		;6ae9
	jr z,solo_arriba		;6aeb
	xor a			;6aed   ; las demas: ninguno
	ld (0d573h),a		;6aee   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6af1
solo_arriba_abajo:
	ld a,(0d573h)		;6af2   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 003h		;6af5
	ld (0d573h),a		;6af7   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6afa
solo_arriba:
	ld a,(0d573h)		;6afb   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 001h		;6afe
	ld (0d573h),a		;6b00   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6b03
solo_abajo:
	ld a,002h		;6b04
	ld (0d573h),a		;6b06   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6b09
paso_lateral:
	bit 3,c		;6b0a   ; derecha?
	jr nz,paso_derecha		;6b0c
	bit 2,c		;6b0e   ; izquierda: x - 1
	ret z			;6b10
	dec h			;6b11
	jr coloca		;6b12
paso_derecha:
	bit 2,c		;6b14   ; las dos a la vez: nada
	ret nz			;6b16
	inc h			;6b17   ; x + 1
coloca:
	jp coloca_jugador		;6b18

; ----------------------------------------------------------------------
; Agarrado a un actor (D914): mientras no pulse el boton 2, su x sale de
; una tabla del banco 7 segun el giro del actor (+2, 0-19) y la distancia en
; y entre los dos; hay una tabla por clase de actor (+1 = 0, 1, 2, 3).
; ----------------------------------------------------------------------
agarrado:
	bit 5,c		;6b1b   ; boton 2: se suelta (p06:6CF6)
	jp nz,se_suelta		;6b1d
	ld a,(0d90fh)		;6b20   ; D90F bit 1 a 0
	res 1,a		;6b23
	ld (0d90fh),a		;6b25   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld ix,(0d914h)		;6b28   ; IX = el actor
	ld a,(ix+002h)		;6b2c   ; su giro (+2)
	and 07fh		;6b2f
	ld e,a			;6b31
	ld a,(0d916h)		;6b32   ; igual que el de antes: nada que hacer
	cp e			;6b35
	ret z			;6b36
	ld a,e			;6b37
	ld (0d916h),a		;6b38   ; apuntado en D916
	ld a,(0d917h)		;6b3b   ; L = y de agarre (D917)
	ld l,a			;6b3e
	ld a,(ix+001h)		;6b3f   ; la clase del actor: 0, 1, 2 o 3
	cp 002h		;6b42
	jp z,clase_2		;6b44
	jp nc,clase_3		;6b47
	cp 001h		;6b4a
	jp z,clase_1		;6b4c
	ld a,e			;6b4f   ; giros 10-19 son los 0-9 al reves
	cp 00ah		;6b50
	jr c,clase_0		;6b52
	sub 00ah		;6b54
	neg		;6b56
	add a,008h		;6b58
	ld e,a			;6b5a
clase_0:
	cp 001h		;6b5b   ; segun el giro, la y se corrige un poco...
	jr c,clase_0_bajo		;6b5d
	jr z,clase_0_alto		;6b5f
	cp 008h		;6b61
	jr c,clase_0_x		;6b63
	jr z,clase_0_alto		;6b65
	cp 00ah		;6b67
	jr c,clase_0_bajo		;6b69
clase_0_alto:
	ld a,l			;6b6b   ; ...si esta muy por debajo del actor, un pixel arriba
	sub (ix+007h)		;6b6c
	cp 02fh		;6b6f
	jr c,clase_0_x		;6b71
	dec l			;6b73
	jr clase_0_x		;6b74
clase_0_bajo:
	ld a,l			;6b76
	sub (ix+007h)		;6b77
	cp 01fh		;6b7a
	jr c,clase_0_x		;6b7c
	dec l			;6b7e
clase_0_x:
	ld a,l			;6b7f   ; B = distancia en y
	sub (ix+007h)		;6b80
	ld b,a			;6b83
	ld a,e			;6b84   ; giro * 20 * 2...
	add a,a			;6b85
	add a,a			;6b86
	add a,e			;6b87
	add a,a			;6b88
	add a,a			;6b89
	push hl			;6b8a
	ld l,a			;6b8b
	ld h,000h		;6b8c
	add hl,hl			;6b8e
	ld de,08d2ch		;6b8f   ; ...en la tabla p07:8D2C (40 bytes por giro)
	add hl,de			;6b92
	ld e,b			;6b93   ; + distancia / 2
	srl e		;6b94
	ld d,000h		;6b96
	add hl,de			;6b98
	ld a,(hl)			;6b99   ; la x relativa + la x del actor - 16
	add a,(ix+006h)		;6b9a
	sub 010h		;6b9d
	pop hl			;6b9f
	ld h,a			;6ba0
	jp coloca_jugador		;6ba1
clase_1:
	ld a,e			;6ba4   ; lo mismo con la tabla p07:8EBC (32 bytes por giro)
	cp 00ah		;6ba5
	jr c,L_6BB0		;6ba7
	sub 00ah		;6ba9
	neg		;6bab
	add a,008h		;6bad
	ld e,a			;6baf
L_6BB0:
	cp 001h		;6bb0
	jr c,clase_1_bajo		;6bb2
	jr z,clase_1_alto		;6bb4
	cp 008h		;6bb6
	jr c,clase_1_x		;6bb8
	jr z,clase_1_alto		;6bba
	cp 00ah		;6bbc
	jr c,clase_1_bajo		;6bbe
clase_1_alto:
	ld a,l			;6bc0
	sub (ix+007h)		;6bc1
	cp 020h		;6bc4
	jr c,clase_1_x		;6bc6
	dec l			;6bc8
	jr clase_1_x		;6bc9
clase_1_bajo:
	ld a,l			;6bcb
	sub (ix+007h)		;6bcc
	cp 018h		;6bcf
	jr c,clase_1_x		;6bd1
	dec l			;6bd3
	cp 030h		;6bd4
	jr c,clase_1_x		;6bd6
	dec l			;6bd8
clase_1_x:
	ld a,l			;6bd9
	sub (ix+007h)		;6bda
	ld b,a			;6bdd
	ld a,e			;6bde
	add a,a			;6bdf
	add a,a			;6be0
	add a,a			;6be1
	add a,a			;6be2
	push hl			;6be3
	ld l,a			;6be4
	ld h,000h		;6be5
	add hl,hl			;6be7
	ld de,08ebch		;6be8   ; tabla p07:8EBC
	add hl,de			;6beb
	ld e,b			;6bec
	srl e		;6bed
	ld d,000h		;6bef
	add hl,de			;6bf1
	ld a,(hl)			;6bf2
	add a,(ix+006h)		;6bf3
	sub 010h		;6bf6
	pop hl			;6bf8
	ld h,a			;6bf9
	jp coloca_jugador		;6bfa
clase_2:
	ld a,e			;6bfd   ; tabla p07:8FFC (24 bytes por giro)
	cp 00ah		;6bfe
	jr c,L_6C09		;6c00
	sub 00ah		;6c02
	neg		;6c04
	add a,008h		;6c06
	ld e,a			;6c08
L_6C09:
	cp 001h		;6c09
	jr c,clase_2_b		;6c0b
	jr z,clase_2_a		;6c0d
	cp 002h		;6c0f
	jr z,clase_2_c		;6c11
	cp 007h		;6c13
	jr c,clase_2_x		;6c15
	jr z,clase_2_c		;6c17
	cp 009h		;6c19
	jr c,clase_2_a		;6c1b
	jr z,clase_2_b		;6c1d
clase_2_a:
	ld a,l			;6c1f
	sub (ix+007h)		;6c20
	cp 010h		;6c23
	jr c,clase_2_x		;6c25
	dec l			;6c27
	jr clase_2_x		;6c28
clase_2_b:
	ld a,l			;6c2a
	sub (ix+007h)		;6c2b
	cp 00ah		;6c2e
	jr c,clase_2_x		;6c30
	dec l			;6c32
	cp 01ch		;6c33
	jr c,clase_2_x		;6c35
	dec l			;6c37
	jr clase_2_x		;6c38
clase_2_c:
	ld a,l			;6c3a
	sub (ix+007h)		;6c3b
	cp 020h		;6c3e
	jr c,clase_2_x		;6c40
	dec l			;6c42
clase_2_x:
	ld a,l			;6c43
	sub (ix+007h)		;6c44
	ld b,a			;6c47
	ld a,e			;6c48
	add a,a			;6c49
	add a,e			;6c4a
	add a,a			;6c4b
	add a,a			;6c4c
	add a,a			;6c4d
	push hl			;6c4e
	ld l,a			;6c4f
	ld h,000h		;6c50
	ld de,08ffch		;6c52   ; tabla p07:8FFC
	add hl,de			;6c55
	ld e,b			;6c56
	srl e		;6c57
	ld d,000h		;6c59
	add hl,de			;6c5b
	ld a,(hl)			;6c5c
	add a,(ix+006h)		;6c5d
	sub 010h		;6c60
	pop hl			;6c62
	ld h,a			;6c63
	jp coloca_jugador		;6c64
clase_3:
	ld a,e			;6c67   ; tabla p07:90EC
	cp 00ah		;6c68
	jr c,L_6C73		;6c6a
	sub 00ah		;6c6c
	neg		;6c6e
	add a,008h		;6c70
	ld e,a			;6c72
L_6C73:
	cp 001h		;6c73
	jr c,clase_3_b		;6c75
	jr z,clase_3_a		;6c77
	cp 003h		;6c79
	jr c,clase_3_c		;6c7b
	jr z,clase_3_d		;6c7d
	cp 006h		;6c7f
	jr c,clase_3_x		;6c81
	jr z,clase_3_d		;6c83
	cp 008h		;6c85
	jr c,clase_3_c		;6c87
	jr nz,clase_3_b		;6c89
clase_3_a:
	ld a,l			;6c8b
	sub (ix+007h)		;6c8c
	cp 005h		;6c8f
	jr c,clase_3_x		;6c91
	dec l			;6c93
	cp 00dh		;6c94
	jr c,clase_3_x		;6c96
	dec l			;6c98
	cp 016h		;6c99
	jr c,clase_3_x		;6c9b
	dec l			;6c9d
	jr clase_3_x		;6c9e
clase_3_b:
	ld a,l			;6ca0
	sub (ix+007h)		;6ca1   ; la y se corrige un pixel por cada umbral que pasa
	cp 003h		;6ca4
	jr c,clase_3_x		;6ca6
	dec l			;6ca8
	cp 008h		;6ca9
	jr c,clase_3_x		;6cab
	dec l			;6cad
	cp 00dh		;6cae
	jr c,clase_3_x		;6cb0
	dec l			;6cb2
	cp 013h		;6cb3
	jr c,clase_3_x		;6cb5
	dec l			;6cb7
	jr clase_3_x		;6cb8
clase_3_c:
	ld a,l			;6cba
	sub (ix+007h)		;6cbb
	cp 009h		;6cbe
	jr c,clase_3_x		;6cc0
	dec l			;6cc2
	cp 019h		;6cc3
	jr c,clase_3_x		;6cc5
	dec l			;6cc7
	jr clase_3_x		;6cc8
clase_3_d:
	ld a,l			;6cca
	sub (ix+007h)		;6ccb
	cp 017h		;6cce
	jr c,clase_3_x		;6cd0
	dec l			;6cd2
clase_3_x:
	ld a,l			;6cd3   ; B = distancia en y
	sub (ix+007h)		;6cd4
	ld b,a			;6cd7
	ld a,e			;6cd8   ; giro * 16 (sin `add hl,hl`: 16 bytes por giro)...
	add a,a			;6cd9
	add a,a			;6cda
	add a,a			;6cdb
	add a,a			;6cdc
	push hl			;6cdd
	ld l,a			;6cde
	ld h,000h		;6cdf
	ld de,090ech		;6ce1   ; ...en la tabla p07:90EC
	add hl,de			;6ce4
	ld e,b			;6ce5   ; + distancia / 2
	srl e		;6ce6
	ld d,000h		;6ce8
	add hl,de			;6cea
	ld a,(hl)			;6ceb   ; x relativa + x del actor - 16
	add a,(ix+006h)		;6cec
	sub 010h		;6cef
	pop hl			;6cf1
	ld h,a			;6cf2
	jp coloca_jugador		;6cf3

; ----------------------------------------------------------------------
; Se suelta del actor: le da un empujon hacia el lado al que mira y pasa
; al salto del boton 2 (p06:7175).
; ----------------------------------------------------------------------
se_suelta:
	ld a,(0d904h)		;6cf6   ; mirando a la derecha (bit 0 = 0)...
	ld e,008h		;6cf9
	ld d,004h		;6cfb
	and 001h		;6cfd   ; ...E = derecha, D = izquierda
	jr nz,L_6D05		;6cff
	ld e,004h		;6d01   ; a la izquierda: al reves
	ld d,008h		;6d03
L_6D05:
	ld a,(0d573h)		;6d05   ; si no empuja ya hacia el otro lado...
	ld c,a			;6d08
	and d			;6d09
	jr nz,L_6D14		;6d0a
	ld a,(0d573h)		;6d0c   ; ...se le anade el empujon
	or e			;6d0f
	ld (0d573h),a		;6d10   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ld c,a			;6d13
L_6D14:
	push hl			;6d14
	ld hl,0d90fh		;6d15   ; ya no esta agarrado (D90F bit 3)
	res 3,(hl)		;6d18
	pop hl			;6d1a
	jp salta		;6d1b   ; al salto

; ----------------------------------------------------------------------
; D90D bit 5: en una escalera o cuerda (casillas de clase 0x80/0x90).
; Arriba y abajo lo mueven de uno en uno, mirando las casillas (p06:78A9).
; ----------------------------------------------------------------------
trepa:
	ld a,(0d90fh)		;6d1e   ; D90F bit 1 a 0
	res 1,a		;6d21
	ld (0d90fh),a		;6d23   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(0d573h)		;6d26   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6d29
	bit 5,b		;6d2a   ; pose con el bit 5: nada
	ret nz			;6d2c
	ld a,(0d90fh)		;6d2d   ; accion del boton 1 en marcha: nada
	bit 5,a		;6d30
	ret nz			;6d32
	ld a,l			;6d33   ; por debajo de y = 0x1F...
	cp 01fh		;6d34
	jr c,trepa_mandos		;6d36
	bit 5,c		;6d38   ; ...el boton 2 la suelta (p06:6E12)
	jp nz,suelta_escalera		;6d3a
trepa_mandos:
	bit 0,c		;6d3d   ; arriba: p06:6DBC
	jr nz,trepa_arriba		;6d3f
	bit 1,c		;6d41   ; abajo?
	ret z			;6d43
	inc l			;6d44   ; un pixel abajo
	push bc			;6d45
	push hl			;6d46
	ld a,004h		;6d47   ; las casillas de debajo
	call casillas_alrededor		;6d49
	ld a,b			;6d4c   ; la primera: clase menor que 0x20 o 0x80-0x9F u 0xA0...
	and 0f0h		;6d4d
	cp 020h		;6d4f
	jr c,L_6D5B		;6d51
	cp 080h		;6d53   ; ...0x20-0x7F: no se puede (p06:6DB9)
	jr c,no_se_puede		;6d55
	cp 0a0h		;6d57
	jr z,no_se_puede		;6d59
L_6D5B:
	ld a,c			;6d5b   ; la segunda, igual
	and 0f0h		;6d5c
	cp 020h		;6d5e
	jr c,L_6D6A		;6d60
	cp 080h		;6d62
	jr c,no_se_puede		;6d64
	cp 0a0h		;6d66
	jr z,no_se_puede		;6d68
L_6D6A:
	ld a,d			;6d6a   ; la tercera, igual
	and 0f0h		;6d6b
	cp 020h		;6d6d
	jr c,trepa_abajo_mira		;6d6f
	cp 080h		;6d71
	jr c,no_se_puede		;6d73
	cp 0a0h		;6d75
	jr z,no_se_puede		;6d77
trepa_abajo_mira:
	pop hl			;6d79
	pop bc			;6d7a
	push bc			;6d7b
	push hl			;6d7c
	inc l			;6d7d   ; tres pixeles mas abajo
	inc l			;6d7e
	inc l			;6d7f
	ld a,001h		;6d80   ; las casillas de los pies
	call casillas_alrededor		;6d82
	ld a,b			;6d85   ; 0x80 y 0x90 juntas: sigue en la escalera
	and 0f0h		;6d86
	cp 080h		;6d88
	jp nz,trepa_abajo_b		;6d8a
	ld a,c			;6d8d
	and 0f0h		;6d8e
	cp 090h		;6d90
	jp z,sigue_trepando		;6d92
trepa_abajo_b:
	ld a,c			;6d95   ; o 0x80 y 0x90 en la segunda y tercera
	and 0f0h		;6d96
	cp 080h		;6d98
	jp nz,baja_de_la_escalera		;6d9a
	ld a,d			;6d9d
	and 0f0h		;6d9e
	cp 090h		;6da0
	jp nz,baja_de_la_escalera		;6da2
sigue_trepando:
	ld hl,0d90fh		;6da5   ; D90F bit 1: se mueve
	set 1,(hl)		;6da8
	pop hl			;6daa
	pop bc			;6dab
	jp coloca_jugador		;6dac
baja_de_la_escalera:
	ld a,0c0h		;6daf   ; D90D = 0xC0: deja de trepar
	ld (0d90dh),a		;6db1
	pop hl			;6db4
	pop bc			;6db5
	jp coloca_jugador		;6db6
no_se_puede:
	pop hl			;6db9
	pop bc			;6dba
	ret			;6dbb
trepa_arriba:
	dec l			;6dbc   ; un pixel arriba...
	ld a,l			;6dbd
	cp 01fh		;6dbe   ; ...hasta y = 0x1F
	jp c,coloca_jugador		;6dc0
	push bc			;6dc3
	push hl			;6dc4
	ld a,001h		;6dc5   ; las casillas de encima
	call casillas_alrededor		;6dc7
	ld e,000h		;6dca   ; E cuenta las que son de escalera (0x10-0x7F no, 0x80-0x9F si)
	ld a,b			;6dcc   ; primera
	and 0f0h		;6dcd
	cp 010h		;6dcf
	jr c,L_6DDC		;6dd1
	cp 080h		;6dd3
	jr c,no_sube		;6dd5
	cp 0a0h		;6dd7
	jr nc,no_sube		;6dd9
	inc e			;6ddb
L_6DDC:
	ld a,c			;6ddc   ; segunda
	and 0f0h		;6ddd
	cp 010h		;6ddf
	jr c,no_sube		;6de1
	cp 080h		;6de3
	jr c,no_sube		;6de5
	cp 0a0h		;6de7
	jr nc,no_sube		;6de9
	inc e			;6deb
	ld a,d			;6dec   ; tercera
	and 0f0h		;6ded
	cp 010h		;6def
	jp c,cuenta_escalera		;6df1
	cp 080h		;6df4
	jr c,no_sube		;6df6
	cp 0a0h		;6df8
	jr nz,sube		;6dfa
cuenta_escalera:
	ld a,e			;6dfc   ; las dos primeras de escalera: sigue
	cp 002h		;6dfd
	jr z,sube		;6dff
no_sube:
	pop hl			;6e01
	pop bc			;6e02
	ld a,(0d8fdh)		;6e03   ; la y de antes
	ld l,a			;6e06
	jp coloca_jugador		;6e07
sube:
	ld hl,0d90fh		;6e0a   ; D90F bit 1: se mueve
	set 1,(hl)		;6e0d
	jp coloca_pop		;6e0f
suelta_escalera:
	bit 3,c		;6e12   ; con izquierda o derecha...
	jr nz,L_6E19		;6e14
	bit 2,c		;6e16
	ret z			;6e18
L_6E19:
	set 7,a		;6e19   ; ...D90E bits 7 y 6, sin el 0...
	set 6,a		;6e1b
	res 0,a		;6e1d
	ld (0d90eh),a		;6e1f
	jp salto_trayectoria		;6e22   ; ...y salta desde la escalera

; ----------------------------------------------------------------------
; De pie: izquierda o derecha lo mueven un pixel (D = la direccion para
; p06:78A9: 2 derecha, 8 izquierda) y luego mira que hay delante.
; ----------------------------------------------------------------------
anda:
	ld d,002h		;6e25   ; mirando a la derecha...
	bit 0,b		;6e27
	jr z,L_6E2D		;6e29
	ld d,008h		;6e2b   ; ...o a la izquierda
L_6E2D:
	bit 3,c		;6e2d   ; derecha?
	jr nz,anda_derecha		;6e2f
	bit 2,c		;6e31   ; izquierda?
	jr z,quieto		;6e33
	ld a,h			;6e35   ; x de 0xF0 a 0xF7: no pasa
	cp 0f8h		;6e36
	jr nc,anda_izquierda		;6e38
	cp 0f0h		;6e3a
	jp nc,quieto		;6e3c
anda_izquierda:
	ld d,008h		;6e3f   ; x - 1
	dec h			;6e41
	jr mira_delante		;6e42
anda_derecha:
	bit 2,c		;6e44   ; las dos: nada
	jr nz,quieto		;6e46
	ld a,h			;6e48   ; hasta x = 0xF0
	cp 0f0h		;6e49
	jp nc,quieto		;6e4b
	ld d,002h		;6e4e
	inc h			;6e50   ; x + 1
	jp mira_delante		;6e51
quieto:
	ld a,(0d90dh)		;6e54   ; fuera de cuesta: guarda la pose y ya
	bit 4,a		;6e57
	jp z,guarda_pose		;6e59
	ld d,008h		;6e5c   ; en la cuesta, la direccion es...
	bit 2,a		;6e5e   ; ...la izquierda o la derecha
	jr z,mira_delante		;6e60
	ld d,002h		;6e62
mira_delante:
	push bc			;6e64
	push hl			;6e65
	ld a,d			;6e66   ; las casillas en la direccion D
	call casillas_alrededor		;6e67
	ld d,c			;6e6a
	ld a,b			;6e6b   ; la de arriba: 0x10 o menos, nada
	and 0f0h		;6e6c
	cp 010h		;6e6e
	jr c,mira_delante_2		;6e70
	jr z,mira_delante_2		;6e72
	cp 040h		;6e74   ; 0x20-0x3F: pared (p06:6EA3)
	jr c,pared		;6e76
	cp 060h		;6e78   ; 0x40-0x5F: cuesta (p06:6FE8: la y sigue a la x) (p06:6EAC)
	jp c,entra_cuesta_a		;6e7a
	cp 080h		;6e7d   ; 0x60-0x7F: cuesta del otro lado (p06:6ED8)
	jp c,entra_cuesta_b		;6e7f
	cp 0a0h		;6e82   ; 0xA0: pared
	jr z,pared		;6e84
mira_delante_2:
	ld a,c			;6e86   ; la segunda, igual
	and 0f0h		;6e87
	cp 010h		;6e89
	jp c,nada_delante		;6e8b
	jp z,nada_delante		;6e8e
	cp 040h		;6e91
	jr c,pared		;6e93
	cp 060h		;6e95
	jr c,entra_cuesta_a		;6e97
	cp 080h		;6e99
	jp c,entra_cuesta_b		;6e9b
	cp 0a0h		;6e9e
	jp nz,nada_delante		;6ea0
pared:
	pop hl			;6ea3
	pop bc			;6ea4
	ld a,(0d8fch)		;6ea5   ; vuelve a la x de antes
	ld h,a			;6ea8
	jp mira_pies		;6ea9
entra_cuesta_a:
	pop hl			;6eac
	pop bc			;6ead
	bit 3,c		;6eae   ; yendo a la derecha, choca (p06:6F04)
	jr nz,choca		;6eb0
	ld a,h			;6eb2   ; en los dos ultimos pixeles de la casilla...
	and 00fh		;6eb3
	cp 00eh		;6eb5
	jp c,mira_pies		;6eb7
	ld a,(0d90dh)		;6eba   ; ...si no esta ya en una cuesta...
	bit 4,a		;6ebd
	jp nz,mira_pies		;6ebf
	set 4,a		;6ec2   ; ...entra en la cuesta (D90D bit 4)
	res 2,a		;6ec4
	ld (0d90dh),a		;6ec6
	ld a,l			;6ec9   ; apunta la casilla: y en D908...
	and 0f8h		;6eca
	ld (0d908h),a		;6ecc
	ld a,h			;6ecf   ; ...x en D907
	and 0f0h		;6ed0
	ld (0d907h),a		;6ed2
	jp mira_pies		;6ed5
entra_cuesta_b:
	pop hl			;6ed8
	pop bc			;6ed9
	bit 2,c		;6eda   ; yendo a la izquierda, choca
	jr nz,choca		;6edc
	ld a,h			;6ede   ; en los dos primeros pixeles de la casilla...
	and 00fh		;6edf
	cp 002h		;6ee1
	jp nc,mira_pies		;6ee3
	ld a,(0d90dh)		;6ee6
	bit 4,a		;6ee9
	jp nz,mira_pies		;6eeb
	set 4,a		;6eee   ; ...entra en la cuesta del otro lado (bits 4 y 2)
	set 2,a		;6ef0
	ld (0d90dh),a		;6ef2
	ld a,l			;6ef5   ; la casilla en D907/D908
	and 0f8h		;6ef6
	ld (0d908h),a		;6ef8
	ld a,h			;6efb
	and 0f0h		;6efc
	ld (0d907h),a		;6efe
	jp mira_pies		;6f01
choca:
	ld a,(0d8fch)		;6f04   ; la x de antes
	ld h,a			;6f07
	jp mira_pies		;6f08
nada_delante:
	pop hl			;6f0b
	pop bc			;6f0c
mira_pies:
	push bc			;6f0d
	push de			;6f0e
	push hl			;6f0f
	inc l			;6f10   ; tres pixeles mas abajo
	inc l			;6f11
	inc l			;6f12
	ld a,001h		;6f13   ; las casillas de los pies
	call casillas_alrededor		;6f15
	ld a,b			;6f18   ; 0x80 y 0x90 en las dos primeras: el pie de una escalera
	and 0f0h		;6f19
	cp 080h		;6f1b
	jp nz,mira_pies_2		;6f1d
	ld a,c			;6f20
	and 0f0h		;6f21
	cp 090h		;6f23
	jr z,escalera_a_la_izquierda		;6f25
mira_pies_2:
	ld a,c			;6f27   ; o en la segunda y la tercera
	and 0f0h		;6f28
	cp 080h		;6f2a
	jp nz,sin_escalera		;6f2c
	ld a,d			;6f2f
	and 0f0h		;6f30
	cp 090h		;6f32
	jp nz,sin_escalera		;6f34
	pop hl			;6f37
	ld a,h			;6f38   ; a menos de 4 pixeles del borde de la casilla...
	and 00fh		;6f39
	cp 00ch		;6f3b
	jr c,mira_suelo		;6f3d
	ld a,h			;6f3f   ; ...se centra en la siguiente
	add a,010h		;6f40
	ld h,a			;6f42
	jr sube_a_la_escalera		;6f43
escalera_a_la_izquierda:
	pop hl			;6f45
	ld a,h			;6f46   ; a 4 pixeles o mas del borde: no
	and 00fh		;6f47
	cp 004h		;6f49
	jr nc,mira_suelo		;6f4b
sube_a_la_escalera:
	pop de			;6f4d
	pop bc			;6f4e
	ld a,h			;6f4f   ; x al principio de la casilla
	and 0f0h		;6f50
	ld h,a			;6f52
	ld a,b			;6f53   ; la pose de trepar (bits 1-4 = 2)
	and 0e1h		;6f54
	or 004h		;6f56
	ld b,a			;6f58
	ld a,(0d90dh)		;6f59   ; D90D: fuera la cuesta, en la escalera (bit 5)
	res 4,a		;6f5c
	set 5,a		;6f5e
	ld (0d90dh),a		;6f60
	jp coloca_jugador		;6f63
sin_escalera:
	pop hl			;6f66
mira_suelo:
	pop de			;6f67
	pop bc			;6f68
	ld a,(0d90dh)		;6f69   ; en una cuesta: p06:6FE8
	bit 4,a		;6f6c
	jp nz,en_cuesta		;6f6e
	push bc			;6f71
	push hl			;6f72
	ld a,004h		;6f73   ; las casillas de debajo
	call casillas_alrededor		;6f75
	ld a,b			;6f78   ; la primera: 0x10 o menos, nada
	and 0f0h		;6f79
	cp 010h		;6f7b
	jr c,mira_suelo_2		;6f7d
	jr z,mira_suelo_2		;6f7f
	cp 040h		;6f81   ; 0x20-0x3F: suelo con cuesta a un lado (p06:7138)
	jp c,al_borde		;6f83
	cp 070h		;6f86   ; 0x70: p06:7160
	jp z,cuesta_del_otro_lado		;6f88
	cp 0a0h		;6f8b   ; 0xA0: p06:7138
	jp z,al_borde		;6f8d
mira_suelo_2:
	ld a,c			;6f90   ; la segunda: menos de 0x20, sigue
	and 0f0h		;6f91
	cp 020h		;6f93
	jr c,mira_suelo_3		;6f95
	cp 040h		;6f97   ; 0x20-0x3F: p06:6FC2
	jr c,entra_en_cuesta		;6f99
	cp 060h		;6f9b   ; 0x60: p06:7160
	jp z,cuesta_del_otro_lado		;6f9d
	cp 0a0h		;6fa0
	jr z,entra_en_cuesta		;6fa2
mira_suelo_3:
	ld a,d			;6fa4   ; la tercera: 0x20-0x3F o 0xA0, se queda en pie
	and 0f0h		;6fa5
	cp 010h		;6fa7
	jp c,cae		;6fa9
	jr z,cae		;6fac
	cp 040h		;6fae
	jp c,coloca_pop		;6fb0
	cp 0a0h		;6fb3
	jp z,coloca_pop		;6fb5
cae:
	ld a,0c0h		;6fb8   ; no hay suelo: D90D = 0xC0, cae
	ld (0d90dh),a		;6fba
	pop hl			;6fbd
	pop bc			;6fbe
	jp coloca_jugador		;6fbf
entra_en_cuesta:
	ld a,d			;6fc2   ; la tercera tiene que ser 0x40-0x5F
	cp 040h		;6fc3
	jp c,coloca_pop		;6fc5
	cp 060h		;6fc8
	jp nc,coloca_pop		;6fca
	pop hl			;6fcd
	pop bc			;6fce
	ld a,h			;6fcf   ; por debajo de x = 8 no
	cp 008h		;6fd0
	jp c,coloca_jugador		;6fd2
	ld a,(0d90dh)		;6fd5   ; en cuesta (bits 4 y 3)...
	set 4,a		;6fd8
	set 3,a		;6fda
	ld (0d90dh),a		;6fdc
	ld a,(0d8fdh)		;6fdf   ; ...con D907 = la y
	ld (0d907h),a		;6fe2
	jp coloca_jugador		;6fe5

; ----------------------------------------------------------------------
; En una cuesta: la y sigue a la x. D907 guarda la casilla en x y D908 la y
; de la cuesta; cada casilla que se avanza, 8 pixeles mas arriba o abajo.
; ----------------------------------------------------------------------
en_cuesta:
	ld a,(0d90dh)		;6fe8   ; bit 2: la cuesta del otro lado (p06:708A)
	bit 2,a		;6feb
	jp nz,cuesta_b		;6fed
	ld a,h			;6ff0   ; E = (x & 0x0F) / 2 - 8: la altura dentro de la casilla
	and 00fh		;6ff1
	sra a		;6ff3
	sub 008h		;6ff5
	ld e,a			;6ff7
	ld a,(0d907h)		;6ff8   ; ha cambiado de casilla?
	ld d,a			;6ffb
	xor h			;6ffc
	and 0f0h		;6ffd
	jr z,y_en_cuesta		;6fff
	ld a,d			;7001   ; hacia la derecha:...
	cp h			;7002
	jr nc,cuesta_atras		;7003
	ld a,h			;7005   ; ...casilla nueva...
	and 0f0h		;7006
	ld (0d907h),a		;7008
	ld a,(0d908h)		;700b   ; ...8 pixeles mas abajo
	add a,008h		;700e
	ld (0d908h),a		;7010
	jr y_en_cuesta		;7013
cuesta_atras:
	ld a,h			;7015   ; hacia la izquierda: 8 mas arriba
	and 0f0h		;7016
	ld (0d907h),a		;7018
	ld a,(0d908h)		;701b
	sub 008h		;701e
	ld (0d908h),a		;7020
y_en_cuesta:
	ld a,(0d908h)		;7023   ; y = la de la cuesta + E
	add a,e			;7026
	ld l,a			;7027
	push bc			;7028
	push de			;7029
	push hl			;702a
	ld a,004h		;702b   ; mira lo que hay debajo
	call casillas_alrededor		;702d
	ld a,d			;7030   ; la tercera: 0x20-0x3F o 0xA0, se acaba la cuesta (p06:7124)
	and 0f0h		;7031
	cp 020h		;7033
	jr c,y_en_cuesta_2		;7035
	cp 040h		;7037
	jp c,fin_de_cuesta		;7039
	cp 080h		;703c   ; 0x40-0x7F: sigue
	jr c,sigue_en_cuesta		;703e
	cp 0a0h		;7040
	jp z,fin_de_cuesta		;7042
y_en_cuesta_2:
	ld a,b			;7045   ; la primera: 0x20-0x7F o 0xA0, sigue
	and 0f0h		;7046
	cp 020h		;7048
	jp c,y_en_cuesta_3		;704a
	cp 080h		;704d
	jr c,sigue_en_cuesta		;704f
	cp 0a0h		;7051
	jr z,sigue_en_cuesta		;7053
y_en_cuesta_3:
	ld a,c			;7055   ; la segunda, igual
	and 0f0h		;7056
	cp 020h		;7058
	jp c,y_en_cuesta_4		;705a
	cp 080h		;705d
	jr c,sigue_en_cuesta		;705f
	cp 0a0h		;7061
	jr z,sigue_en_cuesta		;7063
	jp y_en_cuesta_4		;7065
y_en_cuesta_4:
	pop hl			;7068   ; 8 pixeles mas abajo...
	push hl			;7069
	ld a,l			;706a
	add a,008h		;706b
	ld l,a			;706d
	ld a,004h		;706e
	call casillas_alrededor		;7070   ; ...la tercera
	ld a,d			;7073
	and 0f0h		;7074
	cp 020h		;7076   ; menos de 0x20: se acaba y cae (p06:716A)
	jp c,sin_suelo		;7078
	cp 080h		;707b
	jr c,sigue_en_cuesta		;707d
	cp 0a0h		;707f
	jp nz,sin_suelo		;7081
sigue_en_cuesta:
	pop hl			;7084
	pop de			;7085
	pop bc			;7086
	jp coloca_jugador		;7087
cuesta_b:
	ld a,h			;708a   ; la del otro lado: E = -(x & 0x0F) / 2 - 1
	and 00fh		;708b
	srl a		;708d
	neg		;708f
	dec a			;7091
	ld e,a			;7092
	ld a,(0d907h)		;7093   ; ha cambiado de casilla?
	ld d,a			;7096
	xor h			;7097
	and 0f0h		;7098
	jr z,y_en_cuesta_b		;709a
	ld a,d			;709c
	cp h			;709d
	jr nc,cuesta_b_atras		;709e
	ld a,h			;70a0   ; hacia la derecha: 8 mas arriba
	and 0f0h		;70a1
	ld (0d907h),a		;70a3
	ld a,(0d908h)		;70a6
	sub 008h		;70a9
	ld (0d908h),a		;70ab
	jr y_en_cuesta_b		;70ae
cuesta_b_atras:
	ld a,h			;70b0   ; hacia la izquierda: 8 mas abajo
	and 0f0h		;70b1
	ld (0d907h),a		;70b3
	ld a,(0d908h)		;70b6
	add a,008h		;70b9
	ld (0d908h),a		;70bb
y_en_cuesta_b:
	ld a,(0d908h)		;70be   ; y = la de la cuesta + E
	add a,e			;70c1
	ld l,a			;70c2
	ld a,h			;70c3
	and 00fh		;70c4
	push bc			;70c6
	push de			;70c7
	push hl			;70c8
	ld a,004h		;70c9   ; lo que hay debajo
	call casillas_alrededor		;70cb
	ld a,b			;70ce   ; la primera: 0x20-0x3F o 0xA0 acaba la cuesta; 0x40-0x7F sigue
	and 0f0h		;70cf
	cp 020h		;70d1
	jr c,y_en_cuesta_b2		;70d3
	cp 040h		;70d5
	jr c,fin_de_cuesta		;70d7
	cp 080h		;70d9
	jr c,sigue_en_cuesta_b		;70db
	cp 0a0h		;70dd
	jr z,fin_de_cuesta		;70df
y_en_cuesta_b2:
	ld a,d			;70e1   ; la tercera
	and 0f0h		;70e2
	cp 020h		;70e4
	jp c,y_en_cuesta_b3		;70e6
	cp 080h		;70e9
	jr c,sigue_en_cuesta_b		;70eb
	cp 0a0h		;70ed
	jr z,sigue_en_cuesta_b		;70ef
y_en_cuesta_b3:
	ld a,c			;70f1   ; la segunda (comparada sin `and 0xF0`)
	cp 020h		;70f2
	jp c,y_en_cuesta_b4		;70f4
	cp 080h		;70f7
	jr c,sigue_en_cuesta_b		;70f9
	cp 0a0h		;70fb
	jr z,sigue_en_cuesta_b		;70fd
	jp y_en_cuesta_b4		;70ff
y_en_cuesta_b4:
	pop hl			;7102
	push hl			;7103
	ld a,l			;7104   ; 8 pixeles mas abajo
	add a,008h		;7105
	ld l,a			;7107
	ld a,004h		;7108
	call casillas_alrededor		;710a
	ld a,b			;710d
	and 0f0h		;710e
	cp 020h		;7110   ; menos de 0x20: cae
	jp c,sin_suelo		;7112
	cp 080h		;7115
	jr c,sigue_en_cuesta_b		;7117
	cp 0a0h		;7119
	jp nz,sin_suelo		;711b
sigue_en_cuesta_b:
	pop hl			;711e
	pop de			;711f
	pop bc			;7120
	jp coloca_jugador		;7121
fin_de_cuesta:
	pop hl			;7124
	pop de			;7125
	pop bc			;7126
	ld a,(0d90dh)		;7127   ; fuera de la cuesta
	res 4,a		;712a
	res 2,a		;712c
	ld (0d90dh),a		;712e
	ld a,l			;7131   ; y al principio de la casilla
	and 0f0h		;7132
	ld l,a			;7134
	jp coloca_jugador		;7135
al_borde:
	ld a,c			;7138   ; la segunda casilla 0x50: el arranque de una cuesta
	and 0f0h		;7139
	cp 050h		;713b
	jp nz,coloca_pop		;713d
	pop hl			;7140
	pop bc			;7141
	ld a,h			;7142   ; en los 4 primeros pixeles no
	and 00fh		;7143
	cp 004h		;7145
	jp c,coloca_jugador		;7147
	ld a,010h		;714a   ; D90D = 0x10: en la cuesta
	ld (0d90dh),a		;714c
apunta_cuesta:
	ld a,l			;714f   ; D908 = y de la casilla + 8
	and 0f0h		;7150
	add a,008h		;7152
	ld (0d908h),a		;7154
	ld a,h			;7157   ; D907 = x de la casilla
	and 0f0h		;7158
	ld (0d907h),a		;715a
	jp coloca_jugador		;715d
cuesta_del_otro_lado:
	pop hl			;7160
	pop bc			;7161
	ld a,014h		;7162   ; D90D = 0x14: en la cuesta del otro lado
	ld (0d90dh),a		;7164
	jp apunta_cuesta		;7167
sin_suelo:
	ld a,0c0h		;716a   ; D90D = 0xC0: cae
	ld (0d90dh),a		;716c
	pop hl			;716f
	pop de			;7170
	pop bc			;7171
	jp coloca_jugador		;7172

; ----------------------------------------------------------------------
; EL SALTO (boton 2). Elige la trayectoria: con arriba, la de las tablas
; p06:744A/7469/7488 y si no las de p06:740B/7420/7435; hacia la
; izquierda, la derecha o recto. Cada tabla es una lista de pasos que se
; suman a la y (o a la x) hasta un 0x80.
; ----------------------------------------------------------------------
salta:
	ld a,040h		;7175   ; D90E = 0x40: hay que soltar el boton 2
	ld (0d90eh),a		;7177
salto_trayectoria:
	push hl			;717a
	ld hl,0d90fh		;717b   ; D90F bit 2 a 0
	res 2,(hl)		;717e
	pop hl			;7180
	bit 0,c		;7181   ; arriba: el salto alto
	jp nz,salto_alto		;7183
	push hl			;7186
	ld hl,0740bh		;7187   ; los pasos en y del salto normal
	bit 3,c		;718a   ; derecha?
	jr nz,salto_derecha		;718c
	bit 2,c		;718e   ; izquierda?
	jr z,salto_recto		;7190
	ld a,088h		;7192   ; hacia la izquierda: D90D = 0x88...
	ld de,07435h		;7194   ; ...y los pasos en x de p06:7435
	jr empieza_salto		;7197
salto_derecha:
	bit 2,c		;7199
	jr nz,salto_recto		;719b   ; las dos: recto
	ld de,07420h		;719d   ; hacia la derecha: pasos en x de p06:7420...
	ld a,08ch		;71a0   ; ...D90D = 0x8C
	jr empieza_salto		;71a2
salto_recto:
	ld a,080h		;71a4   ; D90D = 0x80, sin pasos en x
	ld de,00000h		;71a6
	jr empieza_salto		;71a9
salto_alto:
	push hl			;71ab
	ld hl,0744ah		;71ac   ; los pasos en y del salto alto
	bit 3,c		;71af
	jr nz,salto_alto_derecha		;71b1
	bit 2,c		;71b3
	jr z,salto_alto_recto		;71b5
	ld a,089h		;71b7   ; izquierda: 0x89 y p06:7488
	ld de,07488h		;71b9
	jr empieza_salto		;71bc
salto_alto_derecha:
	bit 2,c		;71be
	jr nz,salto_alto_recto		;71c0
	ld de,07469h		;71c2   ; derecha: p06:7469 y 0x8D
	ld a,08dh		;71c5
	jr empieza_salto		;71c7
salto_alto_recto:
	ld a,080h		;71c9
	ld de,00000h		;71cb
empieza_salto:
	ld (0d90dh),a		;71ce   ; el estado
	ld (0d90bh),de		;71d1   ; D90B = los pasos en x
	ld (0d909h),hl		;71d5   ; D909 = los pasos en y
	exx			;71d8
	ld hl,0d928h		;71d9   ; suceso del bit 0: efecto 0x10
	set 0,(hl)		;71dc
	exx			;71de
	pop hl			;71df

; ----------------------------------------------------------------------
; En el aire (D90D bit 7). Bit 6: cayendo (p06:74A7); bit 1: p06:739E; si
; no, un paso mas de la trayectoria.
; ----------------------------------------------------------------------
en_el_aire:
	bit 6,a		;71e0
	jp nz,cayendo		;71e2
	bit 1,a		;71e5   ; bit 1: p06:739E
	jp nz,bajando		;71e7
	ld de,(0d909h)		;71ea   ; el paso en y...
	ld a,(de)			;71ee
	cp 080h		;71ef   ; ...0x80: la trayectoria se acaba (p06:736E)
	jp z,fin_subida		;71f1
	inc de			;71f4   ; el siguiente, para el cuadro que viene
	ld (0d909h),de		;71f5
	add a,l			;71f9   ; y + paso
	ld l,a			;71fa
	ld a,(0d90dh)		;71fb   ; bit 3: tambien se mueve en x
	bit 3,a		;71fe
	jp z,choque_arriba		;7200
	ld de,(0d90bh)		;7203   ; el paso en x
	ld a,(de)			;7207
	inc de			;7208
	ld (0d90bh),de		;7209
	ld e,a			;720d   ; x + paso
	add a,h			;720e
	ld d,a			;720f
	ld a,(0d90dh)		;7210   ; con el bit 0 el paso cuenta doble
	bit 0,a		;7213
	ld a,d			;7215
	jr z,x_en_el_aire		;7216
	add a,e			;7218
x_en_el_aire:
	ld h,a			;7219
	ld a,(0d90dh)		;721a   ; bit 2: hacia la izquierda...
	bit 2,a		;721d
	jr z,x_en_el_aire_der		;721f
	ld a,002h		;7221   ; ...direccion 2 para p06:78A9
	jr choque_lateral_en_el_aire		;7223
x_en_el_aire_der:
	ld a,008h		;7225   ; ...o la 8
choque_lateral_en_el_aire:
	push bc			;7227
	push hl			;7228
	call casillas_alrededor		;7229   ; las casillas hacia donde va
	ld a,b			;722c   ; la primera: 0x10 o menos, nada
	and 0f0h		;722d
	cp 010h		;722f
	jr c,choque_lateral_2		;7231
	jr c,choque_lateral_2		;7233   ; (el `jr c` repetido no hace nada)
	cp 080h		;7235   ; 0x20-0x7F o 0xA0: choca
	jr c,choque_lateral		;7237
	cp 0a0h		;7239
	jr z,choque_lateral		;723b
choque_lateral_2:
	ld a,c			;723d   ; la segunda: 0x20-0x7F o 0xA0, choca
	and 0f0h		;723e
	cp 010h		;7240
	jr c,choque_lateral_3		;7242
	jr z,choque_lateral_3		;7244
	cp 040h		;7246
	jr c,choque_lateral		;7248
	cp 060h		;724a
	jp c,choque_lateral		;724c
	cp 080h		;724f
	jp c,choque_lateral		;7251
	cp 0a0h		;7254
	jr z,choque_lateral		;7256
choque_lateral_3:
	ld a,d			;7258   ; la tercera: 0x20-0x3F u 0xA0 choca...
	and 0f0h		;7259
	cp 010h		;725b
	jp c,sin_choque_lateral		;725d
	jp z,sin_choque_lateral		;7260
	cp 040h		;7263
	jr c,choque_lateral		;7265
	cp 060h		;7267   ; ...0x40-0x5F y 0x60-0x7F: cuestas (p06:727C/7297)
	jr c,cuesta_en_el_aire_a		;7269
	cp 080h		;726b
	jr c,cuesta_en_el_aire_b		;726d
	cp 0a0h		;726f
	jr z,choque_lateral		;7271
sin_choque_lateral:
	pop hl			;7273
	pop bc			;7274
	jp choque_arriba		;7275
choque_lateral:
	pop hl			;7278
	pop bc			;7279
	jr vuelve_x		;727a
cuesta_en_el_aire_a:
	pop hl			;727c
	pop bc			;727d
	ld a,(0d90dh)		;727e   ; solo cuenta yendo hacia la izquierda
	bit 2,a		;7281
	jp z,choque_arriba		;7283
	ld a,d			;7286   ; una cuesta 0x40 exacta choca
	and 0f0h		;7287
	cp 040h		;7289
	jp z,vuelve_x		;728b
	ld a,h			;728e   ; y por la derecha de x = 8 tambien
	cp 008h		;728f
	jp nc,vuelve_x		;7291
	jp choque_arriba		;7294
cuesta_en_el_aire_b:
	pop hl			;7297
	pop bc			;7298
	ld a,(0d90dh)		;7299   ; solo cuenta yendo hacia la derecha
	bit 2,a		;729c
	jp nz,choque_arriba		;729e
	ld a,d			;72a1   ; 0x40 exacta choca
	and 0f0h		;72a2
	cp 040h		;72a4
	jp z,vuelve_x		;72a6
	ld a,h			;72a9   ; y por la derecha de x = 8
	cp 008h		;72aa
	jp nc,vuelve_x		;72ac
	jp choque_arriba		;72af
vuelve_x:
	ld a,(0d8fch)		;72b2   ; choca: la x de antes
	ld h,a			;72b5
choque_arriba:
	push bc			;72b6   ; las casillas de encima (direccion 1)
	push hl			;72b7
	ld a,001h		;72b8
	call casillas_alrededor		;72ba
	ld a,b			;72bd   ; la primera: menos de 0x20, 0x80, 0x90 o 0xF0 deja pasar...
	and 0f0h		;72be
	cp 020h		;72c0
	jr c,choque_arriba_2		;72c2
	cp 080h		;72c4
	jr z,choque_arriba_2		;72c6
	cp 090h		;72c8
	jr z,choque_arriba_2		;72ca
	cp 0f0h		;72cc
	jp nz,techo		;72ce   ; ...cualquier otra es techo (p06:736C)
choque_arriba_2:
	ld a,c			;72d1   ; la segunda, igual
	and 0f0h		;72d2
	cp 020h		;72d4
	jr c,choque_arriba_3		;72d6
	cp 080h		;72d8
	jr z,choque_arriba_3		;72da
	cp 090h		;72dc
	jr z,choque_arriba_3		;72de
	cp 0f0h		;72e0
	jp nz,techo		;72e2
choque_arriba_3:
	ld a,d			;72e5   ; la tercera, igual
	and 0f0h		;72e6
	cp 020h		;72e8
	jr c,agarra_escalera		;72ea
	cp 080h		;72ec
	jr z,agarra_escalera		;72ee
	cp 090h		;72f0
	jr z,agarra_escalera		;72f2
	cp 0f0h		;72f4
	jp nz,techo		;72f6
agarra_escalera:
	pop hl			;72f9
	pop bc			;72fa
	push bc			;72fb
	push hl			;72fc
	inc l			;72fd   ; tres pixeles mas abajo
	inc l			;72fe
	inc l			;72ff
	ld a,001h		;7300   ; las casillas de los pies
	call casillas_alrededor		;7302
	ld a,b			;7305   ; 0x80 y 0x90: una escalera
	and 0f0h		;7306
	cp 080h		;7308
	jp nz,agarra_escalera_2		;730a
	ld a,c			;730d
	and 0f0h		;730e
	cp 090h		;7310
	jr z,agarra_escalera_izq		;7312
agarra_escalera_2:
	ld a,c			;7314   ; o en la segunda y la tercera
	and 0f0h		;7315
	cp 080h		;7317
	jp nz,sin_escalera_aire		;7319
	ld a,d			;731c
	and 0f0h		;731d
	cp 090h		;731f
	jp nz,sin_escalera_aire		;7321
	pop hl			;7324
	ld a,(0d90eh)		;7325   ; D90E bit 7: aun no puede agarrarse
	bit 7,a		;7328
	jr nz,sigue_en_el_aire		;732a
	ld a,h			;732c   ; en los 6 ultimos pixeles de la casilla...
	and 00fh		;732d
	cp 00ah		;732f
	jr c,sigue_en_el_aire		;7331
	ld a,h			;7333   ; ...se agarra a la siguiente
	add a,010h		;7334
	ld h,a			;7336
	jr se_agarra		;7337
agarra_escalera_izq:
	pop hl			;7339
	ld a,(0d90eh)		;733a   ; D90E bit 7: aun no
	bit 7,a		;733d
	jr nz,sigue_en_el_aire		;733f
	ld a,h			;7341   ; en los 6 primeros pixeles
	and 00fh		;7342
	cp 006h		;7344
	jr nc,sigue_en_el_aire		;7346
se_agarra:
	ld a,h			;7348   ; x al principio de la casilla
	and 0f0h		;7349
	ld h,a			;734b
	pop bc			;734c
	ld a,h			;734d
	and 0f0h		;734e
	ld h,a			;7350
	ld a,b			;7351   ; la pose de trepar (bits 1-4 = 2)
	and 0e1h		;7352
	or 004h		;7354
	ld b,a			;7356
	ld a,020h		;7357   ; D90D = 0x20: en la escalera
	ld (0d90dh),a		;7359
	jp coloca_jugador		;735c
sin_escalera_aire:
	ld a,(0d90eh)		;735f   ; ya puede agarrarse: D90E bit 7 a 0
	res 7,a		;7362
	ld (0d90eh),a		;7364
	pop hl			;7367
sigue_en_el_aire:
	pop bc			;7368
	jp coloca_jugador		;7369
techo:
	pop hl			;736c
	pop bc			;736d

; ----------------------------------------------------------------------
; Se acaba la subida (un 0x80 o un techo): los punteros vuelven un paso
; atras y empieza la bajada (D90D bit 1), que recorre las MISMAS tablas al
; reves y con el signo cambiado.
; ----------------------------------------------------------------------
fin_subida:
	ld de,(0d909h)		;736e   ; un paso atras en y...
	dec de			;7372
	ld (0d909h),de		;7373
	ld de,(0d90bh)		;7377   ; ...y en x
	dec de			;737b
	ld (0d90bh),de		;737c
	ld a,(0d8fdh)		;7380   ; la y de antes
	ld l,a			;7383
	ld a,(0d90dh)		;7384   ; bajando (bit 1)
	set 1,a		;7387
	ld (0d90dh),a		;7389
	ld a,(0d90eh)		;738c   ; D90E bit 0 a 0
	res 0,a		;738f
	ld (0d90eh),a		;7391
	ld de,00000h		;7394   ; ya no esta agarrado a nada (D914 = 0)
	ld (0d914h),de		;7397
	jp coloca_jugador		;739b

; ----------------------------------------------------------------------
; Bajando. Si se pulsa el boton 2 otra vez con D90E bit 0 y la direccion del
; salto, vuelve a saltar; si no, la tabla al reves con el signo cambiado.
; ----------------------------------------------------------------------
bajando:
	ld a,(0d90eh)		;739e   ; D90E bit 0...
	bit 0,a		;73a1
	jr z,paso_de_bajada		;73a3
	ld a,(0d573h)		;73a5   ; ...boton 2...
	ld c,a			;73a8
	bit 5,c		;73a9
	jr z,paso_de_bajada		;73ab
	ld a,(0d90dh)		;73ad   ; ...y saltando de lado...
	bit 3,a		;73b0
	jr z,paso_de_bajada		;73b2
	bit 2,a		;73b4   ; ...hacia la derecha con la derecha pulsada...
	jr nz,otra_vez_izq		;73b6
	bit 3,c		;73b8
	jr z,paso_de_bajada		;73ba
	jp salta		;73bc   ; ...salta otra vez
otra_vez_izq:
	bit 2,c		;73bf   ; ...o hacia la izquierda con la izquierda
	jp nz,salta		;73c1
paso_de_bajada:
	ld de,(0d909h)		;73c4   ; el paso de la tabla, hacia atras
	ld a,(de)			;73c8
	cp 080h		;73c9   ; 0x80: el principio de la tabla, se acaba la trayectoria (p06:73FF)
	jp z,cae_libre		;73cb
	dec de			;73ce
	ld (0d909h),de		;73cf
	neg		;73d3   ; con el signo cambiado: y - paso
	add a,l			;73d5
	ld l,a			;73d6
	ld a,(0d90dh)		;73d7   ; de lado?
	bit 3,a		;73da
	jp z,aterriza		;73dc
	ld de,(0d90bh)		;73df   ; el paso en x, tambien hacia atras...
	ld a,(de)			;73e3
	dec de			;73e4
	ld (0d90bh),de		;73e5
	add a,h			;73e9   ; ...y sumado
	ld h,a			;73ea
	ld a,(0d90dh)		;73eb   ; hacia la izquierda: direcciones 4 y 2...
	bit 2,a		;73ee
	jr z,bajada_der		;73f0
	ld c,004h		;73f2
	ld d,002h		;73f4
	jr mira_al_bajar		;73f6
bajada_der:
	ld c,008h		;73f8   ; ...o 8 y 8
	ld d,008h		;73fa
mira_al_bajar:
	jp mira_al_caer		;73fc
cae_libre:
	ld a,(0d90dh)		;73ff   ; trayectoria acabada: cae (bit 6)
	set 6,a		;7402
	ld (0d90dh),a		;7404
	jp aterriza		;7407

; ----------------------------------------------------------------------
; DATOS salto_inicio: 0x80: el tope del principio para cuando la tabla de
;   abajo se lee al reves
;   0x740a..0x740b  (1 bytes)
DATA_salto_inicio:
	defb 080h	; 740a

; ----------------------------------------------------------------------
; DATOS salto_dy: Salto normal: 20 pasos en y (de -2 a 0) y el 0x80 final
;   0x740b..0x7420  (21 bytes)
DATA_salto_dy:
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0ffh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,000h,000h,080h	; 740b  .....................

; ----------------------------------------------------------------------
; DATOS salto_dx_der: Salto normal a la derecha: 20 pasos en x (+1 o +2) y
;   0x80
;   0x7420..0x7435  (21 bytes)
DATA_salto_dx_der:
	defb 001h,001h,002h,001h,001h,001h,001h,002h,001h,001h,001h,001h,002h,001h,001h,001h,001h,002h,001h,001h,080h	; 7420  .....................

; ----------------------------------------------------------------------
; DATOS salto_dx_izq: Salto normal a la izquierda: 20 pasos en x (-1 o -2) y
;   0x80
;   0x7435..0x744a  (21 bytes)
DATA_salto_dx_izq:
	defb 0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,080h	; 7435  .....................

; ----------------------------------------------------------------------
; DATOS salto_alto_dy: Salto alto (con arriba): 30 pasos en y (de -3 a 0) y
;   0x80
;   0x744a..0x7469  (31 bytes)
DATA_salto_alto_dy:
	defb 0fdh,0fdh,0fdh,0fdh,0fdh,0feh,0fdh,0feh,0feh,0fdh,0feh,0feh,0feh,0feh,0ffh,0feh,0feh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,000h,000h,0ffh,0ffh,000h,000h,000h,080h	; 744a  ...............................

; ----------------------------------------------------------------------
; DATOS salto_alto_dx_der: Salto alto a la derecha: 30 pasos en x (0 o +1, que
;   cuentan doble) y 0x80
;   0x7469..0x7488  (31 bytes)
DATA_salto_alto_dx_der:
	defb 001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,080h	; 7469  ...............................

; ----------------------------------------------------------------------
; DATOS salto_alto_dx_izq: Salto alto a la izquierda: 30 pasos en x (0 o -1,
;   doble) y 0x80
;   0x7488..0x74a7  (31 bytes)
DATA_salto_alto_dx_izq:
	defb 0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,080h	; 7488  ...............................

; ======================================================================
; CODIGO 0x74a7..0x7881  (986 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Cayendo: dos pixeles por cuadro, mirando que hay debajo y delante.
; ----------------------------------------------------------------------
cayendo:
	ld a,l			;74a7   ; y + 2
	add a,002h		;74a8
	ld l,a			;74aa
mira_al_caer:
	ld a,(0d90eh)		;74ab   ; D90E bit 0 a 0
	res 0,a		;74ae
	ld (0d90eh),a		;74b0
	push bc			;74b3
	push hl			;74b4
	ld a,d			;74b5   ; las casillas en la direccion D
	call casillas_alrededor		;74b6
	ld a,b			;74b9   ; la primera: 0x10 o menos, nada; 0x20-0x7F u 0xA0, choca
	and 0f0h		;74ba
	cp 010h		;74bc
	jr c,mira_al_caer_2		;74be
	jr z,mira_al_caer_2		;74c0
	cp 080h		;74c2
	jr c,choca_al_caer		;74c4
	cp 0a0h		;74c6
	jr z,choca_al_caer		;74c8
mira_al_caer_2:
	ld a,c			;74ca   ; la segunda, igual
	and 0f0h		;74cb
	cp 010h		;74cd
	jr c,mira_al_caer_3		;74cf
	jr z,mira_al_caer_3		;74d1
	cp 040h		;74d3
	jr c,choca_al_caer		;74d5
	cp 060h		;74d7
	jp c,choca_al_caer		;74d9
	cp 080h		;74dc
	jp c,choca_al_caer		;74de
	cp 0a0h		;74e1
	jr z,choca_al_caer		;74e3
mira_al_caer_3:
	ld a,d			;74e5   ; la tercera: 0x20-0x3F, 0x40-0x5F, 0x60-0x7F o 0xA0
	and 0f0h		;74e6
	cp 010h		;74e8
	jp c,nada_al_caer		;74ea
	jr z,nada_al_caer		;74ed
	cp 040h		;74ef
	jr c,pared_al_caer		;74f1
	cp 060h		;74f3
	jr c,cuesta_al_caer		;74f5
	cp 080h		;74f7
	jr c,cuesta_al_caer_b		;74f9
	cp 0a0h		;74fb
	jr z,pared_al_caer		;74fd
nada_al_caer:
	pop hl			;74ff
	pop bc			;7500
	jp aterriza		;7501
choca_al_caer:
	pop hl			;7504
	pop bc			;7505
vuelve_x_al_caer:
	ld a,(0d8fch)		;7506   ; la x de antes
	ld h,a			;7509
	ld a,(0d90eh)		;750a   ; D90E bit 0: ha chocado
	set 0,a		;750d
	ld (0d90eh),a		;750f
	jr aterriza		;7512
pared_al_caer:
	pop hl			;7514
	pop bc			;7515
	ld a,(0d8fdh)		;7516   ; en la misma fila de casillas: choca
	xor l			;7519
	and 0f0h		;751a
	jr z,vuelve_x_al_caer		;751c
	ld a,l			;751e   ; muy arriba (y < 3): p06:7856
	cp 003h		;751f
	jr nc,vuelve_x_al_caer		;7521
	jp en_el_suelo		;7523
cuesta_al_caer:
	pop hl			;7526
	pop bc			;7527
	cp 050h		;7528   ; 0x50: el arranque de la cuesta
	jr z,arranque_al_caer		;752a
	bit 3,c		;752c   ; hacia la derecha: choca
	jr nz,vuelve_x_al_caer		;752e
	jp aterriza		;7530
arranque_al_caer:
	ld a,l			;7533   ; en la mitad de abajo de la casilla...
	and 00fh		;7534
	cp 008h		;7536
	jp c,aterriza		;7538
	bit 3,c		;753b   ; ...hacia la derecha choca
	jp nz,vuelve_x_al_caer		;753d
	jp aterriza		;7540
cuesta_al_caer_b:
	pop hl			;7543
	pop bc			;7544
	cp 070h		;7545   ; 0x70: el arranque de la otra cuesta
	jr z,arranque_al_caer_b		;7547
	bit 2,c		;7549   ; hacia la izquierda: choca
	jr nz,vuelve_x_al_caer		;754b
	jp aterriza		;754d
arranque_al_caer_b:
	ld a,l			;7550   ; en la mitad de abajo...
	and 00fh		;7551
	cp 008h		;7553
	jp c,aterriza		;7555
	bit 2,c		;7558   ; ...hacia la izquierda choca
	jp nz,vuelve_x_al_caer		;755a
	jp aterriza		;755d

; ----------------------------------------------------------------------
; Al caer: si hay una escalera debajo se agarra a ella; si no, mira si
; cae sobre un actor (p07:80E6) y luego sobre que casilla aterriza.
; ----------------------------------------------------------------------
aterriza:
	push bc			;7560
	push hl			;7561
	inc l			;7562   ; tres pixeles mas abajo
	inc l			;7563
	inc l			;7564
	ld a,001h		;7565   ; las casillas de los pies
	call casillas_alrededor		;7567
	ld a,b			;756a   ; 0x80 y 0x90 en las dos primeras: escalera
	and 0f0h		;756b
	cp 080h		;756d
	jp nz,aterriza_2		;756f
	ld a,c			;7572
	and 0f0h		;7573
	cp 090h		;7575
	jp z,escalera_al_caer		;7577
aterriza_2:
	ld a,c			;757a   ; o en la segunda y la tercera
	and 0f0h		;757b
	cp 080h		;757d
	jp nz,sobre_actor		;757f
	ld a,d			;7582
	and 0f0h		;7583
	cp 090h		;7585
	jp nz,sobre_actor		;7587
	pop hl			;758a
	ld a,h			;758b   ; en los 6 ultimos pixeles de la casilla...
	and 00fh		;758c
	cp 00ah		;758e
	jr c,mira_actor_debajo		;7590
	ld a,h			;7592   ; ...la de la derecha
	add a,010h		;7593
	ld h,a			;7595
	jr agarra_al_caer		;7596
escalera_al_caer:
	pop hl			;7598
	ld a,h			;7599   ; en los 6 primeros pixeles
	and 00fh		;759a
	cp 006h		;759c
	jr nc,mira_actor_debajo		;759e
	ld a,0e1h		;75a0   ; (este `ld a,0xE1` se pisa enseguida)
agarra_al_caer:
	pop bc			;75a2
	ld a,h			;75a3   ; x al principio de la casilla
	and 0f0h		;75a4
	ld h,a			;75a6
	ld a,b			;75a7   ; la pose de trepar, conservando los bits 0 y 5
	and 021h		;75a8
	or 004h		;75aa
	ld b,a			;75ac
	ld a,020h		;75ad   ; en la escalera
	ld (0d90dh),a		;75af
	ld a,(0d90fh)		;75b2   ; D90F bit 0 a 0
	res 0,a		;75b5
	ld (0d90fh),a		;75b7   ; bit 7 muerto, bit 4 un rato sin mandos = a
	jp coloca_jugador		;75ba
sobre_actor:
	pop hl			;75bd
mira_actor_debajo:
	push hl			;75be
	ld a,l			;75bf   ; el punto de debajo de los pies: (x + 16, y + 16)
	add a,010h		;75c0
	ld l,a			;75c2
	ld a,h			;75c3
	add a,010h		;75c4
	ld h,a			;75c6
	ld a,004h		;75c7   ; hay un actor ahi? (p07:80E6)
	call 080e6h		;75c9
	or a			;75cc   ; 0: no
	jr z,mira_casillas_debajo		;75cd
	cp 020h		;75cf   ; menos de 0x20: se queda encima
	jp c,coloca_pop		;75d1
mira_casillas_debajo:
	pop hl			;75d4
	pop bc			;75d5
	xor a			;75d6   ; D911 cuenta las casillas de clase 0x10 que pisa
	ld (0d911h),a		;75d7
	push bc			;75da
	push hl			;75db
	ld a,004h		;75dc   ; las tres de debajo
	call casillas_alrededor		;75de
	ld a,b			;75e1   ; la primera: menos de 0x10, nada
	and 0f0h		;75e2
	cp 010h		;75e4
	jr c,mira_casillas_2		;75e6
	call z,cuenta_casilla_10		;75e8   ; 0x10: una mas (p06:789F)
	jr z,mira_casillas_2		;75eb
	cp 040h		;75ed   ; 0x20-0x3F u 0xA0: suelo (p06:76F4)
	jp c,suelo_primera		;75ef
	cp 060h		;75f2   ; 0x40-0x5F: cuesta (p06:773D)
	jp c,cae_en_arranque		;75f4
	cp 080h		;75f7   ; 0x60-0x7F: la otra cuesta (p06:7769)
	jp c,cae_en_cuesta_c		;75f9
	cp 0a0h		;75fc
	jp z,suelo_primera		;75fe
mira_casillas_2:
	ld a,c			;7601   ; la segunda
	and 0f0h		;7602
	cp 010h		;7604
	jp c,mira_casillas_3		;7606
	call z,cuenta_casilla_10		;7609
	jr z,mira_casillas_3		;760c
	cp 040h		;760e   ; 0x20-0x3F u 0xA0: suelo
	jp c,suelo_segunda		;7610
	cp 060h		;7613   ; 0x40-0x5F: p06:77C4
	jp c,cuesta_e		;7615
	cp 080h		;7618   ; 0x60-0x7F: p06:77B9
	jp c,cuesta_d		;761a
	cp 0a0h		;761d
	jp z,suelo_segunda		;761f
mira_casillas_3:
	ld a,d			;7622   ; la tercera: menos de 0x10, sigue cayendo
	and 0f0h		;7623
	cp 010h		;7625
	jp c,coloca_pop		;7627
	call z,cuenta_casilla_10		;762a   ; 0x10: p06:77E1
	jp z,casilla_10		;762d
	cp 040h		;7630   ; 0x20-0x3F u 0xA0: p06:7645
	jp c,suelo_tercera		;7632
	cp 060h		;7635   ; 0x40-0x5F: p06:7663
	jr c,cae_en_cuesta		;7637
	cp 080h		;7639   ; 0x60-0x7F: p06:76AE
	jr c,cae_en_cuesta_b		;763b
	cp 0a0h		;763d
	jp z,suelo_tercera		;763f
	jp coloca_pop		;7642
suelo_tercera:
	pop hl			;7645
	push hl			;7646
	ld a,l			;7647   ; 8 pixeles mas arriba...
	sub 008h		;7648
	ld l,a			;764a
	ld a,004h		;764b
	call casillas_alrededor		;764d   ; ...tiene que haber un 0x70 en la tercera
	ld a,d			;7650
	and 0f0h		;7651
	cp 070h		;7653
	jp nz,en_el_suelo_pop		;7655
	pop hl			;7658
	pop bc			;7659
	ld a,l			;765a   ; y la casilla + 8
	and 0f0h		;765b
	add a,008h		;765d
	ld e,a			;765f
	jp y_de_cuesta_b		;7660
cae_en_cuesta:
	pop hl			;7663
	pop bc			;7664
	cp 040h		;7665   ; 0x40 exacta
	jr z,cuesta_arriba		;7667
cuesta_mitad:
	ld a,l			;7669   ; E = y de la casilla + 8
	and 0f0h		;766a
	add a,008h		;766c
	ld e,a			;766e
	jr y_de_cuesta		;766f
cuesta_arriba:
	ld a,l			;7671   ; E = y de la casilla
	and 0f0h		;7672
	ld e,a			;7674
y_de_cuesta:
	ld a,h			;7675   ; D = E + (x & 0x0F) / 2 - 8: la altura de la cuesta en esa x
	and 00fh		;7676
	sra a		;7678
	sub 008h		;767a
	add a,e			;767c
	ld d,a			;767d
	sub 002h		;767e   ; aun no la toca: sigue cayendo
	cp l			;7680
	jp nc,coloca_jugador		;7681
	ld a,(0d90eh)		;7684   ; D90E: solo el bit 6
	and 040h		;7687
	ld (0d90eh),a		;7689
	ld a,010h		;768c   ; D90D = 0x10: en la cuesta
	ld (0d90dh),a		;768e
	ld a,(0d90fh)		;7691   ; D90F bit 0 a 0
	res 0,a		;7694
	ld (0d90fh),a		;7696   ; bit 7 muerto, bit 4 un rato sin mandos = a
	exx			;7699
	ld hl,0d928h		;769a   ; suceso del bit 1: efecto 4 (al tocar suelo)
	set 1,(hl)		;769d
	exx			;769f
pone_en_cuesta:
	ld l,d			;76a0   ; y = la de la cuesta
	ld a,e			;76a1
	ld (0d908h),a		;76a2   ; D908 = E
	ld a,h			;76a5   ; D907 = x de la casilla
	and 0f0h		;76a6
	ld (0d907h),a		;76a8
	jp coloca_jugador		;76ab
cae_en_cuesta_b:
	pop hl			;76ae
	pop bc			;76af
	cp 070h		;76b0   ; 0x70 exacta: E = casilla + 0x18
	jr z,cuesta_b_alta		;76b2
	ld a,l			;76b4   ; si no, casilla + 0x10
	and 0f0h		;76b5
	add a,010h		;76b7
	ld e,a			;76b9
	jr y_de_cuesta_b		;76ba
cuesta_b_alta:
	ld a,l			;76bc
	and 0f0h		;76bd
	add a,018h		;76bf
	ld e,a			;76c1
y_de_cuesta_b:
	ld a,h			;76c2   ; D = E - (x & 0x0F) / 2 - 1
	and 00fh		;76c3
	srl a		;76c5
	neg		;76c7
	dec a			;76c9
	add a,e			;76ca
	ld d,a			;76cb
	sub 002h		;76cc   ; aun no la toca
	cp l			;76ce
	jp nc,coloca_jugador		;76cf
	ld a,(0d90eh)		;76d2
	and 040h		;76d5
	ld (0d90eh),a		;76d7
	ld a,014h		;76da   ; D90D = 0x14: en la cuesta del otro lado
	ld (0d90dh),a		;76dc
	ld a,(0d90fh)		;76df   ; a = bit 7 muerto, bit 4 un rato sin mandos
	res 0,a		;76e2
	ld (0d90fh),a		;76e4   ; bit 7 muerto, bit 4 un rato sin mandos = a
	exx			;76e7
	ld hl,0d928h		;76e8   ; suceso del bit 1
	set 1,(hl)		;76eb
	exx			;76ed
	jp pone_en_cuesta		;76ee
suelo_segunda:
	jp en_el_suelo_pop		;76f1
suelo_primera:
	ld a,c			;76f4   ; la segunda: menos de 0x20 o 0x80+: mira la tercera
	and 0f0h		;76f5
	cp 020h		;76f7
	jr c,suelo_tercera_b		;76f9
	cp 0a0h		;76fb   ; 0xA0: aterriza
	jp z,en_el_suelo_pop		;76fd
	cp 080h		;7700
	jr nc,suelo_tercera_b		;7702
	cp 040h		;7704   ; 0x40 justo detras: la cuesta
	jp nz,en_el_suelo_pop		;7706
sobre_cuesta:
	pop hl			;7709
	pop bc			;770a
	jp cuesta_mitad		;770b
suelo_tercera_b:
	ld a,d			;770e   ; la tercera: 0x20-0x7F u 0xA0, aterriza
	and 0f0h		;770f
	cp 020h		;7711
	jr c,mira_arranque		;7713
	cp 080h		;7715
	jp c,en_el_suelo_pop		;7717
	cp 0a0h		;771a
	jp z,en_el_suelo_pop		;771c
mira_arranque:
	pop hl			;771f
	pop bc			;7720
	push bc			;7721
	push hl			;7722
	ld a,l			;7723   ; 16 pixeles mas arriba...
	sub 010h		;7724
	ld l,a			;7726
	ld a,004h		;7727
	call casillas_alrededor		;7729   ; ...la primera tiene que ser 0x50
	ld a,b			;772c
	and 0f0h		;772d
	cp 050h		;772f
	jp nz,en_el_suelo_pop		;7731
	ld a,l			;7734   ; E = casilla + 0x10
	and 0f0h		;7735
	add a,010h		;7737
	ld e,a			;7739
	jp sobre_cuesta		;773a
cae_en_arranque:
	cp 050h		;773d   ; 0x50: el arranque de la cuesta
	jr z,arranque_a		;773f
	pop hl			;7741
	pop bc			;7742
	ld a,h			;7743   ; mitad derecha o izquierda de la casilla
	and 00fh		;7744
	cp 008h		;7746
	jp nc,cuesta_e_mitad		;7748
	jp cuesta_e_alta		;774b
arranque_a:
	pop hl			;774e
	pop bc			;774f
	ld a,h			;7750   ; mitad izquierda: E = casilla + 0x10...
	and 00fh		;7751
	cp 008h		;7753
	jr c,arranque_b		;7755
	ld a,l			;7757
	and 0f0h		;7758
	add a,010h		;775a
	ld e,a			;775c
	jp y_de_cuesta		;775d
arranque_b:
	ld a,l			;7760   ; ...mitad derecha: + 0x18
	and 0f0h		;7761
	add a,018h		;7763
	ld e,a			;7765
	jp y_de_cuesta		;7766
cae_en_cuesta_c:
	ld a,c			;7769   ; la segunda: 0x20-0x3F u 0xA0, aterriza
	and 0f0h		;776a
	cp 020h		;776c
	jr c,cuesta_c_2		;776e
	cp 040h		;7770
	jp c,en_el_suelo_pop		;7772
	cp 0a0h		;7775
	jp z,en_el_suelo_pop		;7777
	cp 080h		;777a
	jr nc,cuesta_c_2		;777c
	ld a,b			;777e   ; la primera era 0x60 exacta?
	pop hl			;777f
	pop bc			;7780
	and 0f0h		;7781
	cp 060h		;7783
	jr z,cuesta_c_60		;7785
	ld a,h			;7787   ; mitad de la casilla
	and 00fh		;7788
	cp 008h		;778a
	jr nc,cuesta_c_alta		;778c
	jr cuesta_c_mitad		;778e
cuesta_c_60:
	ld a,h			;7790
	and 00fh		;7791
	cp 008h		;7793
	jr nc,cuesta_c_mitad		;7795
cuesta_c_alta:
	ld a,l			;7797   ; E = casilla + 0x10
	and 0f0h		;7798
	add a,010h		;779a
	ld e,a			;779c
	jp y_de_cuesta_b		;779d
cuesta_c_mitad:
	ld a,l			;77a0   ; E = casilla + 8
	and 0f0h		;77a1
	add a,008h		;77a3
	ld e,a			;77a5
	jp y_de_cuesta_b		;77a6
cuesta_c_2:
	ld a,b			;77a9
	and 0f0h		;77aa
	pop hl			;77ac
	pop bc			;77ad
	cp 060h		;77ae   ; 0x60: E = la casilla
	jr nz,cuesta_c_mitad		;77b0
	ld a,l			;77b2
	and 0f0h		;77b3
	ld e,a			;77b5
	jp y_de_cuesta_b		;77b6
cuesta_d:
	ld a,c			;77b9
	and 0f0h		;77ba
	pop hl			;77bc
	pop bc			;77bd
	cp 060h		;77be   ; 0x60 exacta?
	jr z,cuesta_c_mitad		;77c0
	jr cuesta_c_alta		;77c2
cuesta_e:
	ld a,c			;77c4
	and 0f0h		;77c5
	pop hl			;77c7
	pop bc			;77c8
	cp 040h		;77c9   ; 0x40 exacta?
	jr z,cuesta_e_mitad		;77cb
	jr cuesta_e_alta		;77cd
cuesta_e_alta:
	ld a,l			;77cf   ; E = casilla + 0x10
	and 0f0h		;77d0
	add a,010h		;77d2
	ld e,a			;77d4
	jp y_de_cuesta		;77d5
cuesta_e_mitad:
	ld a,l			;77d8   ; E = casilla + 8
	and 0f0h		;77d9
	add a,008h		;77db
	ld e,a			;77dd
	jp y_de_cuesta		;77de

; ----------------------------------------------------------------------
; Pisa una casilla de clase 0x10 con la tercera: si esta en la mitad de
; abajo y no esta ya en un apuro (D90F bits 6 y 4), p06:7818.
; ----------------------------------------------------------------------
casilla_10:
	pop hl			;77e1
	pop bc			;77e2
	ld a,l			;77e3   ; en los 10 primeros pixeles de la casilla: nada
	and 00fh		;77e4
	cp 00ah		;77e6
	jp c,coloca_jugador		;77e8
	ld a,(0d90fh)		;77eb   ; D90F bit 6: nada
	bit 6,a		;77ee
	ret nz			;77f0
	bit 4,a		;77f1   ; bit 4: p06:77FB
	jr nz,casilla_10_salta		;77f3
	ld d,010h		;77f5   ; D = 0x10
	call dano		;77f7
	ret			;77fa
casilla_10_salta:
	ld a,(0d573h)		;77fb   ; con D90F bit 4, el boton 2...
	bit 5,a		;77fe
	ret z			;7800
	ld c,a			;7801   ; ...le hace saltar desde ahi:
	xor a			;7802   ; D90D a 0
	ld (0d90dh),a		;7803
	ld a,(0d90fh)		;7806   ; D90F bit 0 a 0
	res 0,a		;7809
	ld (0d90fh),a		;780b   ; bit 7 muerto, bit 4 un rato sin mandos = a
	exx			;780e
	ld hl,0d928h		;780f   ; suceso del bit 1
	set 1,(hl)		;7812
	exx			;7814
	jp salta		;7815

; ----------------------------------------------------------------------
; DANO: le quita D de vida. Si ya esta tocado (D90F bit 6) o sin mandos
; (bit 4), nada. Si no, se marca tocado durante 0x50 cuadros (D913) con el
; efecto 5; con D910 bit 7 no pierde vida; si la vida llega a 0, muere
; (D90F bit 7) con el efecto 0x11.
; ----------------------------------------------------------------------
dano:
	ld a,(0d90fh)		;7818   ; a = bit 7 muerto, bit 4 un rato sin mandos
	bit 6,a		;781b   ; ya tocado: nada
	ret nz			;781d
	bit 4,a		;781e   ; sin mandos: nada
	ret nz			;7820
	set 4,a		;7821   ; tocado y sin mandos...
	set 6,a		;7823
	ld (0d90fh),a		;7825   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,050h		;7828   ; ...durante 0x50 cuadros
	ld (0d913h),a		;782a   ; cuenta del estado del jugador = a
	exx			;782d
	ld hl,0d929h		;782e   ; sucesos de D929: bits 7 y 6 (efecto 5)
	set 7,(hl)		;7831
	set 6,(hl)		;7833
	exx			;7835
	ld a,(0d910h)		;7836   ; D910 bit 7: no pierde vida
	bit 7,a		;7839
	ret nz			;783b
	ld a,(0d91ch)		;783c   ; vida - D...
	sub d			;783f
	ld (0d91ch),a		;7840   ; la vida de Rastan = a
	jr z,muere		;7843   ; ...0 justo: muere
	ret nc			;7845   ; aun le queda
muere:
	exx			;7846
	set 5,(hl)		;7847   ; suceso D929 bit 5: efecto 0x11
	exx			;7849
	xor a			;784a   ; vida a 0
	ld (0d91ch),a		;784b   ; la vida de Rastan = a
	ld hl,0d90fh		;784e   ; D90F bit 7: muerto
	set 7,(hl)		;7851
	ret			;7853
en_el_suelo_pop:
	pop hl			;7854
	pop bc			;7855
en_el_suelo:
	ld a,l			;7856   ; y al principio de la casilla
	and 0f0h		;7857
	ld l,a			;7859
	ld a,h			;785a   ; coloca a Rastan
	ld (0d8fch),a		;785b   ; la x de Rastan = a
	ld a,l			;785e
	ld (0d8fdh),a		;785f   ; la y de Rastan = a
	xor a			;7862   ; D90D a 0: de pie
	ld (0d90dh),a		;7863
	ld a,(0d90fh)		;7866   ; D90F bit 0 a 0
	res 0,a		;7869
	ld (0d90fh),a		;786b   ; bit 7 muerto, bit 4 un rato sin mandos = a
	exx			;786e
	ld hl,0d928h		;786f   ; suceso del bit 1 (efecto 4)
	set 1,(hl)		;7872
	exx			;7874
	ret			;7875
coloca_pop:
	pop hl			;7876
	pop bc			;7877
coloca_jugador:
	ld a,h			;7878   ; x = H
	ld (0d8fch),a		;7879   ; la x de Rastan = a
	ld a,l			;787c   ; y = L
	ld (0d8fdh),a		;787d   ; la y de Rastan = a
	ret			;7880

; ----------------------------------------------------------------------
; DATOS resto_7881: cinco bytes que nadie ejecuta (`ld a,b / and 0xE1 / jr`)
;   0x7881..0x7886  (5 bytes)
DATA_resto_7881:
	defb 078h,0e6h,0e1h,018h,014h	; 7881

; ======================================================================
; CODIGO 0x7886..0x78d1  (75 bytes)
; ======================================================================


orienta:
	ld a,(0d90dh)		;7886   ; en una cuesta no cambia de lado
	bit 4,a		;7889
	jp nz,guarda_pose		;788b
	bit 3,c		;788e   ; derecha: mira a la derecha (bit 0 = 0)
	jr z,L_7894		;7890
	res 0,b		;7892
L_7894:
	bit 2,c		;7894   ; izquierda: mira a la izquierda (bit 0 = 1)
	jr z,guarda_pose		;7896
	set 0,b		;7898
guarda_pose:
	ld a,b			;789a   ; la pose nueva
	ld (0d904h),a		;789b   ; la pose de Rastan = a
	ret			;789e
cuenta_casilla_10:
	push af			;789f   ; D911 + 1, sin tocar A ni las banderas
	ld a,(0d911h)		;78a0
	inc a			;78a3
	ld (0d911h),a		;78a4
	pop af			;78a7
	ret			;78a8

; ----------------------------------------------------------------------
; Lee lo que hay alrededor de (H, L): en B, C y D, el byte alto de tres
; casillas seguidas del mapa de delante (D774), la clase de la casilla. La
; direccion A elige cuales: 1 encima, 2 a la derecha, 4 debajo, 8 a la
; izquierda. Fuera de la pantalla devuelve 0xA0 en las tres.
; ----------------------------------------------------------------------
casillas_alrededor:
	push af			;78a9
	ld a,l			;78aa   ; y - 16
	sub 010h		;78ab
	ld l,a			;78ad
	ld a,h			;78ae   ; por la derecha de x = 0xF0: p06:7975
	cp 0f0h		;78af
	jp nc,casillas_borde		;78b1
	pop af			;78b4
	bit 1,a		;78b5   ; 2: a la derecha
	jp nz,a_la_derecha		;78b7
	bit 2,a		;78ba   ; 4: debajo
	jp nz,debajo		;78bc
	bit 3,a		;78bf   ; 8: a la izquierda
	jp nz,a_la_izquierda		;78c1
	ex af,af'			;78c4   ; 1: encima...
	ld a,l			;78c5   ; ...la fila de y - 0x0C
	sub 00ch		;78c6
	and 0f0h		;78c8
	cp 0c0h		;78ca   ; por debajo de la fila 12: fuera
	jr c,$+9		;78cc
	jp fuera_de_pantalla		;78ce

; ----------------------------------------------------------------------
; DATOS resto_78D1: cuatro bytes que nadie ejecuta (`sub 0x10 / jr`)
;   0x78d1..0x78d5  (4 bytes)
DATA_resto_78D1:
	defb 0d6h,010h,018h,0f5h	; 78d1

; ======================================================================
; CODIGO 0x78d5..0x8000  (1835 bytes)
; ======================================================================


fila_de_encima:
	ld b,000h		;78d5   ; BC = la fila (y & 0xF0) / 8 * 2...
	ld c,a			;78d7
	ld e,a			;78d8
	ld a,h			;78d9   ; ...mas la columna: x / 16 * 2
	ld d,a			;78da
	and 0f0h		;78db
	rra			;78dd
	rra			;78de
	rra			;78df
	ld l,a			;78e0
	ld h,000h		;78e1
	add hl,bc			;78e3
	add hl,bc			;78e4
	ld bc,0d774h		;78e5   ; en D774...
	add hl,bc			;78e8
	inc hl			;78e9   ; ...el byte alto de la palabra
	ex af,af'			;78ea
	bit 0,a		;78eb   ; A' bit 0 = 0 (la fila salio de pantalla): 0xA0
	jp nz,tres_casillas		;78ed
	ld bc,0a0a0h		;78f0
	ld de,0a0a0h		;78f3
	ret			;78f6
tres_casillas:
	ld a,d			;78f7   ; la casilla...
	ld b,(hl)			;78f8
	inc hl			;78f9
	inc hl			;78fa   ; ...la de su derecha...
	ld c,(hl)			;78fb
	inc hl			;78fc
	inc hl			;78fd   ; ...y la siguiente
	ld d,(hl)			;78fe
	and 00fh		;78ff   ; en la mitad izquierda de la casilla...
	cp 008h		;7901
	jr nc,mitad_derecha		;7903
	ld d,c			;7905   ; ...la tercera es la segunda
	ret			;7906
mitad_derecha:
	ld b,c			;7907   ; en la derecha, la primera es la segunda
	ret			;7908
fuera_de_pantalla:
	ld bc,0a0a0h		;7909   ; 0xA0 en las tres
	ld de,0a0a0h		;790c
	ret			;790f
a_la_derecha:
	ld a,l			;7910   ; y - 16, la fila...
	sub 010h		;7911
	ld e,a			;7913
	and 0f0h		;7914
	ld b,000h		;7916
	ld c,a			;7918
	ld a,h			;7919   ; ...la columna de x + 0x18
	add a,018h		;791a
columna:
	and 0f0h		;791c
	ld d,a			;791e
	rra			;791f
	rra			;7920
	rra			;7921
	ld l,a			;7922
	ld h,000h		;7923
	ld a,e			;7925   ; por debajo de y = 0xA0: fuera
	cp 0a0h		;7926
	jr nc,fuera_de_pantalla		;7928
	add hl,bc			;792a
	add hl,bc			;792b
	ld bc,0d774h		;792c   ; en D774
	add hl,bc			;792f
	inc hl			;7930
	ld a,e			;7931   ; tres casillas en columna:
	ld b,(hl)			;7932   ; la de arriba...
	ld de,00020h		;7933   ; ...la de debajo (una fila son 0x20 bytes)...
	add hl,de			;7936
	ld c,(hl)			;7937
	and 00fh		;7938   ; ...y si no esta justo en la fila, la otra
	jr z,L_793D		;793a
	add hl,de			;793c
L_793D:
	ld d,(hl)			;793d
	cp 00ch		;793e   ; en la parte de abajo de la casilla...
	ret c			;7940
	ld b,c			;7941   ; ...la primera es la segunda
	ret			;7942
debajo:
	ld a,l			;7943   ; la fila de y + 0x10...
	add a,010h		;7944
	and 0f0h		;7946
	cp 0c0h		;7948   ; ...sin pasar de la 11
	jr c,fila_de_debajo		;794a
	sub 010h		;794c
fila_de_debajo:
	ld b,000h		;794e
	ld c,a			;7950
	ld e,a			;7951
	ld a,h			;7952
	ld d,a			;7953
	and 0f0h		;7954
	rra			;7956
	rra			;7957
	rra			;7958
	ld l,a			;7959
	ld h,000h		;795a
	add hl,bc			;795c
	add hl,bc			;795d
	ld bc,0d774h		;795e   ; en D774
	add hl,bc			;7961
	inc hl			;7962
	jp tres_casillas		;7963
a_la_izquierda:
	ld a,l			;7966   ; y - 16, la columna de x + 8
	sub 010h		;7967
	ld e,a			;7969
	and 0f0h		;796a
	ld b,000h		;796c
	ld c,a			;796e
	ld a,h			;796f
	add a,008h		;7970
	jp columna		;7972

; ----------------------------------------------------------------------
; Lo mismo cuando x esta por la derecha de 0xF0 (la ultima columna).
; ----------------------------------------------------------------------
casillas_borde:
	pop af			;7975
	bit 1,a		;7976   ; 2: a la derecha
	jp nz,a_la_derecha		;7978
	bit 2,a		;797b   ; 4: debajo
	jp nz,debajo_b		;797d
	bit 3,a		;7980   ; 8: a la izquierda
	jp nz,a_la_izquierda_b		;7982
	ex af,af'			;7985   ; 1: encima
	ld a,l			;7986
	sub 00ch		;7987
	and 0f0h		;7989
fila_valida:
	cp 0c0h		;798b   ; de la 12 para abajo, una menos
	jr c,fila_de_encima_b		;798d
	sub 010h		;798f
	jr fila_valida		;7991
fila_de_encima_b:
	ld b,000h		;7993
	ld c,a			;7995
	ld e,a			;7996
	ld a,h			;7997
	ld d,a			;7998
	add a,010h		;7999   ; la columna de x + 0x10
	and 0f0h		;799b
	rra			;799d
	rra			;799e
	rra			;799f
	ld l,a			;79a0
	ld h,000h		;79a1
	add hl,bc			;79a3
	add hl,bc			;79a4
	ld bc,0d774h		;79a5   ; en D774
	add hl,bc			;79a8
	inc hl			;79a9
	ex af,af'			;79aa
	bit 0,a		;79ab
	jp nz,dos_casillas		;79ad
	ld bc,0a0a0h		;79b0
	ld de,0a0a0h		;79b3
	ret			;79b6
dos_casillas:
	ld a,d			;79b7
	ld b,(hl)			;79b8   ; la casilla, dos veces...
	ld c,b			;79b9
	inc hl			;79ba
	inc hl			;79bb
	ld d,(hl)			;79bc   ; ...y la de al lado
	and 00fh		;79bd
	cp 008h		;79bf
	ret nc			;79c1
	ld d,c			;79c2
	ret			;79c3
debajo_b:
	ld a,l			;79c4
	add a,010h		;79c5
	and 0f0h		;79c7
fila_valida_b:
	cp 0c0h		;79c9
	jr c,fila_de_debajo_b		;79cb
	sub 010h		;79cd
	jr fila_valida_b		;79cf
fila_de_debajo_b:
	ld b,000h		;79d1
	ld c,a			;79d3
	ld e,a			;79d4
	ld a,h			;79d5
	ld d,a			;79d6
	add a,010h		;79d7
	and 0f0h		;79d9
	rra			;79db
	rra			;79dc
	rra			;79dd
	ld l,a			;79de
	ld h,000h		;79df
	add hl,bc			;79e1
	add hl,bc			;79e2
	ld bc,0d774h		;79e3   ; en D774
	add hl,bc			;79e6
	inc hl			;79e7
	jp dos_casillas		;79e8
a_la_izquierda_b:
	ld a,l			;79eb
	sub 010h		;79ec
	ld e,a			;79ee
	and 0f0h		;79ef
	ld b,000h		;79f1
	ld c,a			;79f3
	ld a,h			;79f4
	add a,008h		;79f5   ; la columna de x + 8...
	cp 0f0h		;79f7   ; ...si aun cabe, como siempre
	jp c,columna		;79f9
	and 0f0h		;79fc   ; si no, la de mas alla
	add a,010h		;79fe
	ld d,a			;7a00
	rra			;7a01
	rra			;7a02
	rra			;7a03
	ld l,a			;7a04
	ld h,000h		;7a05
	ld a,e			;7a07
	cp 0a0h		;7a08   ; por debajo de y = 0xA0: fuera
	jp nc,fuera_de_pantalla		;7a0a
	add hl,bc			;7a0d
	add hl,bc			;7a0e
	ld bc,0d774h		;7a0f   ; en D774
	add hl,bc			;7a12
	inc hl			;7a13
	ld a,e			;7a14
	ld b,(hl)			;7a15   ; tres casillas en columna
	ld de,00020h		;7a16
	add hl,de			;7a19
	ld c,(hl)			;7a1a
	and 00fh		;7a1b
	jr z,L_7A20		;7a1d
	add hl,de			;7a1f
L_7A20:
	ld d,(hl)			;7a20
	cp 00ch		;7a21
	ret c			;7a23
	ld b,c			;7a24
	ret			;7a25

; ----------------------------------------------------------------------
; La pose de Rastan segun lo que esta haciendo: bits 1-4 de D904 (E) y
; el bit 0, hacia donde mira (D).
; ----------------------------------------------------------------------
elige_pose:
	ld a,(0d90dh)		;7a26   ; B = D90D
	ld b,a			;7a29
	ld a,(0d90eh)		;7a2a   ; C = D90E
	ld c,a			;7a2d
	ld a,(0d904h)		;7a2e   ; D = hacia donde mira
	and 001h		;7a31
	ld d,a			;7a33
	ld e,000h		;7a34   ; E = la pose (0 = quieto)
	ld a,(0d573h)		;7a36   ; H = los mandos
	ld h,a			;7a39
	ld a,(0d90fh)		;7a3a   ; L = D90F bit 5 (la accion del boton 1)
	and 020h		;7a3d
	ld l,a			;7a3f
	bit 3,h		;7a40   ; derecha?
	jr nz,pose_derecha		;7a42
	bit 2,h		;7a44   ; izquierda: mira a la izquierda y anda (2)
	jr z,pose_segun_estado		;7a46
	res 0,d		;7a48
	ld e,002h		;7a4a
	jr pose_segun_estado		;7a4c
pose_derecha:
	bit 2,h		;7a4e   ; las dos: nada
	jr nz,pose_segun_estado		;7a50
	set 0,d		;7a52   ; derecha: mira a la derecha y anda (2)
	ld e,002h		;7a54
pose_segun_estado:
	ld a,(0d90fh)		;7a56   ; a = bit 7 muerto, bit 4 un rato sin mandos
	bit 3,a		;7a59   ; agarrado: p06:7ABD
	jp nz,pose_trepando		;7a5b
	bit 7,b		;7a5e   ; en el aire: p06:7A82
	jr nz,pose_en_el_aire		;7a60
	bit 5,b		;7a62   ; en la escalera: p06:7ABD
	jr nz,pose_trepando		;7a64
	bit 4,b		;7a66   ; en una cuesta: p06:7ACE
	jr nz,pose_en_cuesta		;7a68
	bit 0,h		;7a6a   ; arriba: p06:7A78
	jr nz,pose_arriba		;7a6c
	bit 1,h		;7a6e   ; abajo: pose 4
	jp z,pon_pose		;7a70
	ld e,004h		;7a73
	jp pon_pose		;7a75
pose_arriba:
	bit 5,l		;7a78   ; arriba con la accion del boton 1: pose 0x10
	jp z,pon_pose		;7a7a
	ld e,010h		;7a7d
	jp pon_pose		;7a7f
pose_en_el_aire:
	bit 6,b		;7a82   ; cayendo o bajando: p06:7A9C
	jr nz,pose_bajando		;7a84
	bit 1,b		;7a86
	jr nz,pose_bajando		;7a88
	bit 5,l		;7a8a   ; subiendo, sin la accion: pose 8
	jr nz,pose_aire_accion		;7a8c
	ld e,008h		;7a8e
	jp pon_pose		;7a90
pose_aire_accion:
	bit 0,h		;7a93   ; con arriba: pose 0x12
	jr nz,pose_12		;7a95
	ld e,008h		;7a97   ; si no, 8
	jp pon_pose		;7a99
pose_bajando:
	bit 5,l		;7a9c   ; sin la accion: 8
	jr nz,pose_bajando_accion		;7a9e
	ld e,008h		;7aa0
	jp pon_pose		;7aa2
pose_bajando_accion:
	ld e,008h		;7aa5
	bit 1,h		;7aa7   ; sin abajo: como subiendo
	jr z,pose_aire_accion		;7aa9
	ld e,014h		;7aab   ; con abajo: pose 0x14...
	ld a,(0d90fh)		;7aad   ; ...y D90F bit 0
	set 0,a		;7ab0
	ld (0d90fh),a		;7ab2   ; bit 7 muerto, bit 4 un rato sin mandos = a
	jp pon_pose		;7ab5
pose_12:
	ld e,012h		;7ab8
	jp pon_pose		;7aba
pose_trepando:
	ld a,(0d90fh)		;7abd   ; D90F bit 1 (se esta moviendo): pose 0x0A; quieto: 6
	bit 1,a		;7ac0
	jr nz,pose_0a		;7ac2
	ld e,006h		;7ac4
	jp pon_pose		;7ac6
pose_0a:
	ld e,00ah		;7ac9
	jp pon_pose		;7acb
pose_en_cuesta:
	bit 5,l		;7ace   ; con la accion y arriba: p06:7AF6
	jr z,pose_cuesta		;7ad0
	bit 0,h		;7ad2
	jr nz,pose_cuesta_accion		;7ad4
pose_cuesta:
	bit 2,b		;7ad6   ; el lado de la cuesta y hacia donde mira eligen 0x0C o 0x0E
	jr nz,pose_cuesta_b		;7ad8
	bit 0,d		;7ada
	jr nz,pose_0c		;7adc
	ld e,00eh		;7ade
	jp pon_pose		;7ae0
pose_0c:
	ld e,00ch		;7ae3
	jp pon_pose		;7ae5
pose_cuesta_b:
	bit 0,d		;7ae8
	jr nz,pose_0e		;7aea
	ld e,00ch		;7aec
	jp pon_pose		;7aee
pose_0e:
	ld e,00eh		;7af1
	jp pon_pose		;7af3
pose_cuesta_accion:
	bit 2,b		;7af6   ; lo mismo con 0x16 y 0x18
	jr nz,pose_cuesta_accion_b		;7af8
	bit 0,d		;7afa
	jr nz,pose_16		;7afc
	ld e,018h		;7afe
	jp pon_pose		;7b00
pose_16:
	ld e,016h		;7b03
	jp pon_pose		;7b05
pose_cuesta_accion_b:
	bit 0,d		;7b08
	jr nz,pose_18		;7b0a
	ld e,016h		;7b0c
	jp pon_pose		;7b0e
pose_18:
	ld e,018h		;7b11
	jp pon_pose		;7b13
pon_pose:
	ld a,(0d90fh)		;7b16   ; D90F bit 6 (tocado) + lado + pose + accion (bit 5)
	and 040h		;7b19
	or d			;7b1b
	or e			;7b1c
	or l			;7b1d
	ld (0d904h),a		;7b1e   ; la pose
	ret			;7b21

; ----------------------------------------------------------------------
; EL ATAQUE. Con la pose de ataque (bit 5) calcula donde da el golpe segun
; la pose, el cuadro de la animacion y el arma (D919), y resta su fuerza a
; la vida (+0F) de los actores que toca. El arma 3 ademas suelta un disparo
; (la ficha 10, D922/D924) que avanza 3 pixeles por cuadro.
; ----------------------------------------------------------------------
ataque:
	ld a,(0d8fdh)		;7b22   ; HL = (x, y) de Rastan
	ld l,a			;7b25
	ld a,(0d8fch)		;7b26   ; a = la x de Rastan
	ld h,a			;7b29
	ld a,(0d8feh)		;7b2a   ; C = el cuadro de la animacion + 1
	inc a			;7b2d
	ld c,a			;7b2e
	ld a,(0d904h)		;7b2f   ; B = la pose
	ld b,a			;7b32
	bit 5,b		;7b33   ; sin ataque: solo el disparo (p06:7FD3)
	jp z,sin_ataque		;7b35
	and 01eh		;7b38   ; poses 0x10, 0x12, 0x16 y 0x18: hacia arriba (p06:7C2B)
	cp 010h		;7b3a
	jp z,golpe_arriba		;7b3c
	cp 012h		;7b3f
	jp z,golpe_arriba		;7b41
	cp 016h		;7b44
	jp z,golpe_arriba		;7b46
	cp 018h		;7b49
	jp z,golpe_arriba		;7b4b
	cp 014h		;7b4e   ; pose 0x14: hacia abajo (p06:7C4F)
	jp z,golpe_abajo		;7b50
	cp 004h		;7b53   ; pose 4 (agachado): el golpe 12 pixeles mas abajo
	jr nz,golpe_de_lado		;7b55
	ld a,l			;7b57
	add a,00ch		;7b58
	ld l,a			;7b5a
golpe_de_lado:
	ld e,000h		;7b5b   ; E = 0: golpe de lado
	bit 0,b		;7b5d   ; mirando a la izquierda: p06:7BC7
	jr nz,golpe_izq		;7b5f
	ld a,c			;7b61   ; segun el cuadro (0-5) de la animacion...
	cp 001h		;7b62
	jr c,golpe_der_0		;7b64
	jr z,golpe_der_1		;7b66
	cp 003h		;7b68
	jr c,golpe_der_2		;7b6a
	jr z,golpe_der_3		;7b6c
	cp 005h		;7b6e
	jr c,golpe_der_2		;7b70
	jr z,golpe_der_1		;7b72
golpe_der_0:
	ld a,l			;7b74   ; cuadros 0 y 6: (x + 0x11, y - 0x0A)
	sub 00ah		;7b75
	ld l,a			;7b77
	ld a,h			;7b78
	add a,011h		;7b79
	ld h,a			;7b7b
	jp fuerza_del_golpe		;7b7c
golpe_der_1:
	ld a,l			;7b7f   ; cuadros 1 y 5: (x + 0x14, y + 8)
	add a,008h		;7b80
	ld l,a			;7b82
	ld a,h			;7b83
	add a,014h		;7b84
	ld h,a			;7b86
	jp fuerza_del_golpe		;7b87
golpe_der_2:
	ld a,l			;7b8a   ; cuadros 2 y 4: (x - 4, y + 8)
	add a,008h		;7b8b
	ld l,a			;7b8d
	ld a,h			;7b8e
	sub 004h		;7b8f
	ld h,a			;7b91
	jp fuerza_del_golpe		;7b92
golpe_der_3:
	ld a,(0d919h)		;7b95   ; cuadro 3, el del golpe: depende del arma
	cp 002h		;7b98
	jr z,golpe_der_arma2		;7b9a
	cp 003h		;7b9c
	jr z,golpe_der_arma3		;7b9e
	inc l			;7ba0   ; arma 0 y 1: (x - 0x10, y + 1)
	ld a,h			;7ba1
	sub 010h		;7ba2
	ld h,a			;7ba4
	jp fuerza_del_golpe		;7ba5
golpe_der_arma2:
	inc l			;7ba8   ; arma 2: (x - 0x20, y + 1), mas largo
	ld a,h			;7ba9
	sub 020h		;7baa
	ld h,a			;7bac
	jp fuerza_del_golpe		;7bad
golpe_der_arma3:
	inc l			;7bb0   ; arma 3: (x - 0x10, y + 1)...
	ld a,h			;7bb1
	sub 010h		;7bb2
	ld h,a			;7bb4
	ld a,(0d924h)		;7bb5   ; ...y si no hay disparo en el aire...
	or a			;7bb8
	jp nz,fuerza_del_golpe		;7bb9
	ld (0d922h),hl		;7bbc   ; ...sale uno de ahi, direccion 3
	ld a,083h		;7bbf
	ld (0d924h),a		;7bc1   ; bit 7: el jugador usa la ficha 10 = a
	jp fuerza_del_golpe		;7bc4
golpe_izq:
	ld a,c			;7bc7   ; mirando a la izquierda, lo mismo con las x al reves
	cp 001h		;7bc8
	jr c,golpe_izq_0		;7bca
	jr z,golpe_izq_1		;7bcc
	cp 003h		;7bce
	jr c,golpe_izq_2		;7bd0
	jr z,golpe_izq_3		;7bd2
	cp 005h		;7bd4
	jr c,golpe_izq_2		;7bd6
	jr z,golpe_izq_1		;7bd8
golpe_izq_0:
	ld a,l			;7bda
	sub 00ah		;7bdb
	ld l,a			;7bdd
	jp fuerza_del_golpe		;7bde
golpe_izq_1:
	ld a,l			;7be1
	add a,008h		;7be2
	ld l,a			;7be4
	ld a,h			;7be5
	sub 004h		;7be6
	ld h,a			;7be8
	jp fuerza_del_golpe		;7be9
golpe_izq_2:
	ld a,l			;7bec
	add a,008h		;7bed
	ld l,a			;7bef
	ld a,h			;7bf0
	add a,00fh		;7bf1
	ld h,a			;7bf3
	jp fuerza_del_golpe		;7bf4
golpe_izq_3:
	ld a,(0d919h)		;7bf7   ; cuadro 3: arma 0 y 1, x + 0x20
	cp 002h		;7bfa
	jr z,golpe_izq_arma2		;7bfc
	cp 003h		;7bfe
	jr z,golpe_izq_arma3		;7c00
	inc l			;7c02
	ld a,h			;7c03
	add a,020h		;7c04
	ld h,a			;7c06
	jp fuerza_del_golpe		;7c07
golpe_izq_arma2:
	inc l			;7c0a   ; arma 2: x + 0x30
	ld a,h			;7c0b
	add a,030h		;7c0c
	ld h,a			;7c0e
	jp fuerza_del_golpe		;7c0f
golpe_izq_arma3:
	inc l			;7c12
	add a,004h		;7c13   ; (este `add a,4` no sirve: A se pisa)
	ld a,h			;7c15
	add a,020h		;7c16
	ld h,a			;7c18
	ld a,(0d924h)		;7c19   ; disparo, direccion 1
	or a			;7c1c
	jp nz,fuerza_del_golpe		;7c1d
	ld (0d922h),hl		;7c20   ; la y de la ficha 10 del jugador = hl
	ld a,081h		;7c23
	ld (0d924h),a		;7c25   ; bit 7: el jugador usa la ficha 10 = a
	jp fuerza_del_golpe		;7c28
golpe_arriba:
	ld e,001h		;7c2b   ; E = 1: hacia arriba, (x + 8, y - 0x1B)
	ld a,l			;7c2d
	sub 01bh		;7c2e
	ld l,a			;7c30
	ld a,h			;7c31
	add a,008h		;7c32
	ld h,a			;7c34
	ld a,(0d919h)		;7c35   ; con el arma 3...
	cp 003h		;7c38
	jp nz,fuerza_del_golpe		;7c3a
	ld a,(0d924h)		;7c3d   ; ...disparo hacia arriba (direccion 0)
	or a			;7c40
	jp nz,fuerza_del_golpe		;7c41
	ld (0d922h),hl		;7c44   ; la y de la ficha 10 del jugador = hl
	ld a,080h		;7c47
	ld (0d924h),a		;7c49   ; bit 7: el jugador usa la ficha 10 = a
	jp fuerza_del_golpe		;7c4c
golpe_abajo:
	ld e,002h		;7c4f   ; E = 2: hacia abajo, (x + 8, y + 0x18)
	ld a,l			;7c51
	add a,018h		;7c52
	ld l,a			;7c54
	ld a,h			;7c55
	add a,008h		;7c56
	ld h,a			;7c58
	ld a,(0d919h)		;7c59   ; con el arma 3...
	cp 003h		;7c5c
	jp nz,fuerza_del_golpe		;7c5e
	ld a,(0d924h)		;7c61   ; ...disparo hacia abajo (direccion 2)
	or a			;7c64
	jp nz,fuerza_del_golpe		;7c65
	ld (0d922h),hl		;7c68   ; la y de la ficha 10 del jugador = hl
	ld a,082h		;7c6b
	ld (0d924h),a		;7c6d   ; bit 7: el jugador usa la ficha 10 = a
	jp fuerza_del_golpe		;7c70
fuerza_del_golpe:
	ld a,(0d919h)		;7c73   ; arma * 8 + E...
	add a,a			;7c76
	add a,a			;7c77
	add a,a			;7c78
	push hl			;7c79
	ld l,a			;7c7a
	ld h,000h		;7c7b
	ld d,000h		;7c7d
	add hl,de			;7c7f
	ld de,080c6h		;7c80   ; ...en p07:80C6 en el suelo...
	ld a,(0d90dh)		;7c83
	bit 7,a		;7c86   ; ...o en p07:80CA en el aire
	jr z,L_7C8D		;7c88
	ld de,080cah		;7c8a
L_7C8D:
	add hl,de			;7c8d
	ld c,(hl)			;7c8e   ; C = la fuerza
	pop hl			;7c8f
	ld a,(0d910h)		;7c90   ; D910 bit 6: p07:91D1
	bit 6,a		;7c93
	jp nz,091d1h		;7c95
	call toca_especial		;7c98   ; el bloque especial (p06:7FF2)
	ld b,003h		;7c9b   ; los 3 objetos de D933
	ld de,00026h		;7c9d
	ld ix,0d933h		;7ca0   ; ix -> los 6 actores de la pantalla
golpe_a_objeto:
	ld a,(ix+00fh)		;7ca4   ; sin vida (+0F = 0): no se le puede dar
	or a			;7ca7
	jp z,siguiente_objeto_golpe		;7ca8
	ld a,(ix+000h)		;7cab   ; hueco
	or a			;7cae
	jp z,siguiente_objeto_golpe		;7caf
	bit 7,(ix+025h)		;7cb2   ; +25 bit 7: ya le dio este golpe
	jp nz,siguiente_objeto_golpe		;7cb6
	cp 002h		;7cb9   ; segun el tipo, una caja de choque distinta:
	jp c,caja_a		;7cbb
	jp z,caja_b		;7cbe
	cp 004h		;7cc1
	jp c,caja_c		;7cc3
	jp z,caja_b		;7cc6
	cp 006h		;7cc9
	jp c,caja_b		;7ccb
	jp z,caja_a		;7cce
	cp 008h		;7cd1
	jp c,caja_b		;7cd3
	jp z,caja_i		;7cd6
	cp 00ah		;7cd9
	jp c,caja_e		;7cdb
	jp z,caja_i		;7cde
	cp 00ch		;7ce1
	jp c,caja_f		;7ce3
	jp z,caja_f		;7ce6
	cp 00eh		;7ce9
	jp c,caja_e		;7ceb
	jp z,caja_g		;7cee
	cp 010h		;7cf1
	jp c,caja_h		;7cf3
	jp z,caja_g		;7cf6
	cp 012h		;7cf9
	jp c,caja_a		;7cfb
	jp z,caja_a		;7cfe
	cp 014h		;7d01
	jp c,caja_a		;7d03
	jp z,caja_c		;7d06
	cp 016h		;7d09
	jp c,caja_c		;7d0b
	jp z,caja_tipo_16		;7d0e
	jp siguiente_objeto_golpe		;7d11
caja_a:
	ld a,(ix+006h)		;7d14   ; |x del objeto - x del golpe| y |y - y| dentro de la caja...
	sub h			;7d17
	add a,014h		;7d18
	cp 018h		;7d1a
	jp nc,siguiente_objeto_golpe		;7d1c
	ld a,(ix+007h)		;7d1f
	sub l			;7d22
	add a,01eh		;7d23
	cp 02ch		;7d25
	jp nc,siguiente_objeto_golpe		;7d27
	jp le_da		;7d2a
caja_b:
	ld a,(ix+007h)		;7d2d
	sub l			;7d30
	add a,00fh		;7d31
	cp 01bh		;7d33
	jr nc,caja_b_2		;7d35
	ld a,(ix+006h)		;7d37
	sub h			;7d3a
	add a,01ch		;7d3b
	cp 029h		;7d3d
	jp nc,siguiente_objeto_golpe		;7d3f
	jp le_da		;7d42
caja_b_2:
	ld a,(ix+007h)		;7d45
	sub l			;7d48
	add a,01bh		;7d49
	cp 01eh		;7d4b
	jp nc,siguiente_objeto_golpe		;7d4d
	ld a,(ix+006h)		;7d50
	sub h			;7d53
	add a,016h		;7d54
	cp 01dh		;7d56
	jp nc,siguiente_objeto_golpe		;7d58
	jp le_da		;7d5b
caja_c:
	ld a,(ix+007h)		;7d5e
	sub l			;7d61
	add a,00fh		;7d62
	cp 01bh		;7d64
	jr nc,caja_c_2		;7d66
	ld a,(ix+006h)		;7d68
	sub h			;7d6b
	add a,016h		;7d6c
	cp 01dh		;7d6e
	jp nc,siguiente_objeto_golpe		;7d70
	jp le_da		;7d73
caja_c_2:
	ld a,(ix+007h)		;7d76
	sub l			;7d79
	add a,01bh		;7d7a
	cp 01eh		;7d7c
	jp nc,siguiente_objeto_golpe		;7d7e
	ld a,(ix+006h)		;7d81
	sub h			;7d84
	add a,01dh		;7d85
	cp 02bh		;7d87
	jp nc,siguiente_objeto_golpe		;7d89
	jp le_da		;7d8c
huerfana_caja_d:
	ld a,(ix+006h)		;7d8f   ; nadie llega aqui: otra caja sin usar
	sub h			;7d92
	add a,01fh		;7d93
	cp 01dh		;7d95
	jp nc,siguiente_objeto_golpe		;7d97
	ld a,(ix+007h)		;7d9a
	sub l			;7d9d
	add a,01fh		;7d9e
	cp 017h		;7da0
	jp nc,siguiente_objeto_golpe		;7da2
	jp le_da		;7da5
caja_e:
	ld a,(ix+006h)		;7da8
	sub h			;7dab
	add a,01ch		;7dac
	cp 029h		;7dae
	jp nc,siguiente_objeto_golpe		;7db0
	ld a,(ix+007h)		;7db3
	sub l			;7db6
	add a,01dh		;7db7
	cp 029h		;7db9
	jp nc,siguiente_objeto_golpe		;7dbb
	jp le_da		;7dbe
caja_f:
	ld a,(ix+006h)		;7dc1
	sub h			;7dc4
	add a,00eh		;7dc5
	cp 01dh		;7dc7
	jp nc,siguiente_objeto_golpe		;7dc9
	ld a,(ix+007h)		;7dcc
	sub l			;7dcf
	add a,00eh		;7dd0
	cp 01dh		;7dd2
	jp nc,siguiente_objeto_golpe		;7dd4
	jp le_da		;7dd7
caja_g:
	ld a,(ix+006h)		;7dda
	sub h			;7ddd
	add a,00eh		;7dde
	cp 01dh		;7de0
	jp nc,siguiente_objeto_golpe		;7de2
	ld a,(ix+007h)		;7de5
	sub l			;7de8
	add a,01eh		;7de9
	cp 02ch		;7deb
	jp nc,siguiente_objeto_golpe		;7ded
	jp le_da		;7df0
caja_h:
	ld a,(ix+006h)		;7df3
	sub h			;7df6
	add a,01eh		;7df7
	cp 02dh		;7df9
	jp nc,siguiente_objeto_golpe		;7dfb
	ld a,(ix+007h)		;7dfe
	sub l			;7e01
	add a,01fh		;7e02
	cp 01dh		;7e04
	jp nc,siguiente_objeto_golpe		;7e06
	jp le_da		;7e09
caja_tipo_16:
	res 6,(ix+025h)		;7e0c   ; tipo 0x16: +25 bit 6 a 0...
	ld a,(ix+001h)		;7e10   ; ...solo con la pose 0x14 del objeto...
	and 01eh		;7e13
	cp 014h		;7e15
	jp nz,siguiente_objeto_golpe		;7e17
	ld a,(ix+006h)		;7e1a
	sub h			;7e1d
	add a,015h		;7e1e
	cp 01ch		;7e20
	jp nc,siguiente_objeto_golpe		;7e22
	ld a,(ix+007h)		;7e25
	sub l			;7e28
	add a,019h		;7e29
	cp 033h		;7e2b
	jp nc,siguiente_objeto_golpe		;7e2d
	set 6,(ix+025h)		;7e30   ; ...y si le da, +25 bit 6
	jp le_da		;7e34
caja_i:
	ld a,(ix+006h)		;7e37
	sub h			;7e3a
	add a,01eh		;7e3b
	cp 02dh		;7e3d
	jp nc,siguiente_objeto_golpe		;7e3f
	ld a,(ix+007h)		;7e42
	sub l			;7e45
	add a,009h		;7e46
	cp 01eh		;7e48
	jp nc,siguiente_objeto_golpe		;7e4a
	jp le_da		;7e4d
huerfana_caja_j:
	ld a,(ix+006h)		;7e50   ; nadie llega aqui
	sub h			;7e53
	add a,00eh		;7e54
	cp 01dh		;7e56
	jp nc,siguiente_objeto_golpe		;7e58
	ld a,(ix+007h)		;7e5b
	sub l			;7e5e
	add a,00ch		;7e5f
	cp 018h		;7e61
	jp nc,siguiente_objeto_golpe		;7e63
	jp le_da		;7e66
le_da:
	ld a,(ix+00fh)		;7e69   ; vida - fuerza
	sub c			;7e6c
	jr z,L_7E71		;7e6d   ; 0 o menos: p07:807C (se acaba)...
	jr nc,L_7E75		;7e6f
L_7E71:
	call 0807ch		;7e71
	xor a			;7e74   ; ...y vida 0
L_7E75:
	ld (ix+00fh),a		;7e75   ; la vida que le queda
	set 7,(ix+025h)		;7e78   ; marcado: este golpe ya le dio
	exx			;7e7c
	ld hl,0d928h		;7e7d   ; suceso del bit 6: efecto 2
	set 6,(hl)		;7e80
	exx			;7e82
siguiente_objeto_golpe:
	add ix,de		;7e83
	dec b			;7e85
	jp nz,golpe_a_objeto		;7e86
	ld c,000h		;7e89   ; C = 1 si la pose es la 0x14 (hacia abajo)
	ld a,(0d904h)		;7e8b   ; a = la pose de Rastan
	and 01eh		;7e8e
	cp 014h		;7e90
	jr nz,golpe_a_enemigos		;7e92
	ld c,001h		;7e94
golpe_a_enemigos:
	ld b,008h		;7e96   ; los 8 enemigos de DA20
	ld de,00026h		;7e98
	ld ix,0da20h		;7e9b   ; ix -> los 8 enemigos de la pantalla
golpe_a_bloque:
	ld a,(ix+000h)		;7e9f   ; solo los de tipo 0x24
	cp 024h		;7ea2
	jp nz,siguiente_bloque		;7ea4
	bit 0,c		;7ea7   ; hacia abajo: una caja estrecha
	jr z,golpe_a_bloque_lado		;7ea9
	ld a,(ix+010h)		;7eab
	sub h			;7eae
	add a,00eh		;7eaf
	cp 010h		;7eb1
	jr nc,siguiente_bloque		;7eb3
	ld a,(ix+011h)		;7eb5
	sub l			;7eb8
	add a,01fh		;7eb9
	cp 02dh		;7ebb
	jr nc,siguiente_bloque		;7ebd
	jp rompe_bloque		;7ebf
golpe_a_bloque_lado:
	ld a,(ix+010h)		;7ec2   ; de lado: otra caja
	sub h			;7ec5
	add a,01fh		;7ec6
	cp 029h		;7ec8
	jr nc,siguiente_bloque		;7eca
	ld a,(ix+011h)		;7ecc
	sub l			;7ecf
	add a,018h		;7ed0
	sub 01fh		;7ed2
	jr nc,siguiente_bloque		;7ed4
rompe_bloque:
	push bc			;7ed6   ; el tipo 0x24 tapa cuatro casillas de D774 (p07:80E6 da la primera)...
	push de			;7ed7
	push hl			;7ed8
	ld l,(ix+011h)		;7ed9
	ld h,(ix+010h)		;7edc
	call 080e6h		;7edf
	ld a,(hl)			;7ee2   ; ...se les borra la clase (nibble alto): arriba a la izquierda...
	and 00fh		;7ee3
	ld (hl),a			;7ee5
	inc hl			;7ee6   ; ...arriba a la derecha...
	inc hl			;7ee7
	ld a,(hl)			;7ee8
	and 00fh		;7ee9
	ld (hl),a			;7eeb
	ld bc,0001eh		;7eec   ; ...abajo a la izquierda (0x20 bytes mas)...
	add hl,bc			;7eef
	ld a,(hl)			;7ef0
	and 00fh		;7ef1
	ld (hl),a			;7ef3
	inc hl			;7ef4   ; ...abajo a la derecha...
	inc hl			;7ef5
	ld a,(hl)			;7ef6
	and 00fh		;7ef7
	ld (hl),a			;7ef9
	call repinta_fondo_actor		;7efa   ; ...y se repinta el fondo encima
	pop hl			;7efd
	pop de			;7efe
	pop bc			;7eff
siguiente_bloque:
	add ix,de		;7f00
	djnz golpe_a_bloque		;7f02

; ----------------------------------------------------------------------
; El disparo del arma 3 (ficha 10): si sigue en pantalla y no toca una
; casilla solida, puede dar a un objeto (fuerza 0x30) y avanza 3 pixeles.
; ----------------------------------------------------------------------
disparo:
	ld hl,(0d922h)		;7f04   ; su posicion
	ld c,030h		;7f07   ; fuerza 0x30
	ld a,(0d924h)		;7f09   ; no hay disparo
	bit 7,a		;7f0c
	ret z			;7f0e
	ld a,h			;7f0f   ; fuera de la pantalla (x < 4 o >= 0xF4, y < 0x24 o >= 0xCC)...
	cp 004h		;7f10
	jr c,fin_del_disparo		;7f12
	cp 0f4h		;7f14
	jr nc,fin_del_disparo		;7f16
	ld a,l			;7f18
	cp 024h		;7f19
	jr c,fin_del_disparo		;7f1b
	cp 0cch		;7f1d
	jr nc,fin_del_disparo		;7f1f
	push hl			;7f21   ; la casilla de (x + 4, y + 4)...
	ld a,h			;7f22
	add a,004h		;7f23
	ld h,a			;7f25
	ld a,l			;7f26
	add a,004h		;7f27
	ld l,a			;7f29
	push af			;7f2a
	call 080e6h		;7f2b   ; ...en D774
	ld b,a			;7f2e
	pop af			;7f2f
	ld de,00000h		;7f30   ; en la mitad de abajo, la de debajo
	and 00fh		;7f33
	cp 009h		;7f35
	jr c,L_7F3C		;7f37
	ld de,00020h		;7f39
L_7F3C:
	add hl,de			;7f3c
	ld c,(hl)			;7f3d
	pop hl			;7f3e
	ld a,b			;7f3f   ; 0x10-0x7F o 0xA0: choca
	cp 010h		;7f40
	jr c,disparo_2		;7f42
	cp 080h		;7f44
	jr c,fin_del_disparo		;7f46
	cp 0a0h		;7f48
	jr z,fin_del_disparo		;7f4a
disparo_2:
	ld a,c			;7f4c   ; la otra casilla, igual
	and 0f0h		;7f4d
	cp 010h		;7f4f
	jr c,disparo_objetos		;7f51
	cp 080h		;7f53
	jr c,fin_del_disparo		;7f55
	cp 0a0h		;7f57
	jr nz,disparo_objetos		;7f59
fin_del_disparo:
	xor a			;7f5b   ; ya no hay disparo
	ld (0d924h),a		;7f5c   ; bit 7: el jugador usa la ficha 10 = a
	ret			;7f5f
disparo_objetos:
	ld b,003h		;7f60   ; los 3 objetos
	ld c,030h		;7f62
	ld de,00026h		;7f64
	ld ix,0d933h		;7f67   ; ix -> los 6 actores de la pantalla
disparo_a_objeto:
	ld a,(ix+000h)		;7f6b   ; hueco
	or a			;7f6e
	jp z,disparo_avanza		;7f6f
	ld a,(ix+00fh)		;7f72   ; sin vida
	or a			;7f75
	jp z,disparo_avanza		;7f76
	bit 7,(ix+025h)		;7f79   ; ya tocado
	jp nz,disparo_avanza		;7f7d
	ld a,(ix+006h)		;7f80   ; dentro de la caja del disparo?
	sub h			;7f83
	add a,00eh		;7f84
	cp 01dh		;7f86
	jr nc,disparo_avanza		;7f88
	ld a,(ix+007h)		;7f8a
	sub l			;7f8d
	add a,01bh		;7f8e
	cp 027h		;7f90
	jr nc,disparo_avanza		;7f92
	ld a,(ix+00fh)		;7f94   ; vida - 0x30
	sub c			;7f97
	jr z,L_7F9C		;7f98
	jr nc,L_7FA0		;7f9a
L_7F9C:
	call 0807ch		;7f9c   ; se acaba
	xor a			;7f9f
L_7FA0:
	ld (ix+00fh),a		;7fa0   ; y el disparo tambien
	jp fin_del_disparo		;7fa3
disparo_avanza:
	add ix,de		;7fa6
	djnz disparo_a_objeto		;7fa8
	ld a,(0d924h)		;7faa   ; la direccion: 0 arriba, 1 derecha, 2 abajo, 3 izquierda
	and 003h		;7fad
	cp 001h		;7faf
	jr c,disparo_arriba		;7fb1
	jr z,disparo_derecha		;7fb3
	cp 003h		;7fb5
	jr c,disparo_abajo		;7fb7
	ld a,h			;7fb9
	sub 003h		;7fba
	ld h,a			;7fbc
	jr guarda_disparo		;7fbd
disparo_arriba:
	ld a,l			;7fbf
	sub 003h		;7fc0
	ld l,a			;7fc2
	jr guarda_disparo		;7fc3
disparo_derecha:
	ld a,h			;7fc5
	add a,003h		;7fc6
	ld h,a			;7fc8
	jr guarda_disparo		;7fc9
disparo_abajo:
	ld a,l			;7fcb
	add a,003h		;7fcc
	ld l,a			;7fce
guarda_disparo:
	ld (0d922h),hl		;7fcf   ; la y de la ficha 10 del jugador = hl
	ret			;7fd2
sin_ataque:
	bit 0,b		;7fd3   ; sin ataque: el punto (x + 9, y - 0x0A) mirando a la derecha...
	jr nz,sin_ataque_izq		;7fd5
	ld a,l			;7fd7
	sub 00ah		;7fd8
	ld l,a			;7fda
	ld a,h			;7fdb
	add a,009h		;7fdc
	ld h,a			;7fde
	jr mira_especial		;7fdf
sin_ataque_izq:
	ld a,l			;7fe1   ; ...o (x - 1, y - 0x0A)
	sub 00ah		;7fe2
	ld l,a			;7fe4
	dec h			;7fe5
mira_especial:
	call toca_especial		;7fe6   ; el bloque especial
	ld a,(0d910h)		;7fe9   ; D910 bit 6: nada mas
	bit 6,a		;7fec
	ret nz			;7fee
	jp disparo		;7fef   ; el disparo

; ----------------------------------------------------------------------
; El bloque especial (D92D 1-3): si el punto (H, L) cae dentro, sigue en
; p07:8000 (la rutina cruza la frontera del banco).
; ----------------------------------------------------------------------
toca_especial:
	ld a,(0d92dh)		;7ff2   ; ninguno
	or a			;7ff5
	ret z			;7ff6
	cp 004h		;7ff7   ; solo los tipos 1-3
	ret nc			;7ff9
	ld a,(0d92bh)		;7ffa   ; dentro de su caja?
	sub h			;7ffd
	add a,00eh		;7ffe
