; ==========================================================================
; RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8) - banco 04 (en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS cruce_8000: los dos ultimos bytes del `ld (nn),hl` que empieza en
;   p03:7FFF (ld (0xD189),hl)
;   0x8000..0x8002  (2 bytes)
DATA_cruce_8000:
	defb 089h,0d1h	; 8000

; ======================================================================
; CODIGO 0x8002..0x80ce  (204 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; (Sigue de p03:7FDA, con HL = 0x0130 ya guardado en D189.)
; ----------------------------------------------------------------------
fin_cruce:
	ret			;8002

; ----------------------------------------------------------------------
; JEFE MUERTO (actor 0 de tipo 7): su animacion y una cuenta atras de D189
; cuadros; al acabar, la fase se da por acabada (D17D bit 0).
; ----------------------------------------------------------------------
jefe_muerto:
	call 07f3eh		;8003   ; un paso de su animacion
	ld hl,(0d189h)		;8006   ; D189 - 1
	dec hl			;8009
	ld (0d189h),hl		;800a
	ld a,h			;800d   ; aun no: nada
	or l			;800e
	ret nz			;800f
	ld hl,0d17dh		;8010   ; se acaba la fase
	set 0,(hl)		;8013
	ret			;8015

; ----------------------------------------------------------------------
; JEFE DE LA FASE 2 (tipo 1). La primera vez se coloca en (0x96, 0x40) con
; 0x140 de vida; luego anda hacia Rastan, se para delante de las paredes y
; a veces salta (la lista de alturas de p04:81B8).
; ----------------------------------------------------------------------
jefe_fase_2:
	ld ix,0d933h		;8016   ; IX = el actor 0
	ld a,(ix+000h)		;801a   ; ya muerto (tipo 7): p03:7FDA
	cp 007h		;801d
	jp z,07fdah		;801f   ; p03 actor0_a_tipo7
	ld a,(ix+006h)		;8022   ; x = 0: aun no ha salido
	cp 000h		;8025
	jp nz,jefe_1_mueve		;8027
	ld hl,00140h		;802a   ; 0x140 de vida
	ld (0d969h),hl		;802d   ; actor 1, byte +10 = hl
	ld (ix+007h),040h		;8030   ; en y = 0x40...
	ld (ix+006h),096h		;8034   ; ...x = 0x96
	ld (ix+000h),001h		;8038   ; tipo 1, pose 1
	ld (ix+001h),001h		;803c
	push ix		;8040
	call 07f1fh		;8042   ; su animacion desde el principio
	pop ix		;8045
	jp 07f3eh		;8047   ; p03 anima_actor0
jefe_1_mueve:
	ld (ix+000h),001h		;804a   ; tipo 1
	ld hl,0d910h		;804e   ; D910 bit 6: pelea con un jefe
	set 6,(hl)		;8051
	ld a,(0d969h)		;8053   ; sin vida: muere (p03:7FDA)
	ld b,a			;8056
	ld a,(0d96ah)		;8057   ; a = actor 1, byte +11
	or b			;805a
	jp z,07fdah		;805b   ; p03 actor0_a_tipo7
	bit 0,(ix+010h)		;805e   ; +10 bit 0: saltando (p04:8160)
	jp nz,jefe_1_salta		;8062
	bit 2,(ix+010h)		;8065   ; +10 bit 2: el otro salto (p04:8219)
	jp nz,jefe_1_salta_b		;8069
	res 2,(ix+001h)		;806c   ; poses de ataque fuera
	res 1,(ix+001h)		;8070
	call jefe_1_suelo		;8074   ; nada debajo (p04:811A)...
	cp 0ffh		;8077   ; ...cae
	jp z,07e5ah		;8079   ; p03 cae_2_especial
	call 07b29h		;807c   ; de cara a Rastan
	and a			;807f
	call z,07e18h		;8080   ; p03 da_la_vuelta
	call 07d56h		;8083   ; las casillas: la de delante
	and 0f0h		;8086   ; clase 0x20 (pared)...
	cp 020h		;8088
	jr nz,jefe_1_anda		;808a
	bit 4,(ix+010h)		;808c   ; ...+10 bit 4: p04:80E0
	jr nz,$+80		;8090
	call 07cc6h		;8092   ; cerca de Rastan (0x30): salta
	cp 030h		;8095
	jp c,jefe_1_salta		;8097
jefe_1_anda:
	call jefe_paso		;809a   ; un paso hacia donde mira
	call 07cc6h		;809d   ; lejos (0x30 o mas): solo la animacion
	cp 030h		;80a0
	jr c,jefe_1_cerca		;80a2
	jp 07f3eh		;80a4   ; p03 anima_actor0
jefe_1_cerca:
	ld a,(ix+006h)		;80a7   ; en los bordes, da la vuelta
	cp 010h		;80aa
	call c,07e18h		;80ac   ; p03 da_la_vuelta
	cp 0dch		;80af
	call nc,07e18h		;80b1   ; p03 da_la_vuelta
	call jefe_paso_atras		;80b4   ; un paso atras
	ld a,(ix+006h)		;80b7   ; en los bordes: salta
	cp 010h		;80ba
	jp c,jefe_1_salta		;80bc
	cp 0dch		;80bf
	jp nc,jefe_1_salta		;80c1
	jp 07f3eh		;80c4   ; animacion
huerfana_jefe_1_x20:
	ld (ix+006h),020h		;80c7   ; nadie llega aqui: x = 0x20 y salta
	jp jefe_1_salta		;80cb

; ----------------------------------------------------------------------
; DATOS resto_80CE: 18 bytes que nadie ejecuta
;   0x80ce..0x80e0  (18 bytes)
DATA_resto_80CE:
	defb 0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h,03eh,07fh,0ddh,036h,006h,0dch,0c3h	; 80ce  .........>..6...
	defb 060h,081h	; 80de

; ======================================================================
; CODIGO 0x80e0..0x81b8  (216 bytes)
; ======================================================================


jefe_1_pared:
	call 07cc6h		;80e0   ; a menos de 0x18 de Rastan...
	cp 018h		;80e3
	jr c,jefe_1_ataca		;80e5
	call 07e83h		;80e7   ; ...si no, anda 2
	jp 07f3eh		;80ea   ; p03 anima_actor0
jefe_1_ataca:
	bit 7,(ix+002h)		;80ed   ; su animacion no ha acabado: pose del bit 1
	jr nz,jefe_1_ataques		;80f1
	set 1,(ix+001h)		;80f3
	jp 07f3eh		;80f7   ; p03 anima_actor0
jefe_1_ataques:
	ld a,(ix+011h)		;80fa   ; +11 cuenta los ataques: uno
	cp 001h		;80fd
	jr z,jefe_1_fin_ataque		;80ff
	inc (ix+011h)		;8101
	jp 07f3eh		;8104   ; p03 anima_actor0
jefe_1_fin_ataque:
	res 4,(ix+010h)		;8107   ; fuera el bit 4 de +10 y las poses
	res 1,(ix+001h)		;810b
	res 2,(ix+001h)		;810f
	ld (ix+011h),000h		;8113
	jp 07f3eh		;8117   ; p03 anima_actor0
jefe_1_suelo:
	call 07d56h		;811a   ; las casillas
	ld a,(ix+023h)		;811d   ; la de +23 (debajo) es clase 0x20?
	and 0f0h		;8120   ; la clase de la casilla (+23)
	cp 020h		;8122   ; clase 0x20?
	jr nz,jefe_1_sin_suelo		;8124
	ld a,000h		;8126   ; si: A = 0
	ret			;8128
jefe_1_sin_suelo:
	ld a,0ffh		;8129   ; no: A = 0xFF
	ret			;812b
jefe_paso:
	bit 0,(ix+001h)		;812c   ; mirando a la izquierda: x - 1
	jr nz,jefe_paso_izq		;8130
	res 1,(ix+001h)		;8132   ; a la derecha: fuera las poses y x + 1
	res 2,(ix+001h)		;8136
	res 3,(ix+001h)		;813a
	inc (ix+006h)		;813e
	ret			;8141
jefe_paso_izq:
	dec (ix+006h)		;8142
	ret			;8145
jefe_paso_atras:
	bit 0,(ix+001h)		;8146   ; lo contrario
	jr nz,jefe_paso_atras_izq		;814a
	res 1,(ix+001h)		;814c
	res 2,(ix+001h)		;8150
	res 3,(ix+001h)		;8154
	dec (ix+006h)		;8158
	ret			;815b
jefe_paso_atras_izq:
	inc (ix+006h)		;815c
	ret			;815f

; ----------------------------------------------------------------------
; El salto del jefe: sube y baja siguiendo la lista de alturas de p04:81B8
; (+14/+15 apuntan por donde va) hasta un 0xFF, avanzando 2 cada cuadro.
; ----------------------------------------------------------------------
jefe_1_salta:
	ld a,(ix+006h)		;8160   ; en los bordes, da la vuelta
	cp 010h		;8163
	call c,07e18h		;8165   ; p03 da_la_vuelta
	cp 0dch		;8168
	call nc,07e18h		;816a   ; p03 da_la_vuelta
	set 2,(ix+001h)		;816d   ; pose del bit 2 y +10 bits 4 y 0: saltando
	set 4,(ix+010h)		;8171
	res 1,(ix+001h)		;8175
	set 0,(ix+010h)		;8179
	ld hl,081b8h		;817d   ; la lista desde el principio...
	bit 1,(ix+010h)		;8180   ; ...o por donde iba
	call nz,jefe_1_sigue_salto		;8184
	ld a,(hl)			;8187   ; 0xFF: se acabo
	cp 0ffh		;8188
	jp z,jefe_1_fin_salto		;818a
	ld a,(ix+007h)		;818d   ; y - el paso
	ld b,(hl)			;8190
	inc hl			;8191
	sub b			;8192
	ld (ix+007h),a		;8193
	set 1,(ix+010h)		;8196   ; +10 bit 1: el salto ya empezo
	ld (ix+015h),h		;819a   ; apunta por donde va
	ld (ix+014h),l		;819d
	call 07e83h		;81a0   ; 2 pixeles hacia donde mira
	jp 07f3eh		;81a3   ; p03 anima_actor0
jefe_1_sigue_salto:
	ld h,(ix+015h)		;81a6   ; HL = por donde iba
	ld l,(ix+014h)		;81a9
	ret			;81ac
jefe_1_fin_salto:
	ld (ix+010h),000h		;81ad   ; +10 = 0x10: aterriza
	set 4,(ix+010h)		;81b1
	jp 07f3eh		;81b5   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS jefe_1_salto: Las alturas del salto del jefe de la fase 2: un byte por
;   cuadro (lo que sube; negativo baja) y 0xFF
;   0x81b8..0x8219  (97 bytes)
DATA_jefe_1_salto:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 81b8  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 81c8  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 81d8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 81e8  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh,0ddh,0cbh	; 81f8  ................
	defb 010h,0d6h,0ddh,0cbh,010h,0e6h,0ddh,0cbh,010h,086h,0ddh,0cbh,010h,08eh,0ddh,07eh	; 8208  ...............~
	defb 006h	; 8218

; ======================================================================
; CODIGO 0x8219..0x8328  (271 bytes)
; ======================================================================


jefe_1_salta_b:
	ld a,(ix+006h)		;8219   ; el otro salto (+10 bit 2): la misma lista con la pose del bit 2
	cp 010h		;821c
	call c,07e18h		;821e   ; p03 da_la_vuelta
	cp 0dch		;8221
	call nc,07e18h		;8223   ; p03 da_la_vuelta
	set 2,(ix+001h)		;8226
	res 1,(ix+001h)		;822a
	set 3,(ix+010h)		;822e   ; +10 bit 3
	ld hl,081b8h		;8232
	bit 2,(ix+010h)		;8235
	call nz,jefe_1_sigue_salto_b		;8239
	ld a,(hl)			;823c
	cp 0ffh		;823d
	jp z,jefe_1_fin_salto		;823f
	ld a,(ix+007h)		;8242
	ld b,(hl)			;8245
	inc hl			;8246
	sub b			;8247
	ld (ix+007h),a		;8248
	set 1,(ix+010h)		;824b
	ld (ix+015h),h		;824f
	ld (ix+014h),l		;8252
	call 07e83h		;8255   ; p03 anda
	jp 07f3eh		;8258   ; p03 anima_actor0
jefe_1_sigue_salto_b:
	ld h,(ix+015h)		;825b
	ld l,(ix+014h)		;825e
	ret			;8261

; ----------------------------------------------------------------------
; JEFE DE LA FASE 5 (tipo 2): como el de la fase 2, con efecto 9 al salir,
; su lista de alturas en p04:83E6 y tres ataques seguidos.
; ----------------------------------------------------------------------
jefe_fase_5:
	ld ix,0d933h		;8262   ; ix -> los 6 actores de la pantalla
	ld a,(ix+000h)		;8266   ; ya muerto: p03:7FDA
	cp 007h		;8269
	jp z,07fdah		;826b   ; p03 actor0_a_tipo7
	ld a,(ix+006h)		;826e   ; aun no ha salido...
	cp 000h		;8271
	jp nz,jefe_2_mueve		;8273
	ld hl,00140h		;8276   ; ...0x140 de vida...
	ld (0d969h),hl		;8279   ; actor 1, byte +10 = hl
	ld (ix+007h),040h		;827c   ; ...en (0x96, 0x40)...
	ld (ix+006h),096h		;8280
	ld hl,0d910h		;8284   ; ...pelea con un jefe...
	set 6,(hl)		;8287
	ld (ix+000h),002h		;8289   ; ...tipo 2, pose 1
	ld (ix+001h),001h		;828d
	push ix		;8291
	call 07f1fh		;8293   ; animacion desde el principio
	pop ix		;8296
	ld a,009h		;8298   ; efecto 9
	ld (0d178h),a		;829a   ; efecto pedido, para p01:63E1 = a
	jp 07f3eh		;829d   ; p03 anima_actor0
jefe_2_mueve:
	ld (ix+000h),002h		;82a0
	ld hl,0d910h		;82a4   ; pelea con un jefe
	set 6,(hl)		;82a7
	ld a,(0d969h)		;82a9   ; sin vida: muere
	ld b,a			;82ac
	ld a,(0d96ah)		;82ad   ; a = actor 1, byte +11
	or b			;82b0
	jp z,07fdah		;82b1   ; p03 actor0_a_tipo7
	bit 0,(ix+010h)		;82b4   ; saltando
	jp nz,jefe_2_saltando		;82b8
	bit 2,(ix+010h)		;82bb   ; el otro salto
	jp nz,jefe_2_salta_b		;82bf
	res 3,(ix+001h)		;82c2   ; fuera las poses 1-3
	res 2,(ix+001h)		;82c6
	res 1,(ix+001h)		;82ca
	call 07ebdh		;82ce   ; nada debajo: cae (p04:8479)
	cp 0ffh		;82d1
	jp z,jefe_2_cae		;82d3
	call 07b29h		;82d6   ; de cara a Rastan
	and a			;82d9
	call z,07e18h		;82da   ; p03 da_la_vuelta
	call 07d56h		;82dd   ; la casilla de delante
	and 0f0h		;82e0
	cp 020h		;82e2
	jr nz,jefe_2_anda		;82e4
	bit 4,(ix+010h)		;82e6   ; pared y +10 bit 4: p04:833A
	jr nz,$+80		;82ea
	call 07cc6h		;82ec   ; cerca: salta
	cp 030h		;82ef
	jp c,jefe_2_salta		;82f1
jefe_2_anda:
	call jefe_paso		;82f4
	call 07cc6h		;82f7   ; p03 distancia_x
	cp 030h		;82fa
	jr c,jefe_2_cerca		;82fc
	jp 07f3eh		;82fe   ; p03 anima_actor0
jefe_2_cerca:
	ld a,(ix+006h)		;8301
	cp 010h		;8304
	call c,07e18h		;8306   ; p03 da_la_vuelta
	cp 0dch		;8309
	call nc,07e18h		;830b   ; p03 da_la_vuelta
	call jefe_paso_atras		;830e
	ld a,(ix+006h)		;8311
	cp 010h		;8314
	jp c,jefe_2_salta		;8316
	cp 0dch		;8319
	jp nc,jefe_2_salta		;831b
	jp 07f3eh		;831e   ; p03 anima_actor0
huerfana_jefe_2_x20:
	ld (ix+006h),020h		;8321   ; nadie llega aqui
	jp jefe_2_salta		;8325

; ----------------------------------------------------------------------
; DATOS resto_8328: 18 bytes que nadie ejecuta
;   0x8328..0x833a  (18 bytes)
DATA_resto_8328:
	defb 0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h,03eh,07fh,0ddh,036h,006h,0dch,0c3h	; 8328  .........>..6...
	defb 086h,083h	; 8338

; ======================================================================
; CODIGO 0x833a..0x83e6  (172 bytes)
; ======================================================================


jefe_2_pared:
	call 07cc6h		;833a   ; a menos de 8 de Rastan: ataca
	cp 008h		;833d
	jr c,jefe_2_ataca		;833f
	ld a,(ix+013h)		;8341   ; si no, cada tres cuadros...
	inc a			;8344
	ld (ix+013h),a		;8345
	cp 003h		;8348
	jr z,L_834F		;834a
	jp 07f3eh		;834c   ; p03 anima_actor0
L_834F:
	ld (ix+013h),000h		;834f   ; ...anda 2
	call 07e83h		;8353   ; p03 anda
	jp 07f3eh		;8356   ; p03 anima_actor0
jefe_2_ataca:
	bit 7,(ix+002h)		;8359
	jr nz,jefe_2_ataques		;835d
	set 1,(ix+001h)		;835f
	jp 07f3eh		;8363   ; p03 anima_actor0
jefe_2_ataques:
	ld a,(ix+011h)		;8366   ; tres ataques (+11 hasta 2)
	cp 002h		;8369
	jr z,jefe_2_fin_ataque		;836b
	inc (ix+011h)		;836d
	jp 07f3eh		;8370   ; p03 anima_actor0
jefe_2_fin_ataque:
	res 4,(ix+010h)		;8373
	res 1,(ix+001h)		;8377
	res 2,(ix+001h)		;837b
	ld (ix+011h),000h		;837f
	jp 07f3eh		;8383   ; p03 anima_actor0
jefe_2_salta:
	call 07b29h		;8386   ; de cara a Rastan y efecto 9
	and a			;8389
	call z,07e18h		;838a   ; p03 da_la_vuelta
	ld a,009h		;838d
	ld (0d178h),a		;838f   ; efecto pedido, para p01:63E1 = a
jefe_2_saltando:
	ld a,(ix+006h)		;8392
	cp 010h		;8395
	call c,07e18h		;8397   ; p03 da_la_vuelta
	cp 0dch		;839a
	call nc,07e18h		;839c   ; p03 da_la_vuelta
	set 3,(ix+001h)		;839f   ; pose del bit 3
	set 4,(ix+010h)		;83a3
	set 0,(ix+010h)		;83a7
	ld hl,083e6h		;83ab   ; la lista de p04:83E6
	bit 1,(ix+010h)		;83ae
	call nz,jefe_2_sigue_salto		;83b2
	ld a,(hl)			;83b5
	cp 0ffh		;83b6
	jp z,jefe_2_fin_salto		;83b8
	ld a,(ix+007h)		;83bb
	ld b,(hl)			;83be
	inc hl			;83bf
	sub b			;83c0
	ld (ix+007h),a		;83c1
	set 1,(ix+010h)		;83c4
	ld (ix+015h),h		;83c8
	ld (ix+014h),l		;83cb
	call 07e83h		;83ce   ; p03 anda
	jp 07f3eh		;83d1   ; p03 anima_actor0
jefe_2_sigue_salto:
	ld h,(ix+015h)		;83d4
	ld l,(ix+014h)		;83d7
	ret			;83da
jefe_2_fin_salto:
	ld (ix+010h),000h		;83db
	set 4,(ix+010h)		;83df
	jp 07f3eh		;83e3   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS jefe_2_salto: Las alturas del salto del jefe de la fase 5, hasta 0xFF
;   0x83e6..0x8434  (78 bytes)
DATA_jefe_2_salto:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 83e6  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 83f6  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 8406  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 8416  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh	; 8426  ..............

; ======================================================================
; CODIGO 0x8434..0x8546  (274 bytes)
; ======================================================================


jefe_2_salta_b:
	ld a,(ix+006h)		;8434
	cp 010h		;8437
	call c,07e18h		;8439   ; p03 da_la_vuelta
	cp 0dch		;843c
	call nc,07e18h		;843e   ; p03 da_la_vuelta
	set 3,(ix+001h)		;8441
	set 3,(ix+010h)		;8445
	ld hl,083e6h		;8449
	bit 2,(ix+010h)		;844c
	call nz,jefe_2_sigue_salto_b		;8450
	ld a,(hl)			;8453
	cp 0ffh		;8454
	jp z,jefe_2_fin_salto		;8456
	ld a,(ix+007h)		;8459
	ld b,(hl)			;845c
	inc hl			;845d
	sub b			;845e
	ld (ix+007h),a		;845f
	set 1,(ix+010h)		;8462
	ld (ix+015h),h		;8466
	ld (ix+014h),l		;8469
	call 07e83h		;846c   ; p03 anda
	jp 07f3eh		;846f   ; p03 anima_actor0
jefe_2_sigue_salto_b:
	ld h,(ix+015h)		;8472
	ld l,(ix+014h)		;8475
	ret			;8478
jefe_2_cae:
	ld a,(ix+007h)		;8479   ; 2 pixeles abajo
	inc a			;847c
	inc a			;847d
	ld (ix+007h),a		;847e
	ld a,(ix+001h)		;8481   ; pose de caer (bit 3)
	and 001h		;8484
	or 008h		;8486
	ld (ix+001h),a		;8488
	jp 07f3eh		;848b   ; un paso de su animacion

; ----------------------------------------------------------------------
; JEFE DE LA FASE 8 (tipo 3): 0xA0 de vida. Lanza un proyectil (el actor 4)
; y, al llegar a ciertas x (0x14, 0x40, 0xA8, 0xC8), desaparece con el
; efecto 8 y vuelve a salir en otro sitio elegido al azar.
; ----------------------------------------------------------------------
jefe_fase_8:
	ld ix,0d933h		;848e   ; ix -> los 6 actores de la pantalla
	ld a,(ix+000h)		;8492   ; ya muerto: p03:7FDA
	cp 007h		;8495
	jp z,07fdah		;8497   ; p03 actor0_a_tipo7
	ld a,(ix+006h)		;849a   ; aun no ha salido...
	cp 000h		;849d
	jp nz,jefe_3_mueve		;849f
	ld hl,000a0h		;84a2   ; ...0xA0 de vida...
	ld (0d969h),hl		;84a5   ; actor 1, byte +10 = hl
	ld (ix+007h),030h		;84a8   ; ...en (0x96, 0x30)...
	ld (ix+006h),096h		;84ac
	ld hl,0d910h		;84b0   ; ...pelea con un jefe...
	set 6,(hl)		;84b3
	ld (ix+000h),003h		;84b5   ; ...tipo 3, pose 1
	ld (ix+001h),001h		;84b9
	push ix		;84bd
	call 07f1fh		;84bf   ; animacion desde el principio
	pop ix		;84c2
	jp 07f3eh		;84c4   ; p03 anima_actor0
jefe_3_mueve:
	ld (ix+000h),003h		;84c7
	ld hl,0d910h		;84cb   ; pelea con un jefe
	set 6,(hl)		;84ce
	ld a,(0d969h)		;84d0   ; sin vida: muere
	ld b,a			;84d3
	ld a,(0d96ah)		;84d4   ; a = actor 1, byte +11
	or b			;84d7
	jp z,07fdah		;84d8   ; p03 actor0_a_tipo7
	ld a,(0d96bh)		;84db   ; D96B: le acaban de dar (p07:96FA)
	and a			;84de
	jp nz,jefe_3_tocado		;84df
jefe_3_proyectil:
	ld a,(0d9e0h)		;84e2   ; su proyectil en vuelo...
	cp 00fh		;84e5
	push af			;84e7
	call z,proyectil_jefe_3		;84e8   ; ...se mueve...
	pop af			;84eb
	jp z,07f3eh		;84ec   ; ...y nada mas
	bit 1,(ix+001h)		;84ef   ; lanzando: el proyectil
	call nz,proyectil_jefe_3		;84f3
	call jefe_1_suelo		;84f6   ; nada debajo...
	cp 0ffh		;84f9
	call z,jefe_3_va_a_lanzar		;84fb   ; ...+12 bit 0...
	jp z,07e5ah		;84fe   ; ...y cae
	call 07b29h		;8501   ; de cara a Rastan
	and a			;8504
	call z,07e18h		;8505   ; p03 da_la_vuelta
	bit 0,(ix+012h)		;8508   ; +12 bit 0: va a lanzar (p04:858B)
	jp nz,jefe_3_lanza		;850c
	bit 1,(ix+001h)		;850f   ; lanzando: p04:85AD
	jp nz,jefe_3_lanzando		;8513
	res 7,(ix+014h)		;8516   ; +14 bit 7 a 0
jefe_3_donde:
	ld a,(ix+006h)		;851a   ; en x < 0x14: salta a otro sitio
	cp 014h		;851d
	jp c,jefe_3_salta_14		;851f
	cp 040h		;8522   ; en 0x40: tambien
	jp z,jefe_3_salta_40		;8524
	cp 0a8h		;8527   ; en 0xA8: tambien
	jp z,jefe_3_salta_a8		;8529
	cp 0c8h		;852c   ; de 0xC8 en adelante: tambien
	jp nc,jefe_3_salta_c8		;852e
	call 07cc6h		;8531   ; lejos de Rastan (0x30): se aleja
	cp 030h		;8534
	jr c,jefe_3_cerca		;8536
	call jefe_aleja_1		;8538
	jp 07f3eh		;853b   ; animacion
jefe_3_cerca:
	cp 030h		;853e   ; cerca: se acerca un pixel
	call c,jefe_acerca_1		;8540
	jp 07f3eh		;8543   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS resto_8546: 22 bytes que nadie ejecuta
;   0x8546..0x855c  (22 bytes)
DATA_resto_8546:
	defb 0ddh,036h,006h,0d1h,0ddh,036h,007h,050h,0c3h,03eh,07fh,0ddh,036h,006h,011h,0ddh	; 8546  .6...6.P.>..6...
	defb 036h,007h,050h,0c3h,03eh,07fh	; 8556

; ======================================================================
; CODIGO 0x855c..0x8578  (28 bytes)
; ======================================================================


jefe_acerca_1:
	bit 0,(ix+001h)		;855c   ; mirando a la izquierda: x + 1
	jr z,jefe_acerca_1_izq		;8560
	inc (ix+006h)		;8562
	ret			;8565
jefe_acerca_1_izq:
	dec (ix+006h)		;8566
	ret			;8569
jefe_aleja_1:
	bit 0,(ix+001h)		;856a   ; lo contrario
	jr z,jefe_aleja_1_der		;856e
	dec (ix+006h)		;8570
	ret			;8573
jefe_aleja_1_der:
	inc (ix+006h)		;8574
	ret			;8577

; ----------------------------------------------------------------------
; DATOS resto_8578: 19 bytes que nadie ejecuta
;   0x8578..0x858b  (19 bytes)
DATA_resto_8578:
	defb 0ddh,0cbh,001h,0ceh,0c3h,03eh,07fh,03ah,0f4h,0d8h,0cbh,06fh,020h,002h,0afh,0c9h	; 8578  .....>.:...o ...
	defb 03eh,0ffh,0c9h	; 8588

; ======================================================================
; CODIGO 0x858b..0x876e  (483 bytes)
; ======================================================================


jefe_3_lanza:
	ld a,(0d9e0h)		;858b   ; ya hay proyectil: p04:8767
	cp 00fh		;858e
	jp z,jefe_3_ya_lanzo		;8590
	set 1,(ix+001h)		;8593   ; pose de lanzar, +12 bit 0 a 0, +10 bit 0
	res 0,(ix+012h)		;8597
	set 0,(ix+010h)		;859b
	push ix		;859f
	call 07f3eh		;85a1   ; un paso de animacion
	pop ix		;85a4
	ld a,(0d9e0h)		;85a6   ; sin proyectil: sale
	and a			;85a9
	jp z,proyectil_jefe_3		;85aa
jefe_3_lanzando:
	bit 7,(ix+002h)		;85ad   ; la animacion de lanzar no ha acabado
	jr nz,jefe_3_lanzado		;85b1
	jp 07f3eh		;85b3   ; p03 anima_actor0
jefe_3_lanzado:
	ld a,(ix+011h)		;85b6   ; una vez
	inc a			;85b9
	cp 001h		;85ba
	jr z,jefe_3_fin_lanzar		;85bc
	ld (ix+011h),a		;85be
	jp 07f3eh		;85c1   ; p03 anima_actor0
jefe_3_fin_lanzar:
	ld (ix+011h),000h		;85c4   ; fuera +10 bit 0 y la pose
	res 0,(ix+010h)		;85c8
	res 1,(ix+001h)		;85cc
	jp 07f3eh		;85d0   ; p03 anima_actor0
jefe_3_salta_14:
	ld (ix+014h),000h		;85d3   ; efecto 8...
	ld a,008h		;85d7
	ld (0d178h),a		;85d9   ; efecto pedido, para p01:63E1 = a
	call 044deh		;85dc   ; ...y al azar a (0xC7, 0x32)...
	jp po,jefe_3_a_a7		;85df
	ld (ix+006h),0c7h		;85e2
	ld (ix+007h),032h		;85e6
	jp 07f3eh		;85ea   ; p03 anima_actor0
jefe_3_a_a7:
	ld (ix+006h),0a7h		;85ed   ; ...o a (0xA7, 0x32)
	ld (ix+007h),032h		;85f1
	jp 07f3eh		;85f5   ; p03 anima_actor0
jefe_3_salta_40:
	ld (ix+014h),000h		;85f8   ; efecto 8 y a 0xA7 o 0xC7
	ld a,008h		;85fc
	ld (0d178h),a		;85fe   ; efecto pedido, para p01:63E1 = a
	call 044deh		;8601   ; p00 azar
	jp po,jefe_3_a_c7		;8604
	ld (ix+006h),0a7h		;8607
	ld (ix+007h),032h		;860b
	jp 07f3eh		;860f   ; p03 anima_actor0
jefe_3_a_c7:
	ld (ix+006h),0c7h		;8612
	ld (ix+007h),032h		;8616
	jp 07f3eh		;861a   ; p03 anima_actor0
jefe_3_salta_a8:
	ld (ix+014h),000h		;861d   ; efecto 8 y a 0xA7 o 0x15 (aqui sin llamar al azar: decide la paridad que ya habia)
	ld a,008h		;8621
	ld (0d178h),a		;8623   ; efecto pedido, para p01:63E1 = a
	jp po,jefe_3_a_15		;8626
	ld (ix+006h),0a7h		;8629
	ld (ix+007h),032h		;862d
	jp 07f3eh		;8631   ; p03 anima_actor0
jefe_3_a_15:
	ld (ix+006h),015h		;8634
	ld (ix+007h),032h		;8638
	jp 07f3eh		;863c   ; p03 anima_actor0
jefe_3_salta_c8:
	ld (ix+014h),000h		;863f   ; efecto 8 y al azar...
	ld a,008h		;8643
	ld (0d178h),a		;8645   ; efecto pedido, para p01:63E1 = a
	call 044deh		;8648   ; p00 azar
	jp po,jefe_3_a_41		;864b
	ld (ix+006h),015h		;864e   ; ...a x = 0x15 (y la y = 0x32 se escribe en la x: se queda en 0x32)...
	ld (ix+006h),032h		;8652
	jp 07f3eh		;8656   ; p03 anima_actor0
jefe_3_a_41:
	ld (ix+006h),041h		;8659   ; ...o a (0x41, 0x32)
	ld (ix+007h),032h		;865d
	jp 07f3eh		;8661   ; p03 anima_actor0
jefe_3_va_a_lanzar:
	set 0,(ix+012h)		;8664   ; +12 bit 0
	ret			;8668
proyectil_jefe_3:
	push ix		;8669   ; IY = el jefe, IX = el actor 4
	push ix		;866b
	pop iy		;866d
	ld ix,0d9cbh		;866f   ; ix -> actor 4
	ld a,(ix+015h)		;8673   ; +15 = 0: aun no ha salido
	cp 000h		;8676
	jp z,lanza_proyectil_jefe_3		;8678
	cp 00fh		;867b   ; 0x0F: en vuelo
	jr z,sigue_proyectil_jefe_3		;867d
	jp acaba_proyectil_jefe_3		;867f   ; si no, acabando
lanza_proyectil_jefe_3:
	bit 7,(iy+002h)		;8682   ; la animacion de lanzar ha acabado?
	jp z,proyectil_jefe_3_fin		;8686
	ld (ix+015h),00fh		;8689   ; en vuelo
	call coloca_proyectil_jefe_3		;868d   ; se coloca
	call 048f9h		;8690   ; alta y pintado
	call 04a8bh		;8693   ; p00 pinta_actor
proyectil_jefe_3_fin:
	pop ix		;8696
	ret			;8698
sigue_proyectil_jefe_3:
	jp mueve_proyectil_jefe_3		;8699
proyectil_jefe_3_pinta:
	call 04a8bh		;869c   ; p00 pinta_actor
	pop ix		;869f
	ret			;86a1
huerfana_acaba_jefe_3:
	ld (ix+015h),000h		;86a2   ; nadie llega aqui
	call 04b10h		;86a6   ; p00 baja_actor
	pop ix		;86a9
	ret			;86ab
coloca_proyectil_jefe_3:
	ld (ix+001h),00dh		;86ac   ; pose 0x0D
	ld a,(iy+001h)		;86b0   ; +13 = el lado del jefe
	ld (ix+013h),a		;86b3
	bit 0,(iy+001h)		;86b6   ; a la izquierda: x - 8
	jr z,coloca_jefe_3_der		;86ba
	set 0,(ix+012h)		;86bc
	ld a,(iy+006h)		;86c0
	sub 008h		;86c3
	ld (ix+006h),a		;86c5
	jr coloca_jefe_3_y		;86c8
coloca_jefe_3_der:
	res 0,(ix+001h)		;86ca   ; a la derecha: x + 0x18
	ld a,(iy+006h)		;86ce
	add a,018h		;86d1
	ld (ix+006h),a		;86d3
coloca_jefe_3_y:
	ld a,(iy+007h)		;86d6   ; y + 0x10, tipo 0x16
	add a,010h		;86d9
	ld (ix+007h),a		;86db
	ld a,016h		;86de
	ld (ix+000h),a		;86e0
	ret			;86e3
mueve_proyectil_jefe_3:
	call 07d56h		;86e4   ; las casillas
	ld a,(ix+020h)		;86e7   ; toca una de clase 0x20: se acaba
	and 0f0h		;86ea   ; la clase de la casilla (+20)
	cp 020h		;86ec   ; clase 0x20?
	jp z,choca_proyectil_jefe_3		;86ee
	ld a,(0d8fch)		;86f1   ; C = x de Rastan + 0x18
	add a,018h		;86f4
	ld c,a			;86f6
	bit 0,(ix+013h)		;86f7   ; hacia la izquierda: si da a Rastan (p03:6AFF), se acaba
	jr z,mueve_proyectil_jefe_3_der		;86fb
	call 06affh		;86fd   ; p03 proyectil_choca_izq
	and a			;8700
	jp z,choca_proyectil_jefe_3		;8701
	ld a,(ix+006h)		;8704   ; 2 a la izquierda, hasta 4
	dec a			;8707
	dec a			;8708
	cp 004h		;8709
	jp c,choca_proyectil_jefe_3		;870b
	ld (ix+006h),a		;870e
	jr proyectil_jefe_3_sigue		;8711
mueve_proyectil_jefe_3_der:
	res 0,(ix+001h)		;8713   ; hacia la derecha (p03:6B2C)
	call 06b2ch		;8717   ; p03 proyectil_choca_der
	and a			;871a
	jp z,choca_proyectil_jefe_3		;871b
	ld a,(ix+006h)		;871e   ; 2 a la derecha, hasta 0xF0
	inc a			;8721
	inc a			;8722
	cp 0f0h		;8723
	jp nc,choca_proyectil_jefe_3		;8725
	ld (ix+006h),a		;8728
proyectil_jefe_3_sigue:
	jp proyectil_jefe_3_pinta		;872b
choca_proyectil_jefe_3:
	ld ix,0d9cbh		;872e   ; al chocar: +15 = 0xF1, pintado y baja
	ld (ix+015h),0f1h		;8732
	push ix		;8736
	call 04a8bh		;8738   ; p00 pinta_actor
	pop ix		;873b
	call 04b10h		;873d   ; p00 baja_actor
	pop ix		;8740
	ret			;8742
acaba_proyectil_jefe_3:
	bit 7,(ix+002h)		;8743   ; su animacion de choque no ha acabado
	jr nz,fin_proyectil_jefe_3		;8747
	push ix		;8749
	call 04a8bh		;874b   ; p00 pinta_actor
	pop ix		;874e
	call 04b10h		;8750   ; p00 baja_actor
	pop ix		;8753
	ret			;8755
fin_proyectil_jefe_3:
	ld (ix+015h),000h		;8756   ; acabada: ya no hay
	push ix		;875a
	call 04a8bh		;875c   ; p00 pinta_actor
	pop ix		;875f
	call 04b10h		;8761   ; p00 baja_actor
	pop ix		;8764
	ret			;8766
jefe_3_ya_lanzo:
	res 1,(ix+001h)		;8767   ; fuera la pose de lanzar
	jp 07f3eh		;876b   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS resto_876E: 17 bytes que nadie ejecuta
;   0x876e..0x877f  (17 bytes)
DATA_resto_876E:
	defb 0ddh,07eh,014h,03ch,0feh,002h,028h,004h,0ddh,077h,014h,0c9h,0ddh,0cbh,014h,0feh	; 876e  .~.<..(..w......
	defb 0c9h	; 877e

; ======================================================================
; CODIGO 0x877f..0x8856  (215 bytes)
; ======================================================================


jefe_3_tocado:
	xor a			;877f   ; D96B a 0
	ld (0d96bh),a		;8780   ; actor 1, byte +12 = a
	ld a,(ix+015h)		;8783   ; +15 + 1: el primer golpe...
	inc a			;8786
	cp 001h		;8787
	jp z,jefe_3_tocado_salta		;8789
	ld (ix+015h),a		;878c   ; ...sigue como siempre
	jp jefe_3_proyectil		;878f
jefe_3_tocado_salta:
	xor a			;8792   ; si no, a cambiar de sitio
	ld (ix+015h),a		;8793
	jp jefe_3_donde		;8796

; ----------------------------------------------------------------------
; JEFE DE LA FASE 0x0B (tipo 4): 0x140 de vida; como el de la fase 2, con
; su salto en p04:8915 y otro salto si Rastan ataca (pose bit 5).
; ----------------------------------------------------------------------
jefe_fase_0b:
	ld ix,0d933h		;8799   ; ix -> los 6 actores de la pantalla
	ld a,(ix+000h)		;879d   ; ya muerto: p03:7FDA
	cp 007h		;87a0
	jp z,07fdah		;87a2   ; p03 actor0_a_tipo7
	ld a,(ix+006h)		;87a5   ; aun no ha salido: 0x140 de vida, en (0x96, 0x30), tipo 4
	cp 000h		;87a8
	jp nz,jefe_4_mueve		;87aa
	ld hl,00140h		;87ad
	ld (0d969h),hl		;87b0   ; actor 1, byte +10 = hl
	ld (ix+007h),030h		;87b3
	ld (ix+006h),096h		;87b7
	ld hl,0d910h		;87bb   ; hl -> bits: 0 en la salida, 6 jefe, 7 no pierde vida
	set 6,(hl)		;87be
	ld (ix+000h),004h		;87c0
	ld (ix+001h),001h		;87c4
	push ix		;87c8
	call 07f1fh		;87ca   ; p03 anima_actor0_desde_cero
	pop ix		;87cd
	jp 07f3eh		;87cf   ; p03 anima_actor0
jefe_4_mueve:
	ld (ix+000h),004h		;87d2
	ld hl,0d910h		;87d6   ; pelea con un jefe
	set 6,(hl)		;87d9
	ld a,(0d969h)		;87db   ; sin vida: muere
	ld b,a			;87de
	ld a,(0d96ah)		;87df   ; a = actor 1, byte +11
	or b			;87e2
	jp z,07fdah		;87e3   ; p03 actor0_a_tipo7
	bit 0,(ix+010h)		;87e6   ; saltando
	jp nz,jefe_4_salta		;87ea
	bit 2,(ix+010h)		;87ed   ; el otro salto
	jp nz,jefe_4_salta_b		;87f1
	res 2,(ix+001h)		;87f4   ; fuera las poses de ataque
	res 1,(ix+001h)		;87f8
	call jefe_1_suelo		;87fc   ; nada debajo: cae
	cp 0ffh		;87ff
	jp z,07e5ah		;8801   ; p03 cae_2_especial
	call 07b29h		;8804   ; de cara a Rastan
	and a			;8807
	call z,07e18h		;8808   ; p03 da_la_vuelta
	call 07d56h		;880b   ; la casilla de delante
	and 0f0h		;880e
	cp 020h		;8810
	jr nz,jefe_4_anda		;8812
	bit 4,(ix+010h)		;8814   ; pared y +10 bit 4: p04:8861
	jr nz,$+73		;8818
	call 07cc6h		;881a   ; cerca de Rastan: salta
	cp 030h		;881d
	jp c,jefe_4_salta		;881f
jefe_4_anda:
	call jefe_paso		;8822
	call 07cc6h		;8825   ; p03 distancia_x
	cp 030h		;8828
	jr c,jefe_4_cerca		;882a
	jp 07f3eh		;882c   ; p03 anima_actor0
jefe_4_cerca:
	ld a,(ix+006h)		;882f
	cp 010h		;8832
	call c,07e18h		;8834   ; p03 da_la_vuelta
	cp 0dch		;8837
	call nc,07e18h		;8839   ; p03 da_la_vuelta
	call jefe_paso_atras		;883c
	ld a,(ix+006h)		;883f
	cp 010h		;8842   ; en los bordes: p04:88AD
	jp c,jefe_4_borde		;8844
	cp 0dch		;8847
	jp nc,jefe_4_borde		;8849
	jp 07f3eh		;884c   ; p03 anima_actor0
huerfana_jefe_4_x20:
	ld (ix+006h),020h		;884f   ; nadie llega aqui
	jp jefe_4_borde		;8853

; ----------------------------------------------------------------------
; DATOS resto_8856: 11 bytes que nadie ejecuta
;   0x8856..0x8861  (11 bytes)
DATA_resto_8856:
	defb 0ddh,0cbh,010h,0a6h,0ddh,0cbh,001h,08eh,0c3h,03eh,07fh	; 8856  .........>.

; ======================================================================
; CODIGO 0x8861..0x8915  (180 bytes)
; ======================================================================


jefe_4_pared:
	call 07cc6h		;8861   ; a menos de 0x10: ataca
	cp 010h		;8864
	jr c,jefe_4_ataca		;8866
	ld a,(ix+013h)		;8868   ; si no, un paso cada tres cuadros
	inc a			;886b
	ld (ix+013h),a		;886c
	cp 003h		;886f
	jr z,jefe_4_paso		;8871
	jp 07f3eh		;8873   ; p03 anima_actor0
jefe_4_paso:
	ld (ix+013h),000h		;8876
	call 07e83h		;887a   ; p03 anda
	jp 07f3eh		;887d   ; p03 anima_actor0
jefe_4_ataca:
	bit 7,(ix+002h)		;8880
	jr nz,jefe_4_ataques		;8884
	set 1,(ix+001h)		;8886
	jp 07f3eh		;888a   ; p03 anima_actor0
jefe_4_ataques:
	ld a,(ix+011h)		;888d   ; tres ataques
	cp 002h		;8890
	jr z,jefe_4_fin_ataque		;8892
	inc (ix+011h)		;8894
	jp 07f3eh		;8897   ; p03 anima_actor0
jefe_4_fin_ataque:
	res 4,(ix+010h)		;889a
	res 1,(ix+001h)		;889e
	res 2,(ix+001h)		;88a2
	ld (ix+011h),000h		;88a6
	jp 07f3eh		;88aa   ; p03 anima_actor0
jefe_4_borde:
	ld a,(0d8f4h)		;88ad   ; Rastan atacando: el otro salto (p04:8963)
	bit 5,a		;88b0
	jp nz,jefe_4_esquiva		;88b2
jefe_4_salta:
	ld a,(ix+006h)		;88b5
	cp 010h		;88b8
	call c,07e18h		;88ba   ; p03 da_la_vuelta
	cp 0dch		;88bd
	call nc,07e18h		;88bf   ; p03 da_la_vuelta
	set 2,(ix+001h)		;88c2   ; pose del bit 2, +10 bits 4 y 0
	set 4,(ix+010h)		;88c6
	res 1,(ix+001h)		;88ca
	set 0,(ix+010h)		;88ce
	ld hl,08915h		;88d2   ; la lista de p04:8915
	bit 1,(ix+010h)		;88d5
	call nz,jefe_4_sigue_salto		;88d9
	ld a,(hl)			;88dc   ; 0xFF: aterriza
	cp 0ffh		;88dd
	jp z,jefe_4_fin_salto		;88df
	ld a,(ix+007h)		;88e2   ; y - el paso
	ld b,(hl)			;88e5
	inc hl			;88e6
	sub b			;88e7
	ld (ix+007h),a		;88e8
	set 1,(ix+010h)		;88eb
	ld (ix+015h),h		;88ef
	ld (ix+014h),l		;88f2
	ld a,(ix+006h)		;88f5   ; en el borde izquierdo: p04:89C7
	cp 010h		;88f8
	jp c,jefe_4_borde_izq		;88fa
	call 07e83h		;88fd   ; 2 pixeles
	jp 07f3eh		;8900   ; p03 anima_actor0
jefe_4_sigue_salto:
	ld h,(ix+015h)		;8903
	ld l,(ix+014h)		;8906
	ret			;8909
jefe_4_fin_salto:
	ld (ix+010h),000h		;890a
	set 4,(ix+010h)		;890e
	jp 07f3eh		;8912   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS jefe_4_salto: Las alturas del salto del jefe de la fase 0x0B, hasta
;   0xFF
;   0x8915..0x8963  (78 bytes)
DATA_jefe_4_salto:
	defb 007h,007h,007h,007h,005h,005h,005h,004h,004h,004h,004h,004h,004h,004h,002h,002h	; 8915  ................
	defb 002h,002h,002h,002h,002h,002h,001h,001h,001h,001h,001h,001h,001h,001h,000h,000h	; 8925  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 8935  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fch,0fch	; 8945  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0fbh,0fbh,0f9h,0f9h,0f9h,0f9h,0ffh	; 8955  ..............

; ======================================================================
; CODIGO 0x8963..0x8a9a  (311 bytes)
; ======================================================================


jefe_4_esquiva:
	set 2,(ix+010h)		;8963   ; +10: bits 2 y 4, fuera el 0 y el 1
	set 4,(ix+010h)		;8967
	res 0,(ix+010h)		;896b
	res 1,(ix+010h)		;896f
	ld a,(ix+006h)		;8973
jefe_4_salta_b:
	ld a,(ix+006h)		;8976   ; en los bordes, da la vuelta
	cp 010h		;8979
	call c,07e18h		;897b   ; p03 da_la_vuelta
	cp 0dch		;897e
	call nc,07e18h		;8980   ; p03 da_la_vuelta
	set 2,(ix+001h)		;8983   ; pose del bit 2 y +10 bit 3
	res 1,(ix+001h)		;8987
	set 3,(ix+010h)		;898b
	ld hl,081b8h		;898f   ; la lista de p04:81B8 (la del jefe de la fase 2)
	bit 2,(ix+010h)		;8992
	call nz,jefe_4_sigue_salto_b		;8996
	ld a,(hl)			;8999   ; 0xFF: aterriza
	cp 0ffh		;899a
	jp z,jefe_4_fin_salto		;899c
	ld a,(ix+007h)		;899f   ; y - el paso
	ld b,(hl)			;89a2
	inc hl			;89a3
	sub b			;89a4
	ld (ix+007h),a		;89a5
	set 1,(ix+010h)		;89a8
	ld (ix+015h),h		;89ac
	ld (ix+014h),l		;89af
	ld a,(ix+006h)		;89b2   ; en el borde izquierdo da la vuelta
	cp 010h		;89b5
	call c,07e18h		;89b7   ; p03 da_la_vuelta
	call 07e83h		;89ba   ; 2 pixeles
	jp 07f3eh		;89bd   ; p03 anima_actor0
jefe_4_sigue_salto_b:
	ld h,(ix+015h)		;89c0
	ld l,(ix+014h)		;89c3
	ret			;89c6
jefe_4_borde_izq:
	ld (ix+006h),011h		;89c7   ; x = 0x11
	jp 07f3eh		;89cb   ; p03 anima_actor0

; ----------------------------------------------------------------------
; JEFE DE LA FASE 0x0E (tipo 5): 0x190 de vida, en (0x96, 0x50). Va y viene
; entre x = 0x20 y 0xB4 y, a 0x48 de Rastan, lanza un proyectil (el actor
; 3, con la lista de pasos de p04:8BCF) con los efectos 0x0F y 0x0E.
; ----------------------------------------------------------------------
jefe_fase_0e:
	ld ix,0d933h		;89ce   ; ix -> los 6 actores de la pantalla
	ld a,(ix+000h)		;89d2   ; ya muerto: p03:7FDA
	cp 007h		;89d5
	jp z,07fdah		;89d7   ; p03 actor0_a_tipo7
	ld a,(ix+006h)		;89da   ; aun no ha salido...
	and a			;89dd
	jp nz,jefe_5_mueve		;89de
	ld hl,00190h		;89e1   ; ...0x190 de vida...
	ld (0d969h),hl		;89e4   ; actor 1, byte +10 = hl
	ld (ix+007h),050h		;89e7   ; ...en (0x96, 0x50)...
	ld (ix+006h),096h		;89eb
	ld hl,0d910h		;89ef   ; ...pelea con un jefe...
	set 6,(hl)		;89f2
	ld (ix+000h),005h		;89f4   ; ...tipo 5, pose 1
	ld (ix+001h),001h		;89f8
	push ix		;89fc
	call 07f1fh		;89fe   ; p03 anima_actor0_desde_cero
	pop ix		;8a01
	jp 07f3eh		;8a03   ; p03 anima_actor0
jefe_5_mueve:
	ld (ix+000h),005h		;8a06
	ld hl,0d910h		;8a0a   ; pelea con un jefe
	set 6,(hl)		;8a0d
	ld a,(0d969h)		;8a0f   ; sin vida: muere
	ld b,a			;8a12
	ld a,(0d96ah)		;8a13   ; a = actor 1, byte +11
	or b			;8a16
	jp z,07fdah		;8a17   ; p03 actor0_a_tipo7
	ld a,(0d9bah)		;8a1a   ; su proyectil en vuelo: se mueve
	cp 00fh		;8a1d
	call z,proyectil_jefe_5		;8a1f
	bit 2,(ix+001h)		;8a22   ; sin la pose del bit 2: tambien
	call z,proyectil_jefe_5		;8a26
	call jefe_1_suelo		;8a29   ; nada debajo: cae
	cp 0ffh		;8a2c
	jp z,07e5ah		;8a2e   ; p03 cae_2_especial
	ld a,(0d96bh)		;8a31   ; le acaban de dar: p04:8B55
	and a			;8a34
	jp nz,jefe_5_tocado		;8a35
	ld a,(ix+006h)		;8a38   ; en x < 0x20 o >= 0xB4: da la vuelta
	cp 020h		;8a3b
	call c,07e18h		;8a3d   ; p03 da_la_vuelta
	cp 0b4h		;8a40
	call nc,07e18h		;8a42   ; p03 da_la_vuelta
	call distancia_jefe_5		;8a45   ; a cuanto esta de Rastan (p04:8B19)
	cp 048h		;8a48   ; justo 0x48: lanza
	call z,jefe_5_lanza		;8a4a
	ld a,(ix+001h)		;8a4d   ; solo el bit del lado en la pose
	and 001h		;8a50
	ld (ix+001h),a		;8a52
	call jefe_aleja_1		;8a55   ; un pixel hacia atras
	jp 07f3eh		;8a58   ; p03 anima_actor0
jefe_5_lanza:
	ld a,(0d9bah)		;8a5b   ; ya hay proyectil: nada
	cp 00fh		;8a5e
	jp z,07f3eh		;8a60   ; p03 anima_actor0
	ld a,00fh		;8a63   ; efecto 0x0F
	ld (0d178h),a		;8a65   ; efecto pedido, para p01:63E1 = a
	ld a,(ix+001h)		;8a68   ; pose 2 con el lado
	and 001h		;8a6b
	or 002h		;8a6d
	ld (ix+001h),a		;8a6f
	set 0,(ix+010h)		;8a72   ; +10 bit 0
	push ix		;8a76
	call 07f3eh		;8a78   ; un paso de animacion
	pop ix		;8a7b
	ld a,(0d9bah)		;8a7d   ; sin proyectil: sale
	and a			;8a80
	jp z,proyectil_jefe_5		;8a81
	ld a,00eh		;8a84   ; efecto 0x0E
	ld (0d178h),a		;8a86   ; efecto pedido, para p01:63E1 = a
	ld a,(ix+001h)		;8a89   ; pose 6 con el lado
	and 001h		;8a8c
	or 006h		;8a8e
	ld (ix+001h),a		;8a90
	set 1,(ix+010h)		;8a93   ; +10 bit 1
	jp 07f3eh		;8a97   ; p03 anima_actor0

; ----------------------------------------------------------------------
; DATOS resto_8A9A: 127 bytes de codigo que nadie ejecuta (otra version del
;   jefe 5)
;   0x8a9a..0x8b19  (127 bytes)
DATA_resto_8A9A:
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


distancia_jefe_5:
	ld a,(0d8fch)		;8b19   ; B = x de Rastan + 0x10
	add a,010h		;8b1c
	ld b,a			;8b1e
	ld a,(ix+006h)		;8b1f   ; C = x del jefe + 0x18
	add a,018h		;8b22
	ld c,a			;8b24
	bit 0,(ix+001h)		;8b25   ; mirando a la izquierda: C - B
	jr z,distancia_jefe_5_der		;8b29
	ld a,c			;8b2b
	sub b			;8b2c
	ret			;8b2d
distancia_jefe_5_der:
	ld a,b			;8b2e   ; a la derecha: B - C
	sub c			;8b2f
	ret			;8b30

; ----------------------------------------------------------------------
; DATOS resto_8B31: 36 bytes que nadie ejecuta
;   0x8b31..0x8b55  (36 bytes)
DATA_resto_8B31:
	defb 0ddh,07eh,006h,0c6h,018h,047h,03ah,0fch,0d8h,0c6h,010h,04fh,0ddh,0cbh,001h,046h	; 8b31  .~...G:....O...F
	defb 028h,009h,078h,091h,038h,002h,0afh,0c9h,03eh,0ffh,0c9h,079h,090h,038h,002h,0afh	; 8b41  (.x.8...>..y.8..
	defb 0c9h,03eh,0ffh,0c9h	; 8b51

; ======================================================================
; CODIGO 0x8b55..0x8bcf  (122 bytes)
; ======================================================================


jefe_5_tocado:
	ld a,00eh		;8b55   ; efecto 0x0E
	ld (0d178h),a		;8b57   ; efecto pedido, para p01:63E1 = a
	xor a			;8b5a   ; D96B a 0
	ld (0d96bh),a		;8b5b   ; actor 1, byte +12 = a
	ld a,(ix+001h)		;8b5e   ; pose 6 con el lado
	and 001h		;8b61
	or 006h		;8b63
	ld (ix+001h),a		;8b65
	jp 07f3eh		;8b68   ; p03 anima_actor0
proyectil_jefe_5:
	push ix		;8b6b   ; IY = el jefe, IX = el actor 3
	push ix		;8b6d
	pop iy		;8b6f
	ld ix,0d9a5h		;8b71   ; ix -> actor 3
	ld a,(ix+015h)		;8b75   ; +15 = 0: aun no ha salido
	and a			;8b78
	jr z,lanza_proyectil_jefe_5		;8b79
	cp 00fh		;8b7b   ; en vuelo: lo mueve p03:6A29 (el del tipo 3)
	jp 06a29h		;8b7d   ; p03 mueve_proyectil_03
lanza_proyectil_jefe_5:
	bit 7,(iy+002h)		;8b80   ; la animacion de lanzar ha acabado?
	jp z,069e3h		;8b84   ; p03 proyectil_03_fin
	ld (ix+015h),00fh		;8b87   ; en vuelo
	call coloca_proyectil_jefe_5		;8b8b   ; se coloca
	ld hl,08bcfh		;8b8e   ; la lista de pasos de p04:8BCF
	ld (0d9b5h),hl		;8b91   ; actor 3, byte +10 = hl
	push ix		;8b94
	call 048f9h		;8b96   ; alta y pintado
	pop ix		;8b99
	call 04a8bh		;8b9b   ; p00 pinta_actor
	pop ix		;8b9e
	ret			;8ba0
coloca_proyectil_jefe_5:
	ld a,(iy+001h)		;8ba1   ; el mismo lado que el jefe
	ld (ix+012h),a		;8ba4
	bit 0,(iy+001h)		;8ba7   ; a la izquierda: x - 0x20
	jr z,coloca_jefe_5_der		;8bab
	ld a,(iy+006h)		;8bad
	sub 020h		;8bb0
	ld (ix+006h),a		;8bb2
	jr coloca_jefe_5_y		;8bb5
coloca_jefe_5_der:
	ld a,(iy+006h)		;8bb7   ; a la derecha: x + 0x40
	add a,040h		;8bba
	ld (ix+006h),a		;8bbc
coloca_jefe_5_y:
	ld a,(iy+007h)		;8bbf   ; la misma y, tipo 0x16, pose bit 3
	ld (ix+007h),a		;8bc2
	ld a,016h		;8bc5
	ld (ix+000h),a		;8bc7
	set 3,(ix+001h)		;8bca
	ret			;8bce

; ----------------------------------------------------------------------
; DATOS pasos_proyectil_jefe: Los pasos (x, y) del proyectil del tipo 3 y del
;   jefe 5, hasta 0xFF
;   0x8bcf..0x8bf4  (37 bytes)
DATA_pasos_proyectil_jefe:
	defb 000h,000h,000h,002h,001h,002h,000h,002h,000h,002h,001h,002h,002h,002h,002h,002h	; 8bcf  ................
	defb 002h,002h,000h,002h,002h,002h,002h,002h,001h,002h,000h,002h,001h,002h,000h,002h	; 8bdf  ................
	defb 002h,002h,002h,002h,0ffh	; 8bef

; ======================================================================
; CODIGO 0x8bf4..0x8d01  (269 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Las fases 0x12-0x16 repiten los cinco jefes, cada uno en una pantalla
; concreta; en las demas pantallas, los actores de siempre (p03:6021...).
; ----------------------------------------------------------------------
jefe_fase_12:
	ld a,(0d5f0h)		;8bf4   ; columna 5, fila 0: el jefe de la fase 2
	cp 005h		;8bf7
	jp nz,06021h		;8bf9
	ld a,(0d5f1h)		;8bfc   ; a = la fila de la pantalla en que se esta
	and a			;8bff
	jp nz,06021h		;8c00
	jp jefe_fase_2		;8c03
jefe_fase_13:
	ld a,(0d5f0h)		;8c06   ; columna 4, fila 0: el de la fase 5
	cp 004h		;8c09
	jp nz,06026h		;8c0b
	ld a,(0d5f1h)		;8c0e   ; a = la fila de la pantalla en que se esta
	and a			;8c11
	jp nz,06026h		;8c12
	jp jefe_fase_5		;8c15
jefe_fase_14:
	ld a,(0d5f0h)		;8c18   ; columna 5, fila 0: el de la fase 8
	cp 005h		;8c1b
	jp nz,0602bh		;8c1d
	ld a,(0d5f1h)		;8c20   ; a = la fila de la pantalla en que se esta
	and a			;8c23
	jp nz,0602bh		;8c24
	jp jefe_fase_8		;8c27
jefe_fase_15:
	ld a,(0d5f0h)		;8c2a   ; columna 5, fila 1: el de la fase 0x0B
	cp 005h		;8c2d
	jp nz,06030h		;8c2f
	ld a,(0d5f1h)		;8c32   ; a = la fila de la pantalla en que se esta
	dec a			;8c35
	jp nz,06030h		;8c36
	jp jefe_fase_0b		;8c39
jefe_fase_16:
	ld a,(0d5f0h)		;8c3c   ; columna 3, fila 0: el de la fase 0x0E
	cp 003h		;8c3f
	jp nz,06035h		;8c41
	ld a,(0d5f1h)		;8c44   ; a = la fila de la pantalla en que se esta
	and a			;8c47
	jp nz,06035h		;8c48
	jp jefe_fase_0e		;8c4b

; ----------------------------------------------------------------------
; EL FINAL (fase 0x17). Musica 5, la pantalla en blanco y el texto de
; p04:8D01 subiendo linea a linea con el desplazamiento vertical; al acabar,
; el rotulo de Taito, y el juego se queda ahi para siempre.
; ----------------------------------------------------------------------
final:
	ld a,005h		;8c4e   ; la musica 5
	ld (0d17ah),a		;8c50   ; musica pedida, para p01:640F = a
	call 0431fh		;8c53   ; VRAM a 0
	xor a			;8c56   ; D933, D934 y D935: la linea, el texto y el fin
	ld (0d933h),a		;8c57   ; los 6 actores de la pantalla = a
	ld (0d934h),a		;8c5a   ; actor 0, byte +1 = a
	ld (0d935h),a		;8c5d   ; actor 0, byte +2 = a
	ld c,008h		;8c60   ; R#8 = 0x2A
	ld b,02ah		;8c62
	call 00047h		;8c64   ; BIOS WRTVDP - Writes data in the VDP-register
final_linea:
	ld hl,01f40h		;8c67   ; una espera de 8000 vueltas
L_8C6A:
	dec hl			;8c6a
	ld a,h			;8c6b
	or l			;8c6c
	jr nz,L_8C6A		;8c6d
	call sube_una_linea		;8c6f   ; una linea mas de desplazamiento
	call linea_de_texto		;8c72   ; y si toca, la linea de texto siguiente
	call 00044h		;8c75   ; BIOS ENASCR - Displays the screen | pantalla encendida
	ld a,(0d935h)		;8c78   ; hasta el 0xFF de la lista
	cp 0ffh		;8c7b
	jr nz,final_linea		;8c7d
	ld hl,05227h		;8c7f   ; el rotulo de Taito (p00:5227)...
	ld de,00000h		;8c82
	ld b,010h		;8c85
	ld c,050h		;8c87
	ld a,0aah		;8c89   ; ...en (0x58, 0xAA)
	ld (0d5d7h),a		;8c8b   ; y donde se pinta = a
	ld a,058h		;8c8e
	ld (0d5d6h),a		;8c90   ; x donde se pinta = a
	exx			;8c93
	ld b,000h		;8c94
	exx			;8c96
	call 046c9h		;8c97   ; p00 pinta_bloque_tiles
fin_del_juego:
	jp fin_del_juego		;8c9a   ; bucle infinito: aqui se acaba
sube_una_linea:
	di			;8c9d
	call 0445dh		;8c9e   ; espera al VDP
	ld a,(0d933h)		;8ca1   ; una linea mas
	inc a			;8ca4
	ld (0d933h),a		;8ca5   ; los 6 actores de la pantalla = a
	ld b,a			;8ca8
	ld a,(00007h)		;8ca9   ; R#23 = la linea
	inc a			;8cac
	ld c,a			;8cad
	ld a,b			;8cae
	out (c),a		;8caf
	ld a,097h		;8cb1
	out (c),a		;8cb3
	ei			;8cb5
	ld a,(0d933h)		;8cb6   ; y la linea que entra por abajo, borrada (HMMV de 0 a 0xFE de ancho)
	ld l,a			;8cb9
	ld e,a			;8cba
	ld h,000h		;8cbb
	ld d,0feh		;8cbd
	xor a			;8cbf
	call 0440eh		;8cc0   ; p00 rellena_vram
	ret			;8cc3
linea_de_texto:
	ld a,(0d933h)		;8cc4   ; cada 16 lineas...
	and 00fh		;8cc7
	ret nz			;8cc9
	ld hl,08d01h		;8cca   ; ...el texto siguiente de p04:8D01
	ld a,(0d934h)		;8ccd   ; a = actor 0, byte +1
	inc a			;8cd0
	ld (0d934h),a		;8cd1   ; actor 0, byte +1 = a
	dec a			;8cd4
	add a,a			;8cd5
	ld e,a			;8cd6
	ld d,000h		;8cd7
	add hl,de			;8cd9
	ld e,(hl)			;8cda
	inc hl			;8cdb
	ld d,(hl)			;8cdc
	ex de,hl			;8cdd
	ld a,(hl)			;8cde   ; 0xFE: linea en blanco
	cp 0feh		;8cdf
	ret z			;8ce1
	cp 0ffh		;8ce2   ; 0xFF: se acabo
	jr nz,escribe_linea_final		;8ce4
	ld (0d935h),a		;8ce6   ; actor 0, byte +2 = a
	ret			;8ce9
escribe_linea_final:
	ld c,a			;8cea   ; la x de la linea
	inc hl			;8ceb
	ld a,(0d933h)		;8cec   ; y la y, 16 por encima de la que entra
	sub 010h		;8cef
	ld b,a			;8cf1
	ld (0d5dbh),bc		;8cf2   ; la lista o la cadena que se esta pintando = bc
letra_final:
	ld a,(hl)			;8cf6   ; hasta el 0
	and a			;8cf7
	ret z			;8cf8
	push hl			;8cf9
	call 04633h		;8cfa   ; una letra
	pop hl			;8cfd
	inc hl			;8cfe
	jr letra_final		;8cff

; ----------------------------------------------------------------------
; DATOS final_lineas: Las 54 lineas del final: la direccion de cada una
;   0x8d01..0x8d6d  (108 bytes)
DATA_final_lineas:
	defw 08d6dh,08d7eh,08d7fh,08d80h,08d81h,08d82h,08d81h,08d81h	; 8d01
	defw 08d89h,08d95h,08da4h,08daeh,08dbah,08dc4h,08dc5h,08dd5h	; 8d11
	defw 08de1h,08de2h,08dedh,08df9h,08e07h,08e08h,08e0fh,08e20h	; 8d21
	defw 08e2fh,08e30h,08e3ah,08e47h,08e48h,08e5bh,08e64h,08e65h	; 8d31
	defw 08e66h,08e67h,08e68h,08e69h,08e6ah,08e6bh,08e6ch,08e6dh	; 8d41
	defw 08e6eh,08e6fh,08e7ch,08e7dh,08e7eh,08e7fh,08e80h,08e9ah	; 8d51
	defw 08eafh,08eb0h,08eb1h,08eb2h,08eb3h,08eb4h	; 8d61

; ----------------------------------------------------------------------
; DATOS final_textos: Los textos del final (x y cadena, 0xFE en blanco, 0xFF
;   fin): CONGRATURATIONS, STAFF, PROGRAMMER N SANTA SATOU, TED AONO, M M
;   ATSUJI, K H KUME, CONVERT DESIGN S IWABUCHI, CHARACTOR S IWABUCHI, MR
;   NISHIMURA, SOUND SPRATTER AIZAWA, YAG YAGISHITA, PRODUCER S TAKAHASHI,
;   SPETIAL THANKS TO TMR WIN, PRODUCED BY @ TAITO CORPORATION 1988, ALL
;   RIGHTS RESERVED
;   0x8d6d..0x8eb5  (328 bytes)
DATA_final_textos:
	defb 040h,043h,04fh,04eh,047h,052h,041h,054h,055h,052h,041h,054h,049h,04fh,04eh,053h	; 8d6d  @CONGRATURATIONS
	defb 000h,0feh,0feh,0feh,0feh,078h,053h,054h,041h,046h,046h,000h,038h,050h,052h,04fh	; 8d7d  .....xSTAFF.8PRO
	defb 047h,052h,041h,04dh,04dh,045h,052h,000h,060h,04eh,020h,053h,041h,04eh,054h,041h	; 8d8d  GRAMMER.`N SANTA
	defb 020h,053h,041h,054h,04fh,055h,000h,060h,054h,045h,044h,020h,041h,04fh,04eh,04fh	; 8d9d   SATOU.`TED AONO
	defb 000h,060h,04dh,020h,04dh,020h,041h,054h,053h,055h,04ah,049h,000h,060h,04bh,020h	; 8dad  .`M M ATSUJI.`K
	defb 048h,020h,04bh,055h,04dh,045h,000h,0feh,038h,043h,04fh,04eh,056h,045h,052h,054h	; 8dbd  H KUME..8CONVERT
	defb 020h,044h,045h,053h,049h,047h,04eh,000h,060h,053h,020h,049h,057h,041h,042h,055h	; 8dcd   DESIGN.`S IWABU
	defb 043h,048h,049h,000h,0feh,038h,043h,048h,041h,052h,041h,043h,054h,04fh,052h,000h	; 8ddd  CHI..8CHARACTOR.
	defb 060h,053h,020h,049h,057h,041h,042h,055h,043h,048h,049h,000h,060h,04dh,052h,020h	; 8ded  `S IWABUCHI.`MR
	defb 04eh,049h,053h,048h,049h,04dh,055h,052h,041h,000h,0feh,038h,053h,04fh,055h,04eh	; 8dfd  NISHIMURA..8SOUN
	defb 044h,000h,060h,053h,050h,052h,041h,054h,054h,045h,052h,020h,041h,049h,05ah,041h	; 8e0d  D.`SPRATTER AIZA
	defb 057h,041h,000h,060h,059h,041h,047h,020h,059h,041h,047h,049h,053h,048h,049h,054h	; 8e1d  WA.`YAG YAGISHIT
	defb 041h,000h,0feh,038h,050h,052h,04fh,044h,055h,043h,045h,052h,000h,060h,053h,020h	; 8e2d  A..8PRODUCER.`S
	defb 054h,041h,04bh,041h,048h,041h,053h,048h,049h,000h,0feh,038h,053h,050h,045h,054h	; 8e3d  TAKAHASHI..8SPET
	defb 049h,041h,04ch,020h,054h,048h,041h,04eh,04bh,053h,020h,054h,04fh,000h,060h,054h	; 8e4d  IAL THANKS TO.`T
	defb 04dh,052h,020h,057h,049h,04eh,000h,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 8e5d  MR WIN..........
	defb 0feh,0feh,050h,050h,052h,04fh,044h,055h,043h,045h,044h,020h,042h,059h,000h,0feh	; 8e6d  ..PPRODUCED BY..
	defb 0feh,0feh,0feh,018h,040h,020h,054h,041h,049h,054h,04fh,020h,043h,04fh,052h,050h	; 8e7d  ....@ TAITO CORP
	defb 04fh,052h,041h,054h,049h,04fh,04eh,020h,031h,039h,038h,038h,000h,030h,041h,04ch	; 8e8d  ORATION 1988.0AL
	defb 04ch,020h,052h,049h,047h,048h,054h,053h,020h,052h,045h,053h,045h,052h,056h,045h	; 8e9d  L RIGHTS RESERVE
	defb 044h,000h,0feh,0feh,0feh,0feh,0feh,0ffh	; 8ead  D.......

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8eb5..0xa000  (4427 bytes)
DATA_8EB5:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8eb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ec5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ed5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ee5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ef5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8f95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fa5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8fe5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8ff5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9005  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9015  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9025  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9035  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9045  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9055  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9065  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9075  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9085  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9095  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 90f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9105  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9115  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9125  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9135  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9145  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9155  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9165  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9175  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9185  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9195  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 91f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9205  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9215  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9225  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9235  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9245  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9255  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9265  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9275  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9285  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9295  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 92f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9305  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9315  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9325  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9335  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9345  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9355  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9365  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9375  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9385  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9395  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 93f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9405  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9415  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9425  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9435  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9445  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9455  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9465  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9475  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9485  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9495  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 94f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9505  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9515  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9525  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9535  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9545  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9555  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9565  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9575  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9585  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9595  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 95f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9605  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9615  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9625  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9635  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9645  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9655  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9665  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9675  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9685  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9695  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 96f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9705  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9715  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9725  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9735  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9745  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9755  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9765  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9775  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9785  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9795  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9805  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9815  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9825  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9835  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9845  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9855  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9865  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9875  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9885  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9895  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9905  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9915  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9925  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9935  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9945  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9955  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9965  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9975  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9985  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9995  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99a5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99b5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99c5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99d5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99e5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99f5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9aa5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ab5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ac5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ad5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ae5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9af5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ba5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9be5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bf5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ca5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ce5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cf5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9da5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9db5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9de5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9df5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ea5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9eb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ec5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ed5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ee5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ef5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f05  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f15  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f25  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f35  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f45  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f55  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f65  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f75  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f85  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f95  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fa5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fb5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fc5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fd5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fe5  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ff5  ...........
