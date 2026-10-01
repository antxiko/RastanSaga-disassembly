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


L_6000:
	ld a,(0d5e5h)		;6000   ; a = la fase
	cp 002h		;6003
	jp z,08016h		;6005
	cp 005h		;6008
	jp z,08262h		;600a
	cp 008h		;600d
	jp z,0848eh		;600f
	cp 00bh		;6012
	jp z,08799h		;6014
	cp 00eh		;6017
	jp z,089ceh		;6019
	cp 012h		;601c
	jp z,08bf4h		;601e
L_6021:
	cp 013h		;6021
	jp z,08c06h		;6023
L_6026:
	cp 014h		;6026
	jp z,08c18h		;6028
L_602B:
	cp 015h		;602b
	jp z,08c2ah		;602d
L_6030:
	cp 016h		;6030
	jp z,08c3ch		;6032
L_6035:
	cp 017h		;6035
	jp z,08c4eh		;6037
	ld ix,(0da1ah)		;603a
	ld a,(ix+000h)		;603e
	and a			;6041
	jp z,L_605C		;6042
	cp 024h		;6045
	jp z,L_607A		;6047
	dec a			;604a
	ld l,a			;604b
	ld h,000h		;604c
	add hl,hl			;604e
	ld de,060c9h		;604f
	add hl,de			;6052
	ld e,(hl)			;6053
	inc hl			;6054
	ld d,(hl)			;6055
	ex de,hl			;6056
	ld de,L_605C		;6057
	push de			;605a
	jp (hl)			;605b
L_605C:
	ld a,(0da1ch)		;605c
	ld b,a			;605f
	ld de,00026h		;6060
	add ix,de		;6063
	djnz L_606A		;6065
	call L_6073		;6067
L_606A:
	ld (0da1ah),ix		;606a
	ld a,b			;606e
	ld (0da1ch),a		;606f
	ret			;6072
L_6073:
	ld ix,0d933h		;6073   ; ix -> los 6 actores de la pantalla
	ld b,003h		;6077
	ret			;6079
L_607A:
	call 04a8bh		;607a
	bit 7,(ix+002h)		;607d
	jp z,L_605C		;6081
	ld a,(0d92dh)		;6084   ; a = cual es el bloque especial
	and a			;6087
	jp nz,L_60C3		;6088
	call 044deh		;608b
	and 024h		;608e
	cp 004h		;6090
	jp nz,L_60C3		;6092
	ld a,(ix+006h)		;6095
	add a,008h		;6098
	and 0f0h		;609a
	ld (0d92bh),a		;609c   ; x del bloque especial de la pantalla = a
	ld a,(ix+007h)		;609f
	add a,008h		;60a2
	and 0f0h		;60a4
	ld (0d92ch),a		;60a6   ; y del bloque especial = a
L_60A9:
	call 044deh		;60a9
	ld b,a			;60ac
	ld a,r		;60ad
	xor b			;60af
	and 00fh		;60b0
	add a,003h		;60b2
	cp 003h		;60b4
	jp z,L_60A9		;60b6
	ld (0d92dh),a		;60b9   ; cual es el bloque especial = a
	push ix		;60bc
	call 048b6h		;60be
	pop ix		;60c1
L_60C3:
	call 04b10h		;60c3
	jp L_605C		;60c6

; ----------------------------------------------------------------------
; DATOS sin identificar  0x60c9..0x6109  (64 bytes)
DATA_60C9:
	defb 05eh,064h,009h,061h,0bah,067h,08dh,066h,059h,06bh,07dh,071h,039h,066h,009h,061h	; 60c9  ^d.a.g.fYk}q9f.a
	defb 0dch,06ch,0c6h,070h,00ah,061h,034h,061h,045h,067h,0aah,061h,076h,070h,006h,062h	; 60d9  .l.p.a4aEg.avp.b
	defb 0fch,074h,068h,073h,095h,06eh,0f1h,076h,0adh,078h,009h,061h,009h,061h,009h,061h	; 60e9  .ths.n.v.x.a.a.a
	defb 009h,061h,009h,061h,009h,061h,009h,061h,009h,061h,009h,061h,009h,061h,009h,061h	; 60f9  .a.a.a.a.a.a.a.a

; ======================================================================
; CODIGO 0x6109..0x618e  (133 bytes)
; ======================================================================


L_6109:
	ret			;6109
L_610A:
	ld a,(ix+00fh)		;610a
	and a			;610d
	jp z,L_7AAF		;610e
	call L_7B29		;6111
	and a			;6114
	call z,L_7E18		;6115
	call L_7D56		;6118
	ld a,(ix+020h)		;611b
	and 0f0h		;611e
	cp 020h		;6120
	jp z,L_6131		;6122
	call L_7B90		;6125
	call L_7E83		;6128
	call L_6184		;612b
	jp 04a8bh		;612e
L_6131:
	jp 04a8bh		;6131
L_6134:
	ld a,(ix+00fh)		;6134
	and a			;6137
	jp z,L_7AAF		;6138
	ld a,(ix+010h)		;613b
	and a			;613e
	jr nz,L_614A		;613f
	ld a,009h		;6141
	ld (0d178h),a		;6143   ; peticion de sonido para p01:63E1 = a
	ld (ix+010h),0ffh		;6146
L_614A:
	call L_7B29		;614a
	and a			;614d
	call z,L_7E18		;614e
	ld a,(ix+006h)		;6151
	cp 001h		;6154
	call c,L_7E97		;6156
	cp 0efh		;6159
	call nc,L_7EA0		;615b
	ld a,(ix+007h)		;615e
	cp 001h		;6161
	call c,L_7EA9		;6163
	cp 0b6h		;6166
	call nc,L_7EAF		;6168
	call L_7D56		;616b
	ld a,(ix+019h)		;616e
	and 0f0h		;6171
	cp 020h		;6173
	jp z,L_6181		;6175
	call L_7E83		;6178
	call L_7B90		;617b
	jp 04a8bh		;617e
L_6181:
	jp 04a8bh		;6181
L_6184:
	ld b,004h		;6184
	ld a,r		;6186
	and 018h		;6188
	cp 000h		;618a
	jr $+15		;618c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x618e..0x619b  (13 bytes)
DATA_618E:
	defb 0feh,008h,018h,00eh,0feh,010h,018h,00fh,0ddh,07eh,006h,080h,0c9h	; 618e  .........~...

; ======================================================================
; CODIGO 0x619b..0x61a0  (5 bytes)
; ======================================================================


L_619B:
	ld a,(ix+006h)		;619b
	sub b			;619e
	ret			;619f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x61a0..0x61aa  (10 bytes)
DATA_61A0:
	defb 0ddh,07eh,007h,080h,0c9h,0ddh,07eh,007h,090h,0c9h	; 61a0  .~....~...

; ======================================================================
; CODIGO 0x61aa..0x63d6  (556 bytes)
; ======================================================================


L_61AA:
	ld a,(ix+00fh)		;61aa
	and a			;61ad
	jp z,L_7AAF		;61ae
	call L_7B29		;61b1
	and a			;61b4
	jp z,L_7E18		;61b5
	call L_7EBD		;61b8
	cp 0ffh		;61bb
	jp z,L_7E4B		;61bd
	ld a,(ix+006h)		;61c0
	cp 008h		;61c3
	call L_7E18		;61c5
	cp 0efh		;61c8
	call L_7E18		;61ca
	call L_7D56		;61cd
	bit 0,(ix+001h)		;61d0
	jr z,L_61EB		;61d4
	ld a,(ix+018h)		;61d6
	and 0f0h		;61d9
	cp 020h		;61db
	jr z,L_6203		;61dd
	ld a,(ix+01bh)		;61df
	and 0f0h		;61e2
	cp 020h		;61e4
	jr nz,L_6203		;61e6
	jp L_7B48		;61e8
L_61EB:
	ld a,(ix+018h)		;61eb
	and 0f0h		;61ee
	cp 020h		;61f0
	jr z,L_6203		;61f2
	ld a,(ix+01dh)		;61f4
	and 0f0h		;61f7
	cp 020h		;61f9
	jr nz,L_6203		;61fb
	call L_7E83		;61fd
	jp 04a8bh		;6200
L_6203:
	jp 04a8bh		;6203
L_6206:
	ld a,(ix+00fh)		;6206
	and a			;6209
	jp z,L_7AAF		;620a
	ld a,(0da06h)		;620d   ; a = actor 5, byte +15
	cp 00fh		;6210
	call z,L_62C6		;6212
	bit 1,(ix+001h)		;6215
	call nz,L_62C6		;6219
	call L_7B29		;621c
	and a			;621f
	jp z,L_7E18		;6220
	ld a,(ix+011h)		;6223
	and a			;6226
	jp nz,L_62AC		;6227
	ld a,(ix+013h)		;622a
	and a			;622d
	res 1,(ix+001h)		;622e
	jp nz,L_62B3		;6232
	ld a,(ix+006h)		;6235
	cp 001h		;6238
	call c,L_7E97		;623a
	cp 0efh		;623d
	call nc,L_7EA0		;623f
	call L_7D56		;6242
	bit 0,(ix+001h)		;6245
	jr z,L_6261		;6249
	ld a,(ix+018h)		;624b
	and 0f0h		;624e
	cp 020h		;6250
	jp z,L_6284		;6252
	ld a,(ix+01ch)		;6255
	and 0f0h		;6258
	cp 020h		;625a
	jp nz,L_6284		;625c
	jr L_6275		;625f
L_6261:
	ld a,(ix+01ah)		;6261
	and 0f0h		;6264
	cp 020h		;6266
	jp z,L_6284		;6268
	ld a,(ix+01eh)		;626b
	and 0f0h		;626e
	cp 020h		;6270
	jp nz,L_6284		;6272
L_6275:
	ld a,(ix+010h)		;6275
	cp 020h		;6278
	jp z,L_628B		;627a
	inc a			;627d
	ld (ix+010h),a		;627e
	jp L_7B64		;6281
L_6284:
	ld (ix+013h),0ffh		;6284
	jp 04a8bh		;6288
L_628B:
	ld a,(0d9e0h)		;628b   ; a = actor 4, byte +15
	cp 00fh		;628e
	jr z,L_62AC		;6290
	set 1,(ix+001h)		;6292
	ld (ix+010h),000h		;6296
	ld (ix+011h),00fh		;629a
	push ix		;629e
	call 04a8bh		;62a0
	pop ix		;62a3
	ld a,(ix+015h)		;62a5
	and a			;62a8
	jp z,L_62C6		;62a9
L_62AC:
	dec a			;62ac
	ld (ix+011h),a		;62ad
	jp 04a8bh		;62b0
L_62B3:
	ld a,r		;62b3
	jp po,L_62BF		;62b5
	dec a			;62b8
	ld (ix+013h),a		;62b9
	jp 04a8bh		;62bc
L_62BF:
	set 1,(ix+001h)		;62bf
	jp 04a8bh		;62c3
L_62C6:
	push ix		;62c6
	push ix		;62c8
	pop iy		;62ca
	ld ix,0d9f1h		;62cc   ; ix -> actor 5
	ld a,(ix+015h)		;62d0
	cp 000h		;62d3
	jp z,L_62DC		;62d5
	cp 00fh		;62d8
	jr L_6348		;62da
L_62DC:
	bit 7,(iy+002h)		;62dc
	jp z,L_62F6		;62e0
	ld (ix+015h),00fh		;62e3
	call L_6312		;62e7
	ld hl,063d6h		;62ea
	ld (0da01h),hl		;62ed   ; actor 5, byte +10 = hl
	call 048f9h		;62f0
	call 04a8bh		;62f3
L_62F6:
	pop ix		;62f6
	ret			;62f8
L_62F9:
	call 04a8bh		;62f9
	pop ix		;62fc
	ret			;62fe
L_62FF:
	ld (ix+015h),000h		;62ff
	ld hl,063d6h		;6303
	ld (ix+010h),l		;6306
	ld (ix+011h),h		;6309
	call 04b10h		;630c
	pop ix		;630f
	ret			;6311
L_6312:
	ld a,(iy+001h)		;6312
	ld (ix+012h),a		;6315
	bit 0,(iy+001h)		;6318
	jr z,L_6328		;631c
	ld a,(iy+006h)		;631e
	sub 010h		;6321
	ld (ix+006h),a		;6323
	jr L_6330		;6326
L_6328:
	ld a,(iy+006h)		;6328
	add a,010h		;632b
	ld (ix+006h),a		;632d
L_6330:
	ld a,(iy+007h)		;6330
	add a,006h		;6333
	ld (ix+007h),a		;6335
	ld a,016h		;6338
	ld (ix+000h),a		;633a
	ld a,(ix+001h)		;633d
	and 001h		;6340
	or 010h		;6342
	ld (ix+001h),a		;6344
	ret			;6347
L_6348:
	call L_7D56		;6348
	ld a,(ix+021h)		;634b
	and 0f0h		;634e
	cp 020h		;6350
	jp z,L_62FF		;6352
	bit 0,(ix+012h)		;6355
	jr z,L_6385		;6359
	call L_6AFF		;635b
	and a			;635e
	jp z,L_62FF		;635f
	ld l,(ix+010h)		;6362
	ld h,(ix+011h)		;6365
	inc hl			;6368
	ld a,(hl)			;6369
	cp 0ffh		;636a
	jp z,L_62FF		;636c
	ld a,(ix+006h)		;636f
	ld l,(ix+010h)		;6372
	ld h,(ix+011h)		;6375
	inc hl			;6378
	ld b,(hl)			;6379
	sub b			;637a
	cp 004h		;637b
	call c,L_6AAE		;637d
	ld (ix+006h),a		;6380
	jr L_63B4		;6383
L_6385:
	call L_6B2C		;6385
	and a			;6388
	jp z,L_62FF		;6389
	ld l,(ix+010h)		;638c
	ld h,(ix+011h)		;638f
	inc hl			;6392
	ld a,(hl)			;6393
	cp 0ffh		;6394
	jp z,L_62FF		;6396
	ld a,(ix+006h)		;6399
	ld l,(ix+010h)		;639c
	ld h,(ix+011h)		;639f
	inc hl			;63a2
	ld b,(hl)			;63a3
	add a,b			;63a4
	cp 0e6h		;63a5
	call nc,L_6AAB		;63a7
	ld (ix+006h),a		;63aa
	ld a,(ix+006h)		;63ad
	inc a			;63b0
	ld (ix+006h),a		;63b1
L_63B4:
	inc hl			;63b4
	ld a,(hl)			;63b5
	cp 0ffh		;63b6
	jp z,L_62FF		;63b8
	ld b,(hl)			;63bb
	ld a,(ix+007h)		;63bc
	add a,b			;63bf
	ld (ix+007h),a		;63c0
	ld (ix+010h),l		;63c3
	ld (ix+011h),h		;63c6
	ld a,(ix+001h)		;63c9
	and 001h		;63cc
	or 010h		;63ce
	ld (ix+001h),a		;63d0
	jp L_62F9		;63d3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x63d6..0x640f  (57 bytes)
DATA_63D6:
	defb 000h,000h,000h,002h,001h,002h,000h,002h,000h,002h,001h,002h,002h,002h,002h,002h	; 63d6  ................
	defb 002h,002h,000h,002h,002h,002h,002h,002h,001h,002h,000h,002h,001h,002h,000h,002h	; 63e6  ................
	defb 002h,002h,002h,002h,0ffh,03ah,0fch,0d8h,057h,0ddh,0cbh,001h,046h,028h,00ah,0ddh	; 63f6  .....:..W...F(..
	defb 07eh,006h,0d6h,010h,0bah,0dah,017h,064h,0c9h	; 6406  ~......d.

; ======================================================================
; CODIGO 0x640f..0x6600  (497 bytes)
; ======================================================================


L_640F:
	ld a,(ix+006h)		;640f
	cp d			;6412
	jp nc,L_6417		;6413
	ret			;6416
L_6417:
	ld a,(0d8fdh)		;6417   ; a = la y de Rastan
	ld d,a			;641a
	ld a,(ix+007h)		;641b
	cp d			;641e
	call c,L_6423		;641f
	ret			;6422
L_6423:
	ld d,008h		;6423
	ld a,(0d90fh)		;6425
	bit 6,a		;6428
	ret nz			;642a
	bit 4,a		;642b
	ret nz			;642d
	set 4,a		;642e
	set 6,a		;6430
	ld (0d90fh),a		;6432
	ld a,(0d904h)		;6435
	set 6,a		;6438
	res 5,a		;643a
	ld (0d904h),a		;643c
	ld a,050h		;643f
	ld (0d913h),a		;6441   ; 0x27 al entrar en una pantalla = a
	ld a,(0d910h)		;6444
	bit 7,a		;6447
	ret nz			;6449
	ld a,(0d91ch)		;644a
	sub d			;644d
	ld (0d91ch),a		;644e
	jr z,L_6454		;6451
	ret nc			;6453
L_6454:
	xor a			;6454
	ld (0d91ch),a		;6455
	ld a,080h		;6458
	ld (0d90fh),a		;645a
	ret			;645d
L_645E:
	ld a,(ix+00fh)		;645e
	and a			;6461
	jp z,L_7AAF		;6462
	ld a,(ix+012h)		;6465
	and a			;6468
	jp nz,L_65C9		;6469
	ld a,(ix+011h)		;646c
	and a			;646f
	jp nz,L_65DB		;6470
	ld a,(ix+010h)		;6473
	and a			;6476
	jr z,L_6493		;6477
	dec a			;6479
	ld (ix+010h),a		;647a
	ld a,(ix+007h)		;647d
	dec a			;6480
	dec a			;6481
	ld (ix+007h),a		;6482
	set 2,(ix+001h)		;6485
	res 1,(ix+001h)		;6489
	call L_7E83		;648d
	jp 04a8bh		;6490
L_6493:
	res 2,(ix+001h)		;6493
	call L_7EBD		;6497
	cp 0ffh		;649a
	jp z,L_7E4B		;649c
	ld a,(ix+006h)		;649f
	cp 001h		;64a2
	call c,L_7E97		;64a4
	cp 0e6h		;64a7
	call nc,L_7EA0		;64a9
	call L_7CC6		;64ac
	cp 004h		;64af
	jp c,L_656E		;64b1
	call L_7D56		;64b4
	bit 0,(ix+001h)		;64b7
	jr z,L_650C		;64bb
	ld a,(ix+018h)		;64bd
	and 0f0h		;64c0
	cp 020h		;64c2
	push af			;64c4
	call z,L_7E18		;64c5
	pop af			;64c8
	jp z,L_658E		;64c9
	ld a,(ix+01bh)		;64cc
	and 00fh		;64cf
	cp 002h		;64d1
	jp z,L_661F		;64d3
L_64D6:
	ld a,(ix+01ch)		;64d6
	and 00fh		;64d9
	cp 00fh		;64db
	jp z,L_6558		;64dd
	cp 001h		;64e0
	push af			;64e2
	call z,L_7E18		;64e3
	pop af			;64e6
	jp z,04a8bh		;64e7
	cp 002h		;64ea
	jp z,L_6591		;64ec
	cp 003h		;64ef
	jp z,L_6591		;64f1
	cp 004h		;64f4
	jp z,L_6560		;64f6
	cp 005h		;64f9
	jp z,L_65B3		;64fb
	cp 006h		;64fe
	jp z,L_65B3		;6500
	jp nc,L_6602		;6503
L_6506:
	call L_7E18		;6506
	jp L_6558		;6509
L_650C:
	ld a,(ix+019h)		;650c
	and 0f0h		;650f
	cp 020h		;6511
	push af			;6513
	call z,L_7E18		;6514
	pop af			;6517
	jp z,L_658E		;6518
	ld a,(ix+01eh)		;651b
	and 00fh		;651e
	cp 002h		;6520
	jp z,L_662C		;6522
L_6525:
	ld a,(ix+01dh)		;6525
	and 00fh		;6528
	cp 00fh		;652a
	jp z,L_6558		;652c
	cp 001h		;652f
	push af			;6531
	call z,L_7E18		;6532
	pop af			;6535
	jp z,04a8bh		;6536
	cp 002h		;6539
	jp z,L_65A2		;653b
	cp 003h		;653e
	jp z,L_65A2		;6540
	cp 004h		;6543
	jp z,L_6560		;6545
	cp 005h		;6548
	jp z,L_65B3		;654a
	cp 006h		;654d
	jp z,L_65B3		;654f
	jp nc,L_6609		;6552
L_6555:
	call L_7E18		;6555
L_6558:
	call L_7CC6		;6558
	cp 030h		;655b
	jp c,L_656E		;655d
L_6560:
	res 2,(ix+001h)		;6560
	res 1,(ix+001h)		;6564
L_6568:
	call L_7E83		;6568
	jp 04a8bh		;656b
L_656E:
	ld a,r		;656e
	and a			;6570
	jp po,L_6560		;6571
	call L_7B29		;6574
	and a			;6577
	call z,L_7E18		;6578
	call L_7CFB		;657b
	cp 018h		;657e
	jp nc,L_658E		;6580
	set 1,(ix+001h)		;6583
	res 2,(ix+001h)		;6587
	jp 04a8bh		;658b
L_658E:
	jp 04a8bh		;658e
L_6591:
	ld a,(ix+017h)		;6591
	and 0f0h		;6594
	cp 020h		;6596
	jp nz,L_6560		;6598
L_659B:
	ld (ix+010h),00ch		;659b
	jp L_6560		;659f
L_65A2:
	ld a,(ix+01ah)		;65a2
	and 0f0h		;65a5
	cp 020h		;65a7
	jp nz,L_6560		;65a9
	ld (ix+010h),00ch		;65ac
	jp L_6560		;65b0
L_65B3:
	set 2,(ix+001h)		;65b3
	res 1,(ix+001h)		;65b7
	ld (ix+011h),010h		;65bb
	jp L_658E		;65bf
L_65C2:
	ld (ix+012h),010h		;65c2
	jp L_658E		;65c6
L_65C9:
	ld a,(ix+007h)		;65c9
	inc a			;65cc
	inc a			;65cd
	ld (ix+007h),a		;65ce
	ld a,(ix+012h)		;65d1
	dec a			;65d4
	ld (ix+012h),a		;65d5
	jp L_6568		;65d8
L_65DB:
	set 2,(ix+001h)		;65db
	res 1,(ix+001h)		;65df
	ld a,(ix+007h)		;65e3
	dec a			;65e6
	dec a			;65e7
	ld (ix+007h),a		;65e8
	ld a,(ix+011h)		;65eb
	dec a			;65ee
	ld (ix+011h),a		;65ef
	and a			;65f2
	jp z,L_65F9		;65f3
	jp L_6568		;65f6
L_65F9:
	ld (ix+012h),010h		;65f9
	jp L_6568		;65fd

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6600..0x6602  (2 bytes)
DATA_6600:
	defb 0c9h,0c9h	; 6600

; ======================================================================
; CODIGO 0x6602..0x6968  (870 bytes)
; ======================================================================


L_6602:
	cp 00fh		;6602
	jp z,L_6506		;6604
	jr L_6611		;6607
L_6609:
	cp 00fh		;6609
	jp z,L_6555		;660b
	jp L_6611		;660e
L_6611:
	call L_7E18		;6611
	call L_7CC6		;6614
	cp 030h		;6617
	jp c,L_656E		;6619
	jp L_658E		;661c
L_661F:
	ld a,(ix+017h)		;661f
	and 0f0h		;6622
	cp 020h		;6624
	jp z,L_659B		;6626
	jp L_64D6		;6629
L_662C:
	ld a,(ix+01ah)		;662c
	and 0f0h		;662f
	cp 020h		;6631
	jp z,L_659B		;6633
	jp L_6525		;6636
L_6639:
	ld a,(ix+00fh)		;6639
	and a			;663c
	jp z,L_7AAF		;663d
	ld a,(ix+010h)		;6640
	and a			;6643
	jr nz,L_664F		;6644
	ld a,009h		;6646
	ld (0d178h),a		;6648   ; peticion de sonido para p01:63E1 = a
	ld (ix+010h),0ffh		;664b
L_664F:
	call L_7B29		;664f
	and a			;6652
	call z,L_7E18		;6653
	ld a,(ix+006h)		;6656
	cp 01eh		;6659
	call c,L_668A		;665b
	cp 0dch		;665e
	call nc,L_668A		;6660
	ld a,(ix+007h)		;6663
	cp 028h		;6666
	call c,L_668A		;6668
	call L_7D56		;666b
	ld a,(ix+018h)		;666e
	and 0f0h		;6671
	cp 020h		;6673
	jp z,L_668A		;6675
	call L_7E83		;6678
	call L_7CFB		;667b
	cp 058h		;667e
	jr z,L_668A		;6680
	jr c,L_668A		;6682
	call L_7B90		;6684
	jp 04a8bh		;6687
L_668A:
	jp 04a8bh		;668a
L_668D:
	ld a,(ix+00fh)		;668d
	and a			;6690
	jp z,L_7AAF		;6691
	ld a,(ix+010h)		;6694
	and a			;6697
	jr nz,L_66A3		;6698
	ld a,009h		;669a
	ld (0d178h),a		;669c   ; peticion de sonido para p01:63E1 = a
	ld (ix+010h),0ffh		;669f
L_66A3:
	ld a,(ix+00fh)		;66a3
	and a			;66a6
	jp z,L_7AAF		;66a7
	call L_7B29		;66aa
	and a			;66ad
	jp z,L_7E18		;66ae
	ld a,(ix+006h)		;66b1
	cp 001h		;66b4
	call c,L_7E97		;66b6
	cp 0efh		;66b9
	call nc,L_670A		;66bb
	ld a,(ix+007h)		;66be
	cp 028h		;66c1
	jp c,L_6728		;66c3
	call L_7D56		;66c6
	bit 0,(ix+001h)		;66c9
	jp z,L_66E4		;66cd
	ld a,(ix+017h)		;66d0
	and 0f0h		;66d3
	cp 020h		;66d5
	jr z,L_6722		;66d7
	ld a,(ix+01bh)		;66d9
	and 0f0h		;66dc
	cp 020h		;66de
	jr z,L_6722		;66e0
	jr L_670F		;66e2
L_66E4:
	ld a,(ix+01ah)		;66e4
	and 0f0h		;66e7
	cp 020h		;66e9
	jr z,L_6722		;66eb
	ld a,(ix+01eh)		;66ed
	and 0f0h		;66f0
	cp 020h		;66f2
	jr z,L_6722		;66f4
	call L_7CC6		;66f6
	cp 020h		;66f9
	jr c,L_670F		;66fb
L_66FD:
	ld a,(0d8fdh)		;66fd   ; a = la y de Rastan
	ld b,014h		;6700
	sub b			;6702
	ld (ix+013h),000h		;6703
	jp L_7BA7		;6707
L_670A:
	ld (ix+007h),0a0h		;670a
	ret			;670e
L_670F:
	call L_7CFB		;670f
	cp 02ah		;6712
	jr nc,L_66FD		;6714
	ld a,(0d8fdh)		;6716   ; a = la y de Rastan
	ld b,014h		;6719
	sub b			;671b
	inc (ix+013h)		;671c
	jp L_7C14		;671f
L_6722:
	dec (ix+007h)		;6722
	jp 04a8bh		;6725
L_6728:
	inc (ix+007h)		;6728
	jp 04a8bh		;672b
L_672E:
	call L_7B29		;672e
	and a			;6731
	jp nz,L_7E18		;6732
	ld a,(ix+006h)		;6735
	cp 0dch		;6738
	jp nc,04b10h		;673a
	cp 01eh		;673d
	jp c,04b10h		;673f
	jp L_7BA7		;6742
L_6745:
	ld a,(ix+00fh)		;6745
	and a			;6748
	jp z,L_7AAF		;6749
	call L_7B29		;674c
	and a			;674f
	jp z,L_7E18		;6750
	call L_7EBD		;6753
	cp 0ffh		;6756
	jp z,L_7E4B		;6758
	ld a,(ix+010h)		;675b
	and a			;675e
	jr z,L_6770		;675f
	dec a			;6761
	ld (ix+010h),a		;6762
	call L_7D0F		;6765
	call 044deh		;6768
	and 0ffh		;676b
	jp po,04a8bh		;676d
L_6770:
	ld a,(ix+006h)		;6770
	cp 001h		;6773
	call c,L_7E97		;6775
	cp 0efh		;6778
	call nc,L_7EA0		;677a
	call L_7D56		;677d
	bit 0,(ix+001h)		;6780
	jr z,L_679C		;6784
	ld a,(ix+018h)		;6786
	and 0f0h		;6789
	cp 020h		;678b
	jp z,L_67B3		;678d
	ld a,(ix+01ch)		;6790
	and 0f0h		;6793
	cp 020h		;6795
	jp nz,L_67B3		;6797
	jr L_67B0		;679a
L_679C:
	ld a,(ix+01ah)		;679c
	and 0f0h		;679f
	cp 020h		;67a1
	jp z,L_67B3		;67a3
	ld a,(ix+01eh)		;67a6
	and 0f0h		;67a9
	cp 020h		;67ab
	jp nz,L_67B3		;67ad
L_67B0:
	jp L_7B64		;67b0
L_67B3:
	ld (ix+010h),008h		;67b3
	jp 04a8bh		;67b7
L_67BA:
	ld a,(ix+00fh)		;67ba
	and a			;67bd
	jp z,L_7AAF		;67be
	ld a,(0d9bah)		;67c1   ; a = actor 3, byte +15
	cp 00fh		;67c4
	call z,L_69AC		;67c6
	bit 2,(ix+001h)		;67c9
	call nz,L_69AC		;67cd
	ld a,(ix+012h)		;67d0
	and a			;67d3
	jp nz,L_6939		;67d4
	ld a,(ix+011h)		;67d7
	and a			;67da
	jp nz,L_6945		;67db
	ld a,(ix+010h)		;67de
	and a			;67e1
	jr z,L_67FB		;67e2
	dec (ix+010h)		;67e4
	dec (ix+007h)		;67e7
	dec (ix+007h)		;67ea
	set 1,(ix+001h)		;67ed
	res 2,(ix+001h)		;67f1
	call L_7E83		;67f5
	jp 04a8bh		;67f8
L_67FB:
	res 1,(ix+001h)		;67fb
	res 2,(ix+001h)		;67ff
	call L_7EBD		;6803
	cp 0ffh		;6806
	jp z,L_7E4B		;6808
	ld a,(ix+006h)		;680b
	cp 001h		;680e
	call c,L_7E97		;6810
	cp 0dch		;6813
	call nc,L_7EA0		;6815
	call L_7CC6		;6818
	cp 004h		;681b
	jp c,L_68D0		;681d
	call L_7D56		;6820
	bit 0,(ix+001h)		;6823
	jr z,L_6873		;6827
	ld a,(ix+018h)		;6829
	and 0f0h		;682c
	cp 020h		;682e
	push af			;6830
	call z,L_7E18		;6831
	pop af			;6834
	jp z,L_68FE		;6835
	ld a,(ix+01bh)		;6838
	and 00fh		;683b
	cp 002h		;683d
	jp z,L_6987		;683f
L_6842:
	ld a,(ix+01ch)		;6842
	and 00fh		;6845
	cp 00fh		;6847
	jp z,L_68BA		;6849
	cp 001h		;684c
	jp z,L_7E18		;684e
	cp 002h		;6851
	jp z,L_6901		;6853
	cp 003h		;6856
	jp z,L_6901		;6858
	cp 004h		;685b
	jp z,L_68C2		;685d
	cp 005h		;6860
	jp z,L_6923		;6862
	cp 006h		;6865
	jp z,L_6923		;6867
	jp nc,L_696A		;686a
L_686D:
	call L_7E18		;686d
	jp L_68BA		;6870
L_6873:
	ld a,(ix+019h)		;6873
	and 0f0h		;6876
	cp 020h		;6878
	push af			;687a
	call z,L_7E18		;687b
	pop af			;687e
	jp z,L_68FE		;687f
	ld a,(ix+01eh)		;6882
	and 00fh		;6885
	cp 002h		;6887
	jp z,L_6994		;6889
L_688C:
	ld a,(ix+01dh)		;688c
	and 00fh		;688f
	cp 00fh		;6891
	jp z,L_68BA		;6893
	cp 001h		;6896
	jp z,L_7E18		;6898
	cp 002h		;689b
	jp z,L_6912		;689d
	cp 003h		;68a0
	jp z,L_6912		;68a2
	cp 004h		;68a5
	jp z,L_68C2		;68a7
	cp 005h		;68aa
	jp z,L_6923		;68ac
	cp 006h		;68af
	jp z,L_6923		;68b1
	jp nc,L_6971		;68b4
L_68B7:
	call L_7E18		;68b7
L_68BA:
	call L_7CC6		;68ba
	cp 050h		;68bd
	jp c,L_68D0		;68bf
L_68C2:
	res 2,(ix+001h)		;68c2
	res 1,(ix+001h)		;68c6
L_68CA:
	call L_7E83		;68ca
	jp 04a8bh		;68cd
L_68D0:
	ld a,(0d9bah)		;68d0   ; a = actor 3, byte +15
	cp 00fh		;68d3
	jp z,L_69A1		;68d5
	call L_7B29		;68d8
	and a			;68db
	call z,L_7E18		;68dc
	call L_7CFB		;68df
	cp 020h		;68e2
	jp nc,L_68FE		;68e4
	set 2,(ix+001h)		;68e7
	res 1,(ix+001h)		;68eb
	push ix		;68ef
	call 04a8bh		;68f1
	pop ix		;68f4
	ld a,(0d9bah)		;68f6   ; a = actor 3, byte +15
	and a			;68f9
	jp z,L_69AC		;68fa
	ret			;68fd
L_68FE:
	jp 04a8bh		;68fe
L_6901:
	ld a,(ix+017h)		;6901
	and 0f0h		;6904
	cp 020h		;6906
	jp nz,L_68C2		;6908
L_690B:
	ld (ix+010h),00ch		;690b
	jp L_68C2		;690f
L_6912:
	ld a,(ix+01ah)		;6912
	and 0f0h		;6915
	cp 020h		;6917
	jp nz,L_68C2		;6919
	ld (ix+010h),00ch		;691c
	jp L_68C2		;6920
L_6923:
	set 1,(ix+001h)		;6923
	res 2,(ix+001h)		;6927
	ld (ix+011h),010h		;692b
	jp L_68FE		;692f
L_6932:
	ld (ix+012h),010h		;6932
	jp L_68FE		;6936
L_6939:
	inc (ix+007h)		;6939
	inc (ix+007h)		;693c
	dec (ix+012h)		;693f
	jp L_68CA		;6942
L_6945:
	set 1,(ix+001h)		;6945
	res 2,(ix+001h)		;6949
	dec (ix+007h)		;694d
	dec (ix+007h)		;6950
	ld a,(ix+011h)		;6953
	dec a			;6956
	ld (ix+011h),a		;6957
	and a			;695a
	jp z,L_6961		;695b
	jp L_68CA		;695e
L_6961:
	ld (ix+012h),010h		;6961
	jp L_68CA		;6965

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6968..0x696a  (2 bytes)
DATA_6968:
	defb 0c9h,0c9h	; 6968

; ======================================================================
; CODIGO 0x696a..0x6cca  (864 bytes)
; ======================================================================


L_696A:
	cp 00fh		;696a
	jp z,L_686D		;696c
	jr L_6979		;696f
L_6971:
	cp 00fh		;6971
	jp z,L_68B7		;6973
	jp L_6979		;6976
L_6979:
	call L_7E18		;6979
	call L_7CC6		;697c
	cp 030h		;697f
	jp c,L_68D0		;6981
	jp L_68FE		;6984
L_6987:
	ld a,(ix+017h)		;6987
	and 0f0h		;698a
	cp 020h		;698c
	jp z,L_690B		;698e
	jp L_6842		;6991
L_6994:
	ld a,(ix+01ah)		;6994
	and 0f0h		;6997
	cp 020h		;6999
	jp z,L_690B		;699b
	jp L_688C		;699e
L_69A1:
	res 1,(ix+001h)		;69a1
	res 2,(ix+001h)		;69a5
	jp 04a8bh		;69a9
L_69AC:
	push ix		;69ac
	push ix		;69ae
	pop iy		;69b0
	ld ix,0d9a5h		;69b2   ; ix -> actor 3
	ld a,(ix+015h)		;69b6
	and a			;69b9
	jr z,L_69C0		;69ba
	cp 00fh		;69bc
	jr L_6A29		;69be
L_69C0:
	bit 7,(iy+002h)		;69c0
	jp z,L_69E3		;69c4
	ld a,00dh		;69c7
	ld (0d178h),a		;69c9   ; peticion de sonido para p01:63E1 = a
	ld (ix+015h),00fh		;69cc
	call L_69F9		;69d0
	ld hl,08bcfh		;69d3
	ld (0d9b5h),hl		;69d6   ; actor 3, byte +10 = hl
	push ix		;69d9
	call 048f9h		;69db
	pop ix		;69de
	call 04a8bh		;69e0
L_69E3:
	pop ix		;69e3
	ret			;69e5
L_69E6:
	ld (ix+015h),000h		;69e6
	ld hl,08bcfh		;69ea
	ld (ix+010h),l		;69ed
	ld (ix+011h),h		;69f0
	call 04b10h		;69f3
	pop ix		;69f6
	ret			;69f8
L_69F9:
	ld a,(iy+001h)		;69f9
	ld (ix+012h),a		;69fc
	bit 0,(iy+001h)		;69ff
	jr z,L_6A0F		;6a03
	ld a,(iy+006h)		;6a05
	sub 00ch		;6a08
	ld (ix+006h),a		;6a0a
	jr L_6A17		;6a0d
L_6A0F:
	ld a,(iy+006h)		;6a0f
	add a,01ch		;6a12
	ld (ix+006h),a		;6a14
L_6A17:
	ld a,(iy+007h)		;6a17
	add a,008h		;6a1a
	ld (ix+007h),a		;6a1c
	ld a,016h		;6a1f
	ld (ix+000h),a		;6a21
	set 3,(ix+001h)		;6a24
	ret			;6a28
L_6A29:
	call L_7D56		;6a29
	ld a,(ix+021h)		;6a2c
	and 0f0h		;6a2f
	cp 020h		;6a31
	jp z,L_69E6		;6a33
	bit 0,(ix+012h)		;6a36
	jr z,L_6A62		;6a3a
	call L_6AB7		;6a3c
	ld l,(ix+010h)		;6a3f
	ld h,(ix+011h)		;6a42
	inc hl			;6a45
	ld a,(hl)			;6a46
	cp 0ffh		;6a47
	jp z,L_69E6		;6a49
	ld a,(ix+006h)		;6a4c
	ld l,(ix+010h)		;6a4f
	ld h,(ix+011h)		;6a52
	inc hl			;6a55
	ld b,(hl)			;6a56
	sub b			;6a57
	cp 004h		;6a58
	call c,L_6AAE		;6a5a
	ld (ix+006h),a		;6a5d
	jr L_6A89		;6a60
L_6A62:
	call L_6ADB		;6a62
	ld l,(ix+010h)		;6a65
	ld h,(ix+011h)		;6a68
	inc hl			;6a6b
	ld a,(hl)			;6a6c
	cp 0ffh		;6a6d
	jp z,L_69E6		;6a6f
	ld a,(ix+006h)		;6a72
	ld l,(ix+010h)		;6a75
	ld h,(ix+011h)		;6a78
	inc hl			;6a7b
	ld b,(hl)			;6a7c
	add a,b			;6a7d
	cp 0e6h		;6a7e
	call nc,L_6AAB		;6a80
	ld (ix+006h),a		;6a83
	inc (ix+006h)		;6a86
L_6A89:
	inc hl			;6a89
	ld a,(hl)			;6a8a
	cp 0ffh		;6a8b
	jp z,L_69E6		;6a8d
	ld b,(hl)			;6a90
	ld a,(ix+007h)		;6a91
	add a,b			;6a94
	ld (ix+007h),a		;6a95
	ld (ix+010h),l		;6a98
	ld (ix+011h),h		;6a9b
	ld a,(ix+001h)		;6a9e
	and 00bh		;6aa1
	or 00ah		;6aa3
	ld (ix+001h),a		;6aa5
	jp L_6AB1		;6aa8
L_6AAB:
	ld a,0e6h		;6aab
	ret			;6aad
L_6AAE:
	ld a,004h		;6aae
	ret			;6ab0
L_6AB1:
	call 04a8bh		;6ab1
	pop ix		;6ab4
	ret			;6ab6
L_6AB7:
	ld a,(0d8fch)		;6ab7   ; a = la x de Rastan
	ld b,a			;6aba
	ld a,(0d8fdh)		;6abb   ; a = la y de Rastan
	ld c,a			;6abe
	ld d,(ix+006h)		;6abf
	ld e,(ix+007h)		;6ac2
	ld a,b			;6ac5
	add a,008h		;6ac6
	cp d			;6ac8
	ret nc			;6ac9
	add a,008h		;6aca
	cp d			;6acc
	ret c			;6acd
	ld a,c			;6ace
	sub 004h		;6acf
	cp e			;6ad1
	ret nc			;6ad2
	add a,01ch		;6ad3
	cp e			;6ad5
	ret c			;6ad6
	call L_6423		;6ad7
	ret			;6ada
L_6ADB:
	ld a,(0d8fch)		;6adb   ; a = la x de Rastan
	ld b,a			;6ade
	ld a,(0d8fdh)		;6adf   ; a = la y de Rastan
	ld c,a			;6ae2
	ld d,(ix+006h)		;6ae3
	ld e,(ix+007h)		;6ae6
	ld a,b			;6ae9
	add a,008h		;6aea
	cp d			;6aec
	ret c			;6aed
	sub 010h		;6aee
	cp d			;6af0
	ret nc			;6af1
	ld a,c			;6af2
	sub 004h		;6af3
	cp e			;6af5
	ret nc			;6af6
	add a,01ch		;6af7
	cp e			;6af9
	ret c			;6afa
	call L_6423		;6afb
	ret			;6afe
L_6AFF:
	ld a,(0d8f4h)		;6aff
	and 01eh		;6b02
	cp 004h		;6b04
	ret z			;6b06
	ld a,(0d8fch)		;6b07   ; a = la x de Rastan
	ld b,a			;6b0a
	ld a,(0d8fdh)		;6b0b   ; a = la y de Rastan
	ld c,a			;6b0e
	ld d,(ix+006h)		;6b0f
	ld e,(ix+007h)		;6b12
	ld a,b			;6b15
	add a,008h		;6b16
	cp d			;6b18
	ret nc			;6b19
	add a,008h		;6b1a
	cp d			;6b1c
	ret c			;6b1d
	ld a,c			;6b1e
	sub 004h		;6b1f
	cp e			;6b21
	ret nc			;6b22
	add a,01ch		;6b23
	cp e			;6b25
	ret c			;6b26
	call L_6423		;6b27
	xor a			;6b2a
	ret			;6b2b
L_6B2C:
	ld a,(0d8f4h)		;6b2c
	and 01eh		;6b2f
	cp 004h		;6b31
	ret z			;6b33
	ld a,(0d8fch)		;6b34   ; a = la x de Rastan
	ld b,a			;6b37
	ld a,(0d8fdh)		;6b38   ; a = la y de Rastan
	ld c,a			;6b3b
	ld d,(ix+006h)		;6b3c
	ld e,(ix+007h)		;6b3f
	ld a,b			;6b42
	add a,008h		;6b43
	cp d			;6b45
	ret c			;6b46
	sub 010h		;6b47
	cp d			;6b49
	ret nc			;6b4a
	ld a,c			;6b4b
	sub 004h		;6b4c
	cp e			;6b4e
	ret nc			;6b4f
	add a,01ch		;6b50
	cp e			;6b52
	ret c			;6b53
	call L_6423		;6b54
	xor a			;6b57
	ret			;6b58
L_6B59:
	ld a,(ix+00fh)		;6b59
	and a			;6b5c
	jp z,L_7AAF		;6b5d
	ld a,(0da06h)		;6b60   ; a = actor 5, byte +15
	cp 00fh		;6b63
	call z,L_6BFA		;6b65
	bit 1,(ix+001h)		;6b68
	call nz,L_6BFA		;6b6c
	call L_7B29		;6b6f
	and a			;6b72
	jp z,L_7E18		;6b73
	call L_7EBD		;6b76
	cp 0ffh		;6b79
	jp z,L_7E4B		;6b7b
	ld a,(ix+006h)		;6b7e
	cp 001h		;6b81
	call c,L_7E97		;6b83
	cp 0dch		;6b86
	call nc,L_7EA0		;6b88
	call L_7D56		;6b8b
	bit 0,(ix+001h)		;6b8e
	jr z,L_6BAA		;6b92
	ld a,(ix+018h)		;6b94
	and 0f0h		;6b97
	cp 020h		;6b99
	jp z,L_6BCF		;6b9b
	ld a,(ix+01ch)		;6b9e
	and 0f0h		;6ba1
	cp 020h		;6ba3
	jp nz,L_6BCF		;6ba5
	jr L_6BBE		;6ba8
L_6BAA:
	ld a,(ix+01ah)		;6baa
	and 0f0h		;6bad
	cp 020h		;6baf
	jp z,L_6BCF		;6bb1
	ld a,(ix+01eh)		;6bb4
	and 0f0h		;6bb7
	cp 020h		;6bb9
	jp nz,L_6BCF		;6bbb
L_6BBE:
	call L_7CC6		;6bbe
	cp 040h		;6bc1
	jr nc,L_6BD8		;6bc3
	jp L_7B48		;6bc5
L_6BC8:
	res 1,(ix+001h)		;6bc8
	jp 04a8bh		;6bcc
L_6BCF:
	call L_7CC6		;6bcf
	cp 040h		;6bd2
	jr nc,L_6BD8		;6bd4
	jr L_6BC8		;6bd6
L_6BD8:
	ld a,(0da06h)		;6bd8   ; a = actor 5, byte +15
	cp 00fh		;6bdb
	jr z,L_6BC8		;6bdd
	call L_7CFB		;6bdf
	cp 020h		;6be2
	jp nc,L_6BC8		;6be4
	set 1,(ix+001h)		;6be7
	push ix		;6beb
	call 04a8bh		;6bed
	pop ix		;6bf0
	ld a,(ix+015h)		;6bf2
	and a			;6bf5
	jp z,L_6BFA		;6bf6
	ret			;6bf9
L_6BFA:
	push ix		;6bfa
	push ix		;6bfc
	pop iy		;6bfe
	ld ix,0d9f1h		;6c00   ; ix -> actor 5
	ld a,(ix+015h)		;6c04
	cp 000h		;6c07
	jp z,L_6C10		;6c09
	cp 00fh		;6c0c
	jr L_6C27		;6c0e
L_6C10:
	bit 7,(iy+002h)		;6c10
	jp z,L_6C24		;6c14
	ld (ix+015h),00fh		;6c17
	call L_6C30		;6c1b
	call 048f9h		;6c1e
	call 04a8bh		;6c21
L_6C24:
	pop ix		;6c24
	ret			;6c26
L_6C27:
	jp L_6C66		;6c27
L_6C2A:
	call 04a8bh		;6c2a
	pop ix		;6c2d
	ret			;6c2f
L_6C30:
	ld (ix+001h),015h		;6c30
	ld a,(iy+001h)		;6c34
	ld (ix+013h),a		;6c37
	bit 0,(iy+001h)		;6c3a
	jr z,L_6C4E		;6c3e
	set 0,(ix+012h)		;6c40
	ld a,(iy+006h)		;6c44
	sub 00ch		;6c47
	ld (ix+006h),a		;6c49
	jr L_6C5A		;6c4c
L_6C4E:
	res 0,(ix+001h)		;6c4e
	ld a,(iy+006h)		;6c52
	add a,01ch		;6c55
	ld (ix+006h),a		;6c57
L_6C5A:
	ld a,(iy+007h)		;6c5a
	ld (ix+007h),a		;6c5d
	ld a,016h		;6c60
	ld (ix+000h),a		;6c62
	ret			;6c65
L_6C66:
	call L_7D56		;6c66
	ld a,(ix+020h)		;6c69
	and 0f0h		;6c6c
	cp 020h		;6c6e
	jp z,L_6CB2		;6c70
	ld a,(0d8fch)		;6c73   ; a = la x de Rastan
	add a,008h		;6c76
	ld c,a			;6c78
	bit 0,(ix+013h)		;6c79
	jr z,L_6C96		;6c7d
	call L_6AFF		;6c7f
	and a			;6c82
	jp z,L_6CB2		;6c83
	ld a,(ix+006h)		;6c86
	dec a			;6c89
	dec a			;6c8a
	dec a			;6c8b
	cp 004h		;6c8c
	jp c,L_6CB2		;6c8e
	ld (ix+006h),a		;6c91
	jr L_6CAF		;6c94
L_6C96:
	res 0,(ix+001h)		;6c96
	call L_6B2C		;6c9a
	and a			;6c9d
	jp z,L_6CB2		;6c9e
	ld a,(ix+006h)		;6ca1
	inc a			;6ca4
	inc a			;6ca5
	inc a			;6ca6
	cp 0f0h		;6ca7
	jp nc,L_6CB2		;6ca9
	ld (ix+006h),a		;6cac
L_6CAF:
	jp L_6C2A		;6caf
L_6CB2:
	ld ix,0d9f1h		;6cb2   ; ix -> actor 5
	ld (ix+015h),000h		;6cb6
	call 04b10h		;6cba
	pop ix		;6cbd
	ret			;6cbf
L_6CC0:
	ld ix,0d9f1h		;6cc0   ; ix -> actor 5
	call 04b10h		;6cc4
	pop ix		;6cc7
	ret			;6cc9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x6cca..0x6cdc  (18 bytes)
DATA_6CCA:
	defb 03ah,0fdh,0d8h,0ddh,046h,007h,090h,0e6h,07fh,0feh,008h,038h,002h,0afh,0c9h,03eh	; 6cca  :...F......8...>
	defb 0ffh,0c9h	; 6cda

; ======================================================================
; CODIGO 0x6cdc..0x703d  (865 bytes)
; ======================================================================


L_6CDC:
	ld a,(ix+00fh)		;6cdc
	and a			;6cdf
	jp z,L_7AAF		;6ce0
	ld a,(0d9e0h)		;6ce3   ; a = actor 4, byte +15
	cp 00fh		;6ce6
	call z,L_6DCA		;6ce8
	bit 1,(ix+001h)		;6ceb
	call nz,L_6DCA		;6cef
	call L_7B29		;6cf2
	and a			;6cf5
	call z,L_7E18		;6cf6
	call L_7EBD		;6cf9
	cp 0ffh		;6cfc
	jp z,L_7E4B		;6cfe
	call L_7CC6		;6d01
	cp 050h		;6d04
	jp z,L_6D4E		;6d06
	jp c,L_6D56		;6d09
	bit 0,(ix+001h)		;6d0c
	jr z,L_6D29		;6d10
	ld a,(ix+01ch)		;6d12
	and 00fh		;6d15
	cp 001h		;6d17
	jp z,L_6D4E		;6d19
	ld a,(ix+018h)		;6d1c
	and 0f0h		;6d1f
	cp 020h		;6d21
	jp z,L_6D4E		;6d23
	jp L_6D3C		;6d26
L_6D29:
	ld a,(ix+01dh)		;6d29
	and 00fh		;6d2c
	cp 001h		;6d2e
	jp z,L_6D4E		;6d30
	ld a,(ix+019h)		;6d33
	and 0f0h		;6d36
	cp 020h		;6d38
	jr z,L_6D4E		;6d3a
L_6D3C:
	ld a,(0d9e0h)		;6d3c   ; a = actor 4, byte +15
	and a			;6d3f
	jp nz,L_6D4E		;6d40
	call L_7E83		;6d43
	res 1,(ix+001h)		;6d46
	call 04a8bh		;6d4a
	ret			;6d4d
L_6D4E:
	res 1,(ix+001h)		;6d4e
	call 04a8bh		;6d52
	ret			;6d55
L_6D56:
	ld a,(ix+006h)		;6d56
	cp 010h		;6d59
	jp c,L_6DA6		;6d5b
	cp 0dch		;6d5e
	jp nc,L_6DA6		;6d60
	bit 0,(ix+001h)		;6d63
	jp z,L_6D88		;6d67
	ld a,(ix+01ah)		;6d6a
	and 0f0h		;6d6d
	cp 020h		;6d6f
	jp z,L_6DA6		;6d71
	ld a,(ix+01eh)		;6d74
	and 0f0h		;6d77
	cp 020h		;6d79
	jp nz,L_6DA6		;6d7b
	res 1,(ix+001h)		;6d7e
	call L_7D0F		;6d82
	jp 04a8bh		;6d85
L_6D88:
	ld a,(ix+017h)		;6d88
	and 0f0h		;6d8b
	cp 020h		;6d8d
	jp z,L_6DA6		;6d8f
	ld a,(ix+01bh)		;6d92
	and 0f0h		;6d95
	cp 020h		;6d97
	jp nz,L_6DA6		;6d99
	res 1,(ix+001h)		;6d9c
	call L_7D0F		;6da0
	jp 04a8bh		;6da3
L_6DA6:
	ld a,(0d9e0h)		;6da6   ; a = actor 4, byte +15
	cp 00fh		;6da9
	jr z,L_6DBF		;6dab
	set 1,(ix+001h)		;6dad
	push ix		;6db1
	call 04a8bh		;6db3
	pop ix		;6db6
	ld a,(ix+015h)		;6db8
	and a			;6dbb
	jp z,L_6DCA		;6dbc
L_6DBF:
	res 1,(ix+001h)		;6dbf
	jp 04a8bh		;6dc3
L_6DC6:
	call L_7E18		;6dc6
	ret			;6dc9
L_6DCA:
	push ix		;6dca
	push ix		;6dcc
	pop iy		;6dce
	ld ix,0d9cbh		;6dd0   ; ix -> actor 4
	ld a,(ix+015h)		;6dd4
	cp 000h		;6dd7
	jp z,L_6DE0		;6dd9
	cp 00fh		;6ddc
	jr L_6E37		;6dde
L_6DE0:
	bit 7,(iy+002h)		;6de0
	jp z,L_6DF4		;6de4
	ld (ix+015h),00fh		;6de7
	call L_6E07		;6deb
	call 048f9h		;6dee
	call 04a8bh		;6df1
L_6DF4:
	pop ix		;6df4
	ret			;6df6
L_6DF7:
	call 04a8bh		;6df7
	pop ix		;6dfa
	ret			;6dfc
L_6DFD:
	ld (ix+015h),000h		;6dfd
	call 04b10h		;6e01
	pop ix		;6e04
	ret			;6e06
L_6E07:
	ld (ix+001h),013h		;6e07
	bit 0,(iy+001h)		;6e0b
	jr z,L_6E1F		;6e0f
	set 0,(ix+012h)		;6e11
	ld a,(iy+006h)		;6e15
	sub 010h		;6e18
	ld (ix+006h),a		;6e1a
	jr L_6E2B		;6e1d
L_6E1F:
	res 0,(ix+001h)		;6e1f
	ld a,(iy+006h)		;6e23
	add a,020h		;6e26
	ld (ix+006h),a		;6e28
L_6E2B:
	ld a,(iy+007h)		;6e2b
	ld (ix+007h),a		;6e2e
	ld a,016h		;6e31
	ld (ix+000h),a		;6e33
	ret			;6e36
L_6E37:
	call L_7D56		;6e37
	ld a,(ix+020h)		;6e3a
	and 0f0h		;6e3d
	cp 020h		;6e3f
	jp z,L_6E7D		;6e41
	ld a,(0d8fch)		;6e44   ; a = la x de Rastan
	add a,008h		;6e47
	ld c,a			;6e49
	bit 0,(ix+001h)		;6e4a
	jr z,L_6E66		;6e4e
	call L_6AFF		;6e50
	and a			;6e53
	jp z,L_6E7D		;6e54
	ld a,(ix+006h)		;6e57
	dec a			;6e5a
	dec a			;6e5b
	cp 004h		;6e5c
	jp c,L_6E7D		;6e5e
	ld (ix+006h),a		;6e61
	jr L_6E7A		;6e64
L_6E66:
	call L_6B2C		;6e66
	and a			;6e69
	jp z,L_6E7D		;6e6a
	ld a,(ix+006h)		;6e6d
	inc a			;6e70
	inc a			;6e71
	cp 0f0h		;6e72
	jp nc,L_6E7D		;6e74
	ld (ix+006h),a		;6e77
L_6E7A:
	jp L_6DF7		;6e7a
L_6E7D:
	ld ix,0d9cbh		;6e7d   ; ix -> actor 4
	ld (ix+015h),000h		;6e81
	call 04b10h		;6e85
	pop ix		;6e88
	ret			;6e8a
L_6E8B:
	ld ix,0d9cbh		;6e8b   ; ix -> actor 4
	call 04b10h		;6e8f
	pop ix		;6e92
	ret			;6e94
L_6E95:
	ld a,(ix+00fh)		;6e95
	and a			;6e98
	jp z,L_7AAF		;6e99
	ld a,r		;6e9c
	and 052h		;6e9e
	jp po,04a8bh		;6ea0
	ld a,(ix+012h)		;6ea3
	and a			;6ea6
	jp nz,L_700A		;6ea7
	ld a,(ix+011h)		;6eaa
	and a			;6ead
	jp nz,L_701C		;6eae
	ld a,(ix+010h)		;6eb1
	and a			;6eb4
	jr z,L_6ED1		;6eb5
	dec a			;6eb7
	ld (ix+010h),a		;6eb8
	ld a,(ix+007h)		;6ebb
	dec a			;6ebe
	dec a			;6ebf
	ld (ix+007h),a		;6ec0
	res 1,(ix+001h)		;6ec3
	res 2,(ix+001h)		;6ec7
	call L_7E83		;6ecb
	jp 04a8bh		;6ece
L_6ED1:
	call L_7B29		;6ed1
	and a			;6ed4
	call z,L_7E18		;6ed5
	call L_7EBD		;6ed8
	cp 0ffh		;6edb
	jp z,L_7E4B		;6edd
	ld a,(ix+006h)		;6ee0
	cp 001h		;6ee3
	call c,L_7E97		;6ee5
	cp 0dch		;6ee8
	call nc,L_7EA0		;6eea
	call L_7CC6		;6eed
	cp 004h		;6ef0
	jp c,L_6FAD		;6ef2
	call L_7D56		;6ef5
	bit 0,(ix+001h)		;6ef8
	jr z,L_6F48		;6efc
	ld a,(ix+018h)		;6efe
	and 0f0h		;6f01
	cp 020h		;6f03
	push af			;6f05
	call z,L_7E18		;6f06
	pop af			;6f09
	jp z,L_6FCB		;6f0a
	ld a,(ix+01bh)		;6f0d
	and 00fh		;6f10
	cp 002h		;6f12
	jp z,L_705C		;6f14
L_6F17:
	ld a,(ix+01ch)		;6f17
	and 00fh		;6f1a
	cp 00fh		;6f1c
	jp z,L_6F8F		;6f1e
	cp 001h		;6f21
	jp z,L_7E18		;6f23
	cp 002h		;6f26
	jp z,L_6FCE		;6f28
	cp 003h		;6f2b
	jp z,L_6FCE		;6f2d
	cp 004h		;6f30
	jp z,L_6F97		;6f32
	cp 005h		;6f35
	jp z,L_6FF0		;6f37
	cp 006h		;6f3a
	jp z,L_6FF0		;6f3c
	jp nc,L_703F		;6f3f
L_6F42:
	call L_7E18		;6f42
	jp L_6F8F		;6f45
L_6F48:
	ld a,(ix+019h)		;6f48
	and 0f0h		;6f4b
	cp 020h		;6f4d
	push af			;6f4f
	call z,L_7E18		;6f50
	pop af			;6f53
	jp z,L_6FCB		;6f54
	ld a,(ix+01eh)		;6f57
	and 00fh		;6f5a
	cp 002h		;6f5c
	jp z,L_7069		;6f5e
L_6F61:
	ld a,(ix+01dh)		;6f61
	and 00fh		;6f64
	cp 00fh		;6f66
	jp z,L_6F8F		;6f68
	cp 001h		;6f6b
	jp z,L_7E18		;6f6d
	cp 002h		;6f70
	jp z,L_6FDF		;6f72
	cp 003h		;6f75
	jp z,L_6FDF		;6f77
	cp 004h		;6f7a
	jp z,L_6F97		;6f7c
	cp 005h		;6f7f
	jp z,L_6FF0		;6f81
	cp 006h		;6f84
	jp z,L_6FF0		;6f86
	jp nc,L_7046		;6f89
L_6F8C:
	call L_7E18		;6f8c
L_6F8F:
	call L_7CC6		;6f8f
	cp 030h		;6f92
	jp c,L_6FAD		;6f94
L_6F97:
	res 1,(ix+001h)		;6f97
	res 2,(ix+001h)		;6f9b
L_6F9F:
	res 2,(ix+001h)		;6f9f
	res 3,(ix+001h)		;6fa3
	call L_7E83		;6fa7
	jp 04a8bh		;6faa
L_6FAD:
	call L_7B29		;6fad
	and a			;6fb0
	call z,L_7E18		;6fb1
	call L_7CFB		;6fb4
	cp 018h		;6fb7
	jp nc,L_6FCB		;6fb9
	set 1,(ix+001h)		;6fbc
	res 2,(ix+001h)		;6fc0
	res 3,(ix+001h)		;6fc4
	jp 04a8bh		;6fc8
L_6FCB:
	jp 04a8bh		;6fcb
L_6FCE:
	ld a,(ix+017h)		;6fce
	and 0f0h		;6fd1
	cp 020h		;6fd3
	jp nz,L_6F97		;6fd5
L_6FD8:
	ld (ix+010h),00ch		;6fd8
	jp L_6F97		;6fdc
L_6FDF:
	ld a,(ix+01ah)		;6fdf
	and 0f0h		;6fe2
	cp 020h		;6fe4
	jp nz,L_6F97		;6fe6
	ld (ix+010h),00ch		;6fe9
	jp L_6F97		;6fed
L_6FF0:
	res 1,(ix+001h)		;6ff0
	res 2,(ix+001h)		;6ff4
	set 3,(ix+001h)		;6ff8
	ld (ix+011h),010h		;6ffc
	jp L_6FCB		;7000
L_7003:
	ld (ix+012h),010h		;7003
	jp L_6FCB		;7007
L_700A:
	ld a,(ix+007h)		;700a
	inc a			;700d
	inc a			;700e
	ld (ix+007h),a		;700f
	ld a,(ix+012h)		;7012
	dec a			;7015
	ld (ix+012h),a		;7016
	jp L_6F9F		;7019
L_701C:
	res 1,(ix+001h)		;701c
	ld a,(ix+007h)		;7020
	dec a			;7023
	dec a			;7024
	ld (ix+007h),a		;7025
	ld a,(ix+011h)		;7028
	dec a			;702b
	ld (ix+011h),a		;702c
	and a			;702f
	jp z,L_7036		;7030
	jp L_6F9F		;7033
L_7036:
	ld (ix+012h),010h		;7036
	jp L_6F9F		;703a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x703d..0x703f  (2 bytes)
DATA_703D:
	defb 0c9h,0c9h	; 703d

; ======================================================================
; CODIGO 0x703f..0x730c  (717 bytes)
; ======================================================================


L_703F:
	cp 00fh		;703f
	jp z,L_6F42		;7041
	jr L_704E		;7044
L_7046:
	cp 00fh		;7046
	jp z,L_6F8C		;7048
	jp L_704E		;704b
L_704E:
	call L_7E18		;704e
	call L_7CC6		;7051
	cp 030h		;7054
	jp c,L_6FAD		;7056
	jp L_6FCB		;7059
L_705C:
	ld a,(ix+017h)		;705c
	and 0f0h		;705f
	cp 020h		;7061
	jp z,L_6FD8		;7063
	jp L_6F17		;7066
L_7069:
	ld a,(ix+01ah)		;7069
	and 0f0h		;706c
	cp 020h		;706e
	jp z,L_6FD8		;7070
	jp L_6F61		;7073
L_7076:
	ld a,(ix+00fh)		;7076
	and a			;7079
	jp z,L_7AAF		;707a
	ld a,(ix+006h)		;707d
	cp 002h		;7080
	call c,L_7E18		;7082
	cp 0f0h		;7085
	call nc,L_7E18		;7087
	call L_7D56		;708a
	bit 0,(ix+001h)		;708d
	jr z,L_70A9		;7091
	ld a,(ix+018h)		;7093
	and 0f0h		;7096
	cp 020h		;7098
	call z,L_7E18		;709a
	ld a,(ix+01bh)		;709d
	and 0f0h		;70a0
	cp 020h		;70a2
	call nz,L_7E18		;70a4
	jr L_70BD		;70a7
L_70A9:
	ld a,(ix+019h)		;70a9
	and 0f0h		;70ac
	cp 020h		;70ae
	call z,L_7E18		;70b0
	ld a,(ix+01eh)		;70b3
	and 0f0h		;70b6
	cp 020h		;70b8
	call nz,L_7E18		;70ba
L_70BD:
	call L_7E83		;70bd
	call L_7E83		;70c0
	jp 04a8bh		;70c3
L_70C6:
	ld a,(ix+00fh)		;70c6
	and a			;70c9
	jp z,L_7AAF		;70ca
	call L_7B29		;70cd
	and a			;70d0
	jp z,L_7E18		;70d1
	call L_7ED7		;70d4
	cp 0ffh		;70d7
	jp z,L_7E4B		;70d9
	jp z,L_7E4B		;70dc
	ld a,(ix+006h)		;70df
	cp 001h		;70e2
	call c,L_7E97		;70e4
	cp 0efh		;70e7
	call nc,L_7EA0		;70e9
	call L_7D56		;70ec
	bit 0,(ix+001h)		;70ef
	jr z,L_7112		;70f3
	ld a,(ix+018h)		;70f5
	and 00fh		;70f8
	cp 001h		;70fa
	jp z,L_7146		;70fc
	cp 002h		;70ff
	jr nc,L_716E		;7101
L_7103:
	cp 005h		;7103
	jr nc,L_7159		;7105
L_7107:
	ld a,(ix+020h)		;7107
	and 0f0h		;710a
	cp 020h		;710c
	jr z,L_7146		;710e
	jr L_712C		;7110
L_7112:
	ld a,(ix+019h)		;7112
	and 00fh		;7115
	cp 001h		;7117
	jr z,L_7146		;7119
	cp 002h		;711b
	jr nc,L_715F		;711d
L_711F:
	cp 005h		;711f
	jr nc,L_7153		;7121
L_7123:
	ld a,(ix+021h)		;7123
	and 0f0h		;7126
	cp 020h		;7128
	jr z,L_7146		;712a
L_712C:
	call L_7CDD		;712c
	cp 010h		;712f
	jr c,L_7143		;7131
	call L_7E83		;7133
	call L_7E83		;7136
	res 1,(ix+001h)		;7139
	jp 04a8bh		;713d
L_7140:
	jp 04a8bh		;7140
L_7143:
	jp L_7EB5		;7143
L_7146:
	call L_7CDD		;7146
	cp 010h		;7149
	jr c,L_7143		;714b
	res 1,(ix+001h)		;714d
	jr L_7140		;7151
L_7153:
	cp 00fh		;7153
	jr z,L_7123		;7155
	jr L_7146		;7157
L_7159:
	cp 00fh		;7159
	jr z,L_7107		;715b
	jr L_7146		;715d
L_715F:
	cp 005h		;715f
	jr nc,L_711F		;7161
	ld a,(ix+022h)		;7163
	and 0f0h		;7166
	cp 0f0h		;7168
	jr z,L_712C		;716a
	jr L_7146		;716c
L_716E:
	cp 005h		;716e
	jr nc,L_7103		;7170
	ld a,(ix+01fh)		;7172
	and 0f0h		;7175
	cp 0f0h		;7177
	jr z,L_712C		;7179
	jr L_7146		;717b
L_717D:
	bit 2,(ix+001h)		;717d
	jp nz,L_7345		;7181
	ld a,(ix+014h)		;7184
	and a			;7187
	jp z,L_7345		;7188
L_718B:
	ld a,(ix+00fh)		;718b
	and a			;718e
	jp z,L_7AAF		;718f
	ld a,r		;7192
	and 076h		;7194
	jp po,04a8bh		;7196
	ld a,(ix+012h)		;7199
	and a			;719c
	jp nz,L_72D9		;719d
	ld a,(ix+011h)		;71a0
	and a			;71a3
	jp nz,L_72EB		;71a4
	ld a,(ix+010h)		;71a7
	and a			;71aa
	jr z,L_71C3		;71ab
	dec a			;71ad
	ld (ix+010h),a		;71ae
	ld a,(ix+007h)		;71b1
	dec a			;71b4
	dec a			;71b5
	ld (ix+007h),a		;71b6
	res 1,(ix+001h)		;71b9
	call L_7E83		;71bd
	jp 04a8bh		;71c0
L_71C3:
	call L_7EBD		;71c3
	cp 0ffh		;71c6
	jp z,L_7E4B		;71c8
	ld a,(ix+006h)		;71cb
	cp 001h		;71ce
	call c,L_7E97		;71d0
	cp 0dch		;71d3
	call nc,L_7EA0		;71d5
	call L_7CC6		;71d8
	cp 004h		;71db
	jp c,L_728C		;71dd
	call L_7D56		;71e0
	bit 0,(ix+001h)		;71e3
	jr z,L_7233		;71e7
	ld a,(ix+018h)		;71e9
	and 0f0h		;71ec
	cp 020h		;71ee
	push af			;71f0
	call z,L_7E18		;71f1
	pop af			;71f4
	jp z,L_72A2		;71f5
	ld a,(ix+01bh)		;71f8
	and 00fh		;71fb
	cp 002h		;71fd
	jp z,L_732B		;71ff
L_7202:
	ld a,(ix+01ch)		;7202
	and 00fh		;7205
	cp 00fh		;7207
	jp z,L_727A		;7209
	cp 001h		;720c
	jp z,L_7E18		;720e
	cp 002h		;7211
	jp z,L_72A5		;7213
	cp 003h		;7216
	jp z,L_72A5		;7218
	cp 004h		;721b
	jp z,L_7282		;721d
	cp 005h		;7220
	jp z,L_72C7		;7222
	cp 006h		;7225
	jp z,L_72C7		;7227
	jp nc,L_730E		;722a
L_722D:
	call L_7E18		;722d
	jp L_727A		;7230
L_7233:
	ld a,(ix+019h)		;7233
	and 0f0h		;7236
	cp 020h		;7238
	push af			;723a
	call z,L_7E18		;723b
	pop af			;723e
	jp z,L_72A2		;723f
	ld a,(ix+01eh)		;7242
	and 00fh		;7245
	cp 002h		;7247
	jp z,L_7338		;7249
L_724C:
	ld a,(ix+01dh)		;724c
	and 00fh		;724f
	cp 00fh		;7251
	jp z,L_727A		;7253
	cp 001h		;7256
	jp z,L_7E18		;7258
	cp 002h		;725b
	jp z,L_72B6		;725d
	cp 003h		;7260
	jp z,L_72B6		;7262
	cp 004h		;7265
	jp z,L_7282		;7267
	cp 005h		;726a
	jp z,L_72C7		;726c
	cp 006h		;726f
	jp z,L_72C7		;7271
	jp nc,L_7315		;7274
L_7277:
	call L_7E18		;7277
L_727A:
	call L_7CC6		;727a
	cp 030h		;727d
	jp c,L_728C		;727f
L_7282:
	res 1,(ix+001h)		;7282
L_7286:
	call L_7E83		;7286
	jp 04a8bh		;7289
L_728C:
	call L_7B29		;728c
	and a			;728f
	call z,L_7E18		;7290
	call L_7CFB		;7293
	cp 018h		;7296
	jp nc,L_72A2		;7298
	set 1,(ix+001h)		;729b
	jp 04a8bh		;729f
L_72A2:
	jp 04a8bh		;72a2
L_72A5:
	ld a,(ix+017h)		;72a5
	and 0f0h		;72a8
	cp 020h		;72aa
	jp nz,L_7282		;72ac
L_72AF:
	ld (ix+010h),00ch		;72af
	jp L_7282		;72b3
L_72B6:
	ld a,(ix+01ah)		;72b6
	and 0f0h		;72b9
	cp 020h		;72bb
	jp nz,L_7282		;72bd
	ld (ix+010h),00ch		;72c0
	jp L_7282		;72c4
L_72C7:
	res 1,(ix+001h)		;72c7
	ld (ix+011h),010h		;72cb
	jp L_72A2		;72cf
L_72D2:
	ld (ix+012h),010h		;72d2
	jp L_72A2		;72d6
L_72D9:
	ld a,(ix+007h)		;72d9
	inc a			;72dc
	inc a			;72dd
	ld (ix+007h),a		;72de
	ld a,(ix+012h)		;72e1
	dec a			;72e4
	ld (ix+012h),a		;72e5
	jp L_7286		;72e8
L_72EB:
	res 1,(ix+001h)		;72eb
	ld a,(ix+007h)		;72ef
	dec a			;72f2
	dec a			;72f3
	ld (ix+007h),a		;72f4
	ld a,(ix+011h)		;72f7
	dec a			;72fa
	ld (ix+011h),a		;72fb
	and a			;72fe
	jp z,L_7305		;72ff
	jp L_7286		;7302
L_7305:
	ld (ix+012h),010h		;7305
	jp L_7286		;7309

; ----------------------------------------------------------------------
; DATOS sin identificar  0x730c..0x730e  (2 bytes)
DATA_730C:
	defb 0c9h,0c9h	; 730c

; ======================================================================
; CODIGO 0x730e..0x76b8  (938 bytes)
; ======================================================================


L_730E:
	cp 00fh		;730e
	jp z,L_722D		;7310
	jr L_731D		;7313
L_7315:
	cp 00fh		;7315
	jp z,L_7277		;7317
	jp L_731D		;731a
L_731D:
	call L_7E18		;731d
	call L_7CC6		;7320
	cp 030h		;7323
	jp c,L_728C		;7325
	jp L_72A2		;7328
L_732B:
	ld a,(ix+017h)		;732b
	and 0f0h		;732e
	cp 020h		;7330
	jp z,L_72AF		;7332
	jp L_7202		;7335
L_7338:
	ld a,(ix+01ah)		;7338
	and 0f0h		;733b
	cp 020h		;733d
	jp z,L_72AF		;733f
	jp L_724C		;7342
L_7345:
	set 0,(ix+001h)		;7345
	set 2,(ix+001h)		;7349
	ld a,(ix+002h)		;734d
	and 07fh		;7350
	cp 004h		;7352
	jr z,L_735D		;7354
	ld (ix+014h),000h		;7356
	jp 04a8bh		;735a
L_735D:
	res 2,(ix+001h)		;735d
	ld (ix+014h),0ffh		;7361
	jp L_718B		;7365
L_7368:
	ld a,(ix+00fh)		;7368
	and a			;736b
	jp z,L_7AAF		;736c
	ld a,(0d9bah)		;736f   ; a = actor 3, byte +15
	cp 00fh		;7372
	call z,L_7420		;7374
	bit 1,(ix+001h)		;7377
	call nz,L_7420		;737b
	call L_7B29		;737e
	and a			;7381
	jp z,L_7E18		;7382
	call L_7EBD		;7385
	cp 0ffh		;7388
	jp z,L_7E4B		;738a
	ld a,(ix+006h)		;738d
	cp 001h		;7390
	call c,L_7E97		;7392
	cp 0efh		;7395
	call nc,L_7EA0		;7397
	call L_7D56		;739a
	bit 0,(ix+001h)		;739d
	jr z,L_73B9		;73a1
	ld a,(ix+017h)		;73a3
	and 0f0h		;73a6
	cp 020h		;73a8
	jp z,L_73D7		;73aa
	ld a,(ix+01ch)		;73ad
	and 0f0h		;73b0
	cp 020h		;73b2
	jp nz,L_73D7		;73b4
	jr L_73CD		;73b7
L_73B9:
	ld a,(ix+01ah)		;73b9
	and 0f0h		;73bc
	cp 020h		;73be
	jp z,L_73D7		;73c0
	ld a,(ix+01eh)		;73c3
	and 0f0h		;73c6
	cp 020h		;73c8
	jp nz,L_73D7		;73ca
L_73CD:
	call L_7CC6		;73cd
	cp 040h		;73d0
	jr c,L_73E2		;73d2
L_73D4:
	jp L_7B64		;73d4
L_73D7:
	call L_7CFB		;73d7
	cp 020h		;73da
	jp nc,L_73DF		;73dc
L_73DF:
	jp 04a8bh		;73df
L_73E2:
	cp 020h		;73e2
	jr nc,L_73E8		;73e4
	jr L_73D4		;73e6
L_73E8:
	ld a,(0d9bah)		;73e8   ; a = actor 3, byte +15
	cp 00fh		;73eb
	jr z,L_7411		;73ed
	call L_7CFB		;73ef
	cp 020h		;73f2
	jp nc,L_73DF		;73f4
	set 1,(ix+001h)		;73f7
	res 2,(ix+001h)		;73fb
	res 3,(ix+001h)		;73ff
	push ix		;7403
	call 04a8bh		;7405
	pop ix		;7408
	ld a,(0d9bah)		;740a   ; a = actor 3, byte +15
	and a			;740d
	jp z,L_7420		;740e
L_7411:
	res 1,(ix+001h)		;7411
	res 2,(ix+001h)		;7415
	res 3,(ix+001h)		;7419
	jp 04a8bh		;741d
L_7420:
	push ix		;7420
	push ix		;7422
	pop iy		;7424
	ld ix,0d9a5h		;7426   ; ix -> actor 3
	ld a,(ix+015h)		;742a
	cp 000h		;742d
	jp z,L_7436		;742f
	cp 00fh		;7432
	jr L_744D		;7434
L_7436:
	bit 7,(iy+002h)		;7436
	jp z,L_744A		;743a
	ld (ix+015h),00fh		;743d
	call L_7460		;7441
	call 048f9h		;7444
	call 04a8bh		;7447
L_744A:
	pop ix		;744a
	ret			;744c
L_744D:
	jp L_7496		;744d
L_7450:
	call 04a8bh		;7450
	pop ix		;7453
	ret			;7455
L_7456:
	ld (ix+015h),000h		;7456
	call 04b10h		;745a
	pop ix		;745d
	ret			;745f
L_7460:
	ld (ix+001h),00fh		;7460
	ld a,(iy+001h)		;7464
	ld (ix+013h),a		;7467
	bit 0,(iy+001h)		;746a
	jr z,L_747E		;746e
	set 0,(ix+012h)		;7470
	ld a,(iy+006h)		;7474
	sub 008h		;7477
	ld (ix+006h),a		;7479
	jr L_748A		;747c
L_747E:
	res 0,(ix+001h)		;747e
	ld a,(iy+006h)		;7482
	add a,018h		;7485
	ld (ix+006h),a		;7487
L_748A:
	ld a,(iy+007h)		;748a
	ld (ix+007h),a		;748d
	ld a,016h		;7490
	ld (ix+000h),a		;7492
	ret			;7495
L_7496:
	ld (ix+001h),00fh		;7496
	call L_7D56		;749a
	ld a,(ix+020h)		;749d
	and 0f0h		;74a0
	cp 020h		;74a2
	jp z,L_74E4		;74a4
	ld a,(0d8fch)		;74a7   ; a = la x de Rastan
	add a,008h		;74aa
	ld c,a			;74ac
	bit 0,(ix+013h)		;74ad
	jr z,L_74C9		;74b1
	call L_6AFF		;74b3
	and a			;74b6
	jp z,L_74E4		;74b7
	ld a,(ix+006h)		;74ba
	dec a			;74bd
	dec a			;74be
	cp 004h		;74bf
	jp c,L_74E4		;74c1
	ld (ix+006h),a		;74c4
	jr L_74E1		;74c7
L_74C9:
	res 0,(ix+001h)		;74c9
	call L_6B2C		;74cd
	and a			;74d0
	jp z,L_74E4		;74d1
	ld a,(ix+006h)		;74d4
	inc a			;74d7
	inc a			;74d8
	cp 0f0h		;74d9
	jp nc,L_74E4		;74db
	ld (ix+006h),a		;74de
L_74E1:
	jp L_7450		;74e1
L_74E4:
	ld ix,0d9a5h		;74e4   ; ix -> actor 3
	ld (ix+015h),000h		;74e8
	call 04b10h		;74ec
	pop ix		;74ef
	ret			;74f1
L_74F2:
	ld ix,0d9a5h		;74f2   ; ix -> actor 3
	call 04b10h		;74f6
	pop ix		;74f9
	ret			;74fb
L_74FC:
	ld a,(ix+00fh)		;74fc
	and a			;74ff
	jp z,L_7AAF		;7500
	ld a,r		;7503
	jp po,04a8bh		;7505
	ld hl,0d8f4h		;7508
	ld a,(hl)			;750b
	and 01eh		;750c
	cp 004h		;750e
	jr nz,L_7518		;7510
	set 2,(ix+001h)		;7512
	jr L_751C		;7516
L_7518:
	res 2,(ix+001h)		;7518
L_751C:
	ld a,(ix+012h)		;751c
	and a			;751f
	jp nz,L_767F		;7520
	ld a,(ix+011h)		;7523
	and a			;7526
	jp nz,L_7690		;7527
	ld a,(ix+010h)		;752a
	and a			;752d
	jr z,L_754D		;752e
	dec a			;7530
	ld (ix+010h),a		;7531
	ld a,(ix+007h)		;7534
	dec a			;7537
	ld (ix+007h),a		;7538
	set 3,(ix+001h)		;753b
	res 2,(ix+001h)		;753f
	res 1,(ix+001h)		;7543
	call L_7E83		;7547
	jp 04a8bh		;754a
L_754D:
	res 2,(ix+001h)		;754d
	call L_7EBD		;7551
	cp 0ffh		;7554
	jp z,L_7E4B		;7556
	ld a,(ix+006h)		;7559
	cp 001h		;755c
	call c,L_7E97		;755e
	cp 0dch		;7561
	call nc,L_7EA0		;7563
	call L_7CC6		;7566
	cp 004h		;7569
	jp c,L_7622		;756b
	call L_7D56		;756e
	bit 0,(ix+001h)		;7571
	jr z,L_75C1		;7575
	ld a,(ix+018h)		;7577
	and 0f0h		;757a
	cp 020h		;757c
	push af			;757e
	call z,L_7E18		;757f
	pop af			;7582
	jp z,L_7640		;7583
	ld a,(ix+01bh)		;7586
	and 00fh		;7589
	cp 002h		;758b
	jp z,L_76D7		;758d
L_7590:
	ld a,(ix+01ch)		;7590
	and 00fh		;7593
	cp 00fh		;7595
	jp z,L_7608		;7597
	cp 001h		;759a
	jp z,L_7E18		;759c
	cp 002h		;759f
	jp z,L_7643		;75a1
	cp 003h		;75a4
	jp z,L_7643		;75a6
	cp 004h		;75a9
	jp z,L_7610		;75ab
	cp 005h		;75ae
	jp z,L_7665		;75b0
	cp 006h		;75b3
	jp z,L_7665		;75b5
	jp nc,L_76BA		;75b8
L_75BB:
	call L_7E18		;75bb
	jp L_7608		;75be
L_75C1:
	ld a,(ix+019h)		;75c1
	and 0f0h		;75c4
	cp 020h		;75c6
	push af			;75c8
	call z,L_7E18		;75c9
	pop af			;75cc
	jp z,L_7640		;75cd
	ld a,(ix+01eh)		;75d0
	and 00fh		;75d3
	cp 002h		;75d5
	jp z,L_76E4		;75d7
L_75DA:
	ld a,(ix+01dh)		;75da
	and 00fh		;75dd
	cp 00fh		;75df
	jp z,L_7608		;75e1
	cp 001h		;75e4
	jp z,L_7E18		;75e6
	cp 002h		;75e9
	jp z,L_7654		;75eb
	cp 003h		;75ee
	jp z,L_7654		;75f0
	cp 004h		;75f3
	jp z,L_7610		;75f5
	cp 005h		;75f8
	jp z,L_7665		;75fa
	cp 006h		;75fd
	jp z,L_7665		;75ff
	jp nc,L_76C1		;7602
L_7605:
	call L_7E18		;7605
L_7608:
	call L_7CC6		;7608
	cp 030h		;760b
	jp c,L_7622		;760d
L_7610:
	res 3,(ix+001h)		;7610
	res 2,(ix+001h)		;7614
	res 1,(ix+001h)		;7618
L_761C:
	call L_7E83		;761c
	jp 04a8bh		;761f
L_7622:
	call L_7B29		;7622
	and a			;7625
	call z,L_7E18		;7626
	call L_7CFB		;7629
	cp 020h		;762c
	jp nc,L_7640		;762e
	set 1,(ix+001h)		;7631
	res 2,(ix+001h)		;7635
	res 3,(ix+001h)		;7639
	jp 04a8bh		;763d
L_7640:
	jp 04a8bh		;7640
L_7643:
	ld a,(ix+017h)		;7643
	and 0f0h		;7646
	cp 020h		;7648
	jp nz,L_7610		;764a
L_764D:
	ld (ix+010h),010h		;764d
	jp L_7610		;7651
L_7654:
	ld a,(ix+01ah)		;7654
	and 0f0h		;7657
	cp 020h		;7659
	jp nz,L_7610		;765b
	ld (ix+010h),010h		;765e
	jp L_7610		;7662
L_7665:
	set 3,(ix+001h)		;7665
	res 2,(ix+001h)		;7669
	res 1,(ix+001h)		;766d
	ld (ix+011h),020h		;7671
	jp L_7640		;7675
L_7678:
	ld (ix+012h),020h		;7678
	jp L_7640		;767c
L_767F:
	ld a,(ix+007h)		;767f
	inc a			;7682
	ld (ix+007h),a		;7683
	ld a,(ix+012h)		;7686
	dec a			;7689
	ld (ix+012h),a		;768a
	jp L_761C		;768d
L_7690:
	set 3,(ix+001h)		;7690
	res 2,(ix+001h)		;7694
	res 1,(ix+001h)		;7698
	ld a,(ix+007h)		;769c
	dec a			;769f
	ld (ix+007h),a		;76a0
	ld a,(ix+011h)		;76a3
	dec a			;76a6
	ld (ix+011h),a		;76a7
	and a			;76aa
	jp z,L_76B1		;76ab
	jp L_761C		;76ae
L_76B1:
	ld (ix+012h),01ch		;76b1
	jp L_761C		;76b5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x76b8..0x76ba  (2 bytes)
DATA_76B8:
	defb 0c9h,0c9h	; 76b8

; ======================================================================
; CODIGO 0x76ba..0x7ae4  (1066 bytes)
; ======================================================================


L_76BA:
	cp 00fh		;76ba
	jp z,L_75BB		;76bc
	jr L_76C9		;76bf
L_76C1:
	cp 00fh		;76c1
	jp z,L_7605		;76c3
	jp L_76C9		;76c6
L_76C9:
	call L_7E18		;76c9
	call L_7CC6		;76cc
	cp 030h		;76cf
	jp c,L_7622		;76d1
	jp L_7640		;76d4
L_76D7:
	ld a,(ix+017h)		;76d7
	and 0f0h		;76da
	cp 020h		;76dc
	jp z,L_764D		;76de
	jp L_7590		;76e1
L_76E4:
	ld a,(ix+01ah)		;76e4
	and 0f0h		;76e7
	cp 020h		;76e9
	jp z,L_764D		;76eb
	jp L_75DA		;76ee
L_76F1:
	ld a,(ix+00fh)		;76f1
	and a			;76f4
	jp z,L_7AAF		;76f5
	ld a,(0d9e0h)		;76f8   ; a = actor 4, byte +15
	cp 0f1h		;76fb
	call z,L_77AF		;76fd
	ld a,(0d9e0h)		;7700   ; a = actor 4, byte +15
	cp 00fh		;7703
	call z,L_77AF		;7705
	bit 1,(ix+001h)		;7708
	call nz,L_77AF		;770c
	call L_7B29		;770f
	and a			;7712
	jp z,L_7E18		;7713
	call L_7EBD		;7716
	cp 0ffh		;7719
	jp z,L_7E4B		;771b
	ld a,(ix+006h)		;771e
	cp 001h		;7721
	call c,L_7E97		;7723
	cp 0efh		;7726
	call nc,L_7EA0		;7728
	call L_7D56		;772b
	bit 0,(ix+001h)		;772e
	jr z,L_774A		;7732
	ld a,(ix+017h)		;7734
	and 0f0h		;7737
	cp 020h		;7739
	jp z,L_77A1		;773b
	ld a,(ix+01ch)		;773e
	and 0f0h		;7741
	cp 020h		;7743
	jp nz,L_77A1		;7745
	jr L_775E		;7748
L_774A:
	ld a,(ix+01ah)		;774a
	and 0f0h		;774d
	cp 020h		;774f
	jp z,L_77A1		;7751
	ld a,(ix+01eh)		;7754
	and 0f0h		;7757
	cp 020h		;7759
	jp nz,L_77A1		;775b
L_775E:
	call L_7CC6		;775e
	cp 040h		;7761
	jr c,L_7773		;7763
L_7765:
	jp L_7B64		;7765
L_7768:
	call L_7CFB		;7768
	cp 020h		;776b
	jp nc,L_7770		;776d
L_7770:
	jp 04a8bh		;7770
L_7773:
	cp 020h		;7773
	jr nc,L_7779		;7775
	jr L_7765		;7777
L_7779:
	ld a,(0d9e0h)		;7779   ; a = actor 4, byte +15
	cp 00fh		;777c
	jr z,L_779A		;777e
	call L_7CFB		;7780
	cp 020h		;7783
	jp nc,L_7770		;7785
	set 1,(ix+001h)		;7788
	push ix		;778c
	call 04a8bh		;778e
	pop ix		;7791
	ld a,(0d9e0h)		;7793   ; a = actor 4, byte +15
	and a			;7796
	jp z,L_77AF		;7797
L_779A:
	res 1,(ix+001h)		;779a
	jp 04a8bh		;779e
L_77A1:
	call L_7CC6		;77a1
	cp 040h		;77a4
	jr c,L_7770		;77a6
	cp 020h		;77a8
	jr nc,L_7770		;77aa
	jp L_7779		;77ac
L_77AF:
	push ix		;77af
	push ix		;77b1
	pop iy		;77b3
	ld ix,0d9cbh		;77b5   ; ix -> actor 4
	ld a,(ix+015h)		;77b9
	cp 000h		;77bc
	jp z,L_77C8		;77be
	cp 00fh		;77c1
	jr z,L_77DF		;77c3
	jp L_7889		;77c5
L_77C8:
	bit 7,(iy+002h)		;77c8
	jp z,L_77DC		;77cc
	ld (ix+015h),00fh		;77cf
	call L_77F2		;77d3
	call 048f9h		;77d6
	call 04a8bh		;77d9
L_77DC:
	pop ix		;77dc
	ret			;77de
L_77DF:
	jp L_7828		;77df
L_77E2:
	call 04a8bh		;77e2
	pop ix		;77e5
	ret			;77e7
L_77E8:
	ld (ix+015h),000h		;77e8
	call 04b10h		;77ec
	pop ix		;77ef
	ret			;77f1
L_77F2:
	ld (ix+001h),001h		;77f2
	ld a,(iy+001h)		;77f6
	ld (ix+013h),a		;77f9
	bit 0,(iy+001h)		;77fc
	jr z,L_7810		;7800
	set 0,(ix+012h)		;7802
	ld a,(iy+006h)		;7806
	sub 008h		;7809
	ld (ix+006h),a		;780b
	jr L_781C		;780e
L_7810:
	res 0,(ix+001h)		;7810
	ld a,(iy+006h)		;7814
	add a,018h		;7817
	ld (ix+006h),a		;7819
L_781C:
	ld a,(iy+007h)		;781c
	ld (ix+007h),a		;781f
	ld a,016h		;7822
	ld (ix+000h),a		;7824
	ret			;7827
L_7828:
	call L_7D56		;7828
	ld a,(ix+020h)		;782b
	and 0f0h		;782e
	cp 020h		;7830
	jp z,L_7870		;7832
	ld a,(0d8fch)		;7835   ; a = la x de Rastan
	add a,008h		;7838
	ld c,a			;783a
	bit 0,(ix+013h)		;783b
	jr z,L_7856		;783f
	call L_6AFF		;7841
	and a			;7844
	jp z,L_7870		;7845
	ld a,(ix+006h)		;7848
	dec a			;784b
	cp 004h		;784c
	jp c,L_7870		;784e
	ld (ix+006h),a		;7851
	jr L_786D		;7854
L_7856:
	res 0,(ix+001h)		;7856
	call L_6B2C		;785a
	and a			;785d
	jp z,L_7870		;785e
	ld a,(ix+006h)		;7861
	inc a			;7864
	cp 0f0h		;7865
	jp nc,L_7870		;7867
	ld (ix+006h),a		;786a
L_786D:
	jp L_77E2		;786d
L_7870:
	ld ix,0d9cbh		;7870   ; ix -> actor 4
	ld (ix+015h),0f1h		;7874
	ld (ix+001h),003h		;7878
	push ix		;787c
	call 04a8bh		;787e
	pop ix		;7881
	call 04b10h		;7883
	pop ix		;7886
	ret			;7888
L_7889:
	bit 7,(ix+002h)		;7889
	jr nz,L_789C		;788d
	push ix		;788f
	call 04a8bh		;7891
	pop ix		;7894
	call 04b10h		;7896
	pop ix		;7899
	ret			;789b
L_789C:
	ld (ix+015h),000h		;789c
	push ix		;78a0
	call 04a8bh		;78a2
	pop ix		;78a5
	call 04b10h		;78a7
	pop ix		;78aa
	ret			;78ac
L_78AD:
	ld a,(ix+00fh)		;78ad
	and a			;78b0
	jp z,L_7AAF		;78b1
	ld a,(0d9e0h)		;78b4   ; a = actor 4, byte +15
	cp 0f1h		;78b7
	call z,L_7964		;78b9
	ld a,(0d9e0h)		;78bc   ; a = actor 4, byte +15
	cp 00fh		;78bf
	call z,L_7964		;78c1
	bit 1,(ix+001h)		;78c4
	call nz,L_7964		;78c8
	call L_7B29		;78cb
	and a			;78ce
	jp z,L_7E18		;78cf
	call L_7EBD		;78d2
	cp 0ffh		;78d5
	jp z,L_7E4B		;78d7
	ld a,(ix+006h)		;78da
	cp 001h		;78dd
	call c,L_7E97		;78df
	cp 0dch		;78e2
	call nc,L_7EA0		;78e4
	call L_7D56		;78e7
	bit 0,(ix+001h)		;78ea
	jr z,L_7906		;78ee
	ld a,(ix+017h)		;78f0
	and 0f0h		;78f3
	cp 020h		;78f5
	jp z,L_7956		;78f7
	ld a,(ix+01ch)		;78fa
	and 0f0h		;78fd
	cp 020h		;78ff
	jp nz,L_7956		;7901
	jr L_791A		;7904
L_7906:
	ld a,(ix+01ah)		;7906
	and 0f0h		;7909
	cp 020h		;790b
	jp z,L_7956		;790d
	ld a,(ix+01eh)		;7910
	and 0f0h		;7913
	cp 020h		;7915
	jp nz,L_7956		;7917
L_791A:
	call L_7CC6		;791a
	cp 040h		;791d
	jr c,L_7927		;791f
L_7921:
	jp L_7B64		;7921
L_7924:
	jp 04a8bh		;7924
L_7927:
	cp 020h		;7927
	jr nc,L_792D		;7929
	jr L_7921		;792b
L_792D:
	ld a,(0d9e0h)		;792d   ; a = actor 4, byte +15
	cp 00fh		;7930
	jr z,L_7940		;7932
	call L_7CFB		;7934
	cp 020h		;7937
	jp nc,L_7940		;7939
	set 1,(ix+001h)		;793c
L_7940:
	push ix		;7940
	call 04a8bh		;7942
	pop ix		;7945
	ld a,(0d9e0h)		;7947   ; a = actor 4, byte +15
	and a			;794a
	jp z,L_7964		;794b
	ret			;794e
L_794F:
	res 1,(ix+001h)		;794f
	jp 04a8bh		;7953
L_7956:
	call L_7CC6		;7956
	cp 040h		;7959
	jr c,L_7924		;795b
	cp 020h		;795d
	jr nc,L_7924		;795f
	jp L_792D		;7961
L_7964:
	push ix		;7964
	push ix		;7966
	pop iy		;7968
	ld ix,0d9cbh		;796a   ; ix -> actor 4
	ld a,(ix+015h)		;796e
	cp 000h		;7971
	jp z,L_797D		;7973
	cp 00fh		;7976
	jr z,L_7994		;7978
	jp L_7889		;797a
L_797D:
	bit 7,(iy+002h)		;797d
	jp z,L_7991		;7981
	ld (ix+015h),00fh		;7984
	call L_79A7		;7988
	call 048f9h		;798b
	call 04a8bh		;798e
L_7991:
	pop ix		;7991
	ret			;7993
L_7994:
	jp L_79DD		;7994
L_7997:
	call 04a8bh		;7997
	pop ix		;799a
	ret			;799c
L_799D:
	ld (ix+015h),000h		;799d
	call 04b10h		;79a1
	pop ix		;79a4
	ret			;79a6
L_79A7:
	ld (ix+001h),005h		;79a7
	ld a,(iy+001h)		;79ab
	ld (ix+013h),a		;79ae
	bit 0,(iy+001h)		;79b1
	jr z,L_79C5		;79b5
	set 0,(ix+012h)		;79b7
	ld a,(iy+006h)		;79bb
	sub 008h		;79be
	ld (ix+006h),a		;79c0
	jr L_79D1		;79c3
L_79C5:
	res 0,(ix+001h)		;79c5
	ld a,(iy+006h)		;79c9
	add a,018h		;79cc
	ld (ix+006h),a		;79ce
L_79D1:
	ld a,(iy+007h)		;79d1
	ld (ix+007h),a		;79d4
	ld a,016h		;79d7
	ld (ix+000h),a		;79d9
	ret			;79dc
L_79DD:
	call L_7D56		;79dd
	ld a,(ix+020h)		;79e0
	and 0f0h		;79e3
	cp 020h		;79e5
	jp z,L_7A25		;79e7
	ld a,(0d8fch)		;79ea   ; a = la x de Rastan
	add a,008h		;79ed
	ld c,a			;79ef
	bit 0,(ix+013h)		;79f0
	jr z,L_7A0B		;79f4
	call L_6AFF		;79f6
	and a			;79f9
	jp z,L_7A25		;79fa
	ld a,(ix+006h)		;79fd
	dec a			;7a00
	cp 004h		;7a01
	jp c,L_7A25		;7a03
	ld (ix+006h),a		;7a06
	jr L_7A22		;7a09
L_7A0B:
	res 0,(ix+001h)		;7a0b
	call L_6B2C		;7a0f
	and a			;7a12
	jp z,L_7A25		;7a13
	ld a,(ix+006h)		;7a16
	inc a			;7a19
	cp 0f0h		;7a1a
	jp nc,L_7A25		;7a1c
	ld (ix+006h),a		;7a1f
L_7A22:
	jp L_7997		;7a22
L_7A25:
	ld ix,0d9cbh		;7a25   ; ix -> actor 4
	ld (ix+015h),0f1h		;7a29
	ld (ix+001h),007h		;7a2d
	push ix		;7a31
	call 04a8bh		;7a33
	pop ix		;7a36
	call 04b10h		;7a38
	pop ix		;7a3b
	ret			;7a3d
L_7A3E:
	ld b,005h		;7a3e
	ld a,(0d936h)		;7a40   ; a = actor 0, byte +3
	add a,b			;7a43
	ld h,a			;7a44
	ld a,(0d92ch)		;7a45   ; a = y del bloque especial
	sub b			;7a48
	ld l,a			;7a49
	ld a,(0d937h)		;7a4a   ; a = actor 0, byte +4
	add a,b			;7a4d
	ld d,a			;7a4e
	ld a,(0d92dh)		;7a4f   ; a = cual es el bloque especial
	sub b			;7a52
	ld e,a			;7a53
	call 044deh		;7a54
	ld c,a			;7a57
	and 01ch		;7a58
	cp 004h		;7a5a
	jr z,L_7A6B		;7a5c
	cp 008h		;7a5e
	jr z,L_7A7C		;7a60
	cp 00ch		;7a62
	jr z,L_7A8D		;7a64
	cp 010h		;7a66
	jr z,L_7A9E		;7a68
	ret			;7a6a
L_7A6B:
	ld a,(ix+006h)		;7a6b
	inc a			;7a6e
	inc a			;7a6f
	inc a			;7a70
	inc a			;7a71
	cp h			;7a72
	ld (ix+006h),a		;7a73
	ret c			;7a76
	ld a,h			;7a77
	ld (ix+006h),a		;7a78
	ret			;7a7b
L_7A7C:
	ld a,(ix+006h)		;7a7c
	dec a			;7a7f
	dec a			;7a80
	dec a			;7a81
	dec a			;7a82
	cp l			;7a83
	ld (ix+006h),a		;7a84
	ret nc			;7a87
	ld a,l			;7a88
	ld (ix+006h),a		;7a89
	ret			;7a8c
L_7A8D:
	ld a,(ix+007h)		;7a8d
	inc a			;7a90
	inc a			;7a91
	inc a			;7a92
	inc a			;7a93
	cp d			;7a94
	ld (ix+006h),a		;7a95
	ret c			;7a98
	ld a,d			;7a99
	ld (ix+006h),a		;7a9a
	ret			;7a9d
L_7A9E:
	ld a,(ix+007h)		;7a9e
	dec a			;7aa1
	dec a			;7aa2
	dec a			;7aa3
	dec a			;7aa4
	cp e			;7aa5
	ld (ix+006h),a		;7aa6
	ret nc			;7aa9
	ld a,e			;7aaa
	ld (ix+006h),a		;7aab
	ret			;7aae
L_7AAF:
	push ix		;7aaf
	ld a,(ix+000h)		;7ab1
	dec a			;7ab4
	ld d,000h		;7ab5
	ld e,a			;7ab7
	ld hl,00000h		;7ab8
	add hl,de			;7abb
	add hl,de			;7abc
	add hl,de			;7abd
	ld de,07ae4h		;7abe
	add hl,de			;7ac1
	ld e,(hl)			;7ac2
	inc hl			;7ac3
	ld d,(hl)			;7ac4
	inc hl			;7ac5
	ld a,d			;7ac6
	and a			;7ac7
	jr z,L_7AD8		;7ac8
	push de			;7aca
	pop ix		;7acb
	ld a,(ix+005h)		;7acd
	and a			;7ad0
	jr z,L_7AD8		;7ad1
	push hl			;7ad3
	call 04b10h		;7ad4
	pop hl			;7ad7
L_7AD8:
	pop ix		;7ad8
	ld a,(hl)			;7ada
	ld (ix+001h),a		;7adb
	ld a,024h		;7ade
	ld (ix+000h),a		;7ae0
	ret			;7ae3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7ae4..0x7b29  (69 bytes)
DATA_7AE4:
	defb 000h,000h,000h,000h,000h,000h,0a5h,0d9h,000h,000h,000h,000h,0f1h,0d9h,000h,000h	; 7ae4  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0cbh,0d9h,000h,000h,000h,003h,000h,000h	; 7af4  ................
	defb 003h,000h,000h,003h,000h,000h,000h,000h,000h,000h,000h,000h,001h,0f1h,0d9h,002h	; 7b04  ................
	defb 000h,000h,000h,0a5h,0d9h,000h,000h,000h,000h,0cbh,0d9h,000h,0cbh,0d9h,000h,000h	; 7b14  ................
	defb 000h,000h,000h,000h,000h	; 7b24

; ======================================================================
; CODIGO 0x7b29..0x7b7a  (81 bytes)
; ======================================================================


L_7B29:
	ld a,(0d8fch)		;7b29   ; a = la x de Rastan
	ld b,a			;7b2c
	ld a,(ix+006h)		;7b2d
	cp b			;7b30
	jr nc,L_7B3C		;7b31
	bit 0,(ix+001h)		;7b33
	jr nz,L_7B45		;7b37
	ld a,001h		;7b39
	ret			;7b3b
L_7B3C:
	bit 0,(ix+001h)		;7b3c
	jr z,L_7B45		;7b40
	ld a,001h		;7b42
	ret			;7b44
L_7B45:
	ld a,000h		;7b45
	ret			;7b47
L_7B48:
	bit 0,(ix+001h)		;7b48
	jr nz,L_7B56		;7b4c
	inc (ix+006h)		;7b4e
	inc (ix+006h)		;7b51
	jr L_7B5C		;7b54
L_7B56:
	dec (ix+006h)		;7b56
	dec (ix+006h)		;7b59
L_7B5C:
	res 1,(ix+001h)		;7b5c
	call 04a8bh		;7b60
	ret			;7b63
L_7B64:
	bit 0,(ix+001h)		;7b64
	jr nz,L_7B6F		;7b68
	inc (ix+006h)		;7b6a
	jr L_7B72		;7b6d
L_7B6F:
	dec (ix+006h)		;7b6f
L_7B72:
	res 1,(ix+001h)		;7b72
	call 04a8bh		;7b76
	ret			;7b79

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7b7a..0x7b90  (22 bytes)
DATA_7B7A:
	defb 0ddh,0cbh,001h,046h,028h,005h,0ddh,034h,006h,018h,003h,0ddh,035h,006h,0ddh,0cbh	; 7b7a  ...F(..4....5...
	defb 001h,08eh,0cdh,08bh,04ah,0c9h	; 7b8a

; ======================================================================
; CODIGO 0x7b90..0x7bd9  (73 bytes)
; ======================================================================


L_7B90:
	ld a,(0d8fdh)		;7b90   ; a = la y de Rastan
	ld b,(ix+007h)		;7b93
	cp b			;7b96
	jr c,L_7BA0		;7b97
	inc (ix+007h)		;7b99
	inc (ix+007h)		;7b9c
	ret			;7b9f
L_7BA0:
	dec (ix+007h)		;7ba0
	dec (ix+007h)		;7ba3
	ret			;7ba6
L_7BA7:
	ld b,(ix+007h)		;7ba7
	cp b			;7baa
	jr z,L_7BB5		;7bab
	jr c,L_7BD1		;7bad
	inc (ix+007h)		;7baf
	inc (ix+007h)		;7bb2
L_7BB5:
	bit 0,(ix+001h)		;7bb5
	jr nz,L_7BC3		;7bb9
	inc (ix+006h)		;7bbb
	inc (ix+006h)		;7bbe
	jr L_7BC9		;7bc1
L_7BC3:
	dec (ix+006h)		;7bc3
	dec (ix+006h)		;7bc6
L_7BC9:
	res 1,(ix+001h)		;7bc9
	call 04a8bh		;7bcd
	ret			;7bd0
L_7BD1:
	dec (ix+007h)		;7bd1
	dec (ix+007h)		;7bd4
	jr L_7BB5		;7bd7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7bd9..0x7c14  (59 bytes)
DATA_7BD9:
	defb 03ah,0fdh,0d8h,04fh,0ddh,07eh,007h,006h,030h,080h,047h,079h,0b8h,028h,008h,038h	; 7bd9  :..O.~..0.Gy.(.8
	defb 022h,0ddh,034h,007h,0ddh,034h,007h,0ddh,0cbh,001h,046h,020h,008h,0ddh,034h,006h	; 7be9  ".4..4....F ..4.
	defb 0ddh,034h,006h,018h,006h,0ddh,035h,006h,0ddh,035h,006h,0ddh,0cbh,001h,08eh,0cdh	; 7bf9  .4....5..5......
	defb 08bh,04ah,0c9h,0ddh,035h,007h,0ddh,035h,007h,018h,0dch	; 7c09  .J..5..5...

; ======================================================================
; CODIGO 0x7c14..0x7c82  (110 bytes)
; ======================================================================


L_7C14:
	ld b,(ix+007h)		;7c14
	cp b			;7c17
	jr z,L_7C22		;7c18
	jr c,L_7C3E		;7c1a
	inc (ix+007h)		;7c1c
	inc (ix+007h)		;7c1f
L_7C22:
	bit 0,(ix+001h)		;7c22
	jr nz,L_7C30		;7c26
	inc (ix+006h)		;7c28
	inc (ix+006h)		;7c2b
	jr L_7C36		;7c2e
L_7C30:
	dec (ix+006h)		;7c30
	dec (ix+006h)		;7c33
L_7C36:
	set 1,(ix+001h)		;7c36
	call 04a8bh		;7c3a
	ret			;7c3d
L_7C3E:
	dec (ix+007h)		;7c3e
	dec (ix+007h)		;7c41
	jr L_7C22		;7c44
L_7C46:
	bit 0,(ix+001h)		;7c46
	jr nz,L_7C60		;7c4a
	inc (ix+006h)		;7c4c
	inc (ix+006h)		;7c4f
	inc (ix+006h)		;7c52
	inc (ix+006h)		;7c55
	res 1,(ix+001h)		;7c58
	call 04a8bh		;7c5c
	ret			;7c5f
L_7C60:
	dec (ix+006h)		;7c60
	dec (ix+006h)		;7c63
	dec (ix+006h)		;7c66
	dec (ix+006h)		;7c69
	res 1,(ix+001h)		;7c6c
	call 04a8bh		;7c70
	ret			;7c73
L_7C74:
	ld a,(ix+010h)		;7c74
	and a			;7c77
	jr nz,L_7C7E		;7c78
	call L_7C46		;7c7a
	ret			;7c7d
L_7C7E:
	call L_7B48		;7c7e
	ret			;7c81

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7c82..0x7cc6  (68 bytes)
DATA_7C82:
	defb 047h,0ddh,07eh,010h,03ch,0b8h,028h,005h,0ddh,077h,010h,0afh,0c9h,0afh,0ddh,077h	; 7c82  G.~.<.(..w.....w
	defb 010h,03eh,001h,0c9h,057h,03ah,0fch,0d8h,006h,010h,080h,047h,0ddh,07eh,006h,00eh	; 7c92  .>..W:.....G.~..
	defb 010h,081h,0b8h,038h,007h,090h,0bah,0c8h,038h,00ah,018h,010h,04fh,078h,041h,090h	; 7ca2  ...8....8...OxA.
	defb 0bah,0c8h,038h,008h,0ddh,07eh,006h,03ch,0ddh,077h,006h,0c9h,0ddh,07eh,006h,03dh	; 7cb2  ..8..~.<.w...~.=
	defb 0ddh,077h,006h,0c9h	; 7cc2

; ======================================================================
; CODIGO 0x7cc6..0x7cf4  (46 bytes)
; ======================================================================


L_7CC6:
	ld a,(0d8fch)		;7cc6   ; a = la x de Rastan
	ld b,010h		;7cc9
	add a,b			;7ccb
	ld b,a			;7ccc
	ld a,(ix+006h)		;7ccd
	ld c,010h		;7cd0
	add a,c			;7cd2
	cp b			;7cd3
	jr c,L_7CD8		;7cd4
	sub b			;7cd6
	ret			;7cd7
L_7CD8:
	ld c,a			;7cd8
	ld a,b			;7cd9
	ld b,c			;7cda
	sub b			;7cdb
	ret			;7cdc
L_7CDD:
	ld a,(0d8fch)		;7cdd   ; a = la x de Rastan
	ld b,010h		;7ce0
	add a,b			;7ce2
	ld b,a			;7ce3
	ld a,(ix+006h)		;7ce4
	ld c,007h		;7ce7
	add a,c			;7ce9
	cp b			;7cea
	jr c,L_7CEF		;7ceb
	sub b			;7ced
	ret			;7cee
L_7CEF:
	ld c,a			;7cef
	ld a,b			;7cf0
	ld b,c			;7cf1
	sub b			;7cf2
	ret			;7cf3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7cf4..0x7cfb  (7 bytes)
DATA_7CF4:
	defb 03eh,001h,04fh,0c9h,0afh,04fh,0c9h	; 7cf4

; ======================================================================
; CODIGO 0x7cfb..0x7d40  (69 bytes)
; ======================================================================


L_7CFB:
	ld a,(0d8fdh)		;7cfb   ; a = la y de Rastan
	ld b,010h		;7cfe
	add a,b			;7d00
	ld b,a			;7d01
	ld a,(ix+007h)		;7d02
	cp b			;7d05
	jr c,L_7D0A		;7d06
	sub b			;7d08
	ret			;7d09
L_7D0A:
	ld c,a			;7d0a
	ld a,b			;7d0b
	ld b,c			;7d0c
	sub b			;7d0d
	ret			;7d0e
L_7D0F:
	bit 0,(ix+001h)		;7d0f
	jr z,L_7D1C		;7d13
	inc (ix+006h)		;7d15
	inc (ix+006h)		;7d18
	ret			;7d1b
L_7D1C:
	dec (ix+006h)		;7d1c
	dec (ix+006h)		;7d1f
	ret			;7d22
L_7D23:
	call L_7E18		;7d23
	ld a,(ix+001h)		;7d26
	and 001h		;7d29
	and a			;7d2b
	jr z,L_7D37		;7d2c
	ld a,(ix+006h)		;7d2e
	dec a			;7d31
	dec a			;7d32
	ld (ix+006h),a		;7d33
	ret			;7d36
L_7D37:
	ld a,(ix+006h)		;7d37
	inc a			;7d3a
	inc a			;7d3b
	ld (ix+006h),a		;7d3c
	ret			;7d3f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7d40..0x7d56  (22 bytes)
DATA_7D40:
	defb 0ddh,07eh,006h,0feh,0fbh,0d2h,050h,07dh,0ddh,07eh,006h,0feh,001h,0dah,053h,07dh	; 7d40  .~....P}.~....S}
	defb 03eh,001h,0c9h,03eh,002h,0c9h	; 7d50

; ======================================================================
; CODIGO 0x7d56..0x7de0  (138 bytes)
; ======================================================================


L_7D56:
	ld a,(ix+006h)		;7d56
	ld h,a			;7d59
	ld a,(ix+007h)		;7d5a
	ld l,a			;7d5d
	inc h			;7d5e
	inc l			;7d5f
	ld a,l			;7d60
	sub 020h		;7d61
	and 0f0h		;7d63
	ld b,000h		;7d65
	ld c,a			;7d67
	srl h		;7d68
	srl h		;7d6a
	srl h		;7d6c
	srl h		;7d6e
	ld l,h			;7d70
	ld h,000h		;7d71
	add hl,hl			;7d73
	add hl,bc			;7d74
	add hl,bc			;7d75
	ld de,0d774h		;7d76   ; de -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,de			;7d79
	inc hl			;7d7a
	bit 0,(ix+001h)		;7d7b
	call z,L_7DDD		;7d7f
	dec hl			;7d82
	dec hl			;7d83
	ld a,(hl)			;7d84
	ld (ix+01fh),a		;7d85
	inc hl			;7d88
	inc hl			;7d89
	ld a,(hl)			;7d8a
	ld (ix+020h),a		;7d8b
	inc hl			;7d8e
	inc hl			;7d8f
	ld a,(hl)			;7d90
	ld (ix+021h),a		;7d91
	inc hl			;7d94
	inc hl			;7d95
	ld a,(hl)			;7d96
	ld (ix+022h),a		;7d97
	ld de,0001ah		;7d9a
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
	ld de,0001ah		;7db4
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
	ld de,0001ch		;7dce
	add hl,de			;7dd1
	ld a,(hl)			;7dd2
	ld (ix+023h),a		;7dd3
	inc hl			;7dd6
	inc hl			;7dd7
	ld a,(hl)			;7dd8
	ld (ix+024h),a		;7dd9
	ret			;7ddc
L_7DDD:
	inc hl			;7ddd
	inc hl			;7dde
	ret			;7ddf

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7de0..0x7e18  (56 bytes)
DATA_7DE0:
	defb 0ddh,07eh,006h,067h,0ddh,07eh,007h,06fh,024h,02ch,07dh,0d6h,010h,0e6h,0f0h,006h	; 7de0  .~.g.~.o$,}.....
	defb 000h,04fh,0cbh,03ch,0cbh,03ch,0cbh,03ch,0cbh,03ch,06ch,026h,000h,029h,009h,009h	; 7df0  .O.<.<.<.<l&.)..
	defb 011h,074h,0d7h,019h,023h,0e5h,0ddh,07eh,001h,0a7h,018h,006h,011h,03eh,000h,019h	; 7e00  .t..#..~.....>..
	defb 07eh,0c9h,011h,043h,000h,019h,07eh,0c9h	; 7e10  ~..C..~.

; ======================================================================
; CODIGO 0x7e18..0x7e29  (17 bytes)
; ======================================================================


L_7E18:
	ld a,(ix+001h)		;7e18
	bit 0,a		;7e1b
	jr z,L_7E24		;7e1d
	res 0,(ix+001h)		;7e1f
	ret			;7e23
L_7E24:
	set 0,(ix+001h)		;7e24
	ret			;7e28

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7e29..0x7e4b  (34 bytes)
DATA_7E29:
	defb 0ddh,07eh,001h,0e6h,001h,0cah,03eh,07eh,0ddh,035h,006h,0ddh,035h,006h,0ddh,035h	; 7e29  .~....>~.5..5..5
	defb 007h,0ddh,035h,007h,0c9h,0ddh,034h,006h,0ddh,034h,006h,0ddh,035h,007h,0ddh,035h	; 7e39  ..5...4..4..5..5
	defb 007h,0c9h	; 7e49

; ======================================================================
; CODIGO 0x7e4b..0x7ef1  (166 bytes)
; ======================================================================


L_7E4B:
	ld a,(ix+007h)		;7e4b
	inc a			;7e4e
	ld (ix+007h),a		;7e4f
	res 1,(ix+001h)		;7e52
	call 04a8bh		;7e56
	ret			;7e59
L_7E5A:
	inc (ix+007h)		;7e5a
	inc (ix+007h)		;7e5d
	jp L_7F3E		;7e60
L_7E63:
	ld a,(ix+006h)		;7e63
	cp 001h		;7e66
	call c,L_7E71		;7e68
	cp 0e7h		;7e6b
	call nc,L_7E7A		;7e6d
	ret			;7e70
L_7E71:
	ld a,001h		;7e71
	ld (ix+006h),a		;7e73
	call L_7E18		;7e76
	ret			;7e79
L_7E7A:
	ld a,0e7h		;7e7a
	ld (ix+006h),a		;7e7c
	call L_7E18		;7e7f
	ret			;7e82
L_7E83:
	bit 0,(ix+001h)		;7e83
	jr nz,L_7E90		;7e87
	inc (ix+006h)		;7e89
	inc (ix+006h)		;7e8c
	ret			;7e8f
L_7E90:
	dec (ix+006h)		;7e90
	dec (ix+006h)		;7e93
	ret			;7e96
L_7E97:
	ld a,002h		;7e97
	ld (ix+006h),a		;7e99
	call L_7E18		;7e9c
	ret			;7e9f
L_7EA0:
	ld a,0dch		;7ea0
	ld (ix+006h),a		;7ea2
	call L_7E18		;7ea5
	ret			;7ea8
L_7EA9:
	ld a,002h		;7ea9
	ld (ix+007h),a		;7eab
	ret			;7eae
L_7EAF:
	ld a,0b5h		;7eaf
	ld (ix+007h),a		;7eb1
	ret			;7eb4
L_7EB5:
	set 1,(ix+001h)		;7eb5
	call 04a8bh		;7eb9
	ret			;7ebc
L_7EBD:
	call L_7D56		;7ebd
	ld a,(ix+01ch)		;7ec0
	and 0f0h		;7ec3
	cp 0f0h		;7ec5
	jr z,L_7ECA		;7ec7
	ret			;7ec9
L_7ECA:
	ld a,(ix+01dh)		;7eca
	and 0f0h		;7ecd
	cp 0f0h		;7ecf
	jr z,L_7ED4		;7ed1
	ret			;7ed3
L_7ED4:
	ld a,0ffh		;7ed4
	ret			;7ed6
L_7ED7:
	call L_7D56		;7ed7
	ld a,(ix+018h)		;7eda
	and 0f0h		;7edd
	cp 0f0h		;7edf
	jr z,L_7EE4		;7ee1
	ret			;7ee3
L_7EE4:
	ld a,(ix+019h)		;7ee4
	and 0f0h		;7ee7
	cp 0f0h		;7ee9
	jr z,L_7EEE		;7eeb
	ret			;7eed
L_7EEE:
	ld a,0ffh		;7eee
	ret			;7ef0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7ef1..0x7f1f  (46 bytes)
DATA_7EF1:
	defb 0ddh,0cbh,001h,046h,028h,009h,0ddh,07eh,006h,03ch,0ddh,077h,006h,018h,007h,0ddh	; 7ef1  ...F(..~.<.w....
	defb 07eh,006h,03dh,0ddh,077h,006h,0ddh,07eh,010h,03dh,0ddh,077h,010h,0c9h,03ah,0fch	; 7f01  ~.=.w..~.=.w..:.
	defb 0d8h,047h,0ddh,07eh,006h,0b8h,0cah,01ch,07fh,0afh,0c9h,03eh,0ffh,0c9h	; 7f11  .G.~.......>..

; ======================================================================
; CODIGO 0x7f1f..0x7f76  (87 bytes)
; ======================================================================


L_7F1F:
	ld a,0feh		;7f1f
	ld (0d93dh),a		;7f21   ; actor 0, byte +A = a
	ld a,001h		;7f24
	ld (0d93eh),a		;7f26   ; actor 0, byte +B = a
	call L_7F3E		;7f29
	call L_7F3E		;7f2c
	call L_7F3E		;7f2f
	call L_7F3E		;7f32
	call L_7F3E		;7f35
	call L_7F3E		;7f38
	call L_7F3E		;7f3b
L_7F3E:
	ld a,(0d933h)		;7f3e   ; a = los 6 actores de la pantalla
	dec a			;7f41
	ld l,a			;7f42
	ld h,000h		;7f43
	add hl,hl			;7f45
	ld de,07f76h		;7f46
	add hl,de			;7f49
	ld e,(hl)			;7f4a
	inc hl			;7f4b
	ld d,(hl)			;7f4c
	push de			;7f4d
	ld a,(0d934h)		;7f4e   ; a = actor 0, byte +1
	ld l,a			;7f51
	ld h,000h		;7f52
	add hl,hl			;7f54
	pop de			;7f55
	add hl,de			;7f56
	ld e,(hl)			;7f57
	inc hl			;7f58
	ld d,(hl)			;7f59
	push de			;7f5a
	pop ix		;7f5b
	ld hl,0d4ceh		;7f5d   ; hl -> ficha de sprite 17
	ld iy,0d93dh		;7f60   ; iy -> actor 0, byte +A
	ld a,(0d939h)		;7f64   ; a = actor 0, byte +6
	ld (0d5ddh),a		;7f67   ; lo que se suma a la x de los sprites = a
	ld a,(0d93ah)		;7f6a   ; a = actor 0, byte +7
	ld (0d5deh),a		;7f6d   ; lo que se suma a la y de los sprites = a
	ld b,00ch		;7f70
	call 058c3h		;7f72
	ret			;7f75

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7f76..0x7fda  (100 bytes)
DATA_7F76:
	defb 084h,07fh,094h,07fh,0a8h,07fh,0b0h,07fh,0c0h,07fh,0d4h,07fh,0d8h,07fh,000h,060h	; 7f76  ...............`
	defb 0e3h,061h,0c3h,060h,0a6h,062h,08fh,060h,072h,062h,050h,061h,033h,063h,0c6h,063h	; 7f86  .a.`.b.`rbPa3c.c
	defb 0d1h,063h,03ah,064h,035h,065h,01bh,064h,020h,064h,08bh,064h,092h,064h,0cfh,064h	; 7f96  .c:d5e.d d.d.d.d
	defb 011h,065h,086h,065h,08fh,065h,0efh,065h,0f8h,065h,093h,066h,09eh,066h,0f5h,067h	; 7fa6  .e.e.e.e.e.f.f.g
	defb 000h,068h,099h,067h,09eh,067h,025h,069h,034h,069h,0f9h,069h,002h,06ah,0bfh,06ah	; 7fb6  .h.g.g%i4i.i.j.j
	defb 0c8h,06ah,00dh,06bh,016h,06bh,097h,06bh,0a0h,06bh,021h,06ch,02ah,06ch,099h,06ch	; 7fc6  .j.k.k.k.k!l*l.l
	defb 09eh,06ch,003h,06dh	; 7fd6

; ======================================================================
; CODIGO 0x7fda..0x7fff  (37 bytes)
; ======================================================================


L_7FDA:
	ld a,(0d933h)		;7fda   ; a = los 6 actores de la pantalla
	cp 007h		;7fdd
	jr z,$+36		;7fdf
	ld a,007h		;7fe1
	ld (0d17ah),a		;7fe3   ; peticion de sonido para p01:640F = a
	ld a,007h		;7fe6
	ld (0d933h),a		;7fe8   ; los 6 actores de la pantalla = a
	xor a			;7feb
	ld (0d934h),a		;7fec   ; actor 0, byte +1 = a
	ld a,0feh		;7fef
	ld (0d93dh),a		;7ff1   ; actor 0, byte +A = a
	ld a,001h		;7ff4
	ld (0d93eh),a		;7ff6   ; actor 0, byte +B = a
	call L_7F3E		;7ff9
	ld hl,00130h		;7ffc

; ----------------------------------------------------------------------
; DATOS sin identificar  0x7fff..0x8000  (1 bytes)
DATA_7FFF:
	defb 022h	; 7fff
