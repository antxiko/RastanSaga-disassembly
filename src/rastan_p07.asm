; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 07 (en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l8094h:	equ 0x08094

; ======================================================================
; CODIGO 0x8000..0x8096  (150 bytes)
; ======================================================================


L_8000:
	cp 01dh		;8000
	ret nc			;8002
	ld a,(0d92ch)		;8003   ; a = y del bloque especial
	sub l			;8006
	add a,00eh		;8007
	cp 01dh		;8009
	ret nc			;800b
	ld a,(0d92dh)		;800c   ; a = cual es el bloque especial
	cp 001h		;800f
	jr z,L_8026		;8011
	cp 002h		;8013
	jr z,L_8020		;8015
	cp 003h		;8017
	jr z,L_802C		;8019
	xor a			;801b
	ld b,000h		;801c
	jr L_8030		;801e
L_8020:
	ld a,002h		;8020
	ld b,030h		;8022
	jr L_8030		;8024
L_8026:
	ld a,001h		;8026
	ld b,020h		;8028
	jr L_8030		;802a
L_802C:
	ld a,003h		;802c
	ld b,000h		;802e
L_8030:
	ld (0d919h),a		;8030
	ld d,a			;8033
	ld a,(0d905h)		;8034
	and 0fch		;8037
	or d			;8039
	set 4,a		;803a
	ld (0d905h),a		;803c
	exx			;803f
	ld hl,0d928h		;8040
	set 3,(hl)		;8043
	exx			;8045
	ld a,(0d920h)		;8046
	ld d,05ah		;8049
	cp 010h		;804b
	jr nc,L_8063		;804d
	ld d,050h		;804f
	cp 006h		;8051
	jr nc,L_8063		;8053
	ld d,046h		;8055
	cp 003h		;8057
	jr nc,L_8063		;8059
	ld d,03ch		;805b
	cp 001h		;805d
	jr nc,L_8063		;805f
	ld d,032h		;8061
L_8063:
	ld a,d			;8063
	ld (0d91ah),a		;8064
	ld e,b			;8067
	ld d,000h		;8068
	push bc			;806a
	push hl			;806b
	ld bc,00000h		;806c
	call L_8D0B		;806f
	xor a			;8072
	ld (0d92dh),a		;8073   ; cual es el bloque especial = a
	call 0629eh		;8076
	pop hl			;8079
	pop bc			;807a
	ret			;807b
L_807C:
	push bc			;807c
	push de			;807d
	push hl			;807e
	ld l,(ix+000h)		;807f
	ld h,000h		;8082
	add hl,hl			;8084
	ld de,l8094h		;8085
	add hl,de			;8088
	ld e,(hl)			;8089
	inc hl			;808a
	ld d,(hl)			;808b
	ld bc,00000h		;808c
	call L_8D0B		;808f
	pop hl			;8092
	pop de			;8093
L_8094:
	pop bc			;8094
	ret			;8095

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8096..0x80e6  (80 bytes)
DATA_8096:
	defb 030h,000h,050h,000h,030h,000h,050h,000h,020h,000h,090h,000h,070h,000h,020h,000h	; 8096  0.P.0.P. ...p. .
	defb 050h,000h,020h,000h,020h,000h,010h,000h,070h,000h,020h,000h,050h,000h,050h,000h	; 80a6  P. . ...p. .P.P.
	defb 040h,000h,080h,000h,070h,000h,070h,000h,090h,000h,000h,000h,000h,000h,000h,000h	; 80b6  @...p.p.........
	defb 008h,008h,00ch,000h,00ch,00ch,020h,000h,020h,020h,030h,000h,024h,024h,034h,000h	; 80c6  ...... .  0.$$4.
	defb 008h,008h,00ch,000h,00ch,00ch,020h,000h,030h,030h,030h,000h,034h,034h,034h,000h	; 80d6  ...... .000.444.

; ======================================================================
; CODIGO 0x80e6..0x8407  (801 bytes)
; ======================================================================


L_80E6:
	ld a,l			;80e6
	sub 010h		;80e7
	sub 010h		;80e9
	and 0f0h		;80eb
	ld b,000h		;80ed
	ld c,a			;80ef
	ld a,h			;80f0
	and 0f0h		;80f1
	rra			;80f3
	rra			;80f4
	rra			;80f5
	ld l,a			;80f6
	ld h,000h		;80f7
	add hl,bc			;80f9
	add hl,bc			;80fa
	ld bc,0d774h		;80fb   ; bc -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,bc			;80fe
	inc hl			;80ff
	ld a,(hl)			;8100
	and 0f0h		;8101
	ret			;8103
L_8104:
	ld a,(0d8fch)		;8104   ; a = la x de Rastan
	ld h,a			;8107
	ld a,(0d8fdh)		;8108   ; a = la y de Rastan
	ld l,a			;810b
	ld ix,0da20h		;810c   ; ix -> los 8 enemigos de la pantalla
	call L_8632		;8110
	ld ix,0da46h		;8113   ; ix -> enemigo 1
	call L_8632		;8117
	ld ix,0da6ch		;811a   ; ix -> enemigo 2
	call L_8632		;811e
	ld ix,0da92h		;8121   ; ix -> enemigo 3
	call L_8632		;8125
	ld ix,0dab8h		;8128   ; ix -> enemigo 4
	call L_8632		;812c
	ld ix,0dadeh		;812f   ; ix -> enemigo 5
	call L_8632		;8133
	ld ix,0db04h		;8136   ; ix -> enemigo 6
	call L_8632		;813a
	ld ix,0db2ah		;813d   ; ix -> enemigo 7
	call L_8632		;8141
	call L_85F6		;8144
	call L_8BC6		;8147
	ld a,(0d90fh)		;814a
	bit 6,a		;814d
	ret nz			;814f
	bit 4,a		;8150
	ret nz			;8152
	ld a,(0d910h)		;8153
	bit 1,a		;8156
	ret nz			;8158
	bit 6,a		;8159
	jp nz,L_918C		;815b
	ld a,(0d904h)		;815e
	and 01eh		;8161
	cp 004h		;8163
	jr nz,L_816B		;8165
	ld a,l			;8167
	add a,00dh		;8168
	ld l,a			;816a
L_816B:
	call L_844C		;816b
	call L_8172		;816e
	ret			;8171
L_8172:
	ld ix,0d933h		;8172   ; ix -> los 6 actores de la pantalla
	ld a,003h		;8176
	ld c,000h		;8178
L_817A:
	ex af,af'			;817a
	ld a,(ix+000h)		;817b
	ld e,a			;817e
	or a			;817f
	jp z,L_83F6		;8180
	cp 018h		;8183
	jp nc,L_8583		;8185
	ld a,(ix+00fh)		;8188
	or a			;818b
	jp z,L_83F6		;818c
	ld d,000h		;818f
	push hl			;8191
	ld hl,08404h		;8192
	add hl,de			;8195
	add hl,de			;8196
	add hl,de			;8197
	ld d,(hl)			;8198
	inc hl			;8199
	ld a,(hl)			;819a
	inc hl			;819b
	ld h,(hl)			;819c
	ld l,a			;819d
	ex (sp),hl			;819e
	ret			;819f
L_81A0:
	ld a,(ix+001h)		;81a0
	ld b,a			;81a3
	and 00eh		;81a4
	cp 002h		;81a6
	jp nz,L_83F6		;81a8
	ld a,(ix+002h)		;81ab
	cp 003h		;81ae
	jp c,L_83F6		;81b0
	ld a,(ix+007h)		;81b3
	sub l			;81b6
	add a,007h		;81b7
	cp 01fh		;81b9
	jp nc,L_83F6		;81bb
	bit 0,b		;81be
	jr nz,L_81D0		;81c0
	ld a,(ix+006h)		;81c2
	sub h			;81c5
	add a,019h		;81c6
	cp 019h		;81c8
	jp nc,L_83F6		;81ca
	jp L_83D0		;81cd
L_81D0:
	ld a,(ix+006h)		;81d0
	sub h			;81d3
	sub 001h		;81d4
	cp 019h		;81d6
	jp nc,L_83F6		;81d8
	jp L_83D0		;81db
L_81DE:
	ld a,(ix+001h)		;81de
	ld b,a			;81e1
	and 00eh		;81e2
	cp 002h		;81e4
	jp nz,L_83F6		;81e6
	ld a,(ix+007h)		;81e9
	sub l			;81ec
	add a,017h		;81ed
	cp 027h		;81ef
	jp nc,L_83F6		;81f1
	bit 0,b		;81f4
	jr nz,L_8206		;81f6
	ld a,(ix+006h)		;81f8
	sub h			;81fb
	add a,010h		;81fc
	cp 017h		;81fe
	jp nc,L_83F6		;8200
	jp L_83D0		;8203
L_8206:
	ld a,(ix+006h)		;8206
	sub h			;8209
	add a,006h		;820a
	cp 017h		;820c
	jp nc,L_83F6		;820e
	jp L_83D0		;8211
L_8214:
	ld a,(ix+001h)		;8214
	ld b,a			;8217
	and 00eh		;8218
	cp 002h		;821a
	jp nz,L_83F6		;821c
	ld a,(ix+002h)		;821f
	cp 003h		;8222
	jp c,L_83F6		;8224
	ld a,(ix+007h)		;8227
	sub l			;822a
	add a,007h		;822b
	cp 01fh		;822d
	jp nc,L_83F6		;822f
	bit 0,b		;8232
	jr nz,L_8244		;8234
	ld a,(ix+006h)		;8236
	sub h			;8239
	add a,021h		;823a
	cp 021h		;823c
	jp nc,L_83F6		;823e
	jp L_83D0		;8241
L_8244:
	ld a,(ix+006h)		;8244
	sub h			;8247
	cp 021h		;8248
	jp nc,L_83F6		;824a
	jp L_83D0		;824d
L_8250:
	ld a,(ix+001h)		;8250
	ld b,a			;8253
	and 00eh		;8254
	cp 002h		;8256
	jp nz,L_83F6		;8258
	ld a,(ix+002h)		;825b
	cp 003h		;825e
	jp c,L_83F6		;8260
	ld a,(ix+007h)		;8263
	sub l			;8266
	add a,009h		;8267
	cp 020h		;8269
	jp nc,L_83F6		;826b
	bit 0,b		;826e
	jr nz,L_8280		;8270
	ld a,(ix+006h)		;8272
	sub h			;8275
	add a,015h		;8276
	cp 01eh		;8278
	jp nc,L_83F6		;827a
	jp L_83D0		;827d
L_8280:
	ld a,(ix+006h)		;8280
	sub h			;8283
	add a,00ch		;8284
	cp 01eh		;8286
	jp nc,L_83F6		;8288
	jp L_83D0		;828b
L_828E:
	ld a,(ix+001h)		;828e
	ld b,a			;8291
	and 00eh		;8292
	cp 002h		;8294
	jp nz,L_83F6		;8296
	ld a,(ix+002h)		;8299
	cp 003h		;829c
	jp c,L_83F6		;829e
	ld a,(ix+007h)		;82a1
	sub l			;82a4
	add a,007h		;82a5
	cp 01fh		;82a7
	jp nc,L_83F6		;82a9
	bit 0,b		;82ac
	jr nz,L_82BE		;82ae
	ld a,(ix+006h)		;82b0
	sub h			;82b3
	add a,031h		;82b4
	cp 031h		;82b6
	jp nc,L_83F6		;82b8
	jp L_83D0		;82bb
L_82BE:
	ld a,(ix+006h)		;82be
	sub h			;82c1
	cp 031h		;82c2
	jp nc,L_83F6		;82c4
	jp L_83D0		;82c7
L_82CA:
	ld a,(ix+001h)		;82ca
	and 01eh		;82cd
	cp 002h		;82cf
	jp c,L_8310		;82d1
	jp z,L_8314		;82d4
	cp 008h		;82d7
	jp c,L_8354		;82d9
	jp z,L_83F6		;82dc
	cp 00ch		;82df
	jp c,L_8373		;82e1
	jp z,L_8392		;82e4
	cp 00eh		;82e7
	jp z,L_83B1		;82e9
	cp 014h		;82ec
	jp nz,L_83F6		;82ee
	ld a,(ix+006h)		;82f1
	sub h			;82f4
	add a,013h		;82f5
	cp 017h		;82f7
	jp nc,L_83F6		;82f9
	ld a,(ix+007h)		;82fc
	sub l			;82ff
	add a,007h		;8300
	cp 01fh		;8302
	jp nc,L_83F6		;8304
	set 7,(ix+025h)		;8307
	ld d,00ch		;830b
	jp L_83D0		;830d
L_8310:
	ld d,00ch		;8310
	jr L_8316		;8312
L_8314:
	ld d,018h		;8314
L_8316:
	ld a,(ix+006h)		;8316
	sub h			;8319
	add a,013h		;831a
	cp 017h		;831c
	jp nc,L_83F6		;831e
	ld a,(ix+007h)		;8321
	sub l			;8324
	add a,007h		;8325
	cp 01fh		;8327
	jp nc,L_83F6		;8329
	set 7,(ix+025h)		;832c
	ld a,(0d91ah)		;8330
	or a			;8333
	jr z,L_8346		;8334
	xor a			;8336
	ld (0d91ah),a		;8337
	ld a,(0d905h)		;833a
	and 0fch		;833d
	ld (0d905h),a		;833f
	xor a			;8342
	ld (0d919h),a		;8343
L_8346:
	ld a,(0d926h)		;8346
	or a			;8349
	jp z,L_83D0		;834a
	xor a			;834d
	ld (0d926h),a		;834e
	jp L_83D0		;8351
L_8354:
	ld a,(ix+006h)		;8354
	sub h			;8357
	add a,012h		;8358
	cp 012h		;835a
	jp nc,L_83F6		;835c
	ld a,(ix+007h)		;835f
	sub l			;8362
	add a,015h		;8363
	cp 01bh		;8365
	jp nc,L_83F6		;8367
	set 7,(ix+025h)		;836a
	ld d,010h		;836e
	jp L_83D0		;8370
L_8373:
	ld a,(ix+006h)		;8373
	sub h			;8376
	add a,012h		;8377
	cp 012h		;8379
	jp nc,L_83F6		;837b
	ld a,(ix+007h)		;837e
	sub l			;8381
	add a,007h		;8382
	cp 01fh		;8384
	jp nc,L_83F6		;8386
	set 7,(ix+025h)		;8389
	ld d,018h		;838d
	jp L_83D0		;838f
L_8392:
	ld a,(ix+006h)		;8392
	sub h			;8395
	add a,012h		;8396
	cp 012h		;8398
	jp nc,L_83F6		;839a
	ld a,(ix+007h)		;839d
	sub l			;83a0
	add a,007h		;83a1
	cp 01fh		;83a3
	jp nc,L_83F6		;83a5
	set 7,(ix+025h)		;83a8
	ld d,008h		;83ac
	jp L_83D0		;83ae
L_83B1:
	ld a,(ix+006h)		;83b1
	sub h			;83b4
	add a,013h		;83b5
	cp 017h		;83b7
	jp nc,L_83F6		;83b9
	ld a,(ix+007h)		;83bc
	sub l			;83bf
	add a,007h		;83c0
	cp 01fh		;83c2
	jp nc,L_83F6		;83c4
	set 7,(ix+025h)		;83c7
	ld d,010h		;83cb
	jp L_83D0		;83cd
L_83D0:
	ld a,(0d91bh)		;83d0
	or a			;83d3
	jr z,L_83EC		;83d4
	ld a,(0d926h)		;83d6
	dec a			;83d9
	ld (0d926h),a		;83da
	jr nz,L_83EA		;83dd
	ld (0d91bh),a		;83df
	ld a,(0d905h)		;83e2
	and 0b3h		;83e5
	ld (0d905h),a		;83e7
L_83EA:
	srl d		;83ea
L_83EC:
	ld a,d			;83ec
	add a,c			;83ed
	ld c,a			;83ee
	exx			;83ef
	ld hl,0d928h		;83f0
	set 7,(hl)		;83f3
	exx			;83f5
L_83F6:
	ld de,00026h		;83f6
	add ix,de		;83f9
	ex af,af'			;83fb
	dec a			;83fc
	jp nz,L_817A		;83fd
	or c			;8400
	ret z			;8401
	ld d,c			;8402
	call 07818h		;8403
	ret			;8406

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8407..0x844c  (69 bytes)
DATA_8407:
	defb 010h,0a0h,081h,000h,0f6h,083h,000h,0f6h,083h,010h,0deh,081h,00ch,0f6h,083h,014h	; 8407  ................
	defb 014h,082h,000h,0f6h,083h,000h,0f6h,083h,000h,0f6h,083h,010h,050h,082h,000h,0f6h	; 8417  ............P...
	defb 083h,000h,0f6h,083h,000h,0f6h,083h,000h,0f6h,083h,000h,0f6h,083h,000h,0f6h,083h	; 8427  ................
	defb 010h,014h,082h,018h,014h,082h,010h,08eh,082h,000h,0f6h,083h,000h,0f6h,083h,000h	; 8437  ................
	defb 0f6h,083h,000h,0f6h,083h	; 8447

; ======================================================================
; CODIGO 0x844c..0x8596  (330 bytes)
; ======================================================================


L_844C:
	ld ix,0d933h		;844c   ; ix -> los 6 actores de la pantalla
	ld a,003h		;8450
	ld c,000h		;8452
L_8454:
	ex af,af'			;8454
	ld a,(ix+000h)		;8455
	ld e,a			;8458
	or a			;8459
	jp z,L_8583		;845a
	cp 018h		;845d
	jp nc,L_8583		;845f
	ld a,(ix+00fh)		;8462
	or a			;8465
	jp z,L_8583		;8466
	ld d,000h		;8469
	push hl			;846b
	ld hl,08592h		;846c
	add hl,de			;846f
	add hl,de			;8470
	add hl,de			;8471
	add hl,de			;8472
	ld d,(hl)			;8473
	inc hl			;8474
	inc hl			;8475
	ld a,(hl)			;8476
	inc hl			;8477
	ld h,(hl)			;8478
	ld l,a			;8479
	ex (sp),hl			;847a
	ret			;847b
L_847C:
	ld a,(ix+006h)		;847c
	sub h			;847f
	add a,009h		;8480
	cp 013h		;8482
	jp nc,L_8583		;8484
	ld a,(ix+007h)		;8487
	sub l			;848a
	add a,017h		;848b
	cp 02fh		;848d
	jp nc,L_8583		;848f
	jp L_8564		;8492
L_8495:
	ld a,(ix+007h)		;8495
	sub l			;8498
	cp 017h		;8499
	jr c,L_84B0		;849b
	cp 0e5h		;849d
	jp c,L_8583		;849f
	ld a,(ix+006h)		;84a2
	sub h			;84a5
	add a,009h		;84a6
	cp 013h		;84a8
	jp nc,L_8583		;84aa
	jp L_8564		;84ad
L_84B0:
	ld a,(ix+006h)		;84b0
	sub h			;84b3
	add a,013h		;84b4
	cp 027h		;84b6
	jp nc,L_8583		;84b8
	jp L_8564		;84bb
L_84BE:
	ld a,(ix+007h)		;84be
	sub l			;84c1
	cp 017h		;84c2
	jr c,L_84D9		;84c4
	cp 0e5h		;84c6
	jp c,L_8583		;84c8
	ld a,(ix+006h)		;84cb
	sub h			;84ce
	add a,013h		;84cf
	cp 027h		;84d1
	jp nc,L_8583		;84d3
	jp L_8564		;84d6
L_84D9:
	ld a,(ix+006h)		;84d9
	sub h			;84dc
	add a,009h		;84dd
	cp 013h		;84df
	jp nc,L_8583		;84e1
	jp L_8564		;84e4
L_84E7:
	ld a,(ix+006h)		;84e7
	sub h			;84ea
	add a,00fh		;84eb
	cp 00fh		;84ed
	jp nc,L_8583		;84ef
	ld a,(ix+007h)		;84f2
	sub l			;84f5
	add a,017h		;84f6
	cp 01fh		;84f8
	jp nc,L_8583		;84fa
	jp L_8564		;84fd
L_8500:
	ld a,(ix+006h)		;8500
	sub h			;8503
	add a,013h		;8504
	cp 027h		;8506
	jp nc,L_8583		;8508
	ld a,(ix+007h)		;850b
	sub l			;850e
	add a,00dh		;850f
	cp 01ch		;8511
	jp nc,L_8583		;8513
	jp L_8564		;8516
L_8519:
	ld a,(ix+006h)		;8519
	sub h			;851c
	add a,002h		;851d
	cp 015h		;851f
	jp nc,L_8583		;8521
	ld a,(ix+007h)		;8524
	sub l			;8527
	add a,007h		;8528
	cp 01fh		;852a
	jp nc,L_8583		;852c
	jp L_8564		;852f
L_8532:
	ld a,(ix+006h)		;8532
	sub h			;8535
	add a,005h		;8536
	cp 01bh		;8538
	jp nc,L_8583		;853a
	ld a,(ix+007h)		;853d
	sub l			;8540
	add a,017h		;8541
	cp 02fh		;8543
	jp nc,L_8583		;8545
	jp L_8564		;8548
L_854B:
	ld a,(ix+006h)		;854b
	sub h			;854e
	add a,013h		;854f
	cp 027h		;8551
	jp nc,L_8583		;8553
	ld a,(ix+007h)		;8556
	sub l			;8559
	add a,009h		;855a
	cp 01fh		;855c
	jp nc,L_8583		;855e
	jp L_8564		;8561
L_8564:
	ld a,(0d91bh)		;8564
	or a			;8567
	jr z,L_8580		;8568
	ld a,(0d926h)		;856a
	dec a			;856d
	ld (0d926h),a		;856e
	jr nz,L_857E		;8571
	ld (0d91bh),a		;8573
	ld a,(0d905h)		;8576
	and 0b3h		;8579
	ld (0d905h),a		;857b
L_857E:
	srl d		;857e
L_8580:
	ld a,d			;8580
	add a,c			;8581
	ld c,a			;8582
L_8583:
	ld de,00026h		;8583
	add ix,de		;8586
	ex af,af'			;8588
	dec a			;8589
	jp nz,L_8454		;858a
	or c			;858d
	ret z			;858e
	ld d,c			;858f
	push hl			;8590
	call 07818h		;8591
	pop hl			;8594
	ret			;8595

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8596..0x85f6  (96 bytes)
DATA_8596:
	defb 004h,000h,07ch,084h,008h,000h,095h,084h,008h,000h,0beh,084h,004h,000h,095h,084h	; 8596  ..|.............
	defb 004h,000h,095h,084h,008h,000h,07ch,084h,008h,000h,095h,084h,002h,000h,0e7h,084h	; 85a6  ......|.........
	defb 008h,000h,000h,085h,004h,000h,04bh,085h,004h,000h,019h,085h,004h,000h,019h,085h	; 85b6  ......K.........
	defb 008h,000h,000h,085h,008h,000h,032h,085h,008h,000h,04bh,085h,008h,000h,032h,085h	; 85c6  ......2...K...2.
	defb 008h,000h,07ch,084h,008h,000h,07ch,084h,008h,000h,07ch,084h,008h,000h,0beh,084h	; 85d6  ..|...|...|.....
	defb 00ch,000h,0beh,084h,002h,000h,0e7h,084h,010h,000h,0e7h,084h,002h,000h,0e7h,084h	; 85e6  ................

; ======================================================================
; CODIGO 0x85f6..0x864c  (86 bytes)
; ======================================================================


L_85F6:
	push hl			;85f6
	ld e,h			;85f7
	ld a,l			;85f8
	add a,018h		;85f9
	ld l,a			;85fb
	ld a,h			;85fc
	add a,005h		;85fd
	ld h,a			;85ff
	push de			;8600
	call L_80E6		;8601
	pop de			;8604
	cp 0b0h		;8605
	jr nz,L_862B		;8607
	inc hl			;8609
	inc hl			;860a
	ld a,(hl)			;860b
	and 0f0h		;860c
	cp 0b0h		;860e
	jr nz,L_862B		;8610
	ld a,e			;8612
	sub 006h		;8613
	and 00fh		;8615
	cp 005h		;8617
	jr nc,L_8624		;8619
	inc hl			;861b
	inc hl			;861c
	ld a,(hl)			;861d
	and 0f0h		;861e
	cp 0b0h		;8620
	jr nz,L_862B		;8622
L_8624:
	ld hl,0d910h		;8624
	set 0,(hl)		;8627
	pop hl			;8629
	ret			;862a
L_862B:
	ld hl,0d910h		;862b
	res 0,(hl)		;862e
	pop hl			;8630
	ret			;8631
L_8632:
	ld a,(ix+000h)		;8632
	cp 017h		;8635
	ret c			;8637
	cp 025h		;8638
	ret nc			;863a
	sub 017h		;863b
	push hl			;863d
	add a,a			;863e
	ld l,a			;863f
	ld h,000h		;8640
	ld de,0864ch		;8642
	add hl,de			;8645
	ld e,(hl)			;8646
	inc hl			;8647
	ld d,(hl)			;8648
	ex de,hl			;8649
	ex (sp),hl			;864a
	ret			;864b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x864c..0x8668  (28 bytes)
DATA_864C:
	defb 03dh,088h,03eh,089h,068h,086h,06eh,087h,08bh,087h,0a8h,087h,0f1h,087h,03dh,088h	; 864c  =.>.h.n.......=.
	defb 03dh,088h,056h,088h,073h,088h,092h,088h,073h,088h,091h,088h	; 865c  =.V.s...s...

; ======================================================================
; CODIGO 0x8668..0x8855  (493 bytes)
; ======================================================================


L_8668:
	ld a,(ix+001h)		;8668
	cp 001h		;866b
	jp c,L_867E		;866d
	jp z,L_86CC		;8670
	cp 003h		;8673
	jp c,L_8722		;8675
	jp z,L_8722		;8678
	jp L_8722		;867b
L_867E:
	ld a,(ix+002h)		;867e
	cp 009h		;8681
	jr c,L_868B		;8683
	sub 009h		;8685
	neg		;8687
	add a,007h		;8689
L_868B:
	cp 002h		;868b
	ret c			;868d
	cp 005h		;868e
	jr nc,L_86A8		;8690
	dec a			;8692
	add a,a			;8693
	add a,a			;8694
	add a,(ix+006h)		;8695
	sub h			;8698
	sub 008h		;8699
	cp 020h		;869b
	ret nc			;869d
	ld a,(ix+007h)		;869e
	add a,006h		;86a1
	cp 01ch		;86a3
	ret nc			;86a5
	jr L_86BD		;86a6
L_86A8:
	dec a			;86a8
	add a,a			;86a9
	add a,a			;86aa
	add a,(ix+006h)		;86ab
	sub h			;86ae
	sub 008h		;86af
	cp 030h		;86b1
	ret nc			;86b3
	ld a,(ix+007h)		;86b4
	sub l			;86b7
	add a,006h		;86b8
	cp 01ch		;86ba
	ret nc			;86bc
L_86BD:
	ld d,010h		;86bd
	ld a,(ix+002h)		;86bf
	cp 009h		;86c2
	jp c,07818h		;86c4
	ld d,008h		;86c7
	jp 07818h		;86c9
L_86CC:
	ld a,(ix+002h)		;86cc
	cp 009h		;86cf
	jr c,L_86D9		;86d1
	sub 009h		;86d3
	neg		;86d5
	add a,007h		;86d7
L_86D9:
	cp 002h		;86d9
	ret c			;86db
	cp 005h		;86dc
	jr nc,L_86FA		;86de
	dec a			;86e0
	neg		;86e1
	add a,a			;86e3
	add a,a			;86e4
	add a,020h		;86e5
	add a,(ix+006h)		;86e7
	sub h			;86ea
	add a,008h		;86eb
	cp 020h		;86ed
	ret nc			;86ef
	ld a,(ix+007h)		;86f0
	add a,006h		;86f3
	cp 01ch		;86f5
	ret nc			;86f7
	jr L_8713		;86f8
L_86FA:
	dec a			;86fa
	neg		;86fb
	add a,a			;86fd
	add a,a			;86fe
	add a,020h		;86ff
	add a,(ix+006h)		;8701
	sub h			;8704
	add a,008h		;8705
	cp 030h		;8707
	ret nc			;8709
	ld a,(ix+007h)		;870a
	sub l			;870d
	add a,006h		;870e
	cp 01ch		;8710
	ret nc			;8712
L_8713:
	ld d,010h		;8713
	ld a,(ix+002h)		;8715
	cp 009h		;8718
	jp c,07818h		;871a
	ld d,008h		;871d
	jp 07818h		;871f
L_8722:
	ld a,(ix+002h)		;8722
	cp 009h		;8725
	jr c,L_872F		;8727
	sub 009h		;8729
	neg		;872b
	add a,007h		;872d
L_872F:
	cp 002h		;872f
	ret c			;8731
	cp 005h		;8732
	jr nc,L_8752		;8734
	dec a			;8736
	neg		;8737
	add a,a			;8739
	add a,a			;873a
	add a,020h		;873b
	add a,(ix+007h)		;873d
	sub l			;8740
	add a,00ah		;8741
	cp 024h		;8743
	ret nc			;8745
	ld a,(ix+006h)		;8746
	sub h			;8749
	add a,00ch		;874a
	cp 018h		;874c
	ret nc			;874e
	jp L_86BD		;874f
L_8752:
	dec a			;8752
	neg		;8753
	add a,a			;8755
	add a,a			;8756
	add a,020h		;8757
	add a,(ix+007h)		;8759
	sub l			;875c
	add a,00ah		;875d
	cp 024h		;875f
	ret nc			;8761
	ld a,(ix+006h)		;8762
	sub h			;8765
	add a,00ch		;8766
	cp 018h		;8768
	ret nc			;876a
	jp L_86BD		;876b
L_876E:
	ld a,(ix+001h)		;876e
	or a			;8771
	ret nz			;8772
	ld a,(ix+006h)		;8773
	sub h			;8776
	add a,005h		;8777
	cp 01bh		;8779
	ret nc			;877b
	ld a,(ix+007h)		;877c
	sub l			;877f
	add a,006h		;8780
	cp 020h		;8782
	ret nc			;8784
	ld d,008h		;8785
	call 07818h		;8787
	ret			;878a
L_878B:
	ld a,(ix+001h)		;878b
	or a			;878e
	ret nz			;878f
	ld a,(ix+006h)		;8790
	sub h			;8793
	add a,007h		;8794
	cp 017h		;8796
	ret nc			;8798
	ld a,(ix+007h)		;8799
	sub l			;879c
	add a,006h		;879d
	cp 020h		;879f
	ret nc			;87a1
	ld d,008h		;87a2
	call 07818h		;87a4
	ret			;87a7
L_87A8:
	ld d,000h		;87a8
	ld a,(0d904h)		;87aa
	and 01eh		;87ad
	cp 004h		;87af
	jr nz,L_87B5		;87b1
	ld d,00eh		;87b3
L_87B5:
	ld a,(ix+002h)		;87b5
	and 00fh		;87b8
	cp 00fh		;87ba
	jr nz,L_87BF		;87bc
	xor a			;87be
L_87BF:
	cp 008h		;87bf
	jr c,L_87CD		;87c1
	sub 008h		;87c3
	cp 008h		;87c5
	jr nc,L_87B5		;87c7
	neg		;87c9
	add a,006h		;87cb
L_87CD:
	add a,a			;87cd
	add a,a			;87ce
	add a,(ix+007h)		;87cf
	sub l			;87d2
	sub d			;87d3
	add a,012h		;87d4
	cp 021h		;87d6
	ret nc			;87d8
	ld a,(ix+006h)		;87d9
	sub h			;87dc
	add a,013h		;87dd
	cp 028h		;87df
	ret nc			;87e1
	ld d,010h		;87e2
	ld a,(ix+002h)		;87e4
	cp 008h		;87e7
	jp c,07818h		;87e9
	ld d,008h		;87ec
	jp 07818h		;87ee
L_87F1:
	ld a,(ix+002h)		;87f1
	cp 009h		;87f4
	jr c,L_87FE		;87f6
	sub 009h		;87f8
	neg		;87fa
	add a,007h		;87fc
L_87FE:
	cp 002h		;87fe
	ret c			;8800
	cp 005h		;8801
	jr nc,L_8821		;8803
	dec a			;8805
	neg		;8806
	add a,a			;8808
	add a,a			;8809
	add a,020h		;880a
	add a,(ix+007h)		;880c
	sub l			;880f
	add a,00ah		;8810
	cp 024h		;8812
	ret nc			;8814
	ld a,(ix+006h)		;8815
	sub h			;8818
	add a,013h		;8819
	cp 027h		;881b
	ret nc			;881d
	jp L_86BD		;881e
L_8821:
	dec a			;8821
	neg		;8822
	add a,a			;8824
	add a,a			;8825
	add a,020h		;8826
	add a,(ix+007h)		;8828
	sub l			;882b
	add a,00ah		;882c
	cp 024h		;882e
	ret nc			;8830
	ld a,(ix+006h)		;8831
	sub h			;8834
	add a,013h		;8835
	cp 027h		;8837
	ret nc			;8839
	jp L_86BD		;883a
L_883D:
	ld a,(ix+006h)		;883d
	sub h			;8840
	add a,00ah		;8841
	cp 015h		;8843
	ret nc			;8845
	ld a,(ix+007h)		;8846
	sub l			;8849
	add a,006h		;884a
	cp 01bh		;884c
	ret nc			;884e
	ld d,008h		;884f
	call 07818h		;8851
	ret			;8854

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8855..0x8856  (1 bytes)
DATA_8855:
	defb 0c9h	; 8855

; ======================================================================
; CODIGO 0x8856..0x8c13  (957 bytes)
; ======================================================================


L_8856:
	ld a,(ix+001h)		;8856
	or a			;8859
	ret nz			;885a
	ld a,(ix+006h)		;885b
	sub h			;885e
	add a,005h		;885f
	cp 01bh		;8861
	ret nc			;8863
	ld a,(ix+007h)		;8864
	sub l			;8867
	add a,009h		;8868
	cp 023h		;886a
	ret nc			;886c
	ld d,008h		;886d
	call 07818h		;886f
	ret			;8872
L_8873:
	ld a,(ix+001h)		;8873
	cp 001h		;8876
	ret nz			;8878
	ld a,(ix+006h)		;8879
	sub h			;887c
	add a,00ch		;887d
	cp 019h		;887f
	ret nc			;8881
	ld a,(ix+007h)		;8882
	sub l			;8885
	add a,028h		;8886
	cp 03eh		;8888
	ret nc			;888a
	ld d,008h		;888b
	call 07818h		;888d
	ret			;8890
L_8891:
	ret			;8891
L_8892:
	ld a,(0d90fh)		;8892
	bit 2,a		;8895
	jp nz,L_88F0		;8897
	ld a,(0d90dh)		;889a
	bit 1,a		;889d
	jr nz,L_88A7		;889f
	bit 7,a		;88a1
	ret z			;88a3
	bit 6,a		;88a4
	ret z			;88a6
L_88A7:
	ld a,(ix+007h)		;88a7
	ld e,a			;88aa
	ld a,(ix+002h)		;88ab
	inc a			;88ae
	cp 010h		;88af
	ret nc			;88b1
	cp 009h		;88b2
	jr c,L_88BC		;88b4
	sub 009h		;88b6
	neg		;88b8
	add a,007h		;88ba
L_88BC:
	neg		;88bc
	add a,008h		;88be
	add a,a			;88c0
	add a,a			;88c1
	add a,e			;88c2
	sub 020h		;88c3
	ld e,a			;88c5
	sub l			;88c6
	add a,003h		;88c7
	cp 006h		;88c9
	ret nc			;88cb
	ld a,(ix+006h)		;88cc
	sub h			;88cf
	add a,017h		;88d0
	cp 02eh		;88d2
	ret nc			;88d4
	ld l,e			;88d5
	ld a,l			;88d6
	ld (0d8fdh),a		;88d7   ; la y de Rastan = a
	ld (0d914h),ix		;88da
	push hl			;88de
	ld hl,0d90fh		;88df
	set 2,(hl)		;88e2
	ld hl,0d90dh		;88e4
	ld (hl),000h		;88e7
	ld hl,0d90fh		;88e9
	res 0,(hl)		;88ec
	pop hl			;88ee
	ret			;88ef
L_88F0:
	ld de,(0d914h)		;88f0
	and a			;88f4
	push hl			;88f5
	push ix		;88f6
	pop hl			;88f8
	sbc hl,de		;88f9
	pop hl			;88fb
	ret nz			;88fc
	ld a,(ix+007h)		;88fd
	ld e,a			;8900
	ld a,(ix+002h)		;8901
	inc a			;8904
	cp 010h		;8905
	jp nc,L_892F		;8907
	cp 009h		;890a
	jr c,L_8914		;890c
	sub 009h		;890e
	neg		;8910
	add a,007h		;8912
L_8914:
	neg		;8914
	add a,008h		;8916
	add a,a			;8918
	add a,a			;8919
	add a,e			;891a
	sub 020h		;891b
	ld e,a			;891d
	ld a,(ix+006h)		;891e
	sub h			;8921
	add a,017h		;8922
	cp 02eh		;8924
	jp nc,L_892F		;8926
	ld l,e			;8929
	ld a,l			;892a
	ld (0d8fdh),a		;892b   ; la y de Rastan = a
	ret			;892e
L_892F:
	push hl			;892f
	ld hl,0d90fh		;8930
	res 2,(hl)		;8933
	ld hl,0d90dh		;8935
	set 7,(hl)		;8938
	set 1,(hl)		;893a
	pop hl			;893c
	ret			;893d
L_893E:
	ld a,(0d90fh)		;893e
	bit 3,a		;8941
	ret nz			;8943
	ld de,(0d914h)		;8944
	and a			;8948
	push hl			;8949
	push ix		;894a
	pop hl			;894c
	sbc hl,de		;894d
	pop hl			;894f
	ret z			;8950
	ld a,(ix+002h)		;8951
	and 07fh		;8954
	cp 00ah		;8956
	jr c,L_8960		;8958
	sub 00ah		;895a
	neg		;895c
	add a,008h		;895e
L_8960:
	ld c,a			;8960
	ld a,(ix+001h)		;8961
	cp 001h		;8964
	jp c,L_8B4A		;8966
	jp z,L_8ACA		;8969
	cp 002h		;896c
	jp z,L_8A33		;896e
	ld a,l			;8971
	sub (ix+007h)		;8972
	ld b,a			;8975
	sub 004h		;8976
	cp 018h		;8978
	ret nc			;897a
	ld a,c			;897b
	add a,a			;897c
	add a,a			;897d
	add a,a			;897e
	push hl			;897f
	ld l,a			;8980
	ld h,000h		;8981
	ld de,090ech		;8983
	add hl,de			;8986
	ld e,b			;8987
	srl e		;8988
	ld d,000h		;898a
	add hl,de			;898c
	ld a,(hl)			;898d
	add a,(ix+006h)		;898e
	sub 010h		;8991
	ld e,a			;8993
	pop hl			;8994
	sub h			;8995
	add a,004h		;8996
	cp 009h		;8998
	ret nc			;899a
	ld a,(0d90fh)		;899b
	set 3,a		;899e
	ld (0d90fh),a		;89a0
	ld a,e			;89a3
	ld (0d8fch),a		;89a4   ; la x de Rastan = a
	ld (0d914h),ix		;89a7
	ld a,(0d90fh)		;89ab
	res 0,a		;89ae
	ld (0d90fh),a		;89b0
	ld a,(ix+002h)		;89b3
	and 07fh		;89b6
	ld (0d916h),a		;89b8
	cp 001h		;89bb
	jr c,L_8A00		;89bd
	jr z,L_89EB		;89bf
	cp 003h		;89c1
	jr c,L_8A1A		;89c3
	jr z,L_8A25		;89c5
	cp 006h		;89c7
	jr z,L_8A25		;89c9
	cp 007h		;89cb
	jr c,L_8A2E		;89cd
	jr z,L_8A1A		;89cf
	cp 009h		;89d1
	jr c,L_89EB		;89d3
	jr z,L_8A00		;89d5
	cp 00bh		;89d7
	jr c,L_89EB		;89d9
	jr z,L_8A1A		;89db
	cp 00ch		;89dd
	jr z,L_8A25		;89df
	cp 00eh		;89e1
	jr z,L_8A25		;89e3
	cp 010h		;89e5
	jr c,L_8A2E		;89e7
	jr z,L_8A1A		;89e9
L_89EB:
	ld a,l			;89eb
	sub (ix+007h)		;89ec
	cp 005h		;89ef
	jr c,L_8A2E		;89f1
	inc l			;89f3
	cp 00dh		;89f4
	jr c,L_8A2E		;89f6
	inc l			;89f8
	cp 016h		;89f9
	jr c,L_8A2E		;89fb
	inc l			;89fd
	jr L_8A2E		;89fe
L_8A00:
	ld a,l			;8a00
	sub (ix+007h)		;8a01
	cp 003h		;8a04
	jr c,L_8A2E		;8a06
	inc l			;8a08
	cp 008h		;8a09
	jr c,L_8A2E		;8a0b
	inc l			;8a0d
	cp 00dh		;8a0e
	jr c,L_8A2E		;8a10
	inc l			;8a12
	cp 013h		;8a13
	jr c,L_8A2E		;8a15
	inc l			;8a17
	jr L_8A2E		;8a18
L_8A1A:
	ld a,l			;8a1a
	sub (ix+007h)		;8a1b
	cp 009h		;8a1e
	jr c,L_8A2E		;8a20
	inc l			;8a22
	jr L_8A2E		;8a23
L_8A25:
	ld a,l			;8a25
	sub (ix+007h)		;8a26
	cp 017h		;8a29
	jr c,L_8A2E		;8a2b
	inc l			;8a2d
L_8A2E:
	ld a,l			;8a2e
	ld (0d917h),a		;8a2f
	ret			;8a32
L_8A33:
	ld a,l			;8a33
	sub (ix+007h)		;8a34
	ld b,a			;8a37
	sub 004h		;8a38
	cp 028h		;8a3a
	ret nc			;8a3c
	ld a,c			;8a3d
	add a,a			;8a3e
	add a,c			;8a3f
	add a,a			;8a40
	add a,a			;8a41
	add a,a			;8a42
	push hl			;8a43
	ld l,a			;8a44
	ld h,000h		;8a45
	ld de,08ffch		;8a47
	add hl,de			;8a4a
	ld e,b			;8a4b
	srl e		;8a4c
	ld d,000h		;8a4e
	add hl,de			;8a50
	ld a,(hl)			;8a51
	add a,(ix+006h)		;8a52
	sub 010h		;8a55
	ld e,a			;8a57
	pop hl			;8a58
	sub h			;8a59
	add a,004h		;8a5a
	cp 009h		;8a5c
	ret nc			;8a5e
	ld a,(0d90fh)		;8a5f
	set 3,a		;8a62
	ld (0d90fh),a		;8a64
	ld a,e			;8a67
	ld (0d8fch),a		;8a68   ; la x de Rastan = a
	ld (0d914h),ix		;8a6b
	ld a,(0d90fh)		;8a6f
	res 0,a		;8a72
	ld (0d90fh),a		;8a74
	ld a,(ix+002h)		;8a77
	and 07fh		;8a7a
	ld (0d916h),a		;8a7c
	cp 001h		;8a7f
	jr c,L_8AAC		;8a81
	jr z,L_8AA1		;8a83
	cp 003h		;8a85
	jr c,L_8ABC		;8a87
	cp 007h		;8a89
	jr c,L_8AC5		;8a8b
	jr z,L_8ABC		;8a8d
	cp 009h		;8a8f
	jr c,L_8AA1		;8a91
	jr z,L_8AAC		;8a93
	cp 00bh		;8a95
	jr c,L_8AA1		;8a97
	jr z,L_8ABC		;8a99
	cp 010h		;8a9b
	jr c,L_8AC5		;8a9d
	jr z,L_8ABC		;8a9f
L_8AA1:
	ld a,l			;8aa1
	sub (ix+007h)		;8aa2
	cp 00fh		;8aa5
	jr c,L_8AC5		;8aa7
	inc l			;8aa9
	jr L_8AC5		;8aaa
L_8AAC:
	ld a,l			;8aac
	sub (ix+007h)		;8aad
	cp 009h		;8ab0
	jr c,L_8AC5		;8ab2
	inc l			;8ab4
	cp 01ch		;8ab5
	jr c,L_8AC5		;8ab7
	inc l			;8ab9
	jr L_8AC5		;8aba
L_8ABC:
	ld a,l			;8abc
	sub (ix+007h)		;8abd
	cp 01eh		;8ac0
	jr c,L_8AC5		;8ac2
	inc l			;8ac4
L_8AC5:
	ld a,l			;8ac5
	ld (0d917h),a		;8ac6
	ret			;8ac9
L_8ACA:
	ld a,l			;8aca
	sub (ix+007h)		;8acb
	ld b,a			;8ace
	sub 004h		;8acf
	cp 038h		;8ad1
	ret nc			;8ad3
	ld a,c			;8ad4
	add a,a			;8ad5
	add a,a			;8ad6
	add a,a			;8ad7
	add a,a			;8ad8
	push hl			;8ad9
	ld l,a			;8ada
	ld h,000h		;8adb
	add hl,hl			;8add
	ld de,08ebch		;8ade
	add hl,de			;8ae1
	ld e,b			;8ae2
	srl e		;8ae3
	ld d,000h		;8ae5
	add hl,de			;8ae7
	ld a,(hl)			;8ae8
	add a,(ix+006h)		;8ae9
	sub 010h		;8aec
	ld e,a			;8aee
	pop hl			;8aef
	sub h			;8af0
	add a,004h		;8af1
	cp 009h		;8af3
	ret nc			;8af5
	ld a,(0d90fh)		;8af6
	set 3,a		;8af9
	ld (0d90fh),a		;8afb
	ld a,e			;8afe
	ld (0d8fch),a		;8aff   ; la x de Rastan = a
	ld (0d914h),ix		;8b02
	ld a,(0d90fh)		;8b06
	res 0,a		;8b09
	ld (0d90fh),a		;8b0b
	ld a,(ix+002h)		;8b0e
	and 07fh		;8b11
	ld (0d916h),a		;8b13
	cp 001h		;8b16
	jr c,L_8B37		;8b18
	jr z,L_8B2C		;8b1a
	cp 008h		;8b1c
	jr c,L_8B45		;8b1e
	jr z,L_8B2C		;8b20
	cp 00ah		;8b22
	jr c,L_8B37		;8b24
	jr z,L_8B2C		;8b26
	cp 011h		;8b28
	jr c,L_8B45		;8b2a
L_8B2C:
	ld a,l			;8b2c
	sub (ix+007h)		;8b2d
	cp 01bh		;8b30
	jr c,L_8B45		;8b32
	inc l			;8b34
	jr L_8B45		;8b35
L_8B37:
	ld a,l			;8b37
	sub (ix+007h)		;8b38
	cp 011h		;8b3b
	jr c,L_8B45		;8b3d
	inc l			;8b3f
	cp 02fh		;8b40
	jr c,L_8B45		;8b42
	inc l			;8b44
L_8B45:
	ld a,l			;8b45
	ld (0d917h),a		;8b46
	ret			;8b49
L_8B4A:
	ld a,l			;8b4a
	sub (ix+007h)		;8b4b
	ld b,a			;8b4e
	sub 004h		;8b4f
	cp 048h		;8b51
	ret nc			;8b53
	ld a,c			;8b54
	add a,a			;8b55
	add a,a			;8b56
	add a,c			;8b57
	add a,a			;8b58
	add a,a			;8b59
	push hl			;8b5a
	ld l,a			;8b5b
	ld h,000h		;8b5c
	add hl,hl			;8b5e
	ld de,08d2ch		;8b5f
	add hl,de			;8b62
	ld e,b			;8b63
	srl e		;8b64
	ld d,000h		;8b66
	add hl,de			;8b68
	ld a,(hl)			;8b69
	add a,(ix+006h)		;8b6a
	sub 010h		;8b6d
	ld e,a			;8b6f
	pop hl			;8b70
	sub h			;8b71
	add a,004h		;8b72
	cp 009h		;8b74
	ret nc			;8b76
	ld a,(0d90fh)		;8b77
	set 3,a		;8b7a
	ld (0d90fh),a		;8b7c
	ld a,e			;8b7f
	ld (0d8fch),a		;8b80   ; la x de Rastan = a
	ld (0d914h),ix		;8b83
	ld a,(0d90fh)		;8b87
	res 0,a		;8b8a
	ld (0d90fh),a		;8b8c
	ld a,(ix+002h)		;8b8f
	and 07fh		;8b92
	ld (0d916h),a		;8b94
	cp 001h		;8b97
	jr c,L_8BB8		;8b99
	jr z,L_8BAD		;8b9b
	cp 008h		;8b9d
	jr c,L_8BC1		;8b9f
	jr z,L_8BAD		;8ba1
	cp 00ah		;8ba3
	jr c,L_8BB8		;8ba5
	jr z,L_8BAD		;8ba7
	cp 011h		;8ba9
	jr c,L_8BC1		;8bab
L_8BAD:
	ld a,l			;8bad
	sub (ix+007h)		;8bae
	cp 01fh		;8bb1
	jr c,L_8BC1		;8bb3
	inc l			;8bb5
	jr L_8BC1		;8bb6
L_8BB8:
	ld a,l			;8bb8
	sub (ix+007h)		;8bb9
	cp 02fh		;8bbc
	jr c,L_8BC1		;8bbe
	inc l			;8bc0
L_8BC1:
	ld a,l			;8bc1
	ld (0d917h),a		;8bc2
	ret			;8bc5
L_8BC6:
	ld a,(0d92dh)		;8bc6   ; a = cual es el bloque especial
	cp 013h		;8bc9
	ret nc			;8bcb
	sub 004h		;8bcc
	ret c			;8bce
	ld c,a			;8bcf
	ld a,(0d92bh)		;8bd0   ; a = x del bloque especial de la pantalla
	sub h			;8bd3
	add a,007h		;8bd4
	cp 01ah		;8bd6
	ret nc			;8bd8
	ld a,(0d92ch)		;8bd9   ; a = y del bloque especial
	sub l			;8bdc
	add a,007h		;8bdd
	cp 01fh		;8bdf
	ret nc			;8be1
	push hl			;8be2
	call 0629eh		;8be3
	ld a,(0d92dh)		;8be6   ; a = cual es el bloque especial
	sub 004h		;8be9
	add a,a			;8beb
	ld c,a			;8bec
	ld b,000h		;8bed
	exx			;8bef
	ld hl,0d928h		;8bf0
	set 2,(hl)		;8bf3
	exx			;8bf5
	ld hl,08c31h		;8bf6
	add hl,bc			;8bf9
	ld e,(hl)			;8bfa
	inc hl			;8bfb
	ld d,(hl)			;8bfc
	push bc			;8bfd
	ld bc,00000h		;8bfe
	call L_8D0B		;8c01
	pop bc			;8c04
	ld hl,08c13h		;8c05
	add hl,bc			;8c08
	ld e,(hl)			;8c09
	inc hl			;8c0a
	ld d,(hl)			;8c0b
	ex de,hl			;8c0c
	xor a			;8c0d
	ld (0d92dh),a		;8c0e   ; cual es el bloque especial = a
	ex (sp),hl			;8c11
	ret			;8c12

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8c13..0x8c4f  (60 bytes)
DATA_8C13:
	defb 00ah,08dh,00ah,08dh,00ah,08dh,04fh,08ch,053h,08ch,06fh,08ch,073h,08ch,057h,08ch	; 8c13  ......O.S.o.s.W.
	defb 0b6h,08ch,0c8h,08ch,0e1h,08ch,0fch,08ch,07ah,08ch,07eh,08ch,082h,08ch,000h,001h	; 8c23  ........z.~.....
	defb 000h,002h,000h,003h,000h,001h,000h,002h,000h,010h,000h,020h,000h,001h,000h,000h	; 8c33  ........... ....
	defb 000h,001h,000h,005h,000h,003h,000h,001h,050h,001h,000h,002h	; 8c43  ........P...

; ======================================================================
; CODIGO 0x8c4f..0x8d2c  (221 bytes)
; ======================================================================


L_8C4F:
	ld c,010h		;8c4f
	jr L_8C5E		;8c51
L_8C53:
	ld c,020h		;8c53
	jr L_8C5E		;8c55
L_8C57:
	ld a,(0d91dh)		;8c57
	ld (0d91ch),a		;8c5a
	ret			;8c5d
L_8C5E:
	ld a,(0d91ch)		;8c5e
	add a,c			;8c61
	ld b,a			;8c62
	ld a,(0d91dh)		;8c63
	cp b			;8c66
	jr nc,L_8C6A		;8c67
	ld b,a			;8c69
L_8C6A:
	ld a,b			;8c6a
	ld (0d91ch),a		;8c6b
	ret			;8c6e
L_8C6F:
	ld d,004h		;8c6f
	jr L_8C77		;8c71
L_8C73:
	ld d,008h		;8c73
	jr L_8C77		;8c75
L_8C77:
	jp 07818h		;8c77
L_8C7A:
	ld d,001h		;8c7a
	jr L_8C84		;8c7c
L_8C7E:
	ld d,002h		;8c7e
	jr L_8C84		;8c80
L_8C82:
	ld d,003h		;8c82
L_8C84:
	ld a,d			;8c84
	ld (0d91bh),a		;8c85
	add a,a			;8c88
	add a,a			;8c89
	ld d,a			;8c8a
	ld a,(0d905h)		;8c8b
	and 0f3h		;8c8e
	or d			;8c90
	ld (0d905h),a		;8c91
	ld a,(0d920h)		;8c94
	ld d,009h		;8c97
	cp 010h		;8c99
	jr nc,L_8CB1		;8c9b
	ld d,008h		;8c9d
	cp 006h		;8c9f
	jr nc,L_8CB1		;8ca1
	ld d,007h		;8ca3
	cp 003h		;8ca5
	jr nc,L_8CB1		;8ca7
	ld d,006h		;8ca9
	cp 001h		;8cab
	jr nc,L_8CB1		;8cad
	ld d,005h		;8caf
L_8CB1:
	ld a,d			;8cb1
	ld (0d926h),a		;8cb2
	ret			;8cb5
L_8CB6:
	ld b,003h		;8cb6
	ld de,00026h		;8cb8
	ld ix,0d933h		;8cbb   ; ix -> los 6 actores de la pantalla
L_8CBF:
	ld (ix+00fh),000h		;8cbf
	add ix,de		;8cc3
	djnz L_8CBF		;8cc5
	ret			;8cc7
L_8CC8:
	ld a,(0d919h)		;8cc8
	or a			;8ccb
	ret z			;8ccc
	ld a,(0d91ah)		;8ccd
	add a,a			;8cd0
	jr nc,L_8CD5		;8cd1
	ld a,0ffh		;8cd3
L_8CD5:
	ld (0d91ah),a		;8cd5
	ld a,(0d905h)		;8cd8
	set 7,a		;8cdb
	ld (0d905h),a		;8cdd
	ret			;8ce0
L_8CE1:
	ld a,(0d91bh)		;8ce1
	or a			;8ce4
	ret z			;8ce5
	ld a,(0d926h)		;8ce6
	add a,a			;8ce9
	cp 020h		;8cea
	jr c,L_8CF0		;8cec
	ld a,01fh		;8cee
L_8CF0:
	ld (0d926h),a		;8cf0
	ld a,(0d905h)		;8cf3
	set 6,a		;8cf6
	ld (0d905h),a		;8cf8
	ret			;8cfb
L_8CFC:
	ld a,(0d905h)		;8cfc
	set 5,a		;8cff
	ld (0d905h),a		;8d01
	ld a,03ch		;8d04
	ld (0d92ah),a		;8d06
	ret			;8d09
L_8D0A:
	ret			;8d0a
L_8D0B:
	ld a,(0d905h)		;8d0b
	bit 5,a		;8d0e
	call nz,L_8D13		;8d10
L_8D13:
	ld a,e			;8d13
	ld hl,0d91eh		;8d14
	add a,(hl)			;8d17
	daa			;8d18
	ld (hl),a			;8d19
	inc hl			;8d1a
	ld a,d			;8d1b
	adc a,(hl)			;8d1c
	daa			;8d1d
	ld (hl),a			;8d1e
	inc hl			;8d1f
	ld a,c			;8d20
	adc a,(hl)			;8d21
	daa			;8d22
	ld (hl),a			;8d23
	inc hl			;8d24
	ld a,b			;8d25
	adc a,(hl)			;8d26
	daa			;8d27
	set 7,a		;8d28
	ld (hl),a			;8d2a
	ret			;8d2b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d2c..0x918c  (1120 bytes)
DATA_8D2C:
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,004h,004h,004h,003h,003h	; 8d2c  ................
	defb 002h,002h,002h,001h,001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch	; 8d3c  ................
	defb 0fbh,0fbh,0fah,0f9h,0f9h,0f8h,0f7h,0f7h,007h,007h,007h,007h,006h,006h,006h,006h	; 8d4c  ................
	defb 005h,005h,005h,005h,004h,004h,004h,004h,003h,003h,003h,002h,002h,002h,001h,001h	; 8d5c  ................
	defb 000h,000h,000h,0ffh,0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch,0fbh,0fbh,0fah,0fah	; 8d6c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h	; 8d7c  ................
	defb 004h,004h,004h,004h,003h,003h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h	; 8d8c  ................
	defb 0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch,007h,007h,007h,007h,007h,007h,007h,007h	; 8d9c  ................
	defb 006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h,003h,003h,003h,003h	; 8dac  ................
	defb 002h,002h,002h,002h,001h,001h,001h,001h,000h,000h,000h,0ffh,0ffh,0ffh,0feh,0feh	; 8dbc  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 8dcc  ................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,006h,006h,006h,006h,005h,005h,005h,005h	; 8ddc  ................
	defb 004h,004h,004h,004h,003h,003h,003h,003h,007h,007h,007h,007h,007h,007h,007h,007h	; 8dec  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,008h,008h,008h,008h	; 8dfc  ................
	defb 008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh	; 8e0c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,008h,008h,008h,008h	; 8e1c  ................
	defb 009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh,00ch,00ch,00ch,00ch	; 8e2c  ................
	defb 00dh,00dh,00dh,00eh,00eh,00eh,00fh,00fh,007h,007h,007h,007h,007h,007h,007h,007h	; 8e3c  ................
	defb 008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh	; 8e4c  ................
	defb 00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h,012h,012h	; 8e5c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 8e6c  ................
	defb 00bh,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00eh,00eh,00eh,00fh,00fh,00fh,010h,010h	; 8e7c  ................
	defb 011h,011h,012h,012h,013h,013h,014h,014h,007h,007h,007h,007h,008h,008h,008h,008h	; 8e8c  ................
	defb 009h,009h,009h,00ah,00ah,00ah,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh	; 8e9c  ................
	defb 00fh,00fh,010h,010h,011h,011h,012h,012h,013h,013h,014h,015h,015h,016h,017h,017h	; 8eac  ................
	defb 007h,007h,007h,006h,006h,006h,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h	; 8ebc  ................
	defb 000h,000h,0ffh,0feh,0feh,0fdh,0fch,0fch,0fbh,0fah,0fah,0f9h,0f8h,0f8h,0f7h,0f7h	; 8ecc  ................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,004h,004h,004h,003h,003h	; 8edc  ................
	defb 002h,002h,001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fch,0fch,0fbh,0fah,0fah	; 8eec  ................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 8efc  ................
	defb 003h,003h,003h,002h,002h,002h,001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh	; 8f0c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h	; 8f1c  ................
	defb 004h,004h,004h,004h,003h,003h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h	; 8f2c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 8f3c  ................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 8f4c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 8f5c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 8f6c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h	; 8f7c  ................
	defb 00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh	; 8f8c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 8f9c  ................
	defb 00bh,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h	; 8fac  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,00ah,00ah,00ah,00bh,00bh	; 8fbc  ................
	defb 00ch,00ch,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,012h,012h,013h,014h,014h	; 8fcc  ................
	defb 007h,007h,007h,008h,008h,008h,009h,009h,00ah,00ah,00bh,00bh,00ch,00ch,00dh,00dh	; 8fdc  ................
	defb 00eh,00eh,00fh,010h,010h,011h,012h,012h,013h,014h,014h,015h,016h,016h,017h,017h	; 8fec  ................
	defb 007h,007h,006h,005h,005h,004h,003h,003h,002h,001h,001h,000h,0ffh,0ffh,0feh,0fdh	; 8ffc  ................
	defb 0fch,0fbh,0fah,0f9h,0f8h,0f7h,0f6h,0f5h,007h,007h,006h,006h,005h,005h,004h,004h	; 900c  ................
	defb 003h,003h,002h,001h,001h,000h,0ffh,0ffh,0feh,0fdh,0fdh,0fch,0fch,0fbh,0fbh,0fah	; 901c  ................
	defb 007h,007h,007h,006h,006h,006h,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h	; 902c  ................
	defb 000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh,007h,007h,007h,007h,006h,006h,006h,006h	; 903c  ................
	defb 005h,005h,005h,004h,004h,004h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h	; 904c  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,006h,006h,006h,006h	; 905c  ................
	defb 005h,005h,005h,005h,004h,004h,004h,004h,007h,007h,007h,007h,007h,007h,007h,007h	; 906c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 907c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,00ah,00ah,00ah,00bh,00bh	; 908c  ................
	defb 00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh,007h,007h,007h,008h,008h,008h,009h,009h	; 909c  ................
	defb 00ah,00ah,00bh,00bh,00ch,00ch,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h	; 90ac  ................
	defb 007h,007h,008h,009h,009h,00ah,00bh,00bh,00ch,00dh,00dh,00eh,00eh,00fh,010h,010h	; 90bc  ................
	defb 011h,012h,012h,013h,014h,014h,015h,015h,007h,007h,008h,009h,009h,00ah,00ah,00bh	; 90cc  ................
	defb 00ch,00ch,00dh,00eh,00eh,00fh,010h,011h,012h,013h,014h,015h,016h,017h,018h,019h	; 90dc  ................
	defb 007h,006h,005h,003h,002h,001h,0ffh,0feh,0fch,0fah,0f8h,0f6h,0f4h,0f2h,0f0h,0eeh	; 90ec  ................
	defb 007h,006h,005h,004h,003h,002h,001h,000h,0ffh,0feh,0fch,0fbh,0fah,0f8h,0f8h,0f8h	; 90fc  ................
	defb 007h,007h,006h,005h,005h,004h,003h,003h,002h,001h,000h,0ffh,0feh,0fdh,0fch,0fbh	; 910c  ................
	defb 007h,007h,006h,006h,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h,000h,000h	; 911c  ................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 912c  ................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 913c  ................
	defb 007h,007h,008h,008h,009h,009h,00ah,00ah,00bh,00bh,00ch,00ch,00dh,00dh,00eh,00eh	; 914c  ................
	defb 007h,007h,008h,009h,009h,00ah,00bh,00bh,00ch,00dh,00eh,00fh,010h,011h,012h,013h	; 915c  ................
	defb 007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh,010h,012h,013h,014h,016h,017h,017h	; 916c  ................
	defb 007h,008h,009h,00bh,00ch,00dh,00eh,010h,012h,014h,016h,018h,01ah,01ch,01eh,01eh	; 917c  ................

; ======================================================================
; CODIGO 0x918c..0x91c5  (57 bytes)
; ======================================================================


L_918C:
	ld hl,(0d969h)		;918c   ; hl = actor 1, byte +10
	ld a,h			;918f
	or l			;9190
	ret z			;9191
	ld a,(0d8fch)		;9192   ; a = la x de Rastan
	ld h,a			;9195
	ld a,(0d8fdh)		;9196   ; a = la y de Rastan
	ld l,a			;9199
	ld a,(0d904h)		;919a
	and 01eh		;919d
	cp 004h		;919f
	jr nz,L_91A7		;91a1
	ld a,l			;91a3
	add a,00eh		;91a4
	ld l,a			;91a6
L_91A7:
	ld a,(0d93ah)		;91a7   ; a = actor 0, byte +7
	ld e,a			;91aa
	ld a,(0d939h)		;91ab   ; a = actor 0, byte +6
	ld d,a			;91ae
	exx			;91af
	ld a,(0d933h)		;91b0   ; a = los 6 actores de la pantalla
	cp 006h		;91b3
	ret nc			;91b5
	add a,a			;91b6
	ld l,a			;91b7
	ld h,000h		;91b8
	ld de,091c5h		;91ba
	add hl,de			;91bd
	ld a,(hl)			;91be
	inc hl			;91bf
	ld h,(hl)			;91c0
	ld l,a			;91c1
	push hl			;91c2
	exx			;91c3
	ret			;91c4

; ----------------------------------------------------------------------
; DATOS sin identificar  0x91c5..0x91d1  (12 bytes)
DATA_91C5:
	defb 0c4h,091h,00ch,092h,0d2h,092h,036h,093h,05dh,093h,0e6h,093h	; 91c5  ......6.]...

; ======================================================================
; CODIGO 0x91d1..0x9200  (47 bytes)
; ======================================================================


L_91D1:
	xor a			;91d1
	ld (0d924h),a		;91d2   ; bit 7: el jugador usa la ficha 10 = a
	ld de,(0d969h)		;91d5   ; de = actor 1, byte +10
	ld a,d			;91d9
	or e			;91da
	ret z			;91db
	ld a,(0d958h)		;91dc   ; a = actor 0, byte +25
	bit 7,a		;91df
	ret nz			;91e1
	ld a,(0d93ah)		;91e2   ; a = actor 0, byte +7
	ld e,a			;91e5
	ld a,(0d939h)		;91e6   ; a = actor 0, byte +6
	ld d,a			;91e9
	exx			;91ea
	ld a,(0d933h)		;91eb   ; a = los 6 actores de la pantalla
	cp 006h		;91ee
	ret nc			;91f0
	add a,a			;91f1
	ld l,a			;91f2
	ld h,000h		;91f3
	ld de,09200h		;91f5
	add hl,de			;91f8
	ld a,(hl)			;91f9
	inc hl			;91fa
	ld h,(hl)			;91fb
	ld l,a			;91fc
	push hl			;91fd
	exx			;91fe
	ret			;91ff

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9200..0xa000  (3584 bytes)
DATA_9200:
	defb 0c4h,091h,02dh,095h,03eh,095h,077h,095h,088h,095h,099h,095h,00eh,00ch,07ah,094h	; 9200  ..-.>.w.......z.
	defb 0c6h,013h,0feh,027h,030h,009h,07bh,095h,0c6h,029h,0feh,043h,0dah,0edh,094h,0e5h	; 9210  ...'0.{..).C....
	defb 0d5h,011h,035h,092h,03ah,034h,0d9h,0e6h,007h,087h,06fh,026h,000h,019h,0d1h,07eh	; 9220  ..5.:4....o&...~
	defb 023h,066h,06fh,0e3h,0c9h,045h,092h,056h,092h,067h,092h,09ch,092h,0d1h,092h,0d1h	; 9230  #fo..E.V.g......
	defb 092h,0d1h,092h,0d1h,092h,07ah,094h,0c6h,022h,0feh,01ah,0d0h,07bh,095h,0c6h,008h	; 9240  .....z.."...{...
	defb 0feh,02fh,0d0h,0c3h,0edh,094h,07ah,094h,0d6h,009h,0feh,01ah,0d0h,07bh,095h,0c6h	; 9250  ./....z......{..
	defb 008h,0feh,02fh,0d0h,0c3h,0edh,094h,00eh,010h,07bh,095h,0c6h,019h,0feh,023h,0d0h	; 9260  ../......{....#.
	defb 03ah,035h,0d9h,0cbh,07fh,0c0h,0feh,001h,028h,00eh,0feh,002h,028h,014h,07ah,094h	; 9270  :5......(...(.z.
	defb 0c6h,03bh,0feh,04bh,0d0h,0c3h,00dh,095h,07ah,094h,0c6h,02bh,0feh,049h,0d0h,0c3h	; 9280  .;.K....z..+.I..
	defb 00dh,095h,07ah,094h,0c6h,033h,0feh,04bh,0d0h,0c3h,00dh,095h,00eh,010h,07bh,095h	; 9290  ..z..3.K......{.
	defb 0c6h,019h,0feh,023h,0d0h,03ah,035h,0d9h,0cbh,07fh,0c0h,0feh,001h,028h,00eh,0feh	; 92a0  ...#.:5......(..
	defb 002h,028h,014h,07ah,094h,0c6h,00fh,0feh,04bh,0d0h,0c3h,00dh,095h,07ah,094h,0c6h	; 92b0  .(.z....K....z..
	defb 01bh,0feh,049h,0d0h,0c3h,00dh,095h,07ah,094h,0c6h,017h,0feh,04bh,0d0h,0c3h,00dh	; 92c0  ..I....z....K...
	defb 095h,0c9h,03ah,034h,0d9h,0e6h,00fh,047h,0feh,002h,028h,005h,0feh,003h,0c2h,00eh	; 92d0  ..:4...G..(.....
	defb 093h,00eh,010h,03ah,035h,0d9h,0feh,003h,0c2h,00eh,093h,07bh,095h,0c6h,007h,0feh	; 92e0  ...:5......{....
	defb 01fh,0d2h,00eh,093h,0cbh,040h,028h,00ch,07ah,094h,0c6h,021h,0feh,021h,0d2h,00eh	; 92f0  .....@(.z..!.!..
	defb 093h,0c3h,00dh,095h,07ah,094h,0feh,021h,0d2h,00eh,093h,0c3h,00dh,095h,00eh,00ch	; 9300  ....z..!........
	defb 078h,0feh,006h,030h,011h,07ah,094h,0c6h,009h,0feh,013h,0d0h,07bh,095h,0c6h,017h	; 9310  x..0.z......{...
	defb 0feh,02fh,0d0h,0c3h,0edh,094h,07ah,094h,0c6h,009h,0feh,013h,0d0h,07bh,0c6h,017h	; 9320  ./....z......{..
	defb 0feh,03fh,0d0h,0c3h,0edh,094h,07bh,095h,04fh,0d6h,00bh,0feh,00dh,038h,012h,079h	; 9330  .?....{.O....8.y
	defb 0c6h,029h,0feh,035h,0d0h,07ah,094h,0c6h,014h,0feh,029h,0d0h,00eh,024h,0c3h,0edh	; 9340  .).5.z....)..$..
	defb 094h,07ah,094h,0c6h,00dh,0feh,01bh,0d0h,00eh,024h,0c3h,0edh,094h,00eh,018h,03ah	; 9350  .z.......$.....:
	defb 034h,0d9h,0feh,002h,028h,039h,0feh,003h,0c2h,0d3h,093h,03ah,035h,0d9h,0feh,002h	; 9360  4...(9.....:5...
	defb 0dah,0d3h,093h,028h,015h,07bh,095h,0c6h,012h,0feh,021h,0d2h,0d3h,093h,07ah,094h	; 9370  ...(.{....!...z.
	defb 0c6h,00bh,0feh,036h,0dah,00dh,095h,0c3h,0d3h,093h,07bh,095h,0c6h,008h,0feh,027h	; 9380  ...6......{....'
	defb 0d2h,0d3h,093h,07ah,094h,0c6h,020h,0feh,018h,0dah,00dh,095h,0c3h,0d3h,093h,03ah	; 9390  ...z.. ........:
	defb 035h,0d9h,0feh,002h,0dah,0d3h,093h,028h,015h,07bh,095h,0c6h,012h,0feh,021h,0d2h	; 93a0  5......(.{....!.
	defb 0d3h,093h,07ah,094h,0c6h,02ah,0feh,036h,0dah,00dh,095h,0c3h,0d3h,093h,07bh,095h	; 93b0  ..z..*.6......{.
	defb 0c6h,008h,0feh,027h,0d2h,0d3h,093h,07ah,094h,0d6h,009h,0feh,018h,0dah,00dh,095h	; 93c0  ...'...z........
	defb 0c3h,0d3h,093h,07ah,094h,0c6h,012h,0feh,025h,0d0h,07bh,095h,0c6h,02bh,0feh,03fh	; 93d0  ...z....%.{..+.?
	defb 0d0h,00eh,00ch,0c3h,0edh,094h,00eh,010h,03ah,034h,0d9h,047h,0feh,002h,0dah,085h	; 93e0  ........:4.G....
	defb 094h,028h,053h,0feh,004h,038h,03ah,028h,023h,0feh,006h,0dah,007h,094h,028h,070h	; 93f0  .(S..8:(#.....(p
	defb 0feh,007h,0c2h,085h,094h,018h,054h,07bh,095h,0c6h,017h,0feh,01fh,0d2h,085h,094h	; 9400  ......T{........
	defb 07ah,094h,0d6h,007h,0feh,01ch,0d2h,085h,094h,0c3h,00dh,095h,07bh,095h,0c6h,017h	; 9410  z...........{...
	defb 0feh,01fh,0d2h,085h,094h,07ah,094h,0c6h,032h,0feh,01ch,0d2h,085h,094h,0c3h,00dh	; 9420  .....z..2.......
	defb 095h,07bh,095h,0c6h,007h,0feh,01fh,0d2h,085h,094h,07ah,094h,0d6h,007h,0feh,01ch	; 9430  .{........z.....
	defb 0d2h,085h,094h,0c3h,00dh,095h,07bh,095h,0c6h,007h,0feh,01fh,0d2h,085h,094h,07ah	; 9440  ......{........z
	defb 094h,0c6h,032h,0feh,01ch,0d2h,085h,094h,0c3h,00dh,095h,07bh,095h,0d6h,009h,0feh	; 9450  ..2........{....
	defb 01fh,0d2h,085h,094h,07ah,094h,0c6h,001h,0feh,01ch,0d2h,085h,094h,0c3h,00dh,095h	; 9460  ....z...........
	defb 07bh,095h,0d6h,009h,0feh,01fh,0d2h,085h,094h,07ah,094h,0c6h,02ah,0feh,01ch,0d2h	; 9470  {........z..*...
	defb 085h,094h,0c3h,00dh,095h,00eh,00ch,07bh,095h,0c6h,027h,0feh,01fh,030h,009h,07ah	; 9480  .......{..'..0.z
	defb 094h,0c6h,021h,0feh,033h,0dah,0edh,094h,078h,0feh,008h,028h,03fh,018h,02ch,0feh	; 9490  ..!.3...x..(?.,.
	defb 006h,028h,039h,030h,026h,0e6h,001h,020h,011h,07bh,095h,0c6h,027h,0feh,03fh,0d0h	; 94a0  .(90&.. .{..'.?.
	defb 07ah,094h,0c6h,003h,0feh,017h,0dah,0edh,094h,0c9h,07bh,095h,0c6h,027h,0feh,03fh	; 94b0  z.........{..'.?
	defb 0d0h,07ah,094h,0c6h,023h,0feh,017h,0dah,0edh,094h,0c9h,07bh,095h,0c6h,027h,0feh	; 94c0  .z..#......{..'.
	defb 02fh,0d0h,07ah,094h,0c6h,003h,0feh,017h,0dah,0edh,094h,0c9h,07bh,095h,0c6h,02fh	; 94d0  /.z.........{../
	defb 0feh,03fh,0d0h,07ah,094h,0c6h,023h,0feh,017h,0dah,0edh,094h,0c9h,03ah,01bh,0d9h	; 94e0  .?.z..#......:..
	defb 0b7h,028h,016h,03ah,026h,0d9h,03dh,032h,026h,0d9h,020h,00bh,032h,01bh,0d9h,03ah	; 94f0  .(.:&.=2&. .2..:
	defb 005h,0d9h,0e6h,0b3h,032h,005h,0d9h,0cbh,039h,051h,0c3h,018h,078h,03ah,01bh,0d9h	; 9500  ....2...9Q..x:..
	defb 0b7h,028h,016h,03ah,026h,0d9h,03dh,032h,026h,0d9h,020h,00bh,032h,01bh,0d9h,03ah	; 9510  .(.:&.=2&. .2..:
	defb 005h,0d9h,0e6h,0b3h,032h,005h,0d9h,0cbh,039h,051h,0c3h,018h,078h,07bh,095h,0c6h	; 9520  ....2...9Q..x{..
	defb 02ch,0feh,038h,0d0h,07ah,094h,0c6h,01dh,0feh,02bh,0d0h,0c3h,0c5h,096h,03ah,034h	; 9530  ,.8.z....+....:4
	defb 0d9h,0feh,008h,030h,011h,07bh,095h,0c6h,02ch,0feh,038h,0d0h,07ah,094h,0c6h,015h	; 9540  ...0.{..,.8.z...
	defb 0feh,01bh,0d0h,0c3h,0c5h,096h,07bh,095h,0c6h,02ch,0feh,038h,030h,009h,07ah,094h	; 9550  ......{..,.80.z.
	defb 0c6h,015h,0feh,01bh,0dah,0c5h,096h,07bh,095h,03dh,0feh,019h,0d0h,07ah,094h,0c6h	; 9560  .......{.=...z..
	defb 01bh,0feh,027h,0d0h,0c3h,0c5h,096h,07bh,095h,0c6h,02ch,0feh,038h,0d0h,07ah,094h	; 9570  ..'....{..,.8.z.
	defb 0c6h,01dh,0feh,02bh,0d0h,0c3h,0c5h,096h,07bh,095h,0c6h,02ch,0feh,048h,0d0h,07ah	; 9580  ...+....{..,.H.z
	defb 094h,0c6h,01dh,0feh,02bh,0d0h,0c3h,0c5h,096h,03ah,034h,0d9h,0feh,001h,0dah,05fh	; 9590  ....+....:4...._
	defb 096h,0cah,03eh,096h,0feh,003h,0dah,05fh,096h,0cah,03eh,096h,0feh,005h,038h,07dh	; 95a0  ..>...._..>...8}
	defb 028h,06ah,0feh,007h,0dah,0a3h,096h,0cah,081h,096h,0feh,009h,038h,02fh,03ah,035h	; 95b0  (j..........8/:5
	defb 0d9h,0feh,003h,0d2h,081h,096h,047h,07bh,095h,0c6h,01dh,0feh,01bh,030h,009h,07ah	; 95c0  ......G{.....0.z
	defb 094h,0c6h,00dh,0feh,01bh,0dah,0c5h,096h,078h,0feh,002h,0d8h,07bh,095h,0c6h,00dh	; 95d0  ........x...{...
	defb 0feh,01bh,0d0h,07ah,094h,0c6h,005h,0feh,01bh,0d0h,0c3h,0c5h,096h,03ah,035h,0d9h	; 95e0  ...z.........:5.
	defb 0feh,003h,0d2h,0a3h,096h,047h,07bh,095h,0c6h,01dh,0feh,01bh,030h,009h,07ah,094h	; 95f0  .....G{.....0.z.
	defb 0c6h,02dh,0feh,01bh,0dah,0c5h,096h,078h,0feh,002h,0d8h,07bh,095h,0c6h,00dh,0feh	; 9600  .-.....x...{....
	defb 01bh,0d0h,07ah,094h,0c6h,035h,0feh,01bh,0d0h,0c3h,0c5h,096h,07bh,095h,0c6h,01dh	; 9610  ..z..5......{...
	defb 0feh,01bh,0d0h,07ah,094h,0c6h,018h,0feh,036h,0d0h,0c3h,0c5h,096h,07bh,095h,0c6h	; 9620  ...z....6....{..
	defb 01dh,0feh,01bh,0d0h,07ah,094h,0c6h,03dh,0feh,036h,0d0h,0c3h,0c5h,096h,07bh,095h	; 9630  ....z..=.6....{.
	defb 0c6h,01bh,0feh,029h,030h,009h,07ah,094h,0c6h,00dh,0feh,01bh,0dah,0c5h,096h,07bh	; 9640  ...)0.z........{
	defb 095h,0c6h,00ch,0feh,019h,0d0h,07ah,094h,03dh,0feh,01ch,0d0h,0c3h,0c5h,096h,07bh	; 9650  ......z.=......{
	defb 095h,0c6h,01bh,0feh,029h,030h,009h,07ah,094h,0c6h,02dh,0feh,01bh,0dah,0c5h,096h	; 9660  ....)0.z..-.....
	defb 07bh,095h,0c6h,00ch,0feh,019h,0d0h,07ah,094h,0c6h,03ch,0feh,01ch,0d0h,0c3h,0c5h	; 9670  {......z..<.....
	defb 096h,07bh,095h,0c6h,01bh,0feh,029h,030h,009h,07ah,094h,0c6h,00dh,0feh,01bh,0dah	; 9680  .{....)0.z......
	defb 0c5h,096h,07bh,095h,0d6h,004h,0feh,019h,0d0h,07ah,094h,0c6h,005h,0feh,01bh,0d0h	; 9690  ..{......z......
	defb 0c3h,0c5h,096h,07bh,095h,0c6h,01bh,0feh,029h,030h,009h,07ah,094h,0c6h,02dh,0feh	; 96a0  ...{....)0.z..-.
	defb 01bh,0dah,0c5h,096h,07bh,095h,0d6h,004h,0feh,019h,0d0h,07ah,094h,0c6h,035h,0feh	; 96b0  ....{......z..5.
	defb 01bh,0d0h,0c3h,0c5h,096h,0e5h,021h,028h,0d9h,0cbh,0f6h,02ah,069h,0d9h,006h,000h	; 96c0  ......!(...*i...
	defb 0b7h,0edh,042h,028h,002h,030h,020h,03ah,033h,0d9h,0b7h,028h,01ah,0feh,006h,030h	; 96d0  ..B(.0 :3..(...0
	defb 016h,0c5h,06fh,026h,000h,029h,011h,007h,097h,019h,05eh,023h,056h,001h,000h,000h	; 96e0  ..o&.)....^#V...
	defb 0cdh,00bh,08dh,0c1h,021h,000h,000h,022h,069h,0d9h,03eh,001h,032h,06bh,0d9h,03ah	; 96f0  ....!.."i.>.2k.:
	defb 058h,0d9h,0cbh,0ffh,032h,058h,0d9h,0e1h,0c9h,000h,005h,000h,010h,000h,015h,000h	; 9700  X...2X..........
	defb 020h,000h,025h,000h,030h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9710   .%.0...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9720  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9730  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9740  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9750  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9760  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9770  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9780  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9790  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97a0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97b0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97c0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97d0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97e0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97f0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9800  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9810  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9820  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9830  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9840  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9850  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9860  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9870  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9880  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9890  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98a0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98b0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98c0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98d0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98e0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98f0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9900  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9910  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9920  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9930  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9940  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9950  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9960  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9970  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9980  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9990  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99a0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99b0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99c0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99d0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99e0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99f0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9aa0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ab0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ac0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ad0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ae0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9af0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ba0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bb0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9be0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bf0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ca0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cb0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ce0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cf0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9da0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9db0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9de0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9df0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ea0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9eb0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ec0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ed0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ee0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ef0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f00  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f10  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f20  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f30  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f40  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f50  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f70  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f80  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f90  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fa0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fb0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fe0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ff0  ................
