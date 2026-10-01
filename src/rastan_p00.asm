; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 00 (en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x4000..0x4011  (17 bytes)
DATA_4000:
	defb 041h,042h,011h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............
	defb 000h	; 4010

; ======================================================================
; CODIGO 0x4011..0x41ec  (475 bytes)
; ======================================================================


L_4011:
	di			;4011
	im 1		;4012
	ld hl,0c000h		;4014
	ld bc,03380h		;4017
	ld de,0c001h		;401a
	xor a			;401d
	ld (hl),a			;401e
	ldir		;401f
	ld sp,0f380h		;4021
	ld a,0c9h		;4024
	ld (0fd9ah),a		;4026
	ld (0fd9bh),a		;4029
	ld (0fd9ch),a		;402c
	ld (0fd9fh),a		;402f
	ld (0fda0h),a		;4032
	ld (0fda1h),a		;4035
	ld a,000h		;4038
	ld (0d18fh),a		;403a
	ld (067f8h),a		;403d
	ld a,001h		;4040
	ld (0d190h),a		;4042
	ld (06ff8h),a		;4045
	ld a,002h		;4048
	ld (0d191h),a		;404a
	ld (077f8h),a		;404d
	call 06000h		;4050
	call 06020h		;4053
	call 06077h		;4056
	ld a,000h		;4059
	call L_4228		;405b
	ld a,0c3h		;405e
	ld (0fd9ah),a		;4060
	ld hl,L_406C		;4063
	ld (0fd9bh),hl		;4066
	ei			;4069
L_406A:
	jr L_406A		;406a
L_406C:
	push af			;406c
	push bc			;406d
	push de			;406e
	push hl			;406f
	push ix		;4070
	push iy		;4072
	ex af,af'			;4074
	exx			;4075
	push af			;4076
	push bc			;4077
	push de			;4078
	push hl			;4079
	ex af,af'			;407a
	exx			;407b
	ld bc,(00006h)		;407c
	inc c			;4080
	ld a,000h		;4081
	out (c),a		;4083
	ld a,08fh		;4085
	out (c),a		;4087
	in b,(c)		;4089
	ld a,000h		;408b
	out (c),a		;408d
	ld a,08fh		;408f
	out (c),a		;4091
	bit 7,b		;4093
	jp z,L_412D		;4095
	ld a,001h		;4098
	ld (06ff8h),a		;409a
	inc a			;409d
	ld (077f8h),a		;409e
	call 06153h		;40a1
	call L_4141		;40a4
	ld a,(0d190h)		;40a7
	ld (06ff8h),a		;40aa
	ld a,(0d191h)		;40ad
	ld (077f8h),a		;40b0
	ld hl,04000h		;40b3
	adc hl,sp		;40b6
	jp nc,L_413E		;40b8
	ld ix,0d17eh		;40bb
	ld l,(ix+000h)		;40bf
	ld h,(ix+001h)		;40c2
	inc hl			;40c5
	ld (ix+000h),l		;40c6
	ld (ix+001h),h		;40c9
	inc ix		;40cc
	inc ix		;40ce
	ld l,(ix+000h)		;40d0
	ld h,(ix+001h)		;40d3
	inc hl			;40d6
	ld (ix+000h),l		;40d7
	ld (ix+001h),h		;40da
	inc ix		;40dd
	inc ix		;40df
	ld l,(ix+000h)		;40e1
	ld h,(ix+001h)		;40e4
	inc hl			;40e7
	ld (ix+000h),l		;40e8
	ld (ix+001h),h		;40eb
	inc ix		;40ee
	inc ix		;40f0
	ld l,(ix+000h)		;40f2
	ld h,(ix+001h)		;40f5
	inc hl			;40f8
	ld (ix+000h),l		;40f9
	ld (ix+001h),h		;40fc
	inc ix		;40ff
	inc ix		;4101
	ld l,(ix+000h)		;4103
	ld h,(ix+001h)		;4106
	inc hl			;4109
	ld (ix+000h),l		;410a
	ld (ix+001h),h		;410d
	inc ix		;4110
	inc ix		;4112
	ld a,(0d032h)		;4114
	and a			;4117
	jp nz,L_412D		;4118
	ld a,0ffh		;411b
	ld (0d032h),a		;411d
	call L_4160		;4120
	call L_41D9		;4123
	call L_426E		;4126
	xor a			;4129
	ld (0d032h),a		;412a
L_412D:
	ex af,af'			;412d
	exx			;412e
	pop hl			;412f
	pop de			;4130
	pop bc			;4131
	pop af			;4132
	ex af,af'			;4133
	exx			;4134
	pop iy		;4135
	pop ix		;4137
	pop hl			;4139
	pop de			;413a
	pop bc			;413b
	pop af			;413c
	ret			;413d
L_413E:
	di			;413e
	jr L_413E		;413f
L_4141:
	ld a,(0d17ah)		;4141
	cp 0ffh		;4144
	jr z,L_4150		;4146
	call 0640fh		;4148
	ld a,0ffh		;414b
	ld (0d17ah),a		;414d
L_4150:
	ld a,(0d178h)		;4150
	cp 0ffh		;4153
	jr z,L_415F		;4155
	call 063e1h		;4157
	ld a,0ffh		;415a
	ld (0d178h),a		;415c
L_415F:
	ret			;415f
L_4160:
	ld hl,0d18ch		;4160
	ld a,(hl)			;4163
	add a,00eh		;4164
	cp 020h		;4166
	jr c,L_416C		;4168
	sub 020h		;416a
L_416C:
	ld (hl),a			;416c
	add a,a			;416d
	add a,a			;416e
	ld c,a			;416f
	ld l,a			;4170
	ld h,000h		;4171
	ld de,0d193h		;4173
	add hl,de			;4176
	ex af,af'			;4177
	ld a,080h		;4178
	sub c			;417a
	ld c,a			;417b
	ld b,000h		;417c
	ld (0d18dh),bc		;417e
	ld de,08600h		;4182
	call 0005ch		;4185   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ex af,af'			;4188
	ld c,a			;4189
	ex af,af'			;418a
	dec c			;418b
	inc c			;418c
	jr z,L_41A0		;418d
	ld b,000h		;418f
	ld hl,08600h		;4191
	ld de,(0d18dh)		;4194
	add hl,de			;4198
	ex de,hl			;4199
	ld hl,0d193h		;419a
	call 0005ch		;419d   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_41A0:
	ex af,af'			;41a0
	ld e,a			;41a1
	ex af,af'			;41a2
	ld a,080h		;41a3
	sub e			;41a5
	ld l,a			;41a6
	ld h,000h		;41a7
	add hl,hl			;41a9
	add hl,hl			;41aa
	ld c,l			;41ab
	ld b,h			;41ac
	ld (0d18dh),hl		;41ad
	ld h,000h		;41b0
	ld l,e			;41b2
	add hl,hl			;41b3
	add hl,hl			;41b4
	ld de,0d213h		;41b5
	add hl,de			;41b8
	ld de,08400h		;41b9
	call 0005ch		;41bc   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ex af,af'			;41bf
	or a			;41c0
	ret z			;41c1
	ld l,a			;41c2
	ld h,000h		;41c3
	add hl,hl			;41c5
	add hl,hl			;41c6
	ld c,l			;41c7
	ld b,h			;41c8
	ld hl,08400h		;41c9
	ld de,(0d18dh)		;41cc
	add hl,de			;41d0
	ex de,hl			;41d1
	ld hl,0d213h		;41d2
	call 0005ch		;41d5   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;41d8
L_41D9:
	ld hl,04000h		;41d9
	ld bc,01000h		;41dc
	ld de,008ffh		;41df
	ld a,001h		;41e2
	ex af,af'			;41e4
	ld a,001h		;41e5
	ex af,af'			;41e7
	call L_44F1		;41e8
	ret			;41eb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x41ec..0x4228  (60 bytes)
DATA_41EC:
	defb 0cdh,05dh,044h,0edh,04bh,007h,000h,00ch,03eh,020h,0edh,079h,03eh,091h,0edh,079h	; 41ec  .]D.K...> .y>..y
	defb 00ch,00ch,006h,00fh,021h,006h,042h,0edh,0b3h,0c9h,000h,000h,040h,001h,000h,000h	; 41fc  ....!.B.....@...
	defb 010h,001h,000h,001h,008h,000h,000h,000h,00dh,0e5h,026h,0c0h,06fh,036h,001h,0e1h	; 420c  ..........&.o6..
	defb 0c9h,021h,000h,0c0h,006h,010h,036h,000h,023h,010h,0fbh,0c9h	; 421c  .!....6.#...

; ======================================================================
; CODIGO 0x4228..0x429a  (114 bytes)
; ======================================================================


L_4228:
	ld l,a			;4228
	ld h,0c0h		;4229
	ld (hl),001h		;422b
	ld d,a			;422d
	ld e,000h		;422e
	ld hl,0c12eh		;4230
	add hl,de			;4233
	ex de,hl			;4234
	ld a,h			;4235
	add a,a			;4236
	ld c,a			;4237
	add a,010h		;4238
	ld l,a			;423a
	ld h,0c0h		;423b
	ld (hl),e			;423d
	inc hl			;423e
	ld (hl),d			;423f
	ld hl,0429ah		;4240
	ld b,000h		;4243
	add hl,bc			;4245
	ld c,(hl)			;4246
	inc hl			;4247
	ld b,(hl)			;4248
	ex de,hl			;4249
	ld (hl),c			;424a
	inc hl			;424b
	ld (hl),b			;424c
	ret			;424d
L_424E:
	push hl			;424e
	ld h,0c0h		;424f
	ld l,a			;4251
	ld (hl),000h		;4252
	pop hl			;4254
L_4255:
	ld a,001h		;4255
L_4257:
	ld hl,(0d030h)		;4257
	ld (hl),a			;425a
	ld a,l			;425b
	add a,a			;425c
	add a,010h		;425d
	ld l,a			;425f
	ld (0d063h),sp		;4260
	ld de,(0d063h)		;4264
	ld (hl),e			;4268
	inc hl			;4269
	ld (hl),d			;426a
	jp L_428B		;426b
L_426E:
	ld hl,0c000h		;426e
	ld (0d065h),sp		;4271
L_4275:
	ld a,(hl)			;4275
	or a			;4276
	jp z,L_428E		;4277
	dec (hl)			;427a
	jr nz,L_428E		;427b
	ld (0d030h),hl		;427d
	ld a,l			;4280
	add a,a			;4281
	add a,010h		;4282
	ld l,a			;4284
	ld e,(hl)			;4285
	inc hl			;4286
	ld d,(hl)			;4287
	ex de,hl			;4288
	ld sp,hl			;4289
	ret			;428a
L_428B:
	ld hl,(0d030h)		;428b
L_428E:
	inc l			;428e
	ld a,l			;428f
	cp 010h		;4290
	jp nz,L_4275		;4292
	ld sp,(0d065h)		;4295
	ret			;4299

; ----------------------------------------------------------------------
; DATOS sin identificar  0x429a..0x42ba  (32 bytes)
DATA_429A:
	defb 014h,04eh,04fh,052h,0f2h,056h,060h,057h,099h,057h,000h,000h,000h,000h,000h,000h	; 429a  .NOR.V`W.W......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 42aa  ................

; ======================================================================
; CODIGO 0x42ba..0x4313  (89 bytes)
; ======================================================================


L_42BA:
	call L_4301		;42ba
	ld b,a			;42bd
	push bc			;42be
	ld a,008h		;42bf
	call 00141h		;42c1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	pop bc			;42c4
	bit 0,a		;42c5
	jr nz,L_42CB		;42c7
	set 4,b		;42c9
L_42CB:
	bit 7,a		;42cb
	jr nz,L_42D1		;42cd
	set 3,b		;42cf
L_42D1:
	bit 4,a		;42d1
	jr nz,L_42D7		;42d3
	set 2,b		;42d5
L_42D7:
	bit 6,a		;42d7
	jr nz,L_42DD		;42d9
	set 1,b		;42db
L_42DD:
	bit 5,a		;42dd
	jr nz,L_42E3		;42df
	set 0,b		;42e1
L_42E3:
	bit 0,a		;42e3
	jr nz,L_42E9		;42e5
	set 4,b		;42e7
L_42E9:
	push bc			;42e9
	ld a,006h		;42ea
	call 00141h		;42ec   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	pop bc			;42ef
	bit 3,a		;42f0
	jr nz,L_42F6		;42f2
	set 4,b		;42f4
L_42F6:
	bit 2,a		;42f6
	jr nz,L_42FC		;42f8
	set 5,b		;42fa
L_42FC:
	ld a,b			;42fc
	ld (0d573h),a		;42fd
	ret			;4300
L_4301:
	di			;4301
	ld e,08fh		;4302
	ld a,00fh		;4304
	call 00093h		;4306   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4309
	call 00096h		;430b   ; BIOS RDPSG - Reads value from PSG-register
	cpl			;430e
	and 03fh		;430f
	ei			;4311
	ret			;4312

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4313..0x431f  (12 bytes)
DATA_4313:
	defb 02eh,000h,055h,006h,008h,029h,030h,001h,019h,010h,0fah,0c9h	; 4313  ..U..)0.....

; ======================================================================
; CODIGO 0x431f..0x4332  (19 bytes)
; ======================================================================


L_431F:
	call 00041h		;431f   ; BIOS DISSCR - Inhibits the screen display
	di			;4322
	ld hl,00000h		;4323
	ld bc,07fffh		;4326
	xor a			;4329
	call 0016bh		;432a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ei			;432d
	call 00044h		;432e   ; BIOS ENASCR - Displays the screen
	ret			;4331

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4332..0x43af  (125 bytes)
DATA_4332:
	defb 0f3h,0cdh,05dh,044h,03ah,007h,000h,04fh,00ch,03eh,024h,0edh,079h,03eh,091h,0edh	; 4332  ..]D:..O.>$.y>..
	defb 079h,00ch,00ch,0afh,0edh,069h,0edh,079h,0edh,061h,008h,0edh,079h,008h,07ch,092h	; 4342  y....i.y.a..y.|.
	defb 016h,008h,0d2h,05bh,043h,016h,000h,0edh,044h,067h,07dh,093h,01eh,004h,0d2h,067h	; 4352  ...[C...Dg}....g
	defb 043h,01eh,000h,0edh,044h,06fh,024h,02ch,0afh,0edh,069h,0edh,079h,0edh,061h,0edh	; 4362  C...Do$,..i.y.a.
	defb 079h,0ddh,066h,000h,0edh,061h,07ah,0b3h,0edh,079h,03eh,0f0h,0edh,079h,03ah,007h	; 4372  y.f..az..y>..y:.
	defb 000h,04fh,00ch,03eh,0ach,0edh,079h,03eh,091h,0edh,079h,00ch,00ch,03eh,002h,0cdh	; 4382  .O.>..y>..y..>..
	defb 045h,044h,0cbh,047h,0cah,0a8h,043h,0cbh,07fh,0cah,08fh,043h,0ddh,023h,0ddh,07eh	; 4392  ED.G..C....C.#.~
	defb 000h,0edh,079h,0c3h,08fh,043h,03eh,000h,0cdh,045h,044h,0fbh,0c9h	; 43a2  ..y..C>..ED..

; ======================================================================
; CODIGO 0x43af..0x449b  (236 bytes)
; ======================================================================


L_43AF:
	di			;43af
	push bc			;43b0
	push af			;43b1
	call L_445D		;43b2
	ld bc,(00007h)		;43b5
	inc c			;43b9
	pop af			;43ba
	ld b,a			;43bb
	ld a,020h		;43bc
	out (c),a		;43be
	ld a,091h		;43c0
	out (c),a		;43c2
	inc c			;43c4
	inc c			;43c5
	out (c),l		;43c6
	xor a			;43c8
	out (c),a		;43c9
	out (c),h		;43cb
	out (c),b		;43cd
	ld a,h			;43cf
	sub d			;43d0
	ld d,008h		;43d1
	jp nc,L_43DA		;43d3
	ld d,000h		;43d6
	neg		;43d8
L_43DA:
	ld h,a			;43da
	ld a,l			;43db
	sub e			;43dc
	ld e,004h		;43dd
	jp nc,L_43E6		;43df
	ld e,000h		;43e2
	neg		;43e4
L_43E6:
	ld l,a			;43e6
	ld a,d			;43e7
	or e			;43e8
	pop de			;43e9
	push af			;43ea
	xor a			;43eb
	out (c),e		;43ec
	out (c),a		;43ee
	out (c),d		;43f0
	ex af,af'			;43f2
	out (c),a		;43f3
	ex af,af'			;43f5
	push hl			;43f6
	ld h,000h		;43f7
	inc hl			;43f9
	out (c),l		;43fa
	out (c),h		;43fc
	pop hl			;43fe
	out (c),h		;43ff
	out (c),a		;4401
	out (c),a		;4403
	pop af			;4405
	out (c),a		;4406
	ld a,0d0h		;4408
	out (c),a		;440a
	ei			;440c
	ret			;440d
L_440E:
	di			;440e
	ex de,hl			;440f
	push af			;4410
	call L_445D		;4411
	ld bc,(00007h)		;4414
	inc c			;4418
	pop af			;4419
	ld b,a			;441a
	ld a,024h		;441b
	out (c),a		;441d
	ld a,091h		;441f
	out (c),a		;4421
	inc c			;4423
	inc c			;4424
	or a			;4425
	sbc hl,de		;4426
	inc h			;4428
	inc l			;4429
	xor a			;442a
	out (c),d		;442b
	out (c),a		;442d
	out (c),e		;442f
	out (c),a		;4431
	out (c),h		;4433
	out (c),a		;4435
	out (c),l		;4437
	out (c),a		;4439
	out (c),b		;443b
	out (c),a		;443d
	ld a,0c0h		;443f
	out (c),a		;4441
	ei			;4443
	ret			;4444
L_4445:
	push bc			;4445
	ld bc,(00006h)		;4446
	inc c			;444a
	out (c),a		;444b
	ld a,08fh		;444d
	out (c),a		;444f
	in b,(c)		;4451
	xor a			;4453
	out (c),a		;4454
	ld a,08fh		;4456
	out (c),a		;4458
	ld a,b			;445a
	pop bc			;445b
	ret			;445c
L_445D:
	ld a,002h		;445d
	call L_4445		;445f
	and 001h		;4462
	jp nz,L_445D		;4464
	xor a			;4467
	call L_4445		;4468
	ret			;446b
L_446C:
	ld de,0d5b4h		;446c
	ld bc,00020h		;446f
	ldir		;4472
	ld hl,0d5b4h		;4474
	di			;4477
	call L_445D		;4478
	ld b,000h		;447b
	ld a,(00007h)		;447d
	inc a			;4480
	ld c,a			;4481
	ld a,b			;4482
	out (c),a		;4483
	ld a,090h		;4485
	out (c),a		;4487
	inc c			;4489
L_448A:
	ld a,(hl)			;448a
	out (c),a		;448b
	inc hl			;448d
	ld a,(hl)			;448e
	out (c),a		;448f
	inc hl			;4491
	inc b			;4492
	ld a,b			;4493
	cp 010h		;4494
	jp nz,L_448A		;4496
	ei			;4499
	ret			;449a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x449b..0x44de  (67 bytes)
DATA_449B:
	defb 006h,030h,021h,074h,0d5h,01ah,0beh,028h,001h,034h,023h,013h,010h,0f7h,018h,000h	; 449b  .0!t...(.4#.....
	defb 021h,074h,0d5h,011h,0a4h,0d5h,006h,010h,01ah,0a7h,0cah,0d7h,044h,013h,0d5h,07eh	; 44ab  !t..........D..~
	defb 023h,0cbh,027h,0cbh,027h,0cbh,027h,0cbh,027h,04fh,07eh,023h,0b1h,057h,07eh,023h	; 44bb  #.'.'.'.'O~#.W~#
	defb 05fh,0c5h,078h,03dh,0cdh,045h,044h,0c1h,0d1h,010h,0ddh,0c9h,023h,023h,023h,013h	; 44cb  _.x=.ED.....###.
	defb 0c3h,0d4h,044h	; 44db

; ======================================================================
; CODIGO 0x44de..0x45ec  (270 bytes)
; ======================================================================


L_44DE:
	push de			;44de
	ld hl,(0d5d4h)		;44df
	ex de,hl			;44e2
	add hl,hl			;44e3
	add hl,hl			;44e4
	add hl,hl			;44e5
	add hl,de			;44e6
	inc hl			;44e7
	ld a,r		;44e8
	xor l			;44ea
	ld (0d5d4h),hl		;44eb
	ld a,h			;44ee
	pop de			;44ef
	ret			;44f0
L_44F1:
	di			;44f1
	push bc			;44f2
	push af			;44f3
	call L_445D		;44f4
	ld bc,(00007h)		;44f7
	inc c			;44fb
	pop af			;44fc
	ld b,a			;44fd
	ld a,020h		;44fe
	out (c),a		;4500
	ld a,091h		;4502
	out (c),a		;4504
	inc c			;4506
	inc c			;4507
	out (c),l		;4508
	xor a			;450a
	out (c),a		;450b
	out (c),h		;450d
	out (c),b		;450f
	pop hl			;4511
	out (c),l		;4512
	out (c),a		;4514
	out (c),h		;4516
	ex af,af'			;4518
	out (c),a		;4519
	ex af,af'			;451b
	push de			;451c
	ld d,000h		;451d
	inc de			;451f
	out (c),e		;4520
	out (c),d		;4522
	pop de			;4524
	xor a			;4525
	out (c),d		;4526
	out (c),a		;4528
	out (c),a		;452a
	out (c),a		;452c
	ld a,0d0h		;452e
	out (c),a		;4530
	ei			;4532
	ret			;4533
L_4534:
	ld h,(ix+001h)		;4534
	ld l,(ix+000h)		;4537
	push hl			;453a
	ld d,(ix+005h)		;453b
	ld e,(ix+004h)		;453e
	xor a			;4541
	sbc hl,de		;4542
	ld a,h			;4544
	or l			;4545
	pop hl			;4546
	jp z,L_45EB		;4547
	ld (ix+005h),h		;454a
	ld (ix+004h),l		;454d
	ld a,h			;4550
	and l			;4551
	inc a			;4552
	jp z,L_45EB		;4553
	push hl			;4556
	ld a,(ix+00ah)		;4557
	ld l,a			;455a
	ld h,000h		;455b
	add hl,hl			;455d
	add hl,hl			;455e
	add hl,hl			;455f
	add hl,hl			;4560
	add hl,hl			;4561
	ld de,0a000h		;4562
	add hl,de			;4565
	push hl			;4566
	ld bc,00020h		;4567
	pop de			;456a
	pop hl			;456b
	di			;456c
	ld a,(ix+008h)		;456d
	bit 7,a		;4570
	jr nz,L_4586		;4572
	ld a,00eh		;4574
	ld (0d190h),a		;4576
	ld (06ff8h),a		;4579
	ld a,00fh		;457c
	ld (0d191h),a		;457e
	ld (077f8h),a		;4581
	jr L_45BC		;4584
L_4586:
	bit 6,a		;4586
	jr nz,L_45A4		;4588
	ld a,00bh		;458a
	ld (0d190h),a		;458c
	ld (06ff8h),a		;458f
	ld a,00ch		;4592
	ld (0d191h),a		;4594
	ld (077f8h),a		;4597
	ld a,00dh		;459a
	ld (0d192h),a		;459c
	ld (07ff8h),a		;459f
	jr L_45BC		;45a2
L_45A4:
	ld a,008h		;45a4
	ld (0d190h),a		;45a6
	ld (06ff8h),a		;45a9
	ld a,009h		;45ac
	ld (0d191h),a		;45ae
	ld (077f8h),a		;45b1
	ld a,00ah		;45b4
	ld (0d192h),a		;45b6
	ld (07ff8h),a		;45b9
L_45BC:
	call 0005ch		;45bc   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ei			;45bf
	ld a,(ix+008h)		;45c0
	res 7,a		;45c3
	res 6,a		;45c5
	ld h,000h		;45c7
	ld l,a			;45c9
	ld de,04df4h		;45ca
	add hl,de			;45cd
	push hl			;45ce
	ld a,(ix+009h)		;45cf
	ld h,000h		;45d2
	ld l,a			;45d4
	add hl,hl			;45d5
	add hl,hl			;45d6
	add hl,hl			;45d7
	add hl,hl			;45d8
	ld de,0d213h		;45d9
	add hl,de			;45dc
	push hl			;45dd
	pop de			;45de
	pop hl			;45df
	ld bc,0000fh		;45e0
	ld a,(hl)			;45e3
	ex de,hl			;45e4
	ld (hl),a			;45e5
	ld d,h			;45e6
	ld e,l			;45e7
	inc de			;45e8
	ldir		;45e9
L_45EB:
	ret			;45eb

; ----------------------------------------------------------------------
; DATOS sin identificar  0x45ec..0x45ee  (2 bytes)
DATA_45EC:
	defb 0e1h,0c9h	; 45ec

; ======================================================================
; CODIGO 0x45ee..0x48e7  (761 bytes)
; ======================================================================


L_45EE:
	push de			;45ee
	ld de,00200h		;45ef
	add hl,de			;45f2
	add hl,hl			;45f3
	add hl,hl			;45f4
	add hl,hl			;45f5
	ld b,l			;45f6
	ld l,h			;45f7
	ld h,000h		;45f8
	add hl,hl			;45fa
	add hl,hl			;45fb
	add hl,hl			;45fc
	ld a,h			;45fd
	inc a			;45fe
	ld h,l			;45ff
	ld l,b			;4600
	pop bc			;4601
	ld de,00808h		;4602
	ex af,af'			;4605
	xor a			;4606
	ex af,af'			;4607
	exx			;4608
	bit 0,b		;4609
	exx			;460b
	jp z,L_44F1		;460c
	jp L_468B		;460f
L_4612:
	ex (sp),hl			;4612
	ld (0d5dbh),hl		;4613
L_4616:
	ld hl,(0d5dbh)		;4616
	ld a,(hl)			;4619
	push de			;461a
	call L_4649		;461b
	pop de			;461e
	ld hl,00008h		;461f
	add hl,de			;4622
	ex de,hl			;4623
	ld hl,(0d5dbh)		;4624
	inc hl			;4627
	ld (0d5dbh),hl		;4628
	ld a,(hl)			;462b
	and a			;462c
	jp nz,L_4616		;462d
	inc hl			;4630
	ex (sp),hl			;4631
	ret			;4632
L_4633:
	ld de,(0d5dbh)		;4633
	push de			;4637
	exx			;4638
	ld b,000h		;4639
	exx			;463b
	call L_4649		;463c
	pop de			;463f
	ex de,hl			;4640
	ld hl,00008h		;4641
	add hl,de			;4644
	ld (0d5dbh),hl		;4645
	ret			;4648
L_4649:
	ld b,000h		;4649
	cp 020h		;464b
	ld hl,00000h		;464d
	jr z,L_465F		;4650
	sub 030h		;4652
	cp 00ah		;4654
	jr c,L_465A		;4656
	sub 006h		;4658
L_465A:
	ld l,a			;465a
	ld h,000h		;465b
	inc hl			;465d
	inc hl			;465e
L_465F:
	call L_45EE		;465f
	ret			;4662
L_4663:
	push af			;4663
	push de			;4664
	srl a		;4665
	srl a		;4667
	srl a		;4669
	srl a		;466b
	jr nz,L_4674		;466d
	ld a,020h		;466f
	jp L_4676		;4671
L_4674:
	add a,030h		;4674
L_4676:
	call L_4649		;4676
	pop de			;4679
	pop af			;467a
	inc de			;467b
	inc de			;467c
	inc de			;467d
	inc de			;467e
	inc de			;467f
	inc de			;4680
	inc de			;4681
	inc de			;4682
	and 00fh		;4683
	add a,030h		;4685
	call L_4649		;4687
	ret			;468a
L_468B:
	di			;468b
	push bc			;468c
	push af			;468d
	call L_445D		;468e
	ld bc,(00007h)		;4691
	inc c			;4695
	pop af			;4696
	ld b,a			;4697
	ld a,020h		;4698
	out (c),a		;469a
	ld a,091h		;469c
	out (c),a		;469e
	inc c			;46a0
	inc c			;46a1
	out (c),l		;46a2
	xor a			;46a4
	out (c),a		;46a5
	out (c),h		;46a7
	out (c),b		;46a9
	pop hl			;46ab
	out (c),l		;46ac
	out (c),a		;46ae
	out (c),h		;46b0
	ex af,af'			;46b2
	out (c),a		;46b3
	ex af,af'			;46b5
	xor a			;46b6
	out (c),e		;46b7
	out (c),a		;46b9
	out (c),d		;46bb
	out (c),a		;46bd
	out (c),a		;46bf
	out (c),a		;46c1
	ld a,098h		;46c3
	out (c),a		;46c5
	ei			;46c7
	ret			;46c8
L_46C9:
	ld a,(0d5d6h)		;46c9
	ld (0d5dah),a		;46cc
	add a,c			;46cf
	ld c,a			;46d0
	ld a,(0d5d7h)		;46d1
	add a,b			;46d4
	ld b,a			;46d5
	ld (0d5dbh),hl		;46d6
L_46D9:
	push bc			;46d9
	push de			;46da
	push de			;46db
	ld hl,(0d5dbh)		;46dc
	ld e,(hl)			;46df
	inc hl			;46e0
	ld d,(hl)			;46e1
	inc hl			;46e2
	ld (0d5dbh),hl		;46e3
	ex de,hl			;46e6
	pop de			;46e7
	add hl,de			;46e8
	ld de,(0d5d6h)		;46e9
	call L_45EE		;46ed
	pop de			;46f0
	pop bc			;46f1
	ld a,(0d5d6h)		;46f2
	add a,008h		;46f5
	ld (0d5d6h),a		;46f7
	cp c			;46fa
	jp nz,L_46D9		;46fb
	ld a,(0d5dah)		;46fe
	ld (0d5d6h),a		;4701
	ld a,(0d5d7h)		;4704
	add a,008h		;4707
	ld (0d5d7h),a		;4709
	cp b			;470c
	jp nz,L_46D9		;470d
	ret			;4710
L_4711:
	ld a,(0d5d6h)		;4711
	ld (0d5dah),a		;4714
	ld (0d5dbh),hl		;4717
	xor a			;471a
	ld (0d5d8h),a		;471b
	ld (0d5d9h),a		;471e
L_4721:
	push bc			;4721
	push de			;4722
	push de			;4723
	ld hl,(0d5dbh)		;4724
	ld e,(hl)			;4727
	inc hl			;4728
	ld d,(hl)			;4729
	inc hl			;472a
	ld (0d5dbh),hl		;472b
	ld a,e			;472e
	cp 0ffh		;472f
	jr nz,L_4736		;4731
	pop de			;4733
	jr L_4744		;4734
L_4736:
	dec de			;4736
	ex de,hl			;4737
	pop de			;4738
	add hl,de			;4739
	ld de,(0d5d6h)		;473a
	ld h,000h		;473e
	inc hl			;4740
	call L_4777		;4741
L_4744:
	pop de			;4744
	pop bc			;4745
	ld a,(0d5d6h)		;4746
	add a,010h		;4749
	ld (0d5d6h),a		;474b
	ld a,(0d5d8h)		;474e
	inc a			;4751
	ld (0d5d8h),a		;4752
	cp c			;4755
	jp nz,L_4721		;4756
	ld a,(0d5dah)		;4759
	ld (0d5d6h),a		;475c
	xor a			;475f
	ld (0d5d8h),a		;4760
	ld a,(0d5d7h)		;4763
	add a,010h		;4766
	ld (0d5d7h),a		;4768
	ld a,(0d5d9h)		;476b
	inc a			;476e
	ld (0d5d9h),a		;476f
	cp b			;4772
	jp nz,L_4721		;4773
	ret			;4776
L_4777:
	ld a,01bh		;4777
	ld (0d192h),a		;4779
	ld (07ff8h),a		;477c
	push hl			;477f
	push hl			;4780
	exx			;4781
	pop hl			;4782
	ld a,l			;4783
	and 007h		;4784
	ld l,a			;4786
	ld h,000h		;4787
	add hl,hl			;4789
	add hl,hl			;478a
	pop de			;478b
	push hl			;478c
	ex de,hl			;478d
	ld a,l			;478e
	and 0f8h		;478f
	ld l,a			;4791
	ld h,000h		;4792
	add hl,hl			;4794
	add hl,hl			;4795
	add hl,hl			;4796
	pop de			;4797
	add hl,de			;4798
	ld de,(0d5eah)		;4799
	add hl,de			;479d
	push hl			;479e
	pop ix		;479f
	exx			;47a1
	ld l,(ix+000h)		;47a2
	ld h,(ix+001h)		;47a5
	push de			;47a8
	call L_45EE		;47a9
	pop de			;47ac
	ld hl,00008h		;47ad
	add hl,de			;47b0
	ex de,hl			;47b1
	push de			;47b2
	ld l,(ix+002h)		;47b3
	ld h,(ix+003h)		;47b6
	call L_45EE		;47b9
	pop de			;47bc
	ld hl,007f8h		;47bd
	add hl,de			;47c0
	ex de,hl			;47c1
	push de			;47c2
	ld bc,00020h		;47c3
	add ix,bc		;47c6
	ld l,(ix+000h)		;47c8
	ld h,(ix+001h)		;47cb
	call L_45EE		;47ce
	pop de			;47d1
	ld hl,00008h		;47d2
	add hl,de			;47d5
	ex de,hl			;47d6
	ld l,(ix+002h)		;47d7
	ld h,(ix+003h)		;47da
	call L_45EE		;47dd
	ld a,000h		;47e0
	ld (0d192h),a		;47e2
	ld (07ff8h),a		;47e5
	ret			;47e8
L_47E9:
	ld ix,0d413h		;47e9
	ld b,020h		;47ed
L_47EF:
	push bc			;47ef
	ld a,020h		;47f0
	sub b			;47f2
	ld (ix+000h),000h		;47f3
	ld (ix+001h),000h		;47f7
	ld (ix+009h),a		;47fb
	ld (ix+00ah),a		;47fe
	ld (ix+007h),000h		;4801
	ld (ix+003h),0ffh		;4805
	inc ix		;4809
	inc ix		;480b
	inc ix		;480d
	inc ix		;480f
	inc ix		;4811
	inc ix		;4813
	inc ix		;4815
	inc ix		;4817
	inc ix		;4819
	inc ix		;481b
	inc ix		;481d
	pop bc			;481f
	djnz L_47EF		;4820
	ret			;4822
L_4823:
	push bc			;4823
	ld (ix+000h),000h		;4824
	ld (ix+001h),000h		;4828
	ld (ix+007h),000h		;482c
	ld (ix+003h),0ffh		;4830
	inc ix		;4834
	inc ix		;4836
	inc ix		;4838
	inc ix		;483a
	inc ix		;483c
	inc ix		;483e
	inc ix		;4840
	inc ix		;4842
	inc ix		;4844
	inc ix		;4846
	inc ix		;4848
	pop bc			;484a
	djnz L_4823		;484b
	ret			;484d
L_484E:
	push bc			;484e
	call L_4534		;484f
	ld a,(ix+009h)		;4852
	ld l,a			;4855
	ld h,000h		;4856
	add hl,hl			;4858
	add hl,hl			;4859
	ld de,0d193h		;485a
	add hl,de			;485d
	ld a,(ix+003h)		;485e
	cp 0ffh		;4861
	jr z,L_4899		;4863
	ld b,a			;4865
	ld a,(0d5deh)		;4866
	add a,b			;4869
L_486A:
	ld (hl),a			;486a
	inc hl			;486b
	ld a,(0d5ddh)		;486c
	add a,(ix+002h)		;486f
	ld (hl),a			;4872
	inc hl			;4873
	ld a,(ix+00ah)		;4874
	add a,a			;4877
	add a,a			;4878
	ld (hl),a			;4879
	inc hl			;487a
	ld a,(ix+008h)		;487b
	ld (hl),a			;487e
	inc ix		;487f
	inc ix		;4881
	inc ix		;4883
	inc ix		;4885
	inc ix		;4887
	inc ix		;4889
	inc ix		;488b
	inc ix		;488d
	inc ix		;488f
	inc ix		;4891
	inc ix		;4893
	pop bc			;4895
	djnz L_484E		;4896
	ret			;4898
L_4899:
	ld a,0e0h		;4899
	jp L_486A		;489b
L_489E:
	push bc			;489e
	di			;489f
	call L_445D		;48a0
	ld a,(0d5e0h)		;48a3
	ld b,a			;48a6
	ld a,(00007h)		;48a7
	inc a			;48aa
	ld c,a			;48ab
	ld a,b			;48ac
	out (c),a		;48ad
	ld a,097h		;48af
	out (c),a		;48b1
	ei			;48b3
	pop bc			;48b4
	ret			;48b5
L_48B6:
	ld hl,(0d5eah)		;48b6
	ld (0d5ech),hl		;48b9
	ld hl,05bc3h		;48bc
	ld (0d5eah),hl		;48bf
	ld a,(0d92dh)		;48c2
	dec a			;48c5
	ld l,a			;48c6
	ld h,000h		;48c7
	ld de,048e7h		;48c9
	add hl,de			;48cc
	ld a,(hl)			;48cd
	ld l,a			;48ce
	ld h,000h		;48cf
	ld a,(0d92bh)		;48d1
	ld e,a			;48d4
	ld a,(0d92ch)		;48d5
	ld d,a			;48d8
	exx			;48d9
	ld b,001h		;48da
	exx			;48dc
	call L_4777		;48dd
	ld hl,(0d5ech)		;48e0
	ld (0d5eah),hl		;48e3
	ret			;48e6

; ----------------------------------------------------------------------
; DATOS sin identificar  0x48e7..0x48f9  (18 bytes)
DATA_48E7:
	defb 00fh,010h,011h,000h,001h,002h,005h,006h,003h,004h,007h,008h,009h,00ah,00bh,00ch	; 48e7  ................
	defb 00dh,00eh	; 48f7

; ======================================================================
; CODIGO 0x48f9..0x4a19  (288 bytes)
; ======================================================================


L_48F9:
	ld a,(ix+000h)		;48f9
	and a			;48fc
	ret z			;48fd
	ld a,(ix+000h)		;48fe
	cp 00ah		;4901
	jp z,L_4967		;4903
	cp 01ah		;4906
	jp z,L_4967		;4908
	cp 01bh		;490b
	jp z,L_4967		;490d
	cp 016h		;4910
	jp z,L_49EB		;4912
	cp 01fh		;4915
	jp z,L_49EB		;4917
	cp 00bh		;491a
	jp z,L_49EB		;491c
	cp 00ch		;491f
	jp z,L_49EB		;4921
	cp 017h		;4924
	jp z,L_49EB		;4926
	cp 01eh		;4929
	jp z,L_49EB		;492b
	cp 025h		;492e
	jp z,L_49EB		;4930
	ld d,000h		;4933
	call L_4C25		;4935
	ld a,b			;4938
	and a			;4939
	ret z			;493a
	ld a,003h		;493b
	call L_4C3A		;493d
	ld a,b			;4940
	and 007h		;4941
	set 4,a		;4943
	ld (ix+00eh),a		;4945
	ld a,b			;4948
	dec a			;4949
	add a,a			;494a
	add a,a			;494b
	add a,b			;494c
	add a,010h		;494d
	ld de,0000bh		;494f
	ld hl,0d413h		;4952
	ld b,a			;4955
L_4956:
	add hl,de			;4956
	djnz L_4956		;4957
	ld (ix+003h),l		;4959
	ld (ix+004h),h		;495c
	ld a,005h		;495f
	ld (ix+005h),a		;4961
	jp L_4A1B		;4964
L_4967:
	ld d,040h		;4967
	call L_4C25		;4969
	ld a,b			;496c
	and a			;496d
	jp nz,L_49AF		;496e
	ld d,080h		;4971
	call L_4C25		;4973
	ld a,b			;4976
	and a			;4977
	jp nz,L_49B7		;4978
	ld d,000h		;497b
	call L_4C25		;497d
	ld a,b			;4980
	and a			;4981
	ret z			;4982
	ld a,002h		;4983
	call L_4C3A		;4985
L_4988:
	ld a,b			;4988
	and 007h		;4989
	set 7,a		;498b
	ld (ix+00eh),a		;498d
	ld a,b			;4990
	dec a			;4991
	add a,a			;4992
	add a,a			;4993
	add a,b			;4994
	add a,010h		;4995
	ld de,0000bh		;4997
	ld hl,0d413h		;499a
	ld b,a			;499d
L_499E:
	add hl,de			;499e
	djnz L_499E		;499f
	ld (ix+003h),l		;49a1
	ld (ix+004h),h		;49a4
	ld a,002h		;49a7
	ld (ix+005h),a		;49a9
	jp L_4A1B		;49ac
L_49AF:
	ld a,003h		;49af
	call L_4C3A		;49b1
	jp L_4988		;49b4
L_49B7:
	ld a,b			;49b7
	and 007h		;49b8
	set 6,a		;49ba
	ld (ix+00eh),a		;49bc
	ld a,003h		;49bf
	call L_4C3A		;49c1
	ld a,b			;49c4
	and 007h		;49c5
	set 6,a		;49c7
	ld (ix+00eh),a		;49c9
	ld a,b			;49cc
	dec a			;49cd
	add a,a			;49ce
	add a,a			;49cf
	add a,b			;49d0
	add a,012h		;49d1
	ld de,0000bh		;49d3
	ld hl,0d413h		;49d6
	ld b,a			;49d9
L_49DA:
	add hl,de			;49da
	djnz L_49DA		;49db
	ld (ix+003h),l		;49dd
	ld (ix+004h),h		;49e0
	ld a,002h		;49e3
	ld (ix+005h),a		;49e5
	jp L_4A1B		;49e8
L_49EB:
	call L_4C12		;49eb
	ld a,b			;49ee
	and a			;49ef
	ret z			;49f0
	ld a,001h		;49f1
	call L_4BBA		;49f3
	ld a,b			;49f6
	and 007h		;49f7
	set 5,a		;49f9
	ld (ix+00eh),a		;49fb
	ld a,b			;49fe
	add a,00ah		;49ff
	ld de,0000bh		;4a01
	ld hl,0d413h		;4a04
	ld b,a			;4a07
L_4A08:
	add hl,de			;4a08
	djnz L_4A08		;4a09
	ld (ix+003h),l		;4a0b
	ld (ix+004h),h		;4a0e
	ld a,001h		;4a11
	ld (ix+005h),a		;4a13
	jp L_4A1B		;4a16

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4a19..0x4a1b  (2 bytes)
DATA_4A19:
	defb 0c9h,0c9h	; 4a19

; ======================================================================
; CODIGO 0x4a1b..0x4c68  (589 bytes)
; ======================================================================


L_4A1B:
	push ix		;4a1b
	ld a,(ix+006h)		;4a1d
	ld (0d5ddh),a		;4a20
	ld a,(ix+007h)		;4a23
	ld (0d5deh),a		;4a26
	ld a,(ix+000h)		;4a29
	cp 018h		;4a2c
	jr nc,L_4A3A		;4a2e
	ld a,01eh		;4a30
	ld (0d191h),a		;4a32
	ld (077f8h),a		;4a35
	jr L_4A42		;4a38
L_4A3A:
	ld a,01ah		;4a3a
	ld (0d191h),a		;4a3c
	ld (077f8h),a		;4a3f
L_4A42:
	push ix		;4a42
	pop hl			;4a44
	ld de,0000ah		;4a45
	add hl,de			;4a48
	push hl			;4a49
	pop iy		;4a4a
	call L_4BF7		;4a4c
	ld (ix+00ch),e		;4a4f
	ld (ix+00dh),d		;4a52
	ld l,(ix+003h)		;4a55
	ld h,(ix+004h)		;4a58
	push de			;4a5b
	pop ix		;4a5c
	ex af,af'			;4a5e
	ld a,002h		;4a5f
	ex af,af'			;4a61
	call L_5AA5		;4a62
	pop ix		;4a65
	push ix		;4a67
	ld l,(ix+003h)		;4a69
	ld h,(ix+004h)		;4a6c
	ld b,(ix+005h)		;4a6f
	push hl			;4a72
	pop ix		;4a73
	call L_484E		;4a75
	pop ix		;4a78
	ld a,003h		;4a7a
	ld (0d190h),a		;4a7c
	ld (06ff8h),a		;4a7f
	ld a,004h		;4a82
	ld (0d191h),a		;4a84
	ld (077f8h),a		;4a87
	ret			;4a8a
L_4A8B:
	call L_4BF7		;4a8b
	ld (ix+00ch),e		;4a8e
	ld (ix+00dh),d		;4a91
	push ix		;4a94
	ld a,(ix+006h)		;4a96
	ld (0d5ddh),a		;4a99
	ld a,(ix+007h)		;4a9c
	ld (0d5deh),a		;4a9f
	ld a,(ix+000h)		;4aa2
	cp 018h		;4aa5
	jr nc,L_4AB3		;4aa7
	ld a,01eh		;4aa9
	ld (0d191h),a		;4aab
	ld (077f8h),a		;4aae
	jr L_4ABB		;4ab1
L_4AB3:
	ld a,01ah		;4ab3
	ld (0d191h),a		;4ab5
	ld (077f8h),a		;4ab8
L_4ABB:
	push ix		;4abb
	pop hl			;4abd
	ld de,0000ah		;4abe
	add hl,de			;4ac1
	push hl			;4ac2
	pop iy		;4ac3
	ld e,(ix+00ch)		;4ac5
	ld d,(ix+00dh)		;4ac8
	ld l,(ix+003h)		;4acb
	ld h,(ix+004h)		;4ace
	push de			;4ad1
	pop ix		;4ad2
	ex af,af'			;4ad4
	ld a,000h		;4ad5
	ex af,af'			;4ad7
	call L_5AA5		;4ad8
	pop ix		;4adb
	push ix		;4add
	ld a,(ix+00ah)		;4adf
	and 07fh		;4ae2
	ex af,af'			;4ae4
	rrca			;4ae5
	and 080h		;4ae6
	ld b,a			;4ae8
	ex af,af'			;4ae9
	or b			;4aea
	ld (ix+002h),a		;4aeb
	ld l,(ix+003h)		;4aee
	ld h,(ix+004h)		;4af1
	ld b,(ix+005h)		;4af4
	push hl			;4af7
	pop ix		;4af8
	call L_484E		;4afa
	pop ix		;4afd
	ld a,003h		;4aff
	ld (0d190h),a		;4b01
	ld (06ff8h),a		;4b04
	ld a,004h		;4b07
	ld (0d191h),a		;4b09
	ld (077f8h),a		;4b0c
	ret			;4b0f
L_4B10:
	ld a,(ix+003h)		;4b10
	and a			;4b13
	ret z			;4b14
	ld a,(ix+00eh)		;4b15
	bit 4,a		;4b18
	jp nz,L_4B2C		;4b1a
	bit 5,a		;4b1d
	jp nz,L_4B75		;4b1f
	bit 6,a		;4b22
	jp nz,L_4B86		;4b24
	bit 7,a		;4b27
	jp nz,L_4B7F		;4b29
L_4B2C:
	and 003h		;4b2c
	ld b,a			;4b2e
	xor a			;4b2f
	call L_4C3A		;4b30
L_4B33:
	push ix		;4b33
	ld l,(ix+003h)		;4b35
	ld h,(ix+004h)		;4b38
	ld b,(ix+005h)		;4b3b
	ld a,h			;4b3e
	or l			;4b3f
	jr z,L_4B62		;4b40
	push hl			;4b42
	pop ix		;4b43
	push ix		;4b45
	push bc			;4b47
	call L_4823		;4b48
	pop bc			;4b4b
	pop ix		;4b4c
	call L_484E		;4b4e
	pop hl			;4b51
	push hl			;4b52
	ld d,h			;4b53
	ld e,l			;4b54
	inc de			;4b55
	ld bc,00025h		;4b56
	xor a			;4b59
	ld (hl),a			;4b5a
	ldir		;4b5b
	ld hl,0da19h		;4b5d
	res 0,(hl)		;4b60
L_4B62:
	pop ix		;4b62
	ld a,003h		;4b64
	ld (0d190h),a		;4b66
	ld (06ff8h),a		;4b69
	ld a,004h		;4b6c
	ld (0d191h),a		;4b6e
	ld (077f8h),a		;4b71
	ret			;4b74
L_4B75:
	and 007h		;4b75
	ld b,a			;4b77
	xor a			;4b78
	call L_4BBA		;4b79
	jp L_4B33		;4b7c
L_4B7F:
	and 003h		;4b7f
	add a,a			;4b81
	ld b,a			;4b82
	jp L_4B8B		;4b83
L_4B86:
	and 003h		;4b86
	add a,a			;4b88
	dec a			;4b89
	ld b,a			;4b8a
L_4B8B:
	push bc			;4b8b
	ld a,(0da17h)		;4b8c
	djnz L_4B95		;4b8f
	res 2,a		;4b91
	jr L_4BB3		;4b93
L_4B95:
	djnz L_4B9B		;4b95
	res 3,a		;4b97
	jr L_4BB3		;4b99
L_4B9B:
	djnz L_4BA1		;4b9b
	res 4,a		;4b9d
	jr L_4BB3		;4b9f
L_4BA1:
	djnz L_4BA7		;4ba1
	res 5,a		;4ba3
	jr L_4BB3		;4ba5
L_4BA7:
	djnz L_4BAD		;4ba7
	res 6,a		;4ba9
	jr L_4BB3		;4bab
L_4BAD:
	djnz L_4BB3		;4bad
	res 7,a		;4baf
	jr L_4BB3		;4bb1
L_4BB3:
	ld (0da17h),a		;4bb3
	pop bc			;4bb6
	jp L_4B33		;4bb7
L_4BBA:
	push bc			;4bba
	push af			;4bbb
	ld a,(0da18h)		;4bbc
	ld c,a			;4bbf
	pop af			;4bc0
	add a,a			;4bc1
	add a,a			;4bc2
	djnz L_4BCA		;4bc3
	res 2,c		;4bc5
	or c			;4bc7
	jr L_4BF2		;4bc8
L_4BCA:
	add a,a			;4bca
	djnz L_4BD2		;4bcb
	res 3,c		;4bcd
	or c			;4bcf
	jr L_4BF2		;4bd0
L_4BD2:
	add a,a			;4bd2
	djnz L_4BDA		;4bd3
	res 4,c		;4bd5
	or c			;4bd7
	jr L_4BF2		;4bd8
L_4BDA:
	add a,a			;4bda
	djnz L_4BE2		;4bdb
	res 5,c		;4bdd
	or c			;4bdf
	jr L_4BF2		;4be0
L_4BE2:
	add a,a			;4be2
	djnz L_4BEA		;4be3
	res 6,c		;4be5
	or c			;4be7
	jr L_4BF2		;4be8
L_4BEA:
	add a,a			;4bea
	djnz L_4BF2		;4beb
	res 7,c		;4bed
	or c			;4bef
	jr L_4BF2		;4bf0
L_4BF2:
	ld (0da18h),a		;4bf2
	pop bc			;4bf5
	ret			;4bf6
L_4BF7:
	ld a,(ix+000h)		;4bf7
	ld de,04c68h		;4bfa
	dec a			;4bfd
	ld l,a			;4bfe
	ld h,000h		;4bff
	add hl,hl			;4c01
	add hl,de			;4c02
	ld e,(hl)			;4c03
	inc hl			;4c04
	ld d,(hl)			;4c05
	ld a,(ix+001h)		;4c06
	ld l,a			;4c09
	ld h,000h		;4c0a
	add hl,hl			;4c0c
	add hl,de			;4c0d
	ld e,(hl)			;4c0e
	inc hl			;4c0f
	ld d,(hl)			;4c10
	ret			;4c11
L_4C12:
	ld a,(0da18h)		;4c12
	ld b,006h		;4c15
L_4C17:
	ld c,a			;4c17
	bit 7,a		;4c18
	ret z			;4c1a
	ld a,c			;4c1b
	add a,a			;4c1c
	djnz L_4C17		;4c1d
	ld hl,0da19h		;4c1f
	set 1,(hl)		;4c22
	ret			;4c24
L_4C25:
	ld a,(0da17h)		;4c25
	ld b,003h		;4c28
L_4C2A:
	ld c,a			;4c2a
	and 0c0h		;4c2b
	cp d			;4c2d
	ret z			;4c2e
	ld a,c			;4c2f
	add a,a			;4c30
	add a,a			;4c31
	djnz L_4C2A		;4c32
	ld hl,0da19h		;4c34
	set 0,(hl)		;4c37
	ret			;4c39
L_4C3A:
	push bc			;4c3a
	push af			;4c3b
	ld a,(0da17h)		;4c3c
	ld c,a			;4c3f
	pop af			;4c40
	add a,a			;4c41
	add a,a			;4c42
	djnz L_4C4C		;4c43
	res 2,c		;4c45
	res 3,c		;4c47
	or c			;4c49
	jr L_4C63		;4c4a
L_4C4C:
	add a,a			;4c4c
	add a,a			;4c4d
	djnz L_4C57		;4c4e
	res 4,c		;4c50
	res 5,c		;4c52
	or c			;4c54
	jr L_4C63		;4c55
L_4C57:
	add a,a			;4c57
	add a,a			;4c58
	djnz L_4C62		;4c59
	res 6,c		;4c5b
	res 7,c		;4c5d
	or c			;4c5f
	jr L_4C63		;4c60
L_4C62:
	ld a,c			;4c62
L_4C63:
	ld (0da17h),a		;4c63
	pop bc			;4c66
	ret			;4c67

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4c68..0x4e14  (428 bytes)
DATA_4C68:
	defb 0b2h,04ch,0beh,04ch,0cah,04ch,0d6h,04ch,0deh,04ch,0e6h,04ch,0f2h,04ch,0f6h,04ch	; 4c68  .L.L.L.L.L.L.L.L
	defb 002h,04dh,00ah,04dh,012h,04dh,01ah,04dh,022h,04dh,026h,04dh,02ah,04dh,02eh,04dh	; 4c78  .M.M.M.M"M&M*M.M
	defb 036h,04dh,04ah,04dh,05eh,04dh,072h,04dh,07ah,04dh,082h,04dh,0aeh,04dh,0bah,04dh	; 4c88  6MJM^MrMzM.M.M.M
	defb 0c2h,04dh,0d0h,04dh,0d4h,04dh,0d8h,04dh,0cch,04dh,0b4h,04dh,0dch,04dh,0dah,04dh	; 4c98  .M.M.M.M.M.M.M.M
	defb 0e0h,04dh,0ceh,04dh,0e8h,04dh,0ech,04dh,0eah,04dh,000h,080h,00bh,080h,020h,080h	; 4ca8  .M.M.M.M.M.... .
	defb 02bh,080h,016h,080h,01bh,080h,097h,080h,09ch,080h,0a1h,080h,0a6h,080h,0abh,080h	; 4cb8  +...............
	defb 0b0h,080h,034h,081h,03fh,081h,05ch,081h,067h,081h,04ah,081h,053h,081h,08eh,082h	; 4cc8  ..4.?.\.g.J.S...
	defb 099h,082h,0a4h,082h,0b7h,082h,044h,084h,04dh,084h,056h,084h,05fh,084h,0d1h,084h	; 4cd8  ......D.M.V._...
	defb 0dah,084h,0edh,084h,0f8h,084h,003h,085h,010h,085h,0bfh,085h,0cah,085h,0f5h,085h	; 4ce8  ................
	defb 0f5h,085h,0d5h,085h,0deh,085h,0e7h,085h,0eeh,085h,0a8h,086h,0b1h,086h,0bah,086h	; 4cf8  ................
	defb 0c1h,086h,06eh,087h,077h,087h,080h,087h,087h,087h,0beh,087h,0c5h,087h,0cch,087h	; 4d08  ..n.w...........
	defb 0d3h,087h,0f2h,087h,0fbh,087h,004h,088h,00dh,088h,03ah,088h,043h,088h,0a0h,088h	; 4d18  ..........:.C...
	defb 0abh,088h,0d4h,088h,0ddh,088h,004h,089h,00dh,089h,016h,089h,01fh,089h,05bh,089h	; 4d28  ..............[.
	defb 064h,089h,06dh,089h,078h,089h,083h,089h,088h,089h,097h,089h,0a2h,089h,08dh,089h	; 4d38  d.m.x...........
	defb 092h,089h,067h,08ah,070h,08ah,079h,08ah,084h,08ah,08fh,08ah,094h,08ah,0a3h,08ah	; 4d48  ..g.p.y.........
	defb 0aeh,08ah,099h,08ah,09eh,08ah,061h,08bh,06ah,08bh,087h,08bh,0a2h,08bh,07dh,08bh	; 4d58  ......a.j.....}.
	defb 082h,08bh,0bdh,08bh,0d8h,08bh,073h,08bh,078h,08bh,054h,08eh,05dh,08eh,066h,08eh	; 4d68  ......s.x.T.].f.
	defb 06fh,08eh,017h,08fh,020h,08fh,029h,08fh,032h,08fh,078h,08eh,07fh,08eh,086h,08eh	; 4d78  o... .).2.x.....
	defb 08bh,08eh,03bh,08fh,042h,08fh,049h,08fh,04eh,08fh,072h,081h,072h,081h,07bh,081h	; 4d88  ..;.B.I.N.r.r.{.
	defb 07bh,081h,082h,081h,082h,081h,03eh,08bh,03eh,08bh,028h,089h,028h,089h,0c8h,086h	; 4d98  {.....>.>.(.(...
	defb 0cfh,086h,068h,084h,068h,084h,000h,000h,0dah,08fh,0e7h,08fh,0bdh,088h,0d0h,088h	; 4da8  ..h.h...........
	defb 01bh,089h,000h,080h,003h,081h,0deh,081h,091h,082h,007h,086h,0a2h,086h,030h,084h	; 4db8  ..............0.
	defb 030h,084h,0d1h,084h,06ch,085h,063h,087h,04fh,083h,069h,083h,054h,083h,06eh,083h	; 4dc8  0...l.c.O.i.T.n.
	defb 083h,083h,01ch,083h,044h,087h,03dh,087h,01ch,088h,08dh,088h,0a0h,088h,0b0h,088h	; 4dd8  ....D.=.........
	defb 01ch,088h,011h,08ah,066h,089h,04ch,08ah,0a3h,08ah,011h,08ah,000h,001h,002h,003h	; 4de8  ....f.L.........
	defb 004h,005h,006h,007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh,040h,041h,042h,043h	; 4df8  ............@ABC
	defb 044h,045h,046h,047h,048h,049h,04ah,04bh,04ch,04dh,04eh,04fh	; 4e08  DEFGHIJKLMNO

; ======================================================================
; CODIGO 0x4e14..0x4e99  (133 bytes)
; ======================================================================


L_4E14:
	xor a			;4e14
	ld (0d5e0h),a		;4e15
	call L_489E		;4e18
	ld a,0ffh		;4e1b
	ld (0d5dfh),a		;4e1d
	ld a,000h		;4e20
	ld (0d178h),a		;4e22
	ld a,000h		;4e25
	ld (0d17ah),a		;4e27
	ld a,003h		;4e2a
	ld (0d067h),a		;4e2c
	call L_4FE0		;4e2f
	xor a			;4e32
	ld (0d17dh),a		;4e33
L_4E36:
	call L_431F		;4e36
	ld a,001h		;4e39
	call L_4228		;4e3b
L_4E3E:
	call L_4255		;4e3e
	ld a,(04010h)		;4e41
	and a			;4e44
	jp z,L_4E61		;4e45
	ld a,000h		;4e48
	call 00141h		;4e4a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 030h		;4e4d
	add a,a			;4e4f
	cpl			;4e50
	ld b,a			;4e51
	ld a,(0f3e1h)		;4e52
	and 09fh		;4e55
	or b			;4e57
	ld (0f3e1h),a		;4e58
	ld c,002h		;4e5b
	ld b,a			;4e5d
	call 00047h		;4e5e   ; BIOS WRTVDP - Writes data in the VDP-register
L_4E61:
	ld a,(0d17dh)		;4e61
	bit 6,a		;4e64
	jr z,L_4E3E		;4e66
	call L_431F		;4e68
	ld a,004h		;4e6b
	call L_424E		;4e6d
	ld a,002h		;4e70
	call L_424E		;4e72
	ld a,003h		;4e75
	call L_424E		;4e77
	ld a,001h		;4e7a
	call L_424E		;4e7c
	call L_47E9		;4e7f
	ld ix,0d413h		;4e82
	ld b,020h		;4e86
	call L_484E		;4e88
	call L_431F		;4e8b
	exx			;4e8e
	ld b,000h		;4e8f
	exx			;4e91
	ld d,060h		;4e92
	ld e,060h		;4e94
	call L_4612		;4e96

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4e99..0x4ea3  (10 bytes)
DATA_4E99:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 4e99  GAME OVER.

; ======================================================================
; CODIGO 0x4ea3..0x4eec  (73 bytes)
; ======================================================================


	ld a,000h		;4ea3
	ld (0d17ah),a		;4ea5
	ld a,008h		;4ea8
	ld (0d17ah),a		;4eaa
	ld a,0c8h		;4ead
	call L_4257		;4eaf
	ld a,0c8h		;4eb2
	call L_4257		;4eb4
	ld a,006h		;4eb7
	ld (0d17ah),a		;4eb9
	xor a			;4ebc
	ld (0d17dh),a		;4ebd
	ld (0d905h),a		;4ec0
	ld (0d919h),a		;4ec3
	ld (0d926h),a		;4ec6
	ld (0d91eh),a		;4ec9
	ld (0d91fh),a		;4ecc
	ld (0d920h),a		;4ecf
	ld (0d921h),a		;4ed2
	ld (0d90dh),a		;4ed5
	ld (0d90eh),a		;4ed8
	ld (0d90fh),a		;4edb
	ld (0d910h),a		;4ede
	exx			;4ee1
	ld b,000h		;4ee2
	exx			;4ee4
	ld d,080h		;4ee5
	ld e,030h		;4ee7
	call L_4612		;4ee9

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4eec..0x4ef8  (12 bytes)
DATA_4EEC:
	defb 054h,04fh,020h,043h,04fh,04eh,054h,049h,04eh,055h,045h,000h	; 4eec  TO CONTINUE.

; ======================================================================
; CODIGO 0x4ef8..0x4f03  (11 bytes)
; ======================================================================


	exx			;4ef8
	ld b,000h		;4ef9
	exx			;4efb
	ld d,088h		;4efc
	ld e,030h		;4efe
	call L_4612		;4f00

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f03..0x4f17  (20 bytes)
DATA_4F03:
	defb 020h,020h,020h,020h,020h,050h,055h,053h,048h,020h,053h,050h,041h,043h,045h,020h	; 4f03       PUSH SPACE
	defb 04bh,045h,059h,000h	; 4f13

; ======================================================================
; CODIGO 0x4f17..0x4f22  (11 bytes)
; ======================================================================


	exx			;4f17
	ld b,000h		;4f18
	exx			;4f1a
	ld d,098h		;4f1b
	ld e,030h		;4f1d
	call L_4612		;4f1f

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f22..0x4f2c  (10 bytes)
DATA_4F22:
	defb 054h,04fh,020h,043h,041h,04eh,043h,045h,04ch,000h	; 4f22  TO CANCEL.

; ======================================================================
; CODIGO 0x4f2c..0x4f37  (11 bytes)
; ======================================================================


	exx			;4f2c
	ld b,000h		;4f2d
	exx			;4f2f
	ld d,0a0h		;4f30
	ld e,030h		;4f32
	call L_4612		;4f34

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f37..0x4f4b  (20 bytes)
DATA_4F37:
	defb 020h,020h,020h,020h,020h,050h,055h,053h,048h,020h,047h,052h,041h,050h,048h,020h	; 4f37       PUSH GRAPH
	defb 04bh,045h,059h,000h	; 4f47

; ======================================================================
; CODIGO 0x4f4b..0x4f68  (29 bytes)
; ======================================================================


	ld hl,01c20h		;4f4b
L_4F4E:
	push hl			;4f4e
	call L_4255		;4f4f
	pop hl			;4f52
	push hl			;4f53
	ld a,l			;4f54
	and 01fh		;4f55
	jr z,$+50		;4f57
	bit 5,l		;4f59
	jr nz,$+25		;4f5b
	exx			;4f5d
	ld b,000h		;4f5e
	exx			;4f60
	ld d,060h		;4f61
	ld e,060h		;4f63
	call L_4612		;4f65

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f68..0x4f72  (10 bytes)
DATA_4F68:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 4f68  GAME OVER.

; ======================================================================
; CODIGO 0x4f72..0x4f7f  (13 bytes)
; ======================================================================


	jr $+23		;4f72
L_4F74:
	exx			;4f74
	ld b,000h		;4f75
	exx			;4f77
	ld d,060h		;4f78
	ld e,060h		;4f7a
	call L_4612		;4f7c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4f7f..0x4f89  (10 bytes)
DATA_4F7F:
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,000h	; 4f7f           .

; ======================================================================
; CODIGO 0x4f89..0x504b  (194 bytes)
; ======================================================================


L_4F89:
	call L_42BA		;4f89
	pop hl			;4f8c
	ld a,(0d573h)		;4f8d
	bit 4,a		;4f90
	jp nz,L_4FC4		;4f92
	bit 5,a		;4f95
	jr nz,L_4F9F		;4f97
	dec hl			;4f99
	ld a,h			;4f9a
	or l			;4f9b
	jp nz,L_4F4E		;4f9c
L_4F9F:
	ld a,001h		;4f9f
	ld (0d190h),a		;4fa1
	ld (06ff8h),a		;4fa4
	ld a,002h		;4fa7
	ld (0d191h),a		;4fa9
	ld (077f8h),a		;4fac
	call 00041h		;4faf   ; BIOS DISSCR - Inhibits the screen display
	call 06077h		;4fb2
	call 00044h		;4fb5   ; BIOS ENASCR - Displays the screen
	ld a,000h		;4fb8
	ld (0d17ah),a		;4fba
	xor a			;4fbd
	ld (0d5e5h),a		;4fbe
	jp L_4E14		;4fc1
L_4FC4:
	ld a,001h		;4fc4
	ld (0d190h),a		;4fc6
	ld (06ff8h),a		;4fc9
	ld a,002h		;4fcc
	ld (0d191h),a		;4fce
	ld (077f8h),a		;4fd1
	call 00041h		;4fd4   ; BIOS DISSCR - Inhibits the screen display
	call 06077h		;4fd7
	call 00044h		;4fda   ; BIOS ENASCR - Displays the screen
	jp L_4E36		;4fdd
L_4FE0:
	ld a,000h		;4fe0
	ld (0d178h),a		;4fe2
	ld a,000h		;4fe5
	ld (0d17ah),a		;4fe7
	xor a			;4fea
	ld (0d17dh),a		;4feb
	ld (0d905h),a		;4fee
	ld (0d919h),a		;4ff1
	ld (0d926h),a		;4ff4
	ld (0d91eh),a		;4ff7
	ld (0d91fh),a		;4ffa
	ld (0d920h),a		;4ffd
	ld (0d921h),a		;5000
	ld (0d90dh),a		;5003
	ld (0d90eh),a		;5006
	ld (0d90fh),a		;5009
	ld (0d910h),a		;500c
	call L_47E9		;500f
	ld ix,0d413h		;5012
	ld b,020h		;5016
	call L_484E		;5018
	xor a			;501b
	ld (0d181h),a		;501c
	call L_431F		;501f
	call L_5124		;5022
	ld hl,05227h		;5025
	ld de,00000h		;5028
	ld b,010h		;502b
	ld c,050h		;502d
	ld a,0a0h		;502f
	ld (0d5d7h),a		;5031
	ld a,058h		;5034
	ld (0d5d6h),a		;5036
	exx			;5039
	ld b,000h		;503a
	exx			;503c
	call L_46C9		;503d
	exx			;5040
	ld b,000h		;5041
	exx			;5043
	ld d,0b8h		;5044
	ld e,020h		;5046
	call L_4612		;5048

; ----------------------------------------------------------------------
; DATOS sin identificar  0x504b..0x5064  (25 bytes)
DATA_504B:
	defb 040h,020h,054h,041h,049h,054h,04fh,020h,043h,04fh,052h,050h,04fh,052h,041h,054h	; 504b  @ TAITO CORPORAT
	defb 049h,04fh,04eh,020h,031h,039h,038h,038h,000h	; 505b  ION 1988.

; ======================================================================
; CODIGO 0x5064..0x506f  (11 bytes)
; ======================================================================


	exx			;5064
	ld b,000h		;5065
	exx			;5067
	ld d,0c0h		;5068
	ld e,038h		;506a
	call L_4612		;506c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x506f..0x5083  (20 bytes)
DATA_506F:
	defb 041h,04ch,04ch,020h,052h,049h,047h,048h,054h,053h,020h,052h,045h,053h,045h,052h	; 506f  ALL RIGHTS RESER
	defb 056h,045h,044h,000h	; 507f

; ======================================================================
; CODIGO 0x5083..0x508e  (11 bytes)
; ======================================================================


L_5083:
	exx			;5083
	ld b,000h		;5084
	exx			;5086
	ld d,088h		;5087
	ld e,040h		;5089
	call L_4612		;508b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x508e..0x509d  (15 bytes)
DATA_508E:
	defb 050h,055h,053h,048h,020h,053h,050h,041h,043h,045h,020h,04bh,045h,059h,000h	; 508e  PUSH SPACE KEY.

; ======================================================================
; CODIGO 0x509d..0x50ad  (16 bytes)
; ======================================================================


	ld a,00fh		;509d
	call L_4257		;509f
	exx			;50a2
	ld b,000h		;50a3
	exx			;50a5
	ld d,088h		;50a6
	ld e,040h		;50a8
	call L_4612		;50aa

; ----------------------------------------------------------------------
; DATOS sin identificar  0x50ad..0x50bc  (15 bytes)
DATA_50AD:
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,000h	; 50ad                .

; ======================================================================
; CODIGO 0x50bc..0x50ea  (46 bytes)
; ======================================================================


	ld a,00fh		;50bc
	call L_4257		;50be
	ld a,(0d181h)		;50c1
	cp 005h		;50c4
	jr z,L_50D3		;50c6
	call L_42BA		;50c8
	ld a,(0d573h)		;50cb
	bit 4,a		;50ce
	jr z,$-77		;50d0
	ret			;50d2
L_50D3:
	xor a			;50d3
	ld (0d181h),a		;50d4
	call L_431F		;50d7
	ld a,080h		;50da
	ld (0d17dh),a		;50dc
	exx			;50df
	ld b,000h		;50e0
	exx			;50e2
	ld d,070h		;50e3
	ld e,060h		;50e5
	call L_4612		;50e7

; ----------------------------------------------------------------------
; DATOS sin identificar  0x50ea..0x50f4  (10 bytes)
DATA_50EA:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 50ea  GAME OVER.

; ======================================================================
; CODIGO 0x50f4..0x5189  (149 bytes)
; ======================================================================


	ld a,032h		;50f4
	call L_4257		;50f6
	ld a,001h		;50f9
	call L_4228		;50fb
L_50FE:
	call L_4255		;50fe
	call L_42BA		;5101
	ld a,(0d573h)		;5104
	bit 4,a		;5107
	jr nz,L_511C		;5109
	ld a,(0d181h)		;510b
	cp 005h		;510e
	jr nz,L_50FE		;5110
	ld hl,0d17dh		;5112
	set 1,(hl)		;5115
	res 7,(hl)		;5117
	jp L_4FE0		;5119
L_511C:
	ld hl,0d17dh		;511c
	set 1,(hl)		;511f
	res 7,(hl)		;5121
	ret			;5123
L_5124:
	ld a,004h		;5124
	call L_424E		;5126
	ld a,003h		;5129
	call L_424E		;512b
	ld a,002h		;512e
	call L_424E		;5130
	ld a,001h		;5133
	call L_424E		;5135
	call L_47E9		;5138
	ld ix,0d413h		;513b
	ld b,020h		;513f
	call L_484E		;5141
	call 00041h		;5144   ; BIOS DISSCR - Inhibits the screen display
	ld a,0f0h		;5147
	ld (0d5e0h),a		;5149
	ld hl,05d27h		;514c
	ld (0d5eah),hl		;514f
	ld hl,05189h		;5152
	ld de,00000h		;5155
	ld b,007h		;5158
	ld c,009h		;515a
	ld a,010h		;515c
	ld (0d5d7h),a		;515e
	ld a,040h		;5161
	ld (0d5d6h),a		;5163
	exx			;5166
	ld b,001h		;5167
	exx			;5169
	call L_4711		;516a
	ld hl,05207h		;516d
	call L_446C		;5170
	call 00044h		;5173   ; BIOS ENASCR - Displays the screen
L_5176:
	call L_489E		;5176
	ld a,002h		;5179
	call L_4257		;517b
	ld a,(0d5e0h)		;517e
	and a			;5181
	ret z			;5182
	inc a			;5183
	ld (0d5e0h),a		;5184
	jr L_5176		;5187

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5189..0x524f  (198 bytes)
DATA_5189:
	defb 000h,000h,000h,000h,000h,000h,002h,000h,003h,000h,000h,000h,000h,000h,000h,000h	; 5189  ................
	defb 000h,000h,004h,000h,005h,000h,006h,000h,007h,000h,008h,000h,009h,000h,00ah,000h	; 5199  ................
	defb 000h,000h,000h,000h,00bh,000h,00ch,000h,00dh,000h,00eh,000h,00fh,000h,010h,000h	; 51a9  ................
	defb 011h,000h,000h,000h,000h,000h,012h,000h,013h,000h,014h,000h,015h,000h,016h,000h	; 51b9  ................
	defb 017h,000h,018h,000h,019h,000h,000h,000h,000h,000h,01ah,000h,000h,000h,01bh,000h	; 51c9  ................
	defb 01ch,000h,01dh,000h,01eh,000h,01fh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 51d9  ................
	defb 020h,000h,021h,000h,022h,000h,023h,000h,024h,000h,025h,000h,000h,000h,000h,000h	; 51e9   .!.".#.$.%.....
	defb 000h,000h,026h,000h,027h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 51f9  ..&.'...........
	defb 064h,006h,050h,005h,050h,004h,040h,003h,030h,003h,070h,000h,020h,002h,000h,000h	; 5209  d.P.P.@.0.p. ...
	defb 044h,004h,077h,077h,022h,002h,000h,000h,010h,000h,033h,003h,032h,000h,027h,000h	; 5219  D.ww".....3.2.'.
	defb 028h,000h,029h,000h,02ah,000h,02bh,000h,02ch,000h,02dh,000h,02eh,000h,02fh,000h	; 5229  (.).*.+.,.-.../.
	defb 030h,000h,000h,000h,031h,000h,032h,000h,033h,000h,034h,000h,035h,000h,036h,000h	; 5239  0...1.2.3.4.5.6.
	defb 037h,000h,038h,000h,039h,000h	; 5249

; ======================================================================
; CODIGO 0x524f..0x553a  (747 bytes)
; ======================================================================


L_524F:
	ld hl,0584bh		;524f
	ld de,00000h		;5252
	ld b,010h		;5255
	ld c,0f0h		;5257
	ld a,000h		;5259
	ld (0d5d7h),a		;525b
	ld a,000h		;525e
	ld (0d5d6h),a		;5260
	exx			;5263
	ld b,000h		;5264
	exx			;5266
	call L_46C9		;5267
	ld hl,00000h		;526a
	ld de,010f0h		;526d
	ld bc,02800h		;5270
	xor a			;5273
	ex af,af'			;5274
	ld a,001h		;5275
	ex af,af'			;5277
	call L_43AF		;5278
	ld a,001h		;527b
	ld (0db52h),a		;527d
	ld (0db53h),a		;5280
	call L_431F		;5283
	ld a,0a0h		;5286
	ld (0d91dh),a		;5288
	ld (0d91ch),a		;528b
	ld a,001h		;528e
	ld (0d902h),a		;5290
	ld a,0feh		;5293
	ld (0d903h),a		;5295
	xor a			;5298
	ld (0d90dh),a		;5299
	ld (0d90eh),a		;529c
	ld (0d90fh),a		;529f
	ld (0d910h),a		;52a2
	ld (0d925h),a		;52a5
	ld (0d924h),a		;52a8
	ld (0d91eh),a		;52ab
	ld (0d91fh),a		;52ae
	ld (0d920h),a		;52b1
	ld (0d921h),a		;52b4
	ld a,001h		;52b7
	ld (0da1fh),a		;52b9
	ld hl,0da20h		;52bc
	ld (0da1dh),hl		;52bf
	ld a,001h		;52c2
	ld (0da1ch),a		;52c4
	ld hl,0d933h		;52c7
	ld (0da1ah),hl		;52ca
	ld a,002h		;52cd
	call L_4228		;52cf
	ld a,003h		;52d2
	call L_4228		;52d4
	ld a,004h		;52d7
	call L_4228		;52d9
	call L_5805		;52dc
L_52DF:
	call L_5655		;52df
	jp L_540F		;52e2
L_52E5:
	ld a,007h		;52e5
	call 00141h		;52e7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 4,a		;52ea
	jr nz,L_52FE		;52ec
L_52EE:
	ld a,007h		;52ee
	call 00141h		;52f0   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 4,a		;52f3
	jr z,L_52EE		;52f5
	ld a,(0d5dfh)		;52f7
	cpl			;52fa
	ld (0d5dfh),a		;52fb
L_52FE:
	ld a,002h		;52fe
	call L_4257		;5300
	ld hl,0d910h		;5303
	bit 0,(hl)		;5306
	jr nz,L_5313		;5308
	ld hl,0d17dh		;530a
	bit 0,(hl)		;530d
	res 0,(hl)		;530f
	jr z,L_5321		;5311
L_5313:
	ld hl,0d5e5h		;5313
	inc (hl)			;5316
	ld a,(hl)			;5317
	cp 011h		;5318
	jp nz,L_52DF		;531a
	inc (hl)			;531d
	jp L_52DF		;531e
L_5321:
	ld a,(04010h)		;5321
	and a			;5324
	jp z,L_5342		;5325
	ld a,000h		;5328
	call 00141h		;532a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld hl,0d5e5h		;532d
	and 0c0h		;5330
	bit 7,a		;5332
	jr nz,L_533A		;5334
	inc (hl)			;5336
	jp L_52DF		;5337
L_533A:
	bit 6,a		;533a
	jr nz,L_5342		;533c
	dec (hl)			;533e
	jp L_52DF		;533f
L_5342:
	ld a,(0d17dh)		;5342
	bit 1,a		;5345
	jr nz,L_535A		;5347
	ld a,(04010h)		;5349
	and a			;534c
	jp z,L_5367		;534d
	ld a,007h		;5350
	call 00141h		;5352   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 5,a		;5355
	jp nz,L_5367		;5357
L_535A:
	ld hl,0d17dh		;535a
	set 6,(hl)		;535d
	ld a,002h		;535f
	call L_424E		;5361
	jp L_52FE		;5364
L_5367:
	ld a,(0d8fch)		;5367
	ld (0d92eh),a		;536a
	ld a,(0d8fdh)		;536d
	ld (0d92fh),a		;5370
	ld a,(0d8fch)		;5373
	cp 007h		;5376
	jr nc,L_539A		;5378
	ld a,0dah		;537a
	ld (0d92eh),a		;537c
	ld a,(0d5f0h)		;537f
	and a			;5382
	jp z,L_52E5		;5383
	dec a			;5386
	ld (0d5f0h),a		;5387
	ld a,(0d8fdh)		;538a
	cp 019h		;538d
	jp nc,L_540F		;538f
	ld a,023h		;5392
	ld (0d92fh),a		;5394
	jp L_540F		;5397
L_539A:
	ld a,(0d8fch)		;539a
	cp 0e2h		;539d
	jr c,L_53C5		;539f
	ld a,00fh		;53a1
	ld (0d92eh),a		;53a3
	ld a,(0d5eeh)		;53a6
	ld b,a			;53a9
	ld a,(0d5f0h)		;53aa
	cp b			;53ad
	jp z,L_52E5		;53ae
	inc a			;53b1
	ld (0d5f0h),a		;53b2
	ld a,(0d8fdh)		;53b5
	cp 019h		;53b8
	jp nc,L_540F		;53ba
	ld a,023h		;53bd
	ld (0d92fh),a		;53bf
	jp L_540F		;53c2
L_53C5:
	ld a,(0d8fdh)		;53c5
	cp 0afh		;53c8
	jp c,L_53E4		;53ca
	ld a,023h		;53cd
	ld (0d92fh),a		;53cf
	ld a,(0d5efh)		;53d2
	ld b,a			;53d5
	ld a,(0d5f1h)		;53d6
	cp b			;53d9
	jp z,L_52E5		;53da
	inc a			;53dd
	ld (0d5f1h),a		;53de
	jp L_540F		;53e1
L_53E4:
	ld a,(0d90dh)		;53e4
	and 0c2h		;53e7
	cp 080h		;53e9
	jr z,L_540C		;53eb
	cp 082h		;53ed
	jr z,L_540C		;53ef
	ld a,(0d8fdh)		;53f1
	cp 019h		;53f4
	jp nc,L_540C		;53f6
	ld a,0a5h		;53f9
	ld (0d92fh),a		;53fb
	ld a,(0d5f1h)		;53fe
	and a			;5401
	jp z,L_52E5		;5402
	dec a			;5405
	ld (0d5f1h),a		;5406
	jp L_540F		;5409
L_540C:
	jp L_52E5		;540c
L_540F:
	call 00041h		;540f   ; BIOS DISSCR - Inhibits the screen display
	ld a,004h		;5412
	call L_424E		;5414
	ld a,003h		;5417
	call L_424E		;5419
	ld a,002h		;541c
	call L_424E		;541e
	ld hl,0d90dh		;5421
	ld (hl),0c0h		;5424
	ld hl,0d90eh		;5426
	ld (hl),000h		;5429
	ld hl,0d90fh		;542b
	ld (hl),000h		;542e
	ld hl,0d910h		;5430
	ld a,(hl)			;5433
	and 080h		;5434
	or 010h		;5436
	ld (hl),a			;5438
	ld hl,0d924h		;5439
	ld (hl),000h		;543c
	ld hl,0d902h		;543e
	ld (hl),0feh		;5441
	ld hl,0d903h		;5443
	ld (hl),001h		;5446
	ld a,0ffh		;5448
	ld (0d8f7h),a		;544a
	ld (0d8f8h),a		;544d
	ld a,027h		;5450
	ld (0d913h),a		;5452
	call L_47E9		;5455
	ld ix,0d413h		;5458
	ld b,020h		;545c
	call L_484E		;545e
	ld a,(0d5f1h)		;5461
	ld hl,(0d5e1h)		;5464
	and a			;5467
	jr z,L_546D		;5468
	ld hl,(0d5e3h)		;546a
L_546D:
	ld a,h			;546d
	or l			;546e
	jr z,L_5496		;546f
	ld de,0d5f4h		;5471
	call L_557D		;5474
	ld hl,0d5f4h		;5477
	ld de,00000h		;547a
	ld b,00bh		;547d
	ld c,010h		;547f
	ld a,020h		;5481
	ld (0d5d7h),a		;5483
	ld a,000h		;5486
	ld (0d5d6h),a		;5488
	exx			;548b
	ld b,000h		;548c
	exx			;548e
	push ix		;548f
	call L_4711		;5491
	pop ix		;5494
L_5496:
	ld de,(0d5e7h)		;5496
	ld a,(0d5f1h)		;549a
	and a			;549d
	jr z,L_54B0		;549e
	ld b,a			;54a0
	ld a,(0d5eeh)		;54a1
	inc a			;54a4
	add a,a			;54a5
	ld c,a			;54a6
	xor a			;54a7
L_54A8:
	add a,c			;54a8
	djnz L_54A8		;54a9
	ld l,a			;54ab
	ld h,000h		;54ac
	add hl,de			;54ae
	ex de,hl			;54af
L_54B0:
	ld a,(0d5f0h)		;54b0
	add a,a			;54b3
	ld l,a			;54b4
	ld h,000h		;54b5
	ld a,002h		;54b7
	ld (0d191h),a		;54b9
	ld (077f8h),a		;54bc
	add hl,de			;54bf
	ld e,(hl)			;54c0
	inc hl			;54c1
	ld d,(hl)			;54c2
	ld a,e			;54c3
	cp 0ffh		;54c4
	jp nz,L_54E0		;54c6
	ld a,d			;54c9
	and 0f0h		;54ca
	srl a		;54cc
	srl a		;54ce
	srl a		;54d0
	srl a		;54d2
	ld (0d5f0h),a		;54d4
	ld a,d			;54d7
	and 00fh		;54d8
	ld (0d5f1h),a		;54da
	jp L_5496		;54dd
L_54E0:
	ex de,hl			;54e0
	ld de,0d774h		;54e1
	call L_557D		;54e4
	ld hl,0d774h		;54e7
	ld de,00000h		;54ea
	ld b,00bh		;54ed
	ld c,010h		;54ef
	ld a,020h		;54f1
	ld (0d5d7h),a		;54f3
	ld a,000h		;54f6
	ld (0d5d6h),a		;54f8
	exx			;54fb
	ld b,001h		;54fc
	exx			;54fe
	push ix		;54ff
	call L_4711		;5501
	pop ix		;5504
	ld de,0d774h		;5506
	call L_55C5		;5509
	ld hl,0d8d4h		;550c
	ld de,0d8d5h		;550f
	ld bc,0001fh		;5512
	ld (hl),0ffh		;5515
	ldir		;5517
	call L_58F9		;5519
	call L_47E9		;551c
	ld ix,0d476h		;551f
	ld b,016h		;5523
	call L_484E		;5525
	ld a,(0d17dh)		;5528
	bit 7,a		;552b
	jr z,$+23		;552d
	exx			;552f
	ld b,001h		;5530
	exx			;5532
	ld d,070h		;5533
	ld e,060h		;5535
	call L_4612		;5537

; ----------------------------------------------------------------------
; DATOS sin identificar  0x553a..0x5544  (10 bytes)
DATA_553A:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 553a  GAME OVER.

; ======================================================================
; CODIGO 0x5544..0x57d3  (655 bytes)
; ======================================================================


L_5544:
	ld ix,0d413h		;5544
	ld b,020h		;5548
	call L_484E		;554a
	ld a,(0d92eh)		;554d
	ld (0d8fch),a		;5550
	ld a,(0d92fh)		;5553
	ld (0d8fdh),a		;5556
	ld a,004h		;5559
	call L_4228		;555b
	ld a,003h		;555e
	call L_4228		;5560
	ld a,002h		;5563
	call L_4228		;5565
	call 00044h		;5568   ; BIOS ENASCR - Displays the screen
	ld hl,0d90dh		;556b
	ld (hl),0c0h		;556e
	ld hl,0d90eh		;5570
	ld (hl),000h		;5573
	ld hl,0d90fh		;5575
	ld (hl),000h		;5578
	jp L_52E5		;557a
L_557D:
	ld a,(0d5e9h)		;557d
	ld (0d191h),a		;5580
	ld (077f8h),a		;5583
	inc a			;5586
	ld (0d192h),a		;5587
	ld (07ff8h),a		;558a
	push hl			;558d
	pop ix		;558e
	ex de,hl			;5590
L_5591:
	ld e,(ix+000h)		;5591
	ld d,(ix+001h)		;5594
	ld a,e			;5597
	and d			;5598
	cp 0efh		;5599
	jp z,L_55C4		;559b
	ld a,d			;559e
	cp 0d0h		;559f
	jr nz,L_55BA		;55a1
	ld b,e			;55a3
	inc ix		;55a4
	inc ix		;55a6
	ld e,(ix+000h)		;55a8
	ld d,(ix+001h)		;55ab
L_55AE:
	ld (hl),e			;55ae
	inc hl			;55af
	ld (hl),d			;55b0
	inc hl			;55b1
	djnz L_55AE		;55b2
	inc ix		;55b4
	inc ix		;55b6
	jr L_5591		;55b8
L_55BA:
	ld (hl),e			;55ba
	inc hl			;55bb
	ld (hl),d			;55bc
	inc hl			;55bd
	inc ix		;55be
	inc ix		;55c0
	jr L_5591		;55c2
L_55C4:
	ret			;55c4
L_55C5:
	ld a,(0d5e9h)		;55c5
	ld (0d191h),a		;55c8
	ld (077f8h),a		;55cb
	inc a			;55ce
	ld (0d192h),a		;55cf
	ld (07ff8h),a		;55d2
	inc ix		;55d5
	inc ix		;55d7
L_55D9:
	ld a,(ix+000h)		;55d9
	cp 0ffh		;55dc
	jp z,L_5635		;55de
	ld l,a			;55e1
	ld h,000h		;55e2
	add hl,hl			;55e4
	ld de,0d774h		;55e5
	add hl,de			;55e8
	push hl			;55e9
	ld l,(ix+001h)		;55ea
	ld h,(ix+002h)		;55ed
	ld de,08000h		;55f0
	add hl,de			;55f3
	ex de,hl			;55f4
	pop hl			;55f5
	ld (hl),e			;55f6
	inc hl			;55f7
	ld (hl),d			;55f8
	inc hl			;55f9
	push hl			;55fa
	ld l,(ix+003h)		;55fb
	ld h,(ix+004h)		;55fe
	ld de,09000h		;5601
	add hl,de			;5604
	ex de,hl			;5605
	pop hl			;5606
	ld (hl),e			;5607
	inc hl			;5608
	ld (hl),d			;5609
	inc hl			;560a
	ld b,(ix+005h)		;560b
	ex de,hl			;560e
L_560F:
	push bc			;560f
	dec de			;5610
	dec de			;5611
	dec de			;5612
	dec de			;5613
	push de			;5614
	ld hl,00020h		;5615
	add hl,de			;5618
	ex de,hl			;5619
	pop hl			;561a
	ldi		;561b
	ldi		;561d
	ldi		;561f
	ldi		;5621
	pop bc			;5623
	djnz L_560F		;5624
	inc ix		;5626
	inc ix		;5628
	inc ix		;562a
	inc ix		;562c
	inc ix		;562e
	inc ix		;5630
	jp L_55D9		;5632
L_5635:
	push ix		;5635
	ld hl,0d774h		;5637
	ld de,00000h		;563a
	ld b,00bh		;563d
	ld c,010h		;563f
	ld a,020h		;5641
	ld (0d5d7h),a		;5643
	ld a,000h		;5646
	ld (0d5d6h),a		;5648
	exx			;564b
	ld b,001h		;564c
	exx			;564e
	call L_4711		;564f
	pop ix		;5652
	ret			;5654
L_5655:
	ld a,002h		;5655
	ld (0d191h),a		;5657
	ld (077f8h),a		;565a
	ld a,(0d5e5h)		;565d
	cp 012h		;5660
	ld a,003h		;5662
	ld (0d17ah),a		;5664
	ld a,007h		;5667
	jp nc,L_5680		;5669
	ld a,(0d5e5h)		;566c
	ld b,000h		;566f
L_5671:
	inc b			;5671
	sub 003h		;5672
	jp nc,L_5671		;5674
	add a,003h		;5677
	inc a			;5679
	inc a			;567a
	ld a,a			;567b
	ld (0d17ah),a		;567c
	ld a,b			;567f
L_5680:
	ld de,00830h		;5680
	ex af,af'			;5683
	xor a			;5684
	ex af,af'			;5685
	call L_4663		;5686
	ld a,(0d5e5h)		;5689
	add a,a			;568c
	ld l,a			;568d
	ld h,000h		;568e
	add hl,hl			;5690
	add hl,hl			;5691
	add hl,hl			;5692
	ld de,09035h		;5693
	add hl,de			;5696
	ld e,(hl)			;5697
	inc hl			;5698
	ld d,(hl)			;5699
	inc hl			;569a
	ld (0d5e7h),de		;569b
	ld e,(hl)			;569f
	inc hl			;56a0
	ld d,(hl)			;56a1
	inc hl			;56a2
	ld (0d5eah),de		;56a3
	ld a,(hl)			;56a7
	inc hl			;56a8
	ld (0d5eeh),a		;56a9
	ld a,(hl)			;56ac
	inc hl			;56ad
	ld (0d5efh),a		;56ae
	ld a,(hl)			;56b1
	inc hl			;56b2
	ld (0d5f0h),a		;56b3
	ld a,(hl)			;56b6
	inc hl			;56b7
	ld (0d5f1h),a		;56b8
	ld e,(hl)			;56bb
	inc hl			;56bc
	ld d,(hl)			;56bd
	inc hl			;56be
	ld (0d5e1h),de		;56bf
	ld e,(hl)			;56c3
	inc hl			;56c4
	ld d,(hl)			;56c5
	inc hl			;56c6
	ld (0d5e3h),de		;56c7
	ld e,(hl)			;56cb
	inc hl			;56cc
	ld d,(hl)			;56cd
	inc hl			;56ce
	ld a,(hl)			;56cf
	ld (0d5e9h),a		;56d0
	inc hl			;56d3
	ld a,(hl)			;56d4
	ld b,a			;56d5
	and 00fh		;56d6
	add a,a			;56d8
	add a,a			;56d9
	add a,a			;56da
	add a,a			;56db
	ld (0d8fch),a		;56dc
	ld (0d92eh),a		;56df
	ld a,b			;56e2
	and 0f0h		;56e3
	add a,020h		;56e5
	ld (0d8fdh),a		;56e7
	ld (0d92fh),a		;56ea
	ex de,hl			;56ed
	call L_446C		;56ee
	ret			;56f1
L_56F2:
	call L_4255		;56f2
	ld a,(0d5dfh)		;56f5
	and a			;56f8
	jr z,L_56F2		;56f9
	ld a,006h		;56fb
	ld (0d190h),a		;56fd
	ld (06ff8h),a		;5700
	ld a,007h		;5703
	ld (0d191h),a		;5705
	ld (077f8h),a		;5708
	call 06000h		;570b
	ld ix,0d413h		;570e
	ld b,00ah		;5712
	call L_484E		;5714
	ld a,(0d924h)		;5717
	bit 7,a		;571a
	jp z,L_574F		;571c
	ld a,(0d922h)		;571f
	ld (0d5deh),a		;5722
	ld a,(0d923h)		;5725
	ld (0d5ddh),a		;5728
	ld hl,0d481h		;572b
	ld iy,0d902h		;572e
	ld ix,0963ah		;5732
	ex af,af'			;5736
	xor a			;5737
	ex af,af'			;5738
	ld a,01ah		;5739
	ld (0d191h),a		;573b
	ld (077f8h),a		;573e
	call L_5AA5		;5741
L_5744:
	ld ix,0d481h		;5744
	ld b,001h		;5748
	call L_484E		;574a
	jr L_56F2		;574d
L_574F:
	xor a			;574f
	ld (0d481h),a		;5750
	ld (0d482h),a		;5753
	ld (0d488h),a		;5756
	ld a,0ffh		;5759
	ld (0d484h),a		;575b
	jr L_5744		;575e
L_5760:
	call L_4255		;5760
	ld a,(0d5dfh)		;5763
	and a			;5766
	jr z,L_5760		;5767
	ld a,003h		;5769
	ld (0d190h),a		;576b
	ld (06ff8h),a		;576e
	ld a,004h		;5771
	ld (0d191h),a		;5773
	ld (077f8h),a		;5776
	call 06000h		;5779
	ld a,(0d5e5h)		;577c
	cp 017h		;577f
	jr nz,L_5760		;5781
	ld a,0c8h		;5783
	call L_4257		;5785
	ld a,0c8h		;5788
	call L_4257		;578a
	ld a,0c8h		;578d
	call L_4257		;578f
	ld a,042h		;5792
	ld (0d17dh),a		;5794
	jr L_5760		;5797
L_5799:
	call L_4255		;5799
	ld a,(0d5dfh)		;579c
	and a			;579f
	jr z,L_5799		;57a0
	ld a,005h		;57a2
	ld (0d190h),a		;57a4
	ld (06ff8h),a		;57a7
	call 06000h		;57aa
	jr L_5799		;57ad
L_57AF:
	call L_48F9		;57af
	ld a,005h		;57b2
	ld (0d190h),a		;57b4
	ld (06ff8h),a		;57b7
	ret			;57ba
L_57BB:
	call L_4A8B		;57bb
	ld a,005h		;57be
	ld (0d190h),a		;57c0
	ld (06ff8h),a		;57c3
	ret			;57c6
L_57C7:
	call L_4B10		;57c7
	ld a,005h		;57ca
	ld (0d190h),a		;57cc
	ld (06ff8h),a		;57cf
	ret			;57d2

; ----------------------------------------------------------------------
; DATOS sin identificar  0x57d3..0x5805  (50 bytes)
DATA_57D3:
	defb 000h,018h,001h,018h,002h,018h,000h,019h,001h,019h,002h,019h,003h,019h,000h,020h	; 57d3  ...............
	defb 000h,01ah,000h,01bh,000h,01ch,000h,01dh,000h,01eh,000h,01fh,000h,022h,000h,021h	; 57e3  .............".!
	defb 000h,023h,000h,024h,001h,01fh,001h,01eh,000h,01eh,000h,025h,004h,019h,002h,017h	; 57f3  .#.$.......%....
	defb 001h,017h	; 5803

; ======================================================================
; CODIGO 0x5805..0x5810  (11 bytes)
; ======================================================================


L_5805:
	exx			;5805
	ld b,000h		;5806
	exx			;5808
	ld d,010h		;5809
	ld e,008h		;580b
	call L_4612		;580d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5810..0x5816  (6 bytes)
DATA_5810:
	defb 053h,043h,04fh,052h,045h,000h	; 5810

; ======================================================================
; CODIGO 0x5816..0x5821  (11 bytes)
; ======================================================================


	exx			;5816
	ld b,000h		;5817
	exx			;5819
	ld d,018h		;581a
	ld e,000h		;581c
	call L_4612		;581e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5821..0x5829  (8 bytes)
DATA_5821:
	defb 020h,020h,020h,020h,020h,020h,030h,000h	; 5821        0.

; ======================================================================
; CODIGO 0x5829..0x5834  (11 bytes)
; ======================================================================


	exx			;5829
	ld b,000h		;582a
	exx			;582c
	ld d,008h		;582d
	ld e,008h		;582f
	call L_4612		;5831

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5834..0x583a  (6 bytes)
DATA_5834:
	defb 052h,04fh,055h,04eh,044h,000h	; 5834

; ======================================================================
; CODIGO 0x583a..0x5845  (11 bytes)
; ======================================================================


	exx			;583a
	ld b,000h		;583b
	exx			;583d
	ld d,008h		;583e
	ld e,050h		;5840
	call L_4612		;5842

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5845..0x584a  (5 bytes)
DATA_5845:
	defb 04ch,049h,046h,045h,000h	; 5845

; ======================================================================
; CODIGO 0x584a..0x584b  (1 bytes)
; ======================================================================


	ret			;584a

; ----------------------------------------------------------------------
; DATOS sin identificar  0x584b..0x58c3  (120 bytes)
DATA_584B:
	defb 016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h	; 584b  ................
	defb 016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h	; 585b  ................
	defb 016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h	; 586b  ................
	defb 016h,002h,017h,002h,016h,002h,017h,002h,016h,002h,017h,002h,026h,002h,027h,002h	; 587b  ............&.'.
	defb 026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h	; 588b  &.'.&.'.&.'.&.'.
	defb 026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h	; 589b  &.'.&.'.&.'.&.'.
	defb 026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h,026h,002h,027h,002h	; 58ab  &.'.&.'.&.'.&.'.
	defb 026h,002h,027h,002h,026h,002h,027h,002h	; 58bb  &.'.&.'.

; ======================================================================
; CODIGO 0x58c3..0x5a8e  (459 bytes)
; ======================================================================


L_58C3:
	ld a,008h		;58c3
	ld (0d190h),a		;58c5
	ld (06ff8h),a		;58c8
	push hl			;58cb
	push bc			;58cc
	ex af,af'			;58cd
	xor a			;58ce
	ex af,af'			;58cf
	call L_5AA5		;58d0
	ld a,(0d93dh)		;58d3
	and 07fh		;58d6
	ex af,af'			;58d8
	rrca			;58d9
	and 080h		;58da
	ld b,a			;58dc
	ex af,af'			;58dd
	or b			;58de
	ld (0d935h),a		;58df
	pop bc			;58e2
	pop ix		;58e3
	call L_484E		;58e5
	ld a,003h		;58e8
	ld (0d190h),a		;58ea
	ld (06ff8h),a		;58ed
	ld a,004h		;58f0
	ld (0d191h),a		;58f2
	ld (077f8h),a		;58f5
	ret			;58f8
L_58F9:
	push ix		;58f9
	ld ix,0da20h		;58fb
	ld b,008h		;58ff
L_5901:
	push bc			;5901
	ld a,(ix+000h)		;5902
	and a			;5905
	jp z,L_590C		;5906
	call L_4B10		;5909
L_590C:
	ld de,00026h		;590c
	add ix,de		;590f
	pop bc			;5911
	djnz L_5901		;5912
	ld ix,0d933h		;5914
	ld b,006h		;5918
L_591A:
	push bc			;591a
	ld a,(ix+000h)		;591b
	and a			;591e
	jp z,L_5925		;591f
	call L_4B10		;5922
L_5925:
	ld de,00026h		;5925
	add ix,de		;5928
	pop bc			;592a
	djnz L_591A		;592b
	ld hl,0da20h		;592d
	ld de,0da21h		;5930
	ld bc,0012fh		;5933
	xor a			;5936
	ld (hl),a			;5937
	ldir		;5938
	ld hl,0d933h		;593a
	ld de,0d934h		;593d
	ld bc,000e3h		;5940
	xor a			;5943
	ld (hl),a			;5944
	ldir		;5945
	ld (0da17h),a		;5947
	ld (0da18h),a		;594a
	pop hl			;594d
	inc hl			;594e
	ld ix,0da20h		;594f
	ld b,008h		;5953
L_5955:
	push bc			;5955
	ld a,(0d5e9h)		;5956
	ld (0d191h),a		;5959
	ld (077f8h),a		;595c
	inc a			;595f
	ld (0d192h),a		;5960
	ld (07ff8h),a		;5963
	ld a,(hl)			;5966
	cp 0ffh		;5967
	jr z,L_599E		;5969
	ld b,a			;596b
	and 00fh		;596c
	add a,a			;596e
	add a,a			;596f
	add a,a			;5970
	add a,a			;5971
	ld (ix+010h),a		;5972
	ld a,b			;5975
	and 0f0h		;5976
	add a,020h		;5978
	ld (ix+011h),a		;597a
	inc hl			;597d
	ld a,(hl)			;597e
	bit 7,a		;597f
	jp nz,L_5A88		;5981
	dec a			;5984
	push hl			;5985
	ld l,a			;5986
	ld h,000h		;5987
	add hl,hl			;5989
	ld de,057d3h		;598a
	add hl,de			;598d
	ld a,(hl)			;598e
	ld (ix+001h),a		;598f
	inc hl			;5992
	ld a,(hl)			;5993
	ld (ix+000h),a		;5994
	pop hl			;5997
L_5998:
	inc hl			;5998
	ld de,00026h		;5999
	add ix,de		;599c
L_599E:
	pop bc			;599e
	djnz L_5955		;599f
	inc hl			;59a1
	ld ix,0d933h		;59a2
	ld b,003h		;59a6
L_59A8:
	push bc			;59a8
	ld a,(0d5e9h)		;59a9
	ld (0d191h),a		;59ac
	ld (077f8h),a		;59af
	inc a			;59b2
	ld (0d192h),a		;59b3
	ld (07ff8h),a		;59b6
	ld a,(hl)			;59b9
	cp 0ffh		;59ba
	jr z,L_59D6		;59bc
	ld b,a			;59be
	and 00fh		;59bf
	add a,a			;59c1
	add a,a			;59c2
	add a,a			;59c3
	add a,a			;59c4
	ld (ix+006h),a		;59c5
	ld a,b			;59c8
	and 0f0h		;59c9
	add a,020h		;59cb
	ld (ix+007h),a		;59cd
	inc hl			;59d0
	ld a,(hl)			;59d1
	ld (ix+000h),a		;59d2
	inc hl			;59d5
L_59D6:
	ld de,00026h		;59d6
	add ix,de		;59d9
	pop bc			;59db
	djnz L_59A8		;59dc
	inc hl			;59de
	ld a,(hl)			;59df
	cp 0ffh		;59e0
	jp z,L_5A02		;59e2
	ld b,a			;59e5
	and 00fh		;59e6
	add a,a			;59e8
	add a,a			;59e9
	add a,a			;59ea
	add a,a			;59eb
	ld (0d92bh),a		;59ec
	ld a,b			;59ef
	and 0f0h		;59f0
	add a,020h		;59f2
	ld (0d92ch),a		;59f4
	inc hl			;59f7
	ld a,(hl)			;59f8
	ld (0d92dh),a		;59f9
	call L_48B6		;59fc
	jp L_5A06		;59ff
L_5A02:
	xor a			;5a02
	ld (0d92dh),a		;5a03
L_5A06:
	ld ix,0d933h		;5a06
	ld b,003h		;5a0a
L_5A0C:
	push bc			;5a0c
	ld a,(ix+000h)		;5a0d
	and a			;5a10
	jr z,L_5A3D		;5a11
	cp 002h		;5a13
	jr z,L_5A3D		;5a15
	ld l,a			;5a17
	ld h,000h		;5a18
	ld de,05a8eh		;5a1a
	add hl,de			;5a1d
	ld a,(hl)			;5a1e
	ld (ix+00fh),a		;5a1f
	call L_48F9		;5a22
	call L_4A8B		;5a25
	call L_4A8B		;5a28
	call L_4A8B		;5a2b
	call L_4A8B		;5a2e
	call L_4A8B		;5a31
	call L_4A8B		;5a34
	call L_4A8B		;5a37
	call L_4A8B		;5a3a
L_5A3D:
	pop bc			;5a3d
	ld de,00026h		;5a3e
	add ix,de		;5a41
	djnz L_5A0C		;5a43
	ld ix,0da20h		;5a45
	ld b,008h		;5a49
L_5A4B:
	push bc			;5a4b
	ld a,(ix+000h)		;5a4c
	and a			;5a4f
	jr z,L_5A7F		;5a50
	cp 018h		;5a52
	jr z,L_5A64		;5a54
	cp 01ch		;5a56
	jr z,L_5A64		;5a58
	cp 022h		;5a5a
	jr z,L_5A64		;5a5c
	cp 025h		;5a5e
	jr z,L_5A64		;5a60
	jr L_5A7F		;5a62
L_5A64:
	call L_48F9		;5a64
	call L_4A8B		;5a67
	call L_4A8B		;5a6a
	call L_4A8B		;5a6d
	call L_4A8B		;5a70
	call L_4A8B		;5a73
	call L_4A8B		;5a76
	call L_4A8B		;5a79
	call L_4A8B		;5a7c
L_5A7F:
	pop bc			;5a7f
	ld de,00026h		;5a80
	add ix,de		;5a83
	djnz L_5A4B		;5a85
	ret			;5a87
L_5A88:
	ld (ix+000h),a		;5a88
	jp L_5998		;5a8b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5a8e..0x5aa5  (23 bytes)
DATA_5A8E:
	defb 000h,010h,020h,010h,010h,010h,030h,020h,020h,020h,010h,010h,010h,020h,010h,020h	; 5a8e  .. ...0   ... .
	defb 020h,020h,020h,020h,020h,020h,000h	; 5a9e

; ======================================================================
; CODIGO 0x5aa5..0x5b7d  (216 bytes)
; ======================================================================


L_5AA5:
	ex af,af'			;5aa5
	bit 1,a		;5aa6
	jr z,L_5AB2		;5aa8
	ld (iy+000h),0feh		;5aaa
	ld (iy+001h),001h		;5aae
L_5AB2:
	ex af,af'			;5ab2
	push hl			;5ab3
	ld a,(iy+001h)		;5ab4
	dec a			;5ab7
	ld (iy+001h),a		;5ab8
	jp nz,L_5B78		;5abb
	ld l,(ix+000h)		;5abe
	ld h,(ix+001h)		;5ac1
	push hl			;5ac4
	inc ix		;5ac5
	inc ix		;5ac7
	ld a,(iy+000h)		;5ac9
	inc a			;5acc
	cp (ix+000h)		;5acd
	jr c,L_5ADB		;5ad0
	ex af,af'			;5ad2
	ld a,000h		;5ad3
	ld a,001h		;5ad5
	ex af,af'			;5ad7
	xor a			;5ad8
	jr L_5ADE		;5ad9
L_5ADB:
	ex af,af'			;5adb
	xor a			;5adc
	ex af,af'			;5add
L_5ADE:
	ld (iy+000h),a		;5ade
	inc ix		;5ae1
	add a,a			;5ae3
	ld e,a			;5ae4
	ld d,000h		;5ae5
	add ix,de		;5ae7
	ld l,(ix+000h)		;5ae9
	ld h,(ix+001h)		;5aec
	push hl			;5aef
	pop ix		;5af0
	ld a,(ix+000h)		;5af2
	ld (iy+001h),a		;5af5
	inc ix		;5af8
	ld a,(ix+000h)		;5afa
	ld b,a			;5afd
	inc ix		;5afe
	pop de			;5b00
	pop iy		;5b01
L_5B03:
	push bc			;5b03
	ld a,(ix+000h)		;5b04
	cp 0ffh		;5b07
	jp z,L_5B5C		;5b09
	dec a			;5b0c
	ld l,a			;5b0d
	ld h,000h		;5b0e
	add hl,hl			;5b10
	add hl,hl			;5b11
	add hl,hl			;5b12
	add hl,hl			;5b13
	add hl,hl			;5b14
	add hl,de			;5b15
	ld (iy+000h),l		;5b16
	ld (iy+001h),h		;5b19
	ld a,(ix+001h)		;5b1c
	ld (iy+002h),a		;5b1f
	ld a,(ix+002h)		;5b22
	ld (iy+003h),a		;5b25
	ld a,(0d5ddh)		;5b28
	ld (iy+006h),a		;5b2b
	ld a,(0d5deh)		;5b2e
	ld (iy+007h),a		;5b31
	ld a,(ix+003h)		;5b34
	ld (iy+008h),a		;5b37
	inc ix		;5b3a
	inc ix		;5b3c
	inc ix		;5b3e
	inc ix		;5b40
L_5B42:
	inc iy		;5b42
	inc iy		;5b44
	inc iy		;5b46
	inc iy		;5b48
	inc iy		;5b4a
	inc iy		;5b4c
	inc iy		;5b4e
	inc iy		;5b50
	inc iy		;5b52
	inc iy		;5b54
	inc iy		;5b56
	pop bc			;5b58
	djnz L_5B03		;5b59
	ret			;5b5b
L_5B5C:
	push de			;5b5c
	push iy		;5b5d
	pop de			;5b5f
	ld hl,05b7dh		;5b60
	ldi		;5b63
	ldi		;5b65
	ldi		;5b67
	ldi		;5b69
	ldi		;5b6b
	ldi		;5b6d
	ldi		;5b6f
	ldi		;5b71
	pop de			;5b73
	inc ix		;5b74
	jr L_5B42		;5b76
L_5B78:
	ex af,af'			;5b78
	xor a			;5b79
	ex af,af'			;5b7a
	pop hl			;5b7b
	ret			;5b7c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5b7d..0x5b95  (24 bytes)
DATA_5B7D:
	defb 0ffh,0ffh,000h,0ffh,0ffh,0ffh,000h,000h,0e0h,000h,000h,000h,0e0h,000h,000h,000h	; 5b7d  ................
	defb 0e0h,000h,000h,000h,0e0h,000h,000h,000h	; 5b8d  ........

; ======================================================================
; CODIGO 0x5b95..0x5bc3  (46 bytes)
; ======================================================================


L_5B95:
	push hl			;5b95
	ld l,(ix+000h)		;5b96
	ld h,(ix+001h)		;5b99
	push hl			;5b9c
	inc ix		;5b9d
	inc ix		;5b9f
	inc ix		;5ba1
	ld a,(iy+000h)		;5ba3
	add a,a			;5ba6
	ld e,a			;5ba7
	ld d,000h		;5ba8
	add ix,de		;5baa
	ld l,(ix+000h)		;5bac
	ld h,(ix+001h)		;5baf
	push hl			;5bb2
	pop ix		;5bb3
	inc ix		;5bb5
	ld a,(ix+000h)		;5bb7
	ld b,a			;5bba
	inc ix		;5bbb
	pop de			;5bbd
	pop iy		;5bbe
	jp L_5B03		;5bc0

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5bc3..0x6000  (1085 bytes)
DATA_5BC3:
	defb 034h,008h,035h,008h,036h,008h,037h,008h,038h,008h,039h,008h,03ah,008h,03bh,008h	; 5bc3  4.5.6.7.8.9.:.;.
	defb 03ch,008h,03dh,008h,03eh,008h,03fh,008h,040h,008h,041h,008h,042h,008h,043h,008h	; 5bd3  <.=.>.?.@.A.B.C.
	defb 044h,008h,045h,008h,046h,008h,047h,008h,048h,008h,049h,008h,04ah,008h,04bh,008h	; 5be3  D.E.F.G.H.I.J.K.
	defb 04ch,008h,04dh,008h,04eh,008h,04fh,008h,050h,008h,051h,008h,052h,008h,053h,008h	; 5bf3  L.M.N.O.P.Q.R.S.
	defb 054h,008h,055h,008h,056h,008h,057h,008h,058h,008h,059h,008h,05ah,008h,05bh,008h	; 5c03  T.U.V.W.X.Y.Z.[.
	defb 05ch,008h,05dh,008h,05eh,008h,05fh,008h,060h,008h,061h,008h,062h,008h,063h,008h	; 5c13  \.].^._.`.a.b.c.
	defb 064h,008h,065h,008h,066h,008h,067h,008h,068h,008h,069h,008h,06ah,008h,06bh,008h	; 5c23  d.e.f.g.h.i.j.k.
	defb 06ch,008h,06dh,008h,06eh,008h,06fh,008h,070h,008h,071h,008h,072h,008h,000h,000h	; 5c33  l.m.n.o.p.q.r...
	defb 073h,008h,074h,008h,075h,008h,076h,008h,077h,008h,078h,008h,000h,000h,000h,000h	; 5c43  s.t.u.v.w.x.....
	defb 0cch,000h,0ceh,000h,0d0h,000h,0d2h,000h,0d4h,000h,0d6h,000h,0d8h,000h,0dah,000h	; 5c53  ................
	defb 079h,008h,07ah,008h,07bh,008h,07ch,008h,07dh,008h,07eh,008h,000h,000h,000h,000h	; 5c63  y.z.{.|.}.~.....
	defb 0cdh,000h,0cfh,000h,0d1h,000h,0d3h,000h,0d5h,000h,0d7h,000h,0d9h,000h,0dbh,000h	; 5c73  ................
	defb 0dch,000h,0deh,000h,0e0h,000h,0e2h,000h,0e4h,000h,0e6h,000h,0e8h,000h,0eah,000h	; 5c83  ................
	defb 0ech,000h,0eeh,000h,0f0h,000h,0f2h,000h,0f4h,000h,0f6h,000h,0b8h,000h,0bah,000h	; 5c93  ................
	defb 0ddh,000h,0dfh,000h,0e1h,000h,0e3h,000h,0e5h,000h,0e7h,000h,0e9h,000h,0ebh,000h	; 5ca3  ................
	defb 0edh,000h,0efh,000h,0f1h,000h,0f3h,000h,0f5h,000h,0f7h,000h,0b9h,000h,0bbh,000h	; 5cb3  ................
	defb 0bch,000h,0beh,000h,0c0h,000h,0c2h,000h,0c4h,000h,0c6h,000h,0c8h,000h,0cah,000h	; 5cc3  ................
	defb 0b8h,000h,0bah,000h,0bch,000h,0beh,000h,0c0h,000h,0c2h,000h,0c4h,000h,0c6h,000h	; 5cd3  ................
	defb 0bdh,000h,0bfh,000h,0c1h,000h,0c3h,000h,0c5h,000h,0c7h,000h,0c9h,000h,0cbh,000h	; 5ce3  ................
	defb 0b9h,000h,0bbh,000h,0bdh,000h,0bfh,000h,0c1h,000h,0c3h,000h,0c5h,000h,0c7h,000h	; 5cf3  ................
	defb 0c8h,000h,0cah,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5d03  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5d13  ................
	defb 0c9h,000h,0cbh,000h,000h,000h,000h,000h,080h,001h,080h,001h,000h,000h,000h,000h	; 5d23  ................
	defb 000h,000h,000h,000h,07fh,008h,080h,008h,081h,008h,082h,008h,000h,000h,000h,000h	; 5d33  ................
	defb 000h,000h,083h,008h,000h,000h,000h,000h,080h,001h,080h,001h,000h,000h,084h,008h	; 5d43  ................
	defb 085h,008h,000h,000h,086h,008h,087h,008h,088h,008h,089h,008h,08ah,008h,08bh,008h	; 5d53  ................
	defb 08ch,008h,08dh,008h,08eh,008h,08fh,008h,000h,000h,000h,000h,000h,000h,000h,000h	; 5d63  ................
	defb 090h,008h,091h,008h,092h,008h,093h,008h,094h,008h,095h,008h,096h,008h,097h,008h	; 5d73  ................
	defb 098h,008h,099h,008h,09ah,008h,09bh,008h,09ch,008h,09dh,008h,09eh,008h,09fh,008h	; 5d83  ................
	defb 0a0h,008h,0a1h,008h,0a2h,008h,0a3h,008h,0a4h,008h,0a5h,008h,0a6h,008h,0a7h,008h	; 5d93  ................
	defb 0a8h,008h,0a9h,008h,0aah,008h,0abh,008h,0ach,008h,0adh,008h,0aeh,008h,0afh,008h	; 5da3  ................
	defb 0b0h,008h,0b1h,008h,0b2h,008h,0b3h,008h,0b4h,008h,0b5h,008h,0b6h,008h,0b7h,008h	; 5db3  ................
	defb 0b8h,008h,0b9h,008h,0bah,008h,0bbh,008h,0bch,008h,0bdh,008h,000h,000h,0beh,008h	; 5dc3  ................
	defb 0bfh,008h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,008h,0c1h,008h,0c2h,008h	; 5dd3  ................
	defb 000h,000h,000h,000h,0c3h,008h,0c4h,008h,000h,000h,000h,000h,0c5h,008h,000h,000h	; 5de3  ................
	defb 0c6h,008h,0c7h,008h,0c8h,008h,0c9h,008h,0cah,008h,0cbh,008h,0cch,008h,0cdh,008h	; 5df3  ................
	defb 0ceh,008h,0cfh,008h,0d0h,008h,0d1h,008h,0d2h,008h,000h,000h,000h,000h,000h,000h	; 5e03  ................
	defb 0d3h,008h,0d4h,008h,0d5h,008h,0d6h,008h,0d7h,008h,0d8h,008h,0d9h,008h,0dah,008h	; 5e13  ................
	defb 0dbh,008h,0dch,008h,0ddh,008h,0deh,008h,0dfh,008h,0e0h,008h,0e1h,008h,0e2h,008h	; 5e23  ................
	defb 0e3h,008h,0e4h,008h,0e5h,008h,0e6h,008h,000h,000h,000h,000h,000h,000h,0e7h,008h	; 5e33  ................
	defb 0e8h,008h,000h,000h,0e9h,008h,0eah,008h,0ebh,008h,0ech,008h,0edh,008h,0eeh,008h	; 5e43  ................
	defb 0efh,008h,0f0h,008h,0f1h,008h,0f2h,008h,0f3h,008h,000h,000h,000h,000h,000h,000h	; 5e53  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,080h,001h,080h,001h,060h,007h,060h,007h	; 5e63  ............`.`.
	defb 060h,007h,060h,007h,060h,007h,061h,007h,062h,007h,063h,007h,064h,007h,060h,007h	; 5e73  `.`.`.a.b.c.d.`.
	defb 065h,007h,066h,007h,000h,000h,000h,000h,080h,001h,080h,001h,060h,007h,060h,007h	; 5e83  e.f.........`.`.
	defb 067h,007h,067h,007h,067h,007h,068h,007h,069h,007h,06ah,007h,06bh,007h,067h,007h	; 5e93  g.g.g.h.i.j.k.g.
	defb 06ch,007h,06dh,007h,06eh,007h,060h,007h,06fh,007h,070h,007h,071h,007h,072h,007h	; 5ea3  l.m.n.`.o.p.q.r.
	defb 073h,007h,060h,007h,074h,007h,075h,007h,076h,007h,060h,007h,077h,007h,078h,007h	; 5eb3  s.`.t.u.v.`.w.x.
	defb 079h,007h,07ah,007h,07bh,007h,067h,007h,07ch,007h,07dh,007h,07eh,007h,07fh,007h	; 5ec3  y.z.{.g.|.}.~...
	defb 080h,007h,067h,007h,080h,001h,081h,007h,082h,007h,067h,007h,083h,007h,084h,007h	; 5ed3  ..g.......g.....
	defb 085h,007h,086h,007h,087h,007h,088h,007h,089h,007h,08ah,007h,08bh,007h,08ch,007h	; 5ee3  ................
	defb 08dh,007h,08eh,007h,08fh,007h,090h,007h,091h,007h,092h,007h,093h,007h,094h,007h	; 5ef3  ................
	defb 095h,007h,096h,007h,097h,007h,098h,007h,099h,007h,09ah,007h,09bh,007h,09ch,007h	; 5f03  ................
	defb 09dh,007h,09eh,007h,09fh,007h,0a0h,007h,0a1h,007h,0a2h,007h,0a3h,007h,0a4h,007h	; 5f13  ................
	defb 0a5h,007h,0a6h,007h,0a7h,007h,0a8h,007h,0f4h,008h,0f5h,008h,0f6h,008h,0f7h,008h	; 5f23  ................
	defb 0f8h,008h,0f9h,008h,0fah,008h,0fbh,008h,0fch,008h,0fdh,008h,0feh,008h,0ffh,008h	; 5f33  ................
	defb 000h,009h,001h,009h,002h,009h,003h,009h,004h,009h,005h,009h,006h,009h,007h,009h	; 5f43  ................
	defb 008h,009h,009h,009h,00ah,009h,00bh,009h,00ch,009h,00dh,009h,00eh,009h,00fh,009h	; 5f53  ................
	defb 010h,009h,011h,009h,012h,009h,013h,009h,014h,009h,015h,009h,016h,009h,017h,009h	; 5f63  ................
	defb 018h,009h,019h,009h,01ah,009h,01bh,009h,01ch,009h,01dh,009h,01eh,009h,01fh,009h	; 5f73  ................
	defb 020h,009h,021h,009h,022h,009h,023h,009h,024h,009h,025h,009h,026h,009h,027h,009h	; 5f83   .!.".#.$.%.&.'.
	defb 028h,009h,029h,009h,02ah,009h,02bh,009h,02ch,009h,02dh,009h,02eh,009h,02fh,009h	; 5f93  (.).*.+.,.-.../.
	defb 030h,009h,031h,009h,032h,009h,033h,009h,034h,009h,035h,009h,036h,009h,037h,009h	; 5fa3  0.1.2.3.4.5.6.7.
	defb 038h,009h,039h,009h,03ah,009h,03bh,009h,03ch,009h,03dh,009h,03eh,009h,03fh,009h	; 5fb3  8.9.:.;.<.=.>.?.
	defb 040h,009h,041h,009h,042h,009h,043h,009h,044h,009h,045h,009h,046h,009h,047h,009h	; 5fc3  @.A.B.C.D.E.F.G.
	defb 048h,009h,049h,009h,04ah,009h,04bh,009h,04ch,009h,04dh,009h,04eh,009h,04fh,009h	; 5fd3  H.I.J.K.L.M.N.O.
	defb 050h,009h,051h,009h,052h,009h,053h,009h,054h,009h,055h,009h,056h,009h,057h,009h	; 5fe3  P.Q.R.S.T.U.V.W.
	defb 058h,009h,059h,009h,05ah,009h,05bh,009h,05ch,009h,05dh,009h,05eh	; 5ff3  X.Y.Z.[.\.].^
