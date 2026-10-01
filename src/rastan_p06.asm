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


L_6000:
	ld a,(0d90fh)		;6000
	bit 7,a		;6003
	jp nz,L_603D		;6005
	call L_68A7		;6008
	ld a,(0d904h)		;600b
	ld (0d8f4h),a		;600e
	ld a,(0d905h)		;6011
	ld (0d8f5h),a		;6014
	ld a,(0d8fch)		;6017   ; a = la x de Rastan
	ld (0d5ddh),a		;601a   ; lo que se suma a la x de los sprites = a
	ld a,(0d8fdh)		;601d   ; a = la y de Rastan
	ld (0d5deh),a		;6020   ; lo que se suma a la y de los sprites = a
	ld hl,0d904h		;6023
	bit 6,(hl)		;6026
	jp z,L_602D		;6028
	res 5,(hl)		;602b
L_602D:
	call L_6134		;602d
	call L_606B		;6030
	call L_60D4		;6033
	ld a,080h		;6036
	ld hl,0d188h		;6038
	ld (hl),a			;603b
	ret			;603c
L_603D:
	ld a,(0d8fch)		;603d   ; a = la x de Rastan
	ld (0d5ddh),a		;6040   ; lo que se suma a la x de los sprites = a
	ld a,(0d8fdh)		;6043   ; a = la y de Rastan
	ld (0d5deh),a		;6046   ; lo que se suma a la y de los sprites = a
	ld a,(0d188h)		;6049
	bit 1,a		;604c
	jr z,L_6055		;604e
	call L_6134		;6050
	jr L_605E		;6053
L_6055:
	ld ix,0d413h		;6055   ; ix -> las 32 fichas de sprite
	ld b,00bh		;6059
	call 04823h		;605b
L_605E:
	ld hl,0d188h		;605e
	dec (hl)			;6061
	ld a,(hl)			;6062
	or a			;6063
	ret nz			;6064
	ld hl,0d17dh		;6065   ; hl -> bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo
	set 6,(hl)		;6068
	ret			;606a
L_606B:
	ld a,(0d925h)		;606b
	ld b,a			;606e
	ld a,(0d91ch)		;606f
	cp b			;6072
	ret z			;6073
	ld (0d925h),a		;6074
	ld a,(0d91ch)		;6077
	srl a		;607a
	ld h,a			;607c
	ld l,000h		;607d
	ld de,0501ah		;607f
	add hl,de			;6082
	ld de,05014h		;6083
	ex de,hl			;6086
	push de			;6087
	and a			;6088
	jp z,L_6091		;6089
	ld a,077h		;608c
	call 0440eh		;608e
L_6091:
	ld a,(0d91ch)		;6091
	srl a		;6094
	ld b,a			;6096
	ld a,(0d91dh)		;6097
	srl a		;609a
	sub b			;609c
	and a			;609d
	jp z,L_60B1		;609e
	ld h,a			;60a1
	ld l,000h		;60a2
	pop de			;60a4
	ld e,01ah		;60a5
	add hl,de			;60a7
	ld e,014h		;60a8
	ld a,066h		;60aa
	ex de,hl			;60ac
	call 0440eh		;60ad
	ret			;60b0
L_60B1:
	pop de			;60b1
	ret			;60b2
L_60B3:
	exx			;60b3
	ld b,000h		;60b4
	exx			;60b6
	ld d,018h		;60b7
	ld e,000h		;60b9
	call 04612h		;60bb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x60be..0x60c6  (8 bytes)
DATA_60BE:
	defb 020h,020h,020h,020h,020h,020h,030h,000h	; 60be        0.

; ======================================================================
; CODIGO 0x60c6..0x6397  (721 bytes)
; ======================================================================


	call L_60E9		;60c6
	ld l,000h		;60c9
	ld h,018h		;60cb
	ld (0d5dbh),hl		;60cd   ; la lista o la cadena que se esta pintando = hl
	call L_60FA		;60d0
	ret			;60d3
L_60D4:
	call L_60E9		;60d4
	bit 7,b		;60d7
	ret z			;60d9
	res 7,(ix+02dh)		;60da
	ld l,000h		;60de
	ld h,018h		;60e0
	ld (0d5dbh),hl		;60e2   ; la lista o la cadena que se esta pintando = hl
	call L_60FA		;60e5
	ret			;60e8
L_60E9:
	ld ix,0d8f4h		;60e9
	ld e,(ix+02ah)		;60ed
	ld d,(ix+02bh)		;60f0
	ld c,(ix+02ch)		;60f3
	ld b,(ix+02dh)		;60f6
	ret			;60f9
L_60FA:
	ld h,000h		;60fa
	ld a,c			;60fc
	rra			;60fd
	rra			;60fe
	rra			;60ff
	rra			;6100
	push bc			;6101
	call L_611F		;6102
	pop bc			;6105
	ld a,c			;6106
	call L_611F		;6107
	ld a,d			;610a
	rra			;610b
	rra			;610c
	rra			;610d
	rra			;610e
	call L_611F		;610f
	ld a,d			;6112
	call L_611F		;6113
	ld a,e			;6116
	rra			;6117
	rra			;6118
	rra			;6119
	rra			;611a
	call L_611F		;611b
	ld a,e			;611e
L_611F:
	and 00fh		;611f
	jr nz,L_6127		;6121
	dec h			;6123
	inc h			;6124
	jr z,L_612A		;6125
L_6127:
	add a,010h		;6127
	inc h			;6129
L_612A:
	add a,020h		;612a
	push hl			;612c
	push de			;612d
	call 04633h		;612e
	pop de			;6131
	pop hl			;6132
	ret			;6133
L_6134:
	ld a,(0d8f5h)		;6134
	ld b,a			;6137
	ld a,(0d8f8h)		;6138
	cp b			;613b
	jp nz,L_614D		;613c
	ld a,(0d8f7h)		;613f
	ld b,a			;6142
	ld a,(0d8f4h)		;6143
	cp b			;6146
	jp z,L_616C		;6147
	jp L_6156		;614a
L_614D:
	ld a,(0d8f5h)		;614d
	ld (0d8f8h),a		;6150
	call L_6302		;6153
L_6156:
	ld a,(0d8f4h)		;6156
	ld (0d8f7h),a		;6159
	ld a,0feh		;615c
	ld (0d8feh),a		;615e
	ld (0d900h),a		;6161
	ld a,001h		;6164
	ld (0d8ffh),a		;6166
	ld (0d901h),a		;6169
L_616C:
	ld a,(0d8f4h)		;616c
	and 07fh		;616f
	ld d,000h		;6171
	ld e,a			;6173
	push de			;6174
	pop hl			;6175
	add hl,hl			;6176
	add hl,de			;6177
	ld de,0639fh		;6178
	add hl,de			;617b
	ld e,(hl)			;617c
	inc hl			;617d
	ld d,(hl)			;617e
	inc hl			;617f
	ex af,af'			;6180
	ld a,(hl)			;6181
	push af			;6182
	ex af,af'			;6183
	push de			;6184
	pop ix		;6185
	ld hl,0d429h		;6187   ; hl -> ficha de sprite 2
	ld iy,0d8feh		;618a
	ld a,01ah		;618e
	ld (0d191h),a		;6190   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;6193   ; registro del mapper: banco A en 0x8000
	call 05aa5h		;6196
	ex af,af'			;6199
	ld b,a			;619a
	ex af,af'			;619b
	bit 0,b		;619c
	jr z,L_61A5		;619e
	ld hl,0d904h		;61a0
	res 5,(hl)		;61a3
L_61A5:
	ld a,(0d8f4h)		;61a5
	and 07fh		;61a8
	ld d,000h		;61aa
	ld e,a			;61ac
	push de			;61ad
	pop hl			;61ae
	add hl,hl			;61af
	add hl,de			;61b0
	ld de,064b3h		;61b1
	add hl,de			;61b4
	ld e,(hl)			;61b5
	inc hl			;61b6
	ld d,(hl)			;61b7
	inc hl			;61b8
	ex af,af'			;61b9
	ld a,(hl)			;61ba
	ex af,af'			;61bb
	push de			;61bc
	pop ix		;61bd
	ld hl,0d455h		;61bf   ; hl -> ficha de sprite 6
	ld iy,0d900h		;61c2
	ld a,01ah		;61c6
	ld (0d191h),a		;61c8   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;61cb   ; registro del mapper: banco A en 0x8000
	call 05aa5h		;61ce
	ld a,(0d8f5h)		;61d1
	and 003h		;61d4
	ld l,a			;61d6
	ld h,000h		;61d7
	add hl,hl			;61d9
	ld de,06397h		;61da
	add hl,de			;61dd
	ld e,(hl)			;61de
	inc hl			;61df
	ld d,(hl)			;61e0
	ld a,(0d8f4h)		;61e1
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
	ex af,af'			;61f1
	pop af			;61f2
	ex af,af'			;61f3
	ld hl,0d413h		;61f4   ; hl -> las 32 fichas de sprite
	ld iy,0d8feh		;61f7
	ld a,01ah		;61fb
	ld (0d191h),a		;61fd   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;6200   ; registro del mapper: banco A en 0x8000
	call 05b95h		;6203
	ret			;6206
L_6207:
	push ix		;6207
	ld a,(ix+010h)		;6209
	ld e,a			;620c
	ld a,(ix+011h)		;620d
	sub 020h		;6210
	ld d,a			;6212
	ld a,e			;6213
	srl a		;6214
	srl a		;6216
	srl a		;6218
	srl a		;621a
	or d			;621c
	ld l,a			;621d
	ld h,000h		;621e
	add hl,hl			;6220
	push hl			;6221
	ld de,0d5f4h		;6222   ; de -> el fondo desempaquetado: 11 x 16 bloques
	add hl,de			;6225
	ld e,(hl)			;6226
	inc hl			;6227
	ld d,(hl)			;6228
	ex de,hl			;6229
	ld a,(ix+010h)		;622a
	ld e,a			;622d
	ld a,(ix+011h)		;622e
	ld d,a			;6231
	exx			;6232
	ld b,000h		;6233
	exx			;6235
	push ix		;6236
	call 04777h		;6238
	pop ix		;623b
	pop hl			;623d
	push hl			;623e
	ld de,0d5f6h		;623f
	add hl,de			;6242
	ld e,(hl)			;6243
	inc hl			;6244
	ld d,(hl)			;6245
	ex de,hl			;6246
	ld a,(ix+010h)		;6247
	add a,010h		;624a
	ld e,a			;624c
	ld a,(ix+011h)		;624d
	ld d,a			;6250
	exx			;6251
	ld b,000h		;6252
	exx			;6254
	push ix		;6255
	call 04777h		;6257
	pop ix		;625a
	pop hl			;625c
	push hl			;625d
	ld de,0d614h		;625e
	add hl,de			;6261
	ld e,(hl)			;6262
	inc hl			;6263
	ld d,(hl)			;6264
	ex de,hl			;6265
	ld a,(ix+010h)		;6266
	ld e,a			;6269
	ld a,(ix+011h)		;626a
	add a,010h		;626d
	ld d,a			;626f
	exx			;6270
	ld b,000h		;6271
	exx			;6273
	push ix		;6274
	call 04777h		;6276
	pop ix		;6279
	pop hl			;627b
	ld de,0d616h		;627c
	add hl,de			;627f
	ld e,(hl)			;6280
	inc hl			;6281
	ld d,(hl)			;6282
	ex de,hl			;6283
	ld a,(ix+010h)		;6284
	add a,010h		;6287
	ld e,a			;6289
	ld a,(ix+011h)		;628a
	add a,010h		;628d
	ld d,a			;628f
	exx			;6290
	ld b,000h		;6291
	exx			;6293
	push ix		;6294
	call 04777h		;6296
	pop ix		;6299
	pop ix		;629b
	ret			;629d
L_629E:
	ld a,(0d92bh)		;629e   ; a = x del bloque especial de la pantalla
	ld e,a			;62a1
	ld a,(0d92ch)		;62a2   ; a = y del bloque especial
	sub 020h		;62a5
	ld d,a			;62a7
	ld a,e			;62a8
	srl a		;62a9
	srl a		;62ab
	srl a		;62ad
	srl a		;62af
	or d			;62b1
	ld l,a			;62b2
	ld h,000h		;62b3
	add hl,hl			;62b5
	ld de,0d5f4h		;62b6   ; de -> el fondo desempaquetado: 11 x 16 bloques
	add hl,de			;62b9
	ld e,(hl)			;62ba
	inc hl			;62bb
	ld d,(hl)			;62bc
	ex de,hl			;62bd
	ld a,(0d92bh)		;62be   ; a = x del bloque especial de la pantalla
	ld e,a			;62c1
	ld a,(0d92ch)		;62c2   ; a = y del bloque especial
	ld d,a			;62c5
	exx			;62c6
	ld b,000h		;62c7
	exx			;62c9
	call 04777h		;62ca
	ld a,(0d92bh)		;62cd   ; a = x del bloque especial de la pantalla
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
	ld de,0d774h		;62e5   ; de -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,de			;62e8
	ld e,(hl)			;62e9
	inc hl			;62ea
	ld d,000h		;62eb
	ex de,hl			;62ed
	ld a,l			;62ee
	cp 0ffh		;62ef
	ret z			;62f1
	ld a,(0d92bh)		;62f2   ; a = x del bloque especial de la pantalla
	ld e,a			;62f5
	ld a,(0d92ch)		;62f6   ; a = y del bloque especial
	ld d,a			;62f9
	exx			;62fa
	ld b,001h		;62fb
	exx			;62fd
	call 04777h		;62fe
	ret			;6301
L_6302:
	push ix		;6302
	ld a,(0d8f5h)		;6304
	and 003h		;6307
	jp nz,L_6312		;6309
	ld hl,00013h		;630c
	jp L_6317		;630f
L_6312:
	add a,019h		;6312
	ld l,a			;6314
	ld h,000h		;6315
L_6317:
	ld de,010b0h		;6317
	call L_6379		;631a
	ld a,(0d8f5h)		;631d
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
	ld de,010c0h		;6334
	call L_6379		;6337
	ld a,(0d8f5h)		;633a
	bit 5,a		;633d
	ld hl,00013h		;633f
	jp z,L_6348		;6342
	ld hl,00016h		;6345
L_6348:
	ld de,010d0h		;6348
	call L_6379		;634b
	ld a,(0d8f5h)		;634e
	bit 6,a		;6351
	ld hl,00013h		;6353
	jp z,L_635C		;6356
	ld hl,00015h		;6359
L_635C:
	ld de,010e0h		;635c
	call L_6379		;635f
	ld a,(0d8f5h)		;6362
	bit 7,a		;6365
	ld hl,00013h		;6367
	jp z,L_6370		;636a
	ld hl,00014h		;636d
L_6370:
	ld de,010f0h		;6370
	call L_6379		;6373
	pop ix		;6376
	ret			;6378
L_6379:
	push de			;6379
	push hl			;637a
	ld hl,(0d5eah)		;637b   ; hl = la tabla de bloques de 16x16 de la fase
	ld (0d5ech),hl		;637e   ; la tabla de bloques guardada = hl
	ld hl,05bc3h		;6381
	ld (0d5eah),hl		;6384   ; la tabla de bloques de 16x16 de la fase = hl
	pop hl			;6387
	pop de			;6388
	exx			;6389
	ld b,000h		;638a
	exx			;638c
	call 04777h		;638d
	ld hl,(0d5ech)		;6390   ; hl = la tabla de bloques guardada
	ld (0d5eah),hl		;6393   ; la tabla de bloques de 16x16 de la fase = hl
	ret			;6396

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6397..0x68a7  (1296 bytes)
DATA_6397:
	defb 0c7h,065h,07fh,066h,037h,067h,0efh,067h,0e6h,08ch,002h,0d5h,08ch,002h,0e6h,08ch	; 6397  .e.f7g.g........
	defb 002h,0d5h,08ch,002h,02ah,08fh,002h,025h,08fh,002h,039h,08ch,002h,042h,08ch,002h	; 63a7  ....*..%..9..B..
	defb 0e6h,08ch,002h,0d5h,08ch,002h,039h,08ch,002h,042h,08ch,002h,0e6h,08ch,002h,0d5h	; 63b7  ......9..B......
	defb 08ch,002h,0e6h,08ch,002h,0d5h,08ch,002h,047h,08fh,000h,050h,08fh,000h,047h,08fh	; 63c7  ........G..P..G.
	defb 000h,050h,08fh,000h,02ah,08fh,002h,025h,08fh,002h,047h,08fh,000h,050h,08fh,000h	; 63d7  .P..*..%..G..P..
	defb 047h,08fh,000h,050h,08fh,000h,0d1h,095h,002h,0c8h,095h,002h,000h,000h,000h,000h	; 63e7  G..P............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0e6h,08ch,000h,0d5h,08ch,000h,0e6h,08ch	; 63f7  ................
	defb 000h,0d5h,08ch,000h,084h,08eh,000h,073h,08eh,000h,080h,08dh,000h,06fh,08dh,000h	; 6407  .......s.....o..
	defb 0e6h,08ch,000h,0d5h,08ch,000h,080h,08dh,000h,06fh,08dh,000h,0e6h,08ch,000h,0d5h	; 6417  .........o......
	defb 08ch,000h,0e6h,08ch,000h,0d5h,08ch,000h,047h,08fh,000h,050h,08fh,000h,047h,08fh	; 6427  ........G..P..G.
	defb 000h,050h,08fh,000h,02ah,08fh,002h,025h,08fh,002h,047h,08fh,000h,050h,08fh,000h	; 6437  .P..*..%..G..P..
	defb 047h,08fh,000h,050h,08fh,000h,0d1h,095h,002h,0c8h,095h,002h,000h,000h,000h,000h	; 6447  G..P............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0fbh,08fh,002h,000h,090h,002h,0fbh,08fh	; 6457  ................
	defb 002h,000h,090h,002h,0fbh,08fh,002h,000h,090h,002h,057h,090h,002h,05ch,090h,002h	; 6467  ..........W..\..
	defb 0a7h,090h,002h,0ach,090h,002h,057h,090h,002h,05ch,090h,002h,0fch,090h,002h,0fch	; 6477  ......W..\......
	defb 090h,002h,0fch,090h,002h,0fch,090h,002h,0fbh,08fh,002h,000h,090h,002h,0ach,090h	; 6487  ................
	defb 002h,0a7h,090h,002h,0ach,090h,002h,0a7h,090h,002h,0f7h,090h,002h,0fch,090h,002h	; 6497  ................
	defb 0f7h,090h,002h,0fch,090h,002h,0fbh,08fh,002h,000h,090h,002h,014h,08eh,002h,009h	; 64a7  ................
	defb 08eh,002h,014h,08eh,000h,009h,08eh,000h,084h,08eh,002h,073h,08eh,002h,093h,08ch	; 64b7  ...........s....
	defb 002h,09ch,08ch,002h,0cdh,08fh,002h,0d2h,08fh,002h,093h,08ch,002h,09ch,08ch,002h	; 64c7  ................
	defb 0a3h,091h,002h,0a8h,091h,002h,07ah,091h,002h,075h,091h,002h,014h,08eh,002h,009h	; 64d7  ......z..u......
	defb 08eh,002h,0cdh,08fh,002h,0d2h,08fh,002h,094h,08fh,002h,07dh,08fh,002h,0a3h,091h	; 64e7  ...........}....
	defb 002h,0a8h,091h,002h,07ah,091h,002h,075h,091h,002h,00dh,096h,002h,004h,096h,002h	; 64f7  ....z..u........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,014h,08eh,002h,009h	; 6507  ................
	defb 08eh,002h,014h,08eh,000h,009h,08eh,000h,02ah,08fh,000h,025h,08fh,000h,093h,08ch	; 6517  ........*..%....
	defb 002h,09ch,08ch,002h,0cdh,08fh,002h,0d2h,08fh,002h,093h,08ch,002h,09ch,08ch,002h	; 6527  ................
	defb 0a3h,091h,002h,0a8h,091h,002h,07ah,091h,002h,075h,091h,002h,014h,08eh,002h,009h	; 6537  ......z..u......
	defb 08eh,002h,0cdh,08fh,002h,0d2h,08fh,002h,094h,08fh,000h,07dh,08fh,000h,0a3h,091h	; 6547  ...........}....
	defb 002h,0a8h,091h,002h,07ah,091h,002h,075h,091h,002h,00dh,096h,002h,004h,096h,002h	; 6557  ....z..u........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,029h,090h,002h,02eh	; 6567  ............)...
	defb 090h,002h,029h,090h,002h,02eh,090h,002h,029h,090h,002h,02eh,090h,002h,079h,090h	; 6577  ..).....).....y.
	defb 002h,07eh,090h,002h,0dah,090h,002h,0d5h,090h,002h,079h,090h,002h,07eh,090h,002h	; 6587  .~........y..~..
	defb 025h,091h,002h,02ah,091h,002h,053h,091h,002h,058h,091h,002h,029h,090h,002h,02eh	; 6597  %..*..S..X..)...
	defb 090h,002h,0dah,090h,002h,0d5h,090h,002h,0dah,090h,002h,0d5h,090h,002h,025h,091h	; 65a7  ..............%.
	defb 002h,025h,091h,002h,053h,091h,002h,053h,091h,002h,029h,090h,002h,02eh,090h,002h	; 65b7  .%..S..S..).....
	defb 0d6h,091h,0c5h,091h,0d6h,091h,0c5h,091h,0f8h,091h,0e7h,091h,094h,095h,094h,095h	; 65c7  ................
	defb 0d6h,091h,0c5h,091h,094h,095h,094h,095h,0d6h,091h,0c5h,091h,0d6h,091h,0c5h,091h	; 65d7  ................
	defb 03eh,092h,035h,092h,03eh,092h,035h,092h,030h,092h,02bh,092h,03eh,092h,035h,092h	; 65e7  >.5.>.5.0.+.>.5.
	defb 03eh,092h,035h,092h,094h,095h,094h,095h,000h,000h,000h,000h,000h,000h,000h,000h	; 65f7  >.5.............
	defb 0d6h,091h,0c5h,091h,0d6h,091h,0c5h,091h,0f8h,091h,0e7h,091h,01ah,092h,009h,092h	; 6607  ................
	defb 0d6h,091h,0c5h,091h,01ah,092h,009h,092h,0d6h,091h,0c5h,091h,0d6h,091h,0c5h,091h	; 6617  ................
	defb 03eh,092h,035h,092h,03eh,092h,035h,092h,030h,092h,02bh,092h,03eh,092h,035h,092h	; 6627  >.5.>.5.0.+.>.5.
	defb 03eh,092h,035h,092h,094h,095h,094h,095h,000h,000h,000h,000h,000h,000h,000h,000h	; 6637  >.5.............
	defb 096h,096h,091h,096h,096h,096h,091h,096h,096h,096h,091h,096h,094h,095h,094h,095h	; 6647  ................
	defb 0d6h,091h,0c5h,091h,094h,095h,094h,095h,096h,096h,091h,096h,096h,096h,091h,096h	; 6657  ................
	defb 096h,096h,091h,096h,03eh,092h,035h,092h,096h,096h,091h,096h,096h,096h,091h,096h	; 6667  ....>.5.........
	defb 096h,096h,091h,096h,094h,095h,094h,095h,015h,093h,004h,093h,015h,093h,004h,093h	; 6677  ................
	defb 037h,093h,026h,093h,094h,095h,094h,095h,015h,093h,004h,093h,094h,095h,094h,095h	; 6687  7.&.............
	defb 015h,093h,004h,093h,015h,093h,004h,093h,05bh,093h,052h,093h,05bh,093h,052h,093h	; 6697  ........[.R.[.R.
	defb 04dh,093h,048h,093h,05bh,093h,052h,093h,05bh,093h,052h,093h,094h,095h,094h,095h	; 66a7  M.H.[.R.[.R.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,015h,093h,004h,093h,015h,093h,004h,093h	; 66b7  ................
	defb 037h,093h,026h,093h,075h,093h,064h,093h,015h,093h,004h,093h,075h,093h,064h,093h	; 66c7  7.&.u.d.....u.d.
	defb 015h,093h,004h,093h,015h,093h,004h,093h,05bh,093h,052h,093h,05bh,093h,052h,093h	; 66d7  ........[.R.[.R.
	defb 04dh,093h,048h,093h,05bh,093h,052h,093h,05bh,093h,052h,093h,094h,095h,094h,095h	; 66e7  M.H.[.R.[.R.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,07eh,096h,079h,096h,07eh,096h,079h,096h	; 66f7  ........~.y.~.y.
	defb 07eh,096h,079h,096h,094h,095h,094h,095h,015h,093h,004h,093h,094h,095h,094h,095h	; 6707  ~.y.............
	defb 07eh,096h,079h,096h,07eh,096h,079h,096h,07eh,096h,079h,096h,015h,093h,004h,093h	; 6717  ~.y.~.y.~.y.....
	defb 07eh,096h,079h,096h,07eh,096h,079h,096h,07eh,096h,079h,096h,094h,095h,094h,095h	; 6727  ~.y.~.y.~.y.....
	defb 054h,094h,043h,094h,054h,094h,043h,094h,076h,094h,065h,094h,094h,095h,094h,095h	; 6737  T.C.T.C.v.e.....
	defb 054h,094h,043h,094h,094h,095h,094h,095h,054h,094h,043h,094h,054h,094h,043h,094h	; 6747  T.C.....T.C.T.C.
	defb 090h,094h,087h,094h,090h,094h,087h,094h,09eh,094h,099h,094h,090h,094h,087h,094h	; 6757  ................
	defb 090h,094h,087h,094h,094h,095h,094h,095h,000h,000h,000h,000h,000h,000h,000h,000h	; 6767  ................
	defb 054h,094h,043h,094h,054h,094h,043h,094h,076h,094h,065h,094h,0b4h,094h,0a3h,094h	; 6777  T.C.T.C.v.e.....
	defb 054h,094h,043h,094h,0b4h,094h,0a3h,094h,054h,094h,043h,094h,054h,094h,043h,094h	; 6787  T.C.....T.C.T.C.
	defb 090h,094h,087h,094h,090h,094h,087h,094h,09eh,094h,099h,094h,090h,094h,087h,094h	; 6797  ................
	defb 090h,094h,087h,094h,094h,095h,094h,095h,000h,000h,000h,000h,000h,000h,000h,000h	; 67a7  ................
	defb 066h,096h,061h,096h,066h,096h,061h,096h,066h,096h,061h,096h,094h,095h,094h,095h	; 67b7  f.a.f.a.f.a.....
	defb 054h,094h,043h,094h,094h,095h,094h,095h,066h,096h,061h,096h,066h,096h,061h,096h	; 67c7  T.C.....f.a.f.a.
	defb 066h,096h,061h,096h,054h,094h,043h,094h,066h,096h,061h,096h,066h,096h,061h,096h	; 67d7  f.a.T.C.f.a.f.a.
	defb 066h,096h,061h,096h,094h,095h,094h,095h,00bh,08bh,0fah,08ah,00bh,08bh,0fah,08ah	; 67e7  f.a.............
	defb 02dh,08bh,01ch,08bh,094h,095h,094h,095h,00bh,08bh,0fah,08ah,094h,095h,094h,095h	; 67f7  -...............
	defb 00bh,08bh,0fah,08ah,00bh,08bh,0fah,08ah,073h,08bh,06ah,08bh,073h,08bh,06ah,08bh	; 6807  ........s.j.s.j.
	defb 065h,08bh,060h,08bh,073h,08bh,06ah,08bh,073h,08bh,06ah,08bh,094h,095h,094h,095h	; 6817  e.`.s.j.s.j.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,00bh,08bh,0fah,08ah,00bh,08bh,0fah,08ah	; 6827  ................
	defb 02dh,08bh,01ch,08bh,04fh,08bh,03eh,08bh,00bh,08bh,0fah,08ah,04fh,08bh,03eh,08bh	; 6837  -...O.>.....O.>.
	defb 00bh,08bh,0fah,08ah,00bh,08bh,0fah,08ah,073h,08bh,06ah,08bh,073h,08bh,06ah,08bh	; 6847  ........s.j.s.j.
	defb 065h,08bh,060h,08bh,073h,08bh,06ah,08bh,073h,08bh,06ah,08bh,094h,095h,094h,095h	; 6857  e.`.s.j.s.j.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0aeh,096h,0a9h,096h,0aeh,096h,0a9h,096h	; 6867  ................
	defb 0aeh,096h,0a9h,096h,094h,095h,094h,095h,00bh,08bh,0fah,08ah,094h,095h,094h,095h	; 6877  ................
	defb 0aeh,096h,0a9h,096h,0aeh,096h,0a9h,096h,0aeh,096h,0a9h,096h,00bh,08bh,0fah,08ah	; 6887  ................
	defb 00bh,08bh,0fah,08ah,0aeh,096h,0a9h,096h,0aeh,096h,0a9h,096h,094h,095h,094h,095h	; 6897  ................

; ======================================================================
; CODIGO 0x68a7..0x740a  (2915 bytes)
; ======================================================================


L_68A7:
	ld a,(0d90fh)		;68a7
	bit 7,a		;68aa
	jp nz,L_69AE		;68ac
	push af			;68af
	call L_6A1F		;68b0
	pop af			;68b3
	bit 4,a		;68b4
	jr nz,L_68CA		;68b6
	ld hl,0d910h		;68b8
	bit 1,(hl)		;68bb
	jr z,L_68EC		;68bd
	ld a,(0d913h)		;68bf   ; a = 0x27 al entrar en una pantalla
	dec a			;68c2
	ld (0d913h),a		;68c3   ; 0x27 al entrar en una pantalla = a
	jr nz,L_68EC		;68c6
	res 1,(hl)		;68c8
L_68CA:
	ld c,a			;68ca
	ld a,(0d913h)		;68cb   ; a = 0x27 al entrar en una pantalla
	dec a			;68ce
	ld (0d913h),a		;68cf   ; 0x27 al entrar en una pantalla = a
	jr z,L_68E0		;68d2
	cp 03ch		;68d4
	jr nc,L_68E8		;68d6
	res 6,c		;68d8
	ld a,c			;68da
	ld (0d90fh),a		;68db
	jr L_68EC		;68de
L_68E0:
	res 4,c		;68e0
	ld a,c			;68e2
	ld (0d90fh),a		;68e3
	jr L_68EC		;68e6
L_68E8:
	xor a			;68e8
	ld (0d573h),a		;68e9   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
L_68EC:
	ld hl,0d927h		;68ec
	inc (hl)			;68ef
	ld a,(hl)			;68f0
	cp 03ch		;68f1
	jr c,L_6921		;68f3
	ld (hl),000h		;68f5
	ld hl,0d91ah		;68f7
	ld a,(hl)			;68fa
	or a			;68fb
	jr z,L_6912		;68fc
	dec (hl)			;68fe
	jr nz,L_6912		;68ff
	ld a,(0d905h)		;6901
	and 0fch		;6904
	ld (0d905h),a		;6906
	xor a			;6909
	ld (0d919h),a		;690a
	ld hl,0d905h		;690d
	res 7,(hl)		;6910
L_6912:
	ld hl,0d92ah		;6912
	ld a,(hl)			;6915
	or a			;6916
	jr z,L_6921		;6917
	dec (hl)			;6919
	jr nz,L_6921		;691a
	ld hl,0d905h		;691c
	res 5,(hl)		;691f
L_6921:
	xor a			;6921
	ld (0d928h),a		;6922
	ld (0d929h),a		;6925
	ld b,003h		;6928
	ld de,00026h		;692a
	ld ix,0d934h		;692d   ; ix -> actor 0, byte +1
L_6931:
	ld a,(ix+000h)		;6931
	cp 016h		;6934
	jr nz,L_693C		;6936
	res 7,(ix+025h)		;6938
L_693C:
	add ix,de		;693c
	djnz L_6931		;693e
	call L_69AF		;6940
	call L_6A37		;6943
	call 08104h		;6946
	call L_7A26		;6949
	call L_7B22		;694c
	ld hl,0d904h		;694f
	bit 6,(hl)		;6952
	jr z,L_696F		;6954
	res 5,(hl)		;6956
	ld hl,0d90fh		;6958
	res 0,(hl)		;695b
	ld hl,0d929h		;695d
	bit 7,(hl)		;6960
	jp z,L_6AD6		;6962
	ld a,005h		;6965
	bit 5,(hl)		;6967
	jr z,L_69A9		;6969
	ld a,011h		;696b
	jr L_69A9		;696d
L_696F:
	ld a,(0d928h)		;696f
	bit 7,a		;6972
	jr nz,L_6995		;6974
	bit 6,a		;6976
	jr nz,$+32		;6978
	bit 3,a		;697a
	jr nz,$+31		;697c
	bit 2,a		;697e
	jr nz,$+30		;6980
	bit 5,a		;6982
	jr nz,$+29		;6984
	bit 4,a		;6986
	jr nz,$+28		;6988
	bit 1,a		;698a
	jr nz,$+27		;698c
	bit 0,a		;698e
	ret z			;6990
	ld a,010h		;6991
	jr L_69A9		;6993
L_6995:
	ld a,001h		;6995
	ld bc,0023eh		;6997
	ld bc,0063eh		;699a
	ld bc,0073eh		;699d
	ld bc,00c3eh		;69a0
	ld bc,0033eh		;69a3
	ld bc,0043eh		;69a6
L_69A9:
	ld a,a			;69a9
	ld (0d178h),a		;69aa   ; peticion de sonido para p01:63E1 = a
	ret			;69ad
L_69AE:
	ret			;69ae
L_69AF:
	ld a,(0d573h)		;69af   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld b,a			;69b2
	ld a,(0d90fh)		;69b3
	bit 0,a		;69b6
	jp nz,L_6A0A		;69b8
	bit 4,b		;69bb
	jp z,L_69F2		;69bd
	ld hl,0d90fh		;69c0
	set 5,(hl)		;69c3
	ld hl,0d904h		;69c5
	bit 5,(hl)		;69c8
	jr nz,L_6A09		;69ca
	ld a,(hl)			;69cc
	and 01eh		;69cd
	cp 014h		;69cf
	jr z,L_6A09		;69d1
	exx			;69d3
	ld hl,0d928h		;69d4
	set 4,(hl)		;69d7
	ld a,(0d919h)		;69d9
	cp 003h		;69dc
	jr nz,L_69E2		;69de
	set 5,(hl)		;69e0
L_69E2:
	exx			;69e2
	ld hl,0d958h		;69e3   ; hl -> actor 0, byte +25
	ld de,00026h		;69e6
	ld b,003h		;69e9
L_69EB:
	res 7,(hl)		;69eb
	add hl,de			;69ed
	djnz L_69EB		;69ee
	jr L_6A09		;69f0
L_69F2:
	ld hl,0d904h		;69f2
	bit 5,(hl)		;69f5
	ld hl,0d90fh		;69f7
	jr nz,L_69FF		;69fa
	res 5,(hl)		;69fc
	ret			;69fe
L_69FF:
	set 5,(hl)		;69ff
	ld a,(0d573h)		;6a01   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 0f3h		;6a04
	ld (0d573h),a		;6a06   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
L_6A09:
	ret			;6a09
L_6A0A:
	ld hl,0d90fh		;6a0a
	set 5,(hl)		;6a0d
	ld hl,0d904h		;6a0f
	set 5,(hl)		;6a12
	ld a,(0d573h)		;6a14   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 0fch		;6a17
	or 002h		;6a19
	ld (0d573h),a		;6a1b   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6a1e
L_6A1F:
	call 042bah		;6a1f
	ld a,(0d17dh)		;6a22   ; a = bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo
	bit 7,a		;6a25
	ret z			;6a27
	ld a,(0d181h)		;6a28   ; a = 5 = la demo ha terminado
	add a,a			;6a2b
	add a,a			;6a2c
	add a,a			;6a2d
	add a,a			;6a2e
	and 010h		;6a2f
	or 008h		;6a31
	ld (0d573h),a		;6a33   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6a36
L_6A37:
	xor a			;6a37
	ld (0d8fah),a		;6a38
	ld (0d8fbh),a		;6a3b
	ld a,(0d8fch)		;6a3e   ; a = la x de Rastan
	ld h,a			;6a41
	ld a,(0d8fdh)		;6a42   ; a = la y de Rastan
	ld l,a			;6a45
	ld a,(0d904h)		;6a46
	ld b,a			;6a49
	ld a,(0d573h)		;6a4a   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6a4d
	ld a,(0d90eh)		;6a4e
	bit 6,a		;6a51
	jr z,L_6A66		;6a53
	bit 5,c		;6a55
	jr nz,L_6A60		;6a57
	res 6,a		;6a59
	ld (0d90eh),a		;6a5b
	jr L_6A66		;6a5e
L_6A60:
	res 5,c		;6a60
	ld a,c			;6a62
	ld (0d573h),a		;6a63   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
L_6A66:
	ld a,(0d90fh)		;6a66
	bit 3,a		;6a69
	jp nz,L_6B1B		;6a6b
	ld a,(0d90dh)		;6a6e
	bit 7,a		;6a71
	jp nz,L_71E0		;6a73
	bit 5,a		;6a76
	jp nz,L_6D1E		;6a78
	bit 4,a		;6a7b
	jr z,L_6AB5		;6a7d
	bit 2,a		;6a7f
	jr nz,L_6A98		;6a81
	ld d,002h		;6a83
	ld a,(0d906h)		;6a85
	add a,080h		;6a88
	ld (0d906h),a		;6a8a
	jr nc,L_6AA9		;6a8d
	ld a,h			;6a8f
	cp 0f0h		;6a90
	jr nc,L_6AA9		;6a92
	inc h			;6a94
	jp L_6AA9		;6a95
L_6A98:
	ld d,008h		;6a98
	ld a,(0d906h)		;6a9a
	sub 080h		;6a9d
	ld (0d906h),a		;6a9f
	jr nc,L_6AA9		;6aa2
	ld a,h			;6aa4
	or a			;6aa5
	jr z,L_6AA9		;6aa6
	dec h			;6aa8
L_6AA9:
	ld a,(0d573h)		;6aa9   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6aac
	bit 5,c		;6aad
	jp nz,L_7175		;6aaf
	jp L_6E64		;6ab2
L_6AB5:
	ld a,(0d573h)		;6ab5   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6ab8
	bit 5,b		;6ab9
	jr nz,L_6AD6		;6abb
	bit 5,c		;6abd
	jp nz,L_7175		;6abf
	ld a,(0d90fh)		;6ac2
	bit 5,a		;6ac5
	jr nz,L_6AF2		;6ac7
	bit 1,c		;6ac9
	jp nz,L_7886		;6acb
	bit 2,a		;6ace
	jp nz,L_6B0A		;6ad0
	jp L_6E25		;6ad3
L_6AD6:
	ld a,b			;6ad6
	and 01eh		;6ad7
	cp 004h		;6ad9
	jr z,L_6B04		;6adb
	cp 010h		;6add
	jr z,L_6AFB		;6adf
	cp 014h		;6ae1
	jr z,L_6AF2		;6ae3
	cp 018h		;6ae5
	jr z,L_6AFB		;6ae7
	cp 01ah		;6ae9
	jr z,L_6AFB		;6aeb
	xor a			;6aed
	ld (0d573h),a		;6aee   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6af1
L_6AF2:
	ld a,(0d573h)		;6af2   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 003h		;6af5
	ld (0d573h),a		;6af7   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6afa
L_6AFB:
	ld a,(0d573h)		;6afb   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	and 001h		;6afe
	ld (0d573h),a		;6b00   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6b03
L_6B04:
	ld a,002h		;6b04
	ld (0d573h),a		;6b06   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;6b09
L_6B0A:
	bit 3,c		;6b0a
	jr nz,L_6B14		;6b0c
	bit 2,c		;6b0e
	ret z			;6b10
	dec h			;6b11
	jr L_6B18		;6b12
L_6B14:
	bit 2,c		;6b14
	ret nz			;6b16
	inc h			;6b17
L_6B18:
	jp L_7878		;6b18
L_6B1B:
	bit 5,c		;6b1b
	jp nz,L_6CF6		;6b1d
	ld a,(0d90fh)		;6b20
	res 1,a		;6b23
	ld (0d90fh),a		;6b25
	ld ix,(0d914h)		;6b28
	ld a,(ix+002h)		;6b2c
	and 07fh		;6b2f
	ld e,a			;6b31
	ld a,(0d916h)		;6b32
	cp e			;6b35
	ret z			;6b36
	ld a,e			;6b37
	ld (0d916h),a		;6b38
	ld a,(0d917h)		;6b3b
	ld l,a			;6b3e
	ld a,(ix+001h)		;6b3f
	cp 002h		;6b42
	jp z,L_6BFD		;6b44
	jp nc,L_6C67		;6b47
	cp 001h		;6b4a
	jp z,L_6BA4		;6b4c
	ld a,e			;6b4f
	cp 00ah		;6b50
	jr c,L_6B5B		;6b52
	sub 00ah		;6b54
	neg		;6b56
	add a,008h		;6b58
	ld e,a			;6b5a
L_6B5B:
	cp 001h		;6b5b
	jr c,L_6B76		;6b5d
	jr z,L_6B6B		;6b5f
	cp 008h		;6b61
	jr c,L_6B7F		;6b63
	jr z,L_6B6B		;6b65
	cp 00ah		;6b67
	jr c,L_6B76		;6b69
L_6B6B:
	ld a,l			;6b6b
	sub (ix+007h)		;6b6c
	cp 02fh		;6b6f
	jr c,L_6B7F		;6b71
	dec l			;6b73
	jr L_6B7F		;6b74
L_6B76:
	ld a,l			;6b76
	sub (ix+007h)		;6b77
	cp 01fh		;6b7a
	jr c,L_6B7F		;6b7c
	dec l			;6b7e
L_6B7F:
	ld a,l			;6b7f
	sub (ix+007h)		;6b80
	ld b,a			;6b83
	ld a,e			;6b84
	add a,a			;6b85
	add a,a			;6b86
	add a,e			;6b87
	add a,a			;6b88
	add a,a			;6b89
	push hl			;6b8a
	ld l,a			;6b8b
	ld h,000h		;6b8c
	add hl,hl			;6b8e
	ld de,08d2ch		;6b8f
	add hl,de			;6b92
	ld e,b			;6b93
	srl e		;6b94
	ld d,000h		;6b96
	add hl,de			;6b98
	ld a,(hl)			;6b99
	add a,(ix+006h)		;6b9a
	sub 010h		;6b9d
	pop hl			;6b9f
	ld h,a			;6ba0
	jp L_7878		;6ba1
L_6BA4:
	ld a,e			;6ba4
	cp 00ah		;6ba5
	jr c,L_6BB0		;6ba7
	sub 00ah		;6ba9
	neg		;6bab
	add a,008h		;6bad
	ld e,a			;6baf
L_6BB0:
	cp 001h		;6bb0
	jr c,L_6BCB		;6bb2
	jr z,L_6BC0		;6bb4
	cp 008h		;6bb6
	jr c,L_6BD9		;6bb8
	jr z,L_6BC0		;6bba
	cp 00ah		;6bbc
	jr c,L_6BCB		;6bbe
L_6BC0:
	ld a,l			;6bc0
	sub (ix+007h)		;6bc1
	cp 020h		;6bc4
	jr c,L_6BD9		;6bc6
	dec l			;6bc8
	jr L_6BD9		;6bc9
L_6BCB:
	ld a,l			;6bcb
	sub (ix+007h)		;6bcc
	cp 018h		;6bcf
	jr c,L_6BD9		;6bd1
	dec l			;6bd3
	cp 030h		;6bd4
	jr c,L_6BD9		;6bd6
	dec l			;6bd8
L_6BD9:
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
	ld de,08ebch		;6be8
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
	jp L_7878		;6bfa
L_6BFD:
	ld a,e			;6bfd
	cp 00ah		;6bfe
	jr c,L_6C09		;6c00
	sub 00ah		;6c02
	neg		;6c04
	add a,008h		;6c06
	ld e,a			;6c08
L_6C09:
	cp 001h		;6c09
	jr c,L_6C2A		;6c0b
	jr z,L_6C1F		;6c0d
	cp 002h		;6c0f
	jr z,L_6C3A		;6c11
	cp 007h		;6c13
	jr c,L_6C43		;6c15
	jr z,L_6C3A		;6c17
	cp 009h		;6c19
	jr c,L_6C1F		;6c1b
	jr z,L_6C2A		;6c1d
L_6C1F:
	ld a,l			;6c1f
	sub (ix+007h)		;6c20
	cp 010h		;6c23
	jr c,L_6C43		;6c25
	dec l			;6c27
	jr L_6C43		;6c28
L_6C2A:
	ld a,l			;6c2a
	sub (ix+007h)		;6c2b
	cp 00ah		;6c2e
	jr c,L_6C43		;6c30
	dec l			;6c32
	cp 01ch		;6c33
	jr c,L_6C43		;6c35
	dec l			;6c37
	jr L_6C43		;6c38
L_6C3A:
	ld a,l			;6c3a
	sub (ix+007h)		;6c3b
	cp 020h		;6c3e
	jr c,L_6C43		;6c40
	dec l			;6c42
L_6C43:
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
	ld de,08ffch		;6c52
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
	jp L_7878		;6c64
L_6C67:
	ld a,e			;6c67
	cp 00ah		;6c68
	jr c,L_6C73		;6c6a
	sub 00ah		;6c6c
	neg		;6c6e
	add a,008h		;6c70
	ld e,a			;6c72
L_6C73:
	cp 001h		;6c73
	jr c,L_6CA0		;6c75
	jr z,L_6C8B		;6c77
	cp 003h		;6c79
	jr c,L_6CBA		;6c7b
	jr z,L_6CCA		;6c7d
	cp 006h		;6c7f
	jr c,L_6CD3		;6c81
	jr z,L_6CCA		;6c83
	cp 008h		;6c85
	jr c,L_6CBA		;6c87
	jr nz,L_6CA0		;6c89
L_6C8B:
	ld a,l			;6c8b
	sub (ix+007h)		;6c8c
	cp 005h		;6c8f
	jr c,L_6CD3		;6c91
	dec l			;6c93
	cp 00dh		;6c94
	jr c,L_6CD3		;6c96
	dec l			;6c98
	cp 016h		;6c99
	jr c,L_6CD3		;6c9b
	dec l			;6c9d
	jr L_6CD3		;6c9e
L_6CA0:
	ld a,l			;6ca0
	sub (ix+007h)		;6ca1
	cp 003h		;6ca4
	jr c,L_6CD3		;6ca6
	dec l			;6ca8
	cp 008h		;6ca9
	jr c,L_6CD3		;6cab
	dec l			;6cad
	cp 00dh		;6cae
	jr c,L_6CD3		;6cb0
	dec l			;6cb2
	cp 013h		;6cb3
	jr c,L_6CD3		;6cb5
	dec l			;6cb7
	jr L_6CD3		;6cb8
L_6CBA:
	ld a,l			;6cba
	sub (ix+007h)		;6cbb
	cp 009h		;6cbe
	jr c,L_6CD3		;6cc0
	dec l			;6cc2
	cp 019h		;6cc3
	jr c,L_6CD3		;6cc5
	dec l			;6cc7
	jr L_6CD3		;6cc8
L_6CCA:
	ld a,l			;6cca
	sub (ix+007h)		;6ccb
	cp 017h		;6cce
	jr c,L_6CD3		;6cd0
	dec l			;6cd2
L_6CD3:
	ld a,l			;6cd3
	sub (ix+007h)		;6cd4
	ld b,a			;6cd7
	ld a,e			;6cd8
	add a,a			;6cd9
	add a,a			;6cda
	add a,a			;6cdb
	add a,a			;6cdc
	push hl			;6cdd
	ld l,a			;6cde
	ld h,000h		;6cdf
	ld de,090ech		;6ce1
	add hl,de			;6ce4
	ld e,b			;6ce5
	srl e		;6ce6
	ld d,000h		;6ce8
	add hl,de			;6cea
	ld a,(hl)			;6ceb
	add a,(ix+006h)		;6cec
	sub 010h		;6cef
	pop hl			;6cf1
	ld h,a			;6cf2
	jp L_7878		;6cf3
L_6CF6:
	ld a,(0d904h)		;6cf6
	ld e,008h		;6cf9
	ld d,004h		;6cfb
	and 001h		;6cfd
	jr nz,L_6D05		;6cff
	ld e,004h		;6d01
	ld d,008h		;6d03
L_6D05:
	ld a,(0d573h)		;6d05   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6d08
	and d			;6d09
	jr nz,L_6D14		;6d0a
	ld a,(0d573h)		;6d0c   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	or e			;6d0f
	ld (0d573h),a		;6d10   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ld c,a			;6d13
L_6D14:
	push hl			;6d14
	ld hl,0d90fh		;6d15
	res 3,(hl)		;6d18
	pop hl			;6d1a
	jp L_7175		;6d1b
L_6D1E:
	ld a,(0d90fh)		;6d1e
	res 1,a		;6d21
	ld (0d90fh),a		;6d23
	ld a,(0d573h)		;6d26   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;6d29
	bit 5,b		;6d2a
	ret nz			;6d2c
	ld a,(0d90fh)		;6d2d
	bit 5,a		;6d30
	ret nz			;6d32
	ld a,l			;6d33
	cp 01fh		;6d34
	jr c,L_6D3D		;6d36
	bit 5,c		;6d38
	jp nz,L_6E12		;6d3a
L_6D3D:
	bit 0,c		;6d3d
	jr nz,L_6DBC		;6d3f
	bit 1,c		;6d41
	ret z			;6d43
	inc l			;6d44
	push bc			;6d45
	push hl			;6d46
	ld a,004h		;6d47
	call L_78A9		;6d49
	ld a,b			;6d4c
	and 0f0h		;6d4d
	cp 020h		;6d4f
	jr c,L_6D5B		;6d51
	cp 080h		;6d53
	jr c,L_6DB9		;6d55
	cp 0a0h		;6d57
	jr z,L_6DB9		;6d59
L_6D5B:
	ld a,c			;6d5b
	and 0f0h		;6d5c
	cp 020h		;6d5e
	jr c,L_6D6A		;6d60
	cp 080h		;6d62
	jr c,L_6DB9		;6d64
	cp 0a0h		;6d66
	jr z,L_6DB9		;6d68
L_6D6A:
	ld a,d			;6d6a
	and 0f0h		;6d6b
	cp 020h		;6d6d
	jr c,L_6D79		;6d6f
	cp 080h		;6d71
	jr c,L_6DB9		;6d73
	cp 0a0h		;6d75
	jr z,L_6DB9		;6d77
L_6D79:
	pop hl			;6d79
	pop bc			;6d7a
	push bc			;6d7b
	push hl			;6d7c
	inc l			;6d7d
	inc l			;6d7e
	inc l			;6d7f
	ld a,001h		;6d80
	call L_78A9		;6d82
	ld a,b			;6d85
	and 0f0h		;6d86
	cp 080h		;6d88
	jp nz,L_6D95		;6d8a
	ld a,c			;6d8d
	and 0f0h		;6d8e
	cp 090h		;6d90
	jp z,L_6DA5		;6d92
L_6D95:
	ld a,c			;6d95
	and 0f0h		;6d96
	cp 080h		;6d98
	jp nz,L_6DAF		;6d9a
	ld a,d			;6d9d
	and 0f0h		;6d9e
	cp 090h		;6da0
	jp nz,L_6DAF		;6da2
L_6DA5:
	ld hl,0d90fh		;6da5
	set 1,(hl)		;6da8
	pop hl			;6daa
	pop bc			;6dab
	jp L_7878		;6dac
L_6DAF:
	ld a,0c0h		;6daf
	ld (0d90dh),a		;6db1
	pop hl			;6db4
	pop bc			;6db5
	jp L_7878		;6db6
L_6DB9:
	pop hl			;6db9
	pop bc			;6dba
	ret			;6dbb
L_6DBC:
	dec l			;6dbc
	ld a,l			;6dbd
	cp 01fh		;6dbe
	jp c,L_7878		;6dc0
	push bc			;6dc3
	push hl			;6dc4
	ld a,001h		;6dc5
	call L_78A9		;6dc7
	ld e,000h		;6dca
	ld a,b			;6dcc
	and 0f0h		;6dcd
	cp 010h		;6dcf
	jr c,L_6DDC		;6dd1
	cp 080h		;6dd3
	jr c,L_6E01		;6dd5
	cp 0a0h		;6dd7
	jr nc,L_6E01		;6dd9
	inc e			;6ddb
L_6DDC:
	ld a,c			;6ddc
	and 0f0h		;6ddd
	cp 010h		;6ddf
	jr c,L_6E01		;6de1
	cp 080h		;6de3
	jr c,L_6E01		;6de5
	cp 0a0h		;6de7
	jr nc,L_6E01		;6de9
	inc e			;6deb
	ld a,d			;6dec
	and 0f0h		;6ded
	cp 010h		;6def
	jp c,L_6DFC		;6df1
	cp 080h		;6df4
	jr c,L_6E01		;6df6
	cp 0a0h		;6df8
	jr nz,L_6E0A		;6dfa
L_6DFC:
	ld a,e			;6dfc
	cp 002h		;6dfd
	jr z,L_6E0A		;6dff
L_6E01:
	pop hl			;6e01
	pop bc			;6e02
	ld a,(0d8fdh)		;6e03   ; a = la y de Rastan
	ld l,a			;6e06
	jp L_7878		;6e07
L_6E0A:
	ld hl,0d90fh		;6e0a
	set 1,(hl)		;6e0d
	jp L_7876		;6e0f
L_6E12:
	bit 3,c		;6e12
	jr nz,L_6E19		;6e14
	bit 2,c		;6e16
	ret z			;6e18
L_6E19:
	set 7,a		;6e19
	set 6,a		;6e1b
	res 0,a		;6e1d
	ld (0d90eh),a		;6e1f
	jp L_717A		;6e22
L_6E25:
	ld d,002h		;6e25
	bit 0,b		;6e27
	jr z,L_6E2D		;6e29
	ld d,008h		;6e2b
L_6E2D:
	bit 3,c		;6e2d
	jr nz,L_6E44		;6e2f
	bit 2,c		;6e31
	jr z,L_6E54		;6e33
	ld a,h			;6e35
	cp 0f8h		;6e36
	jr nc,L_6E3F		;6e38
	cp 0f0h		;6e3a
	jp nc,L_6E54		;6e3c
L_6E3F:
	ld d,008h		;6e3f
	dec h			;6e41
	jr L_6E64		;6e42
L_6E44:
	bit 2,c		;6e44
	jr nz,L_6E54		;6e46
	ld a,h			;6e48
	cp 0f0h		;6e49
	jp nc,L_6E54		;6e4b
	ld d,002h		;6e4e
	inc h			;6e50
	jp L_6E64		;6e51
L_6E54:
	ld a,(0d90dh)		;6e54
	bit 4,a		;6e57
	jp z,L_789A		;6e59
	ld d,008h		;6e5c
	bit 2,a		;6e5e
	jr z,L_6E64		;6e60
	ld d,002h		;6e62
L_6E64:
	push bc			;6e64
	push hl			;6e65
	ld a,d			;6e66
	call L_78A9		;6e67
	ld d,c			;6e6a
	ld a,b			;6e6b
	and 0f0h		;6e6c
	cp 010h		;6e6e
	jr c,L_6E86		;6e70
	jr z,L_6E86		;6e72
	cp 040h		;6e74
	jr c,L_6EA3		;6e76
	cp 060h		;6e78
	jp c,L_6EAC		;6e7a
	cp 080h		;6e7d
	jp c,L_6ED8		;6e7f
	cp 0a0h		;6e82
	jr z,L_6EA3		;6e84
L_6E86:
	ld a,c			;6e86
	and 0f0h		;6e87
	cp 010h		;6e89
	jp c,L_6F0B		;6e8b
	jp z,L_6F0B		;6e8e
	cp 040h		;6e91
	jr c,L_6EA3		;6e93
	cp 060h		;6e95
	jr c,L_6EAC		;6e97
	cp 080h		;6e99
	jp c,L_6ED8		;6e9b
	cp 0a0h		;6e9e
	jp nz,L_6F0B		;6ea0
L_6EA3:
	pop hl			;6ea3
	pop bc			;6ea4
	ld a,(0d8fch)		;6ea5   ; a = la x de Rastan
	ld h,a			;6ea8
	jp L_6F0D		;6ea9
L_6EAC:
	pop hl			;6eac
	pop bc			;6ead
	bit 3,c		;6eae
	jr nz,L_6F04		;6eb0
	ld a,h			;6eb2
	and 00fh		;6eb3
	cp 00eh		;6eb5
	jp c,L_6F0D		;6eb7
	ld a,(0d90dh)		;6eba
	bit 4,a		;6ebd
	jp nz,L_6F0D		;6ebf
	set 4,a		;6ec2
	res 2,a		;6ec4
	ld (0d90dh),a		;6ec6
	ld a,l			;6ec9
	and 0f8h		;6eca
	ld (0d908h),a		;6ecc
	ld a,h			;6ecf
	and 0f0h		;6ed0
	ld (0d907h),a		;6ed2
	jp L_6F0D		;6ed5
L_6ED8:
	pop hl			;6ed8
	pop bc			;6ed9
	bit 2,c		;6eda
	jr nz,L_6F04		;6edc
	ld a,h			;6ede
	and 00fh		;6edf
	cp 002h		;6ee1
	jp nc,L_6F0D		;6ee3
	ld a,(0d90dh)		;6ee6
	bit 4,a		;6ee9
	jp nz,L_6F0D		;6eeb
	set 4,a		;6eee
	set 2,a		;6ef0
	ld (0d90dh),a		;6ef2
	ld a,l			;6ef5
	and 0f8h		;6ef6
	ld (0d908h),a		;6ef8
	ld a,h			;6efb
	and 0f0h		;6efc
	ld (0d907h),a		;6efe
	jp L_6F0D		;6f01
L_6F04:
	ld a,(0d8fch)		;6f04   ; a = la x de Rastan
	ld h,a			;6f07
	jp L_6F0D		;6f08
L_6F0B:
	pop hl			;6f0b
	pop bc			;6f0c
L_6F0D:
	push bc			;6f0d
	push de			;6f0e
	push hl			;6f0f
	inc l			;6f10
	inc l			;6f11
	inc l			;6f12
	ld a,001h		;6f13
	call L_78A9		;6f15
	ld a,b			;6f18
	and 0f0h		;6f19
	cp 080h		;6f1b
	jp nz,L_6F27		;6f1d
	ld a,c			;6f20
	and 0f0h		;6f21
	cp 090h		;6f23
	jr z,L_6F45		;6f25
L_6F27:
	ld a,c			;6f27
	and 0f0h		;6f28
	cp 080h		;6f2a
	jp nz,L_6F66		;6f2c
	ld a,d			;6f2f
	and 0f0h		;6f30
	cp 090h		;6f32
	jp nz,L_6F66		;6f34
	pop hl			;6f37
	ld a,h			;6f38
	and 00fh		;6f39
	cp 00ch		;6f3b
	jr c,L_6F67		;6f3d
	ld a,h			;6f3f
	add a,010h		;6f40
	ld h,a			;6f42
	jr L_6F4D		;6f43
L_6F45:
	pop hl			;6f45
	ld a,h			;6f46
	and 00fh		;6f47
	cp 004h		;6f49
	jr nc,L_6F67		;6f4b
L_6F4D:
	pop de			;6f4d
	pop bc			;6f4e
	ld a,h			;6f4f
	and 0f0h		;6f50
	ld h,a			;6f52
	ld a,b			;6f53
	and 0e1h		;6f54
	or 004h		;6f56
	ld b,a			;6f58
	ld a,(0d90dh)		;6f59
	res 4,a		;6f5c
	set 5,a		;6f5e
	ld (0d90dh),a		;6f60
	jp L_7878		;6f63
L_6F66:
	pop hl			;6f66
L_6F67:
	pop de			;6f67
	pop bc			;6f68
	ld a,(0d90dh)		;6f69
	bit 4,a		;6f6c
	jp nz,L_6FE8		;6f6e
	push bc			;6f71
	push hl			;6f72
	ld a,004h		;6f73
	call L_78A9		;6f75
	ld a,b			;6f78
	and 0f0h		;6f79
	cp 010h		;6f7b
	jr c,L_6F90		;6f7d
	jr z,L_6F90		;6f7f
	cp 040h		;6f81
	jp c,L_7138		;6f83
	cp 070h		;6f86
	jp z,L_7160		;6f88
	cp 0a0h		;6f8b
	jp z,L_7138		;6f8d
L_6F90:
	ld a,c			;6f90
	and 0f0h		;6f91
	cp 020h		;6f93
	jr c,L_6FA4		;6f95
	cp 040h		;6f97
	jr c,L_6FC2		;6f99
	cp 060h		;6f9b
	jp z,L_7160		;6f9d
	cp 0a0h		;6fa0
	jr z,L_6FC2		;6fa2
L_6FA4:
	ld a,d			;6fa4
	and 0f0h		;6fa5
	cp 010h		;6fa7
	jp c,L_6FB8		;6fa9
	jr z,L_6FB8		;6fac
	cp 040h		;6fae
	jp c,L_7876		;6fb0
	cp 0a0h		;6fb3
	jp z,L_7876		;6fb5
L_6FB8:
	ld a,0c0h		;6fb8
	ld (0d90dh),a		;6fba
	pop hl			;6fbd
	pop bc			;6fbe
	jp L_7878		;6fbf
L_6FC2:
	ld a,d			;6fc2
	cp 040h		;6fc3
	jp c,L_7876		;6fc5
	cp 060h		;6fc8
	jp nc,L_7876		;6fca
	pop hl			;6fcd
	pop bc			;6fce
	ld a,h			;6fcf
	cp 008h		;6fd0
	jp c,L_7878		;6fd2
	ld a,(0d90dh)		;6fd5
	set 4,a		;6fd8
	set 3,a		;6fda
	ld (0d90dh),a		;6fdc
	ld a,(0d8fdh)		;6fdf   ; a = la y de Rastan
	ld (0d907h),a		;6fe2
	jp L_7878		;6fe5
L_6FE8:
	ld a,(0d90dh)		;6fe8
	bit 2,a		;6feb
	jp nz,L_708A		;6fed
	ld a,h			;6ff0
	and 00fh		;6ff1
	sra a		;6ff3
	sub 008h		;6ff5
	ld e,a			;6ff7
	ld a,(0d907h)		;6ff8
	ld d,a			;6ffb
	xor h			;6ffc
	and 0f0h		;6ffd
	jr z,L_7023		;6fff
	ld a,d			;7001
	cp h			;7002
	jr nc,L_7015		;7003
	ld a,h			;7005
	and 0f0h		;7006
	ld (0d907h),a		;7008
	ld a,(0d908h)		;700b
	add a,008h		;700e
	ld (0d908h),a		;7010
	jr L_7023		;7013
L_7015:
	ld a,h			;7015
	and 0f0h		;7016
	ld (0d907h),a		;7018
	ld a,(0d908h)		;701b
	sub 008h		;701e
	ld (0d908h),a		;7020
L_7023:
	ld a,(0d908h)		;7023
	add a,e			;7026
	ld l,a			;7027
	push bc			;7028
	push de			;7029
	push hl			;702a
	ld a,004h		;702b
	call L_78A9		;702d
	ld a,d			;7030
	and 0f0h		;7031
	cp 020h		;7033
	jr c,L_7045		;7035
	cp 040h		;7037
	jp c,L_7124		;7039
	cp 080h		;703c
	jr c,L_7084		;703e
	cp 0a0h		;7040
	jp z,L_7124		;7042
L_7045:
	ld a,b			;7045
	and 0f0h		;7046
	cp 020h		;7048
	jp c,L_7055		;704a
	cp 080h		;704d
	jr c,L_7084		;704f
	cp 0a0h		;7051
	jr z,L_7084		;7053
L_7055:
	ld a,c			;7055
	and 0f0h		;7056
	cp 020h		;7058
	jp c,L_7068		;705a
	cp 080h		;705d
	jr c,L_7084		;705f
	cp 0a0h		;7061
	jr z,L_7084		;7063
	jp L_7068		;7065
L_7068:
	pop hl			;7068
	push hl			;7069
	ld a,l			;706a
	add a,008h		;706b
	ld l,a			;706d
	ld a,004h		;706e
	call L_78A9		;7070
	ld a,d			;7073
	and 0f0h		;7074
	cp 020h		;7076
	jp c,L_716A		;7078
	cp 080h		;707b
	jr c,L_7084		;707d
	cp 0a0h		;707f
	jp nz,L_716A		;7081
L_7084:
	pop hl			;7084
	pop de			;7085
	pop bc			;7086
	jp L_7878		;7087
L_708A:
	ld a,h			;708a
	and 00fh		;708b
	srl a		;708d
	neg		;708f
	dec a			;7091
	ld e,a			;7092
	ld a,(0d907h)		;7093
	ld d,a			;7096
	xor h			;7097
	and 0f0h		;7098
	jr z,L_70BE		;709a
	ld a,d			;709c
	cp h			;709d
	jr nc,L_70B0		;709e
	ld a,h			;70a0
	and 0f0h		;70a1
	ld (0d907h),a		;70a3
	ld a,(0d908h)		;70a6
	sub 008h		;70a9
	ld (0d908h),a		;70ab
	jr L_70BE		;70ae
L_70B0:
	ld a,h			;70b0
	and 0f0h		;70b1
	ld (0d907h),a		;70b3
	ld a,(0d908h)		;70b6
	add a,008h		;70b9
	ld (0d908h),a		;70bb
L_70BE:
	ld a,(0d908h)		;70be
	add a,e			;70c1
	ld l,a			;70c2
	ld a,h			;70c3
	and 00fh		;70c4
	push bc			;70c6
	push de			;70c7
	push hl			;70c8
	ld a,004h		;70c9
	call L_78A9		;70cb
	ld a,b			;70ce
	and 0f0h		;70cf
	cp 020h		;70d1
	jr c,L_70E1		;70d3
	cp 040h		;70d5
	jr c,L_7124		;70d7
	cp 080h		;70d9
	jr c,L_711E		;70db
	cp 0a0h		;70dd
	jr z,L_7124		;70df
L_70E1:
	ld a,d			;70e1
	and 0f0h		;70e2
	cp 020h		;70e4
	jp c,L_70F1		;70e6
	cp 080h		;70e9
	jr c,L_711E		;70eb
	cp 0a0h		;70ed
	jr z,L_711E		;70ef
L_70F1:
	ld a,c			;70f1
	cp 020h		;70f2
	jp c,L_7102		;70f4
	cp 080h		;70f7
	jr c,L_711E		;70f9
	cp 0a0h		;70fb
	jr z,L_711E		;70fd
	jp L_7102		;70ff
L_7102:
	pop hl			;7102
	push hl			;7103
	ld a,l			;7104
	add a,008h		;7105
	ld l,a			;7107
	ld a,004h		;7108
	call L_78A9		;710a
	ld a,b			;710d
	and 0f0h		;710e
	cp 020h		;7110
	jp c,L_716A		;7112
	cp 080h		;7115
	jr c,L_711E		;7117
	cp 0a0h		;7119
	jp nz,L_716A		;711b
L_711E:
	pop hl			;711e
	pop de			;711f
	pop bc			;7120
	jp L_7878		;7121
L_7124:
	pop hl			;7124
	pop de			;7125
	pop bc			;7126
	ld a,(0d90dh)		;7127
	res 4,a		;712a
	res 2,a		;712c
	ld (0d90dh),a		;712e
	ld a,l			;7131
	and 0f0h		;7132
	ld l,a			;7134
	jp L_7878		;7135
L_7138:
	ld a,c			;7138
	and 0f0h		;7139
	cp 050h		;713b
	jp nz,L_7876		;713d
	pop hl			;7140
	pop bc			;7141
	ld a,h			;7142
	and 00fh		;7143
	cp 004h		;7145
	jp c,L_7878		;7147
	ld a,010h		;714a
	ld (0d90dh),a		;714c
L_714F:
	ld a,l			;714f
	and 0f0h		;7150
	add a,008h		;7152
	ld (0d908h),a		;7154
	ld a,h			;7157
	and 0f0h		;7158
	ld (0d907h),a		;715a
	jp L_7878		;715d
L_7160:
	pop hl			;7160
	pop bc			;7161
	ld a,014h		;7162
	ld (0d90dh),a		;7164
	jp L_714F		;7167
L_716A:
	ld a,0c0h		;716a
	ld (0d90dh),a		;716c
	pop hl			;716f
	pop de			;7170
	pop bc			;7171
	jp L_7878		;7172
L_7175:
	ld a,040h		;7175
	ld (0d90eh),a		;7177
L_717A:
	push hl			;717a
	ld hl,0d90fh		;717b
	res 2,(hl)		;717e
	pop hl			;7180
	bit 0,c		;7181
	jp nz,L_71AB		;7183
	push hl			;7186
	ld hl,0740bh		;7187
	bit 3,c		;718a
	jr nz,L_7199		;718c
	bit 2,c		;718e
	jr z,L_71A4		;7190
	ld a,088h		;7192
	ld de,07435h		;7194
	jr L_71CE		;7197
L_7199:
	bit 2,c		;7199
	jr nz,L_71A4		;719b
	ld de,07420h		;719d
	ld a,08ch		;71a0
	jr L_71CE		;71a2
L_71A4:
	ld a,080h		;71a4
	ld de,00000h		;71a6
	jr L_71CE		;71a9
L_71AB:
	push hl			;71ab
	ld hl,0744ah		;71ac
	bit 3,c		;71af
	jr nz,L_71BE		;71b1
	bit 2,c		;71b3
	jr z,L_71C9		;71b5
	ld a,089h		;71b7
	ld de,07488h		;71b9
	jr L_71CE		;71bc
L_71BE:
	bit 2,c		;71be
	jr nz,L_71C9		;71c0
	ld de,07469h		;71c2
	ld a,08dh		;71c5
	jr L_71CE		;71c7
L_71C9:
	ld a,080h		;71c9
	ld de,00000h		;71cb
L_71CE:
	ld (0d90dh),a		;71ce
	ld (0d90bh),de		;71d1
	ld (0d909h),hl		;71d5
	exx			;71d8
	ld hl,0d928h		;71d9
	set 0,(hl)		;71dc
	exx			;71de
	pop hl			;71df
L_71E0:
	bit 6,a		;71e0
	jp nz,L_74A7		;71e2
	bit 1,a		;71e5
	jp nz,L_739E		;71e7
	ld de,(0d909h)		;71ea
	ld a,(de)			;71ee
	cp 080h		;71ef
	jp z,L_736E		;71f1
	inc de			;71f4
	ld (0d909h),de		;71f5
	add a,l			;71f9
	ld l,a			;71fa
	ld a,(0d90dh)		;71fb
	bit 3,a		;71fe
	jp z,L_72B6		;7200
	ld de,(0d90bh)		;7203
	ld a,(de)			;7207
	inc de			;7208
	ld (0d90bh),de		;7209
	ld e,a			;720d
	add a,h			;720e
	ld d,a			;720f
	ld a,(0d90dh)		;7210
	bit 0,a		;7213
	ld a,d			;7215
	jr z,L_7219		;7216
	add a,e			;7218
L_7219:
	ld h,a			;7219
	ld a,(0d90dh)		;721a
	bit 2,a		;721d
	jr z,L_7225		;721f
	ld a,002h		;7221
	jr L_7227		;7223
L_7225:
	ld a,008h		;7225
L_7227:
	push bc			;7227
	push hl			;7228
	call L_78A9		;7229
	ld a,b			;722c
	and 0f0h		;722d
	cp 010h		;722f
	jr c,L_723D		;7231
	jr c,L_723D		;7233
	cp 080h		;7235
	jr c,L_7278		;7237
	cp 0a0h		;7239
	jr z,L_7278		;723b
L_723D:
	ld a,c			;723d
	and 0f0h		;723e
	cp 010h		;7240
	jr c,L_7258		;7242
	jr z,L_7258		;7244
	cp 040h		;7246
	jr c,L_7278		;7248
	cp 060h		;724a
	jp c,L_7278		;724c
	cp 080h		;724f
	jp c,L_7278		;7251
	cp 0a0h		;7254
	jr z,L_7278		;7256
L_7258:
	ld a,d			;7258
	and 0f0h		;7259
	cp 010h		;725b
	jp c,L_7273		;725d
	jp z,L_7273		;7260
	cp 040h		;7263
	jr c,L_7278		;7265
	cp 060h		;7267
	jr c,L_727C		;7269
	cp 080h		;726b
	jr c,L_7297		;726d
	cp 0a0h		;726f
	jr z,L_7278		;7271
L_7273:
	pop hl			;7273
	pop bc			;7274
	jp L_72B6		;7275
L_7278:
	pop hl			;7278
	pop bc			;7279
	jr L_72B2		;727a
L_727C:
	pop hl			;727c
	pop bc			;727d
	ld a,(0d90dh)		;727e
	bit 2,a		;7281
	jp z,L_72B6		;7283
	ld a,d			;7286
	and 0f0h		;7287
	cp 040h		;7289
	jp z,L_72B2		;728b
	ld a,h			;728e
	cp 008h		;728f
	jp nc,L_72B2		;7291
	jp L_72B6		;7294
L_7297:
	pop hl			;7297
	pop bc			;7298
	ld a,(0d90dh)		;7299
	bit 2,a		;729c
	jp nz,L_72B6		;729e
	ld a,d			;72a1
	and 0f0h		;72a2
	cp 040h		;72a4
	jp z,L_72B2		;72a6
	ld a,h			;72a9
	cp 008h		;72aa
	jp nc,L_72B2		;72ac
	jp L_72B6		;72af
L_72B2:
	ld a,(0d8fch)		;72b2   ; a = la x de Rastan
	ld h,a			;72b5
L_72B6:
	push bc			;72b6
	push hl			;72b7
	ld a,001h		;72b8
	call L_78A9		;72ba
	ld a,b			;72bd
	and 0f0h		;72be
	cp 020h		;72c0
	jr c,L_72D1		;72c2
	cp 080h		;72c4
	jr z,L_72D1		;72c6
	cp 090h		;72c8
	jr z,L_72D1		;72ca
	cp 0f0h		;72cc
	jp nz,L_736C		;72ce
L_72D1:
	ld a,c			;72d1
	and 0f0h		;72d2
	cp 020h		;72d4
	jr c,L_72E5		;72d6
	cp 080h		;72d8
	jr z,L_72E5		;72da
	cp 090h		;72dc
	jr z,L_72E5		;72de
	cp 0f0h		;72e0
	jp nz,L_736C		;72e2
L_72E5:
	ld a,d			;72e5
	and 0f0h		;72e6
	cp 020h		;72e8
	jr c,L_72F9		;72ea
	cp 080h		;72ec
	jr z,L_72F9		;72ee
	cp 090h		;72f0
	jr z,L_72F9		;72f2
	cp 0f0h		;72f4
	jp nz,L_736C		;72f6
L_72F9:
	pop hl			;72f9
	pop bc			;72fa
	push bc			;72fb
	push hl			;72fc
	inc l			;72fd
	inc l			;72fe
	inc l			;72ff
	ld a,001h		;7300
	call L_78A9		;7302
	ld a,b			;7305
	and 0f0h		;7306
	cp 080h		;7308
	jp nz,L_7314		;730a
	ld a,c			;730d
	and 0f0h		;730e
	cp 090h		;7310
	jr z,L_7339		;7312
L_7314:
	ld a,c			;7314
	and 0f0h		;7315
	cp 080h		;7317
	jp nz,L_735F		;7319
	ld a,d			;731c
	and 0f0h		;731d
	cp 090h		;731f
	jp nz,L_735F		;7321
	pop hl			;7324
	ld a,(0d90eh)		;7325
	bit 7,a		;7328
	jr nz,L_7368		;732a
	ld a,h			;732c
	and 00fh		;732d
	cp 00ah		;732f
	jr c,L_7368		;7331
	ld a,h			;7333
	add a,010h		;7334
	ld h,a			;7336
	jr L_7348		;7337
L_7339:
	pop hl			;7339
	ld a,(0d90eh)		;733a
	bit 7,a		;733d
	jr nz,L_7368		;733f
	ld a,h			;7341
	and 00fh		;7342
	cp 006h		;7344
	jr nc,L_7368		;7346
L_7348:
	ld a,h			;7348
	and 0f0h		;7349
	ld h,a			;734b
	pop bc			;734c
	ld a,h			;734d
	and 0f0h		;734e
	ld h,a			;7350
	ld a,b			;7351
	and 0e1h		;7352
	or 004h		;7354
	ld b,a			;7356
	ld a,020h		;7357
	ld (0d90dh),a		;7359
	jp L_7878		;735c
L_735F:
	ld a,(0d90eh)		;735f
	res 7,a		;7362
	ld (0d90eh),a		;7364
	pop hl			;7367
L_7368:
	pop bc			;7368
	jp L_7878		;7369
L_736C:
	pop hl			;736c
	pop bc			;736d
L_736E:
	ld de,(0d909h)		;736e
	dec de			;7372
	ld (0d909h),de		;7373
	ld de,(0d90bh)		;7377
	dec de			;737b
	ld (0d90bh),de		;737c
	ld a,(0d8fdh)		;7380   ; a = la y de Rastan
	ld l,a			;7383
	ld a,(0d90dh)		;7384
	set 1,a		;7387
	ld (0d90dh),a		;7389
	ld a,(0d90eh)		;738c
	res 0,a		;738f
	ld (0d90eh),a		;7391
	ld de,00000h		;7394
	ld (0d914h),de		;7397
	jp L_7878		;739b
L_739E:
	ld a,(0d90eh)		;739e
	bit 0,a		;73a1
	jr z,L_73C4		;73a3
	ld a,(0d573h)		;73a5   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld c,a			;73a8
	bit 5,c		;73a9
	jr z,L_73C4		;73ab
	ld a,(0d90dh)		;73ad
	bit 3,a		;73b0
	jr z,L_73C4		;73b2
	bit 2,a		;73b4
	jr nz,L_73BF		;73b6
	bit 3,c		;73b8
	jr z,L_73C4		;73ba
	jp L_7175		;73bc
L_73BF:
	bit 2,c		;73bf
	jp nz,L_7175		;73c1
L_73C4:
	ld de,(0d909h)		;73c4
	ld a,(de)			;73c8
	cp 080h		;73c9
	jp z,L_73FF		;73cb
	dec de			;73ce
	ld (0d909h),de		;73cf
	neg		;73d3
	add a,l			;73d5
	ld l,a			;73d6
	ld a,(0d90dh)		;73d7
	bit 3,a		;73da
	jp z,L_7560		;73dc
	ld de,(0d90bh)		;73df
	ld a,(de)			;73e3
	dec de			;73e4
	ld (0d90bh),de		;73e5
	add a,h			;73e9
	ld h,a			;73ea
	ld a,(0d90dh)		;73eb
	bit 2,a		;73ee
	jr z,L_73F8		;73f0
	ld c,004h		;73f2
	ld d,002h		;73f4
	jr L_73FC		;73f6
L_73F8:
	ld c,008h		;73f8
	ld d,008h		;73fa
L_73FC:
	jp L_74AB		;73fc
L_73FF:
	ld a,(0d90dh)		;73ff
	set 6,a		;7402
	ld (0d90dh),a		;7404
	jp L_7560		;7407

; ----------------------------------------------------------------------
; DATOS sin identificar  0x740a..0x74a7  (157 bytes)
DATA_740A:
	defb 080h,0feh,0feh,0feh,0feh,0feh,0feh,0ffh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,000h,0ffh	; 740a  ................
	defb 0ffh,000h,0ffh,000h,000h,080h,001h,001h,002h,001h,001h,001h,001h,002h,001h,001h	; 741a  ................
	defb 001h,001h,002h,001h,001h,001h,001h,002h,001h,001h,080h,0ffh,0ffh,0feh,0ffh,0ffh	; 742a  ................
	defb 0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,080h	; 743a  ................
	defb 0fdh,0fdh,0fdh,0fdh,0fdh,0feh,0fdh,0feh,0feh,0fdh,0feh,0feh,0feh,0feh,0ffh,0feh	; 744a  ................
	defb 0feh,0ffh,0feh,0ffh,0ffh,0ffh,0ffh,000h,000h,0ffh,0ffh,000h,000h,000h,080h,001h	; 745a  ................
	defb 001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,001h,001h	; 746a  ................
	defb 000h,001h,001h,001h,001h,000h,001h,001h,001h,001h,000h,001h,001h,080h,0ffh,0ffh	; 747a  ................
	defb 000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h	; 748a  ................
	defb 0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,080h	; 749a  .............

; ======================================================================
; CODIGO 0x74a7..0x7881  (986 bytes)
; ======================================================================


L_74A7:
	ld a,l			;74a7
	add a,002h		;74a8
	ld l,a			;74aa
L_74AB:
	ld a,(0d90eh)		;74ab
	res 0,a		;74ae
	ld (0d90eh),a		;74b0
	push bc			;74b3
	push hl			;74b4
	ld a,d			;74b5
	call L_78A9		;74b6
	ld a,b			;74b9
	and 0f0h		;74ba
	cp 010h		;74bc
	jr c,L_74CA		;74be
	jr z,L_74CA		;74c0
	cp 080h		;74c2
	jr c,L_7504		;74c4
	cp 0a0h		;74c6
	jr z,L_7504		;74c8
L_74CA:
	ld a,c			;74ca
	and 0f0h		;74cb
	cp 010h		;74cd
	jr c,L_74E5		;74cf
	jr z,L_74E5		;74d1
	cp 040h		;74d3
	jr c,L_7504		;74d5
	cp 060h		;74d7
	jp c,L_7504		;74d9
	cp 080h		;74dc
	jp c,L_7504		;74de
	cp 0a0h		;74e1
	jr z,L_7504		;74e3
L_74E5:
	ld a,d			;74e5
	and 0f0h		;74e6
	cp 010h		;74e8
	jp c,L_74FF		;74ea
	jr z,L_74FF		;74ed
	cp 040h		;74ef
	jr c,L_7514		;74f1
	cp 060h		;74f3
	jr c,L_7526		;74f5
	cp 080h		;74f7
	jr c,L_7543		;74f9
	cp 0a0h		;74fb
	jr z,L_7514		;74fd
L_74FF:
	pop hl			;74ff
	pop bc			;7500
	jp L_7560		;7501
L_7504:
	pop hl			;7504
	pop bc			;7505
L_7506:
	ld a,(0d8fch)		;7506   ; a = la x de Rastan
	ld h,a			;7509
	ld a,(0d90eh)		;750a
	set 0,a		;750d
	ld (0d90eh),a		;750f
	jr L_7560		;7512
L_7514:
	pop hl			;7514
	pop bc			;7515
	ld a,(0d8fdh)		;7516   ; a = la y de Rastan
	xor l			;7519
	and 0f0h		;751a
	jr z,L_7506		;751c
	ld a,l			;751e
	cp 003h		;751f
	jr nc,L_7506		;7521
	jp L_7856		;7523
L_7526:
	pop hl			;7526
	pop bc			;7527
	cp 050h		;7528
	jr z,L_7533		;752a
	bit 3,c		;752c
	jr nz,L_7506		;752e
	jp L_7560		;7530
L_7533:
	ld a,l			;7533
	and 00fh		;7534
	cp 008h		;7536
	jp c,L_7560		;7538
	bit 3,c		;753b
	jp nz,L_7506		;753d
	jp L_7560		;7540
L_7543:
	pop hl			;7543
	pop bc			;7544
	cp 070h		;7545
	jr z,L_7550		;7547
	bit 2,c		;7549
	jr nz,L_7506		;754b
	jp L_7560		;754d
L_7550:
	ld a,l			;7550
	and 00fh		;7551
	cp 008h		;7553
	jp c,L_7560		;7555
	bit 2,c		;7558
	jp nz,L_7506		;755a
	jp L_7560		;755d
L_7560:
	push bc			;7560
	push hl			;7561
	inc l			;7562
	inc l			;7563
	inc l			;7564
	ld a,001h		;7565
	call L_78A9		;7567
	ld a,b			;756a
	and 0f0h		;756b
	cp 080h		;756d
	jp nz,L_757A		;756f
	ld a,c			;7572
	and 0f0h		;7573
	cp 090h		;7575
	jp z,L_7598		;7577
L_757A:
	ld a,c			;757a
	and 0f0h		;757b
	cp 080h		;757d
	jp nz,L_75BD		;757f
	ld a,d			;7582
	and 0f0h		;7583
	cp 090h		;7585
	jp nz,L_75BD		;7587
	pop hl			;758a
	ld a,h			;758b
	and 00fh		;758c
	cp 00ah		;758e
	jr c,L_75BE		;7590
	ld a,h			;7592
	add a,010h		;7593
	ld h,a			;7595
	jr L_75A2		;7596
L_7598:
	pop hl			;7598
	ld a,h			;7599
	and 00fh		;759a
	cp 006h		;759c
	jr nc,L_75BE		;759e
	ld a,0e1h		;75a0
L_75A2:
	pop bc			;75a2
	ld a,h			;75a3
	and 0f0h		;75a4
	ld h,a			;75a6
	ld a,b			;75a7
	and 021h		;75a8
	or 004h		;75aa
	ld b,a			;75ac
	ld a,020h		;75ad
	ld (0d90dh),a		;75af
	ld a,(0d90fh)		;75b2
	res 0,a		;75b5
	ld (0d90fh),a		;75b7
	jp L_7878		;75ba
L_75BD:
	pop hl			;75bd
L_75BE:
	push hl			;75be
	ld a,l			;75bf
	add a,010h		;75c0
	ld l,a			;75c2
	ld a,h			;75c3
	add a,010h		;75c4
	ld h,a			;75c6
	ld a,004h		;75c7
	call 080e6h		;75c9
	or a			;75cc
	jr z,L_75D4		;75cd
	cp 020h		;75cf
	jp c,L_7876		;75d1
L_75D4:
	pop hl			;75d4
	pop bc			;75d5
	xor a			;75d6
	ld (0d911h),a		;75d7
	push bc			;75da
	push hl			;75db
	ld a,004h		;75dc
	call L_78A9		;75de
	ld a,b			;75e1
	and 0f0h		;75e2
	cp 010h		;75e4
	jr c,L_7601		;75e6
	call z,L_789F		;75e8
	jr z,L_7601		;75eb
	cp 040h		;75ed
	jp c,L_76F4		;75ef
	cp 060h		;75f2
	jp c,L_773D		;75f4
	cp 080h		;75f7
	jp c,L_7769		;75f9
	cp 0a0h		;75fc
	jp z,L_76F4		;75fe
L_7601:
	ld a,c			;7601
	and 0f0h		;7602
	cp 010h		;7604
	jp c,L_7622		;7606
	call z,L_789F		;7609
	jr z,L_7622		;760c
	cp 040h		;760e
	jp c,L_76F1		;7610
	cp 060h		;7613
	jp c,L_77C4		;7615
	cp 080h		;7618
	jp c,L_77B9		;761a
	cp 0a0h		;761d
	jp z,L_76F1		;761f
L_7622:
	ld a,d			;7622
	and 0f0h		;7623
	cp 010h		;7625
	jp c,L_7876		;7627
	call z,L_789F		;762a
	jp z,L_77E1		;762d
	cp 040h		;7630
	jp c,L_7645		;7632
	cp 060h		;7635
	jr c,L_7663		;7637
	cp 080h		;7639
	jr c,L_76AE		;763b
	cp 0a0h		;763d
	jp z,L_7645		;763f
	jp L_7876		;7642
L_7645:
	pop hl			;7645
	push hl			;7646
	ld a,l			;7647
	sub 008h		;7648
	ld l,a			;764a
	ld a,004h		;764b
	call L_78A9		;764d
	ld a,d			;7650
	and 0f0h		;7651
	cp 070h		;7653
	jp nz,L_7854		;7655
	pop hl			;7658
	pop bc			;7659
	ld a,l			;765a
	and 0f0h		;765b
	add a,008h		;765d
	ld e,a			;765f
	jp L_76C2		;7660
L_7663:
	pop hl			;7663
	pop bc			;7664
	cp 040h		;7665
	jr z,L_7671		;7667
L_7669:
	ld a,l			;7669
	and 0f0h		;766a
	add a,008h		;766c
	ld e,a			;766e
	jr L_7675		;766f
L_7671:
	ld a,l			;7671
	and 0f0h		;7672
	ld e,a			;7674
L_7675:
	ld a,h			;7675
	and 00fh		;7676
	sra a		;7678
	sub 008h		;767a
	add a,e			;767c
	ld d,a			;767d
	sub 002h		;767e
	cp l			;7680
	jp nc,L_7878		;7681
	ld a,(0d90eh)		;7684
	and 040h		;7687
	ld (0d90eh),a		;7689
	ld a,010h		;768c
	ld (0d90dh),a		;768e
	ld a,(0d90fh)		;7691
	res 0,a		;7694
	ld (0d90fh),a		;7696
	exx			;7699
	ld hl,0d928h		;769a
	set 1,(hl)		;769d
	exx			;769f
L_76A0:
	ld l,d			;76a0
	ld a,e			;76a1
	ld (0d908h),a		;76a2
	ld a,h			;76a5
	and 0f0h		;76a6
	ld (0d907h),a		;76a8
	jp L_7878		;76ab
L_76AE:
	pop hl			;76ae
	pop bc			;76af
	cp 070h		;76b0
	jr z,L_76BC		;76b2
	ld a,l			;76b4
	and 0f0h		;76b5
	add a,010h		;76b7
	ld e,a			;76b9
	jr L_76C2		;76ba
L_76BC:
	ld a,l			;76bc
	and 0f0h		;76bd
	add a,018h		;76bf
	ld e,a			;76c1
L_76C2:
	ld a,h			;76c2
	and 00fh		;76c3
	srl a		;76c5
	neg		;76c7
	dec a			;76c9
	add a,e			;76ca
	ld d,a			;76cb
	sub 002h		;76cc
	cp l			;76ce
	jp nc,L_7878		;76cf
	ld a,(0d90eh)		;76d2
	and 040h		;76d5
	ld (0d90eh),a		;76d7
	ld a,014h		;76da
	ld (0d90dh),a		;76dc
	ld a,(0d90fh)		;76df
	res 0,a		;76e2
	ld (0d90fh),a		;76e4
	exx			;76e7
	ld hl,0d928h		;76e8
	set 1,(hl)		;76eb
	exx			;76ed
	jp L_76A0		;76ee
L_76F1:
	jp L_7854		;76f1
L_76F4:
	ld a,c			;76f4
	and 0f0h		;76f5
	cp 020h		;76f7
	jr c,L_770E		;76f9
	cp 0a0h		;76fb
	jp z,L_7854		;76fd
	cp 080h		;7700
	jr nc,L_770E		;7702
	cp 040h		;7704
	jp nz,L_7854		;7706
L_7709:
	pop hl			;7709
	pop bc			;770a
	jp L_7669		;770b
L_770E:
	ld a,d			;770e
	and 0f0h		;770f
	cp 020h		;7711
	jr c,L_771F		;7713
	cp 080h		;7715
	jp c,L_7854		;7717
	cp 0a0h		;771a
	jp z,L_7854		;771c
L_771F:
	pop hl			;771f
	pop bc			;7720
	push bc			;7721
	push hl			;7722
	ld a,l			;7723
	sub 010h		;7724
	ld l,a			;7726
	ld a,004h		;7727
	call L_78A9		;7729
	ld a,b			;772c
	and 0f0h		;772d
	cp 050h		;772f
	jp nz,L_7854		;7731
	ld a,l			;7734
	and 0f0h		;7735
	add a,010h		;7737
	ld e,a			;7739
	jp L_7709		;773a
L_773D:
	cp 050h		;773d
	jr z,L_774E		;773f
	pop hl			;7741
	pop bc			;7742
	ld a,h			;7743
	and 00fh		;7744
	cp 008h		;7746
	jp nc,L_77D8		;7748
	jp L_77CF		;774b
L_774E:
	pop hl			;774e
	pop bc			;774f
	ld a,h			;7750
	and 00fh		;7751
	cp 008h		;7753
	jr c,L_7760		;7755
	ld a,l			;7757
	and 0f0h		;7758
	add a,010h		;775a
	ld e,a			;775c
	jp L_7675		;775d
L_7760:
	ld a,l			;7760
	and 0f0h		;7761
	add a,018h		;7763
	ld e,a			;7765
	jp L_7675		;7766
L_7769:
	ld a,c			;7769
	and 0f0h		;776a
	cp 020h		;776c
	jr c,L_77A9		;776e
	cp 040h		;7770
	jp c,L_7854		;7772
	cp 0a0h		;7775
	jp z,L_7854		;7777
	cp 080h		;777a
	jr nc,L_77A9		;777c
	ld a,b			;777e
	pop hl			;777f
	pop bc			;7780
	and 0f0h		;7781
	cp 060h		;7783
	jr z,L_7790		;7785
	ld a,h			;7787
	and 00fh		;7788
	cp 008h		;778a
	jr nc,L_7797		;778c
	jr L_77A0		;778e
L_7790:
	ld a,h			;7790
	and 00fh		;7791
	cp 008h		;7793
	jr nc,L_77A0		;7795
L_7797:
	ld a,l			;7797
	and 0f0h		;7798
	add a,010h		;779a
	ld e,a			;779c
	jp L_76C2		;779d
L_77A0:
	ld a,l			;77a0
	and 0f0h		;77a1
	add a,008h		;77a3
	ld e,a			;77a5
	jp L_76C2		;77a6
L_77A9:
	ld a,b			;77a9
	and 0f0h		;77aa
	pop hl			;77ac
	pop bc			;77ad
	cp 060h		;77ae
	jr nz,L_77A0		;77b0
	ld a,l			;77b2
	and 0f0h		;77b3
	ld e,a			;77b5
	jp L_76C2		;77b6
L_77B9:
	ld a,c			;77b9
	and 0f0h		;77ba
	pop hl			;77bc
	pop bc			;77bd
	cp 060h		;77be
	jr z,L_77A0		;77c0
	jr L_7797		;77c2
L_77C4:
	ld a,c			;77c4
	and 0f0h		;77c5
	pop hl			;77c7
	pop bc			;77c8
	cp 040h		;77c9
	jr z,L_77D8		;77cb
	jr L_77CF		;77cd
L_77CF:
	ld a,l			;77cf
	and 0f0h		;77d0
	add a,010h		;77d2
	ld e,a			;77d4
	jp L_7675		;77d5
L_77D8:
	ld a,l			;77d8
	and 0f0h		;77d9
	add a,008h		;77db
	ld e,a			;77dd
	jp L_7675		;77de
L_77E1:
	pop hl			;77e1
	pop bc			;77e2
	ld a,l			;77e3
	and 00fh		;77e4
	cp 00ah		;77e6
	jp c,L_7878		;77e8
	ld a,(0d90fh)		;77eb
	bit 6,a		;77ee
	ret nz			;77f0
	bit 4,a		;77f1
	jr nz,L_77FB		;77f3
	ld d,010h		;77f5
	call L_7818		;77f7
	ret			;77fa
L_77FB:
	ld a,(0d573h)		;77fb   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	bit 5,a		;77fe
	ret z			;7800
	ld c,a			;7801
	xor a			;7802
	ld (0d90dh),a		;7803
	ld a,(0d90fh)		;7806
	res 0,a		;7809
	ld (0d90fh),a		;780b
	exx			;780e
	ld hl,0d928h		;780f
	set 1,(hl)		;7812
	exx			;7814
	jp L_7175		;7815
L_7818:
	ld a,(0d90fh)		;7818
	bit 6,a		;781b
	ret nz			;781d
	bit 4,a		;781e
	ret nz			;7820
	set 4,a		;7821
	set 6,a		;7823
	ld (0d90fh),a		;7825
	ld a,050h		;7828
	ld (0d913h),a		;782a   ; 0x27 al entrar en una pantalla = a
	exx			;782d
	ld hl,0d929h		;782e
	set 7,(hl)		;7831
	set 6,(hl)		;7833
	exx			;7835
	ld a,(0d910h)		;7836
	bit 7,a		;7839
	ret nz			;783b
	ld a,(0d91ch)		;783c
	sub d			;783f
	ld (0d91ch),a		;7840
	jr z,L_7846		;7843
	ret nc			;7845
L_7846:
	exx			;7846
	set 5,(hl)		;7847
	exx			;7849
	xor a			;784a
	ld (0d91ch),a		;784b
	ld hl,0d90fh		;784e
	set 7,(hl)		;7851
	ret			;7853
L_7854:
	pop hl			;7854
	pop bc			;7855
L_7856:
	ld a,l			;7856
	and 0f0h		;7857
	ld l,a			;7859
	ld a,h			;785a
	ld (0d8fch),a		;785b   ; la x de Rastan = a
	ld a,l			;785e
	ld (0d8fdh),a		;785f   ; la y de Rastan = a
	xor a			;7862
	ld (0d90dh),a		;7863
	ld a,(0d90fh)		;7866
	res 0,a		;7869
	ld (0d90fh),a		;786b
	exx			;786e
	ld hl,0d928h		;786f
	set 1,(hl)		;7872
	exx			;7874
	ret			;7875
L_7876:
	pop hl			;7876
	pop bc			;7877
L_7878:
	ld a,h			;7878
	ld (0d8fch),a		;7879   ; la x de Rastan = a
	ld a,l			;787c
	ld (0d8fdh),a		;787d   ; la y de Rastan = a
	ret			;7880

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7881..0x7886  (5 bytes)
DATA_7881:
	defb 078h,0e6h,0e1h,018h,014h	; 7881

; ======================================================================
; CODIGO 0x7886..0x78d1  (75 bytes)
; ======================================================================


L_7886:
	ld a,(0d90dh)		;7886
	bit 4,a		;7889
	jp nz,L_789A		;788b
	bit 3,c		;788e
	jr z,L_7894		;7890
	res 0,b		;7892
L_7894:
	bit 2,c		;7894
	jr z,L_789A		;7896
	set 0,b		;7898
L_789A:
	ld a,b			;789a
	ld (0d904h),a		;789b
	ret			;789e
L_789F:
	push af			;789f
	ld a,(0d911h)		;78a0
	inc a			;78a3
	ld (0d911h),a		;78a4
	pop af			;78a7
	ret			;78a8
L_78A9:
	push af			;78a9
	ld a,l			;78aa
	sub 010h		;78ab
	ld l,a			;78ad
	ld a,h			;78ae
	cp 0f0h		;78af
	jp nc,L_7975		;78b1
	pop af			;78b4
	bit 1,a		;78b5
	jp nz,L_7910		;78b7
	bit 2,a		;78ba
	jp nz,L_7943		;78bc
	bit 3,a		;78bf
	jp nz,L_7966		;78c1
	ex af,af'			;78c4
	ld a,l			;78c5
	sub 00ch		;78c6
	and 0f0h		;78c8
	cp 0c0h		;78ca
	jr c,$+9		;78cc
	jp L_7909		;78ce

; ----------------------------------------------------------------------
; DATOS sin identificar  0x78d1..0x78d5  (4 bytes)
DATA_78D1:
	defb 0d6h,010h,018h,0f5h	; 78d1

; ======================================================================
; CODIGO 0x78d5..0x8000  (1835 bytes)
; ======================================================================


L_78D5:
	ld b,000h		;78d5
	ld c,a			;78d7
	ld e,a			;78d8
	ld a,h			;78d9
	ld d,a			;78da
	and 0f0h		;78db
	rra			;78dd
	rra			;78de
	rra			;78df
	ld l,a			;78e0
	ld h,000h		;78e1
	add hl,bc			;78e3
	add hl,bc			;78e4
	ld bc,0d774h		;78e5   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;78e8
	inc hl			;78e9
	ex af,af'			;78ea
	bit 0,a		;78eb
	jp nz,L_78F7		;78ed
	ld bc,0a0a0h		;78f0
	ld de,0a0a0h		;78f3
	ret			;78f6
L_78F7:
	ld a,d			;78f7
	ld b,(hl)			;78f8
	inc hl			;78f9
	inc hl			;78fa
	ld c,(hl)			;78fb
	inc hl			;78fc
	inc hl			;78fd
	ld d,(hl)			;78fe
	and 00fh		;78ff
	cp 008h		;7901
	jr nc,L_7907		;7903
	ld d,c			;7905
	ret			;7906
L_7907:
	ld b,c			;7907
	ret			;7908
L_7909:
	ld bc,0a0a0h		;7909
	ld de,0a0a0h		;790c
	ret			;790f
L_7910:
	ld a,l			;7910
	sub 010h		;7911
	ld e,a			;7913
	and 0f0h		;7914
	ld b,000h		;7916
	ld c,a			;7918
	ld a,h			;7919
	add a,018h		;791a
L_791C:
	and 0f0h		;791c
	ld d,a			;791e
	rra			;791f
	rra			;7920
	rra			;7921
	ld l,a			;7922
	ld h,000h		;7923
	ld a,e			;7925
	cp 0a0h		;7926
	jr nc,L_7909		;7928
	add hl,bc			;792a
	add hl,bc			;792b
	ld bc,0d774h		;792c   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;792f
	inc hl			;7930
	ld a,e			;7931
	ld b,(hl)			;7932
	ld de,00020h		;7933
	add hl,de			;7936
	ld c,(hl)			;7937
	and 00fh		;7938
	jr z,L_793D		;793a
	add hl,de			;793c
L_793D:
	ld d,(hl)			;793d
	cp 00ch		;793e
	ret c			;7940
	ld b,c			;7941
	ret			;7942
L_7943:
	ld a,l			;7943
	add a,010h		;7944
	and 0f0h		;7946
	cp 0c0h		;7948
	jr c,L_794E		;794a
	sub 010h		;794c
L_794E:
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
	ld bc,0d774h		;795e   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;7961
	inc hl			;7962
	jp L_78F7		;7963
L_7966:
	ld a,l			;7966
	sub 010h		;7967
	ld e,a			;7969
	and 0f0h		;796a
	ld b,000h		;796c
	ld c,a			;796e
	ld a,h			;796f
	add a,008h		;7970
	jp L_791C		;7972
L_7975:
	pop af			;7975
	bit 1,a		;7976
	jp nz,L_7910		;7978
	bit 2,a		;797b
	jp nz,L_79C4		;797d
	bit 3,a		;7980
	jp nz,L_79EB		;7982
	ex af,af'			;7985
	ld a,l			;7986
	sub 00ch		;7987
	and 0f0h		;7989
L_798B:
	cp 0c0h		;798b
	jr c,L_7993		;798d
	sub 010h		;798f
	jr L_798B		;7991
L_7993:
	ld b,000h		;7993
	ld c,a			;7995
	ld e,a			;7996
	ld a,h			;7997
	ld d,a			;7998
	add a,010h		;7999
	and 0f0h		;799b
	rra			;799d
	rra			;799e
	rra			;799f
	ld l,a			;79a0
	ld h,000h		;79a1
	add hl,bc			;79a3
	add hl,bc			;79a4
	ld bc,0d774h		;79a5   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;79a8
	inc hl			;79a9
	ex af,af'			;79aa
	bit 0,a		;79ab
	jp nz,L_79B7		;79ad
	ld bc,0a0a0h		;79b0
	ld de,0a0a0h		;79b3
	ret			;79b6
L_79B7:
	ld a,d			;79b7
	ld b,(hl)			;79b8
	ld c,b			;79b9
	inc hl			;79ba
	inc hl			;79bb
	ld d,(hl)			;79bc
	and 00fh		;79bd
	cp 008h		;79bf
	ret nc			;79c1
	ld d,c			;79c2
	ret			;79c3
L_79C4:
	ld a,l			;79c4
	add a,010h		;79c5
	and 0f0h		;79c7
L_79C9:
	cp 0c0h		;79c9
	jr c,L_79D1		;79cb
	sub 010h		;79cd
	jr L_79C9		;79cf
L_79D1:
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
	ld bc,0d774h		;79e3   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;79e6
	inc hl			;79e7
	jp L_79B7		;79e8
L_79EB:
	ld a,l			;79eb
	sub 010h		;79ec
	ld e,a			;79ee
	and 0f0h		;79ef
	ld b,000h		;79f1
	ld c,a			;79f3
	ld a,h			;79f4
	add a,008h		;79f5
	cp 0f0h		;79f7
	jp c,L_791C		;79f9
	and 0f0h		;79fc
	add a,010h		;79fe
	ld d,a			;7a00
	rra			;7a01
	rra			;7a02
	rra			;7a03
	ld l,a			;7a04
	ld h,000h		;7a05
	ld a,e			;7a07
	cp 0a0h		;7a08
	jp nc,L_7909		;7a0a
	add hl,bc			;7a0d
	add hl,bc			;7a0e
	ld bc,0d774h		;7a0f   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;7a12
	inc hl			;7a13
	ld a,e			;7a14
	ld b,(hl)			;7a15
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
L_7A26:
	ld a,(0d90dh)		;7a26
	ld b,a			;7a29
	ld a,(0d90eh)		;7a2a
	ld c,a			;7a2d
	ld a,(0d904h)		;7a2e
	and 001h		;7a31
	ld d,a			;7a33
	ld e,000h		;7a34
	ld a,(0d573h)		;7a36   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	ld h,a			;7a39
	ld a,(0d90fh)		;7a3a
	and 020h		;7a3d
	ld l,a			;7a3f
	bit 3,h		;7a40
	jr nz,L_7A4E		;7a42
	bit 2,h		;7a44
	jr z,L_7A56		;7a46
	res 0,d		;7a48
	ld e,002h		;7a4a
	jr L_7A56		;7a4c
L_7A4E:
	bit 2,h		;7a4e
	jr nz,L_7A56		;7a50
	set 0,d		;7a52
	ld e,002h		;7a54
L_7A56:
	ld a,(0d90fh)		;7a56
	bit 3,a		;7a59
	jp nz,L_7ABD		;7a5b
	bit 7,b		;7a5e
	jr nz,L_7A82		;7a60
	bit 5,b		;7a62
	jr nz,L_7ABD		;7a64
	bit 4,b		;7a66
	jr nz,L_7ACE		;7a68
	bit 0,h		;7a6a
	jr nz,L_7A78		;7a6c
	bit 1,h		;7a6e
	jp z,L_7B16		;7a70
	ld e,004h		;7a73
	jp L_7B16		;7a75
L_7A78:
	bit 5,l		;7a78
	jp z,L_7B16		;7a7a
	ld e,010h		;7a7d
	jp L_7B16		;7a7f
L_7A82:
	bit 6,b		;7a82
	jr nz,L_7A9C		;7a84
	bit 1,b		;7a86
	jr nz,L_7A9C		;7a88
	bit 5,l		;7a8a
	jr nz,L_7A93		;7a8c
	ld e,008h		;7a8e
	jp L_7B16		;7a90
L_7A93:
	bit 0,h		;7a93
	jr nz,L_7AB8		;7a95
	ld e,008h		;7a97
	jp L_7B16		;7a99
L_7A9C:
	bit 5,l		;7a9c
	jr nz,L_7AA5		;7a9e
	ld e,008h		;7aa0
	jp L_7B16		;7aa2
L_7AA5:
	ld e,008h		;7aa5
	bit 1,h		;7aa7
	jr z,L_7A93		;7aa9
	ld e,014h		;7aab
	ld a,(0d90fh)		;7aad
	set 0,a		;7ab0
	ld (0d90fh),a		;7ab2
	jp L_7B16		;7ab5
L_7AB8:
	ld e,012h		;7ab8
	jp L_7B16		;7aba
L_7ABD:
	ld a,(0d90fh)		;7abd
	bit 1,a		;7ac0
	jr nz,L_7AC9		;7ac2
	ld e,006h		;7ac4
	jp L_7B16		;7ac6
L_7AC9:
	ld e,00ah		;7ac9
	jp L_7B16		;7acb
L_7ACE:
	bit 5,l		;7ace
	jr z,L_7AD6		;7ad0
	bit 0,h		;7ad2
	jr nz,L_7AF6		;7ad4
L_7AD6:
	bit 2,b		;7ad6
	jr nz,L_7AE8		;7ad8
	bit 0,d		;7ada
	jr nz,L_7AE3		;7adc
	ld e,00eh		;7ade
	jp L_7B16		;7ae0
L_7AE3:
	ld e,00ch		;7ae3
	jp L_7B16		;7ae5
L_7AE8:
	bit 0,d		;7ae8
	jr nz,L_7AF1		;7aea
	ld e,00ch		;7aec
	jp L_7B16		;7aee
L_7AF1:
	ld e,00eh		;7af1
	jp L_7B16		;7af3
L_7AF6:
	bit 2,b		;7af6
	jr nz,L_7B08		;7af8
	bit 0,d		;7afa
	jr nz,L_7B03		;7afc
	ld e,018h		;7afe
	jp L_7B16		;7b00
L_7B03:
	ld e,016h		;7b03
	jp L_7B16		;7b05
L_7B08:
	bit 0,d		;7b08
	jr nz,L_7B11		;7b0a
	ld e,016h		;7b0c
	jp L_7B16		;7b0e
L_7B11:
	ld e,018h		;7b11
	jp L_7B16		;7b13
L_7B16:
	ld a,(0d90fh)		;7b16
	and 040h		;7b19
	or d			;7b1b
	or e			;7b1c
	or l			;7b1d
	ld (0d904h),a		;7b1e
	ret			;7b21
L_7B22:
	ld a,(0d8fdh)		;7b22   ; a = la y de Rastan
	ld l,a			;7b25
	ld a,(0d8fch)		;7b26   ; a = la x de Rastan
	ld h,a			;7b29
	ld a,(0d8feh)		;7b2a
	inc a			;7b2d
	ld c,a			;7b2e
	ld a,(0d904h)		;7b2f
	ld b,a			;7b32
	bit 5,b		;7b33
	jp z,L_7FD3		;7b35
	and 01eh		;7b38
	cp 010h		;7b3a
	jp z,L_7C2B		;7b3c
	cp 012h		;7b3f
	jp z,L_7C2B		;7b41
	cp 016h		;7b44
	jp z,L_7C2B		;7b46
	cp 018h		;7b49
	jp z,L_7C2B		;7b4b
	cp 014h		;7b4e
	jp z,L_7C4F		;7b50
	cp 004h		;7b53
	jr nz,L_7B5B		;7b55
	ld a,l			;7b57
	add a,00ch		;7b58
	ld l,a			;7b5a
L_7B5B:
	ld e,000h		;7b5b
	bit 0,b		;7b5d
	jr nz,L_7BC7		;7b5f
	ld a,c			;7b61
	cp 001h		;7b62
	jr c,L_7B74		;7b64
	jr z,L_7B7F		;7b66
	cp 003h		;7b68
	jr c,L_7B8A		;7b6a
	jr z,L_7B95		;7b6c
	cp 005h		;7b6e
	jr c,L_7B8A		;7b70
	jr z,L_7B7F		;7b72
L_7B74:
	ld a,l			;7b74
	sub 00ah		;7b75
	ld l,a			;7b77
	ld a,h			;7b78
	add a,011h		;7b79
	ld h,a			;7b7b
	jp L_7C73		;7b7c
L_7B7F:
	ld a,l			;7b7f
	add a,008h		;7b80
	ld l,a			;7b82
	ld a,h			;7b83
	add a,014h		;7b84
	ld h,a			;7b86
	jp L_7C73		;7b87
L_7B8A:
	ld a,l			;7b8a
	add a,008h		;7b8b
	ld l,a			;7b8d
	ld a,h			;7b8e
	sub 004h		;7b8f
	ld h,a			;7b91
	jp L_7C73		;7b92
L_7B95:
	ld a,(0d919h)		;7b95
	cp 002h		;7b98
	jr z,L_7BA8		;7b9a
	cp 003h		;7b9c
	jr z,L_7BB0		;7b9e
	inc l			;7ba0
	ld a,h			;7ba1
	sub 010h		;7ba2
	ld h,a			;7ba4
	jp L_7C73		;7ba5
L_7BA8:
	inc l			;7ba8
	ld a,h			;7ba9
	sub 020h		;7baa
	ld h,a			;7bac
	jp L_7C73		;7bad
L_7BB0:
	inc l			;7bb0
	ld a,h			;7bb1
	sub 010h		;7bb2
	ld h,a			;7bb4
	ld a,(0d924h)		;7bb5   ; a = bit 7: el jugador usa la ficha 10
	or a			;7bb8
	jp nz,L_7C73		;7bb9
	ld (0d922h),hl		;7bbc   ; la y de la ficha 10 del jugador = hl
	ld a,083h		;7bbf
	ld (0d924h),a		;7bc1   ; bit 7: el jugador usa la ficha 10 = a
	jp L_7C73		;7bc4
L_7BC7:
	ld a,c			;7bc7
	cp 001h		;7bc8
	jr c,L_7BDA		;7bca
	jr z,L_7BE1		;7bcc
	cp 003h		;7bce
	jr c,L_7BEC		;7bd0
	jr z,L_7BF7		;7bd2
	cp 005h		;7bd4
	jr c,L_7BEC		;7bd6
	jr z,L_7BE1		;7bd8
L_7BDA:
	ld a,l			;7bda
	sub 00ah		;7bdb
	ld l,a			;7bdd
	jp L_7C73		;7bde
L_7BE1:
	ld a,l			;7be1
	add a,008h		;7be2
	ld l,a			;7be4
	ld a,h			;7be5
	sub 004h		;7be6
	ld h,a			;7be8
	jp L_7C73		;7be9
L_7BEC:
	ld a,l			;7bec
	add a,008h		;7bed
	ld l,a			;7bef
	ld a,h			;7bf0
	add a,00fh		;7bf1
	ld h,a			;7bf3
	jp L_7C73		;7bf4
L_7BF7:
	ld a,(0d919h)		;7bf7
	cp 002h		;7bfa
	jr z,L_7C0A		;7bfc
	cp 003h		;7bfe
	jr z,L_7C12		;7c00
	inc l			;7c02
	ld a,h			;7c03
	add a,020h		;7c04
	ld h,a			;7c06
	jp L_7C73		;7c07
L_7C0A:
	inc l			;7c0a
	ld a,h			;7c0b
	add a,030h		;7c0c
	ld h,a			;7c0e
	jp L_7C73		;7c0f
L_7C12:
	inc l			;7c12
	add a,004h		;7c13
	ld a,h			;7c15
	add a,020h		;7c16
	ld h,a			;7c18
	ld a,(0d924h)		;7c19   ; a = bit 7: el jugador usa la ficha 10
	or a			;7c1c
	jp nz,L_7C73		;7c1d
	ld (0d922h),hl		;7c20   ; la y de la ficha 10 del jugador = hl
	ld a,081h		;7c23
	ld (0d924h),a		;7c25   ; bit 7: el jugador usa la ficha 10 = a
	jp L_7C73		;7c28
L_7C2B:
	ld e,001h		;7c2b
	ld a,l			;7c2d
	sub 01bh		;7c2e
	ld l,a			;7c30
	ld a,h			;7c31
	add a,008h		;7c32
	ld h,a			;7c34
	ld a,(0d919h)		;7c35
	cp 003h		;7c38
	jp nz,L_7C73		;7c3a
	ld a,(0d924h)		;7c3d   ; a = bit 7: el jugador usa la ficha 10
	or a			;7c40
	jp nz,L_7C73		;7c41
	ld (0d922h),hl		;7c44   ; la y de la ficha 10 del jugador = hl
	ld a,080h		;7c47
	ld (0d924h),a		;7c49   ; bit 7: el jugador usa la ficha 10 = a
	jp L_7C73		;7c4c
L_7C4F:
	ld e,002h		;7c4f
	ld a,l			;7c51
	add a,018h		;7c52
	ld l,a			;7c54
	ld a,h			;7c55
	add a,008h		;7c56
	ld h,a			;7c58
	ld a,(0d919h)		;7c59
	cp 003h		;7c5c
	jp nz,L_7C73		;7c5e
	ld a,(0d924h)		;7c61   ; a = bit 7: el jugador usa la ficha 10
	or a			;7c64
	jp nz,L_7C73		;7c65
	ld (0d922h),hl		;7c68   ; la y de la ficha 10 del jugador = hl
	ld a,082h		;7c6b
	ld (0d924h),a		;7c6d   ; bit 7: el jugador usa la ficha 10 = a
	jp L_7C73		;7c70
L_7C73:
	ld a,(0d919h)		;7c73
	add a,a			;7c76
	add a,a			;7c77
	add a,a			;7c78
	push hl			;7c79
	ld l,a			;7c7a
	ld h,000h		;7c7b
	ld d,000h		;7c7d
	add hl,de			;7c7f
	ld de,080c6h		;7c80
	ld a,(0d90dh)		;7c83
	bit 7,a		;7c86
	jr z,L_7C8D		;7c88
	ld de,080cah		;7c8a
L_7C8D:
	add hl,de			;7c8d
	ld c,(hl)			;7c8e
	pop hl			;7c8f
	ld a,(0d910h)		;7c90
	bit 6,a		;7c93
	jp nz,091d1h		;7c95
	call L_7FF2		;7c98
	ld b,003h		;7c9b
	ld de,00026h		;7c9d
	ld ix,0d933h		;7ca0   ; ix -> los 6 actores de la pantalla
L_7CA4:
	ld a,(ix+00fh)		;7ca4
	or a			;7ca7
	jp z,L_7E83		;7ca8
	ld a,(ix+000h)		;7cab
	or a			;7cae
	jp z,L_7E83		;7caf
	bit 7,(ix+025h)		;7cb2
	jp nz,L_7E83		;7cb6
	cp 002h		;7cb9
	jp c,L_7D14		;7cbb
	jp z,L_7D2D		;7cbe
	cp 004h		;7cc1
	jp c,L_7D5E		;7cc3
	jp z,L_7D2D		;7cc6
	cp 006h		;7cc9
	jp c,L_7D2D		;7ccb
	jp z,L_7D14		;7cce
	cp 008h		;7cd1
	jp c,L_7D2D		;7cd3
	jp z,L_7E37		;7cd6
	cp 00ah		;7cd9
	jp c,L_7DA8		;7cdb
	jp z,L_7E37		;7cde
	cp 00ch		;7ce1
	jp c,L_7DC1		;7ce3
	jp z,L_7DC1		;7ce6
	cp 00eh		;7ce9
	jp c,L_7DA8		;7ceb
	jp z,L_7DDA		;7cee
	cp 010h		;7cf1
	jp c,L_7DF3		;7cf3
	jp z,L_7DDA		;7cf6
	cp 012h		;7cf9
	jp c,L_7D14		;7cfb
	jp z,L_7D14		;7cfe
	cp 014h		;7d01
	jp c,L_7D14		;7d03
	jp z,L_7D5E		;7d06
	cp 016h		;7d09
	jp c,L_7D5E		;7d0b
	jp z,L_7E0C		;7d0e
	jp L_7E83		;7d11
L_7D14:
	ld a,(ix+006h)		;7d14
	sub h			;7d17
	add a,014h		;7d18
	cp 018h		;7d1a
	jp nc,L_7E83		;7d1c
	ld a,(ix+007h)		;7d1f
	sub l			;7d22
	add a,01eh		;7d23
	cp 02ch		;7d25
	jp nc,L_7E83		;7d27
	jp L_7E69		;7d2a
L_7D2D:
	ld a,(ix+007h)		;7d2d
	sub l			;7d30
	add a,00fh		;7d31
	cp 01bh		;7d33
	jr nc,L_7D45		;7d35
	ld a,(ix+006h)		;7d37
	sub h			;7d3a
	add a,01ch		;7d3b
	cp 029h		;7d3d
	jp nc,L_7E83		;7d3f
	jp L_7E69		;7d42
L_7D45:
	ld a,(ix+007h)		;7d45
	sub l			;7d48
	add a,01bh		;7d49
	cp 01eh		;7d4b
	jp nc,L_7E83		;7d4d
	ld a,(ix+006h)		;7d50
	sub h			;7d53
	add a,016h		;7d54
	cp 01dh		;7d56
	jp nc,L_7E83		;7d58
	jp L_7E69		;7d5b
L_7D5E:
	ld a,(ix+007h)		;7d5e
	sub l			;7d61
	add a,00fh		;7d62
	cp 01bh		;7d64
	jr nc,L_7D76		;7d66
	ld a,(ix+006h)		;7d68
	sub h			;7d6b
	add a,016h		;7d6c
	cp 01dh		;7d6e
	jp nc,L_7E83		;7d70
	jp L_7E69		;7d73
L_7D76:
	ld a,(ix+007h)		;7d76
	sub l			;7d79
	add a,01bh		;7d7a
	cp 01eh		;7d7c
	jp nc,L_7E83		;7d7e
	ld a,(ix+006h)		;7d81
	sub h			;7d84
	add a,01dh		;7d85
	cp 02bh		;7d87
	jp nc,L_7E83		;7d89
	jp L_7E69		;7d8c
L_7D8F:
	ld a,(ix+006h)		;7d8f
	sub h			;7d92
	add a,01fh		;7d93
	cp 01dh		;7d95
	jp nc,L_7E83		;7d97
	ld a,(ix+007h)		;7d9a
	sub l			;7d9d
	add a,01fh		;7d9e
	cp 017h		;7da0
	jp nc,L_7E83		;7da2
	jp L_7E69		;7da5
L_7DA8:
	ld a,(ix+006h)		;7da8
	sub h			;7dab
	add a,01ch		;7dac
	cp 029h		;7dae
	jp nc,L_7E83		;7db0
	ld a,(ix+007h)		;7db3
	sub l			;7db6
	add a,01dh		;7db7
	cp 029h		;7db9
	jp nc,L_7E83		;7dbb
	jp L_7E69		;7dbe
L_7DC1:
	ld a,(ix+006h)		;7dc1
	sub h			;7dc4
	add a,00eh		;7dc5
	cp 01dh		;7dc7
	jp nc,L_7E83		;7dc9
	ld a,(ix+007h)		;7dcc
	sub l			;7dcf
	add a,00eh		;7dd0
	cp 01dh		;7dd2
	jp nc,L_7E83		;7dd4
	jp L_7E69		;7dd7
L_7DDA:
	ld a,(ix+006h)		;7dda
	sub h			;7ddd
	add a,00eh		;7dde
	cp 01dh		;7de0
	jp nc,L_7E83		;7de2
	ld a,(ix+007h)		;7de5
	sub l			;7de8
	add a,01eh		;7de9
	cp 02ch		;7deb
	jp nc,L_7E83		;7ded
	jp L_7E69		;7df0
L_7DF3:
	ld a,(ix+006h)		;7df3
	sub h			;7df6
	add a,01eh		;7df7
	cp 02dh		;7df9
	jp nc,L_7E83		;7dfb
	ld a,(ix+007h)		;7dfe
	sub l			;7e01
	add a,01fh		;7e02
	cp 01dh		;7e04
	jp nc,L_7E83		;7e06
	jp L_7E69		;7e09
L_7E0C:
	res 6,(ix+025h)		;7e0c
	ld a,(ix+001h)		;7e10
	and 01eh		;7e13
	cp 014h		;7e15
	jp nz,L_7E83		;7e17
	ld a,(ix+006h)		;7e1a
	sub h			;7e1d
	add a,015h		;7e1e
	cp 01ch		;7e20
	jp nc,L_7E83		;7e22
	ld a,(ix+007h)		;7e25
	sub l			;7e28
	add a,019h		;7e29
	cp 033h		;7e2b
	jp nc,L_7E83		;7e2d
	set 6,(ix+025h)		;7e30
	jp L_7E69		;7e34
L_7E37:
	ld a,(ix+006h)		;7e37
	sub h			;7e3a
	add a,01eh		;7e3b
	cp 02dh		;7e3d
	jp nc,L_7E83		;7e3f
	ld a,(ix+007h)		;7e42
	sub l			;7e45
	add a,009h		;7e46
	cp 01eh		;7e48
	jp nc,L_7E83		;7e4a
	jp L_7E69		;7e4d
L_7E50:
	ld a,(ix+006h)		;7e50
	sub h			;7e53
	add a,00eh		;7e54
	cp 01dh		;7e56
	jp nc,L_7E83		;7e58
	ld a,(ix+007h)		;7e5b
	sub l			;7e5e
	add a,00ch		;7e5f
	cp 018h		;7e61
	jp nc,L_7E83		;7e63
	jp L_7E69		;7e66
L_7E69:
	ld a,(ix+00fh)		;7e69
	sub c			;7e6c
	jr z,L_7E71		;7e6d
	jr nc,L_7E75		;7e6f
L_7E71:
	call 0807ch		;7e71
	xor a			;7e74
L_7E75:
	ld (ix+00fh),a		;7e75
	set 7,(ix+025h)		;7e78
	exx			;7e7c
	ld hl,0d928h		;7e7d
	set 6,(hl)		;7e80
	exx			;7e82
L_7E83:
	add ix,de		;7e83
	dec b			;7e85
	jp nz,L_7CA4		;7e86
	ld c,000h		;7e89
	ld a,(0d904h)		;7e8b
	and 01eh		;7e8e
	cp 014h		;7e90
	jr nz,L_7E96		;7e92
	ld c,001h		;7e94
L_7E96:
	ld b,008h		;7e96
	ld de,00026h		;7e98
	ld ix,0da20h		;7e9b   ; ix -> los 8 enemigos de la pantalla
L_7E9F:
	ld a,(ix+000h)		;7e9f
	cp 024h		;7ea2
	jp nz,L_7F00		;7ea4
	bit 0,c		;7ea7
	jr z,L_7EC2		;7ea9
	ld a,(ix+010h)		;7eab
	sub h			;7eae
	add a,00eh		;7eaf
	cp 010h		;7eb1
	jr nc,L_7F00		;7eb3
	ld a,(ix+011h)		;7eb5
	sub l			;7eb8
	add a,01fh		;7eb9
	cp 02dh		;7ebb
	jr nc,L_7F00		;7ebd
	jp L_7ED6		;7ebf
L_7EC2:
	ld a,(ix+010h)		;7ec2
	sub h			;7ec5
	add a,01fh		;7ec6
	cp 029h		;7ec8
	jr nc,L_7F00		;7eca
	ld a,(ix+011h)		;7ecc
	sub l			;7ecf
	add a,018h		;7ed0
	sub 01fh		;7ed2
	jr nc,L_7F00		;7ed4
L_7ED6:
	push bc			;7ed6
	push de			;7ed7
	push hl			;7ed8
	ld l,(ix+011h)		;7ed9
	ld h,(ix+010h)		;7edc
	call 080e6h		;7edf
	ld a,(hl)			;7ee2
	and 00fh		;7ee3
	ld (hl),a			;7ee5
	inc hl			;7ee6
	inc hl			;7ee7
	ld a,(hl)			;7ee8
	and 00fh		;7ee9
	ld (hl),a			;7eeb
	ld bc,0001eh		;7eec
	add hl,bc			;7eef
	ld a,(hl)			;7ef0
	and 00fh		;7ef1
	ld (hl),a			;7ef3
	inc hl			;7ef4
	inc hl			;7ef5
	ld a,(hl)			;7ef6
	and 00fh		;7ef7
	ld (hl),a			;7ef9
	call L_6207		;7efa
	pop hl			;7efd
	pop de			;7efe
	pop bc			;7eff
L_7F00:
	add ix,de		;7f00
	djnz L_7E9F		;7f02
L_7F04:
	ld hl,(0d922h)		;7f04   ; hl = la y de la ficha 10 del jugador
	ld c,030h		;7f07
	ld a,(0d924h)		;7f09   ; a = bit 7: el jugador usa la ficha 10
	bit 7,a		;7f0c
	ret z			;7f0e
	ld a,h			;7f0f
	cp 004h		;7f10
	jr c,L_7F5B		;7f12
	cp 0f4h		;7f14
	jr nc,L_7F5B		;7f16
	ld a,l			;7f18
	cp 024h		;7f19
	jr c,L_7F5B		;7f1b
	cp 0cch		;7f1d
	jr nc,L_7F5B		;7f1f
	push hl			;7f21
	ld a,h			;7f22
	add a,004h		;7f23
	ld h,a			;7f25
	ld a,l			;7f26
	add a,004h		;7f27
	ld l,a			;7f29
	push af			;7f2a
	call 080e6h		;7f2b
	ld b,a			;7f2e
	pop af			;7f2f
	ld de,00000h		;7f30
	and 00fh		;7f33
	cp 009h		;7f35
	jr c,L_7F3C		;7f37
	ld de,00020h		;7f39
L_7F3C:
	add hl,de			;7f3c
	ld c,(hl)			;7f3d
	pop hl			;7f3e
	ld a,b			;7f3f
	cp 010h		;7f40
	jr c,L_7F4C		;7f42
	cp 080h		;7f44
	jr c,L_7F5B		;7f46
	cp 0a0h		;7f48
	jr z,L_7F5B		;7f4a
L_7F4C:
	ld a,c			;7f4c
	and 0f0h		;7f4d
	cp 010h		;7f4f
	jr c,L_7F60		;7f51
	cp 080h		;7f53
	jr c,L_7F5B		;7f55
	cp 0a0h		;7f57
	jr nz,L_7F60		;7f59
L_7F5B:
	xor a			;7f5b
	ld (0d924h),a		;7f5c   ; bit 7: el jugador usa la ficha 10 = a
	ret			;7f5f
L_7F60:
	ld b,003h		;7f60
	ld c,030h		;7f62
	ld de,00026h		;7f64
	ld ix,0d933h		;7f67   ; ix -> los 6 actores de la pantalla
L_7F6B:
	ld a,(ix+000h)		;7f6b
	or a			;7f6e
	jp z,L_7FA6		;7f6f
	ld a,(ix+00fh)		;7f72
	or a			;7f75
	jp z,L_7FA6		;7f76
	bit 7,(ix+025h)		;7f79
	jp nz,L_7FA6		;7f7d
	ld a,(ix+006h)		;7f80
	sub h			;7f83
	add a,00eh		;7f84
	cp 01dh		;7f86
	jr nc,L_7FA6		;7f88
	ld a,(ix+007h)		;7f8a
	sub l			;7f8d
	add a,01bh		;7f8e
	cp 027h		;7f90
	jr nc,L_7FA6		;7f92
	ld a,(ix+00fh)		;7f94
	sub c			;7f97
	jr z,L_7F9C		;7f98
	jr nc,L_7FA0		;7f9a
L_7F9C:
	call 0807ch		;7f9c
	xor a			;7f9f
L_7FA0:
	ld (ix+00fh),a		;7fa0
	jp L_7F5B		;7fa3
L_7FA6:
	add ix,de		;7fa6
	djnz L_7F6B		;7fa8
	ld a,(0d924h)		;7faa   ; a = bit 7: el jugador usa la ficha 10
	and 003h		;7fad
	cp 001h		;7faf
	jr c,L_7FBF		;7fb1
	jr z,L_7FC5		;7fb3
	cp 003h		;7fb5
	jr c,L_7FCB		;7fb7
	ld a,h			;7fb9
	sub 003h		;7fba
	ld h,a			;7fbc
	jr L_7FCF		;7fbd
L_7FBF:
	ld a,l			;7fbf
	sub 003h		;7fc0
	ld l,a			;7fc2
	jr L_7FCF		;7fc3
L_7FC5:
	ld a,h			;7fc5
	add a,003h		;7fc6
	ld h,a			;7fc8
	jr L_7FCF		;7fc9
L_7FCB:
	ld a,l			;7fcb
	add a,003h		;7fcc
	ld l,a			;7fce
L_7FCF:
	ld (0d922h),hl		;7fcf   ; la y de la ficha 10 del jugador = hl
	ret			;7fd2
L_7FD3:
	bit 0,b		;7fd3
	jr nz,L_7FE1		;7fd5
	ld a,l			;7fd7
	sub 00ah		;7fd8
	ld l,a			;7fda
	ld a,h			;7fdb
	add a,009h		;7fdc
	ld h,a			;7fde
	jr L_7FE6		;7fdf
L_7FE1:
	ld a,l			;7fe1
	sub 00ah		;7fe2
	ld l,a			;7fe4
	dec h			;7fe5
L_7FE6:
	call L_7FF2		;7fe6
	ld a,(0d910h)		;7fe9
	bit 6,a		;7fec
	ret nz			;7fee
	jp L_7F04		;7fef
L_7FF2:
	ld a,(0d92dh)		;7ff2   ; a = cual es el bloque especial
	or a			;7ff5
	ret z			;7ff6
	cp 004h		;7ff7
	ret nc			;7ff9
	ld a,(0d92bh)		;7ffa   ; a = x del bloque especial de la pantalla
	sub h			;7ffd
	add a,00eh		;7ffe
