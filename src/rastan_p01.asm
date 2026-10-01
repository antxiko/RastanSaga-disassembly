; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 01 (en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x605f  (95 bytes)
; ======================================================================


L_6000:
	call 00138h		;6000   ; BIOS RSLREG - Reads the primary slot register
	rrca			;6003
	rrca			;6004
	and 003h		;6005
	ld c,a			;6007
	ld b,000h		;6008
	ld hl,0fcc1h		;600a
	add hl,bc			;600d
	or (hl)			;600e
	jp p,L_601B		;600f
	ld c,a			;6012
	inc hl			;6013
	inc hl			;6014
	inc hl			;6015
	inc hl			;6016
	ld a,(hl)			;6017
	and 00ch		;6018
	or c			;601a
L_601B:
	ld h,080h		;601b
	jp 00024h		;601d   ; BIOS ENASLT - Switches to specified slot and page definitively
L_6020:
	ld b,017h		;6020
L_6022:
	push bc			;6022
	ld c,b			;6023
	ld b,000h		;6024
	call 00047h		;6026   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;6029
	djnz L_6022		;602a
	ld c,000h		;602c
	ld b,000h		;602e
	call 00047h		;6030   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,005h		;6033
	call 0005fh		;6035   ; BIOS CHGMOD - Switches to given screen mode
	ld a,(0f3e0h)		;6038
	or 062h		;603b
	and 0beh		;603d
	ld (0f3e0h),a		;603f
	ld c,001h		;6042
	ld b,a			;6044
	call 00047h		;6045   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0605fh		;6048
	ld b,00ch		;604b
L_604D:
	push bc			;604d
	ld c,(hl)			;604e
	inc hl			;604f
	ld b,(hl)			;6050
	inc hl			;6051
	push hl			;6052
	call 00047h		;6053   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;6056
	pop bc			;6057
	djnz L_604D		;6058
	xor a			;605a
	ld (0f3dbh),a		;605b
	ret			;605e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x605f..0x6077  (24 bytes)
DATA_605F:
	defb 002h,01fh,00bh,001h,005h,00fh,006h,011h,007h,000h,008h,028h,009h,080h,00eh,003h	; 605f  ...........(....
	defb 012h,000h,014h,000h,015h,03bh,016h,005h	; 606f  .....;..

; ======================================================================
; CODIGO 0x6077..0x646c  (1013 bytes)
; ======================================================================


L_6077:
	ld hl,00000h		;6077
	ld bc,0ffffh		;607a
	xor a			;607d
	call 0016bh		;607e   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ld hl,0ffffh		;6081
	ld bc,0ffffh		;6084
	call 0016bh		;6087   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ld a,012h		;608a
	ld (0d191h),a		;608c
	ld (077f8h),a		;608f
	ld a,013h		;6092
	ld (0d192h),a		;6094
	ld (07ff8h),a		;6097
	ld hl,08000h		;609a
	ld de,00000h		;609d
	ld bc,03fffh		;60a0
	call 0005ch		;60a3   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,014h		;60a6
	ld (0d191h),a		;60a8
	ld (077f8h),a		;60ab
	ld a,015h		;60ae
	ld (0d192h),a		;60b0
	ld (07ff8h),a		;60b3
	ld hl,08000h		;60b6
	ld de,04000h		;60b9
	ld bc,03fffh		;60bc
	call 0005ch		;60bf   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,000h		;60c2
	ex af,af'			;60c4
	ld a,002h		;60c5
	ex af,af'			;60c7
	ld hl,00000h		;60c8
	ld de,080ffh		;60cb
	ld bc,00000h		;60ce
	call 044f1h		;60d1
	ld hl,08000h		;60d4
	ld de,080ffh		;60d7
	ld bc,08000h		;60da
	call 044f1h		;60dd
	ld a,016h		;60e0
	ld (0d191h),a		;60e2
	ld (077f8h),a		;60e5
	ld a,017h		;60e8
	ld (0d192h),a		;60ea
	ld (07ff8h),a		;60ed
	ld hl,08000h		;60f0
	ld de,00000h		;60f3
	ld bc,03fffh		;60f6
	call 0005ch		;60f9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,018h		;60fc
	ld (0d191h),a		;60fe
	ld (077f8h),a		;6101
	ld a,019h		;6104
	ld (0d192h),a		;6106
	ld (07ff8h),a		;6109
	ld hl,08000h		;610c
	ld de,04000h		;610f
	ld bc,03fffh		;6112
	call 0005ch		;6115   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,000h		;6118
	ex af,af'			;611a
	ld a,003h		;611b
	ex af,af'			;611d
	ld hl,00000h		;611e
	ld de,080ffh		;6121
	ld bc,00000h		;6124
	call 044f1h		;6127
	ld hl,08000h		;612a
	ld de,080ffh		;612d
	ld bc,08000h		;6130
	call 044f1h		;6133
	ld a,010h		;6136
	ld (0d191h),a		;6138
	ld (077f8h),a		;613b
	ld a,011h		;613e
	ld (0d192h),a		;6140
	ld (07ff8h),a		;6143
	ld hl,08000h		;6146
	ld de,0c000h		;6149
	ld bc,03fffh		;614c
	call 0005ch		;614f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;6152
L_6153:
	ld a,(0d069h)		;6153
	or a			;6156
	ret m			;6157
	ld hl,0d16bh		;6158
	ld b,003h		;615b
L_615D:
	ld a,(0d067h)		;615d
	add a,(hl)			;6160
	dec hl			;6161
	jp p,L_6166		;6162
	sub a			;6165
L_6166:
	ld e,a			;6166
	ld a,b			;6167
	add a,007h		;6168
	call L_64C4		;616a
	djnz L_615D		;616d
	ld b,008h		;616f
L_6171:
	ld e,(hl)			;6171
	dec hl			;6172
	ld a,b			;6173
	dec a			;6174
	call L_64C4		;6175
	djnz L_6171		;6178
	ld iy,0d08eh		;617a
	ld de,00019h		;617e
	ld b,004h		;6181
L_6183:
	exx			;6183
	ld a,(iy+000h)		;6184
	or a			;6187
	jp z,L_624B		;6188
	dec (iy+002h)		;618b
	jp z,L_6253		;618e
	dec (iy+006h)		;6191
	jr nz,L_61ED		;6194
	dec (iy+004h)		;6196
	jr nz,L_61CA		;6199
	ld l,(iy+00ch)		;619b
	ld h,(iy+00dh)		;619e
	ld a,(iy+005h)		;61a1
	add a,a			;61a4
	ld c,a			;61a5
	ld b,000h		;61a6
	add hl,bc			;61a8
	ld a,(hl)			;61a9
	or a			;61aa
	jr nz,L_61B3		;61ab
	ld (iy+005h),a		;61ad
	sbc hl,bc		;61b0
	ld a,(hl)			;61b2
L_61B3:
	and 00fh		;61b3
	ld (iy+014h),a		;61b5
	ld a,(hl)			;61b8
	inc hl			;61b9
	rrca			;61ba
	rrca			;61bb
	rrca			;61bc
	rrca			;61bd
	and 00fh		;61be
	ld (iy+004h),a		;61c0
	ld a,(hl)			;61c3
	ld (iy+013h),a		;61c4
	inc (iy+005h)		;61c7
L_61CA:
	ld a,(iy+012h)		;61ca
	add a,(iy+013h)		;61cd
	jp pe,L_61E7		;61d0
	ld (iy+012h),a		;61d3
	ld e,a			;61d6
	and 0f0h		;61d7
	jr z,L_61E4		;61d9
	jp m,L_61E2		;61db
	ld e,00fh		;61de
	jr L_61E4		;61e0
L_61E2:
	ld e,000h		;61e2
L_61E4:
	call L_63A7		;61e4
L_61E7:
	ld a,(iy+014h)		;61e7
	ld (iy+006h),a		;61ea
L_61ED:
	dec (iy+009h)		;61ed
	jr nz,L_624B		;61f0
	dec (iy+007h)		;61f2
	jr nz,L_6226		;61f5
	ld l,(iy+00eh)		;61f7
	ld h,(iy+00fh)		;61fa
	ld a,(iy+008h)		;61fd
	add a,a			;6200
	ld c,a			;6201
	ld b,000h		;6202
	add hl,bc			;6204
	ld a,(hl)			;6205
	or a			;6206
	jr nz,L_620F		;6207
	ld (iy+008h),a		;6209
	sbc hl,bc		;620c
	ld a,(hl)			;620e
L_620F:
	and 00fh		;620f
	ld (iy+018h),a		;6211
	ld a,(hl)			;6214
	inc hl			;6215
	rrca			;6216
	rrca			;6217
	rrca			;6218
	rrca			;6219
	and 00fh		;621a
	ld (iy+007h),a		;621c
	ld a,(hl)			;621f
	ld (iy+017h),a		;6220
	inc (iy+008h)		;6223
L_6226:
	ld l,(iy+015h)		;6226
	ld h,(iy+016h)		;6229
	ld a,(iy+017h)		;622c
	or a			;622f
	ld c,a			;6230
	jp m,L_6238		;6231
	ld b,000h		;6234
	jr L_623A		;6236
L_6238:
	ld b,0ffh		;6238
L_623A:
	add hl,bc			;623a
	ld (iy+015h),l		;623b
	ld (iy+016h),h		;623e
	ex de,hl			;6241
	call L_63C0		;6242
	ld a,(iy+018h)		;6245
	ld (iy+009h),a		;6248
L_624B:
	exx			;624b
	add iy,de		;624c
	dec b			;624e
	jp nz,L_6183		;624f
	ret			;6252
L_6253:
	ld l,(iy+010h)		;6253
	ld h,(iy+011h)		;6256
L_6259:
	ld a,(hl)			;6259
	inc hl			;625a
	or a			;625b
	jr z,L_62A4		;625c
	jp p,L_6363		;625e
	cp 0f0h		;6261
	jr nc,L_629D		;6263
	cp 0e0h		;6265
	jp nc,L_62F3		;6267
	cp 0c0h		;626a
	jr nc,L_6290		;626c
	cp 090h		;626e
	jp nc,L_6310		;6270
	cp 081h		;6273
	jp z,L_634C		;6275
	jp c,L_6335		;6278
	cp 083h		;627b
	jr z,L_62E2		;627d
	jr c,L_6297		;627f
	cp 085h		;6281
	jp z,L_631F		;6283
	jr c,L_62D0		;6286
L_6288:
	ld (iy+010h),l		;6288
	ld (iy+011h),h		;628b
	jr L_624B		;628e
L_6290:
	and 01fh		;6290
	ld (0d167h),a		;6292
	jr L_6259		;6295
L_6297:
	ld a,(hl)			;6297
	inc hl			;6298
	ld h,(hl)			;6299
	ld l,a			;629a
	jr L_6259		;629b
L_629D:
	and 00fh		;629d
	ld (iy+003h),a		;629f
	jr L_6259		;62a2
L_62A4:
	ld e,000h		;62a4
	ld d,000h		;62a6
	ld (iy+000h),e		;62a8
	call L_63A7		;62ab
	call L_63C0		;62ae
	exx			;62b1
	ld a,b			;62b2
	exx			;62b3
	cp 002h		;62b4
	jr nz,L_624B		;62b6
	ld hl,0d068h		;62b8
	ld a,(hl)			;62bb
	or a			;62bc
	jp p,L_624B		;62bd
	ld (hl),000h		;62c0
	ld hl,0d0f2h		;62c2
	ld de,0d06ah		;62c5
	ld bc,0006fh		;62c8
	ldir		;62cb
	jp L_624B		;62cd
L_62D0:
	call L_63DA		;62d0
	ld a,(de)			;62d3
	dec de			;62d4
	ld h,a			;62d5
	ld a,(de)			;62d6
	dec de			;62d7
	ld l,a			;62d8
L_62D9:
	ld (iy+00ah),e		;62d9
	ld (iy+00bh),d		;62dc
	jp L_6259		;62df
L_62E2:
	call L_63DA		;62e2
	inc de			;62e5
	ld c,(hl)			;62e6
	inc hl			;62e7
	ld b,(hl)			;62e8
	inc hl			;62e9
	ex de,hl			;62ea
	ld (hl),e			;62eb
	inc hl			;62ec
	ld (hl),d			;62ed
	ex de,hl			;62ee
	ld h,b			;62ef
	ld l,c			;62f0
	jr L_62D9		;62f1
L_62F3:
	and 009h		;62f3
	ld b,a			;62f5
	ld c,0f6h		;62f6
	ld a,(iy+001h)		;62f8
	and 003h		;62fb
	jr z,L_6306		;62fd
L_62FF:
	rlc b		;62ff
	rlc c		;6301
	dec a			;6303
	jr nz,L_62FF		;6304
L_6306:
	ld de,0d168h		;6306
	ld a,(de)			;6309
	and c			;630a
	or b			;630b
	ld (de),a			;630c
	jp L_6259		;630d
L_6310:
	call L_63DA		;6310
	inc de			;6313
	ex de,hl			;6314
	ld (hl),e			;6315
	inc hl			;6316
	ld (hl),d			;6317
	inc hl			;6318
	sub 090h		;6319
	ld (hl),a			;631b
	ex de,hl			;631c
	jr L_62D9		;631d
L_631F:
	call L_63DA		;631f
	ld a,(de)			;6322
	dec a			;6323
	jr z,L_6330		;6324
	ld (de),a			;6326
	dec de			;6327
	ld a,(de)			;6328
	dec de			;6329
	ld h,a			;632a
	ld a,(de)			;632b
	ld l,a			;632c
	jp L_6259		;632d
L_6330:
	dec de			;6330
	dec de			;6331
	dec de			;6332
	jr L_62D9		;6333
L_6335:
	ld a,(hl)			;6335
	inc hl			;6336
	add a,a			;6337
	ld bc,06526h		;6338
	add a,c			;633b
	ld c,a			;633c
	jr nc,L_6340		;633d
	inc b			;633f
L_6340:
	ld a,(bc)			;6340
	inc bc			;6341
	ld (iy+00ch),a		;6342
	ld a,(bc)			;6345
	ld (iy+00dh),a		;6346
	jp L_6259		;6349
L_634C:
	ld a,(hl)			;634c
	inc hl			;634d
	add a,a			;634e
	ld bc,06571h		;634f
	add a,c			;6352
	ld c,a			;6353
	jr nc,L_6357		;6354
	inc b			;6356
L_6357:
	ld a,(bc)			;6357
	inc bc			;6358
	ld (iy+00eh),a		;6359
	ld a,(bc)			;635c
	ld (iy+00fh),a		;635d
	jp L_6259		;6360
L_6363:
	ld (iy+002h),a		;6363
	ld a,(hl)			;6366
	inc hl			;6367
	or a			;6368
	jp m,L_639C		;6369
	ld d,a			;636c
	ld a,(hl)			;636d
	inc hl			;636e
	ld e,a			;636f
	push hl			;6370
	call L_63C0		;6371
	ld (iy+015h),e		;6374
	ld (iy+016h),d		;6377
	ld a,(iy+003h)		;637a
	ld (iy+012h),a		;637d
	ld e,a			;6380
	call L_63A7		;6381
	pop hl			;6384
	sub a			;6385
	ld (iy+005h),a		;6386
	ld (iy+008h),a		;6389
	inc a			;638c
L_638D:
	ld (iy+004h),a		;638d
	ld (iy+007h),a		;6390
	ld (iy+009h),a		;6393
	ld (iy+006h),a		;6396
	jp L_6288		;6399
L_639C:
	push hl			;639c
	ld e,000h		;639d
	call L_63A7		;639f
	pop hl			;63a2
	ld a,0ffh		;63a3
	jr L_638D		;63a5
L_63A7:
	ld a,008h		;63a7
	add a,(iy+001h)		;63a9
	ld c,a			;63ac
	jp p,L_63B8		;63ad
	and 00fh		;63b0
	ld c,a			;63b2
	ld a,(0d0d9h)		;63b3
	or a			;63b6
	ret nz			;63b7
L_63B8:
	ld b,000h		;63b8
	ld hl,0d161h		;63ba
	add hl,bc			;63bd
	ld (hl),e			;63be
	ret			;63bf
L_63C0:
	ld a,(iy+001h)		;63c0
	add a,a			;63c3
	ld c,a			;63c4
	jp p,L_63D0		;63c5
	and 00fh		;63c8
	ld c,a			;63ca
	ld a,(0d0d9h)		;63cb
	or a			;63ce
	ret nz			;63cf
L_63D0:
	ld b,000h		;63d0
	ld hl,0d161h		;63d2
	add hl,bc			;63d5
	ld (hl),e			;63d6
	inc hl			;63d7
	ld (hl),d			;63d8
	ret			;63d9
L_63DA:
	ld e,(iy+00ah)		;63da
	ld d,(iy+00bh)		;63dd
	ret			;63e0
L_63E1:
	push hl			;63e1
	push de			;63e2
	push bc			;63e3
	ld hl,0d069h		;63e4
	bit 0,(hl)		;63e7
	jr nz,L_640B		;63e9
	ld hl,064b1h		;63eb
	ld de,0d0d9h		;63ee
	ld bc,00010h		;63f1
	ldir		;63f4
	add a,a			;63f6
	ld c,a			;63f7
	ld b,000h		;63f8
	ld hl,064cch		;63fa
	add hl,bc			;63fd
	ldi		;63fe
	ldi		;6400
	ld hl,0d168h		;6402
	ld a,(hl)			;6405
	and 03dh		;6406
	or 090h		;6408
	ld (hl),a			;640a
L_640B:
	pop bc			;640b
	pop de			;640c
	pop hl			;640d
	ret			;640e
L_640F:
	push hl			;640f
	push de			;6410
	push bc			;6411
	ld hl,0d069h		;6412
	bit 0,(hl)		;6415
	jr nz,L_640B		;6417
	ld hl,0d068h		;6419
	bit 7,(hl)		;641c
	ld (hl),a			;641e
	jr nz,L_6430		;641f
	bit 7,a		;6421
	jr z,L_6430		;6423
	ld hl,0d06ah		;6425
	ld de,0d0f2h		;6428
	ld bc,0006fh		;642b
	ldir		;642e
L_6430:
	add a,a			;6430
	ld c,a			;6431
	add a,a			;6432
	add a,c			;6433
	ld c,a			;6434
	ld b,000h		;6435
	ld hl,064f0h		;6437
	add hl,bc			;643a
	ld a,003h		;643b
	ld de,0d09eh		;643d
L_6440:
	ldi		;6440
	ldi		;6442
	ld bc,00017h		;6444
	ex de,hl			;6447
	add hl,bc			;6448
	ex de,hl			;6449
	dec a			;644a
	jr nz,L_6440		;644b
	ld hl,06481h		;644d
	ld de,0d08eh		;6450
	ld a,003h		;6453
L_6455:
	ld bc,00010h		;6455
	ldir		;6458
	ld bc,00009h		;645a
	ex de,hl			;645d
	add hl,bc			;645e
	ex de,hl			;645f
	dec a			;6460
	jr nz,L_6455		;6461
	ld a,0b8h		;6463
	ld (0d168h),a		;6465
	pop bc			;6468
	pop de			;6469
	pop hl			;646a
	ret			;646b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x646c..0x64c4  (88 bytes)
DATA_646C:
	defb 03eh,080h,032h,069h,0d0h,03eh,007h,01eh,0bfh,0c3h,0c4h,064h,097h,032h,069h,0d0h	; 646c  >.2i.>.....d.2i.
	defb 0c9h,03eh,001h,018h,0f8h,0ffh,000h,001h,00bh,001h,000h,001h,001h,000h,001h,06ah	; 647c  .>.............j
	defb 0d0h,0c1h,064h,0c1h,064h,0ffh,0c1h,001h,00bh,001h,000h,001h,001h,000h,001h,076h	; 648c  ..d.d..........v
	defb 0d0h,0c1h,064h,0c1h,064h,0ffh,002h,001h,00bh,001h,000h,001h,001h,000h,001h,082h	; 649c  ..d.d...........
	defb 0d0h,0c1h,064h,0c1h,064h,0ffh,001h,001h,00bh,001h,000h,001h,001h,000h,001h,06ch	; 64ac  ..d.d..........l
	defb 0d1h,0c1h,064h,0c1h,064h,0f0h,000h,000h	; 64bc  ..d.d...

; ======================================================================
; CODIGO 0x64c4..0x64cc  (8 bytes)
; ======================================================================


L_64C4:
	out (0a0h),a		;64c4
	push af			;64c6
	ld a,e			;64c7
	out (0a1h),a		;64c8
	pop af			;64ca
	ret			;64cb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x64cc..0x8000  (6964 bytes)
DATA_64CC:
	defb 0d6h,065h,0d7h,065h,0eah,065h,00bh,066h,03bh,066h,04ch,066h,073h,066h,094h,066h	; 64cc  .e.e.e.f;fLfsf.f
	defb 0b4h,066h,0cah,066h,043h,067h,05bh,067h,08dh,067h,0a6h,067h,0fch,067h,058h,068h	; 64dc  .f.fCg[g.g.g.gXh
	defb 0c6h,068h,0dfh,068h,0d6h,065h,0d6h,065h,0d6h,065h,0e5h,069h,07bh,06ah,0f6h,06ah	; 64ec  .h.h.e.e.e.i{j.j
	defb 0a9h,06bh,0adh,06ch,0b5h,06eh,051h,072h,00ah,078h,07dh,07bh,0dfh,07eh,075h,081h	; 64fc  .k.l.nQr.x}{.~u.
	defb 053h,083h,052h,085h,073h,087h,0f8h,089h,047h,08ch,065h,08ch,083h,08ch,0a9h,08ch	; 650c  S.R.s...G.e.....
	defb 01bh,08dh,0bah,08dh,059h,08eh,0eeh,08eh,083h,08fh,03ch,065h,041h,065h,04ah,065h	; 651c  ....Y.....<eAeJe
	defb 04dh,065h,052h,065h,055h,065h,05ah,065h,05fh,065h,064h,065h,067h,065h,06ch,065h	; 652c  MeReUeZe_edegele
	defb 021h,0ffh,011h,001h,000h,000h,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,000h,002h,0ffh	; 653c  !...............
	defb 000h,0ffh,0ffh,012h,001h,000h,001h,0ffh,000h,005h,0ffh,011h,001h,000h,003h,0ffh	; 654c  ................
	defb 012h,001h,000h,023h,0ffh,056h,006h,000h,021h,000h,000h,011h,0efh,011h,008h,000h	; 655c  ...#.V..!.......
	defb 002h,0ffh,011h,001h,000h,08bh,065h,08eh,065h,095h,065h,09ch,065h,0a3h,065h,0aah	; 656c  ......e.e.e.e.e.
	defb 065h,0b1h,065h,0b6h,065h,0b9h,065h,0c0h,065h,0c7h,065h,0ceh,065h,0d3h,065h,0f0h	; 657c  e.e.e.e.e.e.e.e.
	defb 000h,000h,022h,001h,023h,0ffh,024h,000h,000h,011h,001h,0efh,000h,011h,000h,000h	; 658c  ..".#.$.........
	defb 011h,009h,022h,0f0h,012h,0ffh,000h,022h,001h,022h,0ffh,022h,000h,000h,011h,00ah	; 659c  .."...."."."....
	defb 011h,0f6h,011h,000h,000h,012h,045h,011h,012h,000h,011h,04ah,000h,022h,001h,022h	; 65ac  ......E....J."."
	defb 0ffh,022h,000h,000h,022h,0fdh,022h,0fdh,000h,000h,000h,011h,004h,011h,002h,011h	; 65bc  ."..".".........
	defb 012h,000h,011h,067h,012h,012h,000h,011h,0fch,000h,000h,080h,004h,0e0h,081h,002h	; 65cc  ...g............
	defb 0fch,0dfh,004h,000h,020h,0c4h,00ch,000h,01fh,081h,000h,0e8h,000h,000h,0fbh,080h	; 65dc  .... ...........
	defb 008h,0e1h,0cfh,004h,000h,078h,002h,0ffh,0c4h,002h,002h,034h,0c5h,001h,002h,034h	; 65ec  .....x.....4...4
	defb 0c6h,002h,002h,034h,0c9h,001h,002h,034h,0cah,004h,002h,034h,0e8h,000h,000h,080h	; 65fc  ...4...4...4....
	defb 004h,0cch,0e1h,0f7h,001h,000h,090h,0f8h,001h,000h,090h,0f9h,001h,000h,090h,0cbh	; 660c  ................
	defb 0fah,001h,000h,090h,0cah,0fbh,001h,000h,090h,0f8h,001h,000h,090h,0c9h,0f6h,001h	; 661c  ................
	defb 000h,090h,0c8h,0f4h,001h,000h,090h,0c7h,0f6h,006h,000h,090h,0e8h,000h,000h,080h	; 662c  ................
	defb 009h,0fah,0e1h,0c4h,001h,000h,090h,002h,0ffh,0cch,003h,000h,090h,0e8h,000h,000h	; 663c  ................
	defb 080h,005h,0e0h,081h,003h,0fch,0deh,002h,004h,000h,0e8h,001h,000h,080h,0fah,001h	; 664c  ................
	defb 004h,000h,001h,000h,080h,001h,000h,060h,002h,005h,000h,001h,000h,080h,001h,003h	; 665c  .......`........
	defb 000h,001h,000h,060h,081h,000h,000h,080h,008h,0e1h,0fch,0c8h,005h,000h,090h,0e8h	; 666c  ...`............
	defb 080h,008h,0fch,081h,004h,007h,000h,024h,007h,000h,028h,007h,000h,024h,080h,005h	; 667c  .......$..(..$..
	defb 081h,004h,030h,000h,028h,081h,000h,000h,080h,005h,0fbh,081h,004h,002h,000h,026h	; 668c  ..0.(..........&
	defb 002h,000h,022h,002h,000h,026h,002h,000h,022h,002h,000h,026h,002h,000h,022h,002h	; 669c  .."..&.."..&..".
	defb 000h,026h,030h,000h,024h,081h,000h,000h,080h,008h,0e1h,0c7h,0fbh,004h,000h,090h	; 66ac  .&0.$...........
	defb 001h,0ffh,0e8h,080h,005h,081h,005h,0fch,032h,000h,014h,081h,000h,000h,080h,009h	; 66bc  ........2.......
	defb 0c4h,0e1h,0f7h,005h,000h,090h,0cch,0fah,001h,000h,090h,0c6h,007h,000h,090h,0cch	; 66cc  ................
	defb 0fah,004h,000h,090h,003h,0ffh,0c4h,0f6h,001h,000h,090h,001h,0ffh,0fbh,004h,000h	; 66dc  ................
	defb 090h,004h,0ffh,0c8h,0f9h,004h,000h,090h,003h,0ffh,0c4h,0fbh,004h,000h,090h,004h	; 66ec  ................
	defb 0ffh,0c7h,0fah,004h,000h,090h,003h,0ffh,0c4h,0f5h,001h,000h,090h,001h,0ffh,0fbh	; 66fc  ................
	defb 004h,000h,090h,004h,0ffh,0c9h,0f9h,004h,000h,090h,003h,0ffh,0c5h,0fbh,004h,000h	; 670c  ................
	defb 090h,004h,0ffh,0f9h,0cah,004h,000h,090h,003h,0ffh,0c5h,0fah,004h,000h,090h,004h	; 671c  ................
	defb 0ffh,0c8h,0f7h,004h,000h,090h,004h,0ffh,0f9h,0c5h,004h,000h,090h,004h,0ffh,0f8h	; 672c  ................
	defb 0c8h,004h,000h,090h,0e8h,000h,000h,0fdh,0e0h,081h,006h,080h,004h,0deh,002h,004h	; 673c  ................
	defb 000h,001h,0ffh,002h,002h,000h,001h,0ffh,012h,003h,000h,0e8h,081h,000h,000h,0e0h	; 674c  ................
	defb 081h,005h,080h,008h,0fch,0d7h,002h,003h,090h,0c5h,002h,003h,000h,0d2h,002h,003h	; 675c  ................
	defb 090h,0c5h,002h,003h,090h,0d0h,002h,003h,000h,0c5h,002h,003h,090h,0cch,001h,003h	; 676c  ................
	defb 000h,0c5h,001h,003h,090h,0c7h,001h,003h,000h,0c5h,001h,003h,090h,0e8h,081h,000h	; 677c  ................
	defb 000h,080h,005h,081h,007h,0fbh,0cch,0e1h,002h,003h,000h,0e8h,001h,003h,000h,0fbh	; 678c  ................
	defb 001h,003h,000h,0fdh,014h,002h,000h,081h,000h,000h,080h,008h,0c5h,0fbh,081h,005h	; 679c  ................
	defb 0e0h,008h,000h,030h,0c7h,002h,000h,02fh,0c9h,002h,000h,02eh,0cbh,002h,000h,02dh	; 67ac  ...0.../.......-
	defb 0cdh,002h,000h,02ch,0cfh,002h,000h,02bh,0d1h,001h,000h,029h,0cfh,001h,000h,027h	; 67bc  ...,...+...)...'
	defb 0ceh,001h,000h,025h,0cdh,001h,000h,023h,0cch,001h,000h,021h,0cbh,001h,000h,01fh	; 67cc  ...%...#...!....
	defb 0cah,001h,000h,01dh,0c9h,001h,000h,01bh,0c8h,001h,000h,019h,0c7h,001h,000h,017h	; 67dc  ................
	defb 0c6h,001h,000h,015h,0c5h,002h,000h,013h,0c4h,002h,000h,011h,0e8h,081h,000h,000h	; 67ec  ................
	defb 0fch,0e0h,080h,008h,081h,00ah,0dfh,002h,000h,060h,002h,000h,05eh,002h,000h,05ch	; 67fc  .........`..^..\
	defb 0c7h,002h,000h,05ah,0cch,002h,000h,058h,0cah,001h,000h,056h,0c8h,001h,000h,058h	; 680c  ...Z...X...V...X
	defb 0c6h,004h,000h,05ah,0c4h,002h,000h,05ch,0c6h,002h,000h,05dh,0c8h,002h,000h,060h	; 681c  ...Z...\...]...`
	defb 0cah,002h,000h,064h,0cch,002h,000h,068h,0ceh,002h,000h,06ah,0d0h,001h,000h,06dh	; 682c  ...d...h...j...m
	defb 0d2h,001h,000h,070h,0d4h,001h,000h,074h,0d8h,001h,000h,078h,001h,000h,07ah,001h	; 683c  ...p...t...x..z.
	defb 000h,07eh,001h,000h,085h,001h,000h,08ah,0e8h,081h,000h,000h,0e0h,0fbh,080h,008h	; 684c  .~..............
	defb 081h,00bh,0d8h,002h,005h,020h,0d4h,002h,003h,000h,0d2h,002h,005h,020h,0cah,002h	; 685c  ..... ....... ..
	defb 002h,000h,0c8h,002h,005h,020h,0c7h,002h,003h,000h,0c6h,002h,006h,000h,0c5h,002h	; 686c  ..... ..........
	defb 004h,050h,0c4h,002h,002h,020h,0c3h,002h,005h,060h,0c2h,008h,002h,050h,0c3h,003h	; 687c  .P... ...`...P..
	defb 003h,000h,0c4h,003h,003h,020h,0c5h,003h,003h,030h,0c6h,002h,003h,040h,0cah,002h	; 688c  ..... ...0...@..
	defb 003h,050h,0cch,002h,003h,060h,0ceh,002h,003h,070h,0d0h,002h,003h,080h,0d2h,002h	; 689c  .P...`...p......
	defb 003h,090h,0d4h,002h,003h,0a0h,0d6h,002h,003h,0b0h,0d8h,002h,003h,0c0h,0dah,002h	; 68ac  ................
	defb 003h,0d0h,0dch,002h,003h,0e0h,0e8h,081h,000h,000h,080h,008h,0c6h,0e0h,0fdh,001h	; 68bc  ................
	defb 003h,000h,002h,0ffh,0c6h,0f9h,001h,000h,040h,0fbh,001h,000h,045h,001h,000h,010h	; 68cc  ........@...E...
	defb 0e8h,000h,000h,080h,000h,0e1h,0fch,081h,00ch,0dch,001h,000h,090h,0cch,006h,000h	; 68dc  ................
	defb 070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h,0cah,001h,001h	; 68ec  p.......V...F...
	defb 023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h	; 68fc  #...E...4...E...
	defb 023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h,0ffh,0f9h,0dch,001h,000h,090h	; 690c  #...g...#.......
	defb 0cch,004h,000h,070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h	; 691c  ...p.......V...F
	defb 0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh,002h,000h,045h	; 692c  ...#...E...4...E
	defb 0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h,0ffh,0f6h,0dch	; 693c  ...#...g...#....
	defb 001h,000h,090h,0cch,002h,000h,070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h	; 694c  ......p.......V.
	defb 001h,000h,046h,0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh	; 695c  ..F...#...E...4.
	defb 002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h	; 696c  ..E...#...g...#.
	defb 0ffh,0f4h,0dch,001h,000h,090h,0cch,001h,000h,070h,0d9h,001h,000h,012h,0cbh,001h	; 697c  .........p......
	defb 000h,056h,0d7h,001h,000h,046h,0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h	; 698c  .V...F...#...E..
	defb 001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h	; 699c  .4...E...#...g..
	defb 000h,023h,004h,0ffh,0f1h,0dch,001h,000h,090h,0cch,001h,000h,070h,0d9h,001h,000h	; 69ac  .#..........p...
	defb 012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h,0cah,001h,001h,023h,0c6h,002h,000h	; 69bc  ....V...F...#...
	defb 045h,0cch,002h,001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h,005h	; 69cc  E...4...E...#...
	defb 067h,0c5h,002h,000h,023h,0e8h,081h,000h,000h,0fah,080h,000h,081h,008h,00ch,000h	; 69dc  g...#...........
	defb 0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh	; 69ec  ................
	defb 00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch	; 69fc  ................
	defb 000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h	; 6a0c  ................
	defb 0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah	; 6a1c  ................
	defb 00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch	; 6a2c  ................
	defb 000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h	; 6a3c  ................
	defb 07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h	; 6a4c  ................
	defb 00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch	; 6a5c  ................
	defb 000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,000h,000h,0f8h	; 6a6c  ................
	defb 081h,008h,080h,001h,048h,000h,030h,048h,000h,030h,0fah,080h,001h,081h,000h,048h	; 6a7c  ....H.0H.0.....H
	defb 005h,0fah,02eh,005h,0fah,00ah,005h,0fah,001h,005h,0fah,001h,005h,0fah,0fbh,001h	; 6a8c  ................
	defb 005h,0fah,001h,005h,0fah,0fch,001h,005h,0fah,003h,005h,0fah,0fbh,002h,005h,0fah	; 6a9c  ................
	defb 0fah,002h,005h,0fah,0f9h,002h,005h,0fah,0f8h,002h,005h,0fah,0f8h,081h,008h,080h	; 6aac  ................
	defb 001h,048h,000h,030h,048h,000h,030h,0fah,080h,001h,081h,000h,048h,005h,0fah,02eh	; 6abc  .H.0H.0.....H...
	defb 005h,0fah,00ah,005h,0fah,001h,005h,0fah,001h,005h,0fah,0fbh,001h,005h,0fah,001h	; 6acc  ................
	defb 005h,0fah,0fch,001h,005h,0fah,003h,005h,0fah,0fbh,002h,005h,0fah,0fah,002h,005h	; 6adc  ................
	defb 0fah,0f9h,002h,005h,0fah,0f8h,002h,005h,0fah,000h,0f8h,080h,000h,006h,0ffh,00ch	; 6aec  ................
	defb 000h,0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h	; 6afc  .......}........
	defb 07dh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh	; 6b0c  }........}......
	defb 006h,000h,07dh,0fah,080h,001h,048h,005h,0f4h,02eh,005h,0f4h,00ah,005h,0f4h,001h	; 6b1c  ..}...H.........
	defb 005h,0f4h,001h,005h,0f4h,0fbh,001h,005h,0f4h,001h,005h,0f4h,0fch,001h,005h,0f4h	; 6b2c  ................
	defb 003h,005h,0f4h,0fbh,002h,005h,0f4h,0fah,002h,005h,0f4h,0f9h,002h,005h,0f4h,0f8h	; 6b3c  ................
	defb 002h,005h,0f4h,080h,000h,0f8h,006h,0ffh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h	; 6b4c  ................
	defb 07dh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh	; 6b5c  }........}......
	defb 00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh,006h,000h,07dh,080h,001h,0fah,048h	; 6b6c  ..}........}...H
	defb 005h,0f4h,02eh,005h,0f4h,00ah,005h,0f4h,001h,005h,0f4h,001h,005h,0f4h,0fbh,001h	; 6b7c  ................
	defb 005h,0f4h,001h,005h,0f4h,0fch,001h,005h,0f4h,003h,005h,0f4h,0fbh,002h,005h,0f4h	; 6b8c  ................
	defb 0fah,002h,005h,0f4h,0f9h,002h,005h,0f4h,0f8h,002h,005h,0f4h,000h,098h,0fch,080h	; 6b9c  ................
	defb 002h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah	; 6bac  ................
	defb 006h,005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h	; 6bbc  ................
	defb 005h,0f4h,080h,001h,00ch,002h,0fah,085h,082h,0d7h,06bh,0a0h,0fch,080h,002h,006h	; 6bcc  ..........k.....
	defb 005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah,006h,005h	; 6bdc  ................
	defb 0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h	; 6bec  ................
	defb 080h,001h,00ch,002h,0fah,085h,094h,0fch,080h,002h,006h,006h,0aeh,006h,006h,0aeh	; 6bfc  ................
	defb 006h,006h,0aeh,006h,006h,0aeh,00ch,003h,057h,006h,006h,0aeh,006h,006h,0aeh,00ch	; 6c0c  ........W.......
	defb 006h,0aeh,00ch,003h,057h,006h,006h,0aeh,006h,006h,0aeh,080h,001h,00ch,003h,057h	; 6c1c  ....W..........W
	defb 085h,093h,0fdh,080h,002h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h	; 6c2c  ................
	defb 0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah	; 6c3c  ................
	defb 006h,005h,0f4h,006h,005h,0f4h,080h,001h,00ch,002h,0fah,085h,080h,002h,0fdh,006h	; 6c4c  ................
	defb 005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah,0fch,006h	; 6c5c  ................
	defb 005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h	; 6c6c  ................
	defb 0f4h,080h,001h,00ch,002h,0fah,080h,002h,006h,005h,0f4h,006h,005h,0f4h,006h,005h	; 6c7c  ................
	defb 0f4h,006h,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h	; 6c8c  ................
	defb 00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,080h,001h,00ch,002h,0fah,082h,0d7h	; 6c9c  ................
	defb 06bh,080h,005h,0f7h,018h,0ffh,00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch	; 6cac  k.......0..@<.0.
	defb 000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h,03ch,000h	; 6cbc  .0..@<.0..0..@<.
	defb 030h,00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h	; 6ccc  0..0..@<.0..0..@
	defb 03ch,000h,030h,00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h	; 6cdc  <.0..0..@<.0..0.
	defb 000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h,024h,000h,030h,082h,0fdh	; 6cec  .@<.0..0..@$.0..
	defb 06ch,080h,005h,0f7h,081h,000h,018h,0ffh,024h,000h,028h,018h,000h,040h,024h,000h	; 6cfc  l.......$.(..@$.
	defb 028h,024h,000h,02ah,018h,000h,030h,024h,000h,02ah,024h,000h,028h,018h,000h,040h	; 6d0c  ($.*..0$.*$.(..@
	defb 024h,000h,028h,024h,000h,030h,018h,000h,035h,024h,000h,030h,024h,000h,030h,018h	; 6d1c  $.($.0..5$.0$.0.
	defb 000h,028h,024h,000h,040h,024h,000h,024h,018h,000h,02ah,024h,000h,028h,024h,000h	; 6d2c  .($.@$.$..*$.($.
	defb 030h,018h,000h,035h,024h,000h,030h,024h,000h,030h,018h,000h,035h,024h,000h,030h	; 6d3c  0..5$.0$.0..5$.0
	defb 024h,000h,028h,018h,000h,040h,024h,000h,028h,024h,000h,02ah,018h,000h,030h,024h	; 6d4c  $.(..@$.($.*..0$
	defb 000h,02ah,024h,000h,028h,018h,000h,040h,024h,000h,028h,024h,000h,030h,018h,000h	; 6d5c  .*$.(..@$.($.0..
	defb 035h,024h,000h,030h,024h,000h,030h,018h,000h,02ah,024h,000h,040h,024h,000h,024h	; 6d6c  5$.0$.0..*$.@$.$
	defb 018h,000h,02ah,018h,000h,028h,080h,004h,0fah,006h,000h,028h,006h,000h,02ah,006h	; 6d7c  ..*..(.....(..*.
	defb 000h,028h,006h,000h,02ah,006h,000h,028h,006h,000h,030h,006h,000h,028h,0f9h,006h	; 6d8c  .(..*..(..0..(..
	defb 000h,02ah,006h,000h,028h,006h,000h,02ah,0f8h,006h,000h,028h,006h,000h,02ah,006h	; 6d9c  .*..(..*...(..*.
	defb 000h,028h,006h,000h,030h,0f7h,006h,000h,028h,006h,000h,02ah,006h,000h,028h,0f6h	; 6dac  .(..0...(..*..(.
	defb 006h,000h,02ah,006h,000h,028h,006h,000h,02ah,006h,000h,028h,006h,000h,030h,006h	; 6dbc  ..*..(..*..(..0.
	defb 000h,02ah,006h,000h,028h,0f9h,080h,000h,006h,000h,047h,006h,000h,040h,006h,000h	; 6dcc  .*..(.....G..@..
	defb 03ch,006h,000h,035h,006h,000h,030h,006h,000h,024h,080h,001h,081h,008h,0f9h,060h	; 6ddc  <..5..0..$.....`
	defb 000h,02ah,060h,000h,02ah,080h,004h,0f6h,00ch,000h,06bh,00ch,000h,055h,00ch,000h	; 6dec  .*`.*.....k..U..
	defb 050h,0f7h,00ch,000h,055h,00ch,000h,047h,00ch,000h,055h,0f8h,00ch,000h,050h,00ch	; 6dfc  P...U..G..U...P.
	defb 000h,055h,0f9h,00ch,000h,06bh,00ch,000h,055h,0fah,00ch,000h,050h,00ch,000h,055h	; 6e0c  .U...k..U...P..U
	defb 00ch,000h,047h,0fbh,00ch,000h,050h,0fbh,00ch,000h,055h,080h,000h,081h,000h,018h	; 6e1c  ..G...P...U.....
	defb 001h,07dh,002h,0ffh,00ch,001h,040h,00ch,000h,0feh,00ch,001h,040h,00ch,000h,0beh	; 6e2c  .}....@.....@...
	defb 00ch,001h,01dh,00ch,000h,0e2h,018h,001h,07dh,00ch,001h,040h,00ch,000h,0feh,00ch	; 6e3c  ........}..@....
	defb 001h,040h,00ch,000h,0beh,00ch,001h,01dh,00ch,000h,0e2h,018h,001h,07dh,00ch,001h	; 6e4c  .@...........}..
	defb 040h,00ch,000h,0feh,00ch,001h,040h,00ch,000h,0beh,00ch,001h,01dh,00ah,000h,0e2h	; 6e5c  @.....@.........
	defb 080h,001h,0fah,081h,001h,00ch,001h,0fch,080h,002h,0fdh,006h,001h,0fch,006h,001h	; 6e6c  ................
	defb 0fch,006h,001h,0fch,006h,001h,0fch,00ch,001h,0fch,080h,001h,0fbh,012h,001h,0fch	; 6e7c  ................
	defb 0fah,00fh,001h,0fch,00fh,001h,0fch,0f9h,00ch,001h,0fch,00ch,001h,0fch,0f8h,00ch	; 6e8c  ................
	defb 001h,0fch,00ch,001h,0fch,00ch,001h,0fch,0f7h,00ch,001h,0fch,00ch,001h,0fch,0f6h	; 6e9c  ................
	defb 00ch,001h,0fch,00ch,001h,0fch,082h,0fdh,06ch,0f8h,080h,001h,081h,008h,060h,000h	; 6eac  ........l.....`.
	defb 055h,060h,000h,055h,060h,000h,05fh,060h,000h,05fh,060h,000h,055h,048h,000h,055h	; 6ebc  U`.U`._`._`.UH.U
	defb 0f9h,014h,000h,05fh,002h,000h,05eh,002h,000h,05dh,002h,000h,05ch,002h,000h,05bh	; 6ecc  ..._..^..]..\..[
	defb 002h,000h,05ah,002h,000h,059h,002h,000h,058h,002h,000h,057h,002h,000h,056h,002h	; 6edc  ..Z..Y..X..W..V.
	defb 000h,055h,050h,000h,055h,080h,003h,032h,000h,055h,0e1h,0c5h,0f4h,001h,000h,056h	; 6eec  .UP.U..2.U.....V
	defb 001h,000h,056h,001h,000h,056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 6efc  ..V..V...V..V..V
	defb 001h,000h,056h,0f6h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 6f0c  ..V...V..V..V..V
	defb 0f7h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h	; 6f1c  ...V..V..V..V...
	defb 056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h	; 6f2c  V..V..V..V...V..
	defb 056h,001h,000h,056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h,056h,001h,000h	; 6f3c  V..V..V...V..V..
	defb 056h,001h,000h,056h,001h,000h,056h,0fbh,003h,000h,056h,003h,000h,056h,00ch,000h	; 6f4c  V..V..V...V..V..
	defb 056h,082h,060h,06fh,0fbh,0e8h,081h,008h,080h,004h,00ch,000h,05fh,00ch,000h,07fh	; 6f5c  V.`o........_...
	defb 00ch,000h,08fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,018h,000h,0beh,048h	; 6f6c  ...............H
	defb 0ffh,080h,001h,0f9h,018h,001h,0ach,018h,001h,07dh,080h,006h,006h,000h,05fh,006h	; 6f7c  .........}...._.
	defb 000h,05fh,006h,000h,05fh,00ch,000h,040h,0e1h,0cfh,0f4h,001h,000h,056h,001h,000h	; 6f8c  ._.._..@.....V..
	defb 056h,001h,000h,056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h	; 6f9c  V..V...V..V..V..
	defb 056h,0f6h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f7h,001h	; 6fac  V...V..V..V..V..
	defb 000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h,056h,001h	; 6fbc  .V..V..V..V...V.
	defb 000h,056h,001h,000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h,056h,001h	; 6fcc  .V..V..V...V..V.
	defb 000h,056h,001h,000h,056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h,056h,001h	; 6fdc  .V..V..V...V..V.
	defb 000h,056h,0fbh,001h,000h,056h,001h,000h,056h,003h,000h,056h,00ah,000h,056h,0e8h	; 6fec  .V...V..V..V..V.
	defb 0fbh,080h,004h,00ch,000h,05fh,00ch,000h,07fh,00ch,000h,08fh,00ch,000h,0a0h,00ch	; 6ffc  ....._..........
	defb 000h,08fh,00ch,000h,07fh,018h,000h,06bh,00ch,0ffh,0fch,080h,004h,00ch,000h,078h	; 700c  .......k.......x
	defb 00ch,0ffh,080h,001h,0fah,024h,001h,0e0h,00ch,001h,0fch,00ch,0ffh,080h,000h,0fch	; 701c  .....$..........
	defb 018h,000h,07fh,00ch,0ffh,080h,001h,0fbh,024h,001h,0fch,080h,002h,0fdh,00ch,002h	; 702c  ........$.......
	defb 081h,080h,005h,054h,002h,0fah,0f9h,080h,006h,006h,000h,05fh,006h,000h,055h,006h	; 703c  ...T......._..U.
	defb 000h,05fh,006h,000h,051h,060h,000h,050h,0fbh,0e8h,080h,004h,00ch,000h,05fh,00ch	; 704c  ._..Q`.P......_.
	defb 000h,07fh,00ch,000h,08fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,018h,000h	; 705c  ................
	defb 0beh,048h,0ffh,080h,001h,0f9h,012h,001h,0ach,001h,001h,0aah,001h,001h,0a8h,001h	; 706c  .H..............
	defb 001h,0a5h,001h,001h,0a0h,001h,001h,09eh,001h,001h,09ch,001h,001h,098h,001h,001h	; 707c  ................
	defb 093h,001h,001h,090h,001h,001h,08eh,001h,001h,08ch,001h,001h,088h,001h,001h,084h	; 708c  ................
	defb 001h,001h,080h,001h,001h,07fh,001h,001h,07eh,00eh,001h,07dh,080h,006h,006h,000h	; 709c  ........~..}....
	defb 05fh,006h,000h,05fh,006h,000h,05fh,00ch,000h,040h,0e1h,0cfh,0f4h,001h,000h,056h	; 70ac  _.._.._..@.....V
	defb 001h,000h,056h,001h,000h,056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 70bc  ..V..V...V..V..V
	defb 001h,000h,056h,0f6h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 70cc  ..V...V..V..V..V
	defb 0f7h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h	; 70dc  ...V..V..V..V...
	defb 056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h	; 70ec  V..V..V..V...V..
	defb 056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h	; 70fc  V..V..V..V...V..
	defb 056h,001h,000h,056h,0fbh,001h,000h,056h,001h,000h,056h,003h,000h,056h,00ah,000h	; 710c  V..V...V..V..V..
	defb 056h,0e8h,0fbh,080h,004h,00ch,000h,05fh,00ch,000h,07fh,00ch,000h,08fh,00ch,000h	; 711c  V......_........
	defb 0a0h,00ch,000h,08fh,00ch,000h,07fh,018h,000h,06bh,00ch,0ffh,080h,004h,0fch,00ch	; 712c  .........k......
	defb 000h,078h,00ch,0ffh,080h,001h,0fah,024h,001h,0e0h,00ch,001h,0fch,00ch,0ffh,080h	; 713c  .x.....$........
	defb 000h,0fch,018h,000h,07fh,00ch,0ffh,080h,001h,0fah,024h,001h,0fch,080h,002h,0fdh	; 714c  ..........$.....
	defb 00ch,002h,081h,080h,001h,00ch,002h,0fah,0fch,030h,002h,0fah,0fbh,018h,002h,0fah	; 715c  .........0......
	defb 0fah,018h,002h,0fah,0f9h,03ch,002h,081h,080h,000h,006h,002h,03bh,0f9h,006h,001h	; 716c  .....<......;...
	defb 0fch,006h,001h,0e0h,0fah,006h,001h,0ach,006h,001h,07dh,0fbh,006h,001h,050h,00ch	; 717c  ..........}...P.
	defb 001h,040h,0fch,00ch,001h,050h,00ch,001h,0ach,080h,001h,00ch,002h,03bh,030h,002h	; 718c  .@...P.......;0.
	defb 03bh,054h,002h,03bh,080h,000h,006h,000h,0aah,0f9h,006h,000h,0a0h,080h,005h,012h	; 719c  ;T.;............
	defb 000h,0aah,018h,000h,0d6h,0fah,012h,001h,01dh,018h,001h,040h,0fbh,080h,006h,018h	; 71ac  ...........@....
	defb 001h,050h,080h,005h,00ch,001h,01dh,080h,001h,0fah,012h,001h,01dh,0f9h,004h,001h	; 71bc  .P..............
	defb 01dh,004h,001h,01dh,0f7h,005h,001h,01dh,005h,001h,01dh,005h,001h,01dh,0f6h,004h	; 71cc  ................
	defb 001h,01dh,003h,001h,01dh,0fch,080h,005h,00ch,000h,0aah,0fdh,018h,000h,0beh,080h	; 71dc  ................
	defb 004h,0fch,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,05fh,00ch,000h	; 71ec  ............._..
	defb 08fh,00ch,000h,071h,080h,005h,0fdh,018h,000h,0beh,080h,004h,0fch,00ch,000h,0a0h	; 71fc  ...q............
	defb 00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,05fh,00ch,000h,08fh,00ch,000h,071h,080h	; 720c  ........_.....q.
	defb 005h,0fdh,018h,000h,0beh,080h,004h,0fch,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h	; 721c  ................
	defb 0a0h,00ch,000h,05fh,00ch,000h,08fh,00ch,000h,071h,080h,001h,00ch,000h,07fh,018h	; 722c  ..._.....q......
	defb 000h,07fh,0fch,018h,000h,07fh,0fbh,030h,000h,07fh,0fah,030h,000h,07fh,0f9h,030h	; 723c  .......0...0...0
	defb 000h,07fh,082h,060h,06fh,080h,005h,0fbh,070h,0ffh,038h,0ffh,00eh,0ffh,007h,000h	; 724c  ...`o...p.8.....
	defb 07fh,007h,000h,08fh,007h,000h,0a0h,007h,000h,0aah,00eh,0ffh,038h,0ffh,00eh,0ffh	; 725c  ............8...
	defb 007h,000h,07fh,007h,000h,08fh,007h,000h,07fh,015h,000h,071h,080h,008h,0f9h,070h	; 726c  ...........q...p
	defb 000h,06bh,020h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h	; 727c  .k .k..k..k..k..
	defb 06bh,002h,000h,06bh,0fah,002h,000h,06bh,002h,000h,06bh,00eh,000h,06bh,002h,000h	; 728c  k..k...k..k..k..
	defb 06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,0fbh,002h,000h	; 729c  k..k..k..k..k...
	defb 06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh	; 72ac  k..k..k..k..k..k
	defb 002h,000h,06bh,0fch,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh	; 72bc  ..k...k..k..k..k
	defb 002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,0fdh,080h,005h,01ch,000h,07fh,0fch	; 72cc  ..k..k..k.......
	defb 080h,004h,007h,000h,02ah,007h,000h,02ah,007h,000h,02ah,007h,000h,02ah,00eh,0ffh	; 72dc  ....*..*..*..*..
	defb 007h,000h,0aah,007h,000h,07fh,007h,000h,0beh,007h,000h,08fh,007h,000h,0d6h,00eh	; 72ec  ................
	defb 000h,0a0h,007h,0ffh,070h,0ffh,080h,008h,0f8h,038h,001h,0fch,01ch,001h,0fch,003h	; 72fc  ....p....8......
	defb 001h,0fch,0f9h,003h,001h,0fch,003h,001h,0fch,003h,001h,0fch,004h,001h,0fch,0fah	; 730c  ................
	defb 003h,001h,0fch,003h,001h,0fch,0fbh,003h,001h,0fch,003h,001h,0fch,0f8h,038h,001h	; 731c  ..............8.
	defb 0ach,01ch,001h,0ach,003h,001h,0ach,0f9h,003h,001h,0ach,003h,001h,0ach,003h,001h	; 732c  ................
	defb 0ach,004h,001h,0ach,0fah,003h,001h,0ach,003h,001h,0ach,0fbh,003h,001h,0ach,003h	; 733c  ................
	defb 001h,0ach,0f8h,038h,001h,0fch,01ch,001h,0fch,003h,001h,0fch,0f9h,003h,001h,0fch	; 734c  ...8............
	defb 003h,001h,0fch,003h,001h,0fch,004h,001h,0fch,0fah,003h,001h,0fch,003h,001h,0fch	; 735c  ................
	defb 0fbh,003h,001h,0fch,003h,001h,0fch,0f8h,038h,001h,0ach,01ch,001h,0ach,003h,001h	; 736c  ........8.......
	defb 0ach,0f9h,003h,001h,0ach,003h,001h,0ach,003h,001h,0ach,004h,001h,0ach,0fah,003h	; 737c  ................
	defb 001h,0ach,003h,001h,0ach,0fbh,003h,001h,0ach,003h,001h,0ach,080h,005h,0fdh,01ch	; 738c  ................
	defb 002h,0cfh,020h,002h,0cfh,080h,000h,0fah,006h,001h,07dh,00eh,001h,068h,020h,001h	; 739c  .. .......}..h .
	defb 068h,012h,001h,068h,00dh,001h,068h,00ch,001h,068h,00ah,001h,068h,009h,001h,068h	; 73ac  h..h..h..h..h..h
	defb 080h,003h,012h,001h,068h,006h,001h,07dh,006h,001h,068h,007h,001h,07dh,006h,001h	; 73bc  ....h..}..h..}..
	defb 068h,006h,001h,07dh,006h,001h,068h,010h,001h,07dh,080h,005h,0fdh,01ch,002h,0cfh	; 73cc  h..}..h..}......
	defb 01ch,002h,0cfh,080h,000h,0fah,006h,000h,0beh,00eh,000h,0b4h,01fh,000h,0b4h,012h	; 73dc  ................
	defb 000h,0b4h,00dh,000h,0b4h,00ch,000h,0b4h,00ah,000h,0b4h,009h,000h,0b4h,080h,003h	; 73ec  ................
	defb 00ch,000h,0b4h,008h,000h,0beh,007h,000h,0b4h,006h,000h,0beh,006h,000h,0b4h,005h	; 73fc  ................
	defb 000h,0beh,00ah,000h,0b4h,006h,000h,0beh,012h,000h,0b4h,00ah,000h,0beh,080h,008h	; 740c  ................
	defb 0f8h,038h,001h,0fch,01ch,001h,0fch,003h,001h,0fch,0f9h,003h,001h,0fch,003h,001h	; 741c  .8..............
	defb 0fch,003h,001h,0fch,004h,001h,0fch,0fah,003h,001h,0fch,003h,001h,0fch,0fbh,003h	; 742c  ................
	defb 001h,0fch,003h,001h,0fch,0f8h,038h,001h,0ach,01ch,001h,0ach,003h,001h,0ach,0f9h	; 743c  ......8.........
	defb 003h,001h,0ach,003h,001h,0ach,003h,001h,0ach,004h,001h,0ach,0fah,003h,001h,0ach	; 744c  ................
	defb 003h,001h,0ach,0fbh,003h,001h,0ach,003h,001h,0ach,0f8h,038h,001h,0fch,01ch,001h	; 745c  ...........8....
	defb 0fch,003h,001h,0fch,0f9h,003h,001h,0fch,003h,001h,0fch,003h,001h,0fch,004h,001h	; 746c  ................
	defb 0fch,0fah,003h,001h,0fch,003h,001h,0fch,0fbh,003h,001h,0fch,003h,001h,0fch,0f8h	; 747c  ................
	defb 038h,001h,0ach,01ch,001h,0ach,003h,001h,0ach,0f9h,003h,001h,0ach,003h,001h,0ach	; 748c  8...............
	defb 003h,001h,0ach,004h,001h,0ach,0fah,003h,001h,0ach,003h,001h,0ach,0fbh,003h,001h	; 749c  ................
	defb 0ach,003h,001h,0ach,080h,005h,0fdh,015h,002h,0cfh,023h,002h,0cfh,0fah,080h,004h	; 74ac  ..........#.....
	defb 005h,001h,07dh,006h,001h,07dh,080h,008h,008h,001h,069h,001h,001h,06ah,001h,001h	; 74bc  ..}..}....i..j..
	defb 06bh,001h,001h,06ch,001h,001h,06dh,001h,001h,06eh,001h,001h,06fh,001h,001h,070h	; 74cc  k..l..m..n..o..p
	defb 001h,001h,071h,001h,001h,072h,002h,001h,073h,002h,001h,074h,002h,001h,076h,002h	; 74dc  ..q..r..s..t..v.
	defb 001h,078h,002h,001h,079h,002h,001h,07ah,002h,001h,07bh,002h,001h,07ch,006h,001h	; 74ec  .x..y..z..{..|..
	defb 07dh,008h,001h,068h,00bh,000h,0f0h,02ch,000h,0f0h,003h,000h,0f1h,003h,000h,0f2h	; 74fc  }..h...,........
	defb 003h,000h,0f3h,003h,000h,0f4h,003h,000h,0f5h,003h,000h,0f6h,003h,000h,0f7h,003h	; 750c  ................
	defb 000h,0f8h,003h,000h,0f9h,003h,000h,0fah,003h,000h,0fbh,003h,000h,0fch,003h,000h	; 751c  ................
	defb 0fdh,003h,000h,0feh,003h,000h,0ffh,003h,001h,000h,004h,001h,002h,005h,001h,004h	; 752c  ................
	defb 080h,005h,0fdh,015h,002h,0cfh,023h,002h,0cfh,080h,004h,0fdh,003h,000h,08fh,003h	; 753c  ......#.........
	defb 000h,07fh,080h,003h,024h,000h,078h,0fah,007h,000h,07fh,007h,0ffh,007h,000h,08fh	; 754c  ....$.x.........
	defb 007h,0ffh,007h,000h,097h,007h,0ffh,007h,000h,0b4h,007h,0ffh,006h,000h,097h,006h	; 755c  ................
	defb 0ffh,006h,000h,0b4h,006h,0ffh,005h,000h,097h,005h,0ffh,005h,000h,0b4h,005h,0ffh	; 756c  ................
	defb 004h,000h,097h,004h,0ffh,004h,000h,0b4h,004h,0ffh,004h,000h,097h,003h,0ffh,004h	; 757c  ................
	defb 000h,0b4h,003h,0ffh,003h,000h,097h,003h,0ffh,003h,000h,0b4h,003h,0ffh,003h,000h	; 758c  ................
	defb 097h,002h,0ffh,003h,000h,0b4h,002h,0ffh,003h,000h,097h,002h,0ffh,003h,000h,0b4h	; 759c  ................
	defb 002h,0ffh,003h,000h,097h,002h,0ffh,003h,000h,0b4h,002h,0ffh,003h,000h,097h,002h	; 75ac  ................
	defb 0ffh,003h,000h,0b4h,002h,0ffh,002h,000h,097h,002h,0ffh,080h,001h,018h,000h,0b4h	; 75bc  ................
	defb 080h,004h,0fdh,007h,002h,0f6h,007h,002h,0f6h,007h,002h,0f6h,007h,002h,0f6h,0fbh	; 75cc  ................
	defb 080h,008h,064h,000h,05fh,0fah,006h,000h,05fh,0f9h,006h,000h,05fh,0f8h,007h,000h	; 75dc  ..d._..._..._...
	defb 05fh,007h,000h,05fh,080h,003h,0fbh,00eh,000h,06bh,00eh,000h,05fh,02ah,000h,05ah	; 75ec  _.._.....k.._*.Z
	defb 00eh,000h,05fh,00eh,000h,06bh,00eh,000h,078h,00eh,000h,06bh,00eh,000h,078h,046h	; 75fc  .._..k..x..k..xF
	defb 000h,07fh,01ch,000h,05ah,00eh,000h,05fh,00eh,000h,06bh,00eh,000h,05fh,01ch,000h	; 760c  ....Z.._..k.._..
	defb 078h,00eh,000h,06bh,00eh,000h,078h,00eh,000h,06bh,007h,000h,078h,007h,000h,06bh	; 761c  x..k..x..k..x..k
	defb 00eh,000h,078h,0fah,080h,008h,038h,000h,07fh,070h,000h,07fh,080h,003h,081h,001h	; 762c  ..x...8..p......
	defb 0fah,062h,000h,0f0h,00eh,000h,0d6h,07eh,000h,0beh,00eh,000h,0f0h,00eh,000h,0d6h	; 763c  .b.....~........
	defb 02ah,000h,0a0h,00eh,000h,0f0h,00eh,001h,040h,0f9h,00fh,001h,068h,010h,001h,040h	; 764c  *.......@...h..@
	defb 00ah,001h,068h,00ch,001h,040h,01ah,001h,068h,080h,008h,0f8h,038h,001h,07dh,0f7h	; 765c  ..h..@..h...8.}.
	defb 031h,001h,07dh,0f6h,028h,001h,07dh,0f5h,038h,001h,07dh,0f4h,038h,001h,07dh,081h	; 766c  1.}.(.}.8.}.8.}.
	defb 000h,082h,080h,076h,080h,004h,0f8h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h	; 767c  ...v.....}..P..@
	defb 00ch,001h,050h,00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h	; 768c  ..P..@..}..P....
	defb 003h,018h,001h,040h,080h,004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch	; 769c  ...@....}..P..@.
	defb 001h,050h,00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h	; 76ac  .P..@..}..P.....
	defb 018h,001h,040h,080h,004h,0f9h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch	; 76bc  ..@.....}..P..@.
	defb 001h,050h,00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h	; 76cc  .P..@..}..P.....
	defb 018h,001h,040h,080h,004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h	; 76dc  ..@....}..P..@..
	defb 050h,00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h	; 76ec  P..@..}..P......
	defb 001h,040h,080h,004h,0fah,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h	; 76fc  .@.....}..P..@..
	defb 050h,00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h	; 770c  P..@..}..P......
	defb 001h,040h,080h,004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h	; 771c  .@....}..P..@..P
	defb 00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h	; 772c  ..@..}..P.......
	defb 040h,080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h,055h	; 773c  @....._..U..P..U
	defb 00ch,000h,050h,00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h	; 774c  ..P.._..U..G....
	defb 000h,050h,080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h	; 775c  .P....._..U..P..
	defb 055h,00ch,000h,050h,00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh	; 776c  U..P.._..U..G...
	defb 018h,000h,050h,080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch	; 777c  ..P....._..U..P.
	defb 000h,055h,00ch,000h,050h,00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h	; 778c  .U..P.._..U..G..
	defb 0fdh,018h,000h,050h,080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h	; 779c  ...P....._..U..P
	defb 00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h,000h,050h,018h	; 77ac  .._..U..G.....P.
	defb 000h,050h,018h,0ffh,018h,000h,050h,018h,000h,050h,018h,0ffh,0fch,018h,000h,050h	; 77bc  .P....P..P.....P
	defb 018h,000h,050h,018h,0ffh,0fbh,018h,000h,050h,018h,000h,050h,018h,0ffh,0fah,018h	; 77cc  ..P.....P..P....
	defb 000h,050h,018h,000h,050h,018h,0ffh,0f9h,018h,000h,050h,018h,000h,050h,018h,0ffh	; 77dc  .P..P.....P..P..
	defb 0f8h,018h,000h,050h,018h,000h,050h,018h,0ffh,0f7h,018h,000h,050h,018h,000h,050h	; 77ec  ...P..P.....P..P
	defb 018h,0ffh,0f6h,018h,000h,050h,018h,000h,050h,018h,0ffh,082h,051h,072h,081h,001h	; 77fc  .....P..P...Qr..
	defb 080h,008h,0f6h,070h,000h,07fh,070h,000h,07fh,054h,000h,07fh,007h,000h,07fh,015h	; 780c  ...p..p..T......
	defb 000h,0beh,0f6h,038h,000h,0aah,0f7h,034h,000h,0aah,001h,000h,0aah,001h,000h,0aah	; 781c  ...8...4........
	defb 001h,000h,0aah,001h,000h,0aah,0f8h,001h,000h,0aah,001h,000h,0aah,001h,000h,0aah	; 782c  ................
	defb 001h,000h,0aah,00ah,000h,0aah,00eh,000h,0aah,00eh,000h,0aah,00ah,000h,0aah,001h	; 783c  ................
	defb 000h,0aah,001h,000h,0aah,001h,000h,0aah,001h,000h,0aah,0f9h,001h,000h,0aah,001h	; 784c  ................
	defb 000h,0aah,001h,000h,0aah,001h,000h,0aah,00ah,000h,0aah,00eh,000h,0aah,00ch,000h	; 785c  ................
	defb 0aah,002h,0ffh,080h,005h,0fbh,01dh,000h,0aah,0f9h,007h,000h,040h,007h,000h,040h	; 786c  ............@..@
	defb 007h,000h,040h,007h,000h,040h,00fh,0ffh,0f9h,007h,000h,0ach,007h,000h,081h,007h	; 787c  ..@..@..........
	defb 000h,0c0h,007h,000h,091h,007h,000h,0d8h,007h,000h,0a2h,00ch,0ffh,038h,0ffh,00eh	; 788c  .............8..
	defb 0ffh,080h,008h,0f6h,00eh,000h,040h,01ch,000h,040h,070h,000h,040h,070h,000h,040h	; 789c  ......@..@p.@p.@
	defb 070h,000h,040h,070h,000h,040h,080h,005h,0fdh,01ch,003h,0fbh,023h,003h,0fbh,031h	; 78ac  p.@p.@......#..1
	defb 0ffh,070h,0ffh,015h,0ffh,080h,005h,0fdh,01ch,003h,0fbh,023h,003h,0fbh,031h,0ffh	; 78bc  .p.........#..1.
	defb 070h,0ffh,021h,0ffh,0fdh,080h,008h,0f6h,070h,000h,040h,070h,000h,040h,070h,000h	; 78cc  p.!.....p.@p.@p.
	defb 040h,070h,000h,040h,080h,005h,0fdh,015h,003h,0fbh,026h,003h,0fbh,035h,0ffh,072h	; 78dc  @p.@......&..5.r
	defb 0ffh,080h,005h,0fdh,015h,003h,0fbh,024h,003h,0fbh,0f9h,003h,000h,091h,003h,000h	; 78ec  .......$........
	defb 081h,080h,003h,024h,000h,07ah,007h,000h,081h,007h,0ffh,007h,000h,091h,007h,0ffh	; 78fc  ...$.z..........
	defb 007h,000h,099h,007h,0ffh,007h,000h,0b6h,007h,0ffh,006h,000h,099h,006h,0ffh,006h	; 790c  ................
	defb 000h,0b6h,006h,0ffh,005h,000h,099h,005h,0ffh,005h,000h,0b6h,005h,0ffh,004h,000h	; 791c  ................
	defb 099h,004h,0ffh,004h,000h,0b6h,004h,0ffh,004h,000h,099h,003h,0ffh,004h,000h,0b6h	; 792c  ................
	defb 003h,0ffh,003h,000h,099h,003h,0ffh,003h,000h,0b6h,003h,0ffh,003h,000h,099h,002h	; 793c  ................
	defb 0ffh,003h,000h,0b6h,002h,0ffh,003h,000h,099h,002h,0ffh,003h,000h,0b6h,002h,0ffh	; 794c  ................
	defb 003h,000h,099h,002h,0ffh,003h,000h,0b6h,002h,0ffh,003h,000h,097h,002h,0ffh,003h	; 795c  ................
	defb 000h,0b6h,002h,0ffh,002h,000h,099h,002h,0ffh,080h,003h,017h,000h,0b6h,080h,004h	; 796c  ................
	defb 0fdh,007h,002h,0fah,007h,002h,0fah,007h,002h,0fah,007h,002h,0fah,003h,0ffh,0fbh	; 797c  ................
	defb 080h,008h,064h,000h,060h,0fah,006h,000h,060h,0f9h,006h,000h,060h,0f8h,007h,000h	; 798c  ..d.`...`...`...
	defb 060h,007h,000h,060h,080h,003h,0fbh,00eh,000h,06ch,00eh,000h,060h,02ah,000h,05bh	; 799c  `..`.....l..`*.[
	defb 00eh,000h,060h,00eh,000h,06ch,00eh,000h,079h,00eh,000h,06ch,00eh,000h,079h,046h	; 79ac  ..`..l..y..l..yF
	defb 000h,080h,01ch,000h,05bh,00eh,000h,060h,00eh,000h,06ch,00eh,000h,060h,01ch,000h	; 79bc  ....[..`..l..`..
	defb 079h,00eh,000h,06ch,00eh,000h,079h,00eh,000h,06ch,007h,000h,079h,007h,000h,06ch	; 79cc  y..l..y..l..y..l
	defb 00eh,000h,079h,0f9h,080h,008h,038h,000h,080h,06dh,000h,080h,080h,005h,081h,000h	; 79dc  ..y...8..m......
	defb 0f7h,00eh,000h,03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h,028h,01ch,000h,03ch	; 79ec  ...<..P..<..(..<
	defb 00eh,000h,050h,00eh,000h,03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h,028h,01ch	; 79fc  ..P..<..P..<..(.
	defb 000h,03ch,00eh,000h,050h,00eh,000h,03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h	; 7a0c  .<..P..<..P..<..
	defb 028h,01ch,000h,03ch,00eh,000h,050h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h	; 7a1c  (..<..P..<..5..(
	defb 00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,00ah,000h,035h,0f6h	; 7a2c  ..<..5..(..<..5.
	defb 00ah,000h,028h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,00ah	; 7a3c  ..(..<..5..(..<.
	defb 000h,035h,00ah,000h,028h,0f5h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah	; 7a4c  .5..(...<..5..(.
	defb 000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,0f4h,00ah,000h,035h,00ah	; 7a5c  .<..5..(..<...5.
	defb 000h,028h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,0f3h,00ah	; 7a6c  .(..<..5..(..<..
	defb 000h,035h,00ah,000h,028h,00ah,000h,03ch,0f2h,00ah,000h,035h,00ah,000h,028h,006h	; 7a7c  .5..(..<...5..(.
	defb 000h,03ch,080h,008h,0f4h,081h,001h,078h,000h,0a0h,078h,000h,0a0h,078h,000h,0a0h	; 7a8c  .<.....x..x..x..
	defb 078h,000h,0a0h,080h,004h,081h,000h,0f9h,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h	; 7a9c  x...............
	defb 07fh,00ch,000h,08fh,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,078h	; 7aac  ...............x
	defb 080h,003h,018h,000h,07fh,080h,004h,0fah,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h	; 7abc  ................
	defb 07fh,00ch,000h,08fh,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,078h	; 7acc  ...............x
	defb 080h,003h,0fch,017h,000h,07fh,001h,0ffh,080h,008h,0f9h,081h,008h,05fh,000h,0feh	; 7adc  ............._..
	defb 001h,0ffh,080h,005h,0fdh,017h,000h,0feh,001h,0ffh,017h,000h,0feh,001h,0ffh,080h	; 7aec  ................
	defb 008h,0f9h,047h,000h,0feh,001h,0ffh,080h,005h,0fdh,017h,000h,0feh,001h,0ffh,017h	; 7afc  ..G.............
	defb 000h,0feh,001h,0ffh,080h,008h,0f9h,047h,000h,0feh,001h,0ffh,080h,005h,0fdh,018h	; 7b0c  .......G........
	defb 000h,0feh,080h,008h,0f9h,047h,000h,0feh,001h,0ffh,080h,005h,081h,000h,0fch,018h	; 7b1c  .....G..........
	defb 000h,07fh,018h,000h,07fh,018h,0ffh,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0fah	; 7b2c  ................
	defb 018h,000h,07fh,018h,000h,07fh,018h,0ffh,0f9h,018h,000h,07fh,018h,000h,07fh,018h	; 7b3c  ................
	defb 0ffh,0f8h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0f7h,018h,000h,07fh,018h,000h	; 7b4c  ................
	defb 07fh,018h,0ffh,0f6h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0f5h,018h,000h,07fh	; 7b5c  ................
	defb 018h,000h,07fh,018h,0ffh,0f4h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,082h,00ah	; 7b6c  ................
	defb 078h,080h,006h,0fdh,070h,0ffh,094h,005h,003h,0f4h,002h,0ffh,0fch,006h,003h,0f9h	; 7b7c  x...p...........
	defb 001h,0ffh,01ch,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh	; 7b8c  ................
	defb 038h,0ffh,085h,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch	; 7b9c  8...............
	defb 0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,0fdh,007h,002h	; 7bac  ................
	defb 0a7h,007h,001h,0fch,007h,002h,0fah,007h,002h,03bh,007h,003h,057h,015h,002h,081h	; 7bbc  .........;..W...
	defb 095h,080h,006h,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch	; 7bcc  ................
	defb 0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,038h,0ffh,085h	; 7bdc  .............8..
	defb 080h,005h,0feh,01ch,003h,0f9h,023h,003h,0f9h,080h,000h,0fah,006h,001h,07fh,00eh	; 7bec  ......#.........
	defb 001h,06ah,020h,001h,06ah,012h,001h,06ah,00dh,001h,06ah,00ch,001h,06ah,00ah,001h	; 7bfc  .j .j..j..j..j..
	defb 06ah,009h,001h,06ah,080h,003h,012h,001h,06ah,006h,001h,07fh,006h,001h,06ah,007h	; 7c0c  j..j....j.....j.
	defb 001h,07fh,006h,001h,06ah,006h,001h,07fh,006h,001h,06fh,00dh,001h,07fh,080h,005h	; 7c1c  ....j.....o.....
	defb 0feh,01ch,003h,0f9h,01fh,003h,0f9h,080h,000h,0fah,006h,000h,0c0h,00eh,000h,0b6h	; 7c2c  ................
	defb 01fh,000h,0b6h,012h,000h,0b6h,00dh,000h,0b6h,00ch,000h,0b6h,00ah,000h,0b6h,008h	; 7c3c  ................
	defb 000h,0b6h,080h,003h,00ch,000h,0b6h,008h,000h,0c0h,007h,000h,0b6h,006h,000h,0bch	; 7c4c  ................
	defb 006h,000h,0b6h,005h,000h,0bch,00ah,000h,0b6h,006h,000h,0c0h,012h,000h,0b6h,008h	; 7c5c  ................
	defb 000h,0c0h,094h,080h,006h,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h	; 7c6c  ................
	defb 0ffh,01ch,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,006h,003h,0f9h,001h,0ffh,038h,0ffh	; 7c7c  ..............8.
	defb 085h,080h,005h,0feh,015h,003h,0f9h,026h,003h,0f9h,0fah,080h,004h,005h,001h,07dh	; 7c8c  .......&.......}
	defb 006h,001h,07dh,080h,008h,008h,001h,06bh,001h,001h,06ch,001h,001h,06dh,001h,001h	; 7c9c  ..}....k..l..m..
	defb 06eh,001h,001h,06fh,001h,001h,070h,001h,001h,071h,001h,001h,072h,001h,001h,073h	; 7cac  n..o..p..q..r..s
	defb 001h,001h,074h,002h,001h,075h,002h,001h,076h,002h,001h,078h,002h,001h,07ah,002h	; 7cbc  ..t..u..v..x..z.
	defb 001h,07bh,002h,001h,07ch,002h,001h,07dh,002h,001h,07eh,006h,001h,07fh,008h,001h	; 7ccc  .{..|..}..~.....
	defb 06ah,00bh,000h,0f2h,02ch,000h,0f2h,003h,000h,0f3h,003h,000h,0f4h,003h,000h,0f5h	; 7cdc  j...,...........
	defb 003h,000h,0f6h,003h,000h,0f7h,003h,000h,0f8h,003h,000h,0f9h,003h,000h,0fah,003h	; 7cec  ................
	defb 000h,0fbh,003h,000h,0fch,003h,000h,0fdh,003h,000h,0feh,003h,000h,0ffh,003h,001h	; 7cfc  ................
	defb 000h,003h,001h,001h,003h,001h,002h,004h,001h,004h,002h,001h,006h,080h,005h,0feh	; 7d0c  ................
	defb 015h,003h,0f9h,026h,003h,0f9h,03ch,0ffh,080h,006h,0fdh,005h,003h,0f9h,002h,0ffh	; 7d1c  ...&..<.........
	defb 0fch,006h,003h,0f9h,001h,0ffh,01ch,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h	; 7d2c  ................
	defb 003h,0f9h,001h,0ffh,038h,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h	; 7d3c  ....8...........
	defb 001h,0ffh,01ch,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh	; 7d4c  ................
	defb 015h,0ffh,080h,000h,0fdh,007h,005h,0f4h,007h,005h,0f4h,007h,005h,0f4h,007h,005h	; 7d5c  ................
	defb 0f4h,095h,080h,003h,0fdh,01ch,005h,0f4h,001h,004h,0c0h,001h,004h,080h,001h,004h	; 7d6c  ................
	defb 000h,001h,003h,0c0h,001h,003h,080h,001h,003h,000h,016h,002h,0fah,01ch,005h,0f4h	; 7d7c  ................
	defb 015h,002h,0fah,007h,002h,0fah,085h,0fdh,01ch,005h,0f4h,01ch,002h,0fah,0fch,01ch	; 7d8c  ................
	defb 003h,0c0h,01ch,003h,0f9h,080h,003h,0fch,07eh,003h,0c0h,01ch,003h,0c0h,00eh,003h	; 7d9c  ........~.......
	defb 057h,038h,002h,0fah,070h,003h,0c0h,01fh,005h,001h,030h,005h,09eh,080h,008h,0f8h	; 7dac  W8..p.....0.....
	defb 00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,0f7h,00eh,005h,0f4h	; 7dbc  ................
	defb 00eh,005h,0f4h,00eh,005h,0f4h,013h,005h,0f4h,00eh,005h,0f4h,0f6h,00eh,005h,0f4h	; 7dcc  ................
	defb 00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh	; 7ddc  ................
	defb 005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,078h,005h,0f4h,0f5h,078h,005h,0f4h,080h	; 7dec  ........x...x...
	defb 008h,0f8h,018h,005h,0f4h,0f7h,018h,005h,0f4h,0f6h,018h,005h,0f4h,018h,005h,0f4h	; 7dfc  ................
	defb 0f5h,018h,005h,0f4h,018h,005h,0f4h,0f4h,018h,005h,0f4h,00ch,005h,0f4h,0f3h,00ch	; 7e0c  ................
	defb 005h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,0f9h,018h	; 7e1c  ................
	defb 005h,0f4h,0f8h,018h,005h,0f4h,0f7h,018h,005h,0f4h,018h,005h,0f4h,0f6h,018h,005h	; 7e2c  ................
	defb 0f4h,018h,005h,0f4h,0f5h,018h,005h,0f4h,00ch,005h,0f4h,0f4h,00ch,005h,0f4h,00ch	; 7e3c  ................
	defb 005h,0f4h,00ch,005h,0f4h,080h,005h,0fdh,018h,003h,0f9h,093h,080h,002h,00ch,005h	; 7e4c  ................
	defb 0f4h,00ch,005h,04dh,00ch,005h,001h,00ch,005h,04dh,00ch,005h,001h,00ch,005h,0f4h	; 7e5c  ...M.....M......
	defb 00ch,005h,04dh,00ch,004h,075h,080h,005h,018h,005h,001h,085h,080h,002h,00ch,005h	; 7e6c  ..M..u..........
	defb 0f4h,00ch,005h,04dh,00ch,005h,001h,00ch,005h,0f4h,00ch,005h,04dh,00ch,004h,075h	; 7e7c  ...M........M..u
	defb 080h,005h,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,018h,003h,0f9h,018h,003h,0f9h	; 7e8c  ................
	defb 018h,0ffh,0fch,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,0fbh,018h,003h,0f9h,018h	; 7e9c  ................
	defb 003h,0f9h,018h,0ffh,0fbh,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,018h,003h,0f9h	; 7eac  ................
	defb 018h,003h,0f9h,018h,0ffh,0fah,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,0f9h,018h	; 7ebc  ................
	defb 003h,0f9h,018h,003h,0f9h,018h,0ffh,0f8h,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh	; 7ecc  ................
	defb 082h,07dh,07bh,080h,004h,0fbh,008h,000h,030h,0f9h,008h,000h,030h,008h,000h,030h	; 7edc  .}{.....0...0..0
	defb 0fah,008h,000h,02dh,0f9h,008h,000h,02dh,080h,000h,020h,000h,035h,080h,000h,0f7h	; 7eec  ...-...-.. .5...
	defb 006h,005h,04dh,0f6h,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0f8h,006h,005h	; 7efc  ..M......M......
	defb 04dh,0f7h,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0f9h,006h,005h,04dh,0f8h	; 7f0c  M......M......M.
	defb 006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fah,006h,005h,04dh,0f9h,006h,005h	; 7f1c  .....M......M...
	defb 0f4h,006h,005h,04dh,006h,005h,0f4h,0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h	; 7f2c  ...M......M.....
	defb 005h,001h,006h,005h,0f4h,0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h,005h,04dh	; 7f3c  ........M......M
	defb 006h,005h,0f4h,0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h,005h,04dh,006h,005h	; 7f4c  ......M......M..
	defb 0f4h,0fch,006h,005h,04dh,0fbh,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fch	; 7f5c  ....M......M....
	defb 006h,005h,04dh,0fbh,006h,005h,0f4h,006h,006h,0aeh,006h,005h,0f4h,0fdh,006h,005h	; 7f6c  ..M.............
	defb 04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch	; 7f7c  M......M......M.
	defb 006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h	; 7f8c  .....M......M...
	defb 0f4h,006h,005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,0fdh	; 7f9c  ...M......M.....
	defb 006h,005h,001h,0fch,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h	; 7fac  ..........M.....
	defb 005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh	; 7fbc  .M......M......M
	defb 006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h,005h	; 7fcc  ......M......M..
	defb 0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,006h,0aeh,006h,005h,0f4h,082h	; 7fdc  ....M...........
	defb 0eeh,07fh,093h,080h,000h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh	; 7fec  ........M......M
	defb 006h,005h,0f4h,0fdh	; 7ffc
