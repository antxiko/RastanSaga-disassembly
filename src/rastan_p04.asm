; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 04 (en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x8000..0x8002  (2 bytes)
DATA_8000:
	defb 089h,0d1h	; 8000

; ======================================================================
; CODIGO 0x8002..0x80c7  (197 bytes)
; ======================================================================


L_8002:
	ret			;8002
L_8003:
	call 07f3eh		;8003
	ld hl,(0d189h)		;8006
	dec hl			;8009
	ld (0d189h),hl		;800a
	ld a,h			;800d
	or l			;800e
	ret nz			;800f
	ld hl,0d17dh		;8010
	set 0,(hl)		;8013
	ret			;8015
L_8016:
	ld ix,0d933h		;8016
	ld a,(ix+000h)		;801a
	cp 007h		;801d
	jp z,07fdah		;801f
	ld a,(ix+006h)		;8022
	cp 000h		;8025
	jp nz,L_804A		;8027
	ld hl,00140h		;802a
	ld (0d969h),hl		;802d
	ld (ix+007h),040h		;8030
	ld (ix+006h),096h		;8034
	ld (ix+000h),001h		;8038
	ld (ix+001h),001h		;803c
	push ix		;8040
	call 07f1fh		;8042
	pop ix		;8045
	jp 07f3eh		;8047
L_804A:
	ld (ix+000h),001h		;804a
	ld hl,0d910h		;804e
	set 6,(hl)		;8051
	ld a,(0d969h)		;8053
	ld b,a			;8056
	ld a,(0d96ah)		;8057
	or b			;805a
	jp z,07fdah		;805b
	bit 0,(ix+010h)		;805e
	jp nz,L_8160		;8062
	bit 2,(ix+010h)		;8065
	jp nz,L_8219		;8069
	res 2,(ix+001h)		;806c
	res 1,(ix+001h)		;8070
	call L_811A		;8074
	cp 0ffh		;8077
	jp z,07e5ah		;8079
	call 07b29h		;807c
	and a			;807f
	call z,07e18h		;8080
	call 07d56h		;8083
	and 0f0h		;8086
	cp 020h		;8088
	jr nz,L_809A		;808a
	bit 4,(ix+010h)		;808c
	jr nz,$+80		;8090
	call 07cc6h		;8092
	cp 030h		;8095
	jp c,L_8160		;8097
L_809A:
	call L_812C		;809a
	call 07cc6h		;809d
	cp 030h		;80a0
	jr c,L_80A7		;80a2
	jp 07f3eh		;80a4
L_80A7:
	ld a,(ix+006h)		;80a7
	cp 010h		;80aa
	call c,07e18h		;80ac
	cp 0dch		;80af
	call nc,07e18h		;80b1
	call L_8146		;80b4
	ld a,(ix+006h)		;80b7
	cp 010h		;80ba
	jp c,L_8160		;80bc
	cp 0dch		;80bf
	jp nc,L_8160		;80c1
	jp 07f3eh		;80c4

; ----------------------------------------------------------------------
; DATOS sin identificar  0x80c7..0x80e0  (25 bytes)
DATA_80C7:
	defb 0ddh,036h,006h,020h,0c3h,060h,081h,0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h	; 80c7  .6. .`..........
	defb 03eh,07fh,0ddh,036h,006h,0dch,0c3h,060h,081h	; 80d7  >..6...`.

; ======================================================================
; CODIGO 0x80e0..0x81b8  (216 bytes)
; ======================================================================


L_80E0:
	call 07cc6h		;80e0
	cp 018h		;80e3
	jr c,L_80ED		;80e5
	call 07e83h		;80e7
	jp 07f3eh		;80ea
L_80ED:
	bit 7,(ix+002h)		;80ed
	jr nz,L_80FA		;80f1
	set 1,(ix+001h)		;80f3
	jp 07f3eh		;80f7
L_80FA:
	ld a,(ix+011h)		;80fa
	cp 001h		;80fd
	jr z,L_8107		;80ff
	inc (ix+011h)		;8101
	jp 07f3eh		;8104
L_8107:
	res 4,(ix+010h)		;8107
	res 1,(ix+001h)		;810b
	res 2,(ix+001h)		;810f
	ld (ix+011h),000h		;8113
	jp 07f3eh		;8117
L_811A:
	call 07d56h		;811a
	ld a,(ix+023h)		;811d
	and 0f0h		;8120
	cp 020h		;8122
	jr nz,L_8129		;8124
	ld a,000h		;8126
	ret			;8128
L_8129:
	ld a,0ffh		;8129
	ret			;812b
L_812C:
	bit 0,(ix+001h)		;812c
	jr nz,L_8142		;8130
	res 1,(ix+001h)		;8132
	res 2,(ix+001h)		;8136
	res 3,(ix+001h)		;813a
	inc (ix+006h)		;813e
	ret			;8141
L_8142:
	dec (ix+006h)		;8142
	ret			;8145
L_8146:
	bit 0,(ix+001h)		;8146
	jr nz,L_815C		;814a
	res 1,(ix+001h)		;814c
	res 2,(ix+001h)		;8150
	res 3,(ix+001h)		;8154
	dec (ix+006h)		;8158
	ret			;815b
L_815C:
	inc (ix+006h)		;815c
	ret			;815f
L_8160:
	ld a,(ix+006h)		;8160
	cp 010h		;8163
	call c,07e18h		;8165
	cp 0dch		;8168
	call nc,07e18h		;816a
	set 2,(ix+001h)		;816d
	set 4,(ix+010h)		;8171
	res 1,(ix+001h)		;8175
	set 0,(ix+010h)		;8179
	ld hl,081b8h		;817d
	bit 1,(ix+010h)		;8180
	call nz,L_81A6		;8184
	ld a,(hl)			;8187
	cp 0ffh		;8188
	jp z,L_81AD		;818a
	ld a,(ix+007h)		;818d
	ld b,(hl)			;8190
	inc hl			;8191
	sub b			;8192
	ld (ix+007h),a		;8193
	set 1,(ix+010h)		;8196
	ld (ix+015h),h		;819a
	ld (ix+014h),l		;819d
	call 07e83h		;81a0
	jp 07f3eh		;81a3
L_81A6:
	ld h,(ix+015h)		;81a6
	ld l,(ix+014h)		;81a9
	ret			;81ac
L_81AD:
	ld (ix+010h),000h		;81ad
	set 4,(ix+010h)		;81b1
	jp 07f3eh		;81b5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x81b8..0x8219  (97 bytes)
DATA_81B8:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 81b8  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 81c8  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 81d8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 81e8  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh,0ddh,0cbh	; 81f8  ................
	defb 010h,0d6h,0ddh,0cbh,010h,0e6h,0ddh,0cbh,010h,086h,0ddh,0cbh,010h,08eh,0ddh,07eh	; 8208  ...............~
	defb 006h	; 8218

; ======================================================================
; CODIGO 0x8219..0x8321  (264 bytes)
; ======================================================================


L_8219:
	ld a,(ix+006h)		;8219
	cp 010h		;821c
	call c,07e18h		;821e
	cp 0dch		;8221
	call nc,07e18h		;8223
	set 2,(ix+001h)		;8226
	res 1,(ix+001h)		;822a
	set 3,(ix+010h)		;822e
	ld hl,081b8h		;8232
	bit 2,(ix+010h)		;8235
	call nz,L_825B		;8239
	ld a,(hl)			;823c
	cp 0ffh		;823d
	jp z,L_81AD		;823f
	ld a,(ix+007h)		;8242
	ld b,(hl)			;8245
	inc hl			;8246
	sub b			;8247
	ld (ix+007h),a		;8248
	set 1,(ix+010h)		;824b
	ld (ix+015h),h		;824f
	ld (ix+014h),l		;8252
	call 07e83h		;8255
	jp 07f3eh		;8258
L_825B:
	ld h,(ix+015h)		;825b
	ld l,(ix+014h)		;825e
	ret			;8261
L_8262:
	ld ix,0d933h		;8262
	ld a,(ix+000h)		;8266
	cp 007h		;8269
	jp z,07fdah		;826b
	ld a,(ix+006h)		;826e
	cp 000h		;8271
	jp nz,L_82A0		;8273
	ld hl,00140h		;8276
	ld (0d969h),hl		;8279
	ld (ix+007h),040h		;827c
	ld (ix+006h),096h		;8280
	ld hl,0d910h		;8284
	set 6,(hl)		;8287
	ld (ix+000h),002h		;8289
	ld (ix+001h),001h		;828d
	push ix		;8291
	call 07f1fh		;8293
	pop ix		;8296
	ld a,009h		;8298
	ld (0d178h),a		;829a
	jp 07f3eh		;829d
L_82A0:
	ld (ix+000h),002h		;82a0
	ld hl,0d910h		;82a4
	set 6,(hl)		;82a7
	ld a,(0d969h)		;82a9
	ld b,a			;82ac
	ld a,(0d96ah)		;82ad
	or b			;82b0
	jp z,07fdah		;82b1
	bit 0,(ix+010h)		;82b4
	jp nz,L_8392		;82b8
	bit 2,(ix+010h)		;82bb
	jp nz,L_8434		;82bf
	res 3,(ix+001h)		;82c2
	res 2,(ix+001h)		;82c6
	res 1,(ix+001h)		;82ca
	call 07ebdh		;82ce
	cp 0ffh		;82d1
	jp z,L_8479		;82d3
	call 07b29h		;82d6
	and a			;82d9
	call z,07e18h		;82da
	call 07d56h		;82dd
	and 0f0h		;82e0
	cp 020h		;82e2
	jr nz,L_82F4		;82e4
	bit 4,(ix+010h)		;82e6
	jr nz,$+80		;82ea
	call 07cc6h		;82ec
	cp 030h		;82ef
	jp c,L_8386		;82f1
L_82F4:
	call L_812C		;82f4
	call 07cc6h		;82f7
	cp 030h		;82fa
	jr c,L_8301		;82fc
	jp 07f3eh		;82fe
L_8301:
	ld a,(ix+006h)		;8301
	cp 010h		;8304
	call c,07e18h		;8306
	cp 0dch		;8309
	call nc,07e18h		;830b
	call L_8146		;830e
	ld a,(ix+006h)		;8311
	cp 010h		;8314
	jp c,L_8386		;8316
	cp 0dch		;8319
	jp nc,L_8386		;831b
	jp 07f3eh		;831e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8321..0x833a  (25 bytes)
DATA_8321:
	defb 0ddh,036h,006h,020h,0c3h,086h,083h,0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h	; 8321  .6. ............
	defb 03eh,07fh,0ddh,036h,006h,0dch,0c3h,086h,083h	; 8331  >..6.....

; ======================================================================
; CODIGO 0x833a..0x83e6  (172 bytes)
; ======================================================================


L_833A:
	call 07cc6h		;833a
	cp 008h		;833d
	jr c,L_8359		;833f
	ld a,(ix+013h)		;8341
	inc a			;8344
	ld (ix+013h),a		;8345
	cp 003h		;8348
	jr z,L_834F		;834a
	jp 07f3eh		;834c
L_834F:
	ld (ix+013h),000h		;834f
	call 07e83h		;8353
	jp 07f3eh		;8356
L_8359:
	bit 7,(ix+002h)		;8359
	jr nz,L_8366		;835d
	set 1,(ix+001h)		;835f
	jp 07f3eh		;8363
L_8366:
	ld a,(ix+011h)		;8366
	cp 002h		;8369
	jr z,L_8373		;836b
	inc (ix+011h)		;836d
	jp 07f3eh		;8370
L_8373:
	res 4,(ix+010h)		;8373
	res 1,(ix+001h)		;8377
	res 2,(ix+001h)		;837b
	ld (ix+011h),000h		;837f
	jp 07f3eh		;8383
L_8386:
	call 07b29h		;8386
	and a			;8389
	call z,07e18h		;838a
	ld a,009h		;838d
	ld (0d178h),a		;838f
L_8392:
	ld a,(ix+006h)		;8392
	cp 010h		;8395
	call c,07e18h		;8397
	cp 0dch		;839a
	call nc,07e18h		;839c
	set 3,(ix+001h)		;839f
	set 4,(ix+010h)		;83a3
	set 0,(ix+010h)		;83a7
	ld hl,083e6h		;83ab
	bit 1,(ix+010h)		;83ae
	call nz,L_83D4		;83b2
	ld a,(hl)			;83b5
	cp 0ffh		;83b6
	jp z,L_83DB		;83b8
	ld a,(ix+007h)		;83bb
	ld b,(hl)			;83be
	inc hl			;83bf
	sub b			;83c0
	ld (ix+007h),a		;83c1
	set 1,(ix+010h)		;83c4
	ld (ix+015h),h		;83c8
	ld (ix+014h),l		;83cb
	call 07e83h		;83ce
	jp 07f3eh		;83d1
L_83D4:
	ld h,(ix+015h)		;83d4
	ld l,(ix+014h)		;83d7
	ret			;83da
L_83DB:
	ld (ix+010h),000h		;83db
	set 4,(ix+010h)		;83df
	jp 07f3eh		;83e3

; ----------------------------------------------------------------------
; DATOS sin identificar  0x83e6..0x8434  (78 bytes)
DATA_83E6:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 83e6  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 83f6  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 8406  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 8416  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh	; 8426  ..............

; ======================================================================
; CODIGO 0x8434..0x8546  (274 bytes)
; ======================================================================


L_8434:
	ld a,(ix+006h)		;8434
	cp 010h		;8437
	call c,07e18h		;8439
	cp 0dch		;843c
	call nc,07e18h		;843e
	set 3,(ix+001h)		;8441
	set 3,(ix+010h)		;8445
	ld hl,083e6h		;8449
	bit 2,(ix+010h)		;844c
	call nz,L_8472		;8450
	ld a,(hl)			;8453
	cp 0ffh		;8454
	jp z,L_83DB		;8456
	ld a,(ix+007h)		;8459
	ld b,(hl)			;845c
	inc hl			;845d
	sub b			;845e
	ld (ix+007h),a		;845f
	set 1,(ix+010h)		;8462
	ld (ix+015h),h		;8466
	ld (ix+014h),l		;8469
	call 07e83h		;846c
	jp 07f3eh		;846f
L_8472:
	ld h,(ix+015h)		;8472
	ld l,(ix+014h)		;8475
	ret			;8478
L_8479:
	ld a,(ix+007h)		;8479
	inc a			;847c
	inc a			;847d
	ld (ix+007h),a		;847e
	ld a,(ix+001h)		;8481
	and 001h		;8484
	or 008h		;8486
	ld (ix+001h),a		;8488
	jp 07f3eh		;848b
L_848E:
	ld ix,0d933h		;848e
	ld a,(ix+000h)		;8492
	cp 007h		;8495
	jp z,07fdah		;8497
	ld a,(ix+006h)		;849a
	cp 000h		;849d
	jp nz,L_84C7		;849f
	ld hl,000a0h		;84a2
	ld (0d969h),hl		;84a5
	ld (ix+007h),030h		;84a8
	ld (ix+006h),096h		;84ac
	ld hl,0d910h		;84b0
	set 6,(hl)		;84b3
	ld (ix+000h),003h		;84b5
	ld (ix+001h),001h		;84b9
	push ix		;84bd
	call 07f1fh		;84bf
	pop ix		;84c2
	jp 07f3eh		;84c4
L_84C7:
	ld (ix+000h),003h		;84c7
	ld hl,0d910h		;84cb
	set 6,(hl)		;84ce
	ld a,(0d969h)		;84d0
	ld b,a			;84d3
	ld a,(0d96ah)		;84d4
	or b			;84d7
	jp z,07fdah		;84d8
	ld a,(0d96bh)		;84db
	and a			;84de
	jp nz,L_877F		;84df
L_84E2:
	ld a,(0d9e0h)		;84e2
	cp 00fh		;84e5
	push af			;84e7
	call z,L_8669		;84e8
	pop af			;84eb
	jp z,07f3eh		;84ec
	bit 1,(ix+001h)		;84ef
	call nz,L_8669		;84f3
	call L_811A		;84f6
	cp 0ffh		;84f9
	call z,L_8664		;84fb
	jp z,07e5ah		;84fe
	call 07b29h		;8501
	and a			;8504
	call z,07e18h		;8505
	bit 0,(ix+012h)		;8508
	jp nz,L_858B		;850c
	bit 1,(ix+001h)		;850f
	jp nz,L_85AD		;8513
	res 7,(ix+014h)		;8516
L_851A:
	ld a,(ix+006h)		;851a
	cp 014h		;851d
	jp c,L_85D3		;851f
	cp 040h		;8522
	jp z,L_85F8		;8524
	cp 0a8h		;8527
	jp z,L_861D		;8529
	cp 0c8h		;852c
	jp nc,L_863F		;852e
	call 07cc6h		;8531
	cp 030h		;8534
	jr c,L_853E		;8536
	call L_856A		;8538
	jp 07f3eh		;853b
L_853E:
	cp 030h		;853e
	call c,L_855C		;8540
	jp 07f3eh		;8543

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8546..0x855c  (22 bytes)
DATA_8546:
	defb 0ddh,036h,006h,0d1h,0ddh,036h,007h,050h,0c3h,03eh,07fh,0ddh,036h,006h,011h,0ddh	; 8546  .6...6.P.>..6...
	defb 036h,007h,050h,0c3h,03eh,07fh	; 8556

; ======================================================================
; CODIGO 0x855c..0x8578  (28 bytes)
; ======================================================================


L_855C:
	bit 0,(ix+001h)		;855c
	jr z,L_8566		;8560
	inc (ix+006h)		;8562
	ret			;8565
L_8566:
	dec (ix+006h)		;8566
	ret			;8569
L_856A:
	bit 0,(ix+001h)		;856a
	jr z,L_8574		;856e
	dec (ix+006h)		;8570
	ret			;8573
L_8574:
	inc (ix+006h)		;8574
	ret			;8577

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8578..0x858b  (19 bytes)
DATA_8578:
	defb 0ddh,0cbh,001h,0ceh,0c3h,03eh,07fh,03ah,0f4h,0d8h,0cbh,06fh,020h,002h,0afh,0c9h	; 8578  .....>.:...o ...
	defb 03eh,0ffh,0c9h	; 8588

; ======================================================================
; CODIGO 0x858b..0x86a2  (279 bytes)
; ======================================================================


L_858B:
	ld a,(0d9e0h)		;858b
	cp 00fh		;858e
	jp z,L_8767		;8590
	set 1,(ix+001h)		;8593
	res 0,(ix+012h)		;8597
	set 0,(ix+010h)		;859b
	push ix		;859f
	call 07f3eh		;85a1
	pop ix		;85a4
	ld a,(0d9e0h)		;85a6
	and a			;85a9
	jp z,L_8669		;85aa
L_85AD:
	bit 7,(ix+002h)		;85ad
	jr nz,L_85B6		;85b1
	jp 07f3eh		;85b3
L_85B6:
	ld a,(ix+011h)		;85b6
	inc a			;85b9
	cp 001h		;85ba
	jr z,L_85C4		;85bc
	ld (ix+011h),a		;85be
	jp 07f3eh		;85c1
L_85C4:
	ld (ix+011h),000h		;85c4
	res 0,(ix+010h)		;85c8
	res 1,(ix+001h)		;85cc
	jp 07f3eh		;85d0
L_85D3:
	ld (ix+014h),000h		;85d3
	ld a,008h		;85d7
	ld (0d178h),a		;85d9
	call 044deh		;85dc
	jp po,L_85ED		;85df
	ld (ix+006h),0c7h		;85e2
	ld (ix+007h),032h		;85e6
	jp 07f3eh		;85ea
L_85ED:
	ld (ix+006h),0a7h		;85ed
	ld (ix+007h),032h		;85f1
	jp 07f3eh		;85f5
L_85F8:
	ld (ix+014h),000h		;85f8
	ld a,008h		;85fc
	ld (0d178h),a		;85fe
	call 044deh		;8601
	jp po,L_8612		;8604
	ld (ix+006h),0a7h		;8607
	ld (ix+007h),032h		;860b
	jp 07f3eh		;860f
L_8612:
	ld (ix+006h),0c7h		;8612
	ld (ix+007h),032h		;8616
	jp 07f3eh		;861a
L_861D:
	ld (ix+014h),000h		;861d
	ld a,008h		;8621
	ld (0d178h),a		;8623
	jp po,L_8634		;8626
	ld (ix+006h),0a7h		;8629
	ld (ix+007h),032h		;862d
	jp 07f3eh		;8631
L_8634:
	ld (ix+006h),015h		;8634
	ld (ix+007h),032h		;8638
	jp 07f3eh		;863c
L_863F:
	ld (ix+014h),000h		;863f
	ld a,008h		;8643
	ld (0d178h),a		;8645
	call 044deh		;8648
	jp po,L_8659		;864b
	ld (ix+006h),015h		;864e
	ld (ix+006h),032h		;8652
	jp 07f3eh		;8656
L_8659:
	ld (ix+006h),041h		;8659
	ld (ix+007h),032h		;865d
	jp 07f3eh		;8661
L_8664:
	set 0,(ix+012h)		;8664
	ret			;8668
L_8669:
	push ix		;8669
	push ix		;866b
	pop iy		;866d
	ld ix,0d9cbh		;866f
	ld a,(ix+015h)		;8673
	cp 000h		;8676
	jp z,L_8682		;8678
	cp 00fh		;867b
	jr z,L_8699		;867d
	jp L_8743		;867f
L_8682:
	bit 7,(iy+002h)		;8682
	jp z,L_8696		;8686
	ld (ix+015h),00fh		;8689
	call L_86AC		;868d
	call 048f9h		;8690
	call 04a8bh		;8693
L_8696:
	pop ix		;8696
	ret			;8698
L_8699:
	jp L_86E4		;8699
L_869C:
	call 04a8bh		;869c
	pop ix		;869f
	ret			;86a1

; ----------------------------------------------------------------------
; DATOS sin identificar  0x86a2..0x86ac  (10 bytes)
DATA_86A2:
	defb 0ddh,036h,015h,000h,0cdh,010h,04bh,0ddh,0e1h,0c9h	; 86a2  .6....K...

; ======================================================================
; CODIGO 0x86ac..0x876e  (194 bytes)
; ======================================================================


L_86AC:
	ld (ix+001h),00dh		;86ac
	ld a,(iy+001h)		;86b0
	ld (ix+013h),a		;86b3
	bit 0,(iy+001h)		;86b6
	jr z,L_86CA		;86ba
	set 0,(ix+012h)		;86bc
	ld a,(iy+006h)		;86c0
	sub 008h		;86c3
	ld (ix+006h),a		;86c5
	jr L_86D6		;86c8
L_86CA:
	res 0,(ix+001h)		;86ca
	ld a,(iy+006h)		;86ce
	add a,018h		;86d1
	ld (ix+006h),a		;86d3
L_86D6:
	ld a,(iy+007h)		;86d6
	add a,010h		;86d9
	ld (ix+007h),a		;86db
	ld a,016h		;86de
	ld (ix+000h),a		;86e0
	ret			;86e3
L_86E4:
	call 07d56h		;86e4
	ld a,(ix+020h)		;86e7
	and 0f0h		;86ea
	cp 020h		;86ec
	jp z,L_872E		;86ee
	ld a,(0d8fch)		;86f1
	add a,018h		;86f4
	ld c,a			;86f6
	bit 0,(ix+013h)		;86f7
	jr z,L_8713		;86fb
	call 06affh		;86fd
	and a			;8700
	jp z,L_872E		;8701
	ld a,(ix+006h)		;8704
	dec a			;8707
	dec a			;8708
	cp 004h		;8709
	jp c,L_872E		;870b
	ld (ix+006h),a		;870e
	jr L_872B		;8711
L_8713:
	res 0,(ix+001h)		;8713
	call 06b2ch		;8717
	and a			;871a
	jp z,L_872E		;871b
	ld a,(ix+006h)		;871e
	inc a			;8721
	inc a			;8722
	cp 0f0h		;8723
	jp nc,L_872E		;8725
	ld (ix+006h),a		;8728
L_872B:
	jp L_869C		;872b
L_872E:
	ld ix,0d9cbh		;872e
	ld (ix+015h),0f1h		;8732
	push ix		;8736
	call 04a8bh		;8738
	pop ix		;873b
	call 04b10h		;873d
	pop ix		;8740
	ret			;8742
L_8743:
	bit 7,(ix+002h)		;8743
	jr nz,L_8756		;8747
	push ix		;8749
	call 04a8bh		;874b
	pop ix		;874e
	call 04b10h		;8750
	pop ix		;8753
	ret			;8755
L_8756:
	ld (ix+015h),000h		;8756
	push ix		;875a
	call 04a8bh		;875c
	pop ix		;875f
	call 04b10h		;8761
	pop ix		;8764
	ret			;8766
L_8767:
	res 1,(ix+001h)		;8767
	jp 07f3eh		;876b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x876e..0x877f  (17 bytes)
DATA_876E:
	defb 0ddh,07eh,014h,03ch,0feh,002h,028h,004h,0ddh,077h,014h,0c9h,0ddh,0cbh,014h,0feh	; 876e  .~.<..(..w......
	defb 0c9h	; 877e

; ======================================================================
; CODIGO 0x877f..0x884f  (208 bytes)
; ======================================================================


L_877F:
	xor a			;877f
	ld (0d96bh),a		;8780
	ld a,(ix+015h)		;8783
	inc a			;8786
	cp 001h		;8787
	jp z,L_8792		;8789
	ld (ix+015h),a		;878c
	jp L_84E2		;878f
L_8792:
	xor a			;8792
	ld (ix+015h),a		;8793
	jp L_851A		;8796
L_8799:
	ld ix,0d933h		;8799
	ld a,(ix+000h)		;879d
	cp 007h		;87a0
	jp z,07fdah		;87a2
	ld a,(ix+006h)		;87a5
	cp 000h		;87a8
	jp nz,L_87D2		;87aa
	ld hl,00140h		;87ad
	ld (0d969h),hl		;87b0
	ld (ix+007h),030h		;87b3
	ld (ix+006h),096h		;87b7
	ld hl,0d910h		;87bb
	set 6,(hl)		;87be
	ld (ix+000h),004h		;87c0
	ld (ix+001h),001h		;87c4
	push ix		;87c8
	call 07f1fh		;87ca
	pop ix		;87cd
	jp 07f3eh		;87cf
L_87D2:
	ld (ix+000h),004h		;87d2
	ld hl,0d910h		;87d6
	set 6,(hl)		;87d9
	ld a,(0d969h)		;87db
	ld b,a			;87de
	ld a,(0d96ah)		;87df
	or b			;87e2
	jp z,07fdah		;87e3
	bit 0,(ix+010h)		;87e6
	jp nz,L_88B5		;87ea
	bit 2,(ix+010h)		;87ed
	jp nz,L_8976		;87f1
	res 2,(ix+001h)		;87f4
	res 1,(ix+001h)		;87f8
	call L_811A		;87fc
	cp 0ffh		;87ff
	jp z,07e5ah		;8801
	call 07b29h		;8804
	and a			;8807
	call z,07e18h		;8808
	call 07d56h		;880b
	and 0f0h		;880e
	cp 020h		;8810
	jr nz,L_8822		;8812
	bit 4,(ix+010h)		;8814
	jr nz,$+73		;8818
	call 07cc6h		;881a
	cp 030h		;881d
	jp c,L_88B5		;881f
L_8822:
	call L_812C		;8822
	call 07cc6h		;8825
	cp 030h		;8828
	jr c,L_882F		;882a
	jp 07f3eh		;882c
L_882F:
	ld a,(ix+006h)		;882f
	cp 010h		;8832
	call c,07e18h		;8834
	cp 0dch		;8837
	call nc,07e18h		;8839
	call L_8146		;883c
	ld a,(ix+006h)		;883f
	cp 010h		;8842
	jp c,L_88AD		;8844
	cp 0dch		;8847
	jp nc,L_88AD		;8849
	jp 07f3eh		;884c

; ----------------------------------------------------------------------
; DATOS sin identificar  0x884f..0x8861  (18 bytes)
DATA_884F:
	defb 0ddh,036h,006h,020h,0c3h,0adh,088h,0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h	; 884f  .6. ............
	defb 03eh,07fh	; 885f

; ======================================================================
; CODIGO 0x8861..0x8915  (180 bytes)
; ======================================================================


L_8861:
	call 07cc6h		;8861
	cp 010h		;8864
	jr c,L_8880		;8866
	ld a,(ix+013h)		;8868
	inc a			;886b
	ld (ix+013h),a		;886c
	cp 003h		;886f
	jr z,L_8876		;8871
	jp 07f3eh		;8873
L_8876:
	ld (ix+013h),000h		;8876
	call 07e83h		;887a
	jp 07f3eh		;887d
L_8880:
	bit 7,(ix+002h)		;8880
	jr nz,L_888D		;8884
	set 1,(ix+001h)		;8886
	jp 07f3eh		;888a
L_888D:
	ld a,(ix+011h)		;888d
	cp 002h		;8890
	jr z,L_889A		;8892
	inc (ix+011h)		;8894
	jp 07f3eh		;8897
L_889A:
	res 4,(ix+010h)		;889a
	res 1,(ix+001h)		;889e
	res 2,(ix+001h)		;88a2
	ld (ix+011h),000h		;88a6
	jp 07f3eh		;88aa
L_88AD:
	ld a,(0d8f4h)		;88ad
	bit 5,a		;88b0
	jp nz,L_8963		;88b2
L_88B5:
	ld a,(ix+006h)		;88b5
	cp 010h		;88b8
	call c,07e18h		;88ba
	cp 0dch		;88bd
	call nc,07e18h		;88bf
	set 2,(ix+001h)		;88c2
	set 4,(ix+010h)		;88c6
	res 1,(ix+001h)		;88ca
	set 0,(ix+010h)		;88ce
	ld hl,08915h		;88d2
	bit 1,(ix+010h)		;88d5
	call nz,L_8903		;88d9
	ld a,(hl)			;88dc
	cp 0ffh		;88dd
	jp z,L_890A		;88df
	ld a,(ix+007h)		;88e2
	ld b,(hl)			;88e5
	inc hl			;88e6
	sub b			;88e7
	ld (ix+007h),a		;88e8
	set 1,(ix+010h)		;88eb
	ld (ix+015h),h		;88ef
	ld (ix+014h),l		;88f2
	ld a,(ix+006h)		;88f5
	cp 010h		;88f8
	jp c,L_89C7		;88fa
	call 07e83h		;88fd
	jp 07f3eh		;8900
L_8903:
	ld h,(ix+015h)		;8903
	ld l,(ix+014h)		;8906
	ret			;8909
L_890A:
	ld (ix+010h),000h		;890a
	set 4,(ix+010h)		;890e
	jp 07f3eh		;8912

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8915..0x8963  (78 bytes)
DATA_8915:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 8915  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 8925  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 8935  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 8945  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh	; 8955  ..............

; ======================================================================
; CODIGO 0x8963..0x8a9a  (311 bytes)
; ======================================================================


L_8963:
	set 2,(ix+010h)		;8963
	set 4,(ix+010h)		;8967
	res 0,(ix+010h)		;896b
	res 1,(ix+010h)		;896f
	ld a,(ix+006h)		;8973
L_8976:
	ld a,(ix+006h)		;8976
	cp 010h		;8979
	call c,07e18h		;897b
	cp 0dch		;897e
	call nc,07e18h		;8980
	set 2,(ix+001h)		;8983
	res 1,(ix+001h)		;8987
	set 3,(ix+010h)		;898b
	ld hl,081b8h		;898f
	bit 2,(ix+010h)		;8992
	call nz,L_89C0		;8996
	ld a,(hl)			;8999
	cp 0ffh		;899a
	jp z,L_890A		;899c
	ld a,(ix+007h)		;899f
	ld b,(hl)			;89a2
	inc hl			;89a3
	sub b			;89a4
	ld (ix+007h),a		;89a5
	set 1,(ix+010h)		;89a8
	ld (ix+015h),h		;89ac
	ld (ix+014h),l		;89af
	ld a,(ix+006h)		;89b2
	cp 010h		;89b5
	call c,07e18h		;89b7
	call 07e83h		;89ba
	jp 07f3eh		;89bd
L_89C0:
	ld h,(ix+015h)		;89c0
	ld l,(ix+014h)		;89c3
	ret			;89c6
L_89C7:
	ld (ix+006h),011h		;89c7
	jp 07f3eh		;89cb
L_89CE:
	ld ix,0d933h		;89ce
	ld a,(ix+000h)		;89d2
	cp 007h		;89d5
	jp z,07fdah		;89d7
	ld a,(ix+006h)		;89da
	and a			;89dd
	jp nz,L_8A06		;89de
	ld hl,00190h		;89e1
	ld (0d969h),hl		;89e4
	ld (ix+007h),050h		;89e7
	ld (ix+006h),096h		;89eb
	ld hl,0d910h		;89ef
	set 6,(hl)		;89f2
	ld (ix+000h),005h		;89f4
	ld (ix+001h),001h		;89f8
	push ix		;89fc
	call 07f1fh		;89fe
	pop ix		;8a01
	jp 07f3eh		;8a03
L_8A06:
	ld (ix+000h),005h		;8a06
	ld hl,0d910h		;8a0a
	set 6,(hl)		;8a0d
	ld a,(0d969h)		;8a0f
	ld b,a			;8a12
	ld a,(0d96ah)		;8a13
	or b			;8a16
	jp z,07fdah		;8a17
	ld a,(0d9bah)		;8a1a
	cp 00fh		;8a1d
	call z,L_8B6B		;8a1f
	bit 2,(ix+001h)		;8a22
	call z,L_8B6B		;8a26
	call L_811A		;8a29
	cp 0ffh		;8a2c
	jp z,07e5ah		;8a2e
	ld a,(0d96bh)		;8a31
	and a			;8a34
	jp nz,L_8B55		;8a35
	ld a,(ix+006h)		;8a38
	cp 020h		;8a3b
	call c,07e18h		;8a3d
	cp 0b4h		;8a40
	call nc,07e18h		;8a42
	call L_8B19		;8a45
	cp 048h		;8a48
	call z,L_8A5B		;8a4a
	ld a,(ix+001h)		;8a4d
	and 001h		;8a50
	ld (ix+001h),a		;8a52
	call L_856A		;8a55
	jp 07f3eh		;8a58
L_8A5B:
	ld a,(0d9bah)		;8a5b
	cp 00fh		;8a5e
	jp z,07f3eh		;8a60
	ld a,00fh		;8a63
	ld (0d178h),a		;8a65
	ld a,(ix+001h)		;8a68
	and 001h		;8a6b
	or 002h		;8a6d
	ld (ix+001h),a		;8a6f
	set 0,(ix+010h)		;8a72
	push ix		;8a76
	call 07f3eh		;8a78
	pop ix		;8a7b
	ld a,(0d9bah)		;8a7d
	and a			;8a80
	jp z,L_8B6B		;8a81
	ld a,00eh		;8a84
	ld (0d178h),a		;8a86
	ld a,(ix+001h)		;8a89
	and 001h		;8a8c
	or 006h		;8a8e
	ld (ix+001h),a		;8a90
	set 1,(ix+010h)		;8a93
	jp 07f3eh		;8a97

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a9a..0x8b19  (127 bytes)
DATA_8A9A:
	defb 0ddh,07eh,006h,0feh,020h,0dch,018h,07eh,0feh,0b4h,0d4h,018h,07eh,0ddh,0cbh,002h	; 8a9a  .~.. ..~....~...
	defb 07eh,020h,00eh,0ddh,0e5h,0cdh,03eh,07fh,0ddh,0e1h,03ah,0bah,0d9h,0a7h,0cah,06bh	; 8aaa  ~ ....>...:....k
	defb 08bh,0ddh,07eh,011h,03ch,0feh,002h,028h,006h,0ddh,077h,011h,0c3h,03eh,07fh,0ddh	; 8aba  ..~.<..(..w..>..
	defb 036h,011h,000h,0ddh,07eh,001h,0e6h,001h,0ddh,077h,001h,0ddh,036h,010h,000h,0cdh	; 8aca  6...~....w..6...
	defb 06ah,085h,0c3h,03eh,07fh,0ddh,07eh,006h,0feh,020h,0dch,018h,07eh,0feh,0b4h,0d4h	; 8ada  j..>..~.. ..~...
	defb 018h,07eh,0ddh,0cbh,002h,07eh,020h,003h,0c3h,03eh,07fh,0ddh,07eh,011h,03ch,0feh	; 8aea  .~...~ ..>..~.<.
	defb 002h,028h,006h,0ddh,077h,011h,0c3h,03eh,07fh,0ddh,036h,011h,000h,0ddh,07eh,001h	; 8afa  .(..w..>..6...~.
	defb 0e6h,001h,0ddh,077h,001h,0ddh,036h,010h,000h,0cdh,06ah,085h,0c3h,03eh,07fh	; 8b0a  ...w..6...j..>.

; ======================================================================
; CODIGO 0x8b19..0x8b31  (24 bytes)
; ======================================================================


L_8B19:
	ld a,(0d8fch)		;8b19
	add a,010h		;8b1c
	ld b,a			;8b1e
	ld a,(ix+006h)		;8b1f
	add a,018h		;8b22
	ld c,a			;8b24
	bit 0,(ix+001h)		;8b25
	jr z,L_8B2E		;8b29
	ld a,c			;8b2b
	sub b			;8b2c
	ret			;8b2d
L_8B2E:
	ld a,b			;8b2e
	sub c			;8b2f
	ret			;8b30

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8b31..0x8b55  (36 bytes)
DATA_8B31:
	defb 0ddh,07eh,006h,0c6h,018h,047h,03ah,0fch,0d8h,0c6h,010h,04fh,0ddh,0cbh,001h,046h	; 8b31  .~...G:....O...F
	defb 028h,009h,078h,091h,038h,002h,0afh,0c9h,03eh,0ffh,0c9h,079h,090h,038h,002h,0afh	; 8b41  (.x.8...>..y.8..
	defb 0c9h,03eh,0ffh,0c9h	; 8b51

; ======================================================================
; CODIGO 0x8b55..0x8bcf  (122 bytes)
; ======================================================================


L_8B55:
	ld a,00eh		;8b55
	ld (0d178h),a		;8b57
	xor a			;8b5a
	ld (0d96bh),a		;8b5b
	ld a,(ix+001h)		;8b5e
	and 001h		;8b61
	or 006h		;8b63
	ld (ix+001h),a		;8b65
	jp 07f3eh		;8b68
L_8B6B:
	push ix		;8b6b
	push ix		;8b6d
	pop iy		;8b6f
	ld ix,0d9a5h		;8b71
	ld a,(ix+015h)		;8b75
	and a			;8b78
	jr z,L_8B80		;8b79
	cp 00fh		;8b7b
	jp 06a29h		;8b7d
L_8B80:
	bit 7,(iy+002h)		;8b80
	jp z,069e3h		;8b84
	ld (ix+015h),00fh		;8b87
	call L_8BA1		;8b8b
	ld hl,08bcfh		;8b8e
	ld (0d9b5h),hl		;8b91
	push ix		;8b94
	call 048f9h		;8b96
	pop ix		;8b99
	call 04a8bh		;8b9b
	pop ix		;8b9e
	ret			;8ba0
L_8BA1:
	ld a,(iy+001h)		;8ba1
	ld (ix+012h),a		;8ba4
	bit 0,(iy+001h)		;8ba7
	jr z,L_8BB7		;8bab
	ld a,(iy+006h)		;8bad
	sub 020h		;8bb0
	ld (ix+006h),a		;8bb2
	jr L_8BBF		;8bb5
L_8BB7:
	ld a,(iy+006h)		;8bb7
	add a,040h		;8bba
	ld (ix+006h),a		;8bbc
L_8BBF:
	ld a,(iy+007h)		;8bbf
	ld (ix+007h),a		;8bc2
	ld a,016h		;8bc5
	ld (ix+000h),a		;8bc7
	set 3,(ix+001h)		;8bca
	ret			;8bce

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8bcf..0x8bf4  (37 bytes)
DATA_8BCF:
	defb 000h,000h,000h,002h,001h,002h,000h,002h,000h,002h,001h,002h,002h,002h,002h,002h	; 8bcf  ................
	defb 002h,002h,000h,002h,002h,002h,002h,002h,001h,002h,000h,002h,001h,002h,000h,002h	; 8bdf  ................
	defb 002h,002h,002h,002h,0ffh	; 8bef

; ======================================================================
; CODIGO 0x8bf4..0x8d01  (269 bytes)
; ======================================================================


L_8BF4:
	ld a,(0d5f0h)		;8bf4
	cp 005h		;8bf7
	jp nz,06021h		;8bf9
	ld a,(0d5f1h)		;8bfc
	and a			;8bff
	jp nz,06021h		;8c00
	jp L_8016		;8c03
L_8C06:
	ld a,(0d5f0h)		;8c06
	cp 004h		;8c09
	jp nz,06026h		;8c0b
	ld a,(0d5f1h)		;8c0e
	and a			;8c11
	jp nz,06026h		;8c12
	jp L_8262		;8c15
L_8C18:
	ld a,(0d5f0h)		;8c18
	cp 005h		;8c1b
	jp nz,0602bh		;8c1d
	ld a,(0d5f1h)		;8c20
	and a			;8c23
	jp nz,0602bh		;8c24
	jp L_848E		;8c27
L_8C2A:
	ld a,(0d5f0h)		;8c2a
	cp 005h		;8c2d
	jp nz,06030h		;8c2f
	ld a,(0d5f1h)		;8c32
	dec a			;8c35
	jp nz,06030h		;8c36
	jp L_8799		;8c39
L_8C3C:
	ld a,(0d5f0h)		;8c3c
	cp 003h		;8c3f
	jp nz,06035h		;8c41
	ld a,(0d5f1h)		;8c44
	and a			;8c47
	jp nz,06035h		;8c48
	jp L_89CE		;8c4b
L_8C4E:
	ld a,005h		;8c4e
	ld (0d17ah),a		;8c50
	call 0431fh		;8c53
	xor a			;8c56
	ld (0d933h),a		;8c57
	ld (0d934h),a		;8c5a
	ld (0d935h),a		;8c5d
	ld c,008h		;8c60
	ld b,02ah		;8c62
	call 00047h		;8c64   ; BIOS WRTVDP - Writes data in the VDP-register
L_8C67:
	ld hl,01f40h		;8c67
L_8C6A:
	dec hl			;8c6a
	ld a,h			;8c6b
	or l			;8c6c
	jr nz,L_8C6A		;8c6d
	call L_8C9D		;8c6f
	call L_8CC4		;8c72
	call 00044h		;8c75   ; BIOS ENASCR - Displays the screen
	ld a,(0d935h)		;8c78
	cp 0ffh		;8c7b
	jr nz,L_8C67		;8c7d
	ld hl,05227h		;8c7f
	ld de,00000h		;8c82
	ld b,010h		;8c85
	ld c,050h		;8c87
	ld a,0aah		;8c89
	ld (0d5d7h),a		;8c8b
	ld a,058h		;8c8e
	ld (0d5d6h),a		;8c90
	exx			;8c93
	ld b,000h		;8c94
	exx			;8c96
	call 046c9h		;8c97
L_8C9A:
	jp L_8C9A		;8c9a
L_8C9D:
	di			;8c9d
	call 0445dh		;8c9e
	ld a,(0d933h)		;8ca1
	inc a			;8ca4
	ld (0d933h),a		;8ca5
	ld b,a			;8ca8
	ld a,(00007h)		;8ca9
	inc a			;8cac
	ld c,a			;8cad
	ld a,b			;8cae
	out (c),a		;8caf
	ld a,097h		;8cb1
	out (c),a		;8cb3
	ei			;8cb5
	ld a,(0d933h)		;8cb6
	ld l,a			;8cb9
	ld e,a			;8cba
	ld h,000h		;8cbb
	ld d,0feh		;8cbd
	xor a			;8cbf
	call 0440eh		;8cc0
	ret			;8cc3
L_8CC4:
	ld a,(0d933h)		;8cc4
	and 00fh		;8cc7
	ret nz			;8cc9
	ld hl,08d01h		;8cca
	ld a,(0d934h)		;8ccd
	inc a			;8cd0
	ld (0d934h),a		;8cd1
	dec a			;8cd4
	add a,a			;8cd5
	ld e,a			;8cd6
	ld d,000h		;8cd7
	add hl,de			;8cd9
	ld e,(hl)			;8cda
	inc hl			;8cdb
	ld d,(hl)			;8cdc
	ex de,hl			;8cdd
	ld a,(hl)			;8cde
	cp 0feh		;8cdf
	ret z			;8ce1
	cp 0ffh		;8ce2
	jr nz,L_8CEA		;8ce4
	ld (0d935h),a		;8ce6
	ret			;8ce9
L_8CEA:
	ld c,a			;8cea
	inc hl			;8ceb
	ld a,(0d933h)		;8cec
	sub 010h		;8cef
	ld b,a			;8cf1
	ld (0d5dbh),bc		;8cf2
L_8CF6:
	ld a,(hl)			;8cf6
	and a			;8cf7
	ret z			;8cf8
	push hl			;8cf9
	call 04633h		;8cfa
	pop hl			;8cfd
	inc hl			;8cfe
	jr L_8CF6		;8cff

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d01..0xa000  (4863 bytes)
DATA_8D01:
	defb 06dh,08dh,07eh,08dh,07fh,08dh,080h,08dh,081h,08dh,082h,08dh,081h,08dh,081h,08dh	; 8d01  m.~.............
	defb 089h,08dh,095h,08dh,0a4h,08dh,0aeh,08dh,0bah,08dh,0c4h,08dh,0c5h,08dh,0d5h,08dh	; 8d11  ................
	defb 0e1h,08dh,0e2h,08dh,0edh,08dh,0f9h,08dh,007h,08eh,008h,08eh,00fh,08eh,020h,08eh	; 8d21  .............. .
	defb 02fh,08eh,030h,08eh,03ah,08eh,047h,08eh,048h,08eh,05bh,08eh,064h,08eh,065h,08eh	; 8d31  /.0.:.G.H.[.d.e.
	defb 066h,08eh,067h,08eh,068h,08eh,069h,08eh,06ah,08eh,06bh,08eh,06ch,08eh,06dh,08eh	; 8d41  f.g.h.i.j.k.l.m.
	defb 06eh,08eh,06fh,08eh,07ch,08eh,07dh,08eh,07eh,08eh,07fh,08eh,080h,08eh,09ah,08eh	; 8d51  n.o.|.}.~.......
	defb 0afh,08eh,0b0h,08eh,0b1h,08eh,0b2h,08eh,0b3h,08eh,0b4h,08eh,040h,043h,04fh,04eh	; 8d61  ............@CON
	defb 047h,052h,041h,054h,055h,052h,041h,054h,049h,04fh,04eh,053h,000h,0feh,0feh,0feh	; 8d71  GRATURATIONS....
	defb 0feh,078h,053h,054h,041h,046h,046h,000h,038h,050h,052h,04fh,047h,052h,041h,04dh	; 8d81  .xSTAFF.8PROGRAM
	defb 04dh,045h,052h,000h,060h,04eh,020h,053h,041h,04eh,054h,041h,020h,053h,041h,054h	; 8d91  MER.`N SANTA SAT
	defb 04fh,055h,000h,060h,054h,045h,044h,020h,041h,04fh,04eh,04fh,000h,060h,04dh,020h	; 8da1  OU.`TED AONO.`M
	defb 04dh,020h,041h,054h,053h,055h,04ah,049h,000h,060h,04bh,020h,048h,020h,04bh,055h	; 8db1  M ATSUJI.`K H KU
	defb 04dh,045h,000h,0feh,038h,043h,04fh,04eh,056h,045h,052h,054h,020h,044h,045h,053h	; 8dc1  ME..8CONVERT DES
	defb 049h,047h,04eh,000h,060h,053h,020h,049h,057h,041h,042h,055h,043h,048h,049h,000h	; 8dd1  IGN.`S IWABUCHI.
	defb 0feh,038h,043h,048h,041h,052h,041h,043h,054h,04fh,052h,000h,060h,053h,020h,049h	; 8de1  .8CHARACTOR.`S I
	defb 057h,041h,042h,055h,043h,048h,049h,000h,060h,04dh,052h,020h,04eh,049h,053h,048h	; 8df1  WABUCHI.`MR NISH
	defb 049h,04dh,055h,052h,041h,000h,0feh,038h,053h,04fh,055h,04eh,044h,000h,060h,053h	; 8e01  IMURA..8SOUND.`S
	defb 050h,052h,041h,054h,054h,045h,052h,020h,041h,049h,05ah,041h,057h,041h,000h,060h	; 8e11  PRATTER AIZAWA.`
	defb 059h,041h,047h,020h,059h,041h,047h,049h,053h,048h,049h,054h,041h,000h,0feh,038h	; 8e21  YAG YAGISHITA..8
	defb 050h,052h,04fh,044h,055h,043h,045h,052h,000h,060h,053h,020h,054h,041h,04bh,041h	; 8e31  PRODUCER.`S TAKA
	defb 048h,041h,053h,048h,049h,000h,0feh,038h,053h,050h,045h,054h,049h,041h,04ch,020h	; 8e41  HASHI..8SPETIAL
	defb 054h,048h,041h,04eh,04bh,053h,020h,054h,04fh,000h,060h,054h,04dh,052h,020h,057h	; 8e51  THANKS TO.`TMR W
	defb 049h,04eh,000h,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,050h,050h	; 8e61  IN............PP
	defb 052h,04fh,044h,055h,043h,045h,044h,020h,042h,059h,000h,0feh,0feh,0feh,0feh,018h	; 8e71  RODUCED BY......
	defb 040h,020h,054h,041h,049h,054h,04fh,020h,043h,04fh,052h,050h,04fh,052h,041h,054h	; 8e81  @ TAITO CORPORAT
	defb 049h,04fh,04eh,020h,031h,039h,038h,038h,000h,030h,041h,04ch,04ch,020h,052h,049h	; 8e91  ION 1988.0ALL RI
	defb 047h,048h,054h,053h,020h,052h,045h,053h,045h,052h,056h,045h,044h,000h,0feh,0feh	; 8ea1  GHTS RESERVED...
	defb 0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8eb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ec1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ed1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ee1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ef1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fa1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fc1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fd1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fe1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ff1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9001  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9011  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9021  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9031  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9041  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9051  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9061  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9071  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9081  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9091  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9101  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9111  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9121  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9131  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9141  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9151  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9161  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9171  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9181  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9191  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9201  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9211  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9221  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9231  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9241  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9251  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9261  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9271  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9281  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9291  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9301  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9311  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9321  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9331  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9341  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9351  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9361  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9371  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9381  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9391  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9401  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9411  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9421  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9431  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9441  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9451  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9461  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9471  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9481  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9491  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9501  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9511  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9521  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9531  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9541  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9551  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9561  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9571  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9581  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9591  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9601  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9611  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9621  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9631  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9641  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9651  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9661  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9671  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9681  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9691  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9701  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9711  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9721  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9731  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9741  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9751  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9761  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9771  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9781  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9791  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9801  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9811  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9821  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9831  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9841  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9851  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9861  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9871  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9881  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9891  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9901  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9911  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9921  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9931  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9941  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9951  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9961  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9971  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9981  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9991  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99a1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99b1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99c1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99d1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99e1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99f1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9aa1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ab1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ac1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ad1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ae1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9af1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ba1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bc1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bd1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9be1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bf1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ca1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cc1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cd1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ce1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cf1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9da1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9db1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dc1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dd1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9de1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9df1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ea1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9eb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ec1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ed1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ee1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ef1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f01  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f11  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f21  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f31  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f41  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f51  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f61  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f71  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f81  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f91  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fa1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fb1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fc1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fd1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fe1  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ff1  ...............
