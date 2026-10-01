; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 03 (en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x60c9  (201 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS ACTORES (tarea 3, cada cuadro). En las fases de jefe (2, 5, 8, 0x0B,
; 0x0E y 0x12-0x17) salta a la rutina del jefe en p04. Si no, mueve UN actor
; de los tres de D933 por cuadro (DA1A apunta al que toca, DA1C cuenta), con
; la rutina de su tipo de la tabla p03:60C9.
; ----------------------------------------------------------------------
actores:
	ld a,(0d5e5h)		;6000   ; la fase...
	cp 002h		;6003   ; ...2: el jefe de p04:8016
	jp z,08016h		;6005   ; p04 jefe_fase_2
	cp 005h		;6008   ; 5: p04:8262
	jp z,08262h		;600a   ; p04 jefe_fase_5
	cp 008h		;600d   ; 8: p04:848E
	jp z,0848eh		;600f   ; p04 jefe_fase_8
	cp 00bh		;6012   ; 0x0B: p04:8799
	jp z,08799h		;6014   ; p04 jefe_fase_0b
	cp 00eh		;6017   ; 0x0E: p04:89CE
	jp z,089ceh		;6019   ; p04 jefe_fase_0e
	cp 012h		;601c   ; 0x12: p04:8BF4
	jp z,08bf4h		;601e   ; p04 jefe_fase_12
L_6021:
	cp 013h		;6021   ; 0x13: p04:8C06
	jp z,08c06h		;6023   ; p04 jefe_fase_13
L_6026:
	cp 014h		;6026   ; 0x14: p04:8C18
	jp z,08c18h		;6028   ; p04 jefe_fase_14
L_602B:
	cp 015h		;602b   ; 0x15: p04:8C2A
	jp z,08c2ah		;602d   ; p04 jefe_fase_15
L_6030:
	cp 016h		;6030   ; 0x16: p04:8C3C
	jp z,08c3ch		;6032   ; p04 jefe_fase_16
L_6035:
	cp 017h		;6035   ; 0x17: p04:8C4E
	jp z,08c4eh		;6037   ; p04 final
	ld ix,(0da1ah)		;603a   ; el actor al que le toca
	ld a,(ix+000h)		;603e   ; su tipo: 0, hueco
	and a			;6041
	jp z,siguiente_actor		;6042
	cp 024h		;6045   ; 0x24: el que suelta objetos (p03:607A)
	jp z,suelta_objeto		;6047
	dec a			;604a   ; tipo - 1...
	ld l,a			;604b
	ld h,000h		;604c
	add hl,hl			;604e
	ld de,060c9h		;604f   ; ...en la tabla de p03:60C9
	add hl,de			;6052
	ld e,(hl)			;6053
	inc hl			;6054
	ld d,(hl)			;6055
	ex de,hl			;6056
	ld de,siguiente_actor		;6057   ; la rutina vuelve a p03:605C
	push de			;605a
	jp (hl)			;605b   ; salta a la rutina del tipo
siguiente_actor:
	ld a,(0da1ch)		;605c   ; cuantos quedan en la vuelta
	ld b,a			;605f
	ld de,00026h		;6060   ; 38 bytes por actor
	add ix,de		;6063
	djnz L_606A		;6065   ; acabada la vuelta...
	call primer_actor		;6067   ; ...otra vez desde el primero
L_606A:
	ld (0da1ah),ix		;606a   ; apunta el siguiente
	ld a,b			;606e
	ld (0da1ch),a		;606f
	ret			;6072
primer_actor:
	ld ix,0d933h		;6073   ; D933, tres actores
	ld b,003h		;6077
	ret			;6079

; ----------------------------------------------------------------------
; Tipo 0x24: cuando acaba su animacion (+2 bit 7), si no hay bloque
; especial en la pantalla, una vez de cada cuatro deja uno al azar (tipos
; 4-0x12) donde estaba, y se da de baja.
; ----------------------------------------------------------------------
suelta_objeto:
	call 04a8bh		;607a   ; un paso de animacion
	bit 7,(ix+002h)		;607d   ; aun no ha acabado
	jp z,siguiente_actor		;6081
	ld a,(0d92dh)		;6084   ; ya hay un bloque especial: nada
	and a			;6087
	jp nz,se_va		;6088
	call 044deh		;608b   ; al azar...
	and 024h		;608e   ; ...una vez de cada cuatro
	cp 004h		;6090
	jp nz,se_va		;6092
	ld a,(ix+006h)		;6095   ; en su casilla: x...
	add a,008h		;6098
	and 0f0h		;609a
	ld (0d92bh),a		;609c   ; x del bloque especial de la pantalla = a
	ld a,(ix+007h)		;609f   ; ...e y
	add a,008h		;60a2
	and 0f0h		;60a4
	ld (0d92ch),a		;60a6   ; y del bloque especial = a
tipo_al_azar:
	call 044deh		;60a9   ; azar...
	ld b,a			;60ac
	ld a,r		;60ad   ; ...mezclado con R
	xor b			;60af
	and 00fh		;60b0   ; 0-15 + 3...
	add a,003h		;60b2
	cp 003h		;60b4   ; ...pero no el 3: de 4 a 0x12
	jp z,tipo_al_azar		;60b6
	ld (0d92dh),a		;60b9   ; apuntado...
	push ix		;60bc
	call 048b6h		;60be   ; ...y pintado
	pop ix		;60c1
se_va:
	call 04b10h		;60c3   ; se da de baja
	jp siguiente_actor		;60c6

; ----------------------------------------------------------------------
; DATOS rutinas_por_tipo: La rutina de cada tipo de actor (1-32); las del 22
;   en adelante son p03:6109, un `ret`
;   0x60c9..0x6109  (64 bytes)
DATA_rutinas_por_tipo:
	defw 0645eh,06109h,067bah,0668dh,06b59h,0717dh,06639h,06109h	; 60c9
	defw 06cdch,070c6h,0610ah,06134h,06745h,061aah,07076h,06206h	; 60d9
	defw 074fch,07368h,06e95h,076f1h,078adh,06109h,06109h,06109h	; 60e9
	defw 06109h,06109h,06109h,06109h,06109h,06109h,06109h,06109h	; 60f9

; ======================================================================
; CODIGO 0x6109..0x618e  (133 bytes)
; ======================================================================


tipo_sin_rutina:
	ret			;6109   ; nada

; ----------------------------------------------------------------------
; Tipo 0x0B: se vuelve hacia Rastan y, si delante no hay una casilla de clase
; 0x20, se le acerca en y, anda y a veces cambia de rumbo al azar.
; ----------------------------------------------------------------------
tipo_0b:
	ld a,(ix+00fh)		;610a   ; sin vida: p03:7AAF
	and a			;610d
	jp z,muere_actor		;610e
	call de_cara		;6111   ; de cara a Rastan? (p03:7B29)
	and a			;6114
	call z,da_la_vuelta		;6115   ; de espaldas: se da la vuelta
	call casillas_actor		;6118   ; las casillas de alrededor
	ld a,(ix+020h)		;611b   ; la de los pies: clase 0x20?
	and 0f0h		;611e   ; la clase de la casilla (+20)
	cp 020h		;6120   ; clase 0x20?
	jp z,tipo_0b_pinta		;6122
	call acerca_y		;6125   ; se acerca 2 pixeles a la y de Rastan (p03:7B90)...
	call anda		;6128   ; ...anda 2 pixeles (p03:7E83)...
	call cambia_al_azar		;612b   ; ...y a veces cambia de direccion
	jp 04a8bh		;612e   ; pintado
tipo_0b_pinta:
	jp 04a8bh		;6131   ; p00 pinta_actor

; ----------------------------------------------------------------------
; Tipo 0x0C: la primera vez pide el efecto 9; se vuelve hacia Rastan, rebota
; en los bordes de la pantalla, anda y se le acerca en y.
; ----------------------------------------------------------------------
tipo_0c:
	ld a,(ix+00fh)		;6134   ; sin vida
	and a			;6137
	jp z,muere_actor		;6138
	ld a,(ix+010h)		;613b   ; +10 = 0: la primera vez...
	and a			;613e
	jr nz,tipo_0c_mueve		;613f
	ld a,009h		;6141   ; ...efecto 9...
	ld (0d178h),a		;6143   ; efecto pedido, para p01:63E1 = a
	ld (ix+010h),0ffh		;6146   ; ...y ya no
tipo_0c_mueve:
	call de_cara		;614a   ; de espaldas a Rastan: se da la vuelta
	and a			;614d
	call z,da_la_vuelta		;614e
	ld a,(ix+006h)		;6151   ; x < 1: a la derecha
	cp 001h		;6154
	call c,rebota_izq		;6156
	cp 0efh		;6159   ; x >= 0xEF: a la izquierda
	call nc,rebota_der		;615b
	ld a,(ix+007h)		;615e   ; y < 1: hacia abajo
	cp 001h		;6161
	call c,tope_arriba		;6163
	cp 0b6h		;6166   ; y >= 0xB6: hacia arriba
	call nc,tope_abajo		;6168
	call casillas_actor		;616b   ; las casillas
	ld a,(ix+019h)		;616e   ; delante, clase 0x20: se para
	and 0f0h		;6171   ; la clase de la casilla (+19)
	cp 020h		;6173   ; clase 0x20?
	jp z,tipo_0c_pinta		;6175
	call anda		;6178   ; anda 2 pixeles...
	call acerca_y		;617b   ; ...y se acerca a la y de Rastan
	jp 04a8bh		;617e   ; p00 pinta_actor
tipo_0c_pinta:
	jp 04a8bh		;6181   ; p00 pinta_actor
cambia_al_azar:
	ld b,004h		;6184   ; B = 4
	ld a,r		;6186   ; R & 0x18: al azar
	and 018h		;6188
	cp 000h		;618a   ; (este `cp 0` no sirve: el `jr` salta siempre)
	jr $+15		;618c

; ----------------------------------------------------------------------
; DATOS resto_618E: trozos de codigo que nadie ejecuta (`cp 8`, `cp 0x10`, `ld
;   a,(ix+6)`)
;   0x618e..0x619b  (13 bytes)
DATA_resto_618E:
	defb 0feh,008h,018h,00eh,0feh,010h,018h,00fh,0ddh,07eh,006h,080h,0c9h	; 618e  .........~...

; ======================================================================
; CODIGO 0x619b..0x61a0  (5 bytes)
; ======================================================================


x_menos_b:
	ld a,(ix+006h)		;619b   ; la x del actor - B
	sub b			;619e
	ret			;619f

; ----------------------------------------------------------------------
; DATOS resto_61A0: dos trozos que nadie ejecuta (`ld a,(ix+7) / add a,b /
;   ret` y `sub b`)
;   0x61a0..0x61aa  (10 bytes)
DATA_resto_61A0:
	defb 0ddh,07eh,007h,080h,0c9h,0ddh,07eh,007h,090h,0c9h	; 61a0  .~....~...

; ======================================================================
; CODIGO 0x61aa..0x63d6  (556 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Tipo 0x0E: si esta de espaldas a Rastan se da la vuelta; si no, anda mientras
; tenga suelo delante, y cae si no hay nada debajo.
; ----------------------------------------------------------------------
tipo_0e:
	ld a,(ix+00fh)		;61aa   ; sin vida
	and a			;61ad
	jp z,muere_actor		;61ae
	call de_cara		;61b1   ; de espaldas: se da la vuelta y nada mas
	and a			;61b4
	jp z,da_la_vuelta		;61b5
	call nada_debajo		;61b8   ; debajo, casillas de clase 0xF0 (nada)?...
	cp 0ffh		;61bb
	jp z,cae_1		;61bd   ; ...cae un pixel (p03:7E4B)
	ld a,(ix+006h)		;61c0   ; (los dos `call` de abajo no tienen condicion: da la vuelta dos veces y queda igual)
	cp 008h		;61c3
	call da_la_vuelta		;61c5
	cp 0efh		;61c8
	call da_la_vuelta		;61ca
	call casillas_actor		;61cd   ; las casillas
	bit 0,(ix+001h)		;61d0   ; mirando a la izquierda...
	jr z,tipo_0e_der		;61d4
	ld a,(ix+018h)		;61d6   ; ...delante una pared (0x20): se para
	and 0f0h		;61d9   ; la clase de la casilla (+18)
	cp 020h		;61db   ; clase 0x20?
	jr z,tipo_0e_pinta		;61dd
	ld a,(ix+01bh)		;61df   ; ...si la de delante-abajo no es suelo: da la vuelta
	and 0f0h		;61e2   ; la clase de la casilla (+1B)
	cp 020h		;61e4   ; clase 0x20?
	jr nz,tipo_0e_pinta		;61e6
	jp anda_2		;61e8
tipo_0e_der:
	ld a,(ix+018h)		;61eb   ; a la derecha, lo mismo
	and 0f0h		;61ee   ; la clase de la casilla (+18)
	cp 020h		;61f0   ; clase 0x20?
	jr z,tipo_0e_pinta		;61f2
	ld a,(ix+01dh)		;61f4
	and 0f0h		;61f7   ; la clase de la casilla (+1D)
	cp 020h		;61f9   ; clase 0x20?
	jr nz,tipo_0e_pinta		;61fb
	call anda		;61fd   ; anda
	jp 04a8bh		;6200   ; p00 pinta_actor
tipo_0e_pinta:
	jp 04a8bh		;6203   ; p00 pinta_actor

; ----------------------------------------------------------------------
; Tipo 0x10: anda hasta 0x20 pasos y lanza un proyectil (el actor 5, D9F1)
; cada tanto; con +13 se para un rato al azar.
; ----------------------------------------------------------------------
tipo_10:
	ld a,(ix+00fh)		;6206   ; sin vida
	and a			;6209
	jp z,muere_actor		;620a
	ld a,(0da06h)		;620d   ; el actor 5 con +15 = 0x0F: proyectil en vuelo, se mueve
	cp 00fh		;6210
	call z,proyectil		;6212
	bit 1,(ix+001h)		;6215   ; +1 bit 1: le toca lanzar
	call nz,proyectil		;6219
	call de_cara		;621c   ; de espaldas: se da la vuelta y nada mas
	and a			;621f
	jp z,da_la_vuelta		;6220
	ld a,(ix+011h)		;6223   ; +11: esperando
	and a			;6226
	jp nz,tipo_10_espera		;6227
	ld a,(ix+013h)		;622a   ; +13: parado un rato
	and a			;622d
	res 1,(ix+001h)		;622e
	jp nz,tipo_10_al_azar		;6232
	ld a,(ix+006h)		;6235   ; x < 1: derecha
	cp 001h		;6238
	call c,rebota_izq		;623a
	cp 0efh		;623d   ; x >= 0xEF: izquierda
	call nc,rebota_der		;623f
	call casillas_actor		;6242   ; las casillas
	bit 0,(ix+001h)		;6245   ; mirando a la izquierda...
	jr z,tipo_10_der		;6249
	ld a,(ix+018h)		;624b   ; ...pared: se para
	and 0f0h		;624e   ; la clase de la casilla (+18)
	cp 020h		;6250   ; clase 0x20?
	jp z,tipo_10_parado		;6252
	ld a,(ix+01ch)		;6255   ; ...sin suelo delante: se para
	and 0f0h		;6258   ; la clase de la casilla (+1C)
	cp 020h		;625a   ; clase 0x20?
	jp nz,tipo_10_parado		;625c
	jr tipo_10_anda		;625f
tipo_10_der:
	ld a,(ix+01ah)		;6261
	and 0f0h		;6264   ; la clase de la casilla (+1A)
	cp 020h		;6266   ; clase 0x20?
	jp z,tipo_10_parado		;6268
	ld a,(ix+01eh)		;626b
	and 0f0h		;626e   ; la clase de la casilla (+1E)
	cp 020h		;6270   ; clase 0x20?
	jp nz,tipo_10_parado		;6272
tipo_10_anda:
	ld a,(ix+010h)		;6275   ; +10: pasos dados; a 0x20, lanza
	cp 020h		;6278
	jp z,tipo_10_lanza		;627a
	inc a			;627d   ; uno mas
	ld (ix+010h),a		;627e
	jp anda_1		;6281   ; anda
tipo_10_parado:
	ld (ix+013h),0ffh		;6284   ; +13 = 0xFF: se queda parado
	jp 04a8bh		;6288   ; p00 pinta_actor
tipo_10_lanza:
	ld a,(0d9e0h)		;628b   ; el actor 4 ya tiene +15 = 0x0F: no
	cp 00fh		;628e
	jr z,tipo_10_espera		;6290
	set 1,(ix+001h)		;6292   ; marca de lanzar
	ld (ix+010h),000h		;6296   ; pasos a 0...
	ld (ix+011h),00fh		;629a   ; ...y 15 cuadros de espera
	push ix		;629e
	call 04a8bh		;62a0   ; p00 pinta_actor
	pop ix		;62a3
	ld a,(ix+015h)		;62a5   ; el proyectil (+15)...
	and a			;62a8
	jp z,proyectil		;62a9
tipo_10_espera:
	dec a			;62ac   ; un cuadro menos de espera
	ld (ix+011h),a		;62ad
	jp 04a8bh		;62b0   ; p00 pinta_actor
tipo_10_al_azar:
	ld a,r		;62b3   ; R con paridad impar...
	jp po,tipo_10_ya		;62b5
	dec a			;62b8   ; ...un cuadro menos parado
	ld (ix+013h),a		;62b9
	jp 04a8bh		;62bc   ; p00 pinta_actor
tipo_10_ya:
	set 1,(ix+001h)		;62bf   ; ...si no, lanza
	jp 04a8bh		;62c3   ; p00 pinta_actor

; ----------------------------------------------------------------------
; El proyectil del tipo 0x10: el actor 5 (D9F1). Sale del lado al que mira
; quien lo lanza (IY) y sigue una lista de pasos (p03:63D6).
; ----------------------------------------------------------------------
proyectil:
	push ix		;62c6   ; IY = el que lanza
	push ix		;62c8
	pop iy		;62ca
	ld ix,0d9f1h		;62cc   ; IX = el actor 5
	ld a,(ix+015h)		;62d0   ; +15 = 0: aun no ha salido
	cp 000h		;62d3
	jp z,lanza_proyectil		;62d5
	cp 00fh		;62d8   ; 0x0F: en vuelo (este `cp` no decide nada)
	jr mueve_proyectil		;62da
lanza_proyectil:
	bit 7,(iy+002h)		;62dc   ; el que lanza ha acabado su animacion?
	jp z,L_62F6		;62e0
	ld (ix+015h),00fh		;62e3   ; en vuelo
	call coloca_proyectil		;62e7   ; se coloca
	ld hl,063d6h		;62ea   ; la lista de pasos de p03:63D6
	ld (0da01h),hl		;62ed   ; actor 5, byte +10 = hl
	call 048f9h		;62f0   ; alta...
	call 04a8bh		;62f3   ; ...y pintado
L_62F6:
	pop ix		;62f6
	ret			;62f8
pinta_y_vuelve:
	call 04a8bh		;62f9   ; p00 pinta_actor
	pop ix		;62fc
	ret			;62fe
fin_proyectil:
	ld (ix+015h),000h		;62ff   ; +15 = 0: ya no hay
	ld hl,063d6h		;6303   ; la lista otra vez al principio
	ld (ix+010h),l		;6306
	ld (ix+011h),h		;6309
	call 04b10h		;630c   ; baja
	pop ix		;630f
	ret			;6311
coloca_proyectil:
	ld a,(iy+001h)		;6312   ; mira al mismo lado que quien lo lanza
	ld (ix+012h),a		;6315
	bit 0,(iy+001h)		;6318   ; a la izquierda: x - 16...
	jr z,coloca_der		;631c
	ld a,(iy+006h)		;631e
	sub 010h		;6321
	ld (ix+006h),a		;6323
	jr coloca_y		;6326
coloca_der:
	ld a,(iy+006h)		;6328   ; ...a la derecha: x + 16
	add a,010h		;632b
	ld (ix+006h),a		;632d
coloca_y:
	ld a,(iy+007h)		;6330   ; y + 6
	add a,006h		;6333
	ld (ix+007h),a		;6335
	ld a,016h		;6338   ; tipo 0x16
	ld (ix+000h),a		;633a
	ld a,(ix+001h)		;633d   ; pose 0x10, con el lado
	and 001h		;6340
	or 010h		;6342
	ld (ix+001h),a		;6344
	ret			;6347
mueve_proyectil:
	call casillas_actor		;6348   ; las casillas
	ld a,(ix+021h)		;634b   ; toca una de clase 0x20: se acaba
	and 0f0h		;634e   ; la clase de la casilla (+21)
	cp 020h		;6350   ; clase 0x20?
	jp z,fin_proyectil		;6352
	bit 0,(ix+012h)		;6355   ; hacia la izquierda...
	jr z,mueve_proyectil_der		;6359
	call proyectil_choca_izq		;635b   ; ...p03:6AFF: 0, se acaba
	and a			;635e
	jp z,fin_proyectil		;635f
	ld l,(ix+010h)		;6362   ; el paso siguiente de la lista
	ld h,(ix+011h)		;6365
	inc hl			;6368
	ld a,(hl)			;6369
	cp 0ffh		;636a   ; 0xFF: se acaba
	jp z,fin_proyectil		;636c
	ld a,(ix+006h)		;636f   ; x - paso
	ld l,(ix+010h)		;6372
	ld h,(ix+011h)		;6375
	inc hl			;6378
	ld b,(hl)			;6379
	sub b			;637a
	cp 004h		;637b   ; menos de 4: p03:6AAE
	call c,tope_4		;637d
	ld (ix+006h),a		;6380   ; nueva x
	jr proyectil_y		;6383   ; y la y
mueve_proyectil_der:
	call proyectil_choca_der		;6385   ; hacia la derecha: p03:6B2C...
	and a			;6388   ; ...0: se acaba
	jp z,fin_proyectil		;6389
	ld l,(ix+010h)		;638c   ; el paso siguiente
	ld h,(ix+011h)		;638f
	inc hl			;6392
	ld a,(hl)			;6393
	cp 0ffh		;6394   ; 0xFF: se acaba
	jp z,fin_proyectil		;6396
	ld a,(ix+006h)		;6399   ; x + paso
	ld l,(ix+010h)		;639c
	ld h,(ix+011h)		;639f
	inc hl			;63a2
	ld b,(hl)			;63a3
	add a,b			;63a4
	cp 0e6h		;63a5   ; por la derecha de 0xE6: p03:6AAB
	call nc,tope_e6		;63a7
	ld (ix+006h),a		;63aa
	ld a,(ix+006h)		;63ad   ; y uno mas
	inc a			;63b0
	ld (ix+006h),a		;63b1
proyectil_y:
	inc hl			;63b4   ; el paso en y
	ld a,(hl)			;63b5
	cp 0ffh		;63b6   ; 0xFF: se acaba
	jp z,fin_proyectil		;63b8
	ld b,(hl)			;63bb
	ld a,(ix+007h)		;63bc   ; y + paso
	add a,b			;63bf
	ld (ix+007h),a		;63c0
	ld (ix+010h),l		;63c3   ; apunta por donde va
	ld (ix+011h),h		;63c6
	ld a,(ix+001h)		;63c9   ; pose 0x10 con el lado
	and 001h		;63cc
	or 010h		;63ce
	ld (ix+001h),a		;63d0
	jp pinta_y_vuelve		;63d3

; ----------------------------------------------------------------------
; DATOS pasos_proyectil: Los pasos del proyectil del tipo 0x10: un byte de
;   cabecera y pares (x, y) hasta 0xFF
;   0x63d6..0x63f3  (29 bytes)
DATA_pasos_proyectil:
	defb 000h,000h,000h,002h,001h,002h,000h,002h,000h,002h,001h,002h,002h,002h,002h,002h	; 63d6  ................
	defb 002h,002h,000h,002h,002h,002h,002h,002h,001h,002h,000h,002h,001h	; 63e6  .............

; ----------------------------------------------------------------------
; DATOS resto_63F3: codigo que nadie ejecuta (mira la x de Rastan contra el
;   actor)
;   0x63f3..0x640f  (28 bytes)
DATA_resto_63F3:
	defb 002h,000h,002h,002h,002h,002h,002h,0ffh,03ah,0fch,0d8h,057h,0ddh,0cbh,001h,046h	; 63f3  ........:..W...F
	defb 028h,00ah,0ddh,07eh,006h,0d6h,010h,0bah,0dah,017h,064h,0c9h	; 6403  (..~......d.

; ======================================================================
; CODIGO 0x640f..0x6600  (497 bytes)
; ======================================================================


huerfana_choca_x:
	ld a,(ix+006h)		;640f   ; nadie la llama: si la x del actor >= D...
	cp d			;6412
	jp nc,choca_y		;6413
	ret			;6416
choca_y:
	ld a,(0d8fdh)		;6417   ; ...y su y < la de Rastan...
	ld d,a			;641a
	ld a,(ix+007h)		;641b
	cp d			;641e
	call c,dano_por_choque		;641f   ; ...le hace dano
	ret			;6422

; ----------------------------------------------------------------------
; DANO POR CHOQUE: 8 de vida a Rastan, como p06:7818, y ademas la pose de
; tocado (bit 6) sin el ataque (bit 5).
; ----------------------------------------------------------------------
dano_por_choque:
	ld d,008h		;6423   ; D = 8
	ld a,(0d90fh)		;6425   ; ya tocado...
	bit 6,a		;6428
	ret nz			;642a
	bit 4,a		;642b   ; ...o sin mandos: nada
	ret nz			;642d
	set 4,a		;642e   ; tocado y sin mandos
	set 6,a		;6430
	ld (0d90fh),a		;6432   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(0d904h)		;6435   ; la pose: tocado, sin ataque
	set 6,a		;6438
	res 5,a		;643a
	ld (0d904h),a		;643c   ; la pose de Rastan = a
	ld a,050h		;643f   ; 0x50 cuadros
	ld (0d913h),a		;6441   ; cuenta del estado del jugador = a
	ld a,(0d910h)		;6444   ; D910 bit 7: no pierde vida
	bit 7,a		;6447
	ret nz			;6449
	ld a,(0d91ch)		;644a   ; vida - 8
	sub d			;644d
	ld (0d91ch),a		;644e   ; la vida de Rastan = a
	jr z,muere_por_choque		;6451   ; a 0: muere
	ret nc			;6453
muere_por_choque:
	xor a			;6454   ; vida 0...
	ld (0d91ch),a		;6455   ; la vida de Rastan = a
	ld a,080h		;6458   ; ...y D90F = 0x80: muerto
	ld (0d90fh),a		;645a   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ret			;645d

; ----------------------------------------------------------------------
; Tipo 1: anda; salta (+10/+11/+12: subir y bajar de dos en
; dos pixeles) segun lo que hay delante, y cuando esta cerca para.
; ----------------------------------------------------------------------
tipo_01:
	ld a,(ix+00fh)		;645e   ; sin vida
	and a			;6461
	jp z,muere_actor		;6462
	ld a,(ix+012h)		;6465   ; +12: bajando
	and a			;6468
	jp nz,tipo_01_bajando		;6469
	ld a,(ix+011h)		;646c   ; +11: subiendo
	and a			;646f
	jp nz,tipo_01_subiendo		;6470
	ld a,(ix+010h)		;6473   ; +10: subiendo un poco
	and a			;6476
	jr z,tipo_01_suelo		;6477
	dec a			;6479   ; un cuadro menos...
	ld (ix+010h),a		;647a
	ld a,(ix+007h)		;647d   ; ...y 2 pixeles arriba
	dec a			;6480
	dec a			;6481
	ld (ix+007h),a		;6482
	set 2,(ix+001h)		;6485   ; la pose del salto (bit 2)
	res 1,(ix+001h)		;6489
	call anda		;648d   ; anda
	jp 04a8bh		;6490   ; p00 pinta_actor
tipo_01_suelo:
	res 2,(ix+001h)		;6493   ; fuera la pose del salto
	call nada_debajo		;6497   ; nada debajo?...
	cp 0ffh		;649a
	jp z,cae_1		;649c   ; ...cae
	ld a,(ix+006h)		;649f   ; x < 1: a la derecha
	cp 001h		;64a2
	call c,rebota_izq		;64a4
	cp 0e6h		;64a7   ; x >= 0xE6: a la izquierda
	call nc,rebota_der		;64a9
	call distancia_x		;64ac   ; a cuanto esta de Rastan en x
	cp 004h		;64af   ; menos de 4: p03:656E
	jp c,tipo_01_junto		;64b1
	call casillas_actor		;64b4   ; las casillas
	bit 0,(ix+001h)		;64b7   ; mirando a la izquierda...
	jr z,tipo_01_der		;64bb
	ld a,(ix+018h)		;64bd   ; ...pared delante: da la vuelta
	and 0f0h		;64c0   ; la clase de la casilla (+18)
	cp 020h		;64c2   ; clase 0x20?
	push af			;64c4
	call z,da_la_vuelta		;64c5
	pop af			;64c8
	jp z,tipo_01_fin		;64c9
	ld a,(ix+01bh)		;64cc   ; ...casilla de tipo 2 debajo-delante: p03:661F
	and 00fh		;64cf   ; el tipo de la casilla (+1B)
	cp 002h		;64d1
	jp z,tipo_01_tipo2		;64d3
tipo_01_delante:
	ld a,(ix+01ch)		;64d6   ; la casilla de debajo-delante, nibble bajo:
	and 00fh		;64d9   ; el tipo de la casilla (+1C)
	cp 00fh		;64db   ; 0x0F: p03:6558
	jp z,tipo_01_cerca		;64dd
	cp 001h		;64e0   ; 1: da la vuelta
	push af			;64e2
	call z,da_la_vuelta		;64e3
	pop af			;64e6
	jp z,04a8bh		;64e7   ; p00 pinta_actor
	cp 002h		;64ea   ; 2 o 3: p03:6591
	jp z,tipo_01_escalon		;64ec
	cp 003h		;64ef
	jp z,tipo_01_escalon		;64f1
	cp 004h		;64f4   ; 4: p03:6560
	jp z,tipo_01_anda		;64f6
	cp 005h		;64f9   ; 5 o 6: un salto alto (p03:65B3)
	jp z,tipo_01_salto_alto		;64fb
	cp 006h		;64fe
	jp z,tipo_01_salto_alto		;6500
	jp nc,tipo_01_otra		;6503   ; mas: p03:6602
tipo_01_vuelta:
	call da_la_vuelta		;6506
	jp tipo_01_cerca		;6509
tipo_01_der:
	ld a,(ix+019h)		;650c   ; a la derecha, lo mismo con las otras casillas
	and 0f0h		;650f   ; la clase de la casilla (+19)
	cp 020h		;6511   ; clase 0x20?
	push af			;6513
	call z,da_la_vuelta		;6514
	pop af			;6517
	jp z,tipo_01_fin		;6518
	ld a,(ix+01eh)		;651b
	and 00fh		;651e   ; el tipo de la casilla (+1E)
	cp 002h		;6520
	jp z,tipo_01_tipo2_der		;6522
tipo_01_der_delante:
	ld a,(ix+01dh)		;6525
	and 00fh		;6528   ; el tipo de la casilla (+1D)
	cp 00fh		;652a
	jp z,tipo_01_cerca		;652c
	cp 001h		;652f
	push af			;6531
	call z,da_la_vuelta		;6532
	pop af			;6535
	jp z,04a8bh		;6536   ; p00 pinta_actor
	cp 002h		;6539
	jp z,tipo_01_escalon_der		;653b
	cp 003h		;653e
	jp z,tipo_01_escalon_der		;6540
	cp 004h		;6543
	jp z,tipo_01_anda		;6545
	cp 005h		;6548
	jp z,tipo_01_salto_alto		;654a
	cp 006h		;654d
	jp z,tipo_01_salto_alto		;654f
	jp nc,tipo_01_otra_der		;6552
tipo_01_der_vuelta:
	call da_la_vuelta		;6555
tipo_01_cerca:
	call distancia_x		;6558   ; a 0x30 o mas de Rastan...
	cp 030h		;655b
	jp c,tipo_01_junto		;655d
tipo_01_anda:
	res 2,(ix+001h)		;6560   ; la pose de andar
	res 1,(ix+001h)		;6564
tipo_01_pinta:
	call anda		;6568   ; anda
	jp 04a8bh		;656b   ; p00 pinta_actor
tipo_01_junto:
	ld a,r		;656e   ; cerca: al azar (paridad de R)...
	and a			;6570
	jp po,tipo_01_anda		;6571
	call de_cara		;6574   ; ...de espaldas a Rastan, se da la vuelta
	and a			;6577
	call z,da_la_vuelta		;6578
	call distancia_y		;657b   ; a cuanto esta en y
	cp 018h		;657e   ; lejos: nada
	jp nc,tipo_01_fin		;6580
	set 1,(ix+001h)		;6583   ; pose con el bit 1
	res 2,(ix+001h)		;6587
	jp 04a8bh		;658b   ; p00 pinta_actor
tipo_01_fin:
	jp 04a8bh		;658e   ; p00 pinta_actor
tipo_01_escalon:
	ld a,(ix+017h)		;6591   ; la de encima-delante libre: salta un poco (+10 = 12)
	and 0f0h		;6594   ; la clase de la casilla (+17)
	cp 020h		;6596   ; clase 0x20?
	jp nz,tipo_01_anda		;6598
tipo_01_salta:
	ld (ix+010h),00ch		;659b
	jp tipo_01_anda		;659f
tipo_01_escalon_der:
	ld a,(ix+01ah)		;65a2
	and 0f0h		;65a5   ; la clase de la casilla (+1A)
	cp 020h		;65a7   ; clase 0x20?
	jp nz,tipo_01_anda		;65a9
	ld (ix+010h),00ch		;65ac
	jp tipo_01_anda		;65b0
tipo_01_salto_alto:
	set 2,(ix+001h)		;65b3   ; pose del salto, +11 = 16 cuadros subiendo
	res 1,(ix+001h)		;65b7
	ld (ix+011h),010h		;65bb
	jp tipo_01_fin		;65bf
huerfana_baja:
	ld (ix+012h),010h		;65c2   ; nadie llega aqui: +12 = 16
	jp tipo_01_fin		;65c6
tipo_01_bajando:
	ld a,(ix+007h)		;65c9   ; 2 pixeles abajo
	inc a			;65cc
	inc a			;65cd
	ld (ix+007h),a		;65ce
	ld a,(ix+012h)		;65d1   ; un cuadro menos
	dec a			;65d4
	ld (ix+012h),a		;65d5
	jp tipo_01_pinta		;65d8
tipo_01_subiendo:
	set 2,(ix+001h)		;65db   ; pose del salto
	res 1,(ix+001h)		;65df
	ld a,(ix+007h)		;65e3   ; 2 pixeles arriba
	dec a			;65e6
	dec a			;65e7
	ld (ix+007h),a		;65e8
	ld a,(ix+011h)		;65eb   ; un cuadro menos...
	dec a			;65ee
	ld (ix+011h),a		;65ef
	and a			;65f2   ; ...y al acabar...
	jp z,tipo_01_cumbre		;65f3
	jp tipo_01_pinta		;65f6
tipo_01_cumbre:
	ld (ix+012h),010h		;65f9   ; ...16 cuadros bajando
	jp tipo_01_pinta		;65fd

; ----------------------------------------------------------------------
; DATOS resto_6600: dos `ret` que nadie ejecuta
;   0x6600..0x6602  (2 bytes)
DATA_resto_6600:
	defb 0c9h,0c9h	; 6600

; ======================================================================
; CODIGO 0x6602..0x6968  (870 bytes)
; ======================================================================


tipo_01_otra:
	cp 00fh		;6602   ; 0x0F: da la vuelta
	jp z,tipo_01_vuelta		;6604
	jr tipo_01_vuelta_cerca		;6607
tipo_01_otra_der:
	cp 00fh		;6609
	jp z,tipo_01_der_vuelta		;660b
	jp tipo_01_vuelta_cerca		;660e
tipo_01_vuelta_cerca:
	call da_la_vuelta		;6611   ; da la vuelta...
	call distancia_x		;6614   ; ...y si esta cerca, p03:656E
	cp 030h		;6617
	jp c,tipo_01_junto		;6619
	jp tipo_01_fin		;661c
tipo_01_tipo2:
	ld a,(ix+017h)		;661f   ; la de encima-delante libre: salta
	and 0f0h		;6622   ; la clase de la casilla (+17)
	cp 020h		;6624   ; clase 0x20?
	jp z,tipo_01_salta		;6626
	jp tipo_01_delante		;6629
tipo_01_tipo2_der:
	ld a,(ix+01ah)		;662c
	and 0f0h		;662f   ; la clase de la casilla (+1A)
	cp 020h		;6631   ; clase 0x20?
	jp z,tipo_01_salta		;6633
	jp tipo_01_der_delante		;6636

; ----------------------------------------------------------------------
; Tipo 7: pide el efecto 9 la primera vez; anda y se para en los bordes
; o lejos de Rastan (0x58 en y).
; ----------------------------------------------------------------------
tipo_07:
	ld a,(ix+00fh)		;6639   ; sin vida
	and a			;663c
	jp z,muere_actor		;663d
	ld a,(ix+010h)		;6640   ; la primera vez...
	and a			;6643
	jr nz,tipo_07_mueve		;6644
	ld a,009h		;6646   ; ...efecto 9
	ld (0d178h),a		;6648   ; efecto pedido, para p01:63E1 = a
	ld (ix+010h),0ffh		;664b
tipo_07_mueve:
	call de_cara		;664f   ; de espaldas a Rastan: se da la vuelta
	and a			;6652
	call z,da_la_vuelta		;6653
	ld a,(ix+006h)		;6656   ; x < 0x1E o >= 0xDC: se para
	cp 01eh		;6659
	call c,tipo_07_pinta		;665b
	cp 0dch		;665e
	call nc,tipo_07_pinta		;6660
	ld a,(ix+007h)		;6663   ; y < 0x28: se para
	cp 028h		;6666
	call c,tipo_07_pinta		;6668
	call casillas_actor		;666b   ; las casillas
	ld a,(ix+018h)		;666e   ; pared: se para
	and 0f0h		;6671   ; la clase de la casilla (+18)
	cp 020h		;6673   ; clase 0x20?
	jp z,tipo_07_pinta		;6675
	call anda		;6678   ; anda
	call distancia_y		;667b   ; a cuanto esta en y
	cp 058h		;667e   ; 0x58 o menos: se para
	jr z,tipo_07_pinta		;6680
	jr c,tipo_07_pinta		;6682
	call acerca_y		;6684   ; si no, se acerca a la y de Rastan
	jp 04a8bh		;6687   ; p00 pinta_actor
tipo_07_pinta:
	jp 04a8bh		;668a   ; p00 pinta_actor

; ----------------------------------------------------------------------
; Tipo 4: pide el efecto 9; anda, y en cuanto esta a menos de 0x20 de
; Rastan en x se lanza hacia el (p03:7BA7).
; ----------------------------------------------------------------------
tipo_04:
	ld a,(ix+00fh)		;668d   ; sin vida
	and a			;6690
	jp z,muere_actor		;6691
	ld a,(ix+010h)		;6694   ; la primera vez, efecto 9
	and a			;6697
	jr nz,tipo_04_mueve		;6698
	ld a,009h		;669a
	ld (0d178h),a		;669c   ; efecto pedido, para p01:63E1 = a
	ld (ix+010h),0ffh		;669f
tipo_04_mueve:
	ld a,(ix+00fh)		;66a3
	and a			;66a6
	jp z,muere_actor		;66a7
	call de_cara		;66aa   ; de espaldas: se da la vuelta y nada mas
	and a			;66ad
	jp z,da_la_vuelta		;66ae
	ld a,(ix+006h)		;66b1   ; x < 1: a la derecha
	cp 001h		;66b4
	call c,rebota_izq		;66b6
	cp 0efh		;66b9   ; x >= 0xEF: y = 0xA0 (p03:670A)
	call nc,tipo_04_abajo		;66bb
	ld a,(ix+007h)		;66be   ; y < 0x28: p03:6728
	cp 028h		;66c1
	jp c,tipo_04_baja		;66c3
	call casillas_actor		;66c6   ; las casillas
	bit 0,(ix+001h)		;66c9   ; mirando a la izquierda: pared o suelo raro, se para
	jp z,tipo_04_der		;66cd
	ld a,(ix+017h)		;66d0
	and 0f0h		;66d3   ; la clase de la casilla (+17)
	cp 020h		;66d5   ; clase 0x20?
	jr z,tipo_04_sube		;66d7
	ld a,(ix+01bh)		;66d9
	and 0f0h		;66dc   ; la clase de la casilla (+1B)
	cp 020h		;66de   ; clase 0x20?
	jr z,tipo_04_sube		;66e0
	jr tipo_04_cerca		;66e2
tipo_04_der:
	ld a,(ix+01ah)		;66e4
	and 0f0h		;66e7   ; la clase de la casilla (+1A)
	cp 020h		;66e9   ; clase 0x20?
	jr z,tipo_04_sube		;66eb
	ld a,(ix+01eh)		;66ed
	and 0f0h		;66f0   ; la clase de la casilla (+1E)
	cp 020h		;66f2   ; clase 0x20?
	jr z,tipo_04_sube		;66f4
	call distancia_x		;66f6   ; a menos de 0x20 de Rastan...
	cp 020h		;66f9
	jr c,tipo_04_cerca		;66fb
tipo_04_se_lanza:
	ld a,(0d8fdh)		;66fd   ; ...hacia la y de Rastan - 0x14
	ld b,014h		;6700
	sub b			;6702
	ld (ix+013h),000h		;6703
	jp hacia_y_a		;6707
tipo_04_abajo:
	ld (ix+007h),0a0h		;670a
	ret			;670e
tipo_04_cerca:
	call distancia_y		;670f   ; a cuanto esta en y
	cp 02ah		;6712
	jr nc,tipo_04_se_lanza		;6714   ; lejos: se lanza
	ld a,(0d8fdh)		;6716   ; hacia la y de Rastan - 0x14...
	ld b,014h		;6719
	sub b			;671b
	inc (ix+013h)		;671c   ; ...contando en +13...
	jp hacia_y_b		;671f   ; ...con la pose del bit 1
tipo_04_sube:
	dec (ix+007h)		;6722   ; un pixel arriba
	jp 04a8bh		;6725   ; p00 pinta_actor
tipo_04_baja:
	inc (ix+007h)		;6728   ; un pixel abajo
	jp 04a8bh		;672b   ; p00 pinta_actor
huerfana_tipo_04:
	call de_cara		;672e   ; nadie la llama: de cara a Rastan, se da la vuelta...
	and a			;6731
	jp nz,da_la_vuelta		;6732
	ld a,(ix+006h)		;6735   ; ...fuera de x 0x1E-0xDB, baja...
	cp 0dch		;6738
	jp nc,04b10h		;673a   ; p00 baja_actor
	cp 01eh		;673d
	jp c,04b10h		;673f   ; p00 baja_actor
	jp hacia_y_a		;6742   ; ...y si no, va hacia la y A

; ----------------------------------------------------------------------
; Tipo 0x0D: de cara a Rastan; cae si no hay nada debajo; retrocede un rato
; (+10) y anda de pixel en pixel mientras tenga suelo delante.
; ----------------------------------------------------------------------
tipo_0d:
	ld a,(ix+00fh)		;6745   ; sin vida
	and a			;6748
	jp z,muere_actor		;6749
	call de_cara		;674c   ; de espaldas: se da la vuelta
	and a			;674f
	jp z,da_la_vuelta		;6750
	call nada_debajo		;6753   ; nada debajo: cae
	cp 0ffh		;6756
	jp z,cae_1		;6758
	ld a,(ix+010h)		;675b   ; +10: retrocediendo
	and a			;675e
	jr z,tipo_0d_anda		;675f
	dec a			;6761   ; un cuadro menos...
	ld (ix+010h),a		;6762
	call retrocede_2		;6765   ; ...2 pixeles atras...
	call 044deh		;6768   ; ...y al azar, se pinta y ya
	and 0ffh		;676b
	jp po,04a8bh		;676d   ; p00 pinta_actor
tipo_0d_anda:
	ld a,(ix+006h)		;6770   ; x < 1 o >= 0xEF: rebota
	cp 001h		;6773
	call c,rebota_izq		;6775
	cp 0efh		;6778
	call nc,rebota_der		;677a
	call casillas_actor		;677d   ; las casillas
	bit 0,(ix+001h)		;6780   ; mirando a la izquierda: pared o sin suelo, para
	jr z,tipo_0d_der		;6784
	ld a,(ix+018h)		;6786
	and 0f0h		;6789   ; la clase de la casilla (+18)
	cp 020h		;678b   ; clase 0x20?
	jp z,tipo_0d_retrocede		;678d
	ld a,(ix+01ch)		;6790
	and 0f0h		;6793   ; la clase de la casilla (+1C)
	cp 020h		;6795   ; clase 0x20?
	jp nz,tipo_0d_retrocede		;6797
	jr tipo_0d_avanza		;679a
tipo_0d_der:
	ld a,(ix+01ah)		;679c
	and 0f0h		;679f   ; la clase de la casilla (+1A)
	cp 020h		;67a1   ; clase 0x20?
	jp z,tipo_0d_retrocede		;67a3
	ld a,(ix+01eh)		;67a6
	and 0f0h		;67a9   ; la clase de la casilla (+1E)
	cp 020h		;67ab   ; clase 0x20?
	jp nz,tipo_0d_retrocede		;67ad
tipo_0d_avanza:
	jp anda_1		;67b0   ; un pixel
tipo_0d_retrocede:
	ld (ix+010h),008h		;67b3   ; 8 cuadros hacia atras
	jp 04a8bh		;67b7   ; p00 pinta_actor

; ----------------------------------------------------------------------
; Tipo 3: como el tipo 1 (anda, salta los escalones) pero ademas lanza un
; proyectil (el actor 3, D9A5) cuando esta cerca de Rastan en y.
; ----------------------------------------------------------------------
tipo_03:
	ld a,(ix+00fh)		;67ba   ; sin vida
	and a			;67bd
	jp z,muere_actor		;67be
	ld a,(0d9bah)		;67c1   ; su proyectil en vuelo: se mueve
	cp 00fh		;67c4
	call z,proyectil_03		;67c6
	bit 2,(ix+001h)		;67c9   ; pose bit 2 (lanzando): tambien
	call nz,proyectil_03		;67cd
	ld a,(ix+012h)		;67d0   ; +12: bajando
	and a			;67d3
	jp nz,tipo_03_bajando		;67d4
	ld a,(ix+011h)		;67d7   ; +11: subiendo
	and a			;67da
	jp nz,tipo_03_subiendo		;67db
	ld a,(ix+010h)		;67de   ; +10: subiendo un poco
	and a			;67e1
	jr z,tipo_03_suelo		;67e2
	dec (ix+010h)		;67e4   ; un cuadro menos, 2 pixeles arriba
	dec (ix+007h)		;67e7
	dec (ix+007h)		;67ea
	set 1,(ix+001h)		;67ed   ; pose del salto (bit 1)
	res 2,(ix+001h)		;67f1
	call anda		;67f5   ; anda
	jp 04a8bh		;67f8   ; p00 pinta_actor
tipo_03_suelo:
	res 1,(ix+001h)		;67fb   ; fuera las poses del salto y de lanzar
	res 2,(ix+001h)		;67ff
	call nada_debajo		;6803   ; nada debajo: cae
	cp 0ffh		;6806
	jp z,cae_1		;6808
	ld a,(ix+006h)		;680b   ; x < 1 o >= 0xDC: rebota
	cp 001h		;680e
	call c,rebota_izq		;6810
	cp 0dch		;6813
	call nc,rebota_der		;6815
	call distancia_x		;6818   ; muy cerca en x (menos de 4): p03:68D0
	cp 004h		;681b
	jp c,tipo_03_cerca		;681d
	call casillas_actor		;6820   ; las casillas
	bit 0,(ix+001h)		;6823   ; mirando a la izquierda...
	jr z,tipo_03_der		;6827
	ld a,(ix+018h)		;6829   ; ...pared delante: da la vuelta y nada mas
	and 0f0h		;682c   ; la clase de la casilla (+18)
	cp 020h		;682e   ; clase 0x20?
	push af			;6830
	call z,da_la_vuelta		;6831
	pop af			;6834
	jp z,tipo_03_fin		;6835
	ld a,(ix+01bh)		;6838   ; ...casilla de tipo 2 debajo-delante: p03:6987
	and 00fh		;683b   ; el tipo de la casilla (+1B)
	cp 002h		;683d
	jp z,tipo_03_tipo2		;683f
tipo_03_delante:
	ld a,(ix+01ch)		;6842   ; la de debajo-delante, nibble bajo:
	and 00fh		;6845   ; el tipo de la casilla (+1C)
	cp 00fh		;6847   ; 0x0F: p03:68BA
	jp z,tipo_03_lejos		;6849
	cp 001h		;684c   ; 1: da la vuelta
	jp z,da_la_vuelta		;684e
	cp 002h		;6851   ; 2 o 3: escalon (p03:6901)
	jp z,tipo_03_escalon		;6853
	cp 003h		;6856
	jp z,tipo_03_escalon		;6858
	cp 004h		;685b   ; 4: anda
	jp z,tipo_03_anda		;685d
	cp 005h		;6860   ; 5 o 6: salto alto (p03:6923)
	jp z,tipo_03_salto_alto		;6862
	cp 006h		;6865
	jp z,tipo_03_salto_alto		;6867
	jp nc,tipo_03_otra		;686a   ; mas: p03:696A
tipo_03_vuelta:
	call da_la_vuelta		;686d
	jp tipo_03_lejos		;6870
tipo_03_der:
	ld a,(ix+019h)		;6873   ; a la derecha, igual con las otras casillas
	and 0f0h		;6876   ; la clase de la casilla (+19)
	cp 020h		;6878   ; clase 0x20?
	push af			;687a
	call z,da_la_vuelta		;687b
	pop af			;687e
	jp z,tipo_03_fin		;687f
	ld a,(ix+01eh)		;6882
	and 00fh		;6885   ; el tipo de la casilla (+1E)
	cp 002h		;6887
	jp z,tipo_03_tipo2_der		;6889
tipo_03_der_delante:
	ld a,(ix+01dh)		;688c   ; la de debajo-delante a la derecha
	and 00fh		;688f   ; el tipo de la casilla (+1D)
	cp 00fh		;6891   ; 0x0F?
	jp z,tipo_03_lejos		;6893   ; si: como si no hubiera nada
	cp 001h		;6896   ; 1?
	jp z,da_la_vuelta		;6898   ; si: da la vuelta
	cp 002h		;689b   ; 2?
	jp z,tipo_03_escalon_der		;689d   ; escalon
	cp 003h		;68a0   ; 3?
	jp z,tipo_03_escalon_der		;68a2   ; escalon
	cp 004h		;68a5   ; 4?
	jp z,tipo_03_anda		;68a7   ; anda
	cp 005h		;68aa   ; 5?
	jp z,tipo_03_salto_alto		;68ac   ; salto alto
	cp 006h		;68af   ; 6?
	jp z,tipo_03_salto_alto		;68b1   ; salto alto
	jp nc,tipo_03_otra_der		;68b4   ; mas: lo otro
tipo_03_der_vuelta:
	call da_la_vuelta		;68b7
tipo_03_lejos:
	call distancia_x		;68ba   ; a menos de 0x50 en x: p03:68D0
	cp 050h		;68bd
	jp c,tipo_03_cerca		;68bf
tipo_03_anda:
	res 2,(ix+001h)		;68c2   ; pose de andar
	res 1,(ix+001h)		;68c6
tipo_03_pinta:
	call anda		;68ca   ; 2 pixeles y pintado
	jp 04a8bh		;68cd   ; p00 pinta_actor
tipo_03_cerca:
	ld a,(0d9bah)		;68d0   ; proyectil en vuelo: solo se pinta
	cp 00fh		;68d3
	jp z,tipo_03_quieto		;68d5
	call de_cara		;68d8   ; de espaldas: se da la vuelta
	and a			;68db
	call z,da_la_vuelta		;68dc
	call distancia_y		;68df   ; a 0x20 o mas en y: nada
	cp 020h		;68e2
	jp nc,tipo_03_fin		;68e4
	set 2,(ix+001h)		;68e7   ; pose de lanzar (bit 2)
	res 1,(ix+001h)		;68eb
	push ix		;68ef
	call 04a8bh		;68f1   ; pintado
	pop ix		;68f4
	ld a,(0d9bah)		;68f6   ; sin proyectil: lo lanza
	and a			;68f9
	jp z,proyectil_03		;68fa
	ret			;68fd
tipo_03_fin:
	jp 04a8bh		;68fe   ; p00 pinta_actor
tipo_03_escalon:
	ld a,(ix+017h)		;6901   ; encima-delante libre: salta un poco
	and 0f0h		;6904   ; la clase de la casilla (+17)
	cp 020h		;6906   ; clase 0x20?
	jp nz,tipo_03_anda		;6908
tipo_03_salta:
	ld (ix+010h),00ch		;690b   ; 12 cuadros subiendo
	jp tipo_03_anda		;690f
tipo_03_escalon_der:
	ld a,(ix+01ah)		;6912
	and 0f0h		;6915   ; la clase de la casilla (+1A)
	cp 020h		;6917   ; clase 0x20?
	jp nz,tipo_03_anda		;6919
	ld (ix+010h),00ch		;691c
	jp tipo_03_anda		;6920
tipo_03_salto_alto:
	set 1,(ix+001h)		;6923   ; pose del salto, 16 cuadros subiendo
	res 2,(ix+001h)		;6927
	ld (ix+011h),010h		;692b
	jp tipo_03_fin		;692f
huerfana_tipo_03_baja:
	ld (ix+012h),010h		;6932   ; nadie llega aqui
	jp tipo_03_fin		;6936
tipo_03_bajando:
	inc (ix+007h)		;6939   ; 2 abajo, un cuadro menos
	inc (ix+007h)		;693c
	dec (ix+012h)		;693f
	jp tipo_03_pinta		;6942
tipo_03_subiendo:
	set 1,(ix+001h)		;6945   ; pose del salto, 2 arriba
	res 2,(ix+001h)		;6949
	dec (ix+007h)		;694d
	dec (ix+007h)		;6950
	ld a,(ix+011h)		;6953   ; un cuadro menos...
	dec a			;6956
	ld (ix+011h),a		;6957
	and a			;695a
	jp z,tipo_03_cumbre		;695b
	jp tipo_03_pinta		;695e
tipo_03_cumbre:
	ld (ix+012h),010h		;6961   ; ...y 16 bajando
	jp tipo_03_pinta		;6965

; ----------------------------------------------------------------------
; DATOS resto_6968: dos `ret` que nadie ejecuta
;   0x6968..0x696a  (2 bytes)
DATA_resto_6968:
	defb 0c9h,0c9h	; 6968

; ======================================================================
; CODIGO 0x696a..0x6cca  (864 bytes)
; ======================================================================


tipo_03_otra:
	cp 00fh		;696a
	jp z,tipo_03_vuelta		;696c
	jr tipo_03_vuelta_cerca		;696f
tipo_03_otra_der:
	cp 00fh		;6971
	jp z,tipo_03_der_vuelta		;6973
	jp tipo_03_vuelta_cerca		;6976
tipo_03_vuelta_cerca:
	call da_la_vuelta		;6979   ; se da la vuelta; cerca en x (0x30): p03:68D0
	call distancia_x		;697c
	cp 030h		;697f
	jp c,tipo_03_cerca		;6981
	jp tipo_03_fin		;6984
tipo_03_tipo2:
	ld a,(ix+017h)		;6987
	and 0f0h		;698a   ; la clase de la casilla (+17)
	cp 020h		;698c   ; clase 0x20?
	jp z,tipo_03_salta		;698e
	jp tipo_03_delante		;6991
tipo_03_tipo2_der:
	ld a,(ix+01ah)		;6994
	and 0f0h		;6997   ; la clase de la casilla (+1A)
	cp 020h		;6999   ; clase 0x20?
	jp z,tipo_03_salta		;699b
	jp tipo_03_der_delante		;699e
tipo_03_quieto:
	res 1,(ix+001h)		;69a1   ; sin poses de salto ni de lanzar
	res 2,(ix+001h)		;69a5
	jp 04a8bh		;69a9   ; p00 pinta_actor

; ----------------------------------------------------------------------
; El proyectil del tipo 3: el actor 3 (D9A5). Sale cuando acaba la
; animacion de lanzar, con el efecto 0x0D, y sigue la lista de pasos de
; p04:8BCF; se acaba al tocar una casilla de clase 0x20 o al acabar la lista.
; ----------------------------------------------------------------------
proyectil_03:
	push ix		;69ac   ; IY = el que lanza, IX = el actor 3
	push ix		;69ae
	pop iy		;69b0
	ld ix,0d9a5h		;69b2   ; ix -> actor 3
	ld a,(ix+015h)		;69b6   ; +15 = 0: aun no ha salido
	and a			;69b9
	jr z,lanza_proyectil_03		;69ba
	cp 00fh		;69bc   ; (este `cp` no decide nada)
	jr mueve_proyectil_03		;69be
lanza_proyectil_03:
	bit 7,(iy+002h)		;69c0   ; la animacion de lanzar ha acabado?
	jp z,proyectil_03_fin		;69c4
	ld a,00dh		;69c7   ; efecto 0x0D
	ld (0d178h),a		;69c9   ; efecto pedido, para p01:63E1 = a
	ld (ix+015h),00fh		;69cc   ; en vuelo
	call coloca_proyectil_03		;69d0   ; se coloca
	ld hl,08bcfh		;69d3   ; la lista de pasos de p04:8BCF
	ld (0d9b5h),hl		;69d6   ; actor 3, byte +10 = hl
	push ix		;69d9
	call 048f9h		;69db   ; alta...
	pop ix		;69de
	call 04a8bh		;69e0   ; ...y pintado
proyectil_03_fin:
	pop ix		;69e3
	ret			;69e5
acaba_proyectil_03:
	ld (ix+015h),000h		;69e6   ; ya no hay
	ld hl,08bcfh		;69ea   ; la lista al principio
	ld (ix+010h),l		;69ed
	ld (ix+011h),h		;69f0
	call 04b10h		;69f3   ; baja
	pop ix		;69f6
	ret			;69f8
coloca_proyectil_03:
	ld a,(iy+001h)		;69f9   ; mira al mismo lado
	ld (ix+012h),a		;69fc
	bit 0,(iy+001h)		;69ff   ; a la izquierda: x - 0x0C
	jr z,coloca_03_der		;6a03
	ld a,(iy+006h)		;6a05
	sub 00ch		;6a08
	ld (ix+006h),a		;6a0a
	jr coloca_03_y		;6a0d
coloca_03_der:
	ld a,(iy+006h)		;6a0f   ; a la derecha: x + 0x1C
	add a,01ch		;6a12
	ld (ix+006h),a		;6a14
coloca_03_y:
	ld a,(iy+007h)		;6a17   ; y + 8
	add a,008h		;6a1a
	ld (ix+007h),a		;6a1c
	ld a,016h		;6a1f   ; tipo 0x16, pose con el bit 3
	ld (ix+000h),a		;6a21
	set 3,(ix+001h)		;6a24
	ret			;6a28
mueve_proyectil_03:
	call casillas_actor		;6a29   ; las casillas
	ld a,(ix+021h)		;6a2c   ; toca una de clase 0x20: se acaba
	and 0f0h		;6a2f   ; la clase de la casilla (+21)
	cp 020h		;6a31   ; clase 0x20?
	jp z,acaba_proyectil_03		;6a33
	bit 0,(ix+012h)		;6a36   ; hacia la izquierda...
	jr z,mueve_proyectil_03_der		;6a3a
	call proyectil_toca_izq		;6a3c   ; ...p03:6AB7
	ld l,(ix+010h)		;6a3f   ; el paso siguiente
	ld h,(ix+011h)		;6a42
	inc hl			;6a45
	ld a,(hl)			;6a46
	cp 0ffh		;6a47   ; 0xFF: se acaba
	jp z,acaba_proyectil_03		;6a49
	ld a,(ix+006h)		;6a4c   ; x - paso, sin bajar de 4
	ld l,(ix+010h)		;6a4f
	ld h,(ix+011h)		;6a52
	inc hl			;6a55
	ld b,(hl)			;6a56
	sub b			;6a57
	cp 004h		;6a58
	call c,tope_4		;6a5a
	ld (ix+006h),a		;6a5d
	jr proyectil_03_y		;6a60
mueve_proyectil_03_der:
	call proyectil_toca_der		;6a62   ; hacia la derecha: p03:6ADB
	ld l,(ix+010h)		;6a65
	ld h,(ix+011h)		;6a68
	inc hl			;6a6b
	ld a,(hl)			;6a6c
	cp 0ffh		;6a6d   ; 0xFF: se acaba
	jp z,acaba_proyectil_03		;6a6f
	ld a,(ix+006h)		;6a72   ; x + paso, sin pasar de 0xE6, y uno mas
	ld l,(ix+010h)		;6a75
	ld h,(ix+011h)		;6a78
	inc hl			;6a7b
	ld b,(hl)			;6a7c
	add a,b			;6a7d
	cp 0e6h		;6a7e
	call nc,tope_e6		;6a80
	ld (ix+006h),a		;6a83
	inc (ix+006h)		;6a86
proyectil_03_y:
	inc hl			;6a89   ; el paso en y
	ld a,(hl)			;6a8a
	cp 0ffh		;6a8b   ; 0xFF: se acaba
	jp z,acaba_proyectil_03		;6a8d
	ld b,(hl)			;6a90
	ld a,(ix+007h)		;6a91   ; y + paso
	add a,b			;6a94
	ld (ix+007h),a		;6a95
	ld (ix+010h),l		;6a98   ; apunta por donde va
	ld (ix+011h),h		;6a9b
	ld a,(ix+001h)		;6a9e   ; la pose: bits 0, 1 y 3 de la suya y el 1 y el 3 puestos
	and 00bh		;6aa1
	or 00ah		;6aa3
	ld (ix+001h),a		;6aa5
	jp proyectil_03_pinta		;6aa8
tope_e6:
	ld a,0e6h		;6aab   ; A = 0xE6
	ret			;6aad
tope_4:
	ld a,004h		;6aae   ; A = 4
	ret			;6ab0
proyectil_03_pinta:
	call 04a8bh		;6ab1   ; p00 pinta_actor
	pop ix		;6ab4
	ret			;6ab6

; ----------------------------------------------------------------------
; El proyectil (hacia la izquierda) contra Rastan: si cae en su caja
; (x + 8 a x + 16, y - 4 a y + 0x18), le hace dano.
; ----------------------------------------------------------------------
proyectil_toca_izq:
	ld a,(0d8fch)		;6ab7   ; B = x de Rastan
	ld b,a			;6aba
	ld a,(0d8fdh)		;6abb   ; C = y de Rastan
	ld c,a			;6abe
	ld d,(ix+006h)		;6abf   ; D, E = la x y la y del proyectil
	ld e,(ix+007h)		;6ac2
	ld a,b			;6ac5   ; a la izquierda de x + 8: no
	add a,008h		;6ac6
	cp d			;6ac8
	ret nc			;6ac9
	add a,008h		;6aca   ; a la derecha de x + 16: no
	cp d			;6acc
	ret c			;6acd
	ld a,c			;6ace   ; por encima de y - 4: no
	sub 004h		;6acf
	cp e			;6ad1
	ret nc			;6ad2
	add a,01ch		;6ad3   ; por debajo de y + 0x18: no
	cp e			;6ad5
	ret c			;6ad6
	call dano_por_choque		;6ad7   ; le da
	ret			;6ada
proyectil_toca_der:
	ld a,(0d8fch)		;6adb   ; lo mismo yendo a la derecha (x - 8 a x + 8)
	ld b,a			;6ade
	ld a,(0d8fdh)		;6adf   ; a = la y de Rastan
	ld c,a			;6ae2
	ld d,(ix+006h)		;6ae3
	ld e,(ix+007h)		;6ae6
	ld a,b			;6ae9   ; a la derecha de x + 8: no
	add a,008h		;6aea
	cp d			;6aec
	ret c			;6aed
	sub 010h		;6aee   ; a la izquierda de x - 8: no
	cp d			;6af0
	ret nc			;6af1
	ld a,c			;6af2   ; y entre y - 4 e y + 0x18
	sub 004h		;6af3
	cp e			;6af5
	ret nc			;6af6
	add a,01ch		;6af7
	cp e			;6af9
	ret c			;6afa
	call dano_por_choque		;6afb   ; le da
	ret			;6afe

; ----------------------------------------------------------------------
; Lo mismo pero agachado (pose 4) no le da, y devuelve A = 0 si le ha
; dado: el proyectil se acaba.
; ----------------------------------------------------------------------
proyectil_choca_izq:
	ld a,(0d8f4h)		;6aff   ; agachado: pasa por encima
	and 01eh		;6b02
	cp 004h		;6b04
	ret z			;6b06
	ld a,(0d8fch)		;6b07   ; Rastan
	ld b,a			;6b0a
	ld a,(0d8fdh)		;6b0b   ; a = la y de Rastan
	ld c,a			;6b0e
	ld d,(ix+006h)		;6b0f   ; el proyectil
	ld e,(ix+007h)		;6b12
	ld a,b			;6b15   ; x + 8 a x + 16
	add a,008h		;6b16
	cp d			;6b18
	ret nc			;6b19
	add a,008h		;6b1a
	cp d			;6b1c
	ret c			;6b1d
	ld a,c			;6b1e   ; y - 4 a y + 0x18
	sub 004h		;6b1f
	cp e			;6b21
	ret nc			;6b22
	add a,01ch		;6b23
	cp e			;6b25
	ret c			;6b26
	call dano_por_choque		;6b27   ; le da...
	xor a			;6b2a   ; ...y A = 0
	ret			;6b2b
proyectil_choca_der:
	ld a,(0d8f4h)		;6b2c   ; agachado: pasa por encima
	and 01eh		;6b2f
	cp 004h		;6b31
	ret z			;6b33
	ld a,(0d8fch)		;6b34   ; a = la x de Rastan
	ld b,a			;6b37
	ld a,(0d8fdh)		;6b38   ; a = la y de Rastan
	ld c,a			;6b3b
	ld d,(ix+006h)		;6b3c
	ld e,(ix+007h)		;6b3f
	ld a,b			;6b42   ; x - 8 a x + 8
	add a,008h		;6b43
	cp d			;6b45
	ret c			;6b46
	sub 010h		;6b47
	cp d			;6b49
	ret nc			;6b4a
	ld a,c			;6b4b   ; y - 4 a y + 0x18
	sub 004h		;6b4c
	cp e			;6b4e
	ret nc			;6b4f
	add a,01ch		;6b50
	cp e			;6b52
	ret c			;6b53
	call dano_por_choque		;6b54   ; le da, A = 0
	xor a			;6b57
	ret			;6b58

; ----------------------------------------------------------------------
; Tipo 5: de cara a Rastan; anda deprisa si esta a menos de 0x40 en x y, si
; esta lejos en x pero cerca en y, lanza un proyectil recto (el actor 5).
; ----------------------------------------------------------------------
tipo_05:
	ld a,(ix+00fh)		;6b59   ; sin vida
	and a			;6b5c
	jp z,muere_actor		;6b5d
	ld a,(0da06h)		;6b60   ; proyectil en vuelo: se mueve
	cp 00fh		;6b63
	call z,proyectil_05		;6b65
	bit 1,(ix+001h)		;6b68   ; pose bit 1 (lanzando): tambien
	call nz,proyectil_05		;6b6c
	call de_cara		;6b6f   ; de espaldas: se da la vuelta y nada mas
	and a			;6b72
	jp z,da_la_vuelta		;6b73
	call nada_debajo		;6b76   ; nada debajo: cae
	cp 0ffh		;6b79
	jp z,cae_1		;6b7b
	ld a,(ix+006h)		;6b7e   ; rebota en los bordes
	cp 001h		;6b81
	call c,rebota_izq		;6b83
	cp 0dch		;6b86
	call nc,rebota_der		;6b88
	call casillas_actor		;6b8b   ; las casillas
	bit 0,(ix+001h)		;6b8e   ; mirando a la izquierda: pared o sin suelo, para
	jr z,tipo_05_der		;6b92
	ld a,(ix+018h)		;6b94
	and 0f0h		;6b97   ; la clase de la casilla (+18)
	cp 020h		;6b99   ; clase 0x20?
	jp z,tipo_05_parado		;6b9b
	ld a,(ix+01ch)		;6b9e
	and 0f0h		;6ba1   ; la clase de la casilla (+1C)
	cp 020h		;6ba3   ; clase 0x20?
	jp nz,tipo_05_parado		;6ba5
	jr tipo_05_anda		;6ba8
tipo_05_der:
	ld a,(ix+01ah)		;6baa
	and 0f0h		;6bad   ; la clase de la casilla (+1A)
	cp 020h		;6baf   ; clase 0x20?
	jp z,tipo_05_parado		;6bb1
	ld a,(ix+01eh)		;6bb4
	and 0f0h		;6bb7   ; la clase de la casilla (+1E)
	cp 020h		;6bb9   ; clase 0x20?
	jp nz,tipo_05_parado		;6bbb
tipo_05_anda:
	call distancia_x		;6bbe   ; a menos de 0x40 en x: anda 2 pixeles
	cp 040h		;6bc1
	jr nc,tipo_05_lanza		;6bc3
	jp anda_2		;6bc5
tipo_05_pinta:
	res 1,(ix+001h)		;6bc8   ; pose sin el bit 1
	jp 04a8bh		;6bcc   ; p00 pinta_actor
tipo_05_parado:
	call distancia_x		;6bcf   ; cerca: solo se pinta
	cp 040h		;6bd2
	jr nc,tipo_05_lanza		;6bd4
	jr tipo_05_pinta		;6bd6
tipo_05_lanza:
	ld a,(0da06h)		;6bd8   ; ya hay proyectil: nada
	cp 00fh		;6bdb
	jr z,tipo_05_pinta		;6bdd
	call distancia_y		;6bdf   ; a 0x20 o mas en y: nada
	cp 020h		;6be2
	jp nc,tipo_05_pinta		;6be4
	set 1,(ix+001h)		;6be7   ; pose de lanzar
	push ix		;6beb
	call 04a8bh		;6bed   ; p00 pinta_actor
	pop ix		;6bf0
	ld a,(ix+015h)		;6bf2   ; sin proyectil: lo lanza
	and a			;6bf5
	jp z,proyectil_05		;6bf6
	ret			;6bf9
proyectil_05:
	push ix		;6bfa   ; IY = el que lanza, IX = el actor 5
	push ix		;6bfc
	pop iy		;6bfe
	ld ix,0d9f1h		;6c00   ; ix -> actor 5
	ld a,(ix+015h)		;6c04   ; +15 = 0: aun no ha salido
	cp 000h		;6c07
	jp z,lanza_proyectil_05		;6c09
	cp 00fh		;6c0c   ; (este `cp` no decide nada)
	jr sigue_proyectil_05		;6c0e
lanza_proyectil_05:
	bit 7,(iy+002h)		;6c10   ; la animacion de lanzar ha acabado?
	jp z,proyectil_05_fin		;6c14
	ld (ix+015h),00fh		;6c17   ; en vuelo
	call coloca_proyectil_05		;6c1b   ; se coloca
	call 048f9h		;6c1e   ; alta y pintado
	call 04a8bh		;6c21   ; p00 pinta_actor
proyectil_05_fin:
	pop ix		;6c24
	ret			;6c26
sigue_proyectil_05:
	jp mueve_proyectil_05		;6c27
proyectil_05_pinta:
	call 04a8bh		;6c2a   ; p00 pinta_actor
	pop ix		;6c2d
	ret			;6c2f
coloca_proyectil_05:
	ld (ix+001h),015h		;6c30   ; pose 0x15
	ld a,(iy+001h)		;6c34   ; +13 = la pose del que lanza (el lado)
	ld (ix+013h),a		;6c37
	bit 0,(iy+001h)		;6c3a   ; a la izquierda: +12 bit 0 y x - 0x0C
	jr z,coloca_05_der		;6c3e
	set 0,(ix+012h)		;6c40
	ld a,(iy+006h)		;6c44
	sub 00ch		;6c47
	ld (ix+006h),a		;6c49
	jr coloca_05_y		;6c4c
coloca_05_der:
	res 0,(ix+001h)		;6c4e   ; a la derecha: x + 0x1C
	ld a,(iy+006h)		;6c52
	add a,01ch		;6c55
	ld (ix+006h),a		;6c57
coloca_05_y:
	ld a,(iy+007h)		;6c5a   ; la misma y
	ld (ix+007h),a		;6c5d
	ld a,016h		;6c60   ; tipo 0x16
	ld (ix+000h),a		;6c62
	ret			;6c65
mueve_proyectil_05:
	call casillas_actor		;6c66   ; las casillas
	ld a,(ix+020h)		;6c69   ; toca una de clase 0x20: se acaba
	and 0f0h		;6c6c   ; la clase de la casilla (+20)
	cp 020h		;6c6e   ; clase 0x20?
	jp z,acaba_proyectil_05		;6c70
	ld a,(0d8fch)		;6c73   ; C = x de Rastan + 8
	add a,008h		;6c76
	ld c,a			;6c78
	bit 0,(ix+013h)		;6c79   ; hacia la izquierda...
	jr z,mueve_proyectil_05_der		;6c7d
	call proyectil_choca_izq		;6c7f   ; ...si da a Rastan, se acaba
	and a			;6c82
	jp z,acaba_proyectil_05		;6c83
	ld a,(ix+006h)		;6c86   ; 3 pixeles a la izquierda...
	dec a			;6c89
	dec a			;6c8a
	dec a			;6c8b
	cp 004h		;6c8c   ; ...hasta x = 4
	jp c,acaba_proyectil_05		;6c8e
	ld (ix+006h),a		;6c91
	jr proyectil_05_sigue		;6c94
mueve_proyectil_05_der:
	res 0,(ix+001h)		;6c96   ; hacia la derecha...
	call proyectil_choca_der		;6c9a   ; ...si da a Rastan, se acaba
	and a			;6c9d
	jp z,acaba_proyectil_05		;6c9e
	ld a,(ix+006h)		;6ca1   ; 3 pixeles a la derecha, hasta 0xF0
	inc a			;6ca4
	inc a			;6ca5
	inc a			;6ca6
	cp 0f0h		;6ca7
	jp nc,acaba_proyectil_05		;6ca9
	ld (ix+006h),a		;6cac
proyectil_05_sigue:
	jp proyectil_05_pinta		;6caf
acaba_proyectil_05:
	ld ix,0d9f1h		;6cb2   ; el actor 5...
	ld (ix+015h),000h		;6cb6   ; ...ya no esta...
	call 04b10h		;6cba   ; ...y se da de baja
	pop ix		;6cbd
	ret			;6cbf
huerfana_baja_actor5:
	ld ix,0d9f1h		;6cc0   ; nadie la llama: baja del actor 5
	call 04b10h		;6cc4   ; p00 baja_actor
	pop ix		;6cc7
	ret			;6cc9

; ----------------------------------------------------------------------
; DATOS resto_6CCA: un trozo que nadie ejecuta (distancia en y a Rastan)
;   0x6cca..0x6cdc  (18 bytes)
DATA_resto_6CCA:
	defb 03ah,0fdh,0d8h,0ddh,046h,007h,090h,0e6h,07fh,0feh,008h,038h,002h,0afh,0c9h,03eh	; 6cca  :...F......8...>
	defb 0ffh,0c9h	; 6cda

; ======================================================================
; CODIGO 0x6cdc..0x703d  (865 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Tipo 9: de cara a Rastan. Lejos (mas de 0x50 en x) anda hacia el; justo a
; 0x50 se para; mas cerca retrocede o lanza un proyectil (el actor 4).
; ----------------------------------------------------------------------
tipo_09:
	ld a,(ix+00fh)		;6cdc   ; sin vida
	and a			;6cdf
	jp z,muere_actor		;6ce0
	ld a,(0d9e0h)		;6ce3   ; proyectil en vuelo: se mueve
	cp 00fh		;6ce6
	call z,proyectil_09		;6ce8
	bit 1,(ix+001h)		;6ceb   ; pose bit 1 (lanzando): tambien
	call nz,proyectil_09		;6cef
	call de_cara		;6cf2   ; de espaldas: se da la vuelta
	and a			;6cf5
	call z,da_la_vuelta		;6cf6
	call nada_debajo		;6cf9   ; nada debajo: cae
	cp 0ffh		;6cfc
	jp z,cae_1		;6cfe
	call distancia_x		;6d01   ; a cuanto esta en x
	cp 050h		;6d04
	jp z,tipo_09_quieto		;6d06   ; justo 0x50: quieto
	jp c,tipo_09_cerca		;6d09   ; mas cerca: p03:6D56
	bit 0,(ix+001h)		;6d0c   ; mirando a la izquierda...
	jr z,tipo_09_der		;6d10
	ld a,(ix+01ch)		;6d12   ; ...casilla de tipo 1 debajo-delante: quieto
	and 00fh		;6d15   ; el tipo de la casilla (+1C)
	cp 001h		;6d17
	jp z,tipo_09_quieto		;6d19
	ld a,(ix+018h)		;6d1c   ; ...pared: quieto
	and 0f0h		;6d1f   ; la clase de la casilla (+18)
	cp 020h		;6d21   ; clase 0x20?
	jp z,tipo_09_quieto		;6d23
	jp tipo_09_anda		;6d26
tipo_09_der:
	ld a,(ix+01dh)		;6d29
	and 00fh		;6d2c   ; el tipo de la casilla (+1D)
	cp 001h		;6d2e
	jp z,tipo_09_quieto		;6d30
	ld a,(ix+019h)		;6d33
	and 0f0h		;6d36   ; la clase de la casilla (+19)
	cp 020h		;6d38   ; clase 0x20?
	jr z,tipo_09_quieto		;6d3a
tipo_09_anda:
	ld a,(0d9e0h)		;6d3c   ; con proyectil en vuelo no anda
	and a			;6d3f
	jp nz,tipo_09_quieto		;6d40
	call anda		;6d43   ; 2 pixeles, pose de andar, pintado
	res 1,(ix+001h)		;6d46
	call 04a8bh		;6d4a   ; p00 pinta_actor
	ret			;6d4d
tipo_09_quieto:
	res 1,(ix+001h)		;6d4e
	call 04a8bh		;6d52   ; p00 pinta_actor
	ret			;6d55
tipo_09_cerca:
	ld a,(ix+006h)		;6d56   ; en los bordes (x < 0x10 o >= 0xDC): lanza
	cp 010h		;6d59
	jp c,tipo_09_lanza		;6d5b
	cp 0dch		;6d5e
	jp nc,tipo_09_lanza		;6d60
	bit 0,(ix+001h)		;6d63   ; mirando a la izquierda: la de detras...
	jp z,tipo_09_cerca_der		;6d67
	ld a,(ix+01ah)		;6d6a   ; ...pared o sin suelo: lanza
	and 0f0h		;6d6d   ; la clase de la casilla (+1A)
	cp 020h		;6d6f   ; clase 0x20?
	jp z,tipo_09_lanza		;6d71
	ld a,(ix+01eh)		;6d74
	and 0f0h		;6d77   ; la clase de la casilla (+1E)
	cp 020h		;6d79   ; clase 0x20?
	jp nz,tipo_09_lanza		;6d7b
	res 1,(ix+001h)		;6d7e   ; si no, retrocede 2 pixeles
	call retrocede_2		;6d82
	jp 04a8bh		;6d85   ; p00 pinta_actor
tipo_09_cerca_der:
	ld a,(ix+017h)		;6d88
	and 0f0h		;6d8b   ; la clase de la casilla (+17)
	cp 020h		;6d8d   ; clase 0x20?
	jp z,tipo_09_lanza		;6d8f
	ld a,(ix+01bh)		;6d92
	and 0f0h		;6d95   ; la clase de la casilla (+1B)
	cp 020h		;6d97   ; clase 0x20?
	jp nz,tipo_09_lanza		;6d99
	res 1,(ix+001h)		;6d9c
	call retrocede_2		;6da0
	jp 04a8bh		;6da3   ; p00 pinta_actor
tipo_09_lanza:
	ld a,(0d9e0h)		;6da6   ; ya hay proyectil: quieto
	cp 00fh		;6da9
	jr z,tipo_09_pinta		;6dab
	set 1,(ix+001h)		;6dad   ; pose de lanzar
	push ix		;6db1
	call 04a8bh		;6db3   ; p00 pinta_actor
	pop ix		;6db6
	ld a,(ix+015h)		;6db8   ; sin proyectil: lo lanza
	and a			;6dbb
	jp z,proyectil_09		;6dbc
tipo_09_pinta:
	res 1,(ix+001h)		;6dbf
	jp 04a8bh		;6dc3   ; p00 pinta_actor
da_la_vuelta_y_vuelve:
	call da_la_vuelta		;6dc6
	ret			;6dc9
proyectil_09:
	push ix		;6dca   ; IY = el que lanza, IX = el actor 4
	push ix		;6dcc
	pop iy		;6dce
	ld ix,0d9cbh		;6dd0   ; ix -> actor 4
	ld a,(ix+015h)		;6dd4   ; +15 = 0: aun no ha salido
	cp 000h		;6dd7
	jp z,lanza_proyectil_09		;6dd9
	cp 00fh		;6ddc   ; (este `cp` no decide nada)
	jr mueve_proyectil_09		;6dde
lanza_proyectil_09:
	bit 7,(iy+002h)		;6de0   ; la animacion de lanzar ha acabado?
	jp z,proyectil_09_fin		;6de4
	ld (ix+015h),00fh		;6de7   ; en vuelo
	call coloca_proyectil_09		;6deb   ; se coloca
	call 048f9h		;6dee   ; alta y pintado
	call 04a8bh		;6df1   ; p00 pinta_actor
proyectil_09_fin:
	pop ix		;6df4
	ret			;6df6
proyectil_09_pinta:
	call 04a8bh		;6df7   ; p00 pinta_actor
	pop ix		;6dfa
	ret			;6dfc
acaba_proyectil_09:
	ld (ix+015h),000h		;6dfd   ; ya no esta, y baja
	call 04b10h		;6e01   ; p00 baja_actor
	pop ix		;6e04
	ret			;6e06
coloca_proyectil_09:
	ld (ix+001h),013h		;6e07   ; pose 0x13
	bit 0,(iy+001h)		;6e0b   ; a la izquierda: x - 0x10
	jr z,coloca_09_der		;6e0f
	set 0,(ix+012h)		;6e11
	ld a,(iy+006h)		;6e15
	sub 010h		;6e18
	ld (ix+006h),a		;6e1a
	jr coloca_09_y		;6e1d
coloca_09_der:
	res 0,(ix+001h)		;6e1f   ; a la derecha: x + 0x20
	ld a,(iy+006h)		;6e23
	add a,020h		;6e26
	ld (ix+006h),a		;6e28
coloca_09_y:
	ld a,(iy+007h)		;6e2b
	ld (ix+007h),a		;6e2e
	ld a,016h		;6e31   ; tipo 0x16
	ld (ix+000h),a		;6e33
	ret			;6e36
mueve_proyectil_09:
	call casillas_actor		;6e37   ; las casillas
	ld a,(ix+020h)		;6e3a   ; toca una de clase 0x20: se acaba
	and 0f0h		;6e3d   ; la clase de la casilla (+20)
	cp 020h		;6e3f   ; clase 0x20?
	jp z,acaba_proyectil_09_b		;6e41
	ld a,(0d8fch)		;6e44   ; C = x de Rastan + 8
	add a,008h		;6e47
	ld c,a			;6e49
	bit 0,(ix+001h)		;6e4a   ; hacia la izquierda: si da a Rastan, se acaba
	jr z,mueve_proyectil_09_der		;6e4e
	call proyectil_choca_izq		;6e50
	and a			;6e53
	jp z,acaba_proyectil_09_b		;6e54
	ld a,(ix+006h)		;6e57   ; 2 pixeles a la izquierda, hasta 4
	dec a			;6e5a
	dec a			;6e5b
	cp 004h		;6e5c
	jp c,acaba_proyectil_09_b		;6e5e
	ld (ix+006h),a		;6e61
	jr proyectil_09_sigue		;6e64
mueve_proyectil_09_der:
	call proyectil_choca_der		;6e66   ; hacia la derecha: si da a Rastan, se acaba
	and a			;6e69
	jp z,acaba_proyectil_09_b		;6e6a
	ld a,(ix+006h)		;6e6d   ; 2 pixeles a la derecha, hasta 0xF0
	inc a			;6e70
	inc a			;6e71
	cp 0f0h		;6e72
	jp nc,acaba_proyectil_09_b		;6e74
	ld (ix+006h),a		;6e77
proyectil_09_sigue:
	jp proyectil_09_pinta		;6e7a
acaba_proyectil_09_b:
	ld ix,0d9cbh		;6e7d   ; el actor 4 ya no esta...
	ld (ix+015h),000h		;6e81
	call 04b10h		;6e85   ; ...y se da de baja
	pop ix		;6e88
	ret			;6e8a
huerfana_baja_actor4:
	ld ix,0d9cbh		;6e8b   ; nadie la llama: baja del actor 4
	call 04b10h		;6e8f   ; p00 baja_actor
	pop ix		;6e92
	ret			;6e94

; ----------------------------------------------------------------------
; Tipo 0x13: como el tipo 1 (anda, sube escalones, salta) pero no se mueve
; en todos los cuadros: R & 0x52 con paridad impar, solo se pinta.
; ----------------------------------------------------------------------
tipo_13:
	ld a,(ix+00fh)		;6e95   ; sin vida
	and a			;6e98
	jp z,muere_actor		;6e99
	ld a,r		;6e9c   ; al azar, este cuadro no se mueve
	and 052h		;6e9e
	jp po,04a8bh		;6ea0   ; p00 pinta_actor
	ld a,(ix+012h)		;6ea3   ; +12: bajando
	and a			;6ea6
	jp nz,tipo_13_bajando		;6ea7
	ld a,(ix+011h)		;6eaa   ; +11: subiendo
	and a			;6ead
	jp nz,tipo_13_subiendo		;6eae
	ld a,(ix+010h)		;6eb1   ; +10: subiendo un poco
	and a			;6eb4
	jr z,tipo_13_suelo		;6eb5
	dec a			;6eb7   ; un cuadro menos...
	ld (ix+010h),a		;6eb8
	ld a,(ix+007h)		;6ebb   ; ...2 pixeles arriba
	dec a			;6ebe
	dec a			;6ebf
	ld (ix+007h),a		;6ec0
	res 1,(ix+001h)		;6ec3   ; fuera las poses 1 y 2
	res 2,(ix+001h)		;6ec7
	call anda		;6ecb   ; anda
	jp 04a8bh		;6ece   ; p00 pinta_actor
tipo_13_suelo:
	call de_cara		;6ed1   ; de espaldas: se da la vuelta
	and a			;6ed4
	call z,da_la_vuelta		;6ed5
	call nada_debajo		;6ed8   ; nada debajo: cae
	cp 0ffh		;6edb
	jp z,cae_1		;6edd
	ld a,(ix+006h)		;6ee0   ; rebota en los bordes
	cp 001h		;6ee3
	call c,rebota_izq		;6ee5
	cp 0dch		;6ee8
	call nc,rebota_der		;6eea
	call distancia_x		;6eed   ; muy cerca en x: p03:6FAD
	cp 004h		;6ef0
	jp c,tipo_13_cerca		;6ef2
	call casillas_actor		;6ef5   ; las casillas
	bit 0,(ix+001h)		;6ef8   ; mirando a la izquierda...
	jr z,tipo_13_der		;6efc
	ld a,(ix+018h)		;6efe   ; ...pared: da la vuelta y nada mas
	and 0f0h		;6f01   ; la clase de la casilla (+18)
	cp 020h		;6f03   ; clase 0x20?
	push af			;6f05
	call z,da_la_vuelta		;6f06
	pop af			;6f09
	jp z,tipo_13_fin		;6f0a
	ld a,(ix+01bh)		;6f0d   ; ...casilla de tipo 2 debajo-delante: p03:705C
	and 00fh		;6f10   ; el tipo de la casilla (+1B)
	cp 002h		;6f12
	jp z,tipo_13_tipo2		;6f14
tipo_13_delante:
	ld a,(ix+01ch)		;6f17   ; la de debajo-delante, nibble bajo:
	and 00fh		;6f1a   ; el tipo de la casilla (+1C)
	cp 00fh		;6f1c   ; 0x0F: p03:6F8F
	jp z,tipo_13_lejos		;6f1e
	cp 001h		;6f21   ; 1: da la vuelta
	jp z,da_la_vuelta		;6f23
	cp 002h		;6f26   ; 2 o 3: escalon
	jp z,tipo_13_escalon		;6f28
	cp 003h		;6f2b
	jp z,tipo_13_escalon		;6f2d
	cp 004h		;6f30   ; 4: anda
	jp z,tipo_13_anda		;6f32
	cp 005h		;6f35   ; 5 o 6: salto alto
	jp z,tipo_13_salto_alto		;6f37
	cp 006h		;6f3a
	jp z,tipo_13_salto_alto		;6f3c
	jp nc,tipo_13_otra		;6f3f   ; mas: p03:703F
tipo_13_vuelta:
	call da_la_vuelta		;6f42
	jp tipo_13_lejos		;6f45
tipo_13_der:
	ld a,(ix+019h)		;6f48   ; a la derecha, igual
	and 0f0h		;6f4b   ; la clase de la casilla (+19)
	cp 020h		;6f4d   ; clase 0x20?
	push af			;6f4f
	call z,da_la_vuelta		;6f50
	pop af			;6f53
	jp z,tipo_13_fin		;6f54
	ld a,(ix+01eh)		;6f57
	and 00fh		;6f5a   ; el tipo de la casilla (+1E)
	cp 002h		;6f5c
	jp z,tipo_13_tipo2_der		;6f5e
tipo_13_der_delante:
	ld a,(ix+01dh)		;6f61   ; la de debajo-delante a la derecha
	and 00fh		;6f64   ; el tipo de la casilla (+1D)
	cp 00fh		;6f66   ; 0x0F?
	jp z,tipo_13_lejos		;6f68   ; si: como si no hubiera nada
	cp 001h		;6f6b   ; 1?
	jp z,da_la_vuelta		;6f6d   ; si: da la vuelta
	cp 002h		;6f70   ; 2?
	jp z,tipo_13_escalon_der		;6f72   ; escalon
	cp 003h		;6f75   ; 3?
	jp z,tipo_13_escalon_der		;6f77   ; escalon
	cp 004h		;6f7a   ; 4?
	jp z,tipo_13_anda		;6f7c   ; anda
	cp 005h		;6f7f   ; 5?
	jp z,tipo_13_salto_alto		;6f81   ; salto alto
	cp 006h		;6f84   ; 6?
	jp z,tipo_13_salto_alto		;6f86   ; salto alto
	jp nc,tipo_13_otra_der		;6f89   ; mas: lo otro
tipo_13_der_vuelta:
	call da_la_vuelta		;6f8c
tipo_13_lejos:
	call distancia_x		;6f8f   ; a menos de 0x30 en x: p03:6FAD
	cp 030h		;6f92
	jp c,tipo_13_cerca		;6f94
tipo_13_anda:
	res 1,(ix+001h)		;6f97   ; fuera las poses 1 y 2
	res 2,(ix+001h)		;6f9b
tipo_13_pinta:
	res 2,(ix+001h)		;6f9f   ; fuera las 2 y 3
	res 3,(ix+001h)		;6fa3
	call anda		;6fa7   ; anda 2 pixeles
	jp 04a8bh		;6faa   ; p00 pinta_actor
tipo_13_cerca:
	call de_cara		;6fad   ; de cara a Rastan
	and a			;6fb0
	call z,da_la_vuelta		;6fb1
	call distancia_y		;6fb4   ; a 0x18 o mas en y: nada
	cp 018h		;6fb7
	jp nc,tipo_13_fin		;6fb9
	set 1,(ix+001h)		;6fbc   ; pose bit 1
	res 2,(ix+001h)		;6fc0
	res 3,(ix+001h)		;6fc4
	jp 04a8bh		;6fc8   ; p00 pinta_actor
tipo_13_fin:
	jp 04a8bh		;6fcb   ; p00 pinta_actor
tipo_13_escalon:
	ld a,(ix+017h)		;6fce   ; encima-delante libre: salta un poco
	and 0f0h		;6fd1   ; la clase de la casilla (+17)
	cp 020h		;6fd3   ; clase 0x20?
	jp nz,tipo_13_anda		;6fd5
tipo_13_salta:
	ld (ix+010h),00ch		;6fd8   ; 12 cuadros subiendo
	jp tipo_13_anda		;6fdc
tipo_13_escalon_der:
	ld a,(ix+01ah)		;6fdf
	and 0f0h		;6fe2   ; la clase de la casilla (+1A)
	cp 020h		;6fe4   ; clase 0x20?
	jp nz,tipo_13_anda		;6fe6
	ld (ix+010h),00ch		;6fe9
	jp tipo_13_anda		;6fed
tipo_13_salto_alto:
	res 1,(ix+001h)		;6ff0   ; pose bit 3, 16 cuadros subiendo
	res 2,(ix+001h)		;6ff4
	set 3,(ix+001h)		;6ff8
	ld (ix+011h),010h		;6ffc
	jp tipo_13_fin		;7000
huerfana_tipo_13_baja:
	ld (ix+012h),010h		;7003   ; nadie llega aqui
	jp tipo_13_fin		;7007
tipo_13_bajando:
	ld a,(ix+007h)		;700a   ; 2 abajo, un cuadro menos
	inc a			;700d
	inc a			;700e
	ld (ix+007h),a		;700f
	ld a,(ix+012h)		;7012
	dec a			;7015
	ld (ix+012h),a		;7016
	jp tipo_13_pinta		;7019
tipo_13_subiendo:
	res 1,(ix+001h)		;701c   ; 2 arriba, un cuadro menos
	ld a,(ix+007h)		;7020   ; la y...
	dec a			;7023   ; ...2 pixeles arriba
	dec a			;7024
	ld (ix+007h),a		;7025   ; guardada
	ld a,(ix+011h)		;7028   ; cuadros de subida...
	dec a			;702b   ; ...uno menos
	ld (ix+011h),a		;702c
	and a			;702f   ; acabados?
	jp z,tipo_13_cumbre		;7030   ; si: a bajar
	jp tipo_13_pinta		;7033   ; no: pintado
tipo_13_cumbre:
	ld (ix+012h),010h		;7036   ; 16 cuadros bajando
	jp tipo_13_pinta		;703a

; ----------------------------------------------------------------------
; DATOS resto_703D: dos `ret` que nadie ejecuta
;   0x703d..0x703f  (2 bytes)
DATA_resto_703D:
	defb 0c9h,0c9h	; 703d

; ======================================================================
; CODIGO 0x703f..0x730c  (717 bytes)
; ======================================================================


tipo_13_otra:
	cp 00fh		;703f
	jp z,tipo_13_vuelta		;7041
	jr tipo_13_vuelta_cerca		;7044
tipo_13_otra_der:
	cp 00fh		;7046
	jp z,tipo_13_der_vuelta		;7048
	jp tipo_13_vuelta_cerca		;704b
tipo_13_vuelta_cerca:
	call da_la_vuelta		;704e   ; se da la vuelta; cerca en x: p03:6FAD
	call distancia_x		;7051
	cp 030h		;7054
	jp c,tipo_13_cerca		;7056
	jp tipo_13_fin		;7059
tipo_13_tipo2:
	ld a,(ix+017h)		;705c
	and 0f0h		;705f   ; la clase de la casilla (+17)
	cp 020h		;7061   ; clase 0x20?
	jp z,tipo_13_salta		;7063
	jp tipo_13_delante		;7066
tipo_13_tipo2_der:
	ld a,(ix+01ah)		;7069
	and 0f0h		;706c   ; la clase de la casilla (+1A)
	cp 020h		;706e   ; clase 0x20?
	jp z,tipo_13_salta		;7070
	jp tipo_13_der_delante		;7073

; ----------------------------------------------------------------------
; Tipo 0x0F: patrulla. Anda de 4 en 4 pixeles y da la vuelta en los bordes,
; contra una pared o donde se acaba el suelo; no mira a Rastan.
; ----------------------------------------------------------------------
tipo_0f:
	ld a,(ix+00fh)		;7076   ; sin vida
	and a			;7079
	jp z,muere_actor		;707a
	ld a,(ix+006h)		;707d   ; x < 2 o >= 0xF0: da la vuelta
	cp 002h		;7080
	call c,da_la_vuelta		;7082
	cp 0f0h		;7085
	call nc,da_la_vuelta		;7087
	call casillas_actor		;708a   ; las casillas
	bit 0,(ix+001h)		;708d   ; mirando a la izquierda: pared delante...
	jr z,tipo_0f_der		;7091
	ld a,(ix+018h)		;7093
	and 0f0h		;7096   ; la clase de la casilla (+18)
	cp 020h		;7098   ; clase 0x20?
	call z,da_la_vuelta		;709a
	ld a,(ix+01bh)		;709d   ; ...o sin suelo delante: da la vuelta
	and 0f0h		;70a0   ; la clase de la casilla (+1B)
	cp 020h		;70a2   ; clase 0x20?
	call nz,da_la_vuelta		;70a4
	jr tipo_0f_anda		;70a7
tipo_0f_der:
	ld a,(ix+019h)		;70a9
	and 0f0h		;70ac   ; la clase de la casilla (+19)
	cp 020h		;70ae   ; clase 0x20?
	call z,da_la_vuelta		;70b0
	ld a,(ix+01eh)		;70b3
	and 0f0h		;70b6   ; la clase de la casilla (+1E)
	cp 020h		;70b8   ; clase 0x20?
	call nz,da_la_vuelta		;70ba
tipo_0f_anda:
	call anda		;70bd   ; dos veces 2 pixeles
	call anda		;70c0
	jp 04a8bh		;70c3   ; p00 pinta_actor

; ----------------------------------------------------------------------
; Tipo 0x0A: de cara a Rastan; anda deprisa hasta 0x10 de el en x, y segun
; el tipo de la casilla de encima-delante (1, 2-4, 5 o mas) cambia de paso.
; ----------------------------------------------------------------------
tipo_0a:
	ld a,(ix+00fh)		;70c6   ; sin vida
	and a			;70c9
	jp z,muere_actor		;70ca
	call de_cara		;70cd   ; de espaldas: se da la vuelta y nada mas
	and a			;70d0
	jp z,da_la_vuelta		;70d1
	call nada_debajo_16		;70d4   ; nada en la fila de debajo (p03:7ED7): cae
	cp 0ffh		;70d7
	jp z,cae_1		;70d9
	jp z,cae_1		;70dc   ; (el segundo `jp z` no sirve)
	ld a,(ix+006h)		;70df   ; rebota en los bordes
	cp 001h		;70e2
	call c,rebota_izq		;70e4
	cp 0efh		;70e7
	call nc,rebota_der		;70e9
	call casillas_actor		;70ec   ; las casillas
	bit 0,(ix+001h)		;70ef   ; mirando a la izquierda: la de encima-delante...
	jr z,tipo_0a_der		;70f3
	ld a,(ix+018h)		;70f5
	and 00fh		;70f8   ; el tipo de la casilla (+18)
	cp 001h		;70fa   ; ...tipo 1: p03:7146
	jp z,tipo_0a_casilla_1		;70fc
	cp 002h		;70ff   ; ...tipo 2 o mas: p03:716E
	jr nc,tipo_0a_2		;7101
tipo_0a_5:
	cp 005h		;7103   ; 5 o mas: p03:7159
	jr nc,tipo_0a_alta		;7105
tipo_0a_pared:
	ld a,(ix+020h)		;7107   ; pared delante: p03:7146
	and 0f0h		;710a   ; la clase de la casilla (+20)
	cp 020h		;710c   ; clase 0x20?
	jr z,tipo_0a_casilla_1		;710e
	jr tipo_0a_anda		;7110
tipo_0a_der:
	ld a,(ix+019h)		;7112
	and 00fh		;7115   ; el tipo de la casilla (+19)
	cp 001h		;7117
	jr z,tipo_0a_casilla_1		;7119
	cp 002h		;711b
	jr nc,tipo_0a_der_2		;711d
tipo_0a_der_5:
	cp 005h		;711f
	jr nc,tipo_0a_der_alta		;7121
tipo_0a_der_pared:
	ld a,(ix+021h)		;7123
	and 0f0h		;7126   ; la clase de la casilla (+21)
	cp 020h		;7128   ; clase 0x20?
	jr z,tipo_0a_casilla_1		;712a
tipo_0a_anda:
	call distancia_x_7		;712c   ; a menos de 0x10 en x (con +7): quieto
	cp 010h		;712f
	jr c,tipo_0a_cerca		;7131
	call anda		;7133   ; dos veces 2 pixeles
	call anda		;7136
	res 1,(ix+001h)		;7139   ; pose sin el bit 1
	jp 04a8bh		;713d   ; p00 pinta_actor
tipo_0a_pinta:
	jp 04a8bh		;7140   ; p00 pinta_actor
tipo_0a_cerca:
	jp pose_b1_y_pinta		;7143   ; pose del bit 1 y pintado
tipo_0a_casilla_1:
	call distancia_x_7		;7146   ; cerca en x: pose del bit 1
	cp 010h		;7149
	jr c,tipo_0a_cerca		;714b
	res 1,(ix+001h)		;714d   ; si no, sin el bit 1
	jr tipo_0a_pinta		;7151
tipo_0a_der_alta:
	cp 00fh		;7153   ; 0x0F: como si no hubiera nada
	jr z,tipo_0a_der_pared		;7155
	jr tipo_0a_casilla_1		;7157
tipo_0a_alta:
	cp 00fh		;7159
	jr z,tipo_0a_pared		;715b
	jr tipo_0a_casilla_1		;715d
tipo_0a_der_2:
	cp 005h		;715f   ; 5 o mas: la siguiente comprobacion
	jr nc,tipo_0a_der_5		;7161
	ld a,(ix+022h)		;7163   ; la casilla de +22 de clase 0xF0 (nada): anda
	and 0f0h		;7166   ; la clase de la casilla (+22)
	cp 0f0h		;7168   ; clase 0xF0?
	jr z,tipo_0a_anda		;716a
	jr tipo_0a_casilla_1		;716c
tipo_0a_2:
	cp 005h		;716e
	jr nc,tipo_0a_5		;7170
	ld a,(ix+01fh)		;7172   ; la de +1F de clase 0xF0: anda
	and 0f0h		;7175   ; la clase de la casilla (+1F)
	cp 0f0h		;7177   ; clase 0xF0?
	jr z,tipo_0a_anda		;7179
	jr tipo_0a_casilla_1		;717b

; ----------------------------------------------------------------------
; Tipo 6: se queda escondido (pose bit 2) hasta que acaba su animacion de
; salir (+2 = 4); luego, cada cuadro que toca (R & 0x76 con paridad par),
; como el tipo 1: anda, sube escalones y salta.
; ----------------------------------------------------------------------
tipo_06:
	bit 2,(ix+001h)		;717d   ; aun escondido (bit 2)...
	jp nz,tipo_06_escondido		;7181
	ld a,(ix+014h)		;7184   ; ...o +14 = 0: p03:7345
	and a			;7187
	jp z,tipo_06_escondido		;7188
tipo_06_activo:
	ld a,(ix+00fh)		;718b   ; sin vida
	and a			;718e
	jp z,muere_actor		;718f
	ld a,r		;7192   ; al azar, este cuadro no se mueve
	and 076h		;7194
	jp po,04a8bh		;7196   ; p00 pinta_actor
	ld a,(ix+012h)		;7199   ; +12: bajando
	and a			;719c
	jp nz,tipo_06_bajando		;719d
	ld a,(ix+011h)		;71a0   ; +11: subiendo
	and a			;71a3
	jp nz,tipo_06_subiendo		;71a4
	ld a,(ix+010h)		;71a7   ; +10: subiendo un poco
	and a			;71aa
	jr z,tipo_06_suelo		;71ab
	dec a			;71ad   ; un cuadro menos, 2 arriba
	ld (ix+010h),a		;71ae
	ld a,(ix+007h)		;71b1
	dec a			;71b4
	dec a			;71b5
	ld (ix+007h),a		;71b6
	res 1,(ix+001h)		;71b9   ; pose sin el bit 1
	call anda		;71bd   ; anda
	jp 04a8bh		;71c0   ; p00 pinta_actor
tipo_06_suelo:
	call nada_debajo		;71c3   ; nada debajo: cae
	cp 0ffh		;71c6
	jp z,cae_1		;71c8
	ld a,(ix+006h)		;71cb   ; rebota en los bordes
	cp 001h		;71ce
	call c,rebota_izq		;71d0
	cp 0dch		;71d3
	call nc,rebota_der		;71d5
	call distancia_x		;71d8   ; muy cerca en x: p03:728C
	cp 004h		;71db
	jp c,tipo_06_cerca		;71dd
	call casillas_actor		;71e0   ; las casillas
	bit 0,(ix+001h)		;71e3   ; mirando a la izquierda...
	jr z,tipo_06_der		;71e7
	ld a,(ix+018h)		;71e9   ; ...pared: da la vuelta y nada mas
	and 0f0h		;71ec   ; la clase de la casilla (+18)
	cp 020h		;71ee   ; clase 0x20?
	push af			;71f0
	call z,da_la_vuelta		;71f1
	pop af			;71f4
	jp z,tipo_06_fin		;71f5
	ld a,(ix+01bh)		;71f8   ; ...tipo 2 debajo-delante: p03:732B
	and 00fh		;71fb   ; el tipo de la casilla (+1B)
	cp 002h		;71fd
	jp z,tipo_06_tipo2		;71ff
tipo_06_delante:
	ld a,(ix+01ch)		;7202   ; la de debajo-delante, nibble bajo:
	and 00fh		;7205   ; el tipo de la casilla (+1C)
	cp 00fh		;7207   ; 0x0F: p03:727A
	jp z,tipo_06_lejos		;7209
	cp 001h		;720c   ; 1: da la vuelta
	jp z,da_la_vuelta		;720e
	cp 002h		;7211   ; 2 o 3: escalon
	jp z,tipo_06_escalon		;7213
	cp 003h		;7216
	jp z,tipo_06_escalon		;7218
	cp 004h		;721b   ; 4: anda
	jp z,tipo_06_anda		;721d
	cp 005h		;7220   ; 5 o 6: salto alto
	jp z,tipo_06_salto_alto		;7222
	cp 006h		;7225
	jp z,tipo_06_salto_alto		;7227
	jp nc,tipo_06_otra		;722a   ; mas: p03:730E
tipo_06_vuelta:
	call da_la_vuelta		;722d
	jp tipo_06_lejos		;7230
tipo_06_der:
	ld a,(ix+019h)		;7233
	and 0f0h		;7236   ; la clase de la casilla (+19)
	cp 020h		;7238   ; clase 0x20?
	push af			;723a
	call z,da_la_vuelta		;723b
	pop af			;723e
	jp z,tipo_06_fin		;723f
	ld a,(ix+01eh)		;7242
	and 00fh		;7245   ; el tipo de la casilla (+1E)
	cp 002h		;7247
	jp z,tipo_06_tipo2_der		;7249
tipo_06_der_delante:
	ld a,(ix+01dh)		;724c   ; la de debajo-delante a la derecha
	and 00fh		;724f   ; el tipo de la casilla (+1D)
	cp 00fh		;7251   ; 0x0F?
	jp z,tipo_06_lejos		;7253   ; si: como si no hubiera nada
	cp 001h		;7256   ; 1?
	jp z,da_la_vuelta		;7258   ; si: da la vuelta
	cp 002h		;725b   ; 2?
	jp z,tipo_06_escalon_der		;725d   ; escalon
	cp 003h		;7260   ; 3?
	jp z,tipo_06_escalon_der		;7262   ; escalon
	cp 004h		;7265   ; 4?
	jp z,tipo_06_anda		;7267   ; anda
	cp 005h		;726a   ; 5?
	jp z,tipo_06_salto_alto		;726c   ; salto alto
	cp 006h		;726f   ; 6?
	jp z,tipo_06_salto_alto		;7271   ; salto alto
	jp nc,tipo_06_otra_der		;7274   ; mas: lo otro
tipo_06_der_vuelta:
	call da_la_vuelta		;7277
tipo_06_lejos:
	call distancia_x		;727a   ; a menos de 0x30 en x: p03:728C
	cp 030h		;727d
	jp c,tipo_06_cerca		;727f
tipo_06_anda:
	res 1,(ix+001h)		;7282   ; pose sin el bit 1
tipo_06_pinta:
	call anda		;7286   ; anda 2 pixeles y pintado
	jp 04a8bh		;7289   ; p00 pinta_actor
tipo_06_cerca:
	call de_cara		;728c   ; de cara a Rastan
	and a			;728f
	call z,da_la_vuelta		;7290
	call distancia_y		;7293   ; a 0x18 o mas en y: nada
	cp 018h		;7296
	jp nc,tipo_06_fin		;7298
	set 1,(ix+001h)		;729b   ; pose del bit 1
	jp 04a8bh		;729f   ; p00 pinta_actor
tipo_06_fin:
	jp 04a8bh		;72a2   ; p00 pinta_actor
tipo_06_escalon:
	ld a,(ix+017h)		;72a5
	and 0f0h		;72a8   ; la clase de la casilla (+17)
	cp 020h		;72aa   ; clase 0x20?
	jp nz,tipo_06_anda		;72ac
tipo_06_salta:
	ld (ix+010h),00ch		;72af   ; 12 cuadros subiendo
	jp tipo_06_anda		;72b3
tipo_06_escalon_der:
	ld a,(ix+01ah)		;72b6
	and 0f0h		;72b9   ; la clase de la casilla (+1A)
	cp 020h		;72bb   ; clase 0x20?
	jp nz,tipo_06_anda		;72bd
	ld (ix+010h),00ch		;72c0
	jp tipo_06_anda		;72c4
tipo_06_salto_alto:
	res 1,(ix+001h)		;72c7   ; 16 cuadros subiendo
	ld (ix+011h),010h		;72cb
	jp tipo_06_fin		;72cf
huerfana_tipo_06_baja:
	ld (ix+012h),010h		;72d2   ; nadie llega aqui
	jp tipo_06_fin		;72d6
tipo_06_bajando:
	ld a,(ix+007h)		;72d9   ; 2 abajo, un cuadro menos
	inc a			;72dc
	inc a			;72dd
	ld (ix+007h),a		;72de
	ld a,(ix+012h)		;72e1
	dec a			;72e4
	ld (ix+012h),a		;72e5
	jp tipo_06_pinta		;72e8
tipo_06_subiendo:
	res 1,(ix+001h)		;72eb   ; 2 arriba, un cuadro menos
	ld a,(ix+007h)		;72ef   ; la y...
	dec a			;72f2   ; ...2 pixeles arriba
	dec a			;72f3
	ld (ix+007h),a		;72f4   ; guardada
	ld a,(ix+011h)		;72f7   ; cuadros de subida...
	dec a			;72fa   ; ...uno menos
	ld (ix+011h),a		;72fb
	and a			;72fe   ; acabados?
	jp z,tipo_06_cumbre		;72ff   ; si: a bajar
	jp tipo_06_pinta		;7302   ; no: pintado
tipo_06_cumbre:
	ld (ix+012h),010h		;7305   ; 16 cuadros bajando
	jp tipo_06_pinta		;7309

; ----------------------------------------------------------------------
; DATOS resto_730C: dos `ret` que nadie ejecuta
;   0x730c..0x730e  (2 bytes)
DATA_resto_730C:
	defb 0c9h,0c9h	; 730c

; ======================================================================
; CODIGO 0x730e..0x76b8  (938 bytes)
; ======================================================================


tipo_06_otra:
	cp 00fh		;730e
	jp z,tipo_06_vuelta		;7310
	jr tipo_06_vuelta_cerca		;7313
tipo_06_otra_der:
	cp 00fh		;7315
	jp z,tipo_06_der_vuelta		;7317
	jp tipo_06_vuelta_cerca		;731a
tipo_06_vuelta_cerca:
	call da_la_vuelta		;731d
	call distancia_x		;7320
	cp 030h		;7323
	jp c,tipo_06_cerca		;7325
	jp tipo_06_fin		;7328
tipo_06_tipo2:
	ld a,(ix+017h)		;732b
	and 0f0h		;732e   ; la clase de la casilla (+17)
	cp 020h		;7330   ; clase 0x20?
	jp z,tipo_06_salta		;7332
	jp tipo_06_delante		;7335
tipo_06_tipo2_der:
	ld a,(ix+01ah)		;7338
	and 0f0h		;733b   ; la clase de la casilla (+1A)
	cp 020h		;733d   ; clase 0x20?
	jp z,tipo_06_salta		;733f
	jp tipo_06_der_delante		;7342
tipo_06_escondido:
	set 0,(ix+001h)		;7345   ; mirando a la izquierda, escondido
	set 2,(ix+001h)		;7349
	ld a,(ix+002h)		;734d   ; el cuadro de su animacion: 4, la ultima de salir?
	and 07fh		;7350
	cp 004h		;7352
	jr z,tipo_06_sale		;7354
	ld (ix+014h),000h		;7356   ; aun no: +14 = 0
	jp 04a8bh		;735a   ; p00 pinta_actor
tipo_06_sale:
	res 2,(ix+001h)		;735d   ; ya ha salido: fuera la pose del bit 2...
	ld (ix+014h),0ffh		;7361   ; ...+14 = 0xFF y a moverse
	jp tipo_06_activo		;7365

; ----------------------------------------------------------------------
; Tipo 0x12: de cara a Rastan; anda de pixel en pixel si esta a mas de 0x40
; en x, y entre 0x20 y 0x40 lanza un proyectil (el actor 3) si esta cerca
; en y.
; ----------------------------------------------------------------------
tipo_12:
	ld a,(ix+00fh)		;7368   ; sin vida
	and a			;736b
	jp z,muere_actor		;736c
	ld a,(0d9bah)		;736f   ; proyectil en vuelo: se mueve
	cp 00fh		;7372
	call z,proyectil_12		;7374
	bit 1,(ix+001h)		;7377   ; lanzando: tambien
	call nz,proyectil_12		;737b
	call de_cara		;737e   ; de espaldas: se da la vuelta y nada mas
	and a			;7381
	jp z,da_la_vuelta		;7382
	call nada_debajo		;7385   ; nada debajo: cae
	cp 0ffh		;7388
	jp z,cae_1		;738a
	ld a,(ix+006h)		;738d   ; rebota en los bordes
	cp 001h		;7390
	call c,rebota_izq		;7392
	cp 0efh		;7395
	call nc,rebota_der		;7397
	call casillas_actor		;739a   ; las casillas
	bit 0,(ix+001h)		;739d   ; mirando a la izquierda: pared o sin suelo, quieto
	jr z,tipo_12_der		;73a1
	ld a,(ix+017h)		;73a3
	and 0f0h		;73a6   ; la clase de la casilla (+17)
	cp 020h		;73a8   ; clase 0x20?
	jp z,tipo_12_quieto		;73aa
	ld a,(ix+01ch)		;73ad
	and 0f0h		;73b0   ; la clase de la casilla (+1C)
	cp 020h		;73b2   ; clase 0x20?
	jp nz,tipo_12_quieto		;73b4
	jr tipo_12_lejos		;73b7
tipo_12_der:
	ld a,(ix+01ah)		;73b9
	and 0f0h		;73bc   ; la clase de la casilla (+1A)
	cp 020h		;73be   ; clase 0x20?
	jp z,tipo_12_quieto		;73c0
	ld a,(ix+01eh)		;73c3
	and 0f0h		;73c6   ; la clase de la casilla (+1E)
	cp 020h		;73c8   ; clase 0x20?
	jp nz,tipo_12_quieto		;73ca
tipo_12_lejos:
	call distancia_x		;73cd   ; a 0x40 o mas en x: anda
	cp 040h		;73d0
	jr c,tipo_12_medio		;73d2
tipo_12_anda:
	jp anda_1		;73d4   ; un pixel
tipo_12_quieto:
	call distancia_y		;73d7   ; (la distancia en y se calcula y no decide nada)
	cp 020h		;73da
	jp nc,tipo_12_pinta		;73dc
tipo_12_pinta:
	jp 04a8bh		;73df   ; p00 pinta_actor
tipo_12_medio:
	cp 020h		;73e2   ; a menos de 0x20: anda
	jr nc,tipo_12_lanza		;73e4
	jr tipo_12_anda		;73e6
tipo_12_lanza:
	ld a,(0d9bah)		;73e8   ; ya hay proyectil: nada
	cp 00fh		;73eb
	jr z,tipo_12_sin_poses		;73ed
	call distancia_y		;73ef   ; a 0x20 o mas en y: nada
	cp 020h		;73f2
	jp nc,tipo_12_pinta		;73f4
	set 1,(ix+001h)		;73f7   ; pose de lanzar (bit 1)
	res 2,(ix+001h)		;73fb
	res 3,(ix+001h)		;73ff
	push ix		;7403
	call 04a8bh		;7405   ; p00 pinta_actor
	pop ix		;7408
	ld a,(0d9bah)		;740a   ; sin proyectil: lo lanza
	and a			;740d
	jp z,proyectil_12		;740e
tipo_12_sin_poses:
	res 1,(ix+001h)		;7411   ; fuera las poses 1, 2 y 3
	res 2,(ix+001h)		;7415
	res 3,(ix+001h)		;7419
	jp 04a8bh		;741d   ; p00 pinta_actor
proyectil_12:
	push ix		;7420   ; IY = el que lanza, IX = el actor 3
	push ix		;7422
	pop iy		;7424
	ld ix,0d9a5h		;7426   ; ix -> actor 3
	ld a,(ix+015h)		;742a   ; +15 = 0: aun no ha salido
	cp 000h		;742d
	jp z,lanza_proyectil_12		;742f
	cp 00fh		;7432   ; (este `cp` no decide nada)
	jr sigue_proyectil_12		;7434
lanza_proyectil_12:
	bit 7,(iy+002h)		;7436   ; la animacion de lanzar ha acabado?
	jp z,proyectil_12_fin		;743a
	ld (ix+015h),00fh		;743d   ; en vuelo
	call coloca_proyectil_12		;7441   ; se coloca
	call 048f9h		;7444   ; alta y pintado
	call 04a8bh		;7447   ; p00 pinta_actor
proyectil_12_fin:
	pop ix		;744a
	ret			;744c
sigue_proyectil_12:
	jp mueve_proyectil_12		;744d
proyectil_12_pinta:
	call 04a8bh		;7450   ; p00 pinta_actor
	pop ix		;7453
	ret			;7455
huerfana_acaba_12:
	ld (ix+015h),000h		;7456   ; nadie llega aqui
	call 04b10h		;745a   ; p00 baja_actor
	pop ix		;745d
	ret			;745f
coloca_proyectil_12:
	ld (ix+001h),00fh		;7460   ; pose 0x0F
	ld a,(iy+001h)		;7464   ; +13 = el lado del que lanza
	ld (ix+013h),a		;7467
	bit 0,(iy+001h)		;746a   ; a la izquierda: x - 8
	jr z,coloca_12_der		;746e
	set 0,(ix+012h)		;7470
	ld a,(iy+006h)		;7474
	sub 008h		;7477
	ld (ix+006h),a		;7479
	jr coloca_12_y		;747c
coloca_12_der:
	res 0,(ix+001h)		;747e   ; a la derecha: x + 0x18
	ld a,(iy+006h)		;7482
	add a,018h		;7485
	ld (ix+006h),a		;7487
coloca_12_y:
	ld a,(iy+007h)		;748a   ; la misma y, tipo 0x16
	ld (ix+007h),a		;748d
	ld a,016h		;7490
	ld (ix+000h),a		;7492
	ret			;7495
mueve_proyectil_12:
	ld (ix+001h),00fh		;7496   ; pose 0x0F
	call casillas_actor		;749a   ; las casillas
	ld a,(ix+020h)		;749d   ; toca una de clase 0x20: se acaba
	and 0f0h		;74a0   ; la clase de la casilla (+20)
	cp 020h		;74a2   ; clase 0x20?
	jp z,acaba_proyectil_12		;74a4
	ld a,(0d8fch)		;74a7   ; C = x de Rastan + 8
	add a,008h		;74aa
	ld c,a			;74ac
	bit 0,(ix+013h)		;74ad   ; hacia la izquierda: si da a Rastan, se acaba
	jr z,mueve_proyectil_12_der		;74b1
	call proyectil_choca_izq		;74b3
	and a			;74b6
	jp z,acaba_proyectil_12		;74b7
	ld a,(ix+006h)		;74ba   ; 2 a la izquierda, hasta 4
	dec a			;74bd
	dec a			;74be
	cp 004h		;74bf
	jp c,acaba_proyectil_12		;74c1
	ld (ix+006h),a		;74c4
	jr proyectil_12_sigue		;74c7
mueve_proyectil_12_der:
	res 0,(ix+001h)		;74c9   ; hacia la derecha: si da a Rastan, se acaba
	call proyectil_choca_der		;74cd
	and a			;74d0
	jp z,acaba_proyectil_12		;74d1
	ld a,(ix+006h)		;74d4   ; 2 a la derecha, hasta 0xF0
	inc a			;74d7
	inc a			;74d8
	cp 0f0h		;74d9
	jp nc,acaba_proyectil_12		;74db
	ld (ix+006h),a		;74de
proyectil_12_sigue:
	jp proyectil_12_pinta		;74e1
acaba_proyectil_12:
	ld ix,0d9a5h		;74e4   ; el actor 3 ya no esta, baja
	ld (ix+015h),000h		;74e8
	call 04b10h		;74ec   ; p00 baja_actor
	pop ix		;74ef
	ret			;74f1
huerfana_baja_actor3:
	ld ix,0d9a5h		;74f2   ; nadie la llama: baja del actor 3
	call 04b10h		;74f6   ; p00 baja_actor
	pop ix		;74f9
	ret			;74fb

; ----------------------------------------------------------------------
; Tipo 0x11: no se mueve en todos los cuadros (paridad de R); si Rastan
; esta agachado (pose 4), pone su pose del bit 2; luego como el tipo 1.
; ----------------------------------------------------------------------
tipo_11:
	ld a,(ix+00fh)		;74fc   ; sin vida
	and a			;74ff
	jp z,muere_actor		;7500
	ld a,r		;7503   ; al azar, este cuadro no se mueve
	jp po,04a8bh		;7505   ; p00 pinta_actor
	ld hl,0d8f4h		;7508   ; Rastan agachado?
	ld a,(hl)			;750b
	and 01eh		;750c
	cp 004h		;750e
	jr nz,tipo_11_rastan_de_pie		;7510
	set 2,(ix+001h)		;7512   ; si: pose del bit 2
	jr tipo_11_mueve		;7516
tipo_11_rastan_de_pie:
	res 2,(ix+001h)		;7518   ; no: sin ella
tipo_11_mueve:
	ld a,(ix+012h)		;751c   ; +12: bajando
	and a			;751f
	jp nz,tipo_11_bajando		;7520
	ld a,(ix+011h)		;7523   ; +11: subiendo
	and a			;7526
	jp nz,tipo_11_subiendo		;7527
	ld a,(ix+010h)		;752a   ; +10: subiendo un poco
	and a			;752d
	jr z,tipo_11_suelo		;752e
	dec a			;7530   ; un cuadro menos...
	ld (ix+010h),a		;7531
	ld a,(ix+007h)		;7534   ; ...un pixel arriba...
	dec a			;7537
	ld (ix+007h),a		;7538
	set 3,(ix+001h)		;753b   ; ...con la pose del bit 3
	res 2,(ix+001h)		;753f
	res 1,(ix+001h)		;7543
	call anda		;7547   ; anda
	jp 04a8bh		;754a   ; p00 pinta_actor
tipo_11_suelo:
	res 2,(ix+001h)		;754d   ; fuera la pose del bit 2
	call nada_debajo		;7551   ; nada debajo: cae
	cp 0ffh		;7554
	jp z,cae_1		;7556
	ld a,(ix+006h)		;7559   ; rebota en los bordes
	cp 001h		;755c
	call c,rebota_izq		;755e
	cp 0dch		;7561
	call nc,rebota_der		;7563
	call distancia_x		;7566   ; muy cerca en x: p03:7622
	cp 004h		;7569
	jp c,tipo_11_cerca		;756b
	call casillas_actor		;756e   ; las casillas
	bit 0,(ix+001h)		;7571   ; mirando a la izquierda...
	jr z,tipo_11_der		;7575
	ld a,(ix+018h)		;7577   ; ...pared: da la vuelta y nada mas
	and 0f0h		;757a   ; la clase de la casilla (+18)
	cp 020h		;757c   ; clase 0x20?
	push af			;757e
	call z,da_la_vuelta		;757f
	pop af			;7582
	jp z,tipo_11_fin		;7583
	ld a,(ix+01bh)		;7586   ; ...tipo 2 debajo-delante: p03:76D7
	and 00fh		;7589   ; el tipo de la casilla (+1B)
	cp 002h		;758b
	jp z,tipo_11_tipo2		;758d
tipo_11_delante:
	ld a,(ix+01ch)		;7590   ; la de debajo-delante, nibble bajo:
	and 00fh		;7593   ; el tipo de la casilla (+1C)
	cp 00fh		;7595   ; 0x0F: p03:7608
	jp z,tipo_11_lejos		;7597
	cp 001h		;759a   ; 1: da la vuelta
	jp z,da_la_vuelta		;759c
	cp 002h		;759f   ; 2 o 3: escalon
	jp z,tipo_11_escalon		;75a1
	cp 003h		;75a4
	jp z,tipo_11_escalon		;75a6
	cp 004h		;75a9   ; 4: anda
	jp z,tipo_11_anda		;75ab
	cp 005h		;75ae   ; 5 o 6: salto alto
	jp z,tipo_11_salto_alto		;75b0
	cp 006h		;75b3
	jp z,tipo_11_salto_alto		;75b5
	jp nc,tipo_11_otra		;75b8   ; mas: p03:76BA
tipo_11_vuelta:
	call da_la_vuelta		;75bb
	jp tipo_11_lejos		;75be
tipo_11_der:
	ld a,(ix+019h)		;75c1
	and 0f0h		;75c4   ; la clase de la casilla (+19)
	cp 020h		;75c6   ; clase 0x20?
	push af			;75c8
	call z,da_la_vuelta		;75c9
	pop af			;75cc
	jp z,tipo_11_fin		;75cd
	ld a,(ix+01eh)		;75d0
	and 00fh		;75d3   ; el tipo de la casilla (+1E)
	cp 002h		;75d5
	jp z,tipo_11_tipo2_der		;75d7
tipo_11_der_delante:
	ld a,(ix+01dh)		;75da   ; la de debajo-delante a la derecha
	and 00fh		;75dd   ; el tipo de la casilla (+1D)
	cp 00fh		;75df   ; 0x0F?
	jp z,tipo_11_lejos		;75e1   ; si: como si no hubiera nada
	cp 001h		;75e4   ; 1?
	jp z,da_la_vuelta		;75e6   ; si: da la vuelta
	cp 002h		;75e9   ; 2?
	jp z,tipo_11_escalon_der		;75eb   ; escalon
	cp 003h		;75ee   ; 3?
	jp z,tipo_11_escalon_der		;75f0   ; escalon
	cp 004h		;75f3   ; 4?
	jp z,tipo_11_anda		;75f5   ; anda
	cp 005h		;75f8   ; 5?
	jp z,tipo_11_salto_alto		;75fa   ; salto alto
	cp 006h		;75fd   ; 6?
	jp z,tipo_11_salto_alto		;75ff   ; salto alto
	jp nc,tipo_11_otra_der		;7602   ; mas: lo otro
tipo_11_der_vuelta:
	call da_la_vuelta		;7605
tipo_11_lejos:
	call distancia_x		;7608   ; a menos de 0x30 en x: p03:7622
	cp 030h		;760b
	jp c,tipo_11_cerca		;760d
tipo_11_anda:
	res 3,(ix+001h)		;7610   ; fuera las poses 1, 2 y 3
	res 2,(ix+001h)		;7614
	res 1,(ix+001h)		;7618
tipo_11_pinta:
	call anda		;761c   ; anda y pintado
	jp 04a8bh		;761f   ; p00 pinta_actor
tipo_11_cerca:
	call de_cara		;7622   ; de cara a Rastan
	and a			;7625
	call z,da_la_vuelta		;7626
	call distancia_y		;7629   ; a 0x20 o mas en y: nada
	cp 020h		;762c
	jp nc,tipo_11_fin		;762e
	set 1,(ix+001h)		;7631   ; pose del bit 1
	res 2,(ix+001h)		;7635
	res 3,(ix+001h)		;7639
	jp 04a8bh		;763d   ; p00 pinta_actor
tipo_11_fin:
	jp 04a8bh		;7640   ; p00 pinta_actor
tipo_11_escalon:
	ld a,(ix+017h)		;7643
	and 0f0h		;7646   ; la clase de la casilla (+17)
	cp 020h		;7648   ; clase 0x20?
	jp nz,tipo_11_anda		;764a
tipo_11_salta:
	ld (ix+010h),010h		;764d   ; 16 cuadros subiendo de pixel en pixel
	jp tipo_11_anda		;7651
tipo_11_escalon_der:
	ld a,(ix+01ah)		;7654
	and 0f0h		;7657   ; la clase de la casilla (+1A)
	cp 020h		;7659   ; clase 0x20?
	jp nz,tipo_11_anda		;765b
	ld (ix+010h),010h		;765e
	jp tipo_11_anda		;7662
tipo_11_salto_alto:
	set 3,(ix+001h)		;7665   ; pose del bit 3 y 32 cuadros subiendo
	res 2,(ix+001h)		;7669
	res 1,(ix+001h)		;766d
	ld (ix+011h),020h		;7671
	jp tipo_11_fin		;7675
huerfana_tipo_11_baja:
	ld (ix+012h),020h		;7678   ; nadie llega aqui
	jp tipo_11_fin		;767c
tipo_11_bajando:
	ld a,(ix+007h)		;767f   ; un pixel abajo, un cuadro menos
	inc a			;7682
	ld (ix+007h),a		;7683
	ld a,(ix+012h)		;7686
	dec a			;7689
	ld (ix+012h),a		;768a
	jp tipo_11_pinta		;768d
tipo_11_subiendo:
	set 3,(ix+001h)		;7690   ; pose del bit 3
	res 2,(ix+001h)		;7694
	res 1,(ix+001h)		;7698
	ld a,(ix+007h)		;769c   ; un pixel arriba
	dec a			;769f
	ld (ix+007h),a		;76a0
	ld a,(ix+011h)		;76a3   ; un cuadro menos...
	dec a			;76a6
	ld (ix+011h),a		;76a7
	and a			;76aa
	jp z,tipo_11_cumbre		;76ab
	jp tipo_11_pinta		;76ae
tipo_11_cumbre:
	ld (ix+012h),01ch		;76b1   ; ...y 28 bajando
	jp tipo_11_pinta		;76b5

; ----------------------------------------------------------------------
; DATOS resto_76B8: dos `ret` que nadie ejecuta
;   0x76b8..0x76ba  (2 bytes)
DATA_resto_76B8:
	defb 0c9h,0c9h	; 76b8

; ======================================================================
; CODIGO 0x76ba..0x7ae4  (1066 bytes)
; ======================================================================


tipo_11_otra:
	cp 00fh		;76ba
	jp z,tipo_11_vuelta		;76bc
	jr tipo_11_vuelta_cerca		;76bf
tipo_11_otra_der:
	cp 00fh		;76c1
	jp z,tipo_11_der_vuelta		;76c3
	jp tipo_11_vuelta_cerca		;76c6
tipo_11_vuelta_cerca:
	call da_la_vuelta		;76c9
	call distancia_x		;76cc
	cp 030h		;76cf
	jp c,tipo_11_cerca		;76d1
	jp tipo_11_fin		;76d4
tipo_11_tipo2:
	ld a,(ix+017h)		;76d7
	and 0f0h		;76da   ; la clase de la casilla (+17)
	cp 020h		;76dc   ; clase 0x20?
	jp z,tipo_11_salta		;76de
	jp tipo_11_delante		;76e1
tipo_11_tipo2_der:
	ld a,(ix+01ah)		;76e4
	and 0f0h		;76e7   ; la clase de la casilla (+1A)
	cp 020h		;76e9   ; clase 0x20?
	jp z,tipo_11_salta		;76eb
	jp tipo_11_der_delante		;76ee

; ----------------------------------------------------------------------
; Tipo 0x14: como el 0x12 pero su proyectil (el actor 4) va de pixel en
; pixel y, al tocar algo, se queda un momento con la pose 3 (+15 = 0xF1)
; antes de desaparecer.
; ----------------------------------------------------------------------
tipo_14:
	ld a,(ix+00fh)		;76f1   ; sin vida
	and a			;76f4
	jp z,muere_actor		;76f5
	ld a,(0d9e0h)		;76f8   ; proyectil acabando (0xF1): se atiende
	cp 0f1h		;76fb
	call z,proyectil_14		;76fd
	ld a,(0d9e0h)		;7700   ; proyectil en vuelo: se mueve
	cp 00fh		;7703
	call z,proyectil_14		;7705
	bit 1,(ix+001h)		;7708   ; lanzando: tambien
	call nz,proyectil_14		;770c
	call de_cara		;770f   ; de espaldas: se da la vuelta y nada mas
	and a			;7712
	jp z,da_la_vuelta		;7713
	call nada_debajo		;7716   ; nada debajo: cae
	cp 0ffh		;7719
	jp z,cae_1		;771b
	ld a,(ix+006h)		;771e   ; rebota en los bordes
	cp 001h		;7721
	call c,rebota_izq		;7723
	cp 0efh		;7726
	call nc,rebota_der		;7728
	call casillas_actor		;772b   ; las casillas
	bit 0,(ix+001h)		;772e   ; mirando a la izquierda: pared o sin suelo, p03:77A1
	jr z,tipo_14_der		;7732
	ld a,(ix+017h)		;7734
	and 0f0h		;7737   ; la clase de la casilla (+17)
	cp 020h		;7739   ; clase 0x20?
	jp z,tipo_14_parado		;773b
	ld a,(ix+01ch)		;773e
	and 0f0h		;7741   ; la clase de la casilla (+1C)
	cp 020h		;7743   ; clase 0x20?
	jp nz,tipo_14_parado		;7745
	jr tipo_14_lejos		;7748
tipo_14_der:
	ld a,(ix+01ah)		;774a
	and 0f0h		;774d   ; la clase de la casilla (+1A)
	cp 020h		;774f   ; clase 0x20?
	jp z,tipo_14_parado		;7751
	ld a,(ix+01eh)		;7754
	and 0f0h		;7757   ; la clase de la casilla (+1E)
	cp 020h		;7759   ; clase 0x20?
	jp nz,tipo_14_parado		;775b
tipo_14_lejos:
	call distancia_x		;775e   ; a 0x40 o mas en x: anda
	cp 040h		;7761
	jr c,tipo_14_medio		;7763
tipo_14_anda:
	jp anda_1		;7765   ; un pixel
huerfana_tipo_14_quieto:
	call distancia_y		;7768   ; nadie llega aqui (la distancia en y no decide nada)
	cp 020h		;776b
	jp nc,tipo_14_pinta		;776d
tipo_14_pinta:
	jp 04a8bh		;7770   ; p00 pinta_actor
tipo_14_medio:
	cp 020h		;7773   ; a menos de 0x20: anda
	jr nc,tipo_14_lanza		;7775
	jr tipo_14_anda		;7777
tipo_14_lanza:
	ld a,(0d9e0h)		;7779   ; ya hay proyectil: nada
	cp 00fh		;777c
	jr z,tipo_14_sin_pose		;777e
	call distancia_y		;7780   ; a 0x20 o mas en y: nada
	cp 020h		;7783
	jp nc,tipo_14_pinta		;7785
	set 1,(ix+001h)		;7788   ; pose de lanzar
	push ix		;778c
	call 04a8bh		;778e   ; p00 pinta_actor
	pop ix		;7791
	ld a,(0d9e0h)		;7793   ; sin proyectil: lo lanza
	and a			;7796
	jp z,proyectil_14		;7797
tipo_14_sin_pose:
	res 1,(ix+001h)		;779a
	jp 04a8bh		;779e   ; p00 pinta_actor
tipo_14_parado:
	call distancia_x		;77a1   ; parado: lanza si esta entre 0x20 y 0x40 en x
	cp 040h		;77a4
	jr c,tipo_14_pinta		;77a6
	cp 020h		;77a8
	jr nc,tipo_14_pinta		;77aa
	jp tipo_14_lanza		;77ac
proyectil_14:
	push ix		;77af   ; IY = el que lanza, IX = el actor 4
	push ix		;77b1
	pop iy		;77b3
	ld ix,0d9cbh		;77b5   ; ix -> actor 4
	ld a,(ix+015h)		;77b9   ; +15 = 0: aun no ha salido
	cp 000h		;77bc
	jp z,lanza_proyectil_14		;77be
	cp 00fh		;77c1   ; 0x0F: en vuelo
	jr z,sigue_proyectil_14		;77c3
	jp acaba_proyectil_14		;77c5   ; si no (0xF1), acabando
lanza_proyectil_14:
	bit 7,(iy+002h)		;77c8   ; la animacion de lanzar ha acabado?
	jp z,proyectil_14_fin		;77cc
	ld (ix+015h),00fh		;77cf   ; en vuelo
	call coloca_proyectil_14		;77d3   ; se coloca
	call 048f9h		;77d6   ; alta y pintado
	call 04a8bh		;77d9   ; p00 pinta_actor
proyectil_14_fin:
	pop ix		;77dc
	ret			;77de
sigue_proyectil_14:
	jp mueve_proyectil_14		;77df
proyectil_14_pinta:
	call 04a8bh		;77e2   ; p00 pinta_actor
	pop ix		;77e5
	ret			;77e7
huerfana_acaba_14:
	ld (ix+015h),000h		;77e8   ; nadie llega aqui
	call 04b10h		;77ec   ; p00 baja_actor
	pop ix		;77ef
	ret			;77f1
coloca_proyectil_14:
	ld (ix+001h),001h		;77f2   ; pose 1
	ld a,(iy+001h)		;77f6   ; +13 = el lado del que lanza
	ld (ix+013h),a		;77f9
	bit 0,(iy+001h)		;77fc   ; a la izquierda: x - 8
	jr z,coloca_14_der		;7800
	set 0,(ix+012h)		;7802
	ld a,(iy+006h)		;7806
	sub 008h		;7809
	ld (ix+006h),a		;780b
	jr coloca_14_y		;780e
coloca_14_der:
	res 0,(ix+001h)		;7810   ; a la derecha: x + 0x18
	ld a,(iy+006h)		;7814
	add a,018h		;7817
	ld (ix+006h),a		;7819
coloca_14_y:
	ld a,(iy+007h)		;781c   ; la misma y, tipo 0x16
	ld (ix+007h),a		;781f
	ld a,016h		;7822
	ld (ix+000h),a		;7824
	ret			;7827
mueve_proyectil_14:
	call casillas_actor		;7828   ; las casillas
	ld a,(ix+020h)		;782b   ; toca una de clase 0x20: se acaba
	and 0f0h		;782e   ; la clase de la casilla (+20)
	cp 020h		;7830   ; clase 0x20?
	jp z,choca_proyectil_14		;7832
	ld a,(0d8fch)		;7835   ; C = x de Rastan + 8
	add a,008h		;7838
	ld c,a			;783a
	bit 0,(ix+013h)		;783b   ; hacia la izquierda: si da a Rastan, se acaba
	jr z,mueve_proyectil_14_der		;783f
	call proyectil_choca_izq		;7841
	and a			;7844
	jp z,choca_proyectil_14		;7845
	ld a,(ix+006h)		;7848   ; un pixel a la izquierda, hasta 4
	dec a			;784b
	cp 004h		;784c
	jp c,choca_proyectil_14		;784e
	ld (ix+006h),a		;7851
	jr proyectil_14_sigue		;7854
mueve_proyectil_14_der:
	res 0,(ix+001h)		;7856   ; hacia la derecha: si da a Rastan, se acaba
	call proyectil_choca_der		;785a
	and a			;785d
	jp z,choca_proyectil_14		;785e
	ld a,(ix+006h)		;7861   ; un pixel a la derecha, hasta 0xF0
	inc a			;7864
	cp 0f0h		;7865
	jp nc,choca_proyectil_14		;7867
	ld (ix+006h),a		;786a
proyectil_14_sigue:
	jp proyectil_14_pinta		;786d
choca_proyectil_14:
	ld ix,0d9cbh		;7870   ; al chocar: +15 = 0xF1...
	ld (ix+015h),0f1h		;7874
	ld (ix+001h),003h		;7878   ; ...pose 3...
	push ix		;787c   ; ...pintado...
	call 04a8bh		;787e   ; p00 pinta_actor
	pop ix		;7881
	call 04b10h		;7883   ; ...y baja
	pop ix		;7886
	ret			;7888
acaba_proyectil_14:
	bit 7,(ix+002h)		;7889   ; la animacion del choque aun no ha acabado: pinta y baja
	jr nz,fin_choque_14		;788d
	push ix		;788f
	call 04a8bh		;7891   ; p00 pinta_actor
	pop ix		;7894
	call 04b10h		;7896   ; p00 baja_actor
	pop ix		;7899
	ret			;789b
fin_choque_14:
	ld (ix+015h),000h		;789c   ; acabada: +15 = 0, ya no hay
	push ix		;78a0
	call 04a8bh		;78a2   ; p00 pinta_actor
	pop ix		;78a5
	call 04b10h		;78a7   ; p00 baja_actor
	pop ix		;78aa
	ret			;78ac

; ----------------------------------------------------------------------
; Tipo 0x15: como el 0x14, con otro proyectil (pose 5).
; ----------------------------------------------------------------------
tipo_15:
	ld a,(ix+00fh)		;78ad   ; sin vida
	and a			;78b0
	jp z,muere_actor		;78b1
	ld a,(0d9e0h)		;78b4   ; proyectil acabando: se atiende
	cp 0f1h		;78b7
	call z,proyectil_15		;78b9
	ld a,(0d9e0h)		;78bc   ; proyectil en vuelo: se mueve
	cp 00fh		;78bf
	call z,proyectil_15		;78c1
	bit 1,(ix+001h)		;78c4   ; lanzando: tambien
	call nz,proyectil_15		;78c8
	call de_cara		;78cb   ; de espaldas: se da la vuelta y nada mas
	and a			;78ce
	jp z,da_la_vuelta		;78cf
	call nada_debajo		;78d2   ; nada debajo: cae
	cp 0ffh		;78d5
	jp z,cae_1		;78d7
	ld a,(ix+006h)		;78da   ; rebota en los bordes
	cp 001h		;78dd
	call c,rebota_izq		;78df
	cp 0dch		;78e2
	call nc,rebota_der		;78e4
	call casillas_actor		;78e7   ; las casillas
	bit 0,(ix+001h)		;78ea   ; mirando a la izquierda: pared o sin suelo, p03:7956
	jr z,tipo_15_der		;78ee
	ld a,(ix+017h)		;78f0
	and 0f0h		;78f3   ; la clase de la casilla (+17)
	cp 020h		;78f5   ; clase 0x20?
	jp z,tipo_15_parado		;78f7
	ld a,(ix+01ch)		;78fa
	and 0f0h		;78fd   ; la clase de la casilla (+1C)
	cp 020h		;78ff   ; clase 0x20?
	jp nz,tipo_15_parado		;7901
	jr tipo_15_lejos		;7904
tipo_15_der:
	ld a,(ix+01ah)		;7906
	and 0f0h		;7909   ; la clase de la casilla (+1A)
	cp 020h		;790b   ; clase 0x20?
	jp z,tipo_15_parado		;790d
	ld a,(ix+01eh)		;7910
	and 0f0h		;7913   ; la clase de la casilla (+1E)
	cp 020h		;7915   ; clase 0x20?
	jp nz,tipo_15_parado		;7917
tipo_15_lejos:
	call distancia_x		;791a   ; a 0x40 o mas: anda
	cp 040h		;791d
	jr c,tipo_15_medio		;791f
tipo_15_anda:
	jp anda_1		;7921
tipo_15_pinta:
	jp 04a8bh		;7924   ; p00 pinta_actor
tipo_15_medio:
	cp 020h		;7927   ; a menos de 0x20: anda
	jr nc,tipo_15_lanza		;7929
	jr tipo_15_anda		;792b
tipo_15_lanza:
	ld a,(0d9e0h)		;792d   ; ya hay proyectil: solo pinta
	cp 00fh		;7930
	jr z,tipo_15_pinta_y_lanza		;7932
	call distancia_y		;7934   ; cerca en y: pose de lanzar
	cp 020h		;7937
	jp nc,tipo_15_pinta_y_lanza		;7939
	set 1,(ix+001h)		;793c
tipo_15_pinta_y_lanza:
	push ix		;7940
	call 04a8bh		;7942   ; p00 pinta_actor
	pop ix		;7945
	ld a,(0d9e0h)		;7947   ; sin proyectil: lo lanza
	and a			;794a
	jp z,proyectil_15		;794b
	ret			;794e
huerfana_tipo_15_sin_pose:
	res 1,(ix+001h)		;794f   ; nadie llega aqui
	jp 04a8bh		;7953   ; p00 pinta_actor
tipo_15_parado:
	call distancia_x		;7956   ; entre 0x20 y 0x40 en x: lanza
	cp 040h		;7959
	jr c,tipo_15_pinta		;795b
	cp 020h		;795d
	jr nc,tipo_15_pinta		;795f
	jp tipo_15_lanza		;7961
proyectil_15:
	push ix		;7964   ; IY = el que lanza, IX = el actor 4
	push ix		;7966
	pop iy		;7968
	ld ix,0d9cbh		;796a   ; ix -> actor 4
	ld a,(ix+015h)		;796e   ; +15 = 0: aun no ha salido
	cp 000h		;7971
	jp z,lanza_proyectil_15		;7973
	cp 00fh		;7976   ; 0x0F: en vuelo
	jr z,sigue_proyectil_15		;7978
	jp acaba_proyectil_14		;797a   ; 0xF1: acabando (p03:7889)
lanza_proyectil_15:
	bit 7,(iy+002h)		;797d   ; la animacion de lanzar ha acabado?
	jp z,proyectil_15_fin		;7981
	ld (ix+015h),00fh		;7984   ; en vuelo
	call coloca_proyectil_15		;7988   ; se coloca
	call 048f9h		;798b   ; alta y pintado
	call 04a8bh		;798e   ; p00 pinta_actor
proyectil_15_fin:
	pop ix		;7991
	ret			;7993
sigue_proyectil_15:
	jp mueve_proyectil_15		;7994
proyectil_15_pinta:
	call 04a8bh		;7997   ; p00 pinta_actor
	pop ix		;799a
	ret			;799c
huerfana_acaba_15:
	ld (ix+015h),000h		;799d   ; nadie llega aqui
	call 04b10h		;79a1   ; p00 baja_actor
	pop ix		;79a4
	ret			;79a6
coloca_proyectil_15:
	ld (ix+001h),005h		;79a7   ; pose 5
	ld a,(iy+001h)		;79ab   ; +13 = el lado
	ld (ix+013h),a		;79ae
	bit 0,(iy+001h)		;79b1   ; a la izquierda: x - 8
	jr z,coloca_15_der		;79b5
	set 0,(ix+012h)		;79b7
	ld a,(iy+006h)		;79bb
	sub 008h		;79be
	ld (ix+006h),a		;79c0
	jr coloca_15_y		;79c3
coloca_15_der:
	res 0,(ix+001h)		;79c5   ; a la derecha: x + 0x18
	ld a,(iy+006h)		;79c9
	add a,018h		;79cc
	ld (ix+006h),a		;79ce
coloca_15_y:
	ld a,(iy+007h)		;79d1   ; la misma y, tipo 0x16
	ld (ix+007h),a		;79d4
	ld a,016h		;79d7
	ld (ix+000h),a		;79d9
	ret			;79dc
mueve_proyectil_15:
	call casillas_actor		;79dd   ; las casillas
	ld a,(ix+020h)		;79e0   ; toca una de clase 0x20: se acaba
	and 0f0h		;79e3   ; la clase de la casilla (+20)
	cp 020h		;79e5   ; clase 0x20?
	jp z,choca_proyectil_15		;79e7
	ld a,(0d8fch)		;79ea   ; C = x de Rastan + 8
	add a,008h		;79ed
	ld c,a			;79ef
	bit 0,(ix+013h)		;79f0   ; hacia la izquierda: si da a Rastan, se acaba
	jr z,mueve_proyectil_15_der		;79f4
	call proyectil_choca_izq		;79f6
	and a			;79f9
	jp z,choca_proyectil_15		;79fa
	ld a,(ix+006h)		;79fd   ; un pixel a la izquierda, hasta 4
	dec a			;7a00
	cp 004h		;7a01
	jp c,choca_proyectil_15		;7a03
	ld (ix+006h),a		;7a06
	jr proyectil_15_sigue		;7a09
mueve_proyectil_15_der:
	res 0,(ix+001h)		;7a0b   ; hacia la derecha: si da a Rastan, se acaba
	call proyectil_choca_der		;7a0f
	and a			;7a12
	jp z,choca_proyectil_15		;7a13
	ld a,(ix+006h)		;7a16   ; un pixel a la derecha, hasta 0xF0
	inc a			;7a19
	cp 0f0h		;7a1a
	jp nc,choca_proyectil_15		;7a1c
	ld (ix+006h),a		;7a1f
proyectil_15_sigue:
	jp proyectil_15_pinta		;7a22
choca_proyectil_15:
	ld ix,0d9cbh		;7a25   ; al chocar: +15 = 0xF1...
	ld (ix+015h),0f1h		;7a29
	ld (ix+001h),007h		;7a2d   ; ...pose 7...
	push ix		;7a31   ; ...pintado...
	call 04a8bh		;7a33   ; p00 pinta_actor
	pop ix		;7a36
	call 04b10h		;7a38   ; ...y baja
	pop ix		;7a3b
	ret			;7a3d

; ----------------------------------------------------------------------
; Huerfana: un paso al azar de 4 pixeles dentro de una caja hecha con los
; bytes +3/+4 del actor 0 y D92C/D92D (5 pixeles de margen). Nadie la llama.
; ----------------------------------------------------------------------
huerfana_paso_al_azar:
	ld b,005h		;7a3e   ; margen de 5
	ld a,(0d936h)		;7a40   ; H = actor 0 +3 + 5
	add a,b			;7a43
	ld h,a			;7a44
	ld a,(0d92ch)		;7a45   ; L = D92C - 5
	sub b			;7a48
	ld l,a			;7a49
	ld a,(0d937h)		;7a4a   ; D = actor 0 +4 + 5
	add a,b			;7a4d
	ld d,a			;7a4e
	ld a,(0d92dh)		;7a4f   ; E = D92D - 5
	sub b			;7a52
	ld e,a			;7a53
	call 044deh		;7a54   ; al azar, una de cuatro direcciones (o ninguna)
	ld c,a			;7a57
	and 01ch		;7a58
	cp 004h		;7a5a
	jr z,paso_der_azar		;7a5c
	cp 008h		;7a5e
	jr z,paso_izq_azar		;7a60
	cp 00ch		;7a62
	jr z,paso_abajo_azar		;7a64
	cp 010h		;7a66
	jr z,paso_arriba_azar		;7a68
	ret			;7a6a
paso_der_azar:
	ld a,(ix+006h)		;7a6b   ; 4 a la derecha, sin pasar de H
	inc a			;7a6e   ; + 4...
	inc a			;7a6f
	inc a			;7a70
	inc a			;7a71
	cp h			;7a72   ; ...comparado con el tope
	ld (ix+006h),a		;7a73   ; guardado
	ret c			;7a76   ; sin pasarse: vuelve
	ld a,h			;7a77   ; pasado: el tope
	ld (ix+006h),a		;7a78   ; guardado
	ret			;7a7b   ; vuelve
paso_izq_azar:
	ld a,(ix+006h)		;7a7c   ; 4 a la izquierda, sin bajar de L
	dec a			;7a7f   ; - 4...
	dec a			;7a80
	dec a			;7a81
	dec a			;7a82
	cp l			;7a83   ; ...comparado con el tope
	ld (ix+006h),a		;7a84   ; guardado
	ret nc			;7a87   ; sin pasarse: vuelve
	ld a,l			;7a88   ; pasado: el tope
	ld (ix+006h),a		;7a89   ; guardado
	ret			;7a8c   ; vuelve
paso_abajo_azar:
	ld a,(ix+007h)		;7a8d   ; y + 4, sin pasar de D (y lo guarda en la x: un error)
	inc a			;7a90   ; + 4...
	inc a			;7a91
	inc a			;7a92
	inc a			;7a93
	cp d			;7a94   ; ...comparado con el tope
	ld (ix+006h),a		;7a95   ; guardado
	ret c			;7a98   ; sin pasarse: vuelve
	ld a,d			;7a99   ; pasado: el tope
	ld (ix+006h),a		;7a9a   ; guardado
	ret			;7a9d   ; vuelve
paso_arriba_azar:
	ld a,(ix+007h)		;7a9e   ; y - 4, sin bajar de E (tambien en la x)
	dec a			;7aa1   ; - 4...
	dec a			;7aa2
	dec a			;7aa3
	dec a			;7aa4
	cp e			;7aa5   ; ...comparado con el tope
	ld (ix+006h),a		;7aa6   ; guardado
	ret nc			;7aa9   ; sin pasarse: vuelve
	ld a,e			;7aaa   ; pasado: el tope
	ld (ix+006h),a		;7aab   ; guardado
	ret			;7aae   ; vuelve

; ----------------------------------------------------------------------
; MUERTE DE UN ACTOR (vida +0F = 0): si lleva otro actor de la mano (un
; proyectil, segun la tabla de p03:7AE4) lo da de baja, y el actor pasa a ser
; del tipo 0x24 con la pose de la tabla: el de la muerte, que al acabar quiza suelta algo
; (p03:607A).
; ----------------------------------------------------------------------
muere_actor:
	push ix		;7aaf
	ld a,(ix+000h)		;7ab1   ; tipo - 1...
	dec a			;7ab4
	ld d,000h		;7ab5
	ld e,a			;7ab7
	ld hl,00000h		;7ab8   ; ...* 3...
	add hl,de			;7abb
	add hl,de			;7abc
	add hl,de			;7abd
	ld de,07ae4h		;7abe   ; ...en la tabla de p03:7AE4
	add hl,de			;7ac1
	ld e,(hl)			;7ac2   ; el actor que lleva consigo
	inc hl			;7ac3
	ld d,(hl)			;7ac4
	inc hl			;7ac5
	ld a,d			;7ac6   ; ninguno
	and a			;7ac7
	jr z,pasa_a_24		;7ac8
	push de			;7aca
	pop ix		;7acb
	ld a,(ix+005h)		;7acd   ; no tiene sprites: nada que quitar
	and a			;7ad0
	jr z,pasa_a_24		;7ad1
	push hl			;7ad3
	call 04b10h		;7ad4   ; se da de baja
	pop hl			;7ad7
pasa_a_24:
	pop ix		;7ad8
	ld a,(hl)			;7ada   ; la pose de la muerte
	ld (ix+001h),a		;7adb
	ld a,024h		;7ade   ; tipo 0x24
	ld (ix+000h),a		;7ae0
	ret			;7ae3

; ----------------------------------------------------------------------
; DATOS muerte_por_tipo: Por cada tipo de actor (1-23): el actor que lleva
;   consigo (D9A5 o D9CB, o 0) y la pose de la muerte
;   0x7ae4..0x7b29  (69 bytes)
DATA_muerte_por_tipo:
	defb 000h,000h,000h	; 7ae4
	defb 000h,000h,000h	; 7ae7
	defb 0a5h,0d9h,000h	; 7aea
	defb 000h,000h,000h	; 7aed
	defb 0f1h,0d9h,000h	; 7af0
	defb 000h,000h,000h	; 7af3
	defb 000h,000h,000h	; 7af6
	defb 000h,000h,000h	; 7af9
	defb 0cbh,0d9h,000h	; 7afc
	defb 000h,000h,003h	; 7aff
	defb 000h,000h,003h	; 7b02
	defb 000h,000h,003h	; 7b05
	defb 000h,000h,000h	; 7b08
	defb 000h,000h,000h	; 7b0b
	defb 000h,000h,001h	; 7b0e
	defb 0f1h,0d9h,002h	; 7b11
	defb 000h,000h,000h	; 7b14
	defb 0a5h,0d9h,000h	; 7b17
	defb 000h,000h,000h	; 7b1a
	defb 0cbh,0d9h,000h	; 7b1d
	defb 0cbh,0d9h,000h	; 7b20
	defb 000h,000h,000h	; 7b23
	defb 000h,000h,000h	; 7b26

; ======================================================================
; CODIGO 0x7b29..0x7b7a  (81 bytes)
; ======================================================================


de_cara:
	ld a,(0d8fch)		;7b29   ; la x de Rastan
	ld b,a			;7b2c
	ld a,(ix+006h)		;7b2d   ; Rastan a la derecha?
	cp b			;7b30
	jr nc,de_cara_izq		;7b31
	bit 0,(ix+001h)		;7b33   ; mirando a la izquierda: de espaldas
	jr nz,de_espaldas		;7b37
	ld a,001h		;7b39   ; 1: de cara
	ret			;7b3b
de_cara_izq:
	bit 0,(ix+001h)		;7b3c   ; Rastan a la izquierda: mirando a la derecha, de espaldas
	jr z,de_espaldas		;7b40
	ld a,001h		;7b42
	ret			;7b44
de_espaldas:
	ld a,000h		;7b45   ; 0: de espaldas
	ret			;7b47
anda_2:
	bit 0,(ix+001h)		;7b48   ; mirando a la derecha...
	jr nz,anda_2_izq		;7b4c
	inc (ix+006h)		;7b4e   ; ...x + 2
	inc (ix+006h)		;7b51
	jr anda_y_pinta		;7b54
anda_2_izq:
	dec (ix+006h)		;7b56   ; ...o x - 2
	dec (ix+006h)		;7b59
anda_y_pinta:
	res 1,(ix+001h)		;7b5c   ; pose sin el bit 1...
	call 04a8bh		;7b60   ; ...y pintado
	ret			;7b63
anda_1:
	bit 0,(ix+001h)		;7b64   ; lo mismo de pixel en pixel
	jr nz,anda_1_izq		;7b68
	inc (ix+006h)		;7b6a
	jr anda_1_pinta		;7b6d
anda_1_izq:
	dec (ix+006h)		;7b6f
anda_1_pinta:
	res 1,(ix+001h)		;7b72
	call 04a8bh		;7b76   ; p00 pinta_actor
	ret			;7b79

; ----------------------------------------------------------------------
; DATOS resto_7B7A: otra version de anda_1 que nadie ejecuta
;   0x7b7a..0x7b90  (22 bytes)
DATA_resto_7B7A:
	defb 0ddh,0cbh,001h,046h,028h,005h,0ddh,034h,006h,018h,003h,0ddh,035h,006h,0ddh,0cbh	; 7b7a  ...F(..4....5...
	defb 001h,08eh,0cdh,08bh,04ah,0c9h	; 7b8a

; ======================================================================
; CODIGO 0x7b90..0x7bd9  (73 bytes)
; ======================================================================


acerca_y:
	ld a,(0d8fdh)		;7b90   ; la y de Rastan
	ld b,(ix+007h)		;7b93
	cp b			;7b96   ; por encima: 2 pixeles abajo
	jr c,acerca_y_sube		;7b97
	inc (ix+007h)		;7b99
	inc (ix+007h)		;7b9c
	ret			;7b9f
acerca_y_sube:
	dec (ix+007h)		;7ba0   ; por debajo: 2 arriba
	dec (ix+007h)		;7ba3
	ret			;7ba6
hacia_y_a:
	ld b,(ix+007h)		;7ba7   ; va hacia la y A...
	cp b			;7baa
	jr z,hacia_y_anda		;7bab   ; ...ya esta
	jr c,hacia_y_sube		;7bad
	inc (ix+007h)		;7baf   ; ...abajo 2
	inc (ix+007h)		;7bb2
hacia_y_anda:
	bit 0,(ix+001h)		;7bb5   ; y anda 2 hacia donde mira
	jr nz,hacia_y_izq		;7bb9
	inc (ix+006h)		;7bbb
	inc (ix+006h)		;7bbe
	jr hacia_y_pinta		;7bc1
hacia_y_izq:
	dec (ix+006h)		;7bc3
	dec (ix+006h)		;7bc6
hacia_y_pinta:
	res 1,(ix+001h)		;7bc9   ; pose sin el bit 1, pintado
	call 04a8bh		;7bcd   ; p00 pinta_actor
	ret			;7bd0
hacia_y_sube:
	dec (ix+007h)		;7bd1   ; arriba 2
	dec (ix+007h)		;7bd4
	jr hacia_y_anda		;7bd7

; ----------------------------------------------------------------------
; DATOS resto_7BD9: otra rutina de acercarse que nadie ejecuta
;   0x7bd9..0x7c14  (59 bytes)
DATA_resto_7BD9:
	defb 03ah,0fdh,0d8h,04fh,0ddh,07eh,007h,006h,030h,080h,047h,079h,0b8h,028h,008h,038h	; 7bd9  :..O.~..0.Gy.(.8
	defb 022h,0ddh,034h,007h,0ddh,034h,007h,0ddh,0cbh,001h,046h,020h,008h,0ddh,034h,006h	; 7be9  ".4..4....F ..4.
	defb 0ddh,034h,006h,018h,006h,0ddh,035h,006h,0ddh,035h,006h,0ddh,0cbh,001h,08eh,0cdh	; 7bf9  .4....5..5......
	defb 08bh,04ah,0c9h,0ddh,035h,007h,0ddh,035h,007h,018h,0dch	; 7c09  .J..5..5...

; ======================================================================
; CODIGO 0x7c14..0x7c82  (110 bytes)
; ======================================================================


hacia_y_b:
	ld b,(ix+007h)		;7c14   ; como p03:7BA7 pero con la pose del bit 1
	cp b			;7c17
	jr z,hacia_y_b_anda		;7c18
	jr c,hacia_y_b_sube		;7c1a
	inc (ix+007h)		;7c1c
	inc (ix+007h)		;7c1f
hacia_y_b_anda:
	bit 0,(ix+001h)		;7c22   ; mirando a la izquierda?
	jr nz,hacia_y_b_izq		;7c26
	inc (ix+006h)		;7c28
	inc (ix+006h)		;7c2b
	jr hacia_y_b_pinta		;7c2e
hacia_y_b_izq:
	dec (ix+006h)		;7c30
	dec (ix+006h)		;7c33
hacia_y_b_pinta:
	set 1,(ix+001h)		;7c36   ; pose con el bit 1
	call 04a8bh		;7c3a   ; p00 pinta_actor
	ret			;7c3d
hacia_y_b_sube:
	dec (ix+007h)		;7c3e
	dec (ix+007h)		;7c41
	jr hacia_y_b_anda		;7c44
anda_4:
	bit 0,(ix+001h)		;7c46   ; 4 pixeles a la derecha...
	jr nz,anda_4_izq		;7c4a
	inc (ix+006h)		;7c4c
	inc (ix+006h)		;7c4f
	inc (ix+006h)		;7c52
	inc (ix+006h)		;7c55
	res 1,(ix+001h)		;7c58   ; pose sin el bit 1
	call 04a8bh		;7c5c   ; p00 pinta_actor
	ret			;7c5f
anda_4_izq:
	dec (ix+006h)		;7c60   ; ...o a la izquierda
	dec (ix+006h)		;7c63
	dec (ix+006h)		;7c66
	dec (ix+006h)		;7c69
	res 1,(ix+001h)		;7c6c
	call 04a8bh		;7c70   ; p00 pinta_actor
	ret			;7c73
anda_segun_10:
	ld a,(ix+010h)		;7c74   ; +10 = 0: deprisa (4)...
	and a			;7c77
	jr nz,anda_segun_10_b		;7c78
	call anda_4		;7c7a
	ret			;7c7d
anda_segun_10_b:
	call anda_2		;7c7e   ; ...si no, 2
	ret			;7c81

; ----------------------------------------------------------------------
; DATOS resto_7C82: rutinas que nadie ejecuta (un contador en +10 y otra de
;   acercarse en x)
;   0x7c82..0x7cc6  (68 bytes)
DATA_resto_7C82:
	defb 047h,0ddh,07eh,010h,03ch,0b8h,028h,005h,0ddh,077h,010h,0afh,0c9h,0afh,0ddh,077h	; 7c82  G.~.<.(..w.....w
	defb 010h,03eh,001h,0c9h,057h,03ah,0fch,0d8h,006h,010h,080h,047h,0ddh,07eh,006h,00eh	; 7c92  .>..W:.....G.~..
	defb 010h,081h,0b8h,038h,007h,090h,0bah,0c8h,038h,00ah,018h,010h,04fh,078h,041h,090h	; 7ca2  ...8....8...OxA.
	defb 0bah,0c8h,038h,008h,0ddh,07eh,006h,03ch,0ddh,077h,006h,0c9h,0ddh,07eh,006h,03dh	; 7cb2  ..8..~.<.w...~.=
	defb 0ddh,077h,006h,0c9h	; 7cc2

; ======================================================================
; CODIGO 0x7cc6..0x7cf4  (46 bytes)
; ======================================================================


distancia_x:
	ld a,(0d8fch)		;7cc6   ; |(x de Rastan + 16) - (x del actor + 16)|
	ld b,010h		;7cc9
	add a,b			;7ccb
	ld b,a			;7ccc
	ld a,(ix+006h)		;7ccd
	ld c,010h		;7cd0
	add a,c			;7cd2
	cp b			;7cd3   ; el actor mas a la derecha
	jr c,distancia_x_b		;7cd4
	sub b			;7cd6
	ret			;7cd7
distancia_x_b:
	ld c,a			;7cd8   ; Rastan mas a la derecha
	ld a,b			;7cd9
	ld b,c			;7cda
	sub b			;7cdb
	ret			;7cdc
distancia_x_7:
	ld a,(0d8fch)		;7cdd   ; lo mismo con x del actor + 7
	ld b,010h		;7ce0   ; B = x de Rastan + 16
	add a,b			;7ce2
	ld b,a			;7ce3
	ld a,(ix+006h)		;7ce4   ; la x del actor...
	ld c,007h		;7ce7   ; ...+ 7
	add a,c			;7ce9
	cp b			;7cea   ; el actor mas a la derecha?
	jr c,distancia_x_7b		;7ceb   ; no: al reves
	sub b			;7ced   ; la diferencia
	ret			;7cee   ; vuelve
distancia_x_7b:
	ld c,a			;7cef
	ld a,b			;7cf0
	ld b,c			;7cf1
	sub b			;7cf2
	ret			;7cf3

; ----------------------------------------------------------------------
; DATOS resto_7CF4: `ld a,1 / ld c,a / ret` y `xor a / ld c,a / ret` sueltos
;   0x7cf4..0x7cfb  (7 bytes)
DATA_resto_7CF4:
	defb 03eh,001h,04fh,0c9h,0afh,04fh,0c9h	; 7cf4

; ======================================================================
; CODIGO 0x7cfb..0x7d40  (69 bytes)
; ======================================================================


distancia_y:
	ld a,(0d8fdh)		;7cfb   ; |(y de Rastan + 16) - y del actor|
	ld b,010h		;7cfe
	add a,b			;7d00
	ld b,a			;7d01
	ld a,(ix+007h)		;7d02
	cp b			;7d05
	jr c,distancia_y_b		;7d06
	sub b			;7d08
	ret			;7d09
distancia_y_b:
	ld c,a			;7d0a
	ld a,b			;7d0b
	ld b,c			;7d0c
	sub b			;7d0d
	ret			;7d0e
retrocede_2:
	bit 0,(ix+001h)		;7d0f   ; 2 pixeles hacia atras
	jr z,retrocede_2_izq		;7d13
	inc (ix+006h)		;7d15
	inc (ix+006h)		;7d18
	ret			;7d1b
retrocede_2_izq:
	dec (ix+006h)		;7d1c
	dec (ix+006h)		;7d1f
	ret			;7d22
vuelve_y_anda:
	call da_la_vuelta		;7d23   ; se da la vuelta...
	ld a,(ix+001h)		;7d26   ; ...y 2 pixeles hacia el nuevo lado
	and 001h		;7d29
	and a			;7d2b
	jr z,vuelve_y_anda_der		;7d2c
	ld a,(ix+006h)		;7d2e
	dec a			;7d31
	dec a			;7d32
	ld (ix+006h),a		;7d33
	ret			;7d36
vuelve_y_anda_der:
	ld a,(ix+006h)		;7d37
	inc a			;7d3a
	inc a			;7d3b
	ld (ix+006h),a		;7d3c
	ret			;7d3f

; ----------------------------------------------------------------------
; DATOS resto_7D40: otro trozo que nadie ejecuta (mira x >= 0xFB)
;   0x7d40..0x7d56  (22 bytes)
DATA_resto_7D40:
	defb 0ddh,07eh,006h,0feh,0fbh,0d2h,050h,07dh,0ddh,07eh,006h,0feh,001h,0dah,053h,07dh	; 7d40  .~....P}.~....S}
	defb 03eh,001h,0c9h,03eh,002h,0c9h	; 7d50

; ======================================================================
; CODIGO 0x7d56..0x7de0  (138 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Las clases de las casillas de alrededor del actor (byte alto de D774), en
; +17..+24: cuatro filas desde la suya, tres o cuatro casillas por fila, la
; ventana corrida una casilla hacia donde mira.
; ----------------------------------------------------------------------
casillas_actor:
	ld a,(ix+006h)		;7d56   ; H = x + 1, L = y + 1
	ld h,a			;7d59
	ld a,(ix+007h)		;7d5a
	ld l,a			;7d5d
	inc h			;7d5e
	inc l			;7d5f
	ld a,l			;7d60   ; la fila: (y - 0x20) / 16 * 0x20 bytes
	sub 020h		;7d61
	and 0f0h		;7d63
	ld b,000h		;7d65
	ld c,a			;7d67
	srl h		;7d68   ; la columna: x / 16 * 2
	srl h		;7d6a
	srl h		;7d6c
	srl h		;7d6e
	ld l,h			;7d70
	ld h,000h		;7d71
	add hl,hl			;7d73
	add hl,bc			;7d74
	add hl,bc			;7d75
	ld de,0d774h		;7d76   ; en D774
	add hl,de			;7d79
	inc hl			;7d7a   ; el byte alto
	bit 0,(ix+001h)		;7d7b   ; mirando a la derecha: una casilla mas alla
	call z,corre_ventana		;7d7f
	dec hl			;7d82   ; la de atras: +1F
	dec hl			;7d83
	ld a,(hl)			;7d84
	ld (ix+01fh),a		;7d85
	inc hl			;7d88   ; la suya: +20
	inc hl			;7d89
	ld a,(hl)			;7d8a
	ld (ix+020h),a		;7d8b
	inc hl			;7d8e   ; la de delante: +21
	inc hl			;7d8f
	ld a,(hl)			;7d90
	ld (ix+021h),a		;7d91
	inc hl			;7d94   ; la siguiente: +22
	inc hl			;7d95
	ld a,(hl)			;7d96
	ld (ix+022h),a		;7d97
	ld de,0001ah		;7d9a   ; una fila mas abajo: +17..+1A
	add hl,de			;7d9d
	ld a,(hl)			;7d9e
	ld (ix+017h),a		;7d9f
	inc hl			;7da2
	inc hl			;7da3
	ld a,(hl)			;7da4
	ld (ix+018h),a		;7da5
	inc hl			;7da8
	inc hl			;7da9
	ld a,(hl)			;7daa
	ld (ix+019h),a		;7dab
	inc hl			;7dae
	inc hl			;7daf
	ld a,(hl)			;7db0
	ld (ix+01ah),a		;7db1
	ld de,0001ah		;7db4   ; otra fila: +1B..+1E
	add hl,de			;7db7
	ld a,(hl)			;7db8
	ld (ix+01bh),a		;7db9
	inc hl			;7dbc
	inc hl			;7dbd
	ld a,(hl)			;7dbe
	ld (ix+01ch),a		;7dbf
	inc hl			;7dc2
	inc hl			;7dc3
	ld a,(hl)			;7dc4
	ld (ix+01dh),a		;7dc5
	inc hl			;7dc8
	inc hl			;7dc9
	ld a,(hl)			;7dca
	ld (ix+01eh),a		;7dcb
	ld de,0001ch		;7dce   ; y otra: +23, +24
	add hl,de			;7dd1
	ld a,(hl)			;7dd2
	ld (ix+023h),a		;7dd3
	inc hl			;7dd6
	inc hl			;7dd7
	ld a,(hl)			;7dd8
	ld (ix+024h),a		;7dd9
	ret			;7ddc
corre_ventana:
	inc hl			;7ddd   ; una casilla mas (2 bytes)
	inc hl			;7dde
	ret			;7ddf

; ----------------------------------------------------------------------
; DATOS resto_7DE0: otra lectura de casillas que nadie ejecuta
;   0x7de0..0x7e18  (56 bytes)
DATA_resto_7DE0:
	defb 0ddh,07eh,006h,067h,0ddh,07eh,007h,06fh,024h,02ch,07dh,0d6h,010h,0e6h,0f0h,006h	; 7de0  .~.g.~.o$,}.....
	defb 000h,04fh,0cbh,03ch,0cbh,03ch,0cbh,03ch,0cbh,03ch,06ch,026h,000h,029h,009h,009h	; 7df0  .O.<.<.<.<l&.)..
	defb 011h,074h,0d7h,019h,023h,0e5h,0ddh,07eh,001h,0a7h,018h,006h,011h,03eh,000h,019h	; 7e00  .t..#..~.....>..
	defb 07eh,0c9h,011h,043h,000h,019h,07eh,0c9h	; 7e10  ~..C..~.

; ======================================================================
; CODIGO 0x7e18..0x7e29  (17 bytes)
; ======================================================================


da_la_vuelta:
	ld a,(ix+001h)		;7e18   ; el bit 0 de la pose: hacia donde mira
	bit 0,a		;7e1b
	jr z,da_la_vuelta_izq		;7e1d
	res 0,(ix+001h)		;7e1f   ; a la derecha
	ret			;7e23
da_la_vuelta_izq:
	set 0,(ix+001h)		;7e24   ; a la izquierda
	ret			;7e28

; ----------------------------------------------------------------------
; DATOS resto_7E29: trozos que nadie ejecuta (moverse en diagonal)
;   0x7e29..0x7e4b  (34 bytes)
DATA_resto_7E29:
	defb 0ddh,07eh,001h,0e6h,001h,0cah,03eh,07eh,0ddh,035h,006h,0ddh,035h,006h,0ddh,035h	; 7e29  .~....>~.5..5..5
	defb 007h,0ddh,035h,007h,0c9h,0ddh,034h,006h,0ddh,034h,006h,0ddh,035h,007h,0ddh,035h	; 7e39  ..5...4..4..5..5
	defb 007h,0c9h	; 7e49

; ======================================================================
; CODIGO 0x7e4b..0x7ef1  (166 bytes)
; ======================================================================


cae_1:
	ld a,(ix+007h)		;7e4b   ; y + 1
	inc a			;7e4e
	ld (ix+007h),a		;7e4f
	res 1,(ix+001h)		;7e52   ; pose sin el bit 1
	call 04a8bh		;7e56   ; pintado
	ret			;7e59
cae_2_especial:
	inc (ix+007h)		;7e5a   ; y + 2 y la animacion del actor 0 (p03:7F3E)
	inc (ix+007h)		;7e5d
	jp anima_actor0		;7e60
bordes_x:
	ld a,(ix+006h)		;7e63   ; x < 1...
	cp 001h		;7e66
	call c,borde_izq		;7e68
	cp 0e7h		;7e6b   ; ...o >= 0xE7: se da la vuelta en el borde
	call nc,borde_der		;7e6d
	ret			;7e70
borde_izq:
	ld a,001h		;7e71   ; x = 1 y la vuelta
	ld (ix+006h),a		;7e73
	call da_la_vuelta		;7e76
	ret			;7e79
borde_der:
	ld a,0e7h		;7e7a   ; x = 0xE7 y la vuelta
	ld (ix+006h),a		;7e7c
	call da_la_vuelta		;7e7f
	ret			;7e82
anda:
	bit 0,(ix+001h)		;7e83   ; 2 pixeles hacia donde mira
	jr nz,anda_izq		;7e87
	inc (ix+006h)		;7e89
	inc (ix+006h)		;7e8c
	ret			;7e8f
anda_izq:
	dec (ix+006h)		;7e90
	dec (ix+006h)		;7e93
	ret			;7e96
rebota_izq:
	ld a,002h		;7e97   ; x = 2 y la vuelta
	ld (ix+006h),a		;7e99
	call da_la_vuelta		;7e9c
	ret			;7e9f
rebota_der:
	ld a,0dch		;7ea0   ; x = 0xDC y la vuelta
	ld (ix+006h),a		;7ea2
	call da_la_vuelta		;7ea5
	ret			;7ea8
tope_arriba:
	ld a,002h		;7ea9   ; y = 2
	ld (ix+007h),a		;7eab
	ret			;7eae
tope_abajo:
	ld a,0b5h		;7eaf   ; y = 0xB5
	ld (ix+007h),a		;7eb1
	ret			;7eb4
pose_b1_y_pinta:
	set 1,(ix+001h)		;7eb5   ; pose con el bit 1 y pintado
	call 04a8bh		;7eb9   ; p00 pinta_actor
	ret			;7ebc
nada_debajo:
	call casillas_actor		;7ebd   ; las casillas
	ld a,(ix+01ch)		;7ec0   ; las dos de debajo, +1C y +1D, de clase 0xF0...
	and 0f0h		;7ec3   ; la clase de la casilla (+1C)
	cp 0f0h		;7ec5   ; clase 0xF0?
	jr z,nada_debajo_2		;7ec7
	ret			;7ec9
nada_debajo_2:
	ld a,(ix+01dh)		;7eca
	and 0f0h		;7ecd   ; la clase de la casilla (+1D)
	cp 0f0h		;7ecf   ; clase 0xF0?
	jr z,nada_debajo_si		;7ed1
	ret			;7ed3
nada_debajo_si:
	ld a,0ffh		;7ed4   ; ...A = 0xFF: no hay nada, cae
	ret			;7ed6
nada_debajo_16:
	call casillas_actor		;7ed7   ; lo mismo con +18 y +19, la fila siguiente: debajo de los actores de 16 de alto
	ld a,(ix+018h)		;7eda
	and 0f0h		;7edd   ; la clase de la casilla (+18)
	cp 0f0h		;7edf   ; clase 0xF0?
	jr z,nada_debajo_16_2		;7ee1
	ret			;7ee3
nada_debajo_16_2:
	ld a,(ix+019h)		;7ee4
	and 0f0h		;7ee7   ; la clase de la casilla (+19)
	cp 0f0h		;7ee9   ; clase 0xF0?
	jr z,nada_debajo_16_si		;7eeb
	ret			;7eed
nada_debajo_16_si:
	ld a,0ffh		;7eee
	ret			;7ef0

; ----------------------------------------------------------------------
; DATOS resto_7EF1: otro trozo de andar que nadie ejecuta
;   0x7ef1..0x7f1f  (46 bytes)
DATA_resto_7EF1:
	defb 0ddh,0cbh,001h,046h,028h,009h,0ddh,07eh,006h,03ch,0ddh,077h,006h,018h,007h,0ddh	; 7ef1  ...F(..~.<.w....
	defb 07eh,006h,03dh,0ddh,077h,006h,0ddh,07eh,010h,03dh,0ddh,077h,010h,0c9h,03ah,0fch	; 7f01  ~.=.w..~.=.w..:.
	defb 0d8h,047h,0ddh,07eh,006h,0b8h,0cah,01ch,07fh,0afh,0c9h,03eh,0ffh,0c9h	; 7f11  .G.~.......>..

; ======================================================================
; CODIGO 0x7f1f..0x7f76  (87 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El actor 0 (D933) con animacion propia: sus poses salen de la tabla de
; p03:7F76 por tipo, y sus 12 sprites, desde la ficha 17, con el banco 8.
; ----------------------------------------------------------------------
anima_actor0_desde_cero:
	ld a,0feh		;7f1f   ; la animacion desde el principio (+A = 0xFE, +B = 1)...
	ld (0d93dh),a		;7f21   ; actor 0, byte +A = a
	ld a,001h		;7f24
	ld (0d93eh),a		;7f26   ; actor 0, byte +B = a
	call anima_actor0		;7f29   ; ...y ocho pasos
	call anima_actor0		;7f2c
	call anima_actor0		;7f2f
	call anima_actor0		;7f32
	call anima_actor0		;7f35
	call anima_actor0		;7f38
	call anima_actor0		;7f3b
anima_actor0:
	ld a,(0d933h)		;7f3e   ; su tipo - 1...
	dec a			;7f41
	ld l,a			;7f42
	ld h,000h		;7f43
	add hl,hl			;7f45
	ld de,07f76h		;7f46   ; ...en p03:7F76: su tabla de poses
	add hl,de			;7f49
	ld e,(hl)			;7f4a
	inc hl			;7f4b
	ld d,(hl)			;7f4c
	push de			;7f4d
	ld a,(0d934h)		;7f4e   ; y su pose (+1)
	ld l,a			;7f51
	ld h,000h		;7f52
	add hl,hl			;7f54
	pop de			;7f55
	add hl,de			;7f56
	ld e,(hl)			;7f57
	inc hl			;7f58
	ld d,(hl)			;7f59
	push de			;7f5a   ; la definicion
	pop ix		;7f5b
	ld hl,0d4ceh		;7f5d   ; a la ficha 17
	ld iy,0d93dh		;7f60   ; estado en +A/+B
	ld a,(0d939h)		;7f64   ; su x y su y
	ld (0d5ddh),a		;7f67   ; lo que se suma a la x de los sprites = a
	ld a,(0d93ah)		;7f6a   ; a = actor 0, byte +7
	ld (0d5deh),a		;7f6d   ; lo que se suma a la y de los sprites = a
	ld b,00ch		;7f70   ; 12 sprites
	call 058c3h		;7f72   ; con el banco 8
	ret			;7f75

; ----------------------------------------------------------------------
; DATOS poses_actor0: Las tablas de poses del actor 0 por tipo (7 palabras) y
;   las definiciones de cada pose (banco 8)
;   0x7f76..0x7fda  (100 bytes)
DATA_poses_actor0:
	defw 07f84h,07f94h,07fa8h,07fb0h,07fc0h,07fd4h,07fd8h,06000h	; 7f76
	defw 061e3h,060c3h,062a6h,0608fh,06272h,06150h,06333h,063c6h	; 7f86
	defw 063d1h,0643ah,06535h,0641bh,06420h,0648bh,06492h,064cfh	; 7f96
	defw 06511h,06586h,0658fh,065efh,065f8h,06693h,0669eh,067f5h	; 7fa6
	defw 06800h,06799h,0679eh,06925h,06934h,069f9h,06a02h,06abfh	; 7fb6
	defw 06ac8h,06b0dh,06b16h,06b97h,06ba0h,06c21h,06c2ah,06c99h	; 7fc6
	defw 06c9eh,06d03h	; 7fd6

; ======================================================================
; CODIGO 0x7fda..0x7fff  (37 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El actor 0 pasa a tipo 7 (con la musica 7) y empieza su animacion; la
; rutina sigue en p04:8000.
; ----------------------------------------------------------------------
actor0_a_tipo7:
	ld a,(0d933h)		;7fda   ; ya es del tipo 7: salta
	cp 007h		;7fdd
	jr z,$+36		;7fdf
	ld a,007h		;7fe1   ; la musica 7
	ld (0d17ah),a		;7fe3   ; musica pedida, para p01:640F = a
	ld a,007h		;7fe6   ; tipo 7...
	ld (0d933h),a		;7fe8   ; los 6 actores de la pantalla = a
	xor a			;7feb   ; ...pose 0...
	ld (0d934h),a		;7fec   ; actor 0, byte +1 = a
	ld a,0feh		;7fef   ; ...animacion desde el principio
	ld (0d93dh),a		;7ff1   ; actor 0, byte +A = a
	ld a,001h		;7ff4
	ld (0d93eh),a		;7ff6   ; actor 0, byte +B = a
	call anima_actor0		;7ff9   ; el primer paso
	ld hl,00130h		;7ffc   ; HL = 0x0130 (el `ld (nn),hl` que sigue empieza aqui y acaba en p04)

; ----------------------------------------------------------------------
; DATOS cruce_7FFF: el primer byte de `ld (nn),hl` (0x22): la instruccion
;   acaba en p04:8000-8001
;   0x7fff..0x8000  (1 bytes)
DATA_cruce_7FFF:
	defb 022h	; 7fff
