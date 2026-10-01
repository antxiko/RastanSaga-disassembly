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
l9707h:	equ 0x09707

; ======================================================================
; CODIGO 0x8000..0x8096  (150 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; (Sigue de p06:7FF2.) Rastan toca el bloque especial de tipo 1-3: un arma.
; La coge (D919, bits 0-1 de D905), le da segundos segun la puntuacion, suma
; puntos y el bloque desaparece.
; ----------------------------------------------------------------------
coge_arma:
	cp 01dh		;8000   ; fuera de la caja en x: nada
	ret nc			;8002   ; x del bloque - x del golpe + 0x0E fuera de 0-0x1C
	ld a,(0d92ch)		;8003   ; fuera en y: nada
	sub l			;8006   ; y del bloque - y del golpe...
	add a,00eh		;8007   ; ...+ 0x0E...
	cp 01dh		;8009   ; ...dentro de 0-0x1C?
	ret nc			;800b   ; no: nada
	ld a,(0d92dh)		;800c   ; que arma es
	cp 001h		;800f   ; tipo 1?
	jr z,arma_1		;8011
	cp 002h		;8013   ; tipo 2?
	jr z,arma_2		;8015
	cp 003h		;8017   ; tipo 3?
	jr z,arma_3		;8019
	xor a			;801b   ; ninguna: arma 0
	ld b,000h		;801c   ; sin puntos
	jr pon_arma		;801e
arma_2:
	ld a,002h		;8020   ; arma 2, 0x30 puntos
	ld b,030h		;8022   ; B = puntos (BCD)
	jr pon_arma		;8024
arma_1:
	ld a,001h		;8026   ; arma 1, 0x20 puntos
	ld b,020h		;8028   ; 0x20 puntos
	jr pon_arma		;802a
arma_3:
	ld a,003h		;802c   ; arma 3, sin puntos
	ld b,000h		;802e   ; sin puntos
pon_arma:
	ld (0d919h),a		;8030   ; el arma
	ld d,a			;8033   ; D = el arma
	ld a,(0d905h)		;8034   ; en los bits 0-1 de D905, con el bit 4
	and 0fch		;8037   ; fuera el arma de antes...
	or d			;8039   ; ...la nueva...
	set 4,a		;803a   ; ...y el bit 4
	ld (0d905h),a		;803c   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	exx			;803f   ; (HL alternativo: no se pierde el HL del golpe)
	ld hl,0d928h		;8040   ; suceso del bit 3: efecto 6
	set 3,(hl)		;8043   ; suceso del bit 3
	exx			;8045
	ld a,(0d920h)		;8046   ; cuanto dura, segun la puntuacion (cifras 5-6):
	ld d,05ah		;8049   ; D = 90
	cp 010h		;804b   ; 0x10 o mas: 90 segundos
	jr nc,pon_segundos		;804d
	ld d,050h		;804f   ; D = 80
	cp 006h		;8051   ; 6 o mas: 80
	jr nc,pon_segundos		;8053
	ld d,046h		;8055   ; D = 70
	cp 003h		;8057   ; 3 o mas: 70
	jr nc,pon_segundos		;8059
	ld d,03ch		;805b   ; D = 60
	cp 001h		;805d   ; 1 o mas: 60
	jr nc,pon_segundos		;805f
	ld d,032h		;8061   ; menos: 50
pon_segundos:
	ld a,d			;8063   ; apuntado
	ld (0d91ah),a		;8064   ; segundos que le quedan al arma = a
	ld e,b			;8067   ; los puntos del arma...
	ld d,000h		;8068   ; DE = los puntos
	push bc			;806a   ; se guardan BC y HL
	push hl			;806b
	ld bc,00000h		;806c   ; BC = 0: el resto de la suma
	call suma_puntos		;806f   ; ...a la puntuacion
	xor a			;8072   ; ya no hay bloque especial...
	ld (0d92dh),a		;8073   ; cual es el bloque especial = a
	call 0629eh		;8076   ; ...y se repinta el fondo
	pop hl			;8079   ; HL y BC de vuelta
	pop bc			;807a
	ret			;807b

; ----------------------------------------------------------------------
; Puntos por matar un actor: la palabra de su tipo en p07:8096.
; ----------------------------------------------------------------------
puntos_por_actor:
	push bc			;807c   ; guarda BC, DE y HL
	push de			;807d
	push hl			;807e
	ld l,(ix+000h)		;807f   ; tipo * 2...
	ld h,000h		;8082   ; HL = tipo...
	add hl,hl			;8084   ; ...* 2
	ld de,puntos_tipo_0		;8085   ; ...en la tabla (que empieza en el tipo 1)
	add hl,de			;8088   ; + tabla
	ld e,(hl)			;8089   ; E y...
	inc hl			;808a
	ld d,(hl)			;808b   ; ...D: los puntos del tipo
	ld bc,00000h		;808c   ; sumados
	call suma_puntos		;808f   ; a la puntuacion
	pop hl			;8092   ; de vuelta
	pop de			;8093
puntos_tipo_0:
	pop bc			;8094   ; (la palabra del tipo 0 de la tabla cae en este `pop bc / ret`)
	ret			;8095   ; vuelve

; ----------------------------------------------------------------------
; DATOS puntos_por_tipo: Los puntos de cada tipo de actor (1-24), palabras BCD
;   0x8096..0x80c6  (48 bytes)
DATA_puntos_por_tipo:
	defw 00030h,00050h,00030h,00050h,00020h,00090h,00070h,00020h	; 8096
	defw 00050h,00020h,00020h,00010h,00070h,00020h,00050h,00050h	; 80a6
	defw 00040h,00080h,00070h,00070h,00090h,00000h,00000h,00000h	; 80b6

; ----------------------------------------------------------------------
; DATOS fuerza_por_arma: La fuerza del golpe por arma: 8 bytes por arma, los 4
;   primeros en el suelo y los 4 de despues en el aire (p06:7C80)
;   0x80c6..0x80e6  (32 bytes)
DATA_fuerza_por_arma:
	defb 008h,008h,00ch,000h,00ch,00ch,020h,000h	; 80c6  ...... .
	defb 020h,020h,030h,000h,024h,024h,034h,000h	; 80ce    0.$$4.
	defb 008h,008h,00ch,000h,00ch,00ch,020h,000h	; 80d6  ...... .
	defb 030h,030h,030h,000h,034h,034h,034h,000h	; 80de  000.444.

; ======================================================================
; CODIGO 0x80e6..0x8407  (801 bytes)
; ======================================================================


clase_en:
	ld a,l			;80e6   ; la fila de (y - 0x20)...
	sub 010h		;80e7   ; y - 0x20...
	sub 010h		;80e9
	and 0f0h		;80eb   ; ...en filas de 16
	ld b,000h		;80ed   ; BC = fila * 16
	ld c,a			;80ef
	ld a,h			;80f0   ; ...la columna de x...
	and 0f0h		;80f1   ; x / 16...
	rra			;80f3   ; ...* 2
	rra			;80f4
	rra			;80f5
	ld l,a			;80f6   ; HL = columna * 2
	ld h,000h		;80f7
	add hl,bc			;80f9   ; + fila * 32 (dos veces BC)
	add hl,bc			;80fa
	ld bc,0d774h		;80fb   ; ...en D774...
	add hl,bc			;80fe   ; en el mapa de delante
	inc hl			;80ff   ; ...el byte alto...
	ld a,(hl)			;8100   ; ...solo el nibble de la clase
	and 0f0h		;8101   ; A = la clase
	ret			;8103

; ----------------------------------------------------------------------
; Los choques de Rastan con todo, cada cuadro: los 8 enemigos de DA20, las
; casillas de salida, y si no esta tocado, el cuerpo y los ataques de los
; actores.
; ----------------------------------------------------------------------
choques_jugador:
	ld a,(0d8fch)		;8104   ; HL = (x, y) de Rastan
	ld h,a			;8107   ; H = x
	ld a,(0d8fdh)		;8108   ; a = la y de Rastan
	ld l,a			;810b   ; L = y
	ld ix,0da20h		;810c   ; los 8 de DA20, uno a uno
	call choque_enemigo		;8110   ; el 0
	ld ix,0da46h		;8113   ; ix -> enemigo 1
	call choque_enemigo		;8117   ; el 1
	ld ix,0da6ch		;811a   ; ix -> enemigo 2
	call choque_enemigo		;811e   ; el 2
	ld ix,0da92h		;8121   ; ix -> enemigo 3
	call choque_enemigo		;8125   ; el 3
	ld ix,0dab8h		;8128   ; ix -> enemigo 4
	call choque_enemigo		;812c   ; el 4
	ld ix,0dadeh		;812f   ; ix -> enemigo 5
	call choque_enemigo		;8133   ; el 5
	ld ix,0db04h		;8136   ; ix -> enemigo 6
	call choque_enemigo		;813a   ; el 6
	ld ix,0db2ah		;813d   ; ix -> enemigo 7
	call choque_enemigo		;8141   ; el 7
	call mira_salida		;8144   ; la salida de la fase (p07:85F6)
	call coge_objeto		;8147   ; p07:8BC6
	ld a,(0d90fh)		;814a   ; ya tocado o sin mandos: nada mas
	bit 6,a		;814d   ; bit 6: tocado
	ret nz			;814f
	bit 4,a		;8150   ; bit 4: sin mandos
	ret nz			;8152
	ld a,(0d910h)		;8153   ; D910 bit 1: nada mas
	bit 1,a		;8156   ; bit 1
	ret nz			;8158
	bit 6,a		;8159   ; D910 bit 6: p07:918C
	jp nz,choque_jefe		;815b   ; contra el jefe
	ld a,(0d904h)		;815e   ; agachado: la caja 13 pixeles mas abajo
	and 01eh		;8161   ; la pose...
	cp 004h		;8163   ; ...4: agachado
	jr nz,choques_actores		;8165
	ld a,l			;8167   ; y + 0x0D
	add a,00dh		;8168
	ld l,a			;816a
choques_actores:
	call cuerpo_actores		;816b   ; contra el cuerpo de los actores
	call ataques_actores		;816e   ; contra sus ataques
	ret			;8171

; ----------------------------------------------------------------------
; Los ataques de los actores: segun su tipo (tabla de p07:8404, 3 bytes:
; dano y rutina), si estan en su pose de ataque (bits 1-3 = 2) y en el
; cuadro bueno, una caja delante de ellos. El dano se suma en C.
; ----------------------------------------------------------------------
ataques_actores:
	ld ix,0d933h		;8172   ; los 3 actores de D933
	ld a,003h		;8176   ; tres actores
	ld c,000h		;8178   ; C = dano acumulado
ataque_actor:
	ex af,af'			;817a   ; A' = cuantos quedan
	ld a,(ix+000h)		;817b   ; el tipo: 0, hueco
	ld e,a			;817e   ; E = tipo
	or a			;817f   ; 0: hueco
	jp z,siguiente_ataque		;8180
	cp 018h		;8183   ; 0x18 o mas: sin ataque
	jp nc,siguiente_cuerpo		;8185
	ld a,(ix+00fh)		;8188   ; sin vida: nada
	or a			;818b
	jp z,siguiente_ataque		;818c
	ld d,000h		;818f   ; tipo * 3 + p07:8404:
	push hl			;8191   ; HL guardado para la caja
	ld hl,08404h		;8192
	add hl,de			;8195   ; tipo * 3
	add hl,de			;8196
	add hl,de			;8197
	ld d,(hl)			;8198   ; D = el dano...
	inc hl			;8199   ; ...y la rutina de su caja
	ld a,(hl)			;819a   ; la rutina...
	inc hl			;819b
	ld h,(hl)			;819c
	ld l,a			;819d
	ex (sp),hl			;819e   ; ...en la pila, y HL de vuelta: salta a la rutina
	ret			;819f
caja_ataque_a:
	ld a,(ix+001h)		;81a0   ; pose de ataque?
	ld b,a			;81a3   ; B = la pose
	and 00eh		;81a4   ; bits 1-3...
	cp 002h		;81a6   ; ...= 2: atacando
	jp nz,siguiente_ataque		;81a8
	ld a,(ix+002h)		;81ab   ; cuadro 3 en adelante
	cp 003h		;81ae   ; cuadro de la animacion 3 o mas
	jp c,siguiente_ataque		;81b0
	ld a,(ix+007h)		;81b3   ; y dentro de 0x1F
	sub l			;81b6   ; y del actor - y de Rastan + 7...
	add a,007h		;81b7   ; ...corrida +7...
	cp 01fh		;81b9   ; ...dentro de 0-0x1E?
	jp nc,siguiente_ataque		;81bb   ; no cabe: fuera
	bit 0,b		;81be   ; mirando a la izquierda: p07:81D0
	jr nz,caja_ataque_a_izq		;81c0
	ld a,(ix+006h)		;81c2   ; x del actor - x de Rastan + 0x19...
	sub h			;81c5   ; la diferencia en x...
	add a,019h		;81c6   ; ...corrida +25...
	cp 019h		;81c8   ; ...dentro de 0-0x18?
	jp nc,siguiente_ataque		;81ca   ; no cabe: fuera
	jp le_alcanza		;81cd   ; le alcanza
caja_ataque_a_izq:
	ld a,(ix+006h)		;81d0   ; a la izquierda: x - x - 1...
	sub h			;81d3   ; la diferencia en x...
	sub 001h		;81d4   ; ...corrida -1...
	cp 019h		;81d6   ; ...dentro de 0-0x18?
	jp nc,siguiente_ataque		;81d8   ; no cabe: fuera
	jp le_alcanza		;81db   ; le alcanza
caja_ataque_b:
	ld a,(ix+001h)		;81de
	ld b,a			;81e1
	and 00eh		;81e2
	cp 002h		;81e4
	jp nz,siguiente_ataque		;81e6
	ld a,(ix+007h)		;81e9
	sub l			;81ec   ; la diferencia en y...
	add a,017h		;81ed   ; ...corrida +23...
	cp 027h		;81ef   ; ...cabe en la caja si va de -23 a 15
	jp nc,siguiente_ataque		;81f1   ; no cabe: fuera
	bit 0,b		;81f4
	jr nz,caja_ataque_b_izq		;81f6
	ld a,(ix+006h)		;81f8
	sub h			;81fb   ; la diferencia en x...
	add a,010h		;81fc   ; ...corrida +16...
	cp 017h		;81fe   ; ...cabe en la caja si va de -16 a 6
	jp nc,siguiente_ataque		;8200   ; no cabe: fuera
	jp le_alcanza		;8203
caja_ataque_b_izq:
	ld a,(ix+006h)		;8206
	sub h			;8209   ; la diferencia en x...
	add a,006h		;820a   ; ...corrida +6...
	cp 017h		;820c   ; ...cabe en la caja si va de -6 a 16
	jp nc,siguiente_ataque		;820e   ; no cabe: fuera
	jp le_alcanza		;8211
caja_ataque_c:
	ld a,(ix+001h)		;8214
	ld b,a			;8217
	and 00eh		;8218
	cp 002h		;821a
	jp nz,siguiente_ataque		;821c
	ld a,(ix+002h)		;821f
	cp 003h		;8222
	jp c,siguiente_ataque		;8224
	ld a,(ix+007h)		;8227
	sub l			;822a   ; la diferencia en y...
	add a,007h		;822b   ; ...corrida +7...
	cp 01fh		;822d   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;822f   ; no cabe: fuera
	bit 0,b		;8232
	jr nz,caja_ataque_c_izq		;8234
	ld a,(ix+006h)		;8236
	sub h			;8239   ; la diferencia en x...
	add a,021h		;823a   ; ...corrida +33...
	cp 021h		;823c   ; ...cabe en la caja si va de -33 a -1
	jp nc,siguiente_ataque		;823e   ; no cabe: fuera
	jp le_alcanza		;8241
caja_ataque_c_izq:
	ld a,(ix+006h)		;8244
	sub h			;8247   ; la diferencia en x...
	cp 021h		;8248   ; ...cabe si va de 0 a 32
	jp nc,siguiente_ataque		;824a   ; no cabe: fuera
	jp le_alcanza		;824d
caja_ataque_d:
	ld a,(ix+001h)		;8250
	ld b,a			;8253
	and 00eh		;8254
	cp 002h		;8256
	jp nz,siguiente_ataque		;8258
	ld a,(ix+002h)		;825b
	cp 003h		;825e
	jp c,siguiente_ataque		;8260
	ld a,(ix+007h)		;8263
	sub l			;8266   ; la diferencia en y...
	add a,009h		;8267   ; ...corrida +9...
	cp 020h		;8269   ; ...cabe en la caja si va de -9 a 22
	jp nc,siguiente_ataque		;826b   ; no cabe: fuera
	bit 0,b		;826e
	jr nz,caja_ataque_d_izq		;8270
	ld a,(ix+006h)		;8272
	sub h			;8275   ; la diferencia en x...
	add a,015h		;8276   ; ...corrida +21...
	cp 01eh		;8278   ; ...cabe en la caja si va de -21 a 8
	jp nc,siguiente_ataque		;827a   ; no cabe: fuera
	jp le_alcanza		;827d
caja_ataque_d_izq:
	ld a,(ix+006h)		;8280
	sub h			;8283   ; la diferencia en x...
	add a,00ch		;8284   ; ...corrida +12...
	cp 01eh		;8286   ; ...cabe en la caja si va de -12 a 17
	jp nc,siguiente_ataque		;8288   ; no cabe: fuera
	jp le_alcanza		;828b
caja_ataque_e:
	ld a,(ix+001h)		;828e
	ld b,a			;8291
	and 00eh		;8292
	cp 002h		;8294
	jp nz,siguiente_ataque		;8296
	ld a,(ix+002h)		;8299
	cp 003h		;829c
	jp c,siguiente_ataque		;829e
	ld a,(ix+007h)		;82a1
	sub l			;82a4   ; la diferencia en y...
	add a,007h		;82a5   ; ...corrida +7...
	cp 01fh		;82a7   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;82a9   ; no cabe: fuera
	bit 0,b		;82ac
	jr nz,caja_ataque_e_izq		;82ae
	ld a,(ix+006h)		;82b0
	sub h			;82b3   ; la diferencia en x...
	add a,031h		;82b4   ; ...corrida +49...
	cp 031h		;82b6   ; ...cabe en la caja si va de -49 a -1
	jp nc,siguiente_ataque		;82b8   ; no cabe: fuera
	jp le_alcanza		;82bb
caja_ataque_e_izq:
	ld a,(ix+006h)		;82be
	sub h			;82c1   ; la diferencia en x...
	cp 031h		;82c2   ; ...cabe si va de 0 a 48
	jp nc,siguiente_ataque		;82c4   ; no cabe: fuera
	jp le_alcanza		;82c7

; ----------------------------------------------------------------------
; Huerfana (ninguna entrada de la tabla la elige): segun la pose, una caja
; y un dano; con las poses 0-1 ademas le quita el arma y el escudo.
; ----------------------------------------------------------------------
huerfana_ataque_f:
	ld a,(ix+001h)		;82ca
	and 01eh		;82cd
	cp 002h		;82cf
	jp c,ataque_f_0		;82d1
	jp z,ataque_f_2		;82d4
	cp 008h		;82d7
	jp c,ataque_f_6		;82d9
	jp z,siguiente_ataque		;82dc
	cp 00ch		;82df
	jp c,ataque_f_a		;82e1
	jp z,ataque_f_c		;82e4
	cp 00eh		;82e7
	jp z,ataque_f_e		;82e9
	cp 014h		;82ec
	jp nz,siguiente_ataque		;82ee
	ld a,(ix+006h)		;82f1
	sub h			;82f4   ; la diferencia en x...
	add a,013h		;82f5   ; ...corrida +19...
	cp 017h		;82f7   ; ...cabe en la caja si va de -19 a 3
	jp nc,siguiente_ataque		;82f9   ; no cabe: fuera
	ld a,(ix+007h)		;82fc
	sub l			;82ff   ; la diferencia en y...
	add a,007h		;8300   ; ...corrida +7...
	cp 01fh		;8302   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;8304   ; no cabe: fuera
	set 7,(ix+025h)		;8307
	ld d,00ch		;830b
	jp le_alcanza		;830d
ataque_f_0:
	ld d,00ch		;8310   ; dano 0x0C
	jr ataque_f_caja		;8312
ataque_f_2:
	ld d,018h		;8314   ; dano 0x18
ataque_f_caja:
	ld a,(ix+006h)		;8316
	sub h			;8319   ; la diferencia en x...
	add a,013h		;831a   ; ...corrida +19...
	cp 017h		;831c   ; ...cabe en la caja si va de -19 a 3
	jp nc,siguiente_ataque		;831e   ; no cabe: fuera
	ld a,(ix+007h)		;8321
	sub l			;8324   ; la diferencia en y...
	add a,007h		;8325   ; ...corrida +7...
	cp 01fh		;8327   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;8329   ; no cabe: fuera
	set 7,(ix+025h)		;832c   ; ya le dio este ataque
	ld a,(0d91ah)		;8330   ; le quita el arma: sin segundos...
	or a			;8333
	jr z,ataque_f_escudo		;8334
	xor a			;8336
	ld (0d91ah),a		;8337   ; segundos que le quedan al arma = a
	ld a,(0d905h)		;833a   ; ...sin bits 0-1 en D905...
	and 0fch		;833d
	ld (0d905h),a		;833f   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	xor a			;8342   ; ...arma 0
	ld (0d919h),a		;8343   ; el arma que lleva = a
ataque_f_escudo:
	ld a,(0d926h)		;8346   ; y los golpes que le quedaban al escudo
	or a			;8349
	jp z,le_alcanza		;834a
	xor a			;834d
	ld (0d926h),a		;834e   ; los golpes que le quedan al escudo = a
	jp le_alcanza		;8351
ataque_f_6:
	ld a,(ix+006h)		;8354
	sub h			;8357   ; la diferencia en x...
	add a,012h		;8358   ; ...corrida +18...
	cp 012h		;835a   ; ...cabe en la caja si va de -18 a -1
	jp nc,siguiente_ataque		;835c   ; no cabe: fuera
	ld a,(ix+007h)		;835f
	sub l			;8362   ; la diferencia en y...
	add a,015h		;8363   ; ...corrida +21...
	cp 01bh		;8365   ; ...cabe en la caja si va de -21 a 5
	jp nc,siguiente_ataque		;8367   ; no cabe: fuera
	set 7,(ix+025h)		;836a
	ld d,010h		;836e   ; dano 0x10
	jp le_alcanza		;8370
ataque_f_a:
	ld a,(ix+006h)		;8373
	sub h			;8376   ; la diferencia en x...
	add a,012h		;8377   ; ...corrida +18...
	cp 012h		;8379   ; ...cabe en la caja si va de -18 a -1
	jp nc,siguiente_ataque		;837b   ; no cabe: fuera
	ld a,(ix+007h)		;837e
	sub l			;8381   ; la diferencia en y...
	add a,007h		;8382   ; ...corrida +7...
	cp 01fh		;8384   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;8386   ; no cabe: fuera
	set 7,(ix+025h)		;8389
	ld d,018h		;838d   ; dano 0x18
	jp le_alcanza		;838f
ataque_f_c:
	ld a,(ix+006h)		;8392
	sub h			;8395   ; la diferencia en x...
	add a,012h		;8396   ; ...corrida +18...
	cp 012h		;8398   ; ...cabe en la caja si va de -18 a -1
	jp nc,siguiente_ataque		;839a   ; no cabe: fuera
	ld a,(ix+007h)		;839d
	sub l			;83a0   ; la diferencia en y...
	add a,007h		;83a1   ; ...corrida +7...
	cp 01fh		;83a3   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;83a5   ; no cabe: fuera
	set 7,(ix+025h)		;83a8
	ld d,008h		;83ac   ; dano 8
	jp le_alcanza		;83ae
ataque_f_e:
	ld a,(ix+006h)		;83b1
	sub h			;83b4   ; la diferencia en x...
	add a,013h		;83b5   ; ...corrida +19...
	cp 017h		;83b7   ; ...cabe en la caja si va de -19 a 3
	jp nc,siguiente_ataque		;83b9   ; no cabe: fuera
	ld a,(ix+007h)		;83bc
	sub l			;83bf   ; la diferencia en y...
	add a,007h		;83c0   ; ...corrida +7...
	cp 01fh		;83c2   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_ataque		;83c4   ; no cabe: fuera
	set 7,(ix+025h)		;83c7
	ld d,010h		;83cb   ; dano 0x10
	jp le_alcanza		;83cd

; ----------------------------------------------------------------------
; Le alcanza: con escudo (D91B) el dano va a la mitad y el escudo pierde un
; golpe (D926); al acabarse se quitan los bits 2, 3 y 6 de D905.
; ----------------------------------------------------------------------
le_alcanza:
	ld a,(0d91bh)		;83d0   ; lleva escudo?
	or a			;83d3
	jr z,suma_dano		;83d4
	ld a,(0d926h)		;83d6   ; un golpe menos...
	dec a			;83d9
	ld (0d926h),a		;83da   ; los golpes que le quedan al escudo = a
	jr nz,medio_dano		;83dd   ; ...ninguno: sin escudo...
	ld (0d91bh),a		;83df   ; el escudo que lleva = a
	ld a,(0d905h)		;83e2   ; ...ni sus iconos
	and 0b3h		;83e5
	ld (0d905h),a		;83e7   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
medio_dano:
	srl d		;83ea   ; dano / 2
suma_dano:
	ld a,d			;83ec   ; C + dano
	add a,c			;83ed
	ld c,a			;83ee
	exx			;83ef
	ld hl,0d928h		;83f0   ; suceso del bit 7: efecto 1
	set 7,(hl)		;83f3
	exx			;83f5
siguiente_ataque:
	ld de,00026h		;83f6   ; el siguiente actor
	add ix,de		;83f9
	ex af,af'			;83fb
	dec a			;83fc
	jp nz,ataque_actor		;83fd
	or c			;8400   ; sin dano: nada
	ret z			;8401
	ld d,c			;8402   ; D = todo el dano junto...
	call 07818h		;8403   ; ...a la vida (p06:7818)
	ret			;8406

; ----------------------------------------------------------------------
; DATOS ataque_por_tipo: Por cada tipo de actor (1-23): el dano de su ataque y
;   la rutina de su caja (p07:819E)
;   0x8407..0x844c  (69 bytes)
DATA_ataque_por_tipo:
	defb 010h,0a0h,081h	; 8407
	defb 000h,0f6h,083h	; 840a
	defb 000h,0f6h,083h	; 840d
	defb 010h,0deh,081h	; 8410
	defb 00ch,0f6h,083h	; 8413
	defb 014h,014h,082h	; 8416
	defb 000h,0f6h,083h	; 8419
	defb 000h,0f6h,083h	; 841c
	defb 000h,0f6h,083h	; 841f
	defb 010h,050h,082h	; 8422
	defb 000h,0f6h,083h	; 8425
	defb 000h,0f6h,083h	; 8428
	defb 000h,0f6h,083h	; 842b
	defb 000h,0f6h,083h	; 842e
	defb 000h,0f6h,083h	; 8431
	defb 000h,0f6h,083h	; 8434
	defb 010h,014h,082h	; 8437
	defb 018h,014h,082h	; 843a
	defb 010h,08eh,082h	; 843d
	defb 000h,0f6h,083h	; 8440
	defb 000h,0f6h,083h	; 8443
	defb 000h,0f6h,083h	; 8446
	defb 000h,0f6h,083h	; 8449

; ======================================================================
; CODIGO 0x844c..0x8596  (330 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El cuerpo de los actores: tocarlos hace el dano de la tabla de p07:8592
; (4 bytes: dano, -, rutina de la caja), a la mitad con escudo.
; ----------------------------------------------------------------------
cuerpo_actores:
	ld ix,0d933h		;844c   ; los 3 actores
	ld a,003h		;8450
	ld c,000h		;8452
cuerpo_actor:
	ex af,af'			;8454
	ld a,(ix+000h)		;8455   ; hueco
	ld e,a			;8458
	or a			;8459
	jp z,siguiente_cuerpo		;845a
	cp 018h		;845d   ; 0x18 o mas: no hacen dano
	jp nc,siguiente_cuerpo		;845f
	ld a,(ix+00fh)		;8462   ; sin vida: no
	or a			;8465
	jp z,siguiente_cuerpo		;8466
	ld d,000h		;8469   ; tipo * 4 + p07:8592
	push hl			;846b
	ld hl,08592h		;846c
	add hl,de			;846f
	add hl,de			;8470
	add hl,de			;8471
	add hl,de			;8472
	ld d,(hl)			;8473   ; D = el dano...
	inc hl			;8474
	inc hl			;8475
	ld a,(hl)			;8476   ; ...y la rutina de su caja
	inc hl			;8477
	ld h,(hl)			;8478
	ld l,a			;8479
	ex (sp),hl			;847a
	ret			;847b
caja_cuerpo_a:
	ld a,(ix+006h)		;847c
	sub h			;847f   ; la diferencia en x...
	add a,009h		;8480   ; ...corrida +9...
	cp 013h		;8482   ; ...cabe en la caja si va de -9 a 9
	jp nc,siguiente_cuerpo		;8484   ; no cabe: fuera
	ld a,(ix+007h)		;8487
	sub l			;848a   ; la diferencia en y...
	add a,017h		;848b   ; ...corrida +23...
	cp 02fh		;848d   ; ...cabe en la caja si va de -23 a 23
	jp nc,siguiente_cuerpo		;848f   ; no cabe: fuera
	jp le_toca		;8492
caja_cuerpo_b:
	ld a,(ix+007h)		;8495
	sub l			;8498
	cp 017h		;8499
	jr c,caja_cuerpo_b2		;849b
	cp 0e5h		;849d
	jp c,siguiente_cuerpo		;849f
	ld a,(ix+006h)		;84a2
	sub h			;84a5   ; la diferencia en x...
	add a,009h		;84a6   ; ...corrida +9...
	cp 013h		;84a8   ; ...cabe en la caja si va de -9 a 9
	jp nc,siguiente_cuerpo		;84aa   ; no cabe: fuera
	jp le_toca		;84ad
caja_cuerpo_b2:
	ld a,(ix+006h)		;84b0
	sub h			;84b3   ; la diferencia en x...
	add a,013h		;84b4   ; ...corrida +19...
	cp 027h		;84b6   ; ...cabe en la caja si va de -19 a 19
	jp nc,siguiente_cuerpo		;84b8   ; no cabe: fuera
	jp le_toca		;84bb
caja_cuerpo_c:
	ld a,(ix+007h)		;84be
	sub l			;84c1
	cp 017h		;84c2
	jr c,caja_cuerpo_c2		;84c4
	cp 0e5h		;84c6
	jp c,siguiente_cuerpo		;84c8
	ld a,(ix+006h)		;84cb
	sub h			;84ce   ; la diferencia en x...
	add a,013h		;84cf   ; ...corrida +19...
	cp 027h		;84d1   ; ...cabe en la caja si va de -19 a 19
	jp nc,siguiente_cuerpo		;84d3   ; no cabe: fuera
	jp le_toca		;84d6
caja_cuerpo_c2:
	ld a,(ix+006h)		;84d9
	sub h			;84dc   ; la diferencia en x...
	add a,009h		;84dd   ; ...corrida +9...
	cp 013h		;84df   ; ...cabe en la caja si va de -9 a 9
	jp nc,siguiente_cuerpo		;84e1   ; no cabe: fuera
	jp le_toca		;84e4
caja_cuerpo_d:
	ld a,(ix+006h)		;84e7
	sub h			;84ea   ; la diferencia en x...
	add a,00fh		;84eb   ; ...corrida +15...
	cp 00fh		;84ed   ; ...cabe en la caja si va de -15 a -1
	jp nc,siguiente_cuerpo		;84ef   ; no cabe: fuera
	ld a,(ix+007h)		;84f2
	sub l			;84f5   ; la diferencia en y...
	add a,017h		;84f6   ; ...corrida +23...
	cp 01fh		;84f8   ; ...cabe en la caja si va de -23 a 7
	jp nc,siguiente_cuerpo		;84fa   ; no cabe: fuera
	jp le_toca		;84fd
caja_cuerpo_e:
	ld a,(ix+006h)		;8500
	sub h			;8503   ; la diferencia en x...
	add a,013h		;8504   ; ...corrida +19...
	cp 027h		;8506   ; ...cabe en la caja si va de -19 a 19
	jp nc,siguiente_cuerpo		;8508   ; no cabe: fuera
	ld a,(ix+007h)		;850b
	sub l			;850e   ; la diferencia en y...
	add a,00dh		;850f   ; ...corrida +13...
	cp 01ch		;8511   ; ...cabe en la caja si va de -13 a 14
	jp nc,siguiente_cuerpo		;8513   ; no cabe: fuera
	jp le_toca		;8516
caja_cuerpo_f:
	ld a,(ix+006h)		;8519
	sub h			;851c   ; la diferencia en x...
	add a,002h		;851d   ; ...corrida +2...
	cp 015h		;851f   ; ...cabe en la caja si va de -2 a 18
	jp nc,siguiente_cuerpo		;8521   ; no cabe: fuera
	ld a,(ix+007h)		;8524
	sub l			;8527   ; la diferencia en y...
	add a,007h		;8528   ; ...corrida +7...
	cp 01fh		;852a   ; ...cabe en la caja si va de -7 a 23
	jp nc,siguiente_cuerpo		;852c   ; no cabe: fuera
	jp le_toca		;852f
caja_cuerpo_g:
	ld a,(ix+006h)		;8532
	sub h			;8535   ; la diferencia en x...
	add a,005h		;8536   ; ...corrida +5...
	cp 01bh		;8538   ; ...cabe en la caja si va de -5 a 21
	jp nc,siguiente_cuerpo		;853a   ; no cabe: fuera
	ld a,(ix+007h)		;853d
	sub l			;8540   ; la diferencia en y...
	add a,017h		;8541   ; ...corrida +23...
	cp 02fh		;8543   ; ...cabe en la caja si va de -23 a 23
	jp nc,siguiente_cuerpo		;8545   ; no cabe: fuera
	jp le_toca		;8548
caja_cuerpo_h:
	ld a,(ix+006h)		;854b
	sub h			;854e   ; la diferencia en x...
	add a,013h		;854f   ; ...corrida +19...
	cp 027h		;8551   ; ...cabe en la caja si va de -19 a 19
	jp nc,siguiente_cuerpo		;8553   ; no cabe: fuera
	ld a,(ix+007h)		;8556
	sub l			;8559   ; la diferencia en y...
	add a,009h		;855a   ; ...corrida +9...
	cp 01fh		;855c   ; ...cabe en la caja si va de -9 a 21
	jp nc,siguiente_cuerpo		;855e   ; no cabe: fuera
	jp le_toca		;8561
le_toca:
	ld a,(0d91bh)		;8564   ; lleva escudo?
	or a			;8567
	jr z,suma_dano_cuerpo		;8568
	ld a,(0d926h)		;856a   ; un golpe menos al escudo...
	dec a			;856d
	ld (0d926h),a		;856e   ; los golpes que le quedan al escudo = a
	jr nz,medio_dano_cuerpo		;8571
	ld (0d91bh),a		;8573   ; ...y si se acaba, fuera
	ld a,(0d905h)		;8576   ; a = lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble
	and 0b3h		;8579
	ld (0d905h),a		;857b   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
medio_dano_cuerpo:
	srl d		;857e
suma_dano_cuerpo:
	ld a,d			;8580
	add a,c			;8581
	ld c,a			;8582
siguiente_cuerpo:
	ld de,00026h		;8583
	add ix,de		;8586
	ex af,af'			;8588
	dec a			;8589
	jp nz,cuerpo_actor		;858a
	or c			;858d   ; sin dano: nada
	ret z			;858e
	ld d,c			;858f   ; todo junto a la vida
	push hl			;8590
	call 07818h		;8591   ; p06 dano
	pop hl			;8594
	ret			;8595

; ----------------------------------------------------------------------
; DATOS cuerpo_por_tipo: Por cada tipo de actor (1-23): el dano de tocarlo, un
;   byte a 0 y la rutina de su caja (p07:847A)
;   0x8596..0x85f2  (92 bytes)
DATA_cuerpo_por_tipo:
	defb 004h,000h,07ch,084h	; 8596
	defb 008h,000h,095h,084h	; 859a
	defb 008h,000h,0beh,084h	; 859e
	defb 004h,000h,095h,084h	; 85a2
	defb 004h,000h,095h,084h	; 85a6
	defb 008h,000h,07ch,084h	; 85aa
	defb 008h,000h,095h,084h	; 85ae
	defb 002h,000h,0e7h,084h	; 85b2
	defb 008h,000h,000h,085h	; 85b6
	defb 004h,000h,04bh,085h	; 85ba
	defb 004h,000h,019h,085h	; 85be
	defb 004h,000h,019h,085h	; 85c2
	defb 008h,000h,000h,085h	; 85c6
	defb 008h,000h,032h,085h	; 85ca
	defb 008h,000h,04bh,085h	; 85ce
	defb 008h,000h,032h,085h	; 85d2
	defb 008h,000h,07ch,084h	; 85d6
	defb 008h,000h,07ch,084h	; 85da
	defb 008h,000h,07ch,084h	; 85de
	defb 008h,000h,0beh,084h	; 85e2
	defb 00ch,000h,0beh,084h	; 85e6
	defb 002h,000h,0e7h,084h	; 85ea
	defb 010h,000h,0e7h,084h	; 85ee

; ----------------------------------------------------------------------
; DATOS cuerpo_tipo_24: la entrada del tipo 24, que no se usa
;   0x85f2..0x85f6  (4 bytes)
DATA_cuerpo_tipo_24:
	defb 002h,000h,0e7h,084h	; 85f2

; ======================================================================
; CODIGO 0x85f6..0x864c  (86 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; La salida de la fase: si debajo de los pies de Rastan hay casillas de la
; clase 0xB0, D910 bit 0 (p00:5303 pasa a la fase siguiente).
; ----------------------------------------------------------------------
mira_salida:
	push hl			;85f6
	ld e,h			;85f7   ; E = x
	ld a,l			;85f8   ; (x + 5, y + 0x18): los pies
	add a,018h		;85f9
	ld l,a			;85fb
	ld a,h			;85fc
	add a,005h		;85fd
	ld h,a			;85ff
	push de			;8600
	call clase_en		;8601   ; la clase de la casilla
	pop de			;8604
	cp 0b0h		;8605   ; 0xB0?
	jr nz,no_salida		;8607
	inc hl			;8609   ; y la de al lado
	inc hl			;860a
	ld a,(hl)			;860b
	and 0f0h		;860c
	cp 0b0h		;860e
	jr nz,no_salida		;8610
	ld a,e			;8612   ; cerca del borde de la casilla, tambien la tercera
	sub 006h		;8613
	and 00fh		;8615
	cp 005h		;8617
	jr nc,en_la_salida		;8619
	inc hl			;861b
	inc hl			;861c
	ld a,(hl)			;861d
	and 0f0h		;861e
	cp 0b0h		;8620
	jr nz,no_salida		;8622
en_la_salida:
	ld hl,0d910h		;8624   ; D910 bit 0: fase acabada
	set 0,(hl)		;8627
	pop hl			;8629
	ret			;862a
no_salida:
	ld hl,0d910h		;862b   ; D910 bit 0 a 0
	res 0,(hl)		;862e
	pop hl			;8630
	ret			;8631

; ----------------------------------------------------------------------
; Un enemigo de DA20 contra Rastan: los tipos 0x17-0x24 tienen su rutina
; en la tabla de p07:864C.
; ----------------------------------------------------------------------
choque_enemigo:
	ld a,(ix+000h)		;8632   ; tipo 0x17...
	cp 017h		;8635
	ret c			;8637
	cp 025h		;8638   ; ...a 0x24
	ret nc			;863a
	sub 017h		;863b
	push hl			;863d
	add a,a			;863e   ; * 2 + p07:864C
	ld l,a			;863f
	ld h,000h		;8640
	ld de,0864ch		;8642
	add hl,de			;8645
	ld e,(hl)			;8646
	inc hl			;8647
	ld d,(hl)			;8648
	ex de,hl			;8649
	ex (sp),hl			;864a   ; a su rutina
	ret			;864b

; ----------------------------------------------------------------------
; DATOS choque_por_tipo: La rutina de choque de los tipos 0x17-0x24 de DA20
;   (14 palabras)
;   0x864c..0x8668  (28 bytes)
DATA_choque_por_tipo:
	defw 0883dh,0893eh,08668h,0876eh,0878bh,087a8h,087f1h	; 864c
	defw 0883dh,0883dh,08856h,08873h,08892h,08873h,08891h	; 865a

; ======================================================================
; CODIGO 0x8668..0x8855  (493 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Tipo 0x19: algo que gira (+2 = el giro, 0-17) y de cuatro formas (+1);
; solo hace dano en ciertos giros (de 2 en adelante): 0x10 en la primera
; mitad de la vuelta y 8 en la segunda.
; ----------------------------------------------------------------------
choque_tipo_19:
	ld a,(ix+001h)		;8668   ; la forma: 0, 1 o 2-3
	cp 001h		;866b
	jp c,giro_forma_0		;866d
	jp z,giro_forma_1		;8670
	cp 003h		;8673
	jp c,giro_forma_2		;8675
	jp z,giro_forma_2		;8678
	jp giro_forma_2		;867b
giro_forma_0:
	ld a,(ix+002h)		;867e   ; giros 9-17 son los 0-8 al reves
	cp 009h		;8681
	jr c,giro_forma_0_b		;8683
	sub 009h		;8685
	neg		;8687
	add a,007h		;8689
giro_forma_0_b:
	cp 002h		;868b   ; giros 0-1: nada
	ret c			;868d
	cp 005h		;868e   ; de 5 en adelante: p07:86A8
	jr nc,giro_forma_0_c		;8690
	dec a			;8692   ; una caja que crece 4 pixeles por giro
	add a,a			;8693
	add a,a			;8694
	add a,(ix+006h)		;8695
	sub h			;8698   ; la diferencia en x...
	sub 008h		;8699   ; ...corrida -8...
	cp 020h		;869b   ; ...cabe en la caja si va de 8 a 39
	ret nc			;869d   ; no cabe: fuera
	ld a,(ix+007h)		;869e
	add a,006h		;86a1
	cp 01ch		;86a3
	ret nc			;86a5
	jr dano_giro		;86a6
giro_forma_0_c:
	dec a			;86a8
	add a,a			;86a9
	add a,a			;86aa
	add a,(ix+006h)		;86ab
	sub h			;86ae   ; la diferencia en x...
	sub 008h		;86af   ; ...corrida -8...
	cp 030h		;86b1   ; ...cabe en la caja si va de 8 a 55
	ret nc			;86b3   ; no cabe: fuera
	ld a,(ix+007h)		;86b4
	sub l			;86b7   ; la diferencia en y...
	add a,006h		;86b8   ; ...corrida +6...
	cp 01ch		;86ba   ; ...cabe en la caja si va de -6 a 21
	ret nc			;86bc   ; no cabe: fuera
dano_giro:
	ld d,010h		;86bd   ; dano 0x10...
	ld a,(ix+002h)		;86bf   ; ...en la primera mitad
	cp 009h		;86c2
	jp c,07818h		;86c4   ; p06 dano
	ld d,008h		;86c7   ; dano 8 en la segunda
	jp 07818h		;86c9   ; p06 dano
giro_forma_1:
	ld a,(ix+002h)		;86cc   ; el giro
	cp 009h		;86cf   ; 9 o mas?
	jr c,giro_forma_1_b		;86d1   ; no: tal cual
	sub 009h		;86d3   ; si: el espejo...
	neg		;86d5   ; ...negado...
	add a,007h		;86d7   ; ...+ 7
giro_forma_1_b:
	cp 002h		;86d9
	ret c			;86db
	cp 005h		;86dc
	jr nc,giro_forma_1_c		;86de
	dec a			;86e0
	neg		;86e1
	add a,a			;86e3
	add a,a			;86e4
	add a,020h		;86e5
	add a,(ix+006h)		;86e7
	sub h			;86ea   ; la diferencia en x...
	add a,008h		;86eb   ; ...corrida +8...
	cp 020h		;86ed   ; ...cabe en la caja si va de -8 a 23
	ret nc			;86ef   ; no cabe: fuera
	ld a,(ix+007h)		;86f0
	add a,006h		;86f3
	cp 01ch		;86f5
	ret nc			;86f7
	jr dano_giro_1		;86f8
giro_forma_1_c:
	dec a			;86fa
	neg		;86fb
	add a,a			;86fd
	add a,a			;86fe
	add a,020h		;86ff
	add a,(ix+006h)		;8701
	sub h			;8704   ; la diferencia en x...
	add a,008h		;8705   ; ...corrida +8...
	cp 030h		;8707   ; ...cabe en la caja si va de -8 a 39
	ret nc			;8709   ; no cabe: fuera
	ld a,(ix+007h)		;870a
	sub l			;870d   ; la diferencia en y...
	add a,006h		;870e   ; ...corrida +6...
	cp 01ch		;8710   ; ...cabe en la caja si va de -6 a 21
	ret nc			;8712   ; no cabe: fuera
dano_giro_1:
	ld d,010h		;8713
	ld a,(ix+002h)		;8715
	cp 009h		;8718
	jp c,07818h		;871a   ; p06 dano
	ld d,008h		;871d
	jp 07818h		;871f   ; p06 dano
giro_forma_2:
	ld a,(ix+002h)		;8722   ; el giro
	cp 009h		;8725   ; 9 o mas?
	jr c,giro_forma_2_b		;8727   ; no: tal cual
	sub 009h		;8729   ; si: el espejo...
	neg		;872b   ; ...negado...
	add a,007h		;872d   ; ...+ 7
giro_forma_2_b:
	cp 002h		;872f
	ret c			;8731
	cp 005h		;8732
	jr nc,giro_forma_2_c		;8734
	dec a			;8736
	neg		;8737
	add a,a			;8739
	add a,a			;873a
	add a,020h		;873b
	add a,(ix+007h)		;873d
	sub l			;8740   ; la diferencia en y...
	add a,00ah		;8741   ; ...corrida +10...
	cp 024h		;8743   ; ...cabe en la caja si va de -10 a 25
	ret nc			;8745   ; no cabe: fuera
	ld a,(ix+006h)		;8746
	sub h			;8749   ; la diferencia en x...
	add a,00ch		;874a   ; ...corrida +12...
	cp 018h		;874c   ; ...cabe en la caja si va de -12 a 11
	ret nc			;874e   ; no cabe: fuera
	jp dano_giro		;874f
giro_forma_2_c:
	dec a			;8752
	neg		;8753
	add a,a			;8755
	add a,a			;8756
	add a,020h		;8757
	add a,(ix+007h)		;8759
	sub l			;875c   ; la diferencia en y...
	add a,00ah		;875d   ; ...corrida +10...
	cp 024h		;875f   ; ...cabe en la caja si va de -10 a 25
	ret nc			;8761   ; no cabe: fuera
	ld a,(ix+006h)		;8762
	sub h			;8765   ; la diferencia en x...
	add a,00ch		;8766   ; ...corrida +12...
	cp 018h		;8768   ; ...cabe en la caja si va de -12 a 11
	ret nc			;876a   ; no cabe: fuera
	jp dano_giro		;876b
choque_tipo_1a:
	ld a,(ix+001h)		;876e   ; tipo 0x1A: solo con la pose 0...
	or a			;8771
	ret nz			;8772
	ld a,(ix+006h)		;8773   ; ...y dentro de su caja...
	sub h			;8776   ; la diferencia en x...
	add a,005h		;8777   ; ...corrida +5...
	cp 01bh		;8779   ; ...cabe en la caja si va de -5 a 21
	ret nc			;877b   ; no cabe: fuera
	ld a,(ix+007h)		;877c
	sub l			;877f   ; la diferencia en y...
	add a,006h		;8780   ; ...corrida +6...
	cp 020h		;8782   ; ...cabe en la caja si va de -6 a 25
	ret nc			;8784   ; no cabe: fuera
	ld d,008h		;8785   ; ...8 de dano
	call 07818h		;8787   ; p06 dano
	ret			;878a
choque_tipo_1b:
	ld a,(ix+001h)		;878b   ; tipo 0x1B: igual con otra caja
	or a			;878e
	ret nz			;878f
	ld a,(ix+006h)		;8790
	sub h			;8793   ; la diferencia en x...
	add a,007h		;8794   ; ...corrida +7...
	cp 017h		;8796   ; ...cabe en la caja si va de -7 a 15
	ret nc			;8798   ; no cabe: fuera
	ld a,(ix+007h)		;8799
	sub l			;879c   ; la diferencia en y...
	add a,006h		;879d   ; ...corrida +6...
	cp 020h		;879f   ; ...cabe en la caja si va de -6 a 25
	ret nc			;87a1   ; no cabe: fuera
	ld d,008h		;87a2
	call 07818h		;87a4   ; p06 dano
	ret			;87a7

; ----------------------------------------------------------------------
; Tipo 0x1C: otro que gira (+2, 16 giros en ida y vuelta); la caja baja 4
; pixeles por giro; dano 0x10 o 8 segun la mitad de la vuelta (0x0E de mas
; de alto si Rastan esta agachado).
; ----------------------------------------------------------------------
choque_tipo_1c:
	ld d,000h		;87a8   ; D = 0 de pie...
	ld a,(0d904h)		;87aa   ; a = la pose de Rastan
	and 01eh		;87ad
	cp 004h		;87af
	jr nz,giro_1c		;87b1
	ld d,00eh		;87b3   ; ...0x0E agachado
giro_1c:
	ld a,(ix+002h)		;87b5   ; el giro (0x0F cuenta como 0)
	and 00fh		;87b8
	cp 00fh		;87ba
	jr nz,giro_1c_b		;87bc
	xor a			;87be
giro_1c_b:
	cp 008h		;87bf   ; de 8 en adelante, al reves
	jr c,caja_1c		;87c1
	sub 008h		;87c3
	cp 008h		;87c5
	jr nc,giro_1c		;87c7
	neg		;87c9
	add a,006h		;87cb
caja_1c:
	add a,a			;87cd   ; 4 pixeles por giro
	add a,a			;87ce
	add a,(ix+007h)		;87cf
	sub l			;87d2
	sub d			;87d3
	add a,012h		;87d4
	cp 021h		;87d6   ; fuera en y: nada
	ret nc			;87d8
	ld a,(ix+006h)		;87d9   ; fuera en x: nada
	sub h			;87dc   ; la diferencia en x...
	add a,013h		;87dd   ; ...corrida +19...
	cp 028h		;87df   ; ...cabe en la caja si va de -19 a 20
	ret nc			;87e1   ; no cabe: fuera
	ld d,010h		;87e2   ; dano 0x10 o 8
	ld a,(ix+002h)		;87e4
	cp 008h		;87e7
	jp c,07818h		;87e9   ; p06 dano
	ld d,008h		;87ec
	jp 07818h		;87ee   ; p06 dano

; ----------------------------------------------------------------------
; Tipo 0x1D: como el 0x19 con la caja en vertical.
; ----------------------------------------------------------------------
choque_tipo_1d:
	ld a,(ix+002h)		;87f1   ; giros 9-17, al reves
	cp 009h		;87f4
	jr c,giro_1d		;87f6
	sub 009h		;87f8
	neg		;87fa
	add a,007h		;87fc
giro_1d:
	cp 002h		;87fe   ; 0-1: nada
	ret c			;8800
	cp 005h		;8801
	jr nc,giro_1d_b		;8803
	dec a			;8805
	neg		;8806
	add a,a			;8808
	add a,a			;8809
	add a,020h		;880a
	add a,(ix+007h)		;880c
	sub l			;880f   ; la diferencia en y...
	add a,00ah		;8810   ; ...corrida +10...
	cp 024h		;8812   ; ...cabe en la caja si va de -10 a 25
	ret nc			;8814   ; no cabe: fuera
	ld a,(ix+006h)		;8815
	sub h			;8818   ; la diferencia en x...
	add a,013h		;8819   ; ...corrida +19...
	cp 027h		;881b   ; ...cabe en la caja si va de -19 a 19
	ret nc			;881d   ; no cabe: fuera
	jp dano_giro		;881e
giro_1d_b:
	dec a			;8821
	neg		;8822
	add a,a			;8824
	add a,a			;8825
	add a,020h		;8826
	add a,(ix+007h)		;8828
	sub l			;882b   ; la diferencia en y...
	add a,00ah		;882c   ; ...corrida +10...
	cp 024h		;882e   ; ...cabe en la caja si va de -10 a 25
	ret nc			;8830   ; no cabe: fuera
	ld a,(ix+006h)		;8831
	sub h			;8834   ; la diferencia en x...
	add a,013h		;8835   ; ...corrida +19...
	cp 027h		;8837   ; ...cabe en la caja si va de -19 a 19
	ret nc			;8839   ; no cabe: fuera
	jp dano_giro		;883a

; ----------------------------------------------------------------------
; Tipos 0x17, 0x1E y 0x1F: tocarlos quita 8.
; ----------------------------------------------------------------------
choque_contacto:
	ld a,(ix+006h)		;883d   ; dentro de la caja...
	sub h			;8840   ; la diferencia en x...
	add a,00ah		;8841   ; ...corrida +10...
	cp 015h		;8843   ; ...cabe en la caja si va de -10 a 10
	ret nc			;8845   ; no cabe: fuera
	ld a,(ix+007h)		;8846
	sub l			;8849   ; la diferencia en y...
	add a,006h		;884a   ; ...corrida +6...
	cp 01bh		;884c   ; ...cabe en la caja si va de -6 a 20
	ret nc			;884e   ; no cabe: fuera
	ld d,008h		;884f   ; ...8 de dano
	call 07818h		;8851   ; p06 dano
	ret			;8854

; ----------------------------------------------------------------------
; DATOS resto_8855: un `ret` que nadie ejecuta
;   0x8855..0x8856  (1 bytes)
DATA_resto_8855:
	defb 0c9h	; 8855

; ======================================================================
; CODIGO 0x8856..0x8c13  (957 bytes)
; ======================================================================


choque_tipo_20:
	ld a,(ix+001h)		;8856   ; tipo 0x20: solo con la pose 0, caja 0x1B x 0x23, dano 8
	or a			;8859
	ret nz			;885a
	ld a,(ix+006h)		;885b
	sub h			;885e   ; la diferencia en x...
	add a,005h		;885f   ; ...corrida +5...
	cp 01bh		;8861   ; ...cabe en la caja si va de -5 a 21
	ret nc			;8863   ; no cabe: fuera
	ld a,(ix+007h)		;8864
	sub l			;8867   ; la diferencia en y...
	add a,009h		;8868   ; ...corrida +9...
	cp 023h		;886a   ; ...cabe en la caja si va de -9 a 25
	ret nc			;886c   ; no cabe: fuera
	ld d,008h		;886d
	call 07818h		;886f   ; p06 dano
	ret			;8872
choque_tipo_21:
	ld a,(ix+001h)		;8873   ; tipos 0x21 y 0x23: solo con la pose 1, una caja alta (0x3E), dano 8
	cp 001h		;8876
	ret nz			;8878
	ld a,(ix+006h)		;8879
	sub h			;887c   ; la diferencia en x...
	add a,00ch		;887d   ; ...corrida +12...
	cp 019h		;887f   ; ...cabe en la caja si va de -12 a 12
	ret nc			;8881   ; no cabe: fuera
	ld a,(ix+007h)		;8882
	sub l			;8885   ; la diferencia en y...
	add a,028h		;8886   ; ...corrida +40...
	cp 03eh		;8888   ; ...cabe en la caja si va de -40 a 21
	ret nc			;888a   ; no cabe: fuera
	ld d,008h		;888b
	call 07818h		;888d   ; p06 dano
	ret			;8890
choque_tipo_24:
	ret			;8891   ; tipo 0x24: nada

; ----------------------------------------------------------------------
; Tipo 0x22: una plataforma que sube y baja con su giro (+2). Si Rastan
; cae encima, se queda sobre ella (D90F bit 2, D914 = la plataforma) y su y
; la sigue; si se sale por los lados, cae.
; ----------------------------------------------------------------------
plataforma:
	ld a,(0d90fh)		;8892   ; ya esta encima: p07:88F0
	bit 2,a		;8895
	jp nz,sobre_plataforma		;8897
	ld a,(0d90dh)		;889a   ; bajando de un salto...
	bit 1,a		;889d
	jr nz,plataforma_altura		;889f
	bit 7,a		;88a1   ; ...o cayendo: puede subirse
	ret z			;88a3
	bit 6,a		;88a4
	ret z			;88a6
plataforma_altura:
	ld a,(ix+007h)		;88a7   ; E = y de la plataforma
	ld e,a			;88aa
	ld a,(ix+002h)		;88ab   ; su giro + 1: de 0x10 en adelante, nada
	inc a			;88ae
	cp 010h		;88af
	ret nc			;88b1
	cp 009h		;88b2   ; de 9 en adelante, al reves
	jr c,plataforma_y		;88b4
	sub 009h		;88b6
	neg		;88b8
	add a,007h		;88ba
plataforma_y:
	neg		;88bc   ; la altura: y + (8 - giro) * 4 - 0x20
	add a,008h		;88be
	add a,a			;88c0
	add a,a			;88c1
	add a,e			;88c2
	sub 020h		;88c3
	ld e,a			;88c5
	sub l			;88c6   ; los pies de Rastan a menos de 3 pixeles?
	add a,003h		;88c7   ; ...corrida +3...
	cp 006h		;88c9   ; ...cabe en la caja si va de -3 a 2
	ret nc			;88cb   ; no cabe: fuera
	ld a,(ix+006h)		;88cc   ; y dentro en x?
	sub h			;88cf   ; la diferencia en x...
	add a,017h		;88d0   ; ...corrida +23...
	cp 02eh		;88d2   ; ...cabe en la caja si va de -23 a 22
	ret nc			;88d4   ; no cabe: fuera
	ld l,e			;88d5   ; se sube: y = la de la plataforma
	ld a,l			;88d6
	ld (0d8fdh),a		;88d7   ; la y de Rastan = a
	ld (0d914h),ix		;88da   ; D914 = la plataforma
	push hl			;88de
	ld hl,0d90fh		;88df   ; D90F bit 2: encima
	set 2,(hl)		;88e2
	ld hl,0d90dh		;88e4   ; D90D = 0: de pie
	ld (hl),000h		;88e7
	ld hl,0d90fh		;88e9   ; D90F bit 0 a 0
	res 0,(hl)		;88ec
	pop hl			;88ee
	ret			;88ef
sobre_plataforma:
	ld de,(0d914h)		;88f0   ; es esta plataforma?
	and a			;88f4
	push hl			;88f5
	push ix		;88f6
	pop hl			;88f8
	sbc hl,de		;88f9
	pop hl			;88fb
	ret nz			;88fc
	ld a,(ix+007h)		;88fd   ; la altura de ahora...
	ld e,a			;8900
	ld a,(ix+002h)		;8901
	inc a			;8904   ; ...giro + 1, fuera de 0x10: se cae
	cp 010h		;8905
	jp nc,cae_de_plataforma		;8907
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
	ld a,(ix+006h)		;891e   ; fuera en x: se cae
	sub h			;8921   ; la diferencia en x...
	add a,017h		;8922   ; ...corrida +23...
	cp 02eh		;8924   ; ...cabe en la caja si va de -23 a 22
	jp nc,cae_de_plataforma		;8926   ; no cabe: fuera
	ld l,e			;8929   ; la y de Rastan sigue a la plataforma
	ld a,l			;892a
	ld (0d8fdh),a		;892b   ; la y de Rastan = a
	ret			;892e
cae_de_plataforma:
	push hl			;892f
	ld hl,0d90fh		;8930   ; ya no esta encima
	res 2,(hl)		;8933
	ld hl,0d90dh		;8935   ; D90D bits 7 y 1: cayendo
	set 7,(hl)		;8938
	set 1,(hl)		;893a
	pop hl			;893c
	ret			;893d

; ----------------------------------------------------------------------
; Tipo 0x18: algo que gira y a lo que Rastan se agarra (D90F bit 3, D914).
; Su x sale de la tabla de su forma (+1) en el banco 7, como en p06:6B1B.
; ----------------------------------------------------------------------
agarradero:
	ld a,(0d90fh)		;893e   ; ya agarrado: nada
	bit 3,a		;8941
	ret nz			;8943
	ld de,(0d914h)		;8944   ; es al que esta agarrado: nada
	and a			;8948
	push hl			;8949
	push ix		;894a
	pop hl			;894c
	sbc hl,de		;894d
	pop hl			;894f
	ret z			;8950
	ld a,(ix+002h)		;8951   ; el giro: 10-19 son 0-9 al reves
	and 07fh		;8954
	cp 00ah		;8956
	jr c,agarradero_giro		;8958
	sub 00ah		;895a
	neg		;895c
	add a,008h		;895e
agarradero_giro:
	ld c,a			;8960   ; C = giro
	ld a,(ix+001h)		;8961   ; la forma: 0, 1, 2 o 3
	cp 001h		;8964
	jp c,agarradero_forma_0		;8966
	jp z,agarradero_forma_1		;8969
	cp 002h		;896c
	jp z,agarradero_forma_2		;896e
	ld a,l			;8971   ; forma 3: B = distancia en y...
	sub (ix+007h)		;8972
	ld b,a			;8975
	sub 004h		;8976   ; ...de 4 a 0x1C
	cp 018h		;8978
	ret nc			;897a
	ld a,c			;897b   ; giro * 8...
	add a,a			;897c
	add a,a			;897d
	add a,a			;897e
	push hl			;897f
	ld l,a			;8980
	ld h,000h		;8981
	ld de,090ech		;8983   ; ...en p07:90EC...
	add hl,de			;8986
	ld e,b			;8987   ; ...+ distancia / 2
	srl e		;8988
	ld d,000h		;898a
	add hl,de			;898c
	ld a,(hl)			;898d   ; la x relativa + x del actor - 16
	add a,(ix+006h)		;898e
	sub 010h		;8991
	ld e,a			;8993
	pop hl			;8994
	sub h			;8995   ; Rastan a menos de 4 pixeles?
	add a,004h		;8996   ; ...corrida +4...
	cp 009h		;8998   ; ...cabe en la caja si va de -4 a 4
	ret nc			;899a   ; no cabe: fuera
	ld a,(0d90fh)		;899b   ; se agarra (D90F bit 3)...
	set 3,a		;899e
	ld (0d90fh),a		;89a0   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,e			;89a3   ; ...en esa x...
	ld (0d8fch),a		;89a4   ; la x de Rastan = a
	ld (0d914h),ix		;89a7   ; ...D914 = el agarradero
	ld a,(0d90fh)		;89ab   ; D90F bit 0 a 0
	res 0,a		;89ae
	ld (0d90fh),a		;89b0   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(ix+002h)		;89b3   ; D916 = el giro
	and 07fh		;89b6
	ld (0d916h),a		;89b8   ; el giro del actor al que esta agarrado = a
	cp 001h		;89bb   ; la y de agarre segun el giro:
	jr c,agarre_y_b		;89bd
	jr z,agarre_y_a		;89bf
	cp 003h		;89c1
	jr c,agarre_y_c		;89c3
	jr z,agarre_y_d		;89c5
	cp 006h		;89c7
	jr z,agarre_y_d		;89c9
	cp 007h		;89cb
	jr c,guarda_agarre		;89cd
	jr z,agarre_y_c		;89cf
	cp 009h		;89d1
	jr c,agarre_y_a		;89d3
	jr z,agarre_y_b		;89d5
	cp 00bh		;89d7
	jr c,agarre_y_a		;89d9
	jr z,agarre_y_c		;89db
	cp 00ch		;89dd
	jr z,agarre_y_d		;89df
	cp 00eh		;89e1
	jr z,agarre_y_d		;89e3
	cp 010h		;89e5
	jr c,guarda_agarre		;89e7
	jr z,agarre_y_c		;89e9
agarre_y_a:
	ld a,l			;89eb   ; un pixel mas abajo por cada umbral
	sub (ix+007h)		;89ec   ; L - y del agarradero
	cp 005h		;89ef   ; menos de 5?
	jr c,guarda_agarre		;89f1
	inc l			;89f3   ; no: un pixel mas abajo
	cp 00dh		;89f4   ; menos de 0x0D?
	jr c,guarda_agarre		;89f6
	inc l			;89f8   ; uno mas
	cp 016h		;89f9   ; menos de 0x16?
	jr c,guarda_agarre		;89fb
	inc l			;89fd   ; uno mas
	jr guarda_agarre		;89fe
agarre_y_b:
	ld a,l			;8a00
	sub (ix+007h)		;8a01   ; L - y del agarradero
	cp 003h		;8a04   ; menos de 0x03?
	jr c,guarda_agarre		;8a06   ; si: esa y
	inc l			;8a08   ; no: un pixel mas abajo
	cp 008h		;8a09   ; menos de 0x08?
	jr c,guarda_agarre		;8a0b   ; si: esa y
	inc l			;8a0d   ; no: un pixel mas abajo
	cp 00dh		;8a0e   ; menos de 0x0D?
	jr c,guarda_agarre		;8a10   ; si: esa y
	inc l			;8a12   ; no: un pixel mas abajo
	cp 013h		;8a13   ; menos de 0x13?
	jr c,guarda_agarre		;8a15   ; si: esa y
	inc l			;8a17   ; no: un pixel mas abajo
	jr guarda_agarre		;8a18
agarre_y_c:
	ld a,l			;8a1a
	sub (ix+007h)		;8a1b   ; L - y del agarradero
	cp 009h		;8a1e   ; menos de 0x09?
	jr c,guarda_agarre		;8a20   ; si: esa y
	inc l			;8a22   ; no: un pixel mas abajo
	jr guarda_agarre		;8a23
agarre_y_d:
	ld a,l			;8a25
	sub (ix+007h)		;8a26
	cp 017h		;8a29
	jr c,guarda_agarre		;8a2b
	inc l			;8a2d
guarda_agarre:
	ld a,l			;8a2e   ; D917 = la y de agarre
	ld (0d917h),a		;8a2f   ; la y de agarre = a
	ret			;8a32
agarradero_forma_2:
	ld a,l			;8a33   ; forma 2: distancia en y de 4 a 0x2C
	sub (ix+007h)		;8a34
	ld b,a			;8a37
	sub 004h		;8a38
	cp 028h		;8a3a
	ret nc			;8a3c
	ld a,c			;8a3d   ; giro * 24...
	add a,a			;8a3e
	add a,c			;8a3f
	add a,a			;8a40
	add a,a			;8a41
	add a,a			;8a42
	push hl			;8a43
	ld l,a			;8a44
	ld h,000h		;8a45
	ld de,08ffch		;8a47   ; ...en p07:8FFC
	add hl,de			;8a4a
	ld e,b			;8a4b
	srl e		;8a4c
	ld d,000h		;8a4e
	add hl,de			;8a50
	ld a,(hl)			;8a51   ; la x
	add a,(ix+006h)		;8a52
	sub 010h		;8a55
	ld e,a			;8a57
	pop hl			;8a58
	sub h			;8a59   ; a menos de 4?
	add a,004h		;8a5a   ; ...corrida +4...
	cp 009h		;8a5c   ; ...cabe en la caja si va de -4 a 4
	ret nc			;8a5e   ; no cabe: fuera
	ld a,(0d90fh)		;8a5f   ; se agarra
	set 3,a		;8a62
	ld (0d90fh),a		;8a64   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,e			;8a67
	ld (0d8fch),a		;8a68   ; la x de Rastan = a
	ld (0d914h),ix		;8a6b   ; D914
	ld a,(0d90fh)		;8a6f   ; a = bit 7 muerto, bit 4 un rato sin mandos
	res 0,a		;8a72
	ld (0d90fh),a		;8a74   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(ix+002h)		;8a77   ; D916 = el giro
	and 07fh		;8a7a
	ld (0d916h),a		;8a7c   ; el giro del actor al que esta agarrado = a
	cp 001h		;8a7f
	jr c,agarre2_y_b		;8a81
	jr z,agarre2_y_a		;8a83
	cp 003h		;8a85
	jr c,agarre2_y_c		;8a87
	cp 007h		;8a89
	jr c,guarda_agarre_2		;8a8b
	jr z,agarre2_y_c		;8a8d
	cp 009h		;8a8f
	jr c,agarre2_y_a		;8a91
	jr z,agarre2_y_b		;8a93
	cp 00bh		;8a95
	jr c,agarre2_y_a		;8a97
	jr z,agarre2_y_c		;8a99
	cp 010h		;8a9b
	jr c,guarda_agarre_2		;8a9d
	jr z,agarre2_y_c		;8a9f
agarre2_y_a:
	ld a,l			;8aa1
	sub (ix+007h)		;8aa2   ; L - y del agarradero
	cp 00fh		;8aa5   ; menos de 0x0F?
	jr c,guarda_agarre_2		;8aa7   ; si: esa y
	inc l			;8aa9   ; no: un pixel mas abajo
	jr guarda_agarre_2		;8aaa
agarre2_y_b:
	ld a,l			;8aac
	sub (ix+007h)		;8aad   ; L - y del agarradero
	cp 009h		;8ab0   ; menos de 0x09?
	jr c,guarda_agarre_2		;8ab2   ; si: esa y
	inc l			;8ab4   ; no: un pixel mas abajo
	cp 01ch		;8ab5   ; menos de 0x1C?
	jr c,guarda_agarre_2		;8ab7   ; si: esa y
	inc l			;8ab9   ; no: un pixel mas abajo
	jr guarda_agarre_2		;8aba
agarre2_y_c:
	ld a,l			;8abc
	sub (ix+007h)		;8abd
	cp 01eh		;8ac0
	jr c,guarda_agarre_2		;8ac2
	inc l			;8ac4
guarda_agarre_2:
	ld a,l			;8ac5   ; D917
	ld (0d917h),a		;8ac6   ; la y de agarre = a
	ret			;8ac9
agarradero_forma_1:
	ld a,l			;8aca   ; forma 1: distancia en y de 4 a 0x3C
	sub (ix+007h)		;8acb
	ld b,a			;8ace
	sub 004h		;8acf
	cp 038h		;8ad1
	ret nc			;8ad3
	ld a,c			;8ad4   ; giro * 32...
	add a,a			;8ad5
	add a,a			;8ad6
	add a,a			;8ad7
	add a,a			;8ad8
	push hl			;8ad9
	ld l,a			;8ada
	ld h,000h		;8adb
	add hl,hl			;8add
	ld de,08ebch		;8ade   ; ...en p07:8EBC
	add hl,de			;8ae1
	ld e,b			;8ae2
	srl e		;8ae3
	ld d,000h		;8ae5
	add hl,de			;8ae7
	ld a,(hl)			;8ae8   ; la x
	add a,(ix+006h)		;8ae9
	sub 010h		;8aec
	ld e,a			;8aee
	pop hl			;8aef
	sub h			;8af0   ; a menos de 4?
	add a,004h		;8af1   ; ...corrida +4...
	cp 009h		;8af3   ; ...cabe en la caja si va de -4 a 4
	ret nc			;8af5   ; no cabe: fuera
	ld a,(0d90fh)		;8af6   ; se agarra
	set 3,a		;8af9
	ld (0d90fh),a		;8afb   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,e			;8afe
	ld (0d8fch),a		;8aff   ; la x de Rastan = a
	ld (0d914h),ix		;8b02   ; D914
	ld a,(0d90fh)		;8b06   ; a = bit 7 muerto, bit 4 un rato sin mandos
	res 0,a		;8b09
	ld (0d90fh),a		;8b0b   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(ix+002h)		;8b0e   ; D916 = el giro
	and 07fh		;8b11
	ld (0d916h),a		;8b13   ; el giro del actor al que esta agarrado = a
	cp 001h		;8b16
	jr c,agarre1_y_b		;8b18
	jr z,agarre1_y_a		;8b1a
	cp 008h		;8b1c
	jr c,guarda_agarre_1		;8b1e
	jr z,agarre1_y_a		;8b20
	cp 00ah		;8b22
	jr c,agarre1_y_b		;8b24
	jr z,agarre1_y_a		;8b26
	cp 011h		;8b28
	jr c,guarda_agarre_1		;8b2a
agarre1_y_a:
	ld a,l			;8b2c
	sub (ix+007h)		;8b2d   ; L - y del agarradero
	cp 01bh		;8b30   ; menos de 0x1B?
	jr c,guarda_agarre_1		;8b32   ; si: esa y
	inc l			;8b34   ; no: un pixel mas abajo
	jr guarda_agarre_1		;8b35
agarre1_y_b:
	ld a,l			;8b37
	sub (ix+007h)		;8b38   ; L - y del agarradero
	cp 011h		;8b3b   ; menos de 0x11?
	jr c,guarda_agarre_1		;8b3d   ; si: esa y
	inc l			;8b3f   ; no: un pixel mas abajo
	cp 02fh		;8b40   ; menos de 0x2F?
	jr c,guarda_agarre_1		;8b42   ; si: esa y
	inc l			;8b44   ; no: un pixel mas abajo
guarda_agarre_1:
	ld a,l			;8b45   ; D917
	ld (0d917h),a		;8b46   ; la y de agarre = a
	ret			;8b49
agarradero_forma_0:
	ld a,l			;8b4a   ; forma 0: distancia en y de 4 a 0x4C
	sub (ix+007h)		;8b4b
	ld b,a			;8b4e
	sub 004h		;8b4f
	cp 048h		;8b51
	ret nc			;8b53
	ld a,c			;8b54   ; giro * 40...
	add a,a			;8b55
	add a,a			;8b56
	add a,c			;8b57
	add a,a			;8b58
	add a,a			;8b59
	push hl			;8b5a
	ld l,a			;8b5b
	ld h,000h		;8b5c
	add hl,hl			;8b5e
	ld de,08d2ch		;8b5f   ; ...en p07:8D2C
	add hl,de			;8b62
	ld e,b			;8b63
	srl e		;8b64
	ld d,000h		;8b66
	add hl,de			;8b68
	ld a,(hl)			;8b69   ; la x
	add a,(ix+006h)		;8b6a
	sub 010h		;8b6d
	ld e,a			;8b6f
	pop hl			;8b70
	sub h			;8b71   ; a menos de 4?
	add a,004h		;8b72   ; ...corrida +4...
	cp 009h		;8b74   ; ...cabe en la caja si va de -4 a 4
	ret nc			;8b76   ; no cabe: fuera
	ld a,(0d90fh)		;8b77   ; se agarra
	set 3,a		;8b7a
	ld (0d90fh),a		;8b7c   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,e			;8b7f
	ld (0d8fch),a		;8b80   ; la x de Rastan = a
	ld (0d914h),ix		;8b83   ; D914
	ld a,(0d90fh)		;8b87   ; a = bit 7 muerto, bit 4 un rato sin mandos
	res 0,a		;8b8a
	ld (0d90fh),a		;8b8c   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld a,(ix+002h)		;8b8f   ; D916 = el giro
	and 07fh		;8b92
	ld (0d916h),a		;8b94   ; el giro del actor al que esta agarrado = a
	cp 001h		;8b97
	jr c,agarre0_y_b		;8b99
	jr z,agarre0_y_a		;8b9b
	cp 008h		;8b9d
	jr c,guarda_agarre_0		;8b9f
	jr z,agarre0_y_a		;8ba1
	cp 00ah		;8ba3
	jr c,agarre0_y_b		;8ba5
	jr z,agarre0_y_a		;8ba7
	cp 011h		;8ba9
	jr c,guarda_agarre_0		;8bab
agarre0_y_a:
	ld a,l			;8bad
	sub (ix+007h)		;8bae   ; L - y del agarradero
	cp 01fh		;8bb1   ; menos de 0x1F?
	jr c,guarda_agarre_0		;8bb3   ; si: esa y
	inc l			;8bb5   ; no: un pixel mas abajo
	jr guarda_agarre_0		;8bb6
agarre0_y_b:
	ld a,l			;8bb8
	sub (ix+007h)		;8bb9
	cp 02fh		;8bbc
	jr c,guarda_agarre_0		;8bbe
	inc l			;8bc0
guarda_agarre_0:
	ld a,l			;8bc1   ; D917
	ld (0d917h),a		;8bc2   ; la y de agarre = a
	ret			;8bc5

; ----------------------------------------------------------------------
; LOS OBJETOS: el bloque especial de tipo 4-0x12. Si Rastan lo toca,
; desaparece, suma los puntos de p07:8C31 y hace lo que diga la tabla de
; p07:8C13 (efecto 7).
; ----------------------------------------------------------------------
coge_objeto:
	ld a,(0d92dh)		;8bc6   ; tipo 0x13 o mas: no es un objeto
	cp 013h		;8bc9
	ret nc			;8bcb
	sub 004h		;8bcc   ; tipo 0-3: tampoco (las armas, p07:8000)
	ret c			;8bce
	ld c,a			;8bcf
	ld a,(0d92bh)		;8bd0   ; dentro de su caja en x...
	sub h			;8bd3   ; la diferencia en x...
	add a,007h		;8bd4   ; ...corrida +7...
	cp 01ah		;8bd6   ; ...cabe en la caja si va de -7 a 18
	ret nc			;8bd8   ; no cabe: fuera
	ld a,(0d92ch)		;8bd9   ; ...y en y
	sub l			;8bdc   ; la diferencia en y...
	add a,007h		;8bdd   ; ...corrida +7...
	cp 01fh		;8bdf   ; ...cabe en la caja si va de -7 a 23
	ret nc			;8be1   ; no cabe: fuera
	push hl			;8be2
	call 0629eh		;8be3   ; se repinta el fondo encima
	ld a,(0d92dh)		;8be6   ; (tipo - 4) * 2
	sub 004h		;8be9
	add a,a			;8beb
	ld c,a			;8bec
	ld b,000h		;8bed
	exx			;8bef
	ld hl,0d928h		;8bf0   ; suceso del bit 2: efecto 7
	set 2,(hl)		;8bf3
	exx			;8bf5
	ld hl,08c31h		;8bf6   ; sus puntos...
	add hl,bc			;8bf9
	ld e,(hl)			;8bfa
	inc hl			;8bfb
	ld d,(hl)			;8bfc
	push bc			;8bfd
	ld bc,00000h		;8bfe
	call suma_puntos		;8c01   ; ...sumados
	pop bc			;8c04
	ld hl,08c13h		;8c05   ; su rutina...
	add hl,bc			;8c08
	ld e,(hl)			;8c09
	inc hl			;8c0a
	ld d,(hl)			;8c0b
	ex de,hl			;8c0c
	xor a			;8c0d   ; ...ya no hay bloque especial...
	ld (0d92dh),a		;8c0e   ; cual es el bloque especial = a
	ex (sp),hl			;8c11   ; ...y a la rutina
	ret			;8c12

; ----------------------------------------------------------------------
; DATOS objeto_rutina: Lo que hace cada objeto (tipos 4-0x12): 4-6 nada, 7 y 8
;   vida, 9 y 0x0A dano, 0x0B vida llena, 0x0C mata a todos, 0x0D y 0x0E
;   doblan arma y escudo, 0x0F puntos dobles, 0x10-0x12 escudo
;   0x8c13..0x8c31  (30 bytes)
DATA_objeto_rutina:
	defw 08d0ah,08d0ah,08d0ah,08c4fh,08c53h	; 8c13
	defw 08c6fh,08c73h,08c57h,08cb6h,08cc8h	; 8c1d
	defw 08ce1h,08cfch,08c7ah,08c7eh,08c82h	; 8c27

; ----------------------------------------------------------------------
; DATOS objeto_puntos: Los puntos de cada objeto (palabras BCD): 0x100, 0x200,
;   0x300, 0x100, 0x200, 0x1000, 0x2000, 0x100, 0, 0x100, 0x500, 0x300, 0x100,
;   0x150, 0x200
;   0x8c31..0x8c4f  (30 bytes)
DATA_objeto_puntos:
	defw 00100h,00200h,00300h,00100h,00200h	; 8c31
	defw 01000h,02000h,00100h,00000h,00100h	; 8c3b
	defw 00500h,00300h,00100h,00150h,00200h	; 8c45

; ======================================================================
; CODIGO 0x8c4f..0x8d2c  (221 bytes)
; ======================================================================


objeto_vida_10:
	ld c,010h		;8c4f   ; objeto 7: 0x10 de vida
	jr suma_vida		;8c51
objeto_vida_20:
	ld c,020h		;8c53   ; objeto 8: 0x20 de vida
	jr suma_vida		;8c55
objeto_vida_llena:
	ld a,(0d91dh)		;8c57   ; objeto 0x0B: la vida al maximo
	ld (0d91ch),a		;8c5a   ; la vida de Rastan = a
	ret			;8c5d
suma_vida:
	ld a,(0d91ch)		;8c5e   ; vida + C...
	add a,c			;8c61
	ld b,a			;8c62
	ld a,(0d91dh)		;8c63   ; ...sin pasar del maximo
	cp b			;8c66
	jr nc,guarda_vida		;8c67
	ld b,a			;8c69
guarda_vida:
	ld a,b			;8c6a
	ld (0d91ch),a		;8c6b   ; la vida de Rastan = a
	ret			;8c6e
objeto_dano_4:
	ld d,004h		;8c6f   ; objeto 9: quita 4
	jr objeto_dano		;8c71
objeto_dano_8:
	ld d,008h		;8c73   ; objeto 0x0A: quita 8
	jr objeto_dano		;8c75
objeto_dano:
	jp 07818h		;8c77   ; p06:7818
objeto_escudo_1:
	ld d,001h		;8c7a   ; objeto 0x10: escudo 1
	jr pon_escudo		;8c7c
objeto_escudo_2:
	ld d,002h		;8c7e   ; objeto 0x11: escudo 2
	jr pon_escudo		;8c80
objeto_escudo_3:
	ld d,003h		;8c82   ; objeto 0x12: escudo 3
pon_escudo:
	ld a,d			;8c84   ; D91B = el escudo
	ld (0d91bh),a		;8c85   ; el escudo que lleva = a
	add a,a			;8c88   ; en los bits 2-3 de D905 (su icono)
	add a,a			;8c89
	ld d,a			;8c8a
	ld a,(0d905h)		;8c8b   ; a = lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble
	and 0f3h		;8c8e
	or d			;8c90
	ld (0d905h),a		;8c91   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ld a,(0d920h)		;8c94   ; cuantos golpes aguanta, segun la puntuacion:
	ld d,009h		;8c97   ; 0x10 o mas: 9
	cp 010h		;8c99
	jr nc,guarda_golpes		;8c9b
	ld d,008h		;8c9d   ; 6 o mas: 8
	cp 006h		;8c9f
	jr nc,guarda_golpes		;8ca1
	ld d,007h		;8ca3   ; 3 o mas: 7
	cp 003h		;8ca5
	jr nc,guarda_golpes		;8ca7
	ld d,006h		;8ca9   ; 1 o mas: 6
	cp 001h		;8cab
	jr nc,guarda_golpes		;8cad
	ld d,005h		;8caf   ; menos: 5
guarda_golpes:
	ld a,d			;8cb1   ; D926
	ld (0d926h),a		;8cb2   ; los golpes que le quedan al escudo = a
	ret			;8cb5
objeto_mata_todos:
	ld b,003h		;8cb6   ; objeto 0x0C: los 3 actores...
	ld de,00026h		;8cb8
	ld ix,0d933h		;8cbb   ; ix -> los 6 actores de la pantalla
mata_actor:
	ld (ix+00fh),000h		;8cbf   ; ...sin vida
	add ix,de		;8cc3
	djnz mata_actor		;8cc5
	ret			;8cc7
objeto_dobla_arma:
	ld a,(0d919h)		;8cc8   ; objeto 0x0D: con arma...
	or a			;8ccb
	ret z			;8ccc
	ld a,(0d91ah)		;8ccd   ; ...el doble de segundos (hasta 255)...
	add a,a			;8cd0
	jr nc,L_8CD5		;8cd1
	ld a,0ffh		;8cd3
L_8CD5:
	ld (0d91ah),a		;8cd5   ; segundos que le quedan al arma = a
	ld a,(0d905h)		;8cd8   ; ...y el icono del bit 7
	set 7,a		;8cdb
	ld (0d905h),a		;8cdd   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ret			;8ce0
objeto_dobla_escudo:
	ld a,(0d91bh)		;8ce1   ; objeto 0x0E: con escudo...
	or a			;8ce4
	ret z			;8ce5
	ld a,(0d926h)		;8ce6   ; ...el doble de golpes (hasta 31)...
	add a,a			;8ce9
	cp 020h		;8cea
	jr c,L_8CF0		;8cec
	ld a,01fh		;8cee
L_8CF0:
	ld (0d926h),a		;8cf0   ; los golpes que le quedan al escudo = a
	ld a,(0d905h)		;8cf3   ; ...y el icono del bit 6
	set 6,a		;8cf6
	ld (0d905h),a		;8cf8   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ret			;8cfb
objeto_puntos_dobles:
	ld a,(0d905h)		;8cfc   ; objeto 0x0F: D905 bit 5...
	set 5,a		;8cff
	ld (0d905h),a		;8d01   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ld a,03ch		;8d04   ; ...durante 60 segundos
	ld (0d92ah),a		;8d06   ; segundos que le quedan a los puntos dobles = a
	ret			;8d09
objeto_nada:
	ret			;8d0a   ; objetos 4, 5 y 6: solo puntos

; ----------------------------------------------------------------------
; Suma BCDE a la puntuacion (4 bytes BCD desde D91E) y marca que ha
; cambiado (bit 7 del ultimo). Con D905 bit 5 se suma dos veces.
; ----------------------------------------------------------------------
suma_puntos:
	ld a,(0d905h)		;8d0b   ; puntos dobles?
	bit 5,a		;8d0e
	call nz,suma_una_vez		;8d10   ; si: una vez de mas
suma_una_vez:
	ld a,e			;8d13   ; E + byte 1
	ld hl,0d91eh		;8d14   ; hl -> la puntuacion, cuatro bytes BCD
	add a,(hl)			;8d17
	daa			;8d18
	ld (hl),a			;8d19
	inc hl			;8d1a   ; D + byte 2, con acarreo
	ld a,d			;8d1b
	adc a,(hl)			;8d1c
	daa			;8d1d
	ld (hl),a			;8d1e
	inc hl			;8d1f   ; C + byte 3
	ld a,c			;8d20
	adc a,(hl)			;8d21
	daa			;8d22
	ld (hl),a			;8d23
	inc hl			;8d24   ; B + byte 4...
	ld a,b			;8d25
	adc a,(hl)			;8d26
	daa			;8d27
	set 7,a		;8d28   ; ...con la marca de cambio
	ld (hl),a			;8d2a
	ret			;8d2b

; ----------------------------------------------------------------------
; DATOS agarre_x_forma0: Forma 0 de los agarraderos: la x relativa de agarre
;   por giro (10 giros x 40 distancias en y, de 2 en 2)
;   0x8d2c..0x8ebc  (400 bytes)
DATA_agarre_x_forma0:
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,004h,004h,004h,003h,003h,002h,002h,002h,001h	; 8d2c  ....................
	defb 001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch,0fbh,0fbh,0fah,0f9h,0f9h,0f8h,0f7h,0f7h	; 8d40  ....................
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h,003h,003h,003h,002h	; 8d54  ....................
	defb 002h,002h,001h,001h,000h,000h,000h,0ffh,0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch,0fbh,0fbh,0fah,0fah	; 8d68  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 8d7c  ....................
	defb 003h,003h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh,0fch,0fch	; 8d90  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 8da4  ....................
	defb 003h,003h,003h,003h,002h,002h,002h,002h,001h,001h,001h,001h,000h,000h,000h,0ffh,0ffh,0ffh,0feh,0feh	; 8db8  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 8dcc  ....................
	defb 006h,006h,006h,006h,006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h,003h,003h,003h,003h	; 8de0  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 8df4  ....................
	defb 008h,008h,008h,008h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh	; 8e08  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h	; 8e1c  ....................
	defb 00ah,00ah,00ah,00ah,00bh,00bh,00bh,00bh,00ch,00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh,00eh,00fh,00fh	; 8e30  ....................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 8e44  ....................
	defb 00bh,00bh,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h,012h,012h	; 8e58  ....................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,00bh,00ch	; 8e6c  ....................
	defb 00ch,00ch,00dh,00dh,00eh,00eh,00eh,00fh,00fh,00fh,010h,010h,011h,011h,012h,012h,013h,013h,014h,014h	; 8e80  ....................
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,00ah,00ah,00ah,00bh,00bh,00ch,00ch,00ch,00dh	; 8e94  ....................
	defb 00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h,012h,012h,013h,013h,014h,015h,015h,016h,017h,017h	; 8ea8  ....................

; ----------------------------------------------------------------------
; DATOS agarre_x_forma1: Forma 1: 10 giros x 32 distancias
;   0x8ebc..0x8ffc  (320 bytes)
DATA_agarre_x_forma1:
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

; ----------------------------------------------------------------------
; DATOS agarre_x_forma2: Forma 2: 10 giros x 24 distancias
;   0x8ffc..0x90ec  (240 bytes)
DATA_agarre_x_forma2:
	defb 007h,007h,006h,005h,005h,004h,003h,003h,002h,001h,001h,000h	; 8ffc  ............
	defb 0ffh,0ffh,0feh,0fdh,0fch,0fbh,0fah,0f9h,0f8h,0f7h,0f6h,0f5h	; 9008  ............
	defb 007h,007h,006h,006h,005h,005h,004h,004h,003h,003h,002h,001h	; 9014  ............
	defb 001h,000h,0ffh,0ffh,0feh,0fdh,0fdh,0fch,0fch,0fbh,0fbh,0fah	; 9020  ............
	defb 007h,007h,007h,006h,006h,006h,005h,005h,004h,004h,003h,003h	; 902c  ............
	defb 002h,002h,001h,001h,000h,000h,0ffh,0ffh,0feh,0feh,0fdh,0fdh	; 9038  ............
	defb 007h,007h,007h,007h,006h,006h,006h,006h,005h,005h,005h,004h	; 9044  ............
	defb 004h,004h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h	; 9050  ............
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 905c  ............
	defb 006h,006h,006h,006h,005h,005h,005h,005h,004h,004h,004h,004h	; 9068  ............
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; 9074  ............
	defb 008h,008h,008h,008h,009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 9080  ............
	defb 007h,007h,007h,007h,008h,008h,008h,008h,009h,009h,009h,00ah	; 908c  ............
	defb 00ah,00ah,00bh,00bh,00ch,00ch,00ch,00dh,00dh,00dh,00eh,00eh	; 9098  ............
	defb 007h,007h,007h,008h,008h,008h,009h,009h,00ah,00ah,00bh,00bh	; 90a4  ............
	defb 00ch,00ch,00dh,00dh,00eh,00eh,00fh,00fh,010h,010h,011h,011h	; 90b0  ............
	defb 007h,007h,008h,009h,009h,00ah,00bh,00bh,00ch,00dh,00dh,00eh	; 90bc  ............
	defb 00eh,00fh,010h,010h,011h,012h,012h,013h,014h,014h,015h,015h	; 90c8  ............
	defb 007h,007h,008h,009h,009h,00ah,00ah,00bh,00ch,00ch,00dh,00eh	; 90d4  ............
	defb 00eh,00fh,010h,011h,012h,013h,014h,015h,016h,017h,018h,019h	; 90e0  ............

; ----------------------------------------------------------------------
; DATOS agarre_x_forma3: Forma 3: 10 giros x 16 distancias
;   0x90ec..0x918c  (160 bytes)
DATA_agarre_x_forma3:
	defb 007h,006h,005h,003h,002h,001h,0ffh,0feh	; 90ec  ........
	defb 0fch,0fah,0f8h,0f6h,0f4h,0f2h,0f0h,0eeh	; 90f4  ........
	defb 007h,006h,005h,004h,003h,002h,001h,000h	; 90fc  ........
	defb 0ffh,0feh,0fch,0fbh,0fah,0f8h,0f8h,0f8h	; 9104  ........
	defb 007h,007h,006h,005h,005h,004h,003h,003h	; 910c  ........
	defb 002h,001h,000h,0ffh,0feh,0fdh,0fch,0fbh	; 9114  ........
	defb 007h,007h,006h,006h,005h,005h,004h,004h	; 911c  ........
	defb 003h,003h,002h,002h,001h,001h,000h,000h	; 9124  ........
	defb 007h,007h,007h,007h,006h,006h,006h,006h	; 912c  ........
	defb 005h,005h,005h,005h,004h,004h,004h,004h	; 9134  ........
	defb 007h,007h,007h,007h,008h,008h,008h,008h	; 913c  ........
	defb 009h,009h,009h,009h,00ah,00ah,00ah,00ah	; 9144  ........
	defb 007h,007h,008h,008h,009h,009h,00ah,00ah	; 914c  ........
	defb 00bh,00bh,00ch,00ch,00dh,00dh,00eh,00eh	; 9154  ........
	defb 007h,007h,008h,009h,009h,00ah,00bh,00bh	; 915c  ........
	defb 00ch,00dh,00eh,00fh,010h,011h,012h,013h	; 9164  ........
	defb 007h,008h,009h,00ah,00bh,00ch,00dh,00eh	; 916c  ........
	defb 00fh,010h,012h,013h,014h,016h,017h,017h	; 9174  ........
	defb 007h,008h,009h,00bh,00ch,00dh,00eh,010h	; 917c  ........
	defb 012h,014h,016h,018h,01ah,01ch,01eh,01eh	; 9184  ........

; ======================================================================
; CODIGO 0x918c..0x91c5  (57 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL JEFE CONTRA RASTAN (D910 bit 6). El jefe es el actor 0 (D933): su tipo
; (1-5) elige la rutina de la tabla p07:91C5, que mira cajas segun su pose
; (D934) y su cuadro (D935) y hace dano con escudo a la mitad.
; ----------------------------------------------------------------------
choque_jefe:
	ld hl,(0d969h)		;918c   ; D969: la vida del jefe; 0, ya no esta
	ld a,h			;918f
	or l			;9190
	ret z			;9191
	ld a,(0d8fch)		;9192   ; H, L = Rastan
	ld h,a			;9195
	ld a,(0d8fdh)		;9196   ; a = la y de Rastan
	ld l,a			;9199
	ld a,(0d904h)		;919a   ; agachado: 14 pixeles mas abajo
	and 01eh		;919d
	cp 004h		;919f
	jr nz,jefe_xy		;91a1
	ld a,l			;91a3
	add a,00eh		;91a4
	ld l,a			;91a6
jefe_xy:
	ld a,(0d93ah)		;91a7   ; D, E = el jefe (x, y)
	ld e,a			;91aa
	ld a,(0d939h)		;91ab   ; a = actor 0, byte +6
	ld d,a			;91ae
	exx			;91af
	ld a,(0d933h)		;91b0   ; su tipo: 6 o mas, nada
	cp 006h		;91b3
	ret nc			;91b5
	add a,a			;91b6   ; * 2 en p07:91C5...
	ld l,a			;91b7
	ld h,000h		;91b8
	ld de,091c5h		;91ba
	add hl,de			;91bd
	ld a,(hl)			;91be
	inc hl			;91bf
	ld h,(hl)			;91c0
	ld l,a			;91c1
	push hl			;91c2   ; ...y a la rutina
	exx			;91c3
jefe_nada:
	ret			;91c4   ; tipo 0: nada

; ----------------------------------------------------------------------
; DATOS choque_por_jefe: La rutina de choque de cada jefe (tipos 0-5)
;   0x91c5..0x91d1  (12 bytes)
DATA_choque_por_jefe:
	defw 091c4h,0920ch,092d2h,09336h,0935dh,093e6h	; 91c5

; ======================================================================
; CODIGO 0x91d1..0x9200  (47 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL ATAQUE DE RASTAN CONTRA EL JEFE: la rutina de su tipo en p07:9200
; decide si el punto del golpe (H, L) cae en el.
; ----------------------------------------------------------------------
golpe_a_jefe:
	xor a			;91d1   ; sin disparo del arma 3
	ld (0d924h),a		;91d2   ; bit 7: el jugador usa la ficha 10 = a
	ld de,(0d969h)		;91d5   ; el jefe ya no esta: nada
	ld a,d			;91d9
	or e			;91da
	ret z			;91db
	ld a,(0d958h)		;91dc   ; ya le dio este golpe: nada
	bit 7,a		;91df
	ret nz			;91e1
	ld a,(0d93ah)		;91e2   ; D, E = el jefe
	ld e,a			;91e5
	ld a,(0d939h)		;91e6   ; a = actor 0, byte +6
	ld d,a			;91e9
	exx			;91ea
	ld a,(0d933h)		;91eb   ; su tipo
	cp 006h		;91ee
	ret nc			;91f0
	add a,a			;91f1   ; * 2 en p07:9200...
	ld l,a			;91f2
	ld h,000h		;91f3
	ld de,09200h		;91f5
	add hl,de			;91f8
	ld a,(hl)			;91f9
	inc hl			;91fa
	ld h,(hl)			;91fb
	ld l,a			;91fc
	push hl			;91fd   ; ...y a la rutina
	exx			;91fe
	ret			;91ff

; ----------------------------------------------------------------------
; DATOS golpe_por_jefe: La caja de golpe de cada jefe (tipos 0-5)
;   0x9200..0x920c  (12 bytes)
DATA_golpe_por_jefe:
	defw 091c4h,0952dh,0953eh,09577h,09588h,09599h	; 9200

; ======================================================================
; CODIGO 0x920c..0x9235  (41 bytes)
; ======================================================================


choque_jefe_1:
	ld c,00ch		;920c   ; jefe 1: dano 0x0C...
	ld a,d			;920e   ; ...si Rastan cae en su cuerpo
	sub h			;920f   ; la diferencia en x...
	add a,013h		;9210   ; ...corrida +19...
	cp 027h		;9212   ; ...cabe en la caja si va de -19 a 19
	jr nc,L_921F		;9214   ; no cabe: fuera
	ld a,e			;9216
	sub l			;9217
	add a,029h		;9218
	cp 043h		;921a
	jp c,dano_jefe_cuerpo		;921c
L_921F:
	push hl			;921f   ; si no, segun su pose (D934 & 7) en p07:9235
	push de			;9220
	ld de,09235h		;9221
	ld a,(0d934h)		;9224   ; a = actor 0, byte +1
	and 007h		;9227
	add a,a			;9229
	ld l,a			;922a
	ld h,000h		;922b
	add hl,de			;922d
	pop de			;922e
	ld a,(hl)			;922f
	inc hl			;9230
	ld h,(hl)			;9231
	ld l,a			;9232
	ex (sp),hl			;9233   ; a la rutina de la pose
	ret			;9234

; ----------------------------------------------------------------------
; DATOS choque_jefe_1_pose: Jefe 1: la rutina de cada pose (8 palabras)
;   0x9235..0x9245  (16 bytes)
DATA_choque_jefe_1_pose:
	defw 09245h,09256h,09267h,0929ch,092d1h,092d1h,092d1h,092d1h	; 9235

; ======================================================================
; CODIGO 0x9245..0x949f  (602 bytes)
; ======================================================================


jefe_1_pose_0:
	ld a,d			;9245   ; una caja a la izquierda
	sub h			;9246   ; la diferencia en x...
	add a,022h		;9247   ; ...corrida +34...
	cp 01ah		;9249   ; ...cabe en la caja si va de -34 a -9
	ret nc			;924b   ; no cabe: fuera
	ld a,e			;924c
	sub l			;924d   ; la diferencia en y...
	add a,008h		;924e   ; ...corrida +8...
	cp 02fh		;9250   ; ...cabe en la caja si va de -8 a 38
	ret nc			;9252   ; no cabe: fuera
	jp dano_jefe_cuerpo		;9253
jefe_1_pose_1:
	ld a,d			;9256   ; una caja a la derecha
	sub h			;9257   ; la diferencia en x...
	sub 009h		;9258   ; ...corrida -9...
	cp 01ah		;925a   ; ...cabe en la caja si va de 9 a 34
	ret nc			;925c   ; no cabe: fuera
	ld a,e			;925d
	sub l			;925e   ; la diferencia en y...
	add a,008h		;925f   ; ...corrida +8...
	cp 02fh		;9261   ; ...cabe en la caja si va de -8 a 38
	ret nc			;9263   ; no cabe: fuera
	jp dano_jefe_cuerpo		;9264
jefe_1_pose_2:
	ld c,010h		;9267   ; dano 0x10
	ld a,e			;9269   ; en y
	sub l			;926a   ; la diferencia en y...
	add a,019h		;926b   ; ...corrida +25...
	cp 023h		;926d   ; ...cabe en la caja si va de -25 a 9
	ret nc			;926f   ; no cabe: fuera
	ld a,(0d935h)		;9270   ; D935 bit 7: nada
	bit 7,a		;9273
	ret nz			;9275
	cp 001h		;9276   ; segun el cuadro (1, 2 o el resto), una caja de ancho distinto
	jr z,jefe_1_pose_2_c1		;9278
	cp 002h		;927a
	jr z,jefe_1_pose_2_c2		;927c
	ld a,d			;927e
	sub h			;927f   ; la diferencia en x...
	add a,03bh		;9280   ; ...corrida +59...
	cp 04bh		;9282   ; ...cabe en la caja si va de -59 a 15
	ret nc			;9284   ; no cabe: fuera
	jp dano_jefe_ataque		;9285
jefe_1_pose_2_c1:
	ld a,d			;9288
	sub h			;9289   ; la diferencia en x...
	add a,02bh		;928a   ; ...corrida +43...
	cp 049h		;928c   ; ...cabe en la caja si va de -43 a 29
	ret nc			;928e   ; no cabe: fuera
	jp dano_jefe_ataque		;928f
jefe_1_pose_2_c2:
	ld a,d			;9292
	sub h			;9293   ; la diferencia en x...
	add a,033h		;9294   ; ...corrida +51...
	cp 04bh		;9296   ; ...cabe en la caja si va de -51 a 23
	ret nc			;9298   ; no cabe: fuera
	jp dano_jefe_ataque		;9299
jefe_1_pose_3:
	ld c,010h		;929c   ; lo mismo hacia el otro lado
	ld a,e			;929e
	sub l			;929f   ; la diferencia en y...
	add a,019h		;92a0   ; ...corrida +25...
	cp 023h		;92a2   ; ...cabe en la caja si va de -25 a 9
	ret nc			;92a4   ; no cabe: fuera
	ld a,(0d935h)		;92a5   ; a = actor 0, byte +2
	bit 7,a		;92a8
	ret nz			;92aa
	cp 001h		;92ab
	jr z,jefe_1_pose_3_c1		;92ad
	cp 002h		;92af
	jr z,jefe_1_pose_3_c2		;92b1
	ld a,d			;92b3
	sub h			;92b4   ; la diferencia en x...
	add a,00fh		;92b5   ; ...corrida +15...
	cp 04bh		;92b7   ; ...cabe en la caja si va de -15 a 59
	ret nc			;92b9   ; no cabe: fuera
	jp dano_jefe_ataque		;92ba
jefe_1_pose_3_c1:
	ld a,d			;92bd
	sub h			;92be   ; la diferencia en x...
	add a,01bh		;92bf   ; ...corrida +27...
	cp 049h		;92c1   ; ...cabe en la caja si va de -27 a 45
	ret nc			;92c3   ; no cabe: fuera
	jp dano_jefe_ataque		;92c4
jefe_1_pose_3_c2:
	ld a,d			;92c7
	sub h			;92c8   ; la diferencia en x...
	add a,017h		;92c9   ; ...corrida +23...
	cp 04bh		;92cb   ; ...cabe en la caja si va de -23 a 51
	ret nc			;92cd   ; no cabe: fuera
	jp dano_jefe_ataque		;92ce
jefe_1_pose_nada:
	ret			;92d1   ; poses 4-7: nada
choque_jefe_2:
	ld a,(0d934h)		;92d2   ; jefe 2: la pose...
	and 00fh		;92d5
	ld b,a			;92d7
	cp 002h		;92d8   ; ...2 o 3 en el cuadro 3: dano 0x10 delante
	jr z,jefe_2_ataque		;92da
	cp 003h		;92dc
	jp nz,jefe_2_cuerpo		;92de
jefe_2_ataque:
	ld c,010h		;92e1
	ld a,(0d935h)		;92e3   ; a = actor 0, byte +2
	cp 003h		;92e6
	jp nz,jefe_2_cuerpo		;92e8
	ld a,e			;92eb
	sub l			;92ec   ; la diferencia en y...
	add a,007h		;92ed   ; ...corrida +7...
	cp 01fh		;92ef   ; ...cabe en la caja si va de -7 a 23
	jp nc,jefe_2_cuerpo		;92f1   ; no cabe: fuera
	bit 0,b		;92f4   ; el lado al que mira
	jr z,jefe_2_ataque_der		;92f6
	ld a,d			;92f8
	sub h			;92f9   ; la diferencia en x...
	add a,021h		;92fa   ; ...corrida +33...
	cp 021h		;92fc   ; ...cabe en la caja si va de -33 a -1
	jp nc,jefe_2_cuerpo		;92fe   ; no cabe: fuera
	jp dano_jefe_ataque		;9301
jefe_2_ataque_der:
	ld a,d			;9304
	sub h			;9305   ; la diferencia en x...
	cp 021h		;9306   ; ...cabe si va de 0 a 32
	jp nc,jefe_2_cuerpo		;9308   ; no cabe: fuera
	jp dano_jefe_ataque		;930b
jefe_2_cuerpo:
	ld c,00ch		;930e   ; si no, dano 0x0C con el cuerpo
	ld a,b			;9310   ; poses 6 en adelante: otra caja
	cp 006h		;9311
	jr nc,jefe_2_cuerpo_b		;9313
	ld a,d			;9315
	sub h			;9316   ; la diferencia en x...
	add a,009h		;9317   ; ...corrida +9...
	cp 013h		;9319   ; ...cabe en la caja si va de -9 a 9
	ret nc			;931b   ; no cabe: fuera
	ld a,e			;931c
	sub l			;931d   ; la diferencia en y...
	add a,017h		;931e   ; ...corrida +23...
	cp 02fh		;9320   ; ...cabe en la caja si va de -23 a 23
	ret nc			;9322   ; no cabe: fuera
	jp dano_jefe_cuerpo		;9323
jefe_2_cuerpo_b:
	ld a,d			;9326
	sub h			;9327   ; la diferencia en x...
	add a,009h		;9328   ; ...corrida +9...
	cp 013h		;932a   ; ...cabe en la caja si va de -9 a 9
	ret nc			;932c   ; no cabe: fuera
	ld a,e			;932d
	add a,017h		;932e
	cp 03fh		;9330
	ret nc			;9332
	jp dano_jefe_cuerpo		;9333
choque_jefe_3:
	ld a,e			;9336   ; jefe 3: dano 0x24 por arriba o por el cuerpo
	sub l			;9337
	ld c,a			;9338
	sub 00bh		;9339
	cp 00dh		;933b
	jr c,jefe_3_arriba		;933d
	ld a,c			;933f
	add a,029h		;9340
	cp 035h		;9342
	ret nc			;9344
	ld a,d			;9345
	sub h			;9346   ; la diferencia en x...
	add a,014h		;9347   ; ...corrida +20...
	cp 029h		;9349   ; ...cabe en la caja si va de -20 a 20
	ret nc			;934b   ; no cabe: fuera
	ld c,024h		;934c   ; dano 0x24
	jp dano_jefe_cuerpo		;934e
jefe_3_arriba:
	ld a,d			;9351
	sub h			;9352   ; la diferencia en x...
	add a,00dh		;9353   ; ...corrida +13...
	cp 01bh		;9355   ; ...cabe en la caja si va de -13 a 13
	ret nc			;9357   ; no cabe: fuera
	ld c,024h		;9358   ; dano 0x24
	jp dano_jefe_cuerpo		;935a
choque_jefe_4:
	ld c,018h		;935d   ; jefe 4: dano 0x18 con sus ataques (poses 2 y 3, cuadros 2 y 3)
	ld a,(0d934h)		;935f   ; a = actor 0, byte +1
	cp 002h		;9362
	jr z,jefe_4_pose_2		;9364
	cp 003h		;9366
	jp nz,jefe_4_cuerpo		;9368
	ld a,(0d935h)		;936b   ; a = actor 0, byte +2
	cp 002h		;936e
	jp c,jefe_4_cuerpo		;9370
	jr z,jefe_4_c2		;9373
	ld a,e			;9375
	sub l			;9376   ; la diferencia en y...
	add a,012h		;9377   ; ...corrida +18...
	cp 021h		;9379   ; ...cabe en la caja si va de -18 a 14
	jp nc,jefe_4_cuerpo		;937b   ; no cabe: fuera
	ld a,d			;937e
	sub h			;937f
	add a,00bh		;9380
	cp 036h		;9382
	jp c,dano_jefe_ataque		;9384
	jp jefe_4_cuerpo		;9387
jefe_4_c2:
	ld a,e			;938a
	sub l			;938b   ; la diferencia en y...
	add a,008h		;938c   ; ...corrida +8...
	cp 027h		;938e   ; ...cabe en la caja si va de -8 a 30
	jp nc,jefe_4_cuerpo		;9390   ; no cabe: fuera
	ld a,d			;9393
	sub h			;9394
	add a,020h		;9395
	cp 018h		;9397
	jp c,dano_jefe_ataque		;9399
	jp jefe_4_cuerpo		;939c
jefe_4_pose_2:
	ld a,(0d935h)		;939f   ; a = actor 0, byte +2
	cp 002h		;93a2
	jp c,jefe_4_cuerpo		;93a4
	jr z,jefe_4_pose_2_c2		;93a7
	ld a,e			;93a9
	sub l			;93aa   ; la diferencia en y...
	add a,012h		;93ab   ; ...corrida +18...
	cp 021h		;93ad   ; ...cabe en la caja si va de -18 a 14
	jp nc,jefe_4_cuerpo		;93af   ; no cabe: fuera
	ld a,d			;93b2
	sub h			;93b3
	add a,02ah		;93b4
	cp 036h		;93b6
	jp c,dano_jefe_ataque		;93b8
	jp jefe_4_cuerpo		;93bb
jefe_4_pose_2_c2:
	ld a,e			;93be
	sub l			;93bf   ; la diferencia en y...
	add a,008h		;93c0   ; ...corrida +8...
	cp 027h		;93c2   ; ...cabe en la caja si va de -8 a 30
	jp nc,jefe_4_cuerpo		;93c4   ; no cabe: fuera
	ld a,d			;93c7
	sub h			;93c8
	sub 009h		;93c9
	cp 018h		;93cb
	jp c,dano_jefe_ataque		;93cd
	jp jefe_4_cuerpo		;93d0
jefe_4_cuerpo:
	ld a,d			;93d3   ; el cuerpo: dano 0x0C
	sub h			;93d4   ; la diferencia en x...
	add a,012h		;93d5   ; ...corrida +18...
	cp 025h		;93d7   ; ...cabe en la caja si va de -18 a 18
	ret nc			;93d9   ; no cabe: fuera
	ld a,e			;93da
	sub l			;93db   ; la diferencia en y...
	add a,02bh		;93dc   ; ...corrida +43...
	cp 03fh		;93de   ; ...cabe en la caja si va de -43 a 19
	ret nc			;93e0   ; no cabe: fuera
	ld c,00ch		;93e1
	jp dano_jefe_cuerpo		;93e3
choque_jefe_5:
	ld c,010h		;93e6   ; jefe 5: dano 0x10 segun la pose (0-7)
	ld a,(0d934h)		;93e8   ; a = actor 0, byte +1
	ld b,a			;93eb
	cp 002h		;93ec
	jp c,jefe_5_cuerpo		;93ee
	jr z,jefe_5_p2		;93f1
	cp 004h		;93f3
	jr c,jefe_5_p3		;93f5
	jr z,jefe_5_p4		;93f7
	cp 006h		;93f9
	jp c,jefe_5_p5		;93fb
	jr z,jefe_5_p6		;93fe
	cp 007h		;9400
	jp nz,jefe_5_cuerpo		;9402
	jr jefe_5_p7		;9405
jefe_5_p5:
	ld a,e			;9407
	sub l			;9408   ; la diferencia en y...
	add a,017h		;9409   ; ...corrida +23...
	cp 01fh		;940b   ; ...cabe en la caja si va de -23 a 7
	jp nc,jefe_5_cuerpo		;940d   ; no cabe: fuera
	ld a,d			;9410
	sub h			;9411   ; la diferencia en x...
	sub 007h		;9412   ; ...corrida -7...
	cp 01ch		;9414   ; ...cabe en la caja si va de 7 a 34
	jp nc,jefe_5_cuerpo		;9416   ; no cabe: fuera
	jp dano_jefe_ataque		;9419
jefe_5_p4:
	ld a,e			;941c
	sub l			;941d   ; la diferencia en y...
	add a,017h		;941e   ; ...corrida +23...
	cp 01fh		;9420   ; ...cabe en la caja si va de -23 a 7
	jp nc,jefe_5_cuerpo		;9422   ; no cabe: fuera
	ld a,d			;9425
	sub h			;9426   ; la diferencia en x...
	add a,032h		;9427   ; ...corrida +50...
	cp 01ch		;9429   ; ...cabe en la caja si va de -50 a -23
	jp nc,jefe_5_cuerpo		;942b   ; no cabe: fuera
	jp dano_jefe_ataque		;942e
jefe_5_p3:
	ld a,e			;9431
	sub l			;9432   ; la diferencia en y...
	add a,007h		;9433   ; ...corrida +7...
	cp 01fh		;9435   ; ...cabe en la caja si va de -7 a 23
	jp nc,jefe_5_cuerpo		;9437   ; no cabe: fuera
	ld a,d			;943a
	sub h			;943b   ; la diferencia en x...
	sub 007h		;943c   ; ...corrida -7...
	cp 01ch		;943e   ; ...cabe en la caja si va de 7 a 34
	jp nc,jefe_5_cuerpo		;9440   ; no cabe: fuera
	jp dano_jefe_ataque		;9443
jefe_5_p2:
	ld a,e			;9446
	sub l			;9447   ; la diferencia en y...
	add a,007h		;9448   ; ...corrida +7...
	cp 01fh		;944a   ; ...cabe en la caja si va de -7 a 23
	jp nc,jefe_5_cuerpo		;944c   ; no cabe: fuera
	ld a,d			;944f
	sub h			;9450   ; la diferencia en x...
	add a,032h		;9451   ; ...corrida +50...
	cp 01ch		;9453   ; ...cabe en la caja si va de -50 a -23
	jp nc,jefe_5_cuerpo		;9455   ; no cabe: fuera
	jp dano_jefe_ataque		;9458
jefe_5_p7:
	ld a,e			;945b
	sub l			;945c   ; la diferencia en y...
	sub 009h		;945d   ; ...corrida -9...
	cp 01fh		;945f   ; ...cabe en la caja si va de 9 a 39
	jp nc,jefe_5_cuerpo		;9461   ; no cabe: fuera
	ld a,d			;9464
	sub h			;9465   ; la diferencia en x...
	add a,001h		;9466   ; ...corrida +1...
	cp 01ch		;9468   ; ...cabe en la caja si va de -1 a 26
	jp nc,jefe_5_cuerpo		;946a   ; no cabe: fuera
	jp dano_jefe_ataque		;946d
jefe_5_p6:
	ld a,e			;9470
	sub l			;9471   ; la diferencia en y...
	sub 009h		;9472   ; ...corrida -9...
	cp 01fh		;9474   ; ...cabe en la caja si va de 9 a 39
	jp nc,jefe_5_cuerpo		;9476   ; no cabe: fuera
	ld a,d			;9479
	sub h			;947a   ; la diferencia en x...
	add a,02ah		;947b   ; ...corrida +42...
	cp 01ch		;947d   ; ...cabe en la caja si va de -42 a -15
	jp nc,jefe_5_cuerpo		;947f   ; no cabe: fuera
	jp dano_jefe_ataque		;9482
jefe_5_cuerpo:
	ld c,00ch		;9485   ; el cuerpo: dano 0x0C
	ld a,e			;9487
	sub l			;9488   ; la diferencia en y...
	add a,027h		;9489   ; ...corrida +39...
	cp 01fh		;948b   ; ...cabe en la caja si va de -39 a -9
	jr nc,L_9498		;948d   ; no cabe: fuera
	ld a,d			;948f
	sub h			;9490
	add a,021h		;9491
	cp 033h		;9493
	jp c,dano_jefe_cuerpo		;9495
L_9498:
	ld a,b			;9498   ; pose 8: p07:94DC; si no, p07:94CB
	cp 008h		;9499
	jr z,$+65		;949b
	jr $+46		;949d

; ----------------------------------------------------------------------
; DATOS resto_949F: 44 bytes de codigo que nadie ejecuta (mas cajas del jefe
;   5)
;   0x949f..0x94cb  (44 bytes)
DATA_resto_949F:
	defb 0feh,006h,028h,039h,030h,026h,0e6h,001h,020h,011h,07bh,095h,0c6h,027h,0feh,03fh	; 949f  ..(90&.. .{..'.?
	defb 0d0h,07ah,094h,0c6h,003h,0feh,017h,0dah,0edh,094h,0c9h,07bh,095h,0c6h,027h,0feh	; 94af  .z.........{..'.
	defb 03fh,0d0h,07ah,094h,0c6h,023h,0feh,017h,0dah,0edh,094h,0c9h	; 94bf  ?.z..#......

; ======================================================================
; CODIGO 0x94cb..0x9709  (574 bytes)
; ======================================================================


jefe_5_caja_a:
	ld a,e			;94cb
	sub l			;94cc   ; la diferencia en y...
	add a,027h		;94cd   ; ...corrida +39...
	cp 02fh		;94cf   ; ...cabe en la caja si va de -39 a 7
	ret nc			;94d1   ; no cabe: fuera
	ld a,d			;94d2
	sub h			;94d3
	add a,003h		;94d4
	cp 017h		;94d6
	jp c,dano_jefe_cuerpo		;94d8
	ret			;94db
jefe_5_caja_b:
	ld a,e			;94dc
	sub l			;94dd   ; la diferencia en y...
	add a,02fh		;94de   ; ...corrida +47...
	cp 03fh		;94e0   ; ...cabe en la caja si va de -47 a 15
	ret nc			;94e2   ; no cabe: fuera
	ld a,d			;94e3
	sub h			;94e4
	add a,023h		;94e5
	cp 017h		;94e7
	jp c,dano_jefe_cuerpo		;94e9
	ret			;94ec
dano_jefe_cuerpo:
	ld a,(0d91bh)		;94ed   ; con escudo...
	or a			;94f0
	jr z,dano_jefe		;94f1
	ld a,(0d926h)		;94f3   ; ...un golpe menos...
	dec a			;94f6
	ld (0d926h),a		;94f7   ; los golpes que le quedan al escudo = a
	jr nz,dano_jefe_mitad		;94fa
	ld (0d91bh),a		;94fc   ; ...y si se acaba, fuera
	ld a,(0d905h)		;94ff   ; a = lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble
	and 0b3h		;9502
	ld (0d905h),a		;9504   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
dano_jefe_mitad:
	srl c		;9507   ; dano / 2
dano_jefe:
	ld d,c			;9509   ; a la vida de Rastan
	jp 07818h		;950a   ; p06 dano
dano_jefe_ataque:
	ld a,(0d91bh)		;950d   ; lo mismo para los ataques
	or a			;9510
	jr z,dano_jefe_ataque_b		;9511
	ld a,(0d926h)		;9513   ; a = los golpes que le quedan al escudo
	dec a			;9516
	ld (0d926h),a		;9517   ; los golpes que le quedan al escudo = a
	jr nz,dano_jefe_ataque_mitad		;951a
	ld (0d91bh),a		;951c   ; el escudo que lleva = a
	ld a,(0d905h)		;951f   ; a = lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble
	and 0b3h		;9522
	ld (0d905h),a		;9524   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
dano_jefe_ataque_mitad:
	srl c		;9527
dano_jefe_ataque_b:
	ld d,c			;9529
	jp 07818h		;952a   ; p06 dano
golpe_jefe_1:
	ld a,e			;952d   ; jefe 1: una caja de 0x38 x 0x2B
	sub l			;952e   ; la diferencia en y...
	add a,02ch		;952f   ; ...corrida +44...
	cp 038h		;9531   ; ...cabe en la caja si va de -44 a 11
	ret nc			;9533   ; no cabe: fuera
	ld a,d			;9534
	sub h			;9535   ; la diferencia en x...
	add a,01dh		;9536   ; ...corrida +29...
	cp 02bh		;9538   ; ...cabe en la caja si va de -29 a 13
	ret nc			;953a   ; no cabe: fuera
	jp le_da_al_jefe		;953b
golpe_jefe_2:
	ld a,(0d934h)		;953e   ; jefe 2: poses 0-7, una caja...
	cp 008h		;9541
	jr nc,golpe_jefe_2_b		;9543
	ld a,e			;9545
	sub l			;9546   ; la diferencia en y...
	add a,02ch		;9547   ; ...corrida +44...
	cp 038h		;9549   ; ...cabe en la caja si va de -44 a 11
	ret nc			;954b   ; no cabe: fuera
	ld a,d			;954c
	sub h			;954d   ; la diferencia en x...
	add a,015h		;954e   ; ...corrida +21...
	cp 01bh		;9550   ; ...cabe en la caja si va de -21 a 5
	ret nc			;9552   ; no cabe: fuera
	jp le_da_al_jefe		;9553
golpe_jefe_2_b:
	ld a,e			;9556   ; ...de la 8 en adelante, dos
	sub l			;9557   ; la diferencia en y...
	add a,02ch		;9558   ; ...corrida +44...
	cp 038h		;955a   ; ...cabe en la caja si va de -44 a 11
	jr nc,golpe_jefe_2_c		;955c   ; no cabe: fuera
	ld a,d			;955e
	sub h			;955f
	add a,015h		;9560
	cp 01bh		;9562
	jp c,le_da_al_jefe		;9564
golpe_jefe_2_c:
	ld a,e			;9567
	sub l			;9568
	dec a			;9569
	cp 019h		;956a
	ret nc			;956c
	ld a,d			;956d
	sub h			;956e   ; la diferencia en x...
	add a,01bh		;956f   ; ...corrida +27...
	cp 027h		;9571   ; ...cabe en la caja si va de -27 a 11
	ret nc			;9573   ; no cabe: fuera
	jp le_da_al_jefe		;9574
golpe_jefe_3:
	ld a,e			;9577
	sub l			;9578   ; la diferencia en y...
	add a,02ch		;9579   ; ...corrida +44...
	cp 038h		;957b   ; ...cabe en la caja si va de -44 a 11
	ret nc			;957d   ; no cabe: fuera
	ld a,d			;957e
	sub h			;957f   ; la diferencia en x...
	add a,01dh		;9580   ; ...corrida +29...
	cp 02bh		;9582   ; ...cabe en la caja si va de -29 a 13
	ret nc			;9584   ; no cabe: fuera
	jp le_da_al_jefe		;9585
golpe_jefe_4:
	ld a,e			;9588   ; jefe 4: mas ancha (0x48)
	sub l			;9589   ; la diferencia en y...
	add a,02ch		;958a   ; ...corrida +44...
	cp 048h		;958c   ; ...cabe en la caja si va de -44 a 27
	ret nc			;958e   ; no cabe: fuera
	ld a,d			;958f
	sub h			;9590   ; la diferencia en x...
	add a,01dh		;9591   ; ...corrida +29...
	cp 02bh		;9593   ; ...cabe en la caja si va de -29 a 13
	ret nc			;9595   ; no cabe: fuera
	jp le_da_al_jefe		;9596
golpe_jefe_5:
	ld a,(0d934h)		;9599   ; jefe 5: segun la pose, una caja distinta
	cp 001h		;959c
	jp c,golpe_jefe_5_i		;959e
	jp z,golpe_jefe_5_g		;95a1
	cp 003h		;95a4
	jp c,golpe_jefe_5_i		;95a6
	jp z,golpe_jefe_5_g		;95a9
	cp 005h		;95ac
	jr c,golpe_jefe_5_f		;95ae
	jr z,golpe_jefe_5_e		;95b0
	cp 007h		;95b2
	jp c,golpe_jefe_5_m		;95b4
	jp z,golpe_jefe_5_k		;95b7
	cp 009h		;95ba
	jr c,golpe_jefe_5_c		;95bc
	ld a,(0d935h)		;95be   ; a = actor 0, byte +2
	cp 003h		;95c1
	jp nc,golpe_jefe_5_k		;95c3
	ld b,a			;95c6
	ld a,e			;95c7
	sub l			;95c8   ; la diferencia en y...
	add a,01dh		;95c9   ; ...corrida +29...
	cp 01bh		;95cb   ; ...cabe en la caja si va de -29 a -3
	jr nc,golpe_jefe_5_b		;95cd   ; no cabe: fuera
	ld a,d			;95cf
	sub h			;95d0
	add a,00dh		;95d1
	cp 01bh		;95d3
	jp c,le_da_al_jefe		;95d5
golpe_jefe_5_b:
	ld a,b			;95d8
	cp 002h		;95d9
	ret c			;95db
	ld a,e			;95dc
	sub l			;95dd   ; la diferencia en y...
	add a,00dh		;95de   ; ...corrida +13...
	cp 01bh		;95e0   ; ...cabe en la caja si va de -13 a 13
	ret nc			;95e2   ; no cabe: fuera
	ld a,d			;95e3
	sub h			;95e4   ; la diferencia en x...
	add a,005h		;95e5   ; ...corrida +5...
	cp 01bh		;95e7   ; ...cabe en la caja si va de -5 a 21
	ret nc			;95e9   ; no cabe: fuera
	jp le_da_al_jefe		;95ea
golpe_jefe_5_c:
	ld a,(0d935h)		;95ed   ; a = actor 0, byte +2
	cp 003h		;95f0
	jp nc,golpe_jefe_5_m		;95f2
	ld b,a			;95f5
	ld a,e			;95f6
	sub l			;95f7   ; la diferencia en y...
	add a,01dh		;95f8   ; ...corrida +29...
	cp 01bh		;95fa   ; ...cabe en la caja si va de -29 a -3
	jr nc,golpe_jefe_5_d		;95fc   ; no cabe: fuera
	ld a,d			;95fe
	sub h			;95ff
	add a,02dh		;9600
	cp 01bh		;9602
	jp c,le_da_al_jefe		;9604
golpe_jefe_5_d:
	ld a,b			;9607
	cp 002h		;9608
	ret c			;960a
	ld a,e			;960b
	sub l			;960c   ; la diferencia en y...
	add a,00dh		;960d   ; ...corrida +13...
	cp 01bh		;960f   ; ...cabe en la caja si va de -13 a 13
	ret nc			;9611   ; no cabe: fuera
	ld a,d			;9612
	sub h			;9613   ; la diferencia en x...
	add a,035h		;9614   ; ...corrida +53...
	cp 01bh		;9616   ; ...cabe en la caja si va de -53 a -27
	ret nc			;9618   ; no cabe: fuera
	jp le_da_al_jefe		;9619
golpe_jefe_5_e:
	ld a,e			;961c
	sub l			;961d   ; la diferencia en y...
	add a,01dh		;961e   ; ...corrida +29...
	cp 01bh		;9620   ; ...cabe en la caja si va de -29 a -3
	ret nc			;9622   ; no cabe: fuera
	ld a,d			;9623
	sub h			;9624   ; la diferencia en x...
	add a,018h		;9625   ; ...corrida +24...
	cp 036h		;9627   ; ...cabe en la caja si va de -24 a 29
	ret nc			;9629   ; no cabe: fuera
	jp le_da_al_jefe		;962a
golpe_jefe_5_f:
	ld a,e			;962d
	sub l			;962e   ; la diferencia en y...
	add a,01dh		;962f   ; ...corrida +29...
	cp 01bh		;9631   ; ...cabe en la caja si va de -29 a -3
	ret nc			;9633   ; no cabe: fuera
	ld a,d			;9634
	sub h			;9635   ; la diferencia en x...
	add a,03dh		;9636   ; ...corrida +61...
	cp 036h		;9638   ; ...cabe en la caja si va de -61 a -8
	ret nc			;963a   ; no cabe: fuera
	jp le_da_al_jefe		;963b
golpe_jefe_5_g:
	ld a,e			;963e
	sub l			;963f   ; la diferencia en y...
	add a,01bh		;9640   ; ...corrida +27...
	cp 029h		;9642   ; ...cabe en la caja si va de -27 a 13
	jr nc,golpe_jefe_5_h		;9644   ; no cabe: fuera
	ld a,d			;9646
	sub h			;9647
	add a,00dh		;9648
	cp 01bh		;964a
	jp c,le_da_al_jefe		;964c
golpe_jefe_5_h:
	ld a,e			;964f
	sub l			;9650   ; la diferencia en y...
	add a,00ch		;9651   ; ...corrida +12...
	cp 019h		;9653   ; ...cabe en la caja si va de -12 a 12
	ret nc			;9655   ; no cabe: fuera
	ld a,d			;9656
	sub h			;9657
	dec a			;9658
	cp 01ch		;9659
	ret nc			;965b
	jp le_da_al_jefe		;965c
golpe_jefe_5_i:
	ld a,e			;965f
	sub l			;9660   ; la diferencia en y...
	add a,01bh		;9661   ; ...corrida +27...
	cp 029h		;9663   ; ...cabe en la caja si va de -27 a 13
	jr nc,golpe_jefe_5_j		;9665   ; no cabe: fuera
	ld a,d			;9667
	sub h			;9668
	add a,02dh		;9669
	cp 01bh		;966b
	jp c,le_da_al_jefe		;966d
golpe_jefe_5_j:
	ld a,e			;9670
	sub l			;9671   ; la diferencia en y...
	add a,00ch		;9672   ; ...corrida +12...
	cp 019h		;9674   ; ...cabe en la caja si va de -12 a 12
	ret nc			;9676   ; no cabe: fuera
	ld a,d			;9677
	sub h			;9678   ; la diferencia en x...
	add a,03ch		;9679   ; ...corrida +60...
	cp 01ch		;967b   ; ...cabe en la caja si va de -60 a -33
	ret nc			;967d   ; no cabe: fuera
	jp le_da_al_jefe		;967e
golpe_jefe_5_k:
	ld a,e			;9681
	sub l			;9682   ; la diferencia en y...
	add a,01bh		;9683   ; ...corrida +27...
	cp 029h		;9685   ; ...cabe en la caja si va de -27 a 13
	jr nc,golpe_jefe_5_l		;9687   ; no cabe: fuera
	ld a,d			;9689
	sub h			;968a
	add a,00dh		;968b
	cp 01bh		;968d
	jp c,le_da_al_jefe		;968f
golpe_jefe_5_l:
	ld a,e			;9692
	sub l			;9693   ; la diferencia en y...
	sub 004h		;9694   ; ...corrida -4...
	cp 019h		;9696   ; ...cabe en la caja si va de 4 a 28
	ret nc			;9698   ; no cabe: fuera
	ld a,d			;9699
	sub h			;969a   ; la diferencia en x...
	add a,005h		;969b   ; ...corrida +5...
	cp 01bh		;969d   ; ...cabe en la caja si va de -5 a 21
	ret nc			;969f   ; no cabe: fuera
	jp le_da_al_jefe		;96a0
golpe_jefe_5_m:
	ld a,e			;96a3
	sub l			;96a4   ; la diferencia en y...
	add a,01bh		;96a5   ; ...corrida +27...
	cp 029h		;96a7   ; ...cabe en la caja si va de -27 a 13
	jr nc,golpe_jefe_5_n		;96a9   ; no cabe: fuera
	ld a,d			;96ab
	sub h			;96ac
	add a,02dh		;96ad
	cp 01bh		;96af
	jp c,le_da_al_jefe		;96b1
golpe_jefe_5_n:
	ld a,e			;96b4
	sub l			;96b5   ; la diferencia en y...
	sub 004h		;96b6   ; ...corrida -4...
	cp 019h		;96b8   ; ...cabe en la caja si va de 4 a 28
	ret nc			;96ba   ; no cabe: fuera
	ld a,d			;96bb
	sub h			;96bc   ; la diferencia en x...
	add a,035h		;96bd   ; ...corrida +53...
	cp 01bh		;96bf   ; ...cabe en la caja si va de -53 a -27
	ret nc			;96c1   ; no cabe: fuera
	jp le_da_al_jefe		;96c2

; ----------------------------------------------------------------------
; Le da al jefe: efecto 2, su vida (D969) baja la fuerza del golpe (C); a 0,
; suma los puntos de su tipo (p07:9709). Marca el golpe (actor 0 +25 bit 7).
; ----------------------------------------------------------------------
le_da_al_jefe:
	push hl			;96c5
	ld hl,0d928h		;96c6   ; suceso del bit 6: efecto 2
	set 6,(hl)		;96c9
	ld hl,(0d969h)		;96cb   ; vida - fuerza
	ld b,000h		;96ce
	or a			;96d0
	sbc hl,bc		;96d1
	jr z,muere_jefe		;96d3   ; 0 o menos: muere
	jr nc,guarda_vida_jefe		;96d5
muere_jefe:
	ld a,(0d933h)		;96d7   ; su tipo 1-5...
	or a			;96da
	jr z,guarda_vida_jefe		;96db
	cp 006h		;96dd
	jr nc,guarda_vida_jefe		;96df
	push bc			;96e1
	ld l,a			;96e2   ; ...* 2 + p07:9707...
	ld h,000h		;96e3
	add hl,hl			;96e5
	ld de,l9707h		;96e6
	add hl,de			;96e9
	ld e,(hl)			;96ea
	inc hl			;96eb
	ld d,(hl)			;96ec
	ld bc,00000h		;96ed   ; ...sus puntos, sumados
	call suma_puntos		;96f0
	pop bc			;96f3
	ld hl,00000h		;96f4   ; vida 0
guarda_vida_jefe:
	ld (0d969h),hl		;96f7   ; la vida que le queda
	ld a,001h		;96fa   ; D96B = 1
	ld (0d96bh),a		;96fc   ; actor 1, byte +12 = a
	ld a,(0d958h)		;96ff   ; marcado: este golpe ya le dio
	set 7,a		;9702
	ld (0d958h),a		;9704   ; actor 0, byte +25 = a
L_9707:
	pop hl			;9707
	ret			;9708

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9709..0xa000  (2295 bytes)
DATA_9709:
	defb 000h,005h,000h,010h,000h,015h,000h,020h,000h,025h,000h,030h,0ffh,0ffh,0ffh,0ffh	; 9709  ....... .%.0....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9719  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9729  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9739  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9749  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9759  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9769  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9779  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9789  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9799  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97a9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97b9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97c9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97d9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97e9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 97f9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9809  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9819  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9829  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9839  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9849  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9859  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9869  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9879  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9889  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9899  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98a9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98b9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98c9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98d9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98e9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 98f9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9909  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9919  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9929  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9939  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9949  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9959  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9969  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9979  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9989  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9999  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99a9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99b9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99c9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99d9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99e9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 99f9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9a99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9aa9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ab9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ac9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ad9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ae9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9af9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9b99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ba9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9be9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9bf9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9c99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ca9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ce9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9cf9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9d99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9da9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9db9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9dd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9de9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9df9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9e99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ea9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9eb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ec9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ed9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ee9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ef9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9f99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fa9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9fe9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 9ff9
