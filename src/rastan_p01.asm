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



; ----------------------------------------------------------------------
; Pone en la pagina 2 (0x8000) el slot del cartucho, el mismo que la pagina 1
; en la que corre: asi los bancos de 0x8000 y 0xA000 se ven.
; ----------------------------------------------------------------------
cartucho_en_pagina_2:
	call 00138h		;6000   ; BIOS RSLREG - Reads the primary slot register | el registro de slots primarios...
	rrca			;6003   ; ...los bits de la pagina 1: el slot del cartucho
	rrca			;6004
	and 003h		;6005   ; 0-3
	ld c,a			;6007   ; BC = el slot primario
	ld b,000h		;6008
	ld hl,0fcc1h		;600a   ; EXPTBL: si ese slot esta expandido (bit 7)...
	add hl,bc			;600d   ; EXPTBL + slot
	or (hl)			;600e   ; con su bit de expandido
	jp p,en_pagina_2		;600f   ; no expandido: ya esta
	ld c,a			;6012   ; ...se le anade el subslot de SLTTBL (bits 2-3)
	inc hl			;6013   ; SLTTBL (EXPTBL + 4)
	inc hl			;6014
	inc hl			;6015
	inc hl			;6016
	ld a,(hl)			;6017   ; el registro de subslots de ese slot...
	and 00ch		;6018   ; ...el subslot de la pagina 1 (bits 2-3)
	or c			;601a   ; A = 1000SSPP: slot y subslot
en_pagina_2:
	ld h,080h		;601b   ; H = 0x80: la pagina 2
	jp 00024h		;601d   ; BIOS ENASLT - Switches to specified slot and page definitively | ENASLT

; ----------------------------------------------------------------------
; El VDP: todos los registros a 0, SCREEN 5 (256x212, 16 colores),
; pantalla apagada y los 12 registros de p01:605F.
; ----------------------------------------------------------------------
prepara_vdp:
	ld b,017h		;6020   ; de R#23 a R#1...
L_6022:
	push bc			;6022   ; B, guardado
	ld c,b			;6023   ; ...a 0
	ld b,000h		;6024   ; B = 0: el valor
	call 00047h		;6026   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;6029   ; B de vuelta
	djnz L_6022		;602a   ; hasta R#1
	ld c,000h		;602c   ; y R#0 = 0
	ld b,000h		;602e   ; R#0 = 0
	call 00047h		;6030   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,005h		;6033   ; SCREEN 5
	call 0005fh		;6035   ; BIOS CHGMOD - Switches to given screen mode
	ld a,(0f3e0h)		;6038   ; R#1: sprites de 16x16 y pantalla apagada (bits 6, 5 y 1)
	or 062h		;603b   ; bits 6 (pantalla), 5 (interrupcion) y 1 (sprites de 16x16)...
	and 0beh		;603d   ; ...sin el 6 ni el 0: pantalla apagada, sin ampliar
	ld (0f3e0h),a		;603f   ; RG1SAV
	ld c,001h		;6042   ; escrito
	ld b,a			;6044   ; B = el valor
	call 00047h		;6045   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0605fh		;6048   ; los 12 pares (registro, valor) de p01:605F
	ld b,00ch		;604b   ; 12 pares
L_604D:
	push bc			;604d   ; B guardado
	ld c,(hl)			;604e   ; C = registro
	inc hl			;604f
	ld b,(hl)			;6050   ; B = valor
	inc hl			;6051
	push hl			;6052   ; HL guardado
	call 00047h		;6053   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;6056   ; HL de vuelta
	pop bc			;6057   ; B de vuelta
	djnz L_604D		;6058   ; el siguiente
	xor a			;605a   ; CLIKSW (F3DB) = 0: las teclas no hacen clic
	ld (0f3dbh),a		;605b   ; CLIKSW
	ret			;605e   ; vuelve

; ----------------------------------------------------------------------
; DATOS registros_vdp: 12 pares (registro, valor): R#2 0x1F, R#11 1, R#5 0x0F,
;   R#6 0x11, R#7 0, R#8 0x28, R#9 0x80 (212 lineas), R#14 3, R#18 0, R#20 0,
;   R#21 0x3B, R#22 5
;   0x605f..0x6077  (24 bytes)
DATA_registros_vdp:
	defb 002h,01fh	; 605f
	defb 00bh,001h	; 6061
	defb 005h,00fh	; 6063
	defb 006h,011h	; 6065
	defb 007h,000h	; 6067
	defb 008h,028h	; 6069
	defb 009h,080h	; 606b
	defb 00eh,003h	; 606d
	defb 012h,000h	; 606f
	defb 014h,000h	; 6071
	defb 015h,03bh	; 6073
	defb 016h,005h	; 6075

; ======================================================================
; CODIGO 0x6077..0x6478  (1025 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Los graficos a la VRAM: la borra entera, copia los bancos 0x12-0x15 a la
; pagina 0 y de ahi a la 2, los 0x16-0x19 igual a la 3, y los 0x10-0x11 a
; la mitad de abajo de la pagina 1 (los tiles de 8x8).
; ----------------------------------------------------------------------
carga_graficos:
	ld hl,00000h		;6077   ; los primeros 64 KB de VRAM a 0...
	ld bc,0ffffh		;607a   ; 64 KB
	xor a			;607d   ; de 0
	call 0016bh		;607e   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ld hl,0ffffh		;6081   ; ...y los otros 64 KB
	ld bc,0ffffh		;6084   ; 64 KB mas
	call 0016bh		;6087   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ld a,012h		;608a   ; bancos 0x12 y 0x13 en 0x8000/0xA000
	ld (0d191h),a		;608c   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;608f   ; registro del mapper: banco A en 0x8000
	ld a,013h		;6092   ; banco 0x13 en 0xA000
	ld (0d192h),a		;6094   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;6097   ; registro del mapper: banco A en 0xA000
	ld hl,08000h		;609a   ; 16 KB a VRAM 0x0000
	ld de,00000h		;609d   ; a VRAM 0x0000
	ld bc,03fffh		;60a0   ; 16 KB
	call 0005ch		;60a3   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,014h		;60a6   ; bancos 0x14 y 0x15
	ld (0d191h),a		;60a8   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;60ab   ; registro del mapper: banco A en 0x8000
	ld a,015h		;60ae   ; banco 0x15 en 0xA000
	ld (0d192h),a		;60b0   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;60b3   ; registro del mapper: banco A en 0xA000
	ld hl,08000h		;60b6   ; 16 KB a VRAM 0x4000
	ld de,04000h		;60b9   ; a VRAM 0x4000
	ld bc,03fffh		;60bc   ; 16 KB
	call 0005ch		;60bf   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,000h		;60c2   ; de la pagina 0 a la 2 (A' = 2)...
	ex af,af'			;60c4   ; A' = 2: la pagina de destino
	ld a,002h		;60c5   ; (y A = 0: la de origen)
	ex af,af'			;60c7
	ld hl,00000h		;60c8   ; ...las 128 primeras lineas...
	ld de,080ffh		;60cb   ; 256 x 128
	ld bc,00000h		;60ce   ; al mismo sitio de la pagina 2
	call 044f1h		;60d1   ; p00 copia_bloque
	ld hl,08000h		;60d4   ; ...y las 128 siguientes
	ld de,080ffh		;60d7   ; 256 x 128
	ld bc,08000h		;60da   ; y = 128
	call 044f1h		;60dd   ; p00 copia_bloque
	ld a,016h		;60e0   ; bancos 0x16 y 0x17 a VRAM 0x0000
	ld (0d191h),a		;60e2   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;60e5   ; registro del mapper: banco A en 0x8000
	ld a,017h		;60e8   ; banco 0x17 en 0xA000
	ld (0d192h),a		;60ea   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;60ed   ; registro del mapper: banco A en 0xA000
	ld hl,08000h		;60f0   ; de 0x8000...
	ld de,00000h		;60f3   ; ...a VRAM 0x0000...
	ld bc,03fffh		;60f6   ; ...16 KB
	call 0005ch		;60f9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,018h		;60fc   ; bancos 0x18 y 0x19 a VRAM 0x4000
	ld (0d191h),a		;60fe   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;6101   ; registro del mapper: banco A en 0x8000
	ld a,019h		;6104   ; banco 0x19
	ld (0d192h),a		;6106   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;6109   ; registro del mapper: banco A en 0xA000
	ld hl,08000h		;610c   ; de 0x8000...
	ld de,04000h		;610f   ; ...a VRAM 0x4000...
	ld bc,03fffh		;6112   ; ...16 KB
	call 0005ch		;6115   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld a,000h		;6118   ; y de la pagina 0 a la 3
	ex af,af'			;611a
	ld a,003h		;611b   ; A' = 3: la pagina de destino
	ex af,af'			;611d
	ld hl,00000h		;611e   ; de (0, 0)...
	ld de,080ffh		;6121   ; ...256 x 128...
	ld bc,00000h		;6124   ; ...a (0, 0) de la pagina 3
	call 044f1h		;6127   ; p00 copia_bloque
	ld hl,08000h		;612a   ; de (0, 128)...
	ld de,080ffh		;612d   ; ...256 x 128...
	ld bc,08000h		;6130   ; ...a (0, 128)
	call 044f1h		;6133   ; p00 copia_bloque
	ld a,010h		;6136   ; bancos 0x10 y 0x11...
	ld (0d191h),a		;6138   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;613b   ; registro del mapper: banco A en 0x8000
	ld a,011h		;613e   ; banco 0x11 en 0xA000
	ld (0d192h),a		;6140   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;6143   ; registro del mapper: banco A en 0xA000
	ld hl,08000h		;6146   ; ...a VRAM 0xC000: la mitad de abajo de la pagina 1
	ld de,0c000h		;6149   ; de -> contador de la tarea 0
	ld bc,03fffh		;614c   ; 16 KB
	call 0005ch		;614f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;6152   ; vuelve

; ----------------------------------------------------------------------
; EL SONIDO, cada cuadro (desde la interrupcion). Primero los registros del
; PSG con lo que dejo el cuadro anterior (D161-D16B), luego cuatro voces de
; 25 bytes en D08E: tres de musica y la de los efectos.
; ----------------------------------------------------------------------
sonido:
	ld a,(0d069h)		;6153   ; D069 bit 7: sonido apagado
	or a			;6156   ; bit 7?
	ret m			;6157   ; si: apagado
	ld hl,0d16bh		;6158   ; los volumenes de los tres canales (D169-D16B)...
	ld b,003h		;615b   ; tres canales
L_615D:
	ld a,(0d067h)		;615d   ; ...mas el ajuste de D067...
	add a,(hl)			;6160   ; volumen del canal + ajuste
	dec hl			;6161   ; el canal anterior
	jp p,L_6166		;6162   ; ...sin bajar de 0
	sub a			;6165   ; negativo: 0
L_6166:
	ld e,a			;6166   ; E = el volumen
	ld a,b			;6167   ; a los registros 8, 9 y 10 del PSG
	add a,007h		;6168   ; registro 8, 9 o 10
	call escribe_psg		;616a   ; escrito
	djnz L_615D		;616d   ; los tres
	ld b,008h		;616f   ; 8 registros
registros_psg:
	ld e,(hl)			;6171   ; y los registros 7 a 0 (mezclador, ruido y tonos)
	dec hl			;6172   ; hacia atras
	ld a,b			;6173   ; registro 7 al 0
	dec a			;6174
	call escribe_psg		;6175   ; escrito
	djnz registros_psg		;6178   ; los ocho
	ld iy,0d08eh		;617a   ; IY = la primera voz
	ld de,00019h		;617e   ; 25 bytes por voz, cuatro voces
	ld b,004h		;6181   ; cuatro voces
cada_voz:
	exx			;6183   ; B' = las que quedan
	ld a,(iy+000h)		;6184   ; voz apagada
	or a			;6187   ; 0?
	jp z,siguiente_voz		;6188   ; si: la siguiente
	dec (iy+002h)		;618b   ; la nota sigue sonando?
	jp z,partitura		;618e   ; ...acabada: la siguiente (p01:6253)
	dec (iy+006h)		;6191   ; la envolvente de volumen: aun no toca cambiar
	jr nz,vibrato		;6194   ; aun no: el vibrato
	dec (iy+004h)		;6196   ; el paso de la envolvente se acaba?
	jr nz,cambia_volumen		;6199   ; aun quedan cambios en este paso
	ld l,(iy+00ch)		;619b   ; la envolvente (+0C/+0D)...
	ld h,(iy+00dh)		;619e   ; HL = la envolvente
	ld a,(iy+005h)		;61a1   ; ...en su paso (+5)
	add a,a			;61a4   ; paso * 2
	ld c,a			;61a5
	ld b,000h		;61a6
	add hl,bc			;61a8   ; HL = su paso
	ld a,(hl)			;61a9   ; un 0 la hace volver al principio
	or a			;61aa   ; 0: fin de la envolvente
	jr nz,paso_envolvente		;61ab   ; no: este paso
	ld (iy+005h),a		;61ad   ; paso 0...
	sbc hl,bc		;61b0   ; ...HL al principio...
	ld a,(hl)			;61b2   ; ...su primer byte
paso_envolvente:
	and 00fh		;61b3   ; nibble bajo: cuantos cuadros dura cada cambio
	ld (iy+014h),a		;61b5   ; +14 = cuadros por cambio
	ld a,(hl)			;61b8   ; nibble alto: cuantos cambios
	inc hl			;61b9   ; el mismo byte, nibble alto
	rrca			;61ba
	rrca			;61bb
	rrca			;61bc
	rrca			;61bd
	and 00fh		;61be
	ld (iy+004h),a		;61c0   ; +4 = cuantos cambios
	ld a,(hl)			;61c3   ; el byte de despues: cuanto cambia el volumen cada vez
	ld (iy+013h),a		;61c4   ; +13 = cuanto cambia
	inc (iy+005h)		;61c7   ; paso siguiente
cambia_volumen:
	ld a,(iy+012h)		;61ca   ; volumen + cambio...
	add a,(iy+013h)		;61cd   ; volumen + cambio
	jp pe,cuenta_envolvente		;61d0   ; ...si se desborda, no se toca
	ld (iy+012h),a		;61d3   ; apuntado
	ld e,a			;61d6   ; entre 0 y 15
	and 0f0h		;61d7   ; entre 0 y 15?
	jr z,pon_volumen		;61d9   ; si: tal cual
	jp m,volumen_cero		;61db   ; negativo: 0
	ld e,00fh		;61de   ; mas de 15: 15
	jr pon_volumen		;61e0   ; a ponerlo
volumen_cero:
	ld e,000h		;61e2   ; E = 0
pon_volumen:
	call volumen_canal		;61e4   ; al canal
cuenta_envolvente:
	ld a,(iy+014h)		;61e7   ; la cuenta de cuadros...
	ld (iy+006h),a		;61ea   ; ...otra vez desde el principio
vibrato:
	dec (iy+009h)		;61ed   ; la envolvente de tono (+0E/+0F), igual
	jr nz,siguiente_voz		;61f0   ; aun no: la siguiente voz
	dec (iy+007h)		;61f2   ; quedan cambios?
	jr nz,cambia_tono		;61f5   ; si: cambia el tono
	ld l,(iy+00eh)		;61f7   ; HL = la envolvente de tono
	ld h,(iy+00fh)		;61fa
	ld a,(iy+008h)		;61fd   ; su paso
	add a,a			;6200
	ld c,a			;6201
	ld b,000h		;6202
	add hl,bc			;6204
	ld a,(hl)			;6205   ; el byte
	or a			;6206
	jr nz,paso_vibrato		;6207   ; no es 0: este paso
	ld (iy+008h),a		;6209   ; 0: vuelta al principio
	sbc hl,bc		;620c
	ld a,(hl)			;620e   ; el primer byte
paso_vibrato:
	and 00fh		;620f
	ld (iy+018h),a		;6211   ; +18 = cuadros por cambio
	ld a,(hl)			;6214
	inc hl			;6215
	rrca			;6216
	rrca			;6217
	rrca			;6218
	rrca			;6219
	and 00fh		;621a   ; cuantos cambios...
	ld (iy+007h),a		;621c   ; ...en +7
	ld a,(hl)			;621f
	ld (iy+017h),a		;6220   ; +17 = cuanto cambia el tono
	inc (iy+008h)		;6223   ; paso siguiente
cambia_tono:
	ld l,(iy+015h)		;6226   ; el tono (+15/+16) + el cambio con signo
	ld h,(iy+016h)		;6229   ; HL = el tono
	ld a,(iy+017h)		;622c   ; el cambio...
	or a			;622f
	ld c,a			;6230   ; ...con signo:
	jp m,L_6238		;6231
	ld b,000h		;6234   ; positivo: B = 0
	jr L_623A		;6236
L_6238:
	ld b,0ffh		;6238   ; negativo: B = 0xFF
L_623A:
	add hl,bc			;623a   ; tono + cambio
	ld (iy+015h),l		;623b   ; guardado
	ld (iy+016h),h		;623e
	ex de,hl			;6241   ; DE = el tono
	call tono_canal		;6242   ; al canal
	ld a,(iy+018h)		;6245   ; la cuenta...
	ld (iy+009h),a		;6248   ; ...desde el principio
siguiente_voz:
	exx			;624b   ; B' de vuelta
	add iy,de		;624c   ; la voz siguiente (25 bytes)
	dec b			;624e   ; una menos
	jp nz,cada_voz		;624f   ; quedan
	ret			;6252

; ----------------------------------------------------------------------
; La partitura de una voz (+10/+11): bytes 1-0x7F = duracion y nota; 0 =
; fin; 0x80 elige envolvente, 0x81 la de tono, 0x82 salta, 0x83 llama,
; 0x84 vuelve, 0x85 repite, 0x90-0xBF empieza una repeticion, 0xC0-0xDF ruido,
; 0xE0-0xEF mezclador y 0xF0-0xFF volumen.
; ----------------------------------------------------------------------
partitura:
	ld l,(iy+010h)		;6253
	ld h,(iy+011h)		;6256
lee_partitura:
	ld a,(hl)			;6259
	inc hl			;625a
	or a			;625b   ; 0: se acabo
	jr z,fin_partitura		;625c
	jp p,nota		;625e   ; 1-0x7F: una nota
	cp 0f0h		;6261   ; 0xF0-0xFF: volumen
	jr nc,pon_volumen_voz		;6263
	cp 0e0h		;6265   ; 0xE0-0xEF: mezclador
	jp nc,pon_mezclador		;6267
	cp 0c0h		;626a   ; 0xC0-0xDF: ruido
	jr nc,pon_ruido		;626c
	cp 090h		;626e   ; 0x90-0xBF: empieza repeticion
	jp nc,empieza_repeticion		;6270
	cp 081h		;6273   ; 0x81: envolvente de tono
	jp z,pon_envolvente_tono		;6275
	jp c,pon_envolvente		;6278   ; 0x80: envolvente de volumen
	cp 083h		;627b   ; 0x83: llamada
	jr z,llamada_partitura		;627d
	jr c,salta_partitura		;627f   ; 0x82: salto
	cp 085h		;6281   ; 0x85: repeticion
	jp z,repite		;6283
	jr c,vuelta_partitura		;6286   ; 0x84: vuelta
guarda_partitura:
	ld (iy+010h),l		;6288   ; por donde va
	ld (iy+011h),h		;628b
	jr siguiente_voz		;628e
pon_ruido:
	and 01fh		;6290   ; la frecuencia del ruido (D167)
	ld (0d167h),a		;6292
	jr lee_partitura		;6295
salta_partitura:
	ld a,(hl)			;6297
	inc hl			;6298
	ld h,(hl)			;6299
	ld l,a			;629a
	jr lee_partitura		;629b
pon_volumen_voz:
	and 00fh		;629d   ; el volumen de partida (+3)
	ld (iy+003h),a		;629f
	jr lee_partitura		;62a2
fin_partitura:
	ld e,000h		;62a4   ; voz apagada: volumen y tono a 0
	ld d,000h		;62a6
	ld (iy+000h),e		;62a8
	call volumen_canal		;62ab
	call tono_canal		;62ae
	exx			;62b1   ; la voz 2...
	ld a,b			;62b2
	exx			;62b3
	cp 002h		;62b4
	jr nz,siguiente_voz		;62b6
	ld hl,0d068h		;62b8   ; ...si habia una musica guardada (D068 bit 7)...
	ld a,(hl)			;62bb
	or a			;62bc
	jp p,siguiente_voz		;62bd
	ld (hl),000h		;62c0
	ld hl,0d0f2h		;62c2   ; ...se recupera (D0F2 -> D06A): vuelve la musica de antes
	ld de,0d06ah		;62c5
	ld bc,0006fh		;62c8
	ldir		;62cb
	jp siguiente_voz		;62cd
vuelta_partitura:
	call pila_voz		;62d0   ; la pila de la voz (+0A/+0B)...
	ld a,(de)			;62d3   ; ...devuelve la direccion
	dec de			;62d4
	ld h,a			;62d5
	ld a,(de)			;62d6
	dec de			;62d7
	ld l,a			;62d8
guarda_pila:
	ld (iy+00ah),e		;62d9
	ld (iy+00bh),d		;62dc
	jp lee_partitura		;62df
llamada_partitura:
	call pila_voz		;62e2   ; guarda la vuelta en la pila de la voz...
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
	ld h,b			;62ef   ; ...y salta
	ld l,c			;62f0
	jr guarda_pila		;62f1
pon_mezclador:
	and 009h		;62f3   ; los bits de ruido y tono del canal...
	ld b,a			;62f5
	ld c,0f6h		;62f6
	ld a,(iy+001h)		;62f8   ; ...corridos segun la voz (+1)
	and 003h		;62fb
	jr z,guarda_mezclador		;62fd
corre_mezclador:
	rlc b		;62ff
	rlc c		;6301
	dec a			;6303
	jr nz,corre_mezclador		;6304
guarda_mezclador:
	ld de,0d168h		;6306   ; en D168 (el registro 7)
	ld a,(de)			;6309
	and c			;630a
	or b			;630b
	ld (de),a			;630c
	jp lee_partitura		;630d
empieza_repeticion:
	call pila_voz		;6310   ; a la pila: la direccion y la cuenta (byte - 0x90)
	inc de			;6313   ; un byte mas alla
	ex de,hl			;6314   ; HL = la pila, DE = la partitura
	ld (hl),e			;6315   ; la direccion...
	inc hl			;6316
	ld (hl),d			;6317   ; ...de vuelta
	inc hl			;6318
	sub 090h		;6319   ; la cuenta: el byte - 0x90...
	ld (hl),a			;631b   ; ...guardada
	ex de,hl			;631c   ; DE = la pila
	jr guarda_pila		;631d   ; guardada
repite:
	call pila_voz		;631f   ; una vuelta menos...
	ld a,(de)			;6322
	dec a			;6323
	jr z,fin_repeticion		;6324   ; ...ninguna: sigue
	ld (de),a			;6326   ; ...si no, otra vez desde el principio
	dec de			;6327
	ld a,(de)			;6328
	dec de			;6329
	ld h,a			;632a
	ld a,(de)			;632b
	ld l,a			;632c
	jp lee_partitura		;632d
fin_repeticion:
	dec de			;6330
	dec de			;6331
	dec de			;6332
	jr guarda_pila		;6333
pon_envolvente:
	ld a,(hl)			;6335   ; el numero...
	inc hl			;6336
	add a,a			;6337
	ld bc,06526h		;6338   ; ...en la tabla de p01:6526
	add a,c			;633b
	ld c,a			;633c
	jr nc,pon_envolvente_b		;633d
	inc b			;633f
pon_envolvente_b:
	ld a,(bc)			;6340   ; la envolvente, byte bajo...
	inc bc			;6341
	ld (iy+00ch),a		;6342   ; ...+0C
	ld a,(bc)			;6345   ; byte alto...
	ld (iy+00dh),a		;6346   ; ...+0D
	jp lee_partitura		;6349   ; el byte siguiente de la partitura
pon_envolvente_tono:
	ld a,(hl)			;634c
	inc hl			;634d
	add a,a			;634e
	ld bc,06571h		;634f   ; en la tabla de p01:6571
	add a,c			;6352
	ld c,a			;6353
	jr nc,pon_envolvente_tono_b		;6354
	inc b			;6356
pon_envolvente_tono_b:
	ld a,(bc)			;6357   ; la de tono, byte bajo...
	inc bc			;6358
	ld (iy+00eh),a		;6359   ; ...+0E
	ld a,(bc)			;635c   ; byte alto...
	ld (iy+00fh),a		;635d   ; ...+0F
	jp lee_partitura		;6360   ; sigue leyendo
nota:
	ld (iy+002h),a		;6363   ; la duracion
	ld a,(hl)			;6366   ; el tono (o, con el bit 7, un silencio)
	inc hl			;6367
	or a			;6368
	jp m,silencio		;6369
	ld d,a			;636c
	ld a,(hl)			;636d
	inc hl			;636e
	ld e,a			;636f
	push hl			;6370
	call tono_canal		;6371   ; al canal
	ld (iy+015h),e		;6374   ; apuntado en +15/+16
	ld (iy+016h),d		;6377
	ld a,(iy+003h)		;637a   ; el volumen de partida
	ld (iy+012h),a		;637d
	ld e,a			;6380
	call volumen_canal		;6381
	pop hl			;6384
	sub a			;6385   ; las envolventes desde el principio
	ld (iy+005h),a		;6386
	ld (iy+008h),a		;6389
	inc a			;638c
cuentas_a_uno:
	ld (iy+004h),a		;638d
	ld (iy+007h),a		;6390
	ld (iy+009h),a		;6393
	ld (iy+006h),a		;6396
	jp guarda_partitura		;6399
silencio:
	push hl			;639c   ; volumen 0
	ld e,000h		;639d
	call volumen_canal		;639f
	pop hl			;63a2
	ld a,0ffh		;63a3
	jr cuentas_a_uno		;63a5
volumen_canal:
	ld a,008h		;63a7   ; registro 8 + canal
	add a,(iy+001h)		;63a9
	ld c,a			;63ac
	jp p,guarda_volumen		;63ad   ; la voz de efectos (bit 7) solo suena si no hay efecto (D0D9)
	and 00fh		;63b0
	ld c,a			;63b2
	ld a,(0d0d9h)		;63b3
	or a			;63b6
	ret nz			;63b7
guarda_volumen:
	ld b,000h		;63b8   ; en D161 + registro
	ld hl,0d161h		;63ba
	add hl,bc			;63bd
	ld (hl),e			;63be
	ret			;63bf
tono_canal:
	ld a,(iy+001h)		;63c0   ; registro 2 * canal
	add a,a			;63c3
	ld c,a			;63c4
	jp p,guarda_tono		;63c5
	and 00fh		;63c8
	ld c,a			;63ca
	ld a,(0d0d9h)		;63cb
	or a			;63ce
	ret nz			;63cf
guarda_tono:
	ld b,000h		;63d0   ; los dos bytes del tono
	ld hl,0d161h		;63d2
	add hl,bc			;63d5
	ld (hl),e			;63d6
	inc hl			;63d7
	ld (hl),d			;63d8
	ret			;63d9
pila_voz:
	ld e,(iy+00ah)		;63da
	ld d,(iy+00bh)		;63dd
	ret			;63e0

; ----------------------------------------------------------------------
; EFECTO A (D178): la voz de efectos (D0D9) con la cabecera de p01:64B1 y la
; partitura del efecto (tabla p01:64CC).
; ----------------------------------------------------------------------
efecto:
	push hl			;63e1
	push de			;63e2
	push bc			;63e3
	ld hl,0d069h		;63e4   ; D069 bit 0: sin sonido
	bit 0,(hl)		;63e7
	jr nz,L_640B		;63e9
	ld hl,064b1h		;63eb   ; la cabecera de la voz de efectos
	ld de,0d0d9h		;63ee
	ld bc,00010h		;63f1
	ldir		;63f4
	add a,a			;63f6   ; el efecto * 2...
	ld c,a			;63f7
	ld b,000h		;63f8
	ld hl,064cch		;63fa   ; ...su partitura
	add hl,bc			;63fd
	ldi		;63fe
	ldi		;6400
	ld hl,0d168h		;6402   ; el mezclador: ruido y tono del canal 3
	ld a,(hl)			;6405
	and 03dh		;6406
	or 090h		;6408
	ld (hl),a			;640a
L_640B:
	pop bc			;640b
	pop de			;640c
	pop hl			;640d
	ret			;640e

; ----------------------------------------------------------------------
; MUSICA A (D17A). Si es una melodia corta (bit 7) y suena otra larga, la
; guarda en D0F2 para volver a ella al acabar.
; ----------------------------------------------------------------------
musica:
	push hl			;640f
	push de			;6410
	push bc			;6411
	ld hl,0d069h		;6412   ; sin sonido
	bit 0,(hl)		;6415
	jr nz,L_640B		;6417
	ld hl,0d068h		;6419   ; la que sonaba...
	bit 7,(hl)		;641c
	ld (hl),a			;641e   ; ...pasa a ser esta
	jr nz,empieza_musica		;641f
	bit 7,a		;6421   ; corta (bit 7) sobre larga: se guarda la larga
	jr z,empieza_musica		;6423
	ld hl,0d06ah		;6425
	ld de,0d0f2h		;6428
	ld bc,0006fh		;642b
	ldir		;642e
empieza_musica:
	add a,a			;6430   ; musica * 6 en p01:64F0: las tres partituras
	ld c,a			;6431
	add a,a			;6432
	add a,c			;6433
	ld c,a			;6434
	ld b,000h		;6435
	ld hl,064f0h		;6437
	add hl,bc			;643a
	ld a,003h		;643b   ; tres voces
	ld de,0d09eh		;643d
pon_partitura:
	ldi		;6440   ; la partitura de la voz
	ldi		;6442
	ld bc,00017h		;6444
	ex de,hl			;6447
	add hl,bc			;6448
	ex de,hl			;6449
	dec a			;644a
	jr nz,pon_partitura		;644b
	ld hl,06481h		;644d   ; las cabeceras de p01:6481
	ld de,0d08eh		;6450
	ld a,003h		;6453
pon_cabecera:
	ld bc,00010h		;6455   ; 16 bytes de cabecera
	ldir		;6458   ; copiados
	ld bc,00009h		;645a   ; y 9 bytes que no se tocan
	ex de,hl			;645d   ; hasta la voz siguiente
	add hl,bc			;645e
	ex de,hl			;645f
	dec a			;6460   ; una menos
	jr nz,pon_cabecera		;6461   ; las tres
	ld a,0b8h		;6463   ; mezclador = 0xB8
	ld (0d168h),a		;6465
	pop bc			;6468   ; BC...
	pop de			;6469   ; ...DE...
	pop hl			;646a   ; ...HL de vuelta
	ret			;646b   ; vuelve
huerfana_silencio:
	ld a,080h		;646c   ; nadie la llama: sonido apagado y el mezclador todo cerrado
	ld (0d069h),a		;646e
	ld a,007h		;6471
	ld e,0bfh		;6473
	jp escribe_psg		;6475

; ----------------------------------------------------------------------
; DATOS resto_6478: Dos rutinas de sonido sin llamada localizada: sub a / ld
;   (D069),a / ret (sonido encendido) y ld a,1 / jr 6479 (D069 = 1, apagado);
;   ni call ni jp en los 32 bancos y no se ejecutan en el recorrido medido
;   (tools/omsx_lecturas.tcl)
;   0x6478..0x6481  (9 bytes)
DATA_resto_6478:
	defb 097h,032h,069h,0d0h,0c9h,03eh,001h,018h,0f8h	; 6478  .2i..>...

; ----------------------------------------------------------------------
; DATOS voces_cabecera: Las cabeceras de las tres voces de musica (16 bytes
;   cada una)
;   0x6481..0x64b1  (48 bytes)
DATA_voces_cabecera:
	defb 0ffh,000h,001h,00bh,001h,000h,001h,001h,000h,001h,06ah,0d0h,0c1h,064h,0c1h,064h	; 6481  ..........j..d.d
	defb 0ffh,0c1h,001h,00bh,001h,000h,001h,001h,000h,001h,076h,0d0h,0c1h,064h,0c1h,064h	; 6491  ..........v..d.d
	defb 0ffh,002h,001h,00bh,001h,000h,001h,001h,000h,001h,082h,0d0h,0c1h,064h,0c1h,064h	; 64a1  .............d.d

; ----------------------------------------------------------------------
; DATOS voz_efectos: La cabecera de la voz de efectos (16 bytes)
;   0x64b1..0x64c1  (16 bytes)
DATA_voz_efectos:
	defb 0ffh,001h,001h,00bh,001h,000h,001h,001h,000h,001h,06ch,0d1h,0c1h,064h,0c1h,064h	; 64b1  ..........l..d.d

; ----------------------------------------------------------------------
; DATOS envolvente_por_defecto: La envolvente a la que apuntan las cuatro
;   cabeceras de voz (+0C y +0E, p01:6481 y p01:64B1): un paso F0 00 y el 0
;   que la acaba
;   0x64c1..0x64c4  (3 bytes)
DATA_envolvente_por_defecto:
	defb 0f0h,000h,000h	; 64c1

; ======================================================================
; CODIGO 0x64c4..0x64cc  (8 bytes)
; ======================================================================


escribe_psg:
	out (0a0h),a		;64c4   ; el registro A del PSG...
	push af			;64c6
	ld a,e			;64c7
	out (0a1h),a		;64c8   ; ...vale E
	pop af			;64ca
	ret			;64cb

; ----------------------------------------------------------------------
; DATOS tabla_de_efectos_64CC: La partitura de cada uno de los 18 efectos de
;   sonido (p01:63FA)
;   0x64cc..0x64f0  (36 bytes)
DATA_tabla_de_efectos_64CC:
	defb 0d6h,065h,0d7h,065h,0eah,065h,00bh,066h,03bh,066h,04ch,066h,073h,066h,094h,066h	; 64cc  .e.e.e.f;fLfsf.f
	defb 0b4h,066h,0cah,066h,043h,067h,05bh,067h,08dh,067h,0a6h,067h,0fch,067h,058h,068h	; 64dc  .f.fCg[g.g.g.gXh
	defb 0c6h,068h,0dfh,068h	; 64ec

; ----------------------------------------------------------------------
; DATOS tabla_de_musicas_64F0: Las tres partituras (una por voz) de cada una
;   de las 9 musicas (p01:6437)
;   0x64f0..0x6526  (54 bytes)
DATA_tabla_de_musicas_64F0:
	defb 0d6h,065h,0d6h,065h,0d6h,065h,0e5h,069h,07bh,06ah,0f6h,06ah,0a9h,06bh,0adh,06ch	; 64f0  .e.e.e.i{j.j.k.l
	defb 0b5h,06eh,051h,072h,00ah,078h,07dh,07bh,0dfh,07eh,075h,081h,053h,083h,052h,085h	; 6500  .nQr.x}{.~u.S.R.
	defb 073h,087h,0f8h,089h,047h,08ch,065h,08ch,083h,08ch,0a9h,08ch,01bh,08dh,0bah,08dh	; 6510  s...G.e.........
	defb 059h,08eh,0eeh,08eh,083h,08fh	; 6520

; ----------------------------------------------------------------------
; DATOS tabla_de_envolventes_de_volumen_6526: Las 11 envolventes de volumen
;   que pide el codigo 0x80 de una partitura (p01:6338)
;   0x6526..0x653c  (22 bytes)
DATA_tabla_de_envolventes_de_volumen_6526:
	defb 03ch,065h,041h,065h,04ah,065h,04dh,065h,052h,065h,055h,065h,05ah,065h,05fh,065h	; 6526  <eAeJeMeReUeZe_e
	defb 064h,065h,067h,065h,06ch,065h	; 6536

; ----------------------------------------------------------------------
; DATOS envolventes_de_volumen_653C: Envolventes de volumen (p01:619B): pasos
;   de 2 bytes (veces/cuadros, cambio) hasta un 0
;   0x653c..0x6542  (6 bytes)
DATA_envolventes_de_volumen_653C:
	defb 021h,0ffh,011h,001h,000h,000h	; 653c

; ----------------------------------------------------------------------
; DATOS sonido_suelto_6542: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x6542..0x6544  (2 bytes)
DATA_sonido_suelto_6542:
	defb 0ffh,000h	; 6542

; ----------------------------------------------------------------------
; DATOS relleno_6544: Relleno: todo 0xFF
;   0x6544..0x6548  (4 bytes)
DATA_relleno_6544:
	defb 0ffh,0ffh,0ffh,0ffh	; 6544

; ----------------------------------------------------------------------
; DATOS sonido_suelto_6548: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x6548..0x654a  (2 bytes)
DATA_sonido_suelto_6548:
	defb 000h,000h	; 6548

; ----------------------------------------------------------------------
; DATOS envolventes_de_volumen_654A: Envolventes de volumen (p01:619B): pasos
;   de 2 bytes (veces/cuadros, cambio) hasta un 0
;   0x654a..0x6571  (39 bytes)
DATA_envolventes_de_volumen_654A:
	defb 002h,0ffh,000h,0ffh,0ffh,012h,001h,000h,001h,0ffh,000h,005h,0ffh,011h,001h,000h	; 654a  ................
	defb 003h,0ffh,012h,001h,000h,023h,0ffh,056h,006h,000h,021h,000h,000h,011h,0efh,011h	; 655a  .....#.V..!.....
	defb 008h,000h,002h,0ffh,011h,001h,000h	; 656a

; ----------------------------------------------------------------------
; DATOS tabla_de_envolventes_de_tono_6571: Las 13 envolventes de tono que pide
;   el codigo 0x81 de una partitura (p01:634F)
;   0x6571..0x658b  (26 bytes)
DATA_tabla_de_envolventes_de_tono_6571:
	defb 08bh,065h,08eh,065h,095h,065h,09ch,065h,0a3h,065h,0aah,065h,0b1h,065h,0b6h,065h	; 6571  .e.e.e.e.e.e.e.e
	defb 0b9h,065h,0c0h,065h,0c7h,065h,0ceh,065h,0d3h,065h	; 6581  .e.e.e.e.e

; ----------------------------------------------------------------------
; DATOS envolventes_de_tono_658B: Envolventes de tono (p01:61F7): pasos de 2
;   bytes (veces/cuadros, cambio) hasta un 0
;   0x658b..0x65c5  (58 bytes)
DATA_envolventes_de_tono_658B:
	defb 0f0h,000h,000h,022h,001h,023h,0ffh,024h,000h,000h,011h,001h,0efh,000h,011h,000h	; 658b  ...".#.$........
	defb 000h,011h,009h,022h,0f0h,012h,0ffh,000h,022h,001h,022h,0ffh,022h,000h,000h,011h	; 659b  ..."...."."."...
	defb 00ah,011h,0f6h,011h,000h,000h,012h,045h,011h,012h,000h,011h,04ah,000h,022h,001h	; 65ab  .......E....J.".
	defb 022h,0ffh,022h,000h,000h,022h,0fdh,022h,0fdh,000h	; 65bb  ".".."."..

; ----------------------------------------------------------------------
; DATOS sonido_suelto_65C5: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x65c5..0x65c7  (2 bytes)
DATA_sonido_suelto_65C5:
	defb 000h,000h	; 65c5

; ----------------------------------------------------------------------
; DATOS envolventes_de_tono_65C7: Envolventes de tono (p01:61F7): pasos de 2
;   bytes (veces/cuadros, cambio) hasta un 0
;   0x65c7..0x65d6  (15 bytes)
DATA_envolventes_de_tono_65C7:
	defb 011h,004h,011h,002h,011h,012h,000h,011h,067h,012h,012h,000h,011h,0fch,000h	; 65c7  ........g......

; ----------------------------------------------------------------------
; DATOS partituras_65D6: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x65d6..0x65e9  (19 bytes)
DATA_partituras_65D6:
	defb 000h,080h,004h,0e0h,081h,002h,0fch,0dfh,004h,000h,020h,0c4h,00ch,000h,01fh,081h	; 65d6  .......... .....
	defb 000h,0e8h,000h	; 65e6

; ----------------------------------------------------------------------
; DATOS sonido_suelto_65E9: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x65e9..0x65ea  (1 bytes)
DATA_sonido_suelto_65E9:
	defb 000h	; 65e9

; ----------------------------------------------------------------------
; DATOS partituras_65EA: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x65ea..0x660a  (32 bytes)
DATA_partituras_65EA:
	defb 0fbh,080h,008h,0e1h,0cfh,004h,000h,078h,002h,0ffh,0c4h,002h,002h,034h,0c5h,001h	; 65ea  .......x.....4..
	defb 002h,034h,0c6h,002h,002h,034h,0c9h,001h,002h,034h,0cah,004h,002h,034h,0e8h,000h	; 65fa  .4...4...4...4..

; ----------------------------------------------------------------------
; DATOS sonido_suelto_660A: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x660a..0x660b  (1 bytes)
DATA_sonido_suelto_660A:
	defb 000h	; 660a

; ----------------------------------------------------------------------
; DATOS partituras_660B: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x660b..0x663a  (47 bytes)
DATA_partituras_660B:
	defb 080h,004h,0cch,0e1h,0f7h,001h,000h,090h,0f8h,001h,000h,090h,0f9h,001h,000h,090h	; 660b  ................
	defb 0cbh,0fah,001h,000h,090h,0cah,0fbh,001h,000h,090h,0f8h,001h,000h,090h,0c9h,0f6h	; 661b  ................
	defb 001h,000h,090h,0c8h,0f4h,001h,000h,090h,0c7h,0f6h,006h,000h,090h,0e8h,000h	; 662b  ...............

; ----------------------------------------------------------------------
; DATOS sonido_suelto_663A: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x663a..0x663b  (1 bytes)
DATA_sonido_suelto_663A:
	defb 000h	; 663a

; ----------------------------------------------------------------------
; DATOS partituras_663B: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x663b..0x664b  (16 bytes)
DATA_partituras_663B:
	defb 080h,009h,0fah,0e1h,0c4h,001h,000h,090h,002h,0ffh,0cch,003h,000h,090h,0e8h,000h	; 663b  ................

; ----------------------------------------------------------------------
; DATOS sonido_suelto_664B: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x664b..0x664c  (1 bytes)
DATA_sonido_suelto_664B:
	defb 000h	; 664b

; ----------------------------------------------------------------------
; DATOS partituras_664C: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x664c..0x6742  (246 bytes)
DATA_partituras_664C:
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
	defb 0c8h,004h,000h,090h,0e8h,000h	; 673c

; ----------------------------------------------------------------------
; DATOS sonido_suelto_6742: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x6742..0x6743  (1 bytes)
DATA_sonido_suelto_6742:
	defb 000h	; 6742

; ----------------------------------------------------------------------
; DATOS partituras_6743: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x6743..0x68de  (411 bytes)
DATA_partituras_6743:
	defb 0fdh,0e0h,081h,006h,080h,004h,0deh,002h,004h,000h,001h,0ffh,002h,002h,000h,001h	; 6743  ................
	defb 0ffh,012h,003h,000h,0e8h,081h,000h,000h,0e0h,081h,005h,080h,008h,0fch,0d7h,002h	; 6753  ................
	defb 003h,090h,0c5h,002h,003h,000h,0d2h,002h,003h,090h,0c5h,002h,003h,090h,0d0h,002h	; 6763  ................
	defb 003h,000h,0c5h,002h,003h,090h,0cch,001h,003h,000h,0c5h,001h,003h,090h,0c7h,001h	; 6773  ................
	defb 003h,000h,0c5h,001h,003h,090h,0e8h,081h,000h,000h,080h,005h,081h,007h,0fbh,0cch	; 6783  ................
	defb 0e1h,002h,003h,000h,0e8h,001h,003h,000h,0fbh,001h,003h,000h,0fdh,014h,002h,000h	; 6793  ................
	defb 081h,000h,000h,080h,008h,0c5h,0fbh,081h,005h,0e0h,008h,000h,030h,0c7h,002h,000h	; 67a3  ............0...
	defb 02fh,0c9h,002h,000h,02eh,0cbh,002h,000h,02dh,0cdh,002h,000h,02ch,0cfh,002h,000h	; 67b3  /.......-...,...
	defb 02bh,0d1h,001h,000h,029h,0cfh,001h,000h,027h,0ceh,001h,000h,025h,0cdh,001h,000h	; 67c3  +...)...'...%...
	defb 023h,0cch,001h,000h,021h,0cbh,001h,000h,01fh,0cah,001h,000h,01dh,0c9h,001h,000h	; 67d3  #...!...........
	defb 01bh,0c8h,001h,000h,019h,0c7h,001h,000h,017h,0c6h,001h,000h,015h,0c5h,002h,000h	; 67e3  ................
	defb 013h,0c4h,002h,000h,011h,0e8h,081h,000h,000h,0fch,0e0h,080h,008h,081h,00ah,0dfh	; 67f3  ................
	defb 002h,000h,060h,002h,000h,05eh,002h,000h,05ch,0c7h,002h,000h,05ah,0cch,002h,000h	; 6803  ..`..^..\...Z...
	defb 058h,0cah,001h,000h,056h,0c8h,001h,000h,058h,0c6h,004h,000h,05ah,0c4h,002h,000h	; 6813  X...V...X...Z...
	defb 05ch,0c6h,002h,000h,05dh,0c8h,002h,000h,060h,0cah,002h,000h,064h,0cch,002h,000h	; 6823  \...]...`...d...
	defb 068h,0ceh,002h,000h,06ah,0d0h,001h,000h,06dh,0d2h,001h,000h,070h,0d4h,001h,000h	; 6833  h...j...m...p...
	defb 074h,0d8h,001h,000h,078h,001h,000h,07ah,001h,000h,07eh,001h,000h,085h,001h,000h	; 6843  t...x..z..~.....
	defb 08ah,0e8h,081h,000h,000h,0e0h,0fbh,080h,008h,081h,00bh,0d8h,002h,005h,020h,0d4h	; 6853  .............. .
	defb 002h,003h,000h,0d2h,002h,005h,020h,0cah,002h,002h,000h,0c8h,002h,005h,020h,0c7h	; 6863  ...... ....... .
	defb 002h,003h,000h,0c6h,002h,006h,000h,0c5h,002h,004h,050h,0c4h,002h,002h,020h,0c3h	; 6873  ..........P... .
	defb 002h,005h,060h,0c2h,008h,002h,050h,0c3h,003h,003h,000h,0c4h,003h,003h,020h,0c5h	; 6883  ..`...P....... .
	defb 003h,003h,030h,0c6h,002h,003h,040h,0cah,002h,003h,050h,0cch,002h,003h,060h,0ceh	; 6893  ..0...@...P...`.
	defb 002h,003h,070h,0d0h,002h,003h,080h,0d2h,002h,003h,090h,0d4h,002h,003h,0a0h,0d6h	; 68a3  ..p.............
	defb 002h,003h,0b0h,0d8h,002h,003h,0c0h,0dah,002h,003h,0d0h,0dch,002h,003h,0e0h,0e8h	; 68b3  ................
	defb 081h,000h,000h,080h,008h,0c6h,0e0h,0fdh,001h,003h,000h,002h,0ffh,0c6h,0f9h,001h	; 68c3  ................
	defb 000h,040h,0fbh,001h,000h,045h,001h,000h,010h,0e8h,000h	; 68d3  .@...E.....

; ----------------------------------------------------------------------
; DATOS sonido_suelto_68DE: Bytes en la zona del sonido a los que no llega
;   ninguna tabla, partitura ni envolvente, y que no se leen en el recorrido
;   medido (tools/omsx_lecturas.tcl por las 257 pantallas)
;   0x68de..0x68df  (1 bytes)
DATA_sonido_suelto_68DE:
	defb 000h	; 68de

; ----------------------------------------------------------------------
; DATOS partituras_68DF: Partituras (p01:6253): nota = duracion + tono (2) o
;   silencio (bit 7); 0x80/0x81 envolvente, 0x82 salto, 0x83 llamada, 0x84
;   vuelta, 0x85 repite, 0x90-0xBF repeticion, 0xC0 ruido, 0xE0 mezclador,
;   0xF0 volumen, 0 fin
;   0x68df..0x8000  (5921 bytes)
DATA_partituras_68DF:
	defb 080h,000h,0e1h,0fch,081h,00ch,0dch,001h,000h,090h,0cch,006h,000h,070h,0d9h,001h	; 68df  .............p..
	defb 000h,012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h,0cah,001h,001h,023h,0c6h,002h	; 68ef  .....V...F...#..
	defb 000h,045h,0cch,002h,001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h	; 68ff  .E...4...E...#..
	defb 005h,067h,0c5h,002h,000h,023h,004h,0ffh,0f9h,0dch,001h,000h,090h,0cch,004h,000h	; 690f  .g...#..........
	defb 070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h,0cah,001h,001h	; 691f  p.......V...F...
	defb 023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h	; 692f  #...E...4...E...
	defb 023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h,0ffh,0f6h,0dch,001h,000h,090h	; 693f  #...g...#.......
	defb 0cch,002h,000h,070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h,001h,000h,046h	; 694f  ...p.......V...F
	defb 0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh,002h,000h,045h	; 695f  ...#...E...4...E
	defb 0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h,0ffh,0f4h,0dch	; 696f  ...#...g...#....
	defb 001h,000h,090h,0cch,001h,000h,070h,0d9h,001h,000h,012h,0cbh,001h,000h,056h,0d7h	; 697f  ......p.......V.
	defb 001h,000h,046h,0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h,001h,034h,0cbh	; 698f  ..F...#...E...4.
	defb 002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h,000h,023h,004h	; 699f  ..E...#...g...#.
	defb 0ffh,0f1h,0dch,001h,000h,090h,0cch,001h,000h,070h,0d9h,001h,000h,012h,0cbh,001h	; 69af  .........p......
	defb 000h,056h,0d7h,001h,000h,046h,0cah,001h,001h,023h,0c6h,002h,000h,045h,0cch,002h	; 69bf  .V...F...#...E..
	defb 001h,034h,0cbh,002h,000h,045h,0c8h,001h,001h,023h,0c6h,001h,005h,067h,0c5h,002h	; 69cf  .4...E...#...g..
	defb 000h,023h,0e8h,081h,000h,000h,0fah,080h,000h,081h,008h,00ch,000h,0aah,00ch,000h	; 69df  .#..............
	defb 0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah	; 69ef  ................
	defb 00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch	; 69ff  ................
	defb 000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h	; 6a0f  ................
	defb 07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h	; 6a1f  ................
	defb 00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch	; 6a2f  ................
	defb 000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h	; 6a3f  ................
	defb 0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh	; 6a4f  ................
	defb 00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch	; 6a5f  ................
	defb 000h,07fh,00ch,000h,0aah,00ch,000h,0a0h,00ch,000h,000h,000h,0f8h,081h,008h,080h	; 6a6f  ................
	defb 001h,048h,000h,030h,048h,000h,030h,0fah,080h,001h,081h,000h,048h,005h,0fah,02eh	; 6a7f  .H.0H.0.....H...
	defb 005h,0fah,00ah,005h,0fah,001h,005h,0fah,001h,005h,0fah,0fbh,001h,005h,0fah,001h	; 6a8f  ................
	defb 005h,0fah,0fch,001h,005h,0fah,003h,005h,0fah,0fbh,002h,005h,0fah,0fah,002h,005h	; 6a9f  ................
	defb 0fah,0f9h,002h,005h,0fah,0f8h,002h,005h,0fah,0f8h,081h,008h,080h,001h,048h,000h	; 6aaf  ..............H.
	defb 030h,048h,000h,030h,0fah,080h,001h,081h,000h,048h,005h,0fah,02eh,005h,0fah,00ah	; 6abf  0H.0.....H......
	defb 005h,0fah,001h,005h,0fah,001h,005h,0fah,0fbh,001h,005h,0fah,001h,005h,0fah,0fch	; 6acf  ................
	defb 001h,005h,0fah,003h,005h,0fah,0fbh,002h,005h,0fah,0fah,002h,005h,0fah,0f9h,002h	; 6adf  ................
	defb 005h,0fah,0f8h,002h,005h,0fah,000h,0f8h,080h,000h,006h,0ffh,00ch,000h,0a8h,00ch	; 6aef  ................
	defb 000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h	; 6aff  ....}........}..
	defb 0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh,006h,000h,07dh	; 6b0f  ......}........}
	defb 0fah,080h,001h,048h,005h,0f4h,02eh,005h,0f4h,00ah,005h,0f4h,001h,005h,0f4h,001h	; 6b1f  ...H............
	defb 005h,0f4h,0fbh,001h,005h,0f4h,001h,005h,0f4h,0fch,001h,005h,0f4h,003h,005h,0f4h	; 6b2f  ................
	defb 0fbh,002h,005h,0f4h,0fah,002h,005h,0f4h,0f9h,002h,005h,0f4h,0f8h,002h,005h,0f4h	; 6b3f  ................
	defb 080h,000h,0f8h,006h,0ffh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h	; 6b4f  .............}..
	defb 0a8h,00ch,000h,09eh,00ch,000h,07dh,00ch,000h,0a8h,00ch,000h,09eh,00ch,000h,07dh	; 6b5f  ......}........}
	defb 00ch,000h,0a8h,00ch,000h,09eh,006h,000h,07dh,080h,001h,0fah,048h,005h,0f4h,02eh	; 6b6f  ........}...H...
	defb 005h,0f4h,00ah,005h,0f4h,001h,005h,0f4h,001h,005h,0f4h,0fbh,001h,005h,0f4h,001h	; 6b7f  ................
	defb 005h,0f4h,0fch,001h,005h,0f4h,003h,005h,0f4h,0fbh,002h,005h,0f4h,0fah,002h,005h	; 6b8f  ................
	defb 0f4h,0f9h,002h,005h,0f4h,0f8h,002h,005h,0f4h,000h,098h,0fch,080h,002h,006h,005h	; 6b9f  ................
	defb 0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h	; 6baf  ................
	defb 006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,080h	; 6bbf  ................
	defb 001h,00ch,002h,0fah,085h,082h,0d7h,06bh,0a0h,0fch,080h,002h,006h,005h,0f4h,006h	; 6bcf  .......k........
	defb 005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h	; 6bdf  ................
	defb 0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,080h,001h,00ch	; 6bef  ................
	defb 002h,0fah,085h,094h,0fch,080h,002h,006h,006h,0aeh,006h,006h,0aeh,006h,006h,0aeh	; 6bff  ................
	defb 006h,006h,0aeh,00ch,003h,057h,006h,006h,0aeh,006h,006h,0aeh,00ch,006h,0aeh,00ch	; 6c0f  .....W..........
	defb 003h,057h,006h,006h,0aeh,006h,006h,0aeh,080h,001h,00ch,003h,057h,085h,093h,0fdh	; 6c1f  .W..........W...
	defb 080h,002h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h	; 6c2f  ................
	defb 0fah,006h,005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h	; 6c3f  ................
	defb 006h,005h,0f4h,080h,001h,00ch,002h,0fah,085h,080h,002h,0fdh,006h,005h,0f4h,006h	; 6c4f  ................
	defb 005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,00ch,002h,0fah,0fch,006h,005h,0f4h,006h	; 6c5f  ................
	defb 005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,080h,001h	; 6c6f  ................
	defb 00ch,002h,0fah,080h,002h,006h,005h,0f4h,006h,005h,0f4h,006h,005h,0f4h,006h,005h	; 6c7f  ................
	defb 0f4h,00ch,002h,0fah,006h,005h,0f4h,006h,005h,0f4h,00ch,005h,0f4h,00ch,002h,0fah	; 6c8f  ................
	defb 006h,005h,0f4h,006h,005h,0f4h,080h,001h,00ch,002h,0fah,082h,0d7h,06bh,080h,005h	; 6c9f  .............k..
	defb 0f7h,018h,0ffh,00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h	; 6caf  .....0..@<.0..0.
	defb 000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h	; 6cbf  .@<.0..0..@<.0..
	defb 030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h,03ch,000h,030h	; 6ccf  0..@<.0..0..@<.0
	defb 00ch,000h,030h,018h,000h,040h,03ch,000h,030h,00ch,000h,030h,018h,000h,040h,03ch	; 6cdf  ..0..@<.0..0..@<
	defb 000h,030h,00ch,000h,030h,018h,000h,040h,024h,000h,030h,082h,0fdh,06ch,080h,005h	; 6cef  .0..0..@$.0..l..
	defb 0f7h,081h,000h,018h,0ffh,024h,000h,028h,018h,000h,040h,024h,000h,028h,024h,000h	; 6cff  .....$.(..@$.($.
	defb 02ah,018h,000h,030h,024h,000h,02ah,024h,000h,028h,018h,000h,040h,024h,000h,028h	; 6d0f  *..0$.*$.(..@$.(
	defb 024h,000h,030h,018h,000h,035h,024h,000h,030h,024h,000h,030h,018h,000h,028h,024h	; 6d1f  $.0..5$.0$.0..($
	defb 000h,040h,024h,000h,024h,018h,000h,02ah,024h,000h,028h,024h,000h,030h,018h,000h	; 6d2f  .@$.$..*$.($.0..
	defb 035h,024h,000h,030h,024h,000h,030h,018h,000h,035h,024h,000h,030h,024h,000h,028h	; 6d3f  5$.0$.0..5$.0$.(
	defb 018h,000h,040h,024h,000h,028h,024h,000h,02ah,018h,000h,030h,024h,000h,02ah,024h	; 6d4f  ..@$.($.*..0$.*$
	defb 000h,028h,018h,000h,040h,024h,000h,028h,024h,000h,030h,018h,000h,035h,024h,000h	; 6d5f  .(..@$.($.0..5$.
	defb 030h,024h,000h,030h,018h,000h,02ah,024h,000h,040h,024h,000h,024h,018h,000h,02ah	; 6d6f  0$.0..*$.@$.$..*
	defb 018h,000h,028h,080h,004h,0fah,006h,000h,028h,006h,000h,02ah,006h,000h,028h,006h	; 6d7f  ..(.....(..*..(.
	defb 000h,02ah,006h,000h,028h,006h,000h,030h,006h,000h,028h,0f9h,006h,000h,02ah,006h	; 6d8f  .*..(..0..(...*.
	defb 000h,028h,006h,000h,02ah,0f8h,006h,000h,028h,006h,000h,02ah,006h,000h,028h,006h	; 6d9f  .(..*...(..*..(.
	defb 000h,030h,0f7h,006h,000h,028h,006h,000h,02ah,006h,000h,028h,0f6h,006h,000h,02ah	; 6daf  .0...(..*..(...*
	defb 006h,000h,028h,006h,000h,02ah,006h,000h,028h,006h,000h,030h,006h,000h,02ah,006h	; 6dbf  ..(..*..(..0..*.
	defb 000h,028h,0f9h,080h,000h,006h,000h,047h,006h,000h,040h,006h,000h,03ch,006h,000h	; 6dcf  .(.....G..@..<..
	defb 035h,006h,000h,030h,006h,000h,024h,080h,001h,081h,008h,0f9h,060h,000h,02ah,060h	; 6ddf  5..0..$.....`.*`
	defb 000h,02ah,080h,004h,0f6h,00ch,000h,06bh,00ch,000h,055h,00ch,000h,050h,0f7h,00ch	; 6def  .*.....k..U..P..
	defb 000h,055h,00ch,000h,047h,00ch,000h,055h,0f8h,00ch,000h,050h,00ch,000h,055h,0f9h	; 6dff  .U..G..U...P..U.
	defb 00ch,000h,06bh,00ch,000h,055h,0fah,00ch,000h,050h,00ch,000h,055h,00ch,000h,047h	; 6e0f  ..k..U...P..U..G
	defb 0fbh,00ch,000h,050h,0fbh,00ch,000h,055h,080h,000h,081h,000h,018h,001h,07dh,002h	; 6e1f  ...P...U......}.
	defb 0ffh,00ch,001h,040h,00ch,000h,0feh,00ch,001h,040h,00ch,000h,0beh,00ch,001h,01dh	; 6e2f  ...@.....@......
	defb 00ch,000h,0e2h,018h,001h,07dh,00ch,001h,040h,00ch,000h,0feh,00ch,001h,040h,00ch	; 6e3f  .....}..@.....@.
	defb 000h,0beh,00ch,001h,01dh,00ch,000h,0e2h,018h,001h,07dh,00ch,001h,040h,00ch,000h	; 6e4f  ..........}..@..
	defb 0feh,00ch,001h,040h,00ch,000h,0beh,00ch,001h,01dh,00ah,000h,0e2h,080h,001h,0fah	; 6e5f  ...@............
	defb 081h,001h,00ch,001h,0fch,080h,002h,0fdh,006h,001h,0fch,006h,001h,0fch,006h,001h	; 6e6f  ................
	defb 0fch,006h,001h,0fch,00ch,001h,0fch,080h,001h,0fbh,012h,001h,0fch,0fah,00fh,001h	; 6e7f  ................
	defb 0fch,00fh,001h,0fch,0f9h,00ch,001h,0fch,00ch,001h,0fch,0f8h,00ch,001h,0fch,00ch	; 6e8f  ................
	defb 001h,0fch,00ch,001h,0fch,0f7h,00ch,001h,0fch,00ch,001h,0fch,0f6h,00ch,001h,0fch	; 6e9f  ................
	defb 00ch,001h,0fch,082h,0fdh,06ch,0f8h,080h,001h,081h,008h,060h,000h,055h,060h,000h	; 6eaf  .....l.....`.U`.
	defb 055h,060h,000h,05fh,060h,000h,05fh,060h,000h,055h,048h,000h,055h,0f9h,014h,000h	; 6ebf  U`._`._`.UH.U...
	defb 05fh,002h,000h,05eh,002h,000h,05dh,002h,000h,05ch,002h,000h,05bh,002h,000h,05ah	; 6ecf  _..^..]..\..[..Z
	defb 002h,000h,059h,002h,000h,058h,002h,000h,057h,002h,000h,056h,002h,000h,055h,050h	; 6edf  ..Y..X..W..V..UP
	defb 000h,055h,080h,003h,032h,000h,055h,0e1h,0c5h,0f4h,001h,000h,056h,001h,000h,056h	; 6eef  .U..2.U.....V..V
	defb 001h,000h,056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 6eff  ..V...V..V..V..V
	defb 0f6h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f7h,001h,000h	; 6f0f  ...V..V..V..V...
	defb 056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h,056h,001h,000h	; 6f1f  V..V..V..V...V..
	defb 056h,001h,000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h,056h,001h,000h	; 6f2f  V..V..V...V..V..
	defb 056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h	; 6f3f  V..V...V..V..V..
	defb 056h,001h,000h,056h,0fbh,003h,000h,056h,003h,000h,056h,00ch,000h,056h,082h,060h	; 6f4f  V..V...V..V..V.`
	defb 06fh,0fbh,0e8h,081h,008h,080h,004h,00ch,000h,05fh,00ch,000h,07fh,00ch,000h,08fh	; 6f5f  o........_......
	defb 00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,018h,000h,0beh,048h,0ffh,080h,001h	; 6f6f  ............H...
	defb 0f9h,018h,001h,0ach,018h,001h,07dh,080h,006h,006h,000h,05fh,006h,000h,05fh,006h	; 6f7f  ......}...._.._.
	defb 000h,05fh,00ch,000h,040h,0e1h,0cfh,0f4h,001h,000h,056h,001h,000h,056h,001h,000h	; 6f8f  ._..@.....V..V..
	defb 056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f6h,001h	; 6f9f  V...V..V..V..V..
	defb 000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f7h,001h,000h,056h,001h	; 6faf  .V..V..V..V...V.
	defb 000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h,056h,001h,000h,056h,001h	; 6fbf  .V..V..V...V..V.
	defb 000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h	; 6fcf  .V..V...V..V..V.
	defb 000h,056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h,056h,001h,000h,056h,0fbh	; 6fdf  .V..V...V..V..V.
	defb 001h,000h,056h,001h,000h,056h,003h,000h,056h,00ah,000h,056h,0e8h,0fbh,080h,004h	; 6fef  ..V..V..V..V....
	defb 00ch,000h,05fh,00ch,000h,07fh,00ch,000h,08fh,00ch,000h,0a0h,00ch,000h,08fh,00ch	; 6fff  .._.............
	defb 000h,07fh,018h,000h,06bh,00ch,0ffh,0fch,080h,004h,00ch,000h,078h,00ch,0ffh,080h	; 700f  ....k.......x...
	defb 001h,0fah,024h,001h,0e0h,00ch,001h,0fch,00ch,0ffh,080h,000h,0fch,018h,000h,07fh	; 701f  ..$.............
	defb 00ch,0ffh,080h,001h,0fbh,024h,001h,0fch,080h,002h,0fdh,00ch,002h,081h,080h,005h	; 702f  .....$..........
	defb 054h,002h,0fah,0f9h,080h,006h,006h,000h,05fh,006h,000h,055h,006h,000h,05fh,006h	; 703f  T......._..U.._.
	defb 000h,051h,060h,000h,050h,0fbh,0e8h,080h,004h,00ch,000h,05fh,00ch,000h,07fh,00ch	; 704f  .Q`.P......_....
	defb 000h,08fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,018h,000h,0beh,048h,0ffh	; 705f  ..............H.
	defb 080h,001h,0f9h,012h,001h,0ach,001h,001h,0aah,001h,001h,0a8h,001h,001h,0a5h,001h	; 706f  ................
	defb 001h,0a0h,001h,001h,09eh,001h,001h,09ch,001h,001h,098h,001h,001h,093h,001h,001h	; 707f  ................
	defb 090h,001h,001h,08eh,001h,001h,08ch,001h,001h,088h,001h,001h,084h,001h,001h,080h	; 708f  ................
	defb 001h,001h,07fh,001h,001h,07eh,00eh,001h,07dh,080h,006h,006h,000h,05fh,006h,000h	; 709f  .....~..}...._..
	defb 05fh,006h,000h,05fh,00ch,000h,040h,0e1h,0cfh,0f4h,001h,000h,056h,001h,000h,056h	; 70af  _.._..@.....V..V
	defb 001h,000h,056h,0f5h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h	; 70bf  ..V...V..V..V..V
	defb 0f6h,001h,000h,056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f7h,001h,000h	; 70cf  ...V..V..V..V...
	defb 056h,001h,000h,056h,001h,000h,056h,001h,000h,056h,0f8h,001h,000h,056h,001h,000h	; 70df  V..V..V..V...V..
	defb 056h,001h,000h,056h,001h,000h,056h,0f9h,001h,000h,056h,001h,000h,056h,001h,000h	; 70ef  V..V..V...V..V..
	defb 056h,001h,000h,056h,001h,000h,056h,0fah,001h,000h,056h,001h,000h,056h,001h,000h	; 70ff  V..V..V...V..V..
	defb 056h,0fbh,001h,000h,056h,001h,000h,056h,003h,000h,056h,00ah,000h,056h,0e8h,0fbh	; 710f  V...V..V..V..V..
	defb 080h,004h,00ch,000h,05fh,00ch,000h,07fh,00ch,000h,08fh,00ch,000h,0a0h,00ch,000h	; 711f  ...._...........
	defb 08fh,00ch,000h,07fh,018h,000h,06bh,00ch,0ffh,080h,004h,0fch,00ch,000h,078h,00ch	; 712f  ......k.......x.
	defb 0ffh,080h,001h,0fah,024h,001h,0e0h,00ch,001h,0fch,00ch,0ffh,080h,000h,0fch,018h	; 713f  ....$...........
	defb 000h,07fh,00ch,0ffh,080h,001h,0fah,024h,001h,0fch,080h,002h,0fdh,00ch,002h,081h	; 714f  .......$........
	defb 080h,001h,00ch,002h,0fah,0fch,030h,002h,0fah,0fbh,018h,002h,0fah,0fah,018h,002h	; 715f  ......0.........
	defb 0fah,0f9h,03ch,002h,081h,080h,000h,006h,002h,03bh,0f9h,006h,001h,0fch,006h,001h	; 716f  ..<......;......
	defb 0e0h,0fah,006h,001h,0ach,006h,001h,07dh,0fbh,006h,001h,050h,00ch,001h,040h,0fch	; 717f  .......}...P..@.
	defb 00ch,001h,050h,00ch,001h,0ach,080h,001h,00ch,002h,03bh,030h,002h,03bh,054h,002h	; 718f  ..P.......;0.;T.
	defb 03bh,080h,000h,006h,000h,0aah,0f9h,006h,000h,0a0h,080h,005h,012h,000h,0aah,018h	; 719f  ;...............
	defb 000h,0d6h,0fah,012h,001h,01dh,018h,001h,040h,0fbh,080h,006h,018h,001h,050h,080h	; 71af  ........@.....P.
	defb 005h,00ch,001h,01dh,080h,001h,0fah,012h,001h,01dh,0f9h,004h,001h,01dh,004h,001h	; 71bf  ................
	defb 01dh,0f7h,005h,001h,01dh,005h,001h,01dh,005h,001h,01dh,0f6h,004h,001h,01dh,003h	; 71cf  ................
	defb 001h,01dh,0fch,080h,005h,00ch,000h,0aah,0fdh,018h,000h,0beh,080h,004h,0fch,00ch	; 71df  ................
	defb 000h,0a0h,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,05fh,00ch,000h,08fh,00ch,000h	; 71ef  .........._.....
	defb 071h,080h,005h,0fdh,018h,000h,0beh,080h,004h,0fch,00ch,000h,0a0h,00ch,000h,07fh	; 71ff  q...............
	defb 00ch,000h,0a0h,00ch,000h,05fh,00ch,000h,08fh,00ch,000h,071h,080h,005h,0fdh,018h	; 720f  ....._.....q....
	defb 000h,0beh,080h,004h,0fch,00ch,000h,0a0h,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h	; 721f  ................
	defb 05fh,00ch,000h,08fh,00ch,000h,071h,080h,001h,00ch,000h,07fh,018h,000h,07fh,0fch	; 722f  _.....q.........
	defb 018h,000h,07fh,0fbh,030h,000h,07fh,0fah,030h,000h,07fh,0f9h,030h,000h,07fh,082h	; 723f  ....0...0...0...
	defb 060h,06fh,080h,005h,0fbh,070h,0ffh,038h,0ffh,00eh,0ffh,007h,000h,07fh,007h,000h	; 724f  `o...p.8........
	defb 08fh,007h,000h,0a0h,007h,000h,0aah,00eh,0ffh,038h,0ffh,00eh,0ffh,007h,000h,07fh	; 725f  .........8......
	defb 007h,000h,08fh,007h,000h,07fh,015h,000h,071h,080h,008h,0f9h,070h,000h,06bh,020h	; 726f  ........q...p.k
	defb 000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h	; 727f  .k..k..k..k..k..
	defb 06bh,0fah,002h,000h,06bh,002h,000h,06bh,00eh,000h,06bh,002h,000h,06bh,002h,000h	; 728f  k...k..k..k..k..
	defb 06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,0fbh,002h,000h,06bh,002h,000h	; 729f  k..k..k..k...k..
	defb 06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh	; 72af  k..k..k..k..k..k
	defb 0fch,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh,002h,000h,06bh	; 72bf  ...k..k..k..k..k
	defb 002h,000h,06bh,002h,000h,06bh,0fdh,080h,005h,01ch,000h,07fh,0fch,080h,004h,007h	; 72cf  ..k..k..........
	defb 000h,02ah,007h,000h,02ah,007h,000h,02ah,007h,000h,02ah,00eh,0ffh,007h,000h,0aah	; 72df  .*..*..*..*.....
	defb 007h,000h,07fh,007h,000h,0beh,007h,000h,08fh,007h,000h,0d6h,00eh,000h,0a0h,007h	; 72ef  ................
	defb 0ffh,070h,0ffh,080h,008h,0f8h,038h,001h,0fch,01ch,001h,0fch,003h,001h,0fch,0f9h	; 72ff  .p....8.........
	defb 003h,001h,0fch,003h,001h,0fch,003h,001h,0fch,004h,001h,0fch,0fah,003h,001h,0fch	; 730f  ................
	defb 003h,001h,0fch,0fbh,003h,001h,0fch,003h,001h,0fch,0f8h,038h,001h,0ach,01ch,001h	; 731f  ...........8....
	defb 0ach,003h,001h,0ach,0f9h,003h,001h,0ach,003h,001h,0ach,003h,001h,0ach,004h,001h	; 732f  ................
	defb 0ach,0fah,003h,001h,0ach,003h,001h,0ach,0fbh,003h,001h,0ach,003h,001h,0ach,0f8h	; 733f  ................
	defb 038h,001h,0fch,01ch,001h,0fch,003h,001h,0fch,0f9h,003h,001h,0fch,003h,001h,0fch	; 734f  8...............
	defb 003h,001h,0fch,004h,001h,0fch,0fah,003h,001h,0fch,003h,001h,0fch,0fbh,003h,001h	; 735f  ................
	defb 0fch,003h,001h,0fch,0f8h,038h,001h,0ach,01ch,001h,0ach,003h,001h,0ach,0f9h,003h	; 736f  .....8..........
	defb 001h,0ach,003h,001h,0ach,003h,001h,0ach,004h,001h,0ach,0fah,003h,001h,0ach,003h	; 737f  ................
	defb 001h,0ach,0fbh,003h,001h,0ach,003h,001h,0ach,080h,005h,0fdh,01ch,002h,0cfh,020h	; 738f  ...............
	defb 002h,0cfh,080h,000h,0fah,006h,001h,07dh,00eh,001h,068h,020h,001h,068h,012h,001h	; 739f  .......}..h .h..
	defb 068h,00dh,001h,068h,00ch,001h,068h,00ah,001h,068h,009h,001h,068h,080h,003h,012h	; 73af  h..h..h..h..h...
	defb 001h,068h,006h,001h,07dh,006h,001h,068h,007h,001h,07dh,006h,001h,068h,006h,001h	; 73bf  .h..}..h..}..h..
	defb 07dh,006h,001h,068h,010h,001h,07dh,080h,005h,0fdh,01ch,002h,0cfh,01ch,002h,0cfh	; 73cf  }..h..}.........
	defb 080h,000h,0fah,006h,000h,0beh,00eh,000h,0b4h,01fh,000h,0b4h,012h,000h,0b4h,00dh	; 73df  ................
	defb 000h,0b4h,00ch,000h,0b4h,00ah,000h,0b4h,009h,000h,0b4h,080h,003h,00ch,000h,0b4h	; 73ef  ................
	defb 008h,000h,0beh,007h,000h,0b4h,006h,000h,0beh,006h,000h,0b4h,005h,000h,0beh,00ah	; 73ff  ................
	defb 000h,0b4h,006h,000h,0beh,012h,000h,0b4h,00ah,000h,0beh,080h,008h,0f8h,038h,001h	; 740f  ..............8.
	defb 0fch,01ch,001h,0fch,003h,001h,0fch,0f9h,003h,001h,0fch,003h,001h,0fch,003h,001h	; 741f  ................
	defb 0fch,004h,001h,0fch,0fah,003h,001h,0fch,003h,001h,0fch,0fbh,003h,001h,0fch,003h	; 742f  ................
	defb 001h,0fch,0f8h,038h,001h,0ach,01ch,001h,0ach,003h,001h,0ach,0f9h,003h,001h,0ach	; 743f  ...8............
	defb 003h,001h,0ach,003h,001h,0ach,004h,001h,0ach,0fah,003h,001h,0ach,003h,001h,0ach	; 744f  ................
	defb 0fbh,003h,001h,0ach,003h,001h,0ach,0f8h,038h,001h,0fch,01ch,001h,0fch,003h,001h	; 745f  ........8.......
	defb 0fch,0f9h,003h,001h,0fch,003h,001h,0fch,003h,001h,0fch,004h,001h,0fch,0fah,003h	; 746f  ................
	defb 001h,0fch,003h,001h,0fch,0fbh,003h,001h,0fch,003h,001h,0fch,0f8h,038h,001h,0ach	; 747f  .............8..
	defb 01ch,001h,0ach,003h,001h,0ach,0f9h,003h,001h,0ach,003h,001h,0ach,003h,001h,0ach	; 748f  ................
	defb 004h,001h,0ach,0fah,003h,001h,0ach,003h,001h,0ach,0fbh,003h,001h,0ach,003h,001h	; 749f  ................
	defb 0ach,080h,005h,0fdh,015h,002h,0cfh,023h,002h,0cfh,0fah,080h,004h,005h,001h,07dh	; 74af  .......#.......}
	defb 006h,001h,07dh,080h,008h,008h,001h,069h,001h,001h,06ah,001h,001h,06bh,001h,001h	; 74bf  ..}....i..j..k..
	defb 06ch,001h,001h,06dh,001h,001h,06eh,001h,001h,06fh,001h,001h,070h,001h,001h,071h	; 74cf  l..m..n..o..p..q
	defb 001h,001h,072h,002h,001h,073h,002h,001h,074h,002h,001h,076h,002h,001h,078h,002h	; 74df  ..r..s..t..v..x.
	defb 001h,079h,002h,001h,07ah,002h,001h,07bh,002h,001h,07ch,006h,001h,07dh,008h,001h	; 74ef  .y..z..{..|..}..
	defb 068h,00bh,000h,0f0h,02ch,000h,0f0h,003h,000h,0f1h,003h,000h,0f2h,003h,000h,0f3h	; 74ff  h...,...........
	defb 003h,000h,0f4h,003h,000h,0f5h,003h,000h,0f6h,003h,000h,0f7h,003h,000h,0f8h,003h	; 750f  ................
	defb 000h,0f9h,003h,000h,0fah,003h,000h,0fbh,003h,000h,0fch,003h,000h,0fdh,003h,000h	; 751f  ................
	defb 0feh,003h,000h,0ffh,003h,001h,000h,004h,001h,002h,005h,001h,004h,080h,005h,0fdh	; 752f  ................
	defb 015h,002h,0cfh,023h,002h,0cfh,080h,004h,0fdh,003h,000h,08fh,003h,000h,07fh,080h	; 753f  ...#............
	defb 003h,024h,000h,078h,0fah,007h,000h,07fh,007h,0ffh,007h,000h,08fh,007h,0ffh,007h	; 754f  .$.x............
	defb 000h,097h,007h,0ffh,007h,000h,0b4h,007h,0ffh,006h,000h,097h,006h,0ffh,006h,000h	; 755f  ................
	defb 0b4h,006h,0ffh,005h,000h,097h,005h,0ffh,005h,000h,0b4h,005h,0ffh,004h,000h,097h	; 756f  ................
	defb 004h,0ffh,004h,000h,0b4h,004h,0ffh,004h,000h,097h,003h,0ffh,004h,000h,0b4h,003h	; 757f  ................
	defb 0ffh,003h,000h,097h,003h,0ffh,003h,000h,0b4h,003h,0ffh,003h,000h,097h,002h,0ffh	; 758f  ................
	defb 003h,000h,0b4h,002h,0ffh,003h,000h,097h,002h,0ffh,003h,000h,0b4h,002h,0ffh,003h	; 759f  ................
	defb 000h,097h,002h,0ffh,003h,000h,0b4h,002h,0ffh,003h,000h,097h,002h,0ffh,003h,000h	; 75af  ................
	defb 0b4h,002h,0ffh,002h,000h,097h,002h,0ffh,080h,001h,018h,000h,0b4h,080h,004h,0fdh	; 75bf  ................
	defb 007h,002h,0f6h,007h,002h,0f6h,007h,002h,0f6h,007h,002h,0f6h,0fbh,080h,008h,064h	; 75cf  ...............d
	defb 000h,05fh,0fah,006h,000h,05fh,0f9h,006h,000h,05fh,0f8h,007h,000h,05fh,007h,000h	; 75df  ._..._..._..._..
	defb 05fh,080h,003h,0fbh,00eh,000h,06bh,00eh,000h,05fh,02ah,000h,05ah,00eh,000h,05fh	; 75ef  _.....k.._*.Z.._
	defb 00eh,000h,06bh,00eh,000h,078h,00eh,000h,06bh,00eh,000h,078h,046h,000h,07fh,01ch	; 75ff  ..k..x..k..xF...
	defb 000h,05ah,00eh,000h,05fh,00eh,000h,06bh,00eh,000h,05fh,01ch,000h,078h,00eh,000h	; 760f  .Z.._..k.._..x..
	defb 06bh,00eh,000h,078h,00eh,000h,06bh,007h,000h,078h,007h,000h,06bh,00eh,000h,078h	; 761f  k..x..k..x..k..x
	defb 0fah,080h,008h,038h,000h,07fh,070h,000h,07fh,080h,003h,081h,001h,0fah,062h,000h	; 762f  ...8..p.......b.
	defb 0f0h,00eh,000h,0d6h,07eh,000h,0beh,00eh,000h,0f0h,00eh,000h,0d6h,02ah,000h,0a0h	; 763f  ....~........*..
	defb 00eh,000h,0f0h,00eh,001h,040h,0f9h,00fh,001h,068h,010h,001h,040h,00ah,001h,068h	; 764f  .....@...h..@..h
	defb 00ch,001h,040h,01ah,001h,068h,080h,008h,0f8h,038h,001h,07dh,0f7h,031h,001h,07dh	; 765f  ..@..h...8.}.1.}
	defb 0f6h,028h,001h,07dh,0f5h,038h,001h,07dh,0f4h,038h,001h,07dh,081h,000h,082h,080h	; 766f  .(.}.8.}.8.}....
	defb 076h,080h,004h,0f8h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h	; 767f  v.....}..P..@..P
	defb 00ch,001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h	; 768f  ..@..}..P.......
	defb 040h,080h,004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h,00ch	; 769f  @....}..P..@..P.
	defb 001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h,040h	; 76af  .@..}..P.......@
	defb 080h,004h,0f9h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h,00ch	; 76bf  .....}..P..@..P.
	defb 001h,040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h,040h	; 76cf  .@..}..P.......@
	defb 080h,004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h,00ch,001h	; 76df  ....}..P..@..P..
	defb 040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h,040h,080h	; 76ef  @..}..P.......@.
	defb 004h,0fah,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h,00ch,001h	; 76ff  ....}..P..@..P..
	defb 040h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h,040h,080h	; 770f  @..}..P.......@.
	defb 004h,00ch,001h,07dh,00ch,001h,050h,00ch,001h,040h,00ch,001h,050h,00ch,001h,040h	; 771f  ...}..P..@..P..@
	defb 00ch,001h,07dh,00ch,001h,050h,00ch,001h,01dh,080h,003h,018h,001h,040h,080h,002h	; 772f  ..}..P.......@..
	defb 0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h,055h,00ch,000h,050h	; 773f  ..._..U..P..U..P
	defb 00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h,000h,050h,080h	; 774f  .._..U..G.....P.
	defb 002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h,055h,00ch,000h	; 775f  ...._..U..P..U..
	defb 050h,00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h,000h,050h	; 776f  P.._..U..G.....P
	defb 080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h,055h,00ch	; 777f  ....._..U..P..U.
	defb 000h,050h,00ch,000h,05fh,00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h,000h	; 778f  .P.._..U..G.....
	defb 050h,080h,002h,0fch,00ch,000h,05fh,00ch,000h,055h,00ch,000h,050h,00ch,000h,05fh	; 779f  P....._..U..P.._
	defb 00ch,000h,055h,00ch,000h,047h,080h,005h,0fdh,018h,000h,050h,018h,000h,050h,018h	; 77af  ..U..G.....P..P.
	defb 0ffh,018h,000h,050h,018h,000h,050h,018h,0ffh,0fch,018h,000h,050h,018h,000h,050h	; 77bf  ...P..P.....P..P
	defb 018h,0ffh,0fbh,018h,000h,050h,018h,000h,050h,018h,0ffh,0fah,018h,000h,050h,018h	; 77cf  .....P..P.....P.
	defb 000h,050h,018h,0ffh,0f9h,018h,000h,050h,018h,000h,050h,018h,0ffh,0f8h,018h,000h	; 77df  .P.....P..P.....
	defb 050h,018h,000h,050h,018h,0ffh,0f7h,018h,000h,050h,018h,000h,050h,018h,0ffh,0f6h	; 77ef  P..P.....P..P...
	defb 018h,000h,050h,018h,000h,050h,018h,0ffh,082h,051h,072h,081h,001h,080h,008h,0f6h	; 77ff  ..P..P...Qr.....
	defb 070h,000h,07fh,070h,000h,07fh,054h,000h,07fh,007h,000h,07fh,015h,000h,0beh,0f6h	; 780f  p..p..T.........
	defb 038h,000h,0aah,0f7h,034h,000h,0aah,001h,000h,0aah,001h,000h,0aah,001h,000h,0aah	; 781f  8...4...........
	defb 001h,000h,0aah,0f8h,001h,000h,0aah,001h,000h,0aah,001h,000h,0aah,001h,000h,0aah	; 782f  ................
	defb 00ah,000h,0aah,00eh,000h,0aah,00eh,000h,0aah,00ah,000h,0aah,001h,000h,0aah,001h	; 783f  ................
	defb 000h,0aah,001h,000h,0aah,001h,000h,0aah,0f9h,001h,000h,0aah,001h,000h,0aah,001h	; 784f  ................
	defb 000h,0aah,001h,000h,0aah,00ah,000h,0aah,00eh,000h,0aah,00ch,000h,0aah,002h,0ffh	; 785f  ................
	defb 080h,005h,0fbh,01dh,000h,0aah,0f9h,007h,000h,040h,007h,000h,040h,007h,000h,040h	; 786f  .........@..@..@
	defb 007h,000h,040h,00fh,0ffh,0f9h,007h,000h,0ach,007h,000h,081h,007h,000h,0c0h,007h	; 787f  ..@.............
	defb 000h,091h,007h,000h,0d8h,007h,000h,0a2h,00ch,0ffh,038h,0ffh,00eh,0ffh,080h,008h	; 788f  ..........8.....
	defb 0f6h,00eh,000h,040h,01ch,000h,040h,070h,000h,040h,070h,000h,040h,070h,000h,040h	; 789f  ...@..@p.@p.@p.@
	defb 070h,000h,040h,080h,005h,0fdh,01ch,003h,0fbh,023h,003h,0fbh,031h,0ffh,070h,0ffh	; 78af  p.@......#..1.p.
	defb 015h,0ffh,080h,005h,0fdh,01ch,003h,0fbh,023h,003h,0fbh,031h,0ffh,070h,0ffh,021h	; 78bf  ........#..1.p.!
	defb 0ffh,0fdh,080h,008h,0f6h,070h,000h,040h,070h,000h,040h,070h,000h,040h,070h,000h	; 78cf  .....p.@p.@p.@p.
	defb 040h,080h,005h,0fdh,015h,003h,0fbh,026h,003h,0fbh,035h,0ffh,072h,0ffh,080h,005h	; 78df  @......&..5.r...
	defb 0fdh,015h,003h,0fbh,024h,003h,0fbh,0f9h,003h,000h,091h,003h,000h,081h,080h,003h	; 78ef  ....$...........
	defb 024h,000h,07ah,007h,000h,081h,007h,0ffh,007h,000h,091h,007h,0ffh,007h,000h,099h	; 78ff  $.z.............
	defb 007h,0ffh,007h,000h,0b6h,007h,0ffh,006h,000h,099h,006h,0ffh,006h,000h,0b6h,006h	; 790f  ................
	defb 0ffh,005h,000h,099h,005h,0ffh,005h,000h,0b6h,005h,0ffh,004h,000h,099h,004h,0ffh	; 791f  ................
	defb 004h,000h,0b6h,004h,0ffh,004h,000h,099h,003h,0ffh,004h,000h,0b6h,003h,0ffh,003h	; 792f  ................
	defb 000h,099h,003h,0ffh,003h,000h,0b6h,003h,0ffh,003h,000h,099h,002h,0ffh,003h,000h	; 793f  ................
	defb 0b6h,002h,0ffh,003h,000h,099h,002h,0ffh,003h,000h,0b6h,002h,0ffh,003h,000h,099h	; 794f  ................
	defb 002h,0ffh,003h,000h,0b6h,002h,0ffh,003h,000h,097h,002h,0ffh,003h,000h,0b6h,002h	; 795f  ................
	defb 0ffh,002h,000h,099h,002h,0ffh,080h,003h,017h,000h,0b6h,080h,004h,0fdh,007h,002h	; 796f  ................
	defb 0fah,007h,002h,0fah,007h,002h,0fah,007h,002h,0fah,003h,0ffh,0fbh,080h,008h,064h	; 797f  ...............d
	defb 000h,060h,0fah,006h,000h,060h,0f9h,006h,000h,060h,0f8h,007h,000h,060h,007h,000h	; 798f  .`...`...`...`..
	defb 060h,080h,003h,0fbh,00eh,000h,06ch,00eh,000h,060h,02ah,000h,05bh,00eh,000h,060h	; 799f  `.....l..`*.[..`
	defb 00eh,000h,06ch,00eh,000h,079h,00eh,000h,06ch,00eh,000h,079h,046h,000h,080h,01ch	; 79af  ..l..y..l..yF...
	defb 000h,05bh,00eh,000h,060h,00eh,000h,06ch,00eh,000h,060h,01ch,000h,079h,00eh,000h	; 79bf  .[..`..l..`..y..
	defb 06ch,00eh,000h,079h,00eh,000h,06ch,007h,000h,079h,007h,000h,06ch,00eh,000h,079h	; 79cf  l..y..l..y..l..y
	defb 0f9h,080h,008h,038h,000h,080h,06dh,000h,080h,080h,005h,081h,000h,0f7h,00eh,000h	; 79df  ...8..m.........
	defb 03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h,028h,01ch,000h,03ch,00eh,000h,050h	; 79ef  <..P..<..(..<..P
	defb 00eh,000h,03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h,028h,01ch,000h,03ch,00eh	; 79ff  ..<..P..<..(..<.
	defb 000h,050h,00eh,000h,03ch,00eh,000h,050h,00eh,000h,03ch,01ch,000h,028h,01ch,000h	; 7a0f  .P..<..P..<..(..
	defb 03ch,00eh,000h,050h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch	; 7a1f  <..P..<..5..(..<
	defb 00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,00ah,000h,035h,0f6h,00ah,000h,028h	; 7a2f  ..5..(..<..5...(
	defb 00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,00ah,000h,035h,00ah	; 7a3f  ..<..5..(..<..5.
	defb 000h,028h,0f5h,00ah,000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,00ah	; 7a4f  .(...<..5..(..<.
	defb 000h,035h,00ah,000h,028h,00ah,000h,03ch,0f4h,00ah,000h,035h,00ah,000h,028h,00ah	; 7a5f  .5..(..<...5..(.
	defb 000h,03ch,00ah,000h,035h,00ah,000h,028h,00ah,000h,03ch,0f3h,00ah,000h,035h,00ah	; 7a6f  .<..5..(..<...5.
	defb 000h,028h,00ah,000h,03ch,0f2h,00ah,000h,035h,00ah,000h,028h,006h,000h,03ch,080h	; 7a7f  .(..<...5..(..<.
	defb 008h,0f4h,081h,001h,078h,000h,0a0h,078h,000h,0a0h,078h,000h,0a0h,078h,000h,0a0h	; 7a8f  ....x..x..x..x..
	defb 080h,004h,081h,000h,0f9h,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,00ch,000h	; 7a9f  ................
	defb 08fh,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,078h,080h,003h,018h	; 7aaf  ............x...
	defb 000h,07fh,080h,004h,0fah,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,07fh,00ch,000h	; 7abf  ................
	defb 08fh,00ch,000h,07fh,00ch,000h,0a0h,00ch,000h,08fh,00ch,000h,078h,080h,003h,0fch	; 7acf  ............x...
	defb 017h,000h,07fh,001h,0ffh,080h,008h,0f9h,081h,008h,05fh,000h,0feh,001h,0ffh,080h	; 7adf  .........._.....
	defb 005h,0fdh,017h,000h,0feh,001h,0ffh,017h,000h,0feh,001h,0ffh,080h,008h,0f9h,047h	; 7aef  ...............G
	defb 000h,0feh,001h,0ffh,080h,005h,0fdh,017h,000h,0feh,001h,0ffh,017h,000h,0feh,001h	; 7aff  ................
	defb 0ffh,080h,008h,0f9h,047h,000h,0feh,001h,0ffh,080h,005h,0fdh,018h,000h,0feh,080h	; 7b0f  ....G...........
	defb 008h,0f9h,047h,000h,0feh,001h,0ffh,080h,005h,081h,000h,0fch,018h,000h,07fh,018h	; 7b1f  ..G.............
	defb 000h,07fh,018h,0ffh,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0fah,018h,000h,07fh	; 7b2f  ................
	defb 018h,000h,07fh,018h,0ffh,0f9h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0f8h,018h	; 7b3f  ................
	defb 000h,07fh,018h,000h,07fh,018h,0ffh,0f7h,018h,000h,07fh,018h,000h,07fh,018h,0ffh	; 7b4f  ................
	defb 0f6h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,0f5h,018h,000h,07fh,018h,000h,07fh	; 7b5f  ................
	defb 018h,0ffh,0f4h,018h,000h,07fh,018h,000h,07fh,018h,0ffh,082h,00ah,078h,080h,006h	; 7b6f  .............x..
	defb 0fdh,070h,0ffh,094h,005h,003h,0f4h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch	; 7b7f  .p..............
	defb 0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,038h,0ffh,085h	; 7b8f  .............8..
	defb 0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch,0ffh,0fdh,005h	; 7b9f  ................
	defb 003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,0fdh,007h,002h,0a7h,007h,001h	; 7baf  ................
	defb 0fch,007h,002h,0fah,007h,002h,03bh,007h,003h,057h,015h,002h,081h,095h,080h,006h	; 7bbf  ......;..W......
	defb 0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch,0ffh,0fdh,005h	; 7bcf  ................
	defb 003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,038h,0ffh,085h,080h,005h,0feh	; 7bdf  ..........8.....
	defb 01ch,003h,0f9h,023h,003h,0f9h,080h,000h,0fah,006h,001h,07fh,00eh,001h,06ah,020h	; 7bef  ...#..........j
	defb 001h,06ah,012h,001h,06ah,00dh,001h,06ah,00ch,001h,06ah,00ah,001h,06ah,009h,001h	; 7bff  .j..j..j..j..j..
	defb 06ah,080h,003h,012h,001h,06ah,006h,001h,07fh,006h,001h,06ah,007h,001h,07fh,006h	; 7c0f  j....j.....j....
	defb 001h,06ah,006h,001h,07fh,006h,001h,06fh,00dh,001h,07fh,080h,005h,0feh,01ch,003h	; 7c1f  .j.....o........
	defb 0f9h,01fh,003h,0f9h,080h,000h,0fah,006h,000h,0c0h,00eh,000h,0b6h,01fh,000h,0b6h	; 7c2f  ................
	defb 012h,000h,0b6h,00dh,000h,0b6h,00ch,000h,0b6h,00ah,000h,0b6h,008h,000h,0b6h,080h	; 7c3f  ................
	defb 003h,00ch,000h,0b6h,008h,000h,0c0h,007h,000h,0b6h,006h,000h,0bch,006h,000h,0b6h	; 7c4f  ................
	defb 005h,000h,0bch,00ah,000h,0b6h,006h,000h,0c0h,012h,000h,0b6h,008h,000h,0c0h,094h	; 7c5f  ................
	defb 080h,006h,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch,0ffh	; 7c6f  ................
	defb 0fdh,005h,003h,0f9h,002h,0ffh,006h,003h,0f9h,001h,0ffh,038h,0ffh,085h,080h,005h	; 7c7f  ...........8....
	defb 0feh,015h,003h,0f9h,026h,003h,0f9h,0fah,080h,004h,005h,001h,07dh,006h,001h,07dh	; 7c8f  ....&.......}..}
	defb 080h,008h,008h,001h,06bh,001h,001h,06ch,001h,001h,06dh,001h,001h,06eh,001h,001h	; 7c9f  ....k..l..m..n..
	defb 06fh,001h,001h,070h,001h,001h,071h,001h,001h,072h,001h,001h,073h,001h,001h,074h	; 7caf  o..p..q..r..s..t
	defb 002h,001h,075h,002h,001h,076h,002h,001h,078h,002h,001h,07ah,002h,001h,07bh,002h	; 7cbf  ..u..v..x..z..{.
	defb 001h,07ch,002h,001h,07dh,002h,001h,07eh,006h,001h,07fh,008h,001h,06ah,00bh,000h	; 7ccf  .|..}..~.....j..
	defb 0f2h,02ch,000h,0f2h,003h,000h,0f3h,003h,000h,0f4h,003h,000h,0f5h,003h,000h,0f6h	; 7cdf  .,..............
	defb 003h,000h,0f7h,003h,000h,0f8h,003h,000h,0f9h,003h,000h,0fah,003h,000h,0fbh,003h	; 7cef  ................
	defb 000h,0fch,003h,000h,0fdh,003h,000h,0feh,003h,000h,0ffh,003h,001h,000h,003h,001h	; 7cff  ................
	defb 001h,003h,001h,002h,004h,001h,004h,002h,001h,006h,080h,005h,0feh,015h,003h,0f9h	; 7d0f  ................
	defb 026h,003h,0f9h,03ch,0ffh,080h,006h,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h	; 7d1f  &..<............
	defb 0f9h,001h,0ffh,01ch,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h	; 7d2f  ................
	defb 0ffh,038h,0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,01ch	; 7d3f  .8..............
	defb 0ffh,0fdh,005h,003h,0f9h,002h,0ffh,0fch,006h,003h,0f9h,001h,0ffh,015h,0ffh,080h	; 7d4f  ................
	defb 000h,0fdh,007h,005h,0f4h,007h,005h,0f4h,007h,005h,0f4h,007h,005h,0f4h,095h,080h	; 7d5f  ................
	defb 003h,0fdh,01ch,005h,0f4h,001h,004h,0c0h,001h,004h,080h,001h,004h,000h,001h,003h	; 7d6f  ................
	defb 0c0h,001h,003h,080h,001h,003h,000h,016h,002h,0fah,01ch,005h,0f4h,015h,002h,0fah	; 7d7f  ................
	defb 007h,002h,0fah,085h,0fdh,01ch,005h,0f4h,01ch,002h,0fah,0fch,01ch,003h,0c0h,01ch	; 7d8f  ................
	defb 003h,0f9h,080h,003h,0fch,07eh,003h,0c0h,01ch,003h,0c0h,00eh,003h,057h,038h,002h	; 7d9f  .....~.......W8.
	defb 0fah,070h,003h,0c0h,01fh,005h,001h,030h,005h,09eh,080h,008h,0f8h,00eh,005h,0f4h	; 7daf  .p.....0........
	defb 00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,0f7h,00eh,005h,0f4h,00eh,005h,0f4h	; 7dbf  ................
	defb 00eh,005h,0f4h,013h,005h,0f4h,00eh,005h,0f4h,0f6h,00eh,005h,0f4h,00eh,005h,0f4h	; 7dcf  ................
	defb 00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh,005h,0f4h,00eh	; 7ddf  ................
	defb 005h,0f4h,00eh,005h,0f4h,078h,005h,0f4h,0f5h,078h,005h,0f4h,080h,008h,0f8h,018h	; 7def  .....x...x......
	defb 005h,0f4h,0f7h,018h,005h,0f4h,0f6h,018h,005h,0f4h,018h,005h,0f4h,0f5h,018h,005h	; 7dff  ................
	defb 0f4h,018h,005h,0f4h,0f4h,018h,005h,0f4h,00ch,005h,0f4h,0f3h,00ch,005h,0f4h,00ch	; 7e0f  ................
	defb 005h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,0f9h,018h,005h,0f4h,0f8h	; 7e1f  ................
	defb 018h,005h,0f4h,0f7h,018h,005h,0f4h,018h,005h,0f4h,0f6h,018h,005h,0f4h,018h,005h	; 7e2f  ................
	defb 0f4h,0f5h,018h,005h,0f4h,00ch,005h,0f4h,0f4h,00ch,005h,0f4h,00ch,005h,0f4h,00ch	; 7e3f  ................
	defb 005h,0f4h,080h,005h,0fdh,018h,003h,0f9h,093h,080h,002h,00ch,005h,0f4h,00ch,005h	; 7e4f  ................
	defb 04dh,00ch,005h,001h,00ch,005h,04dh,00ch,005h,001h,00ch,005h,0f4h,00ch,005h,04dh	; 7e5f  M.....M........M
	defb 00ch,004h,075h,080h,005h,018h,005h,001h,085h,080h,002h,00ch,005h,0f4h,00ch,005h	; 7e6f  ..u.............
	defb 04dh,00ch,005h,001h,00ch,005h,0f4h,00ch,005h,04dh,00ch,004h,075h,080h,005h,018h	; 7e7f  M........M..u...
	defb 003h,0f9h,018h,003h,0f9h,018h,0ffh,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,0fch	; 7e8f  ................
	defb 018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,0fbh,018h,003h,0f9h,018h,003h,0f9h,018h	; 7e9f  ................
	defb 0ffh,0fbh,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,018h,003h,0f9h,018h,003h,0f9h	; 7eaf  ................
	defb 018h,0ffh,0fah,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,0f9h,018h,003h,0f9h,018h	; 7ebf  ................
	defb 003h,0f9h,018h,0ffh,0f8h,018h,003h,0f9h,018h,003h,0f9h,018h,0ffh,082h,07dh,07bh	; 7ecf  ..............}{
	defb 080h,004h,0fbh,008h,000h,030h,0f9h,008h,000h,030h,008h,000h,030h,0fah,008h,000h	; 7edf  .....0...0..0...
	defb 02dh,0f9h,008h,000h,02dh,080h,000h,020h,000h,035h,080h,000h,0f7h,006h,005h,04dh	; 7eef  -...-.. .5.....M
	defb 0f6h,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0f8h,006h,005h,04dh,0f7h,006h	; 7eff  ......M......M..
	defb 005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0f9h,006h,005h,04dh,0f8h,006h,005h,0f4h	; 7f0f  ....M......M....
	defb 006h,005h,04dh,006h,005h,0f4h,0fah,006h,005h,04dh,0f9h,006h,005h,0f4h,006h,005h	; 7f1f  ..M......M......
	defb 04dh,006h,005h,0f4h,0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h,005h,001h,006h	; 7f2f  M......M........
	defb 005h,0f4h,0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h	; 7f3f  .....M......M...
	defb 0fbh,006h,005h,04dh,0fah,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fch,006h	; 7f4f  ...M......M.....
	defb 005h,04dh,0fbh,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fch,006h,005h,04dh	; 7f5f  .M......M......M
	defb 0fbh,006h,005h,0f4h,006h,006h,0aeh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h	; 7f6f  .............M..
	defb 005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h	; 7f7f  ....M......M....
	defb 006h,005h,04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h	; 7f8f  ..M......M......
	defb 04dh,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,0fdh,006h,005h,001h	; 7f9f  M......M........
	defb 0fch,006h,005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h	; 7faf  .......M......M.
	defb 005h,0f4h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h	; 7fbf  .....M......M...
	defb 0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h,0fdh,006h	; 7fcf  ...M......M.....
	defb 005h,04dh,0fch,006h,005h,0f4h,006h,006h,0aeh,006h,005h,0f4h,082h,0eeh,07fh,093h	; 7fdf  .M..............
	defb 080h,000h,0fdh,006h,005h,04dh,0fch,006h,005h,0f4h,006h,005h,04dh,006h,005h,0f4h	; 7fef  .....M......M...
	defb 0fdh	; 7fff
