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
; CODIGO 0x4011..0x4206  (501 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; INIT: limpia la RAM, desactiva los ganchos de la BIOS, pone los bancos 0/1/2,
; inicializa video y sonido (p01), arranca la tarea 0 y se queda esperando: a
; partir de aqui TODO el juego corre dentro de la interrupcion (p00:406C).
; ----------------------------------------------------------------------
init:
	di			;4011   ; sin interrupciones mientras se prepara todo
	im 1		;4012   ; modo 1: la interrupcion va a 0x0038 y de ahi a H.TIMI
	ld hl,0c000h		;4014   ; borra C000-F37F (13184 bytes) con ldir
	ld bc,03380h		;4017
	ld de,0c001h		;401a   ; de -> contador de la tarea 1
	xor a			;401d   ; el byte de partida es 0
	ld (hl),a			;401e
	ldir		;401f
	ld sp,0f380h		;4021   ; la pila arriba del todo de la RAM del juego
	ld a,0c9h		;4024   ; 0xC9 = ret: anula los ganchos H.TIMI (FD9A), FD9B-FD9C y FD9F-FDA1
	ld (0fd9ah),a		;4026
	ld (0fd9bh),a		;4029
	ld (0fd9ch),a		;402c
	ld (0fd9fh),a		;402f
	ld (0fda0h),a		;4032
	ld (0fda1h),a		;4035
	ld a,000h		;4038   ; banco 0 en 0x4000 (y su copia en D18F)
	ld (0d18fh),a		;403a   ; copia del registro del mapper de 0x4000 = a
	ld (067f8h),a		;403d   ; registro del mapper: banco A en 0x4000
	ld a,001h		;4040   ; banco 1 en 0x6000 (copia en D190)
	ld (0d190h),a		;4042   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4045   ; registro del mapper: banco A en 0x6000
	ld a,002h		;4048   ; banco 2 en 0x8000 (copia en D191)
	ld (0d191h),a		;404a   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;404d   ; registro del mapper: banco A en 0x8000
	call 06000h		;4050   ; p01:6000, p01:6020 y p01:6077: preparan el VDP y el sonido
	call 06020h		;4053
	call 06077h		;4056
	ld a,000h		;4059   ; tarea 0 = p00:4E14 (la tabla de p00:429A)
	call crea_tarea		;405b
	ld a,0c3h		;405e   ; H.TIMI = jp 0x406C: la interrupcion pasa a ser el motor del juego
	ld (0fd9ah),a		;4060
	ld hl,interrupcion		;4063
	ld (0fd9bh),hl		;4066
	ei			;4069   ; ya con interrupciones...
L_406A:
	jr L_406A		;406a   ; ...espera para siempre: el resto lo hacen las tareas

; ----------------------------------------------------------------------
; INTERRUPCION (H.TIMI). Guarda todos los registros, mira si es el retrazo
; vertical y, si lo es: musica (bancos 1 y 2), cinco contadores de cuadros,
; sprites y paleta al VDP, y un turno del planificador de tareas.
; ----------------------------------------------------------------------
interrupcion:
	push af			;406c   ; guarda los registros normales...
	push bc			;406d
	push de			;406e
	push hl			;406f
	push ix		;4070
	push iy		;4072
	ex af,af'			;4074   ; ...y los alternativos
	exx			;4075
	push af			;4076
	push bc			;4077
	push de			;4078
	push hl			;4079
	ex af,af'			;407a
	exx			;407b
	ld bc,(00006h)		;407c   ; puerto de escritura del VDP (BIOS 0x0007, +1 = puerto de registros)
	inc c			;4080
	ld a,000h		;4081   ; R#15 = 0: el siguiente `in` lee el registro de estado S#0
	out (c),a		;4083
	ld a,08fh		;4085
	out (c),a		;4087
	in b,(c)		;4089   ; B = S#0
	ld a,000h		;408b   ; y vuelve a dejar R#15 = 0 (lo que espera la BIOS)
	out (c),a		;408d
	ld a,08fh		;408f
	out (c),a		;4091
	bit 7,b		;4093   ; bit 7 de S#0: interrupcion de retrazo vertical
	jp z,L_412D		;4095   ; si no lo es (otra interrupcion del V9938), sale sin hacer nada
	ld a,001h		;4098   ; bancos 1 y 2 en 0x6000/0x8000 SIN tocar la copia: el sonido vive ahi
	ld (06ff8h),a		;409a   ; registro del mapper: banco A en 0x6000
	inc a			;409d
	ld (077f8h),a		;409e   ; registro del mapper: banco A en 0x8000
	call 06153h		;40a1   ; p01:6153: un paso de la musica y los efectos
	call arranca_sonidos		;40a4   ; arranca las peticiones de sonido pendientes
	ld a,(0d190h)		;40a7   ; devuelve los bancos que tenia la tarea interrumpida, leidos de la copia
	ld (06ff8h),a		;40aa   ; registro del mapper: banco A en 0x6000
	ld a,(0d191h)		;40ad   ; a = copia del registro del mapper de 0x8000
	ld (077f8h),a		;40b0   ; registro del mapper: banco A en 0x8000
	ld hl,04000h		;40b3   ; HL = 0x4000 + SP: si SP ha bajado de 0xC000 hay acarreo...
	adc hl,sp		;40b6
	jp nc,pila_desbordada		;40b8   ; ...y si no, la pila se ha desbordado: se cuelga a proposito (p00:413E)
	ld ix,0d17eh		;40bb   ; cinco contadores de 16 bits en D17E-D187, +1 cada cuadro
	ld l,(ix+000h)		;40bf
	ld h,(ix+001h)		;40c2
	inc hl			;40c5   ; primer contador +1
	ld (ix+000h),l		;40c6
	ld (ix+001h),h		;40c9
	inc ix		;40cc
	inc ix		;40ce
	ld l,(ix+000h)		;40d0
	ld h,(ix+001h)		;40d3
	inc hl			;40d6   ; segundo
	ld (ix+000h),l		;40d7
	ld (ix+001h),h		;40da
	inc ix		;40dd
	inc ix		;40df
	ld l,(ix+000h)		;40e1
	ld h,(ix+001h)		;40e4
	inc hl			;40e7   ; tercero
	ld (ix+000h),l		;40e8
	ld (ix+001h),h		;40eb
	inc ix		;40ee
	inc ix		;40f0
	ld l,(ix+000h)		;40f2
	ld h,(ix+001h)		;40f5
	inc hl			;40f8   ; cuarto
	ld (ix+000h),l		;40f9
	ld (ix+001h),h		;40fc
	inc ix		;40ff
	inc ix		;4101
	ld l,(ix+000h)		;4103
	ld h,(ix+001h)		;4106
	inc hl			;4109   ; quinto
	ld (ix+000h),l		;410a
	ld (ix+001h),h		;410d
	inc ix		;4110
	inc ix		;4112
	ld a,(0d032h)		;4114   ; D032 = "ya estoy dentro": si el cuadro anterior no acabo...
	and a			;4117
	jp nz,L_412D		;4118   ; ...este se salta el trabajo (no se reentra)
	ld a,0ffh		;411b   ; marca que se esta dentro
	ld (0d032h),a		;411d   ; 1 mientras la interrupcion hace el trabajo del cuadro = a
	call sprites_a_vram		;4120   ; sprites de RAM a VRAM, rotando cual va primero
	call copia_franja		;4123   ; copia una franja de 256x8 de la pagina 1 (p00:41D9)
	call planificador		;4126   ; un turno del planificador: corre las tareas que toque
	xor a			;4129   ; trabajo del cuadro hecho
	ld (0d032h),a		;412a   ; 1 mientras la interrupcion hace el trabajo del cuadro = a
L_412D:
	ex af,af'			;412d   ; devuelve los registros alternativos...
	exx			;412e
	pop hl			;412f
	pop de			;4130
	pop bc			;4131
	pop af			;4132
	ex af,af'			;4133
	exx			;4134
	pop iy		;4135   ; ...y los normales
	pop ix		;4137
	pop hl			;4139
	pop de			;413a
	pop bc			;413b
	pop af			;413c
	ret			;413d   ; vuelve a la BIOS, que acaba la interrupcion
pila_desbordada:
	di			;413e   ; sin interrupciones y bucle infinito: el juego se para aqui
	jr pila_desbordada		;413f
arranca_sonidos:
	ld a,(0d17ah)		;4141   ; D17A: efecto pedido (0xFF = ninguno)
	cp 0ffh		;4144
	jr z,L_4150		;4146
	call 0640fh		;4148   ; p01:640F lo arranca...
	ld a,0ffh		;414b   ; ...y se borra la peticion
	ld (0d17ah),a		;414d   ; musica pedida, para p01:640F = a
L_4150:
	ld a,(0d178h)		;4150   ; D178: musica pedida (0xFF = ninguna)
	cp 0ffh		;4153
	jr z,L_415F		;4155
	call 063e1h		;4157   ; p01:63E1 la arranca...
	ld a,0ffh		;415a   ; ...y se borra la peticion
	ld (0d178h),a		;415c   ; efecto pedido, para p01:63E1 = a
L_415F:
	ret			;415f

; ----------------------------------------------------------------------
; Los 32 sprites de RAM al VDP. La tabla de atributos (D193, 4 bytes por
; sprite) va a VRAM 0x8600 y la de colores (D213, 16 bytes por sprite) a
; 0x8400. Cada cuadro se empieza por un sprite distinto (+14 de 32): asi,
; cuando hay mas de 8 en una linea, el que no se ve no es siempre el mismo y
; parpadean en vez de desaparecer.
; ----------------------------------------------------------------------
sprites_a_vram:
	ld hl,0d18ch		;4160   ; D18C: el primer sprite de este cuadro
	ld a,(hl)			;4163
	add a,00eh		;4164   ; avanza 14...
	cp 020h		;4166   ; ...modulo 32
	jr c,L_416C		;4168
	sub 020h		;416a
L_416C:
	ld (hl),a			;416c
	add a,a			;416d   ; A = primer sprite * 4 (bytes de atributos)
	add a,a			;416e
	ld c,a			;416f
	ld l,a			;4170
	ld h,000h		;4171
	ld de,0d193h		;4173   ; HL = D193 + primer*4
	add hl,de			;4176
	ex af,af'			;4177   ; se guarda primer*4 en A'
	ld a,080h		;4178   ; BC = 128 - primer*4: lo que va desde el primero hasta el final
	sub c			;417a
	ld c,a			;417b
	ld b,000h		;417c
	ld (0d18dh),bc		;417e   ; apuntado en D18D
	ld de,08600h		;4182   ; a VRAM 0x8600, el principio de la tabla de atributos
	call 0005ch		;4185   ; BIOS LDIRVM - Block transfers to VRAM from memory | copia la primera parte
	ex af,af'			;4188
	ld c,a			;4189
	ex af,af'			;418a
	dec c			;418b   ; si el primero era el 0, ya esta
	inc c			;418c
	jr z,L_41A0		;418d
	ld b,000h		;418f
	ld hl,08600h		;4191   ; DE = 0x8600 + lo ya copiado
	ld de,(0d18dh)		;4194   ; de = bytes ya copiados a VRAM, de paso
	add hl,de			;4198
	ex de,hl			;4199
	ld hl,0d193h		;419a   ; y el resto desde el principio de D193
	call 0005ch		;419d   ; BIOS LDIRVM - Block transfers to VRAM from memory | copia la segunda parte
L_41A0:
	ex af,af'			;41a0   ; ahora los colores: E = primer*4
	ld e,a			;41a1
	ex af,af'			;41a2
	ld a,080h		;41a3   ; (128 - primer*4) * 4 = (32 - primer) * 16 bytes
	sub e			;41a5
	ld l,a			;41a6
	ld h,000h		;41a7
	add hl,hl			;41a9
	add hl,hl			;41aa
	ld c,l			;41ab
	ld b,h			;41ac
	ld (0d18dh),hl		;41ad   ; bytes ya copiados a VRAM, de paso = hl
	ld h,000h		;41b0   ; HL = D213 + primer*16
	ld l,e			;41b2
	add hl,hl			;41b3
	add hl,hl			;41b4
	ld de,0d213h		;41b5   ; de -> los colores de los 32 sprites
	add hl,de			;41b8
	ld de,08400h		;41b9   ; a VRAM 0x8400, la tabla de colores de los sprites
	call 0005ch		;41bc   ; BIOS LDIRVM - Block transfers to VRAM from memory | primera parte
	ex af,af'			;41bf   ; si el primero era el 0, ya esta
	or a			;41c0
	ret z			;41c1
	ld l,a			;41c2   ; primer*16 bytes...
	ld h,000h		;41c3
	add hl,hl			;41c5
	add hl,hl			;41c6
	ld c,l			;41c7
	ld b,h			;41c8
	ld hl,08400h		;41c9   ; ...detras de lo ya copiado...
	ld de,(0d18dh)		;41cc   ; de = bytes ya copiados a VRAM, de paso
	add hl,de			;41d0
	ex de,hl			;41d1
	ld hl,0d213h		;41d2   ; ...desde el principio de D213
	call 0005ch		;41d5   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;41d8
copia_franja:
	ld hl,04000h		;41d9   ; origen x=0 y=64, destino x=0 y=16...
	ld bc,01000h		;41dc
	ld de,008ffh		;41df   ; ...256 x 8 pixeles...
	ld a,001h		;41e2   ; ...los dos en la pagina 1
	ex af,af'			;41e4
	ld a,001h		;41e5
	ex af,af'			;41e7
	call copia_bloque		;41e8   ; HMMM
	ret			;41eb
huerfana_vdp_r32:
	call espera_vdp		;41ec   ; nadie la llama: espera a que el VDP acabe el comando anterior...
	ld bc,(00007h)		;41ef   ; ...y apunta a R#32 con autoincremento (R#17 = 0x20)
	inc c			;41f3
	ld a,020h		;41f4
	out (c),a		;41f6
	ld a,091h		;41f8
	out (c),a		;41fa
	inc c			;41fc
	inc c			;41fd
	ld b,00fh		;41fe   ; 15 registros de comando (R#32-R#46) desde p00:4206
	ld hl,04206h		;4200
	otir		;4203   ; los manda por el puerto 3 del VDP
	ret			;4205

; ----------------------------------------------------------------------
; DATOS comando_vdp: Los 15 registros de un comando del VDP (R#32-R#46) que
;   vuelca p00:41EC; nadie lo usa
;   0x4206..0x4215  (15 bytes)
DATA_comando_vdp:
	defb 000h,000h,040h,001h,000h,000h,010h,001h,000h,001h,008h,000h,000h,000h,00dh	; 4206  ..@............

; ======================================================================
; CODIGO 0x4215..0x429a  (133 bytes)
; ======================================================================


huerfana_tarea_on:
	push hl			;4215   ; nadie la llama: pone a 1 el contador de la tarea A (C000+A)
	ld h,0c0h		;4216
	ld l,a			;4218
	ld (hl),001h		;4219
	pop hl			;421b
	ret			;421c
apaga_tareas:
	ld hl,0c000h		;421d   ; los 16 contadores C000-C00F a 0: ninguna tarea corre
	ld b,010h		;4220
L_4222:
	ld (hl),000h		;4222
	inc hl			;4224
	djnz L_4222		;4225
	ret			;4227

; ----------------------------------------------------------------------
; EL PLANIFICADOR. Hay 16 tareas; la i tiene su contador en C000+i (0 =
; parada, n = corre dentro de n cuadros), su SP guardado en C010+2i y su pila
; de 256 bytes por debajo de C12E+256i. Una tarea cede con p00:4255 (vuelve al
; cuadro siguiente) o p00:4257 (dentro de A cuadros), y la interrupcion la
; retoma donde se quedo con `ld sp,hl / ret`.
; ----------------------------------------------------------------------
crea_tarea:
	ld l,a			;4228   ; C000+A = 1: la tarea A corre en el proximo cuadro
	ld h,0c0h		;4229
	ld (hl),001h		;422b
	ld d,a			;422d   ; DE = C12E + A*256: la cima de su pila
	ld e,000h		;422e
	ld hl,0c12eh		;4230
	add hl,de			;4233
	ex de,hl			;4234
	ld a,h			;4235   ; H = A (el numero de tarea, tras el ex de,hl)
	add a,a			;4236   ; C = 2A, el desplazamiento en las tablas de palabras
	ld c,a			;4237
	add a,010h		;4238   ; HL = C010 + 2A: donde se guarda su SP
	ld l,a			;423a
	ld h,0c0h		;423b
	ld (hl),e			;423d   ; su SP = la cima de su pila
	inc hl			;423e
	ld (hl),d			;423f
	ld hl,0429ah		;4240   ; la direccion de arranque de la tarea, de la tabla p00:429A
	ld b,000h		;4243
	add hl,bc			;4245
	ld c,(hl)			;4246
	inc hl			;4247
	ld b,(hl)			;4248
	ex de,hl			;4249
	ld (hl),c			;424a   ; se deja en la cima de su pila: el primer `ret` del planificador salta ahi
	inc hl			;424b
	ld (hl),b			;424c
	ret			;424d
para_tarea_y_cede:
	push hl			;424e   ; C000+A = 0: la tarea A ya no corre...
	ld h,0c0h		;424f
	ld l,a			;4251
	ld (hl),000h		;4252
	pop hl			;4254   ; ...y la que llama cede su turno
cede:
	ld a,001h		;4255   ; vuelve en el cuadro siguiente
duerme:
	ld hl,(0d030h)		;4257   ; D030 apunta al contador de la tarea que corre...
	ld (hl),a			;425a   ; ...que vale A: dentro de A cuadros vuelve a correr
	ld a,l			;425b   ; HL = C010 + 2*tarea
	add a,a			;425c
	add a,010h		;425d
	ld l,a			;425f
	ld (0d063h),sp		;4260   ; su SP (con la vuelta de este call encima)...
	ld de,(0d063h)		;4264   ; de = el SP de la tarea que cede, de paso
	ld (hl),e			;4268   ; ...queda guardado para retomarla
	inc hl			;4269
	ld (hl),d			;426a
	jp siguiente_tarea		;426b   ; y el planificador sigue con la tarea siguiente
planificador:
	ld hl,0c000h		;426e   ; HL recorre los 16 contadores
	ld (0d065h),sp		;4271   ; el SP de la interrupcion, para volver a el al final
L_4275:
	ld a,(hl)			;4275   ; contador 0: tarea parada, se salta
	or a			;4276
	jp z,L_428E		;4277
	dec (hl)			;427a   ; uno menos; si no llega a 0, aun no le toca
	jr nz,L_428E		;427b
	ld (0d030h),hl		;427d   ; le toca: D030 = su contador
	ld a,l			;4280   ; HL = C010 + 2*tarea
	add a,a			;4281
	add a,010h		;4282
	ld l,a			;4284
	ld e,(hl)			;4285   ; su SP guardado...
	inc hl			;4286
	ld d,(hl)			;4287
	ex de,hl			;4288
	ld sp,hl			;4289   ; ...y `ret` la retoma justo detras de su ultimo `call 4255/4257`
	ret			;428a
siguiente_tarea:
	ld hl,(0d030h)		;428b   ; la que acaba de ceder
L_428E:
	inc l			;428e   ; la siguiente...
	ld a,l			;428f
	cp 010h		;4290   ; ...hasta la 15
	jp nz,L_4275		;4292
	ld sp,(0d065h)		;4295   ; todas vistas: vuelve a la pila de la interrupcion
	ret			;4299

; ----------------------------------------------------------------------
; DATOS arranque_tareas: Direccion de arranque de cada tarea (16 palabras;
;   solo las 5 primeras usadas: 4E14 524F 56F2 5760 5799)
;   0x429a..0x42ba  (32 bytes)
DATA_arranque_tareas:
	defw 04e14h,0524fh,056f2h,05760h,05799h,00000h,00000h,00000h	; 429a
	defw 00000h,00000h,00000h,00000h,00000h,00000h,00000h,00000h	; 42aa

; ======================================================================
; CODIGO 0x42ba..0x45ec  (818 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Los mandos, a D573: bit 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4
; boton 1 (ESPACIO, CAPS o gatillo A del joystick) y 5 boton 2 (GRAPH o
; gatillo B). Teclado y joystick del puerto 1 se suman.
; ----------------------------------------------------------------------
lee_mandos:
	call lee_joystick		;42ba   ; el joystick, ya con los bits del juego...
	ld b,a			;42bd   ; ...en B
	push bc			;42be
	ld a,008h		;42bf   ; fila 8 del teclado: espacio y cursores (0 = pulsada)
	call 00141h		;42c1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	pop bc			;42c4
	bit 0,a		;42c5   ; ESPACIO -> boton 1
	jr nz,L_42CB		;42c7
	set 4,b		;42c9
L_42CB:
	bit 7,a		;42cb   ; derecha -> bit 3
	jr nz,L_42D1		;42cd
	set 3,b		;42cf
L_42D1:
	bit 4,a		;42d1   ; izquierda -> bit 2
	jr nz,L_42D7		;42d3
	set 2,b		;42d5
L_42D7:
	bit 6,a		;42d7   ; abajo -> bit 1
	jr nz,L_42DD		;42d9
	set 1,b		;42db
L_42DD:
	bit 5,a		;42dd   ; arriba -> bit 0
	jr nz,L_42E3		;42df
	set 0,b		;42e1
L_42E3:
	bit 0,a		;42e3   ; (ESPACIO otra vez, repetido)
	jr nz,L_42E9		;42e5
	set 4,b		;42e7
L_42E9:
	push bc			;42e9
	ld a,006h		;42ea   ; fila 6: SHIFT, CTRL, GRAPH, CAPS, CODE
	call 00141h		;42ec   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	pop bc			;42ef
	bit 3,a		;42f0   ; CAPS -> boton 1
	jr nz,L_42F6		;42f2
	set 4,b		;42f4
L_42F6:
	bit 2,a		;42f6   ; GRAPH -> boton 2
	jr nz,L_42FC		;42f8
	set 5,b		;42fa
L_42FC:
	ld a,b			;42fc   ; el resultado, para todo el juego
	ld (0d573h),a		;42fd   ; los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2 = a
	ret			;4300
lee_joystick:
	di			;4301   ; R#15 del PSG = 0x8F: puerto de joystick 1 y salidas en alto
	ld e,08fh		;4302
	ld a,00fh		;4304
	call 00093h		;4306   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4309   ; R#14: las patas del joystick (0 = pulsada)
	call 00096h		;430b   ; BIOS RDPSG - Reads value from PSG-register
	cpl			;430e   ; invertidas: 1 = pulsada; bits 0-3 direcciones, 4-5 gatillos
	and 03fh		;430f
	ei			;4311
	ret			;4312
multiplica_h_por_e:
	ld l,000h		;4313   ; nadie la llama: HL = H * E, por sumas y desplazamientos
	ld d,l			;4315
	ld b,008h		;4316   ; ocho bits
L_4318:
	add hl,hl			;4318   ; HL*2; si salia un 1 de H...
	jr nc,L_431C		;4319
	add hl,de			;431b   ; ...se suma E
L_431C:
	djnz L_4318		;431c
	ret			;431e
borra_vram:
	call 00041h		;431f   ; BIOS DISSCR - Inhibits the screen display | pantalla apagada mientras...
	di			;4322
	ld hl,00000h		;4323   ; ...se llenan de 0 los primeros 32 KB de VRAM
	ld bc,07fffh		;4326
	xor a			;4329
	call 0016bh		;432a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
	ei			;432d
	call 00044h		;432e   ; BIOS ENASCR - Displays the screen | pantalla encendida
	ret			;4331

; ----------------------------------------------------------------------
; Huerfana: un rectangulo de bytes de la CPU a la VRAM con el comando HMMC
; del V9938. HL = esquina de destino, DE = la otra esquina, A' = pagina, IX =
; los bytes.
; ----------------------------------------------------------------------
huerfana_hmmc:
	di			;4332   ; espera al VDP
	call espera_vdp		;4333
	ld a,(00007h)		;4336   ; R#17 = 36 con autoincremento: DX, DY, NX, NY, CLR, ARG, CMD
	ld c,a			;4339
	inc c			;433a
	ld a,024h		;433b
	out (c),a		;433d
	ld a,091h		;433f
	out (c),a		;4341
	inc c			;4343
	inc c			;4344
	xor a			;4345
	out (c),l		;4346   ; DX = L
	out (c),a		;4348
	out (c),h		;434a   ; DY = H, pagina A'
	ex af,af'			;434c
	out (c),a		;434d
	ex af,af'			;434f
	ld a,h			;4350   ; ancho: |H - D|, y el sentido en D (DIY)...
	sub d			;4351
	ld d,008h		;4352
	jp nc,L_435B		;4354
	ld d,000h		;4357
	neg		;4359
L_435B:
	ld h,a			;435b
	ld a,l			;435c   ; ...alto: |L - E|, y el sentido en E (DIX)
	sub e			;435d
	ld e,004h		;435e
	jp nc,L_4367		;4360
	ld e,000h		;4363
	neg		;4365
L_4367:
	ld l,a			;4367
	inc h			;4368   ; los dos +1
	inc l			;4369
	xor a			;436a
	out (c),l		;436b   ; NX y NY
	out (c),a		;436d
	out (c),h		;436f
	out (c),a		;4371
	ld h,(ix+000h)		;4373   ; CLR = el primer byte
	out (c),h		;4376
	ld a,d			;4378   ; ARG = los dos sentidos
	or e			;4379
	out (c),a		;437a
	ld a,0f0h		;437c   ; CMD 0xF0 = HMMC
	out (c),a		;437e
	ld a,(00007h)		;4380   ; R#17 = 44 sin autoincremento: los demas bytes van todos a CLR
	ld c,a			;4383
	inc c			;4384
	ld a,0ach		;4385
	out (c),a		;4387
	ld a,091h		;4389
	out (c),a		;438b
	inc c			;438d
	inc c			;438e
L_438F:
	ld a,002h		;438f   ; S#2: CE (bit 0) = aun trabajando, TR (bit 7) = quiere otro byte
	call lee_estado_vdp		;4391
	bit 0,a		;4394   ; acabado
	jp z,L_43A8		;4396
	bit 7,a		;4399   ; aun no lo quiere
	jp z,L_438F		;439b
	inc ix		;439e   ; el siguiente byte
	ld a,(ix+000h)		;43a0
	out (c),a		;43a3
	jp L_438F		;43a5
L_43A8:
	ld a,000h		;43a8   ; R#15 = 0 otra vez
	call lee_estado_vdp		;43aa
	ei			;43ad
	ret			;43ae

; ----------------------------------------------------------------------
; Copia un rectangulo de VRAM a VRAM con HMMM: HL = origen (pagina A), DE =
; la esquina opuesta, la pila trae el destino y A' su pagina.
; ----------------------------------------------------------------------
copia_vram_vram:
	di			;43af
	push bc			;43b0
	push af			;43b1
	call espera_vdp		;43b2   ; espera al VDP
	ld bc,(00007h)		;43b5
	inc c			;43b9
	pop af			;43ba
	ld b,a			;43bb
	ld a,020h		;43bc   ; R#17 = 32 con autoincremento: SX, SY, DX, DY...
	out (c),a		;43be
	ld a,091h		;43c0
	out (c),a		;43c2
	inc c			;43c4
	inc c			;43c5
	out (c),l		;43c6   ; SX = L, SY = H, pagina B
	xor a			;43c8
	out (c),a		;43c9
	out (c),h		;43cb
	out (c),b		;43cd
	ld a,h			;43cf   ; ancho y sentido, como en p00:4332
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
	out (c),e		;43ec   ; DX, DY y pagina A'
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
	ld a,0d0h		;4408   ; CMD 0xD0 = HMMM
	out (c),a		;440a
	ei			;440c
	ret			;440d
rellena_vram:
	di			;440e   ; rellena un rectangulo con el byte A (HMMV): DE..HL las esquinas
	ex de,hl			;440f
	push af			;4410
	call espera_vdp		;4411
	ld bc,(00007h)		;4414
	inc c			;4418
	pop af			;4419
	ld b,a			;441a
	ld a,024h		;441b   ; R#17 = 36: DX, DY, NX, NY, CLR...
	out (c),a		;441d
	ld a,091h		;441f
	out (c),a		;4421
	inc c			;4423
	inc c			;4424
	or a			;4425
	sbc hl,de		;4426   ; NX, NY = HL - DE + 1
	inc h			;4428
	inc l			;4429
	xor a			;442a
	out (c),d		;442b   ; DX = D, DY = E (pagina 0)
	out (c),a		;442d
	out (c),e		;442f
	out (c),a		;4431
	out (c),h		;4433   ; NX = H, NY = L
	out (c),a		;4435
	out (c),l		;4437
	out (c),a		;4439
	out (c),b		;443b   ; CLR = el byte de relleno
	out (c),a		;443d
	ld a,0c0h		;443f   ; CMD 0xC0 = HMMV
	out (c),a		;4441
	ei			;4443
	ret			;4444
lee_estado_vdp:
	push bc			;4445   ; R#15 = A...
	ld bc,(00006h)		;4446
	inc c			;444a
	out (c),a		;444b
	ld a,08fh		;444d
	out (c),a		;444f
	in b,(c)		;4451   ; ...B = S#A...
	xor a			;4453   ; ...y R#15 = 0 otra vez
	out (c),a		;4454
	ld a,08fh		;4456
	out (c),a		;4458
	ld a,b			;445a
	pop bc			;445b
	ret			;445c
espera_vdp:
	ld a,002h		;445d   ; S#2 bit 0 (CE): el comando anterior aun no ha acabado
	call lee_estado_vdp		;445f
	and 001h		;4462
	jp nz,espera_vdp		;4464
	xor a			;4467   ; R#15 = 0
	call lee_estado_vdp		;4468
	ret			;446b

; ----------------------------------------------------------------------
; La paleta: copia los 32 bytes de HL a D5B4 y los manda al VDP (R#16 = 0 y
; luego dos bytes por color al puerto 2).
; ----------------------------------------------------------------------
pon_paleta:
	ld de,0d5b4h		;446c   ; copia en D5B4
	ld bc,00020h		;446f
	ldir		;4472
	ld hl,0d5b4h		;4474   ; hl -> la paleta puesta: 16 colores x 2 bytes
	di			;4477
	call espera_vdp		;4478   ; espera al VDP
	ld b,000h		;447b
	ld a,(00007h)		;447d   ; puerto de registros
	inc a			;4480
	ld c,a			;4481
	ld a,b			;4482   ; R#16 = 0: empieza por el color 0
	out (c),a		;4483
	ld a,090h		;4485
	out (c),a		;4487
	inc c			;4489   ; puerto 2, el de la paleta
L_448A:
	ld a,(hl)			;448a   ; rojo y azul...
	out (c),a		;448b
	inc hl			;448d
	ld a,(hl)			;448e   ; ...y verde
	out (c),a		;448f
	inc hl			;4491
	inc b			;4492   ; 16 colores
	ld a,b			;4493
	cp 010h		;4494
	jp nz,L_448A		;4496
	ei			;4499
	ret			;449a

; ----------------------------------------------------------------------
; Huerfana: un fundido. Los 48 componentes de D574 (16 colores x R,G,B) se
; acercan un paso a los de DE, y los colores marcados en D5A4 se mandan con
; p00:4445... que no escribe la paleta sino que lee un estado: sin terminar.
; ----------------------------------------------------------------------
huerfana_fundido:
	ld b,030h		;449b
	ld hl,0d574h		;449d   ; hl -> 48 componentes de color del fundido
L_44A0:
	ld a,(de)			;44a0   ; si aun no ha llegado...
	cp (hl)			;44a1
	jr z,L_44A5		;44a2
	inc (hl)			;44a4   ; ...un paso mas
L_44A5:
	inc hl			;44a5
	inc de			;44a6
	djnz L_44A0		;44a7
	jr L_44AB		;44a9
L_44AB:
	ld hl,0d574h		;44ab   ; hl -> 48 componentes de color del fundido
	ld de,0d5a4h		;44ae   ; de -> 16 marcas de color cambiado del fundido
	ld b,010h		;44b1
L_44B3:
	ld a,(de)			;44b3   ; color marcado en D5A4?
	and a			;44b4
	jp z,L_44D7		;44b5
	inc de			;44b8
	push de			;44b9
	ld a,(hl)			;44ba   ; rojo en el nibble alto...
	inc hl			;44bb
	sla a		;44bc
	sla a		;44be
	sla a		;44c0
	sla a		;44c2
	ld c,a			;44c4
	ld a,(hl)			;44c5   ; ...con el verde: D
	inc hl			;44c6
	or c			;44c7
	ld d,a			;44c8
	ld a,(hl)			;44c9   ; azul: E
	inc hl			;44ca
	ld e,a			;44cb
	push bc			;44cc
	ld a,b			;44cd
	dec a			;44ce
	call lee_estado_vdp		;44cf   ; A = numero de color: aqui haria falta escribir la paleta
	pop bc			;44d2
	pop de			;44d3
L_44D4:
	djnz L_44B3		;44d4
	ret			;44d6
L_44D7:
	inc hl			;44d7
	inc hl			;44d8
	inc hl			;44d9
	inc de			;44da
	jp L_44D4		;44db
azar:
	push de			;44de   ; semilla en D5D4
	ld hl,(0d5d4h)		;44df   ; hl = la semilla del azar
	ex de,hl			;44e2
	add hl,hl			;44e3   ; semilla * 9 + 1
	add hl,hl			;44e4
	add hl,hl			;44e5
	add hl,de			;44e6
	inc hl			;44e7
	ld a,r		;44e8   ; este `ld a,r / xor l` no sirve: A se pisa mas abajo
	xor l			;44ea
	ld (0d5d4h),hl		;44eb   ; nueva semilla
	ld a,h			;44ee   ; devuelve el byte alto
	pop de			;44ef
	ret			;44f0

; ----------------------------------------------------------------------
; Copia un rectangulo de VRAM a VRAM (HMMM): HL = origen y A su pagina, BC
; (por la pila) = destino y A' su pagina, E+1 = ancho, D = alto.
; ----------------------------------------------------------------------
copia_bloque:
	di			;44f1
	push bc			;44f2
	push af			;44f3
	call espera_vdp		;44f4   ; espera al VDP
	ld bc,(00007h)		;44f7
	inc c			;44fb
	pop af			;44fc
	ld b,a			;44fd
	ld a,020h		;44fe   ; R#17 = 32 con autoincremento
	out (c),a		;4500
	ld a,091h		;4502
	out (c),a		;4504
	inc c			;4506
	inc c			;4507
	out (c),l		;4508   ; SX = L, SY = H, pagina B (la A de entrada)
	xor a			;450a
	out (c),a		;450b
	out (c),h		;450d
	out (c),b		;450f
	pop hl			;4511   ; el destino
	out (c),l		;4512   ; DX = L, DY = H, pagina A'
	out (c),a		;4514
	out (c),h		;4516
	ex af,af'			;4518
	out (c),a		;4519
	ex af,af'			;451b
	push de			;451c   ; NX = E + 1 (hasta 256)
	ld d,000h		;451d
	inc de			;451f
	out (c),e		;4520
	out (c),d		;4522
	pop de			;4524
	xor a			;4525
	out (c),d		;4526   ; NY = D
	out (c),a		;4528
	out (c),a		;452a
	out (c),a		;452c
	ld a,0d0h		;452e   ; CMD 0xD0 = HMMM
	out (c),a		;4530
	ei			;4532
	ret			;4533

; ----------------------------------------------------------------------
; Los patrones de un sprite a VRAM, solo si han cambiado. IX = ficha de
; sprite: +0/1 patron que toca, +4/5 el ultimo cargado, +8 juego de graficos
; (bits 7-6 = bancos), +9 sprite, +0A sitio en la tabla de patrones.
; ----------------------------------------------------------------------
carga_patron_sprite:
	ld h,(ix+001h)		;4534   ; el patron que toca...
	ld l,(ix+000h)		;4537
	push hl			;453a
	ld d,(ix+005h)		;453b   ; ...contra el que ya hay
	ld e,(ix+004h)		;453e
	xor a			;4541
	sbc hl,de		;4542
	ld a,h			;4544
	or l			;4545
	pop hl			;4546
	jp z,L_45EB		;4547   ; el mismo: nada que hacer
	ld (ix+005h),h		;454a   ; apunta el nuevo
	ld (ix+004h),l		;454d
	ld a,h			;4550   ; 0xFFFF = ninguno
	and l			;4551
	inc a			;4552
	jp z,L_45EB		;4553
	push hl			;4556
	ld a,(ix+00ah)		;4557   ; destino: 0xA000 + (ix+0A) * 32, la tabla de patrones de sprites
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
	ld bc,00020h		;4567   ; 32 bytes, un patron de 16x16
	pop de			;456a
	pop hl			;456b
	di			;456c
	ld a,(ix+008h)		;456d   ; (ix+8) bit 7 = 0: bancos 14 y 15 en 0x6000/0x8000
	bit 7,a		;4570
	jr nz,L_4586		;4572
	ld a,00eh		;4574
	ld (0d190h),a		;4576   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4579   ; registro del mapper: banco A en 0x6000
	ld a,00fh		;457c
	ld (0d191h),a		;457e   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4581   ; registro del mapper: banco A en 0x8000
	jr L_45BC		;4584
L_4586:
	bit 6,a		;4586   ; bits 7 y 6 = 10: bancos 11, 12 y 13 en 0x6000/0x8000/0xA000
	jr nz,L_45A4		;4588
	ld a,00bh		;458a
	ld (0d190h),a		;458c   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;458f   ; registro del mapper: banco A en 0x6000
	ld a,00ch		;4592
	ld (0d191h),a		;4594   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4597   ; registro del mapper: banco A en 0x8000
	ld a,00dh		;459a
	ld (0d192h),a		;459c   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;459f   ; registro del mapper: banco A en 0xA000
	jr L_45BC		;45a2
L_45A4:
	ld a,008h		;45a4   ; bits 7 y 6 = 11: bancos 8, 9 y 10
	ld (0d190h),a		;45a6   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;45a9   ; registro del mapper: banco A en 0x6000
	ld a,009h		;45ac
	ld (0d191h),a		;45ae   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;45b1   ; registro del mapper: banco A en 0x8000
	ld a,00ah		;45b4
	ld (0d192h),a		;45b6   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;45b9   ; registro del mapper: banco A en 0xA000
L_45BC:
	call 0005ch		;45bc   ; BIOS LDIRVM - Block transfers to VRAM from memory | el patron a VRAM
	ei			;45bf
	ld a,(ix+008h)		;45c0   ; los colores: (ix+8) sin los bits de banco...
	res 7,a		;45c3
	res 6,a		;45c5
	ld h,000h		;45c7
	ld l,a			;45c9
	ld de,04df4h		;45ca   ; ...indexa la tabla de colores de p00:4DF4
	add hl,de			;45cd
	push hl			;45ce
	ld a,(ix+009h)		;45cf   ; destino: D213 + sprite*16, sus colores en RAM
	ld h,000h		;45d2
	ld l,a			;45d4
	add hl,hl			;45d5
	add hl,hl			;45d6
	add hl,hl			;45d7
	add hl,hl			;45d8
	ld de,0d213h		;45d9   ; de -> los colores de los 32 sprites
	add hl,de			;45dc
	push hl			;45dd
	pop de			;45de
	pop hl			;45df
	ld bc,0000fh		;45e0   ; los 16 colores de lineas iguales:
	ld a,(hl)			;45e3   ; el primero...
	ex de,hl			;45e4
	ld (hl),a			;45e5
	ld d,h			;45e6
	ld e,l			;45e7
	inc de			;45e8
	ldir		;45e9   ; ...y se copia sobre los otros 15
L_45EB:
	ret			;45eb

; ----------------------------------------------------------------------
; DATOS resto_45EC: `pop hl / ret` sueltos que nadie ejecuta
;   0x45ec..0x45ee  (2 bytes)
DATA_resto_45EC:
	defb 0e1h,0c9h	; 45ec

; ======================================================================
; CODIGO 0x45ee..0x48e7  (761 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Un tile de 8x8 a la pantalla: HL = numero de tile, DE = destino (E = x,
; D = y). Los tiles estan en VRAM a partir de la pagina 1 (tile + 512, 32 por
; fila). B' bit 0 = 0 lo copia entero (HMMM), = 1 con el color 0
; transparente (LMMM con TIMP).
; ----------------------------------------------------------------------
pinta_tile:
	push de			;45ee
	ld de,00200h		;45ef   ; HL = (tile + 512) * 8
	add hl,de			;45f2
	add hl,hl			;45f3
	add hl,hl			;45f4
	add hl,hl			;45f5
	ld b,l			;45f6   ; B = x de origen
	ld l,h			;45f7   ; H*8...
	ld h,000h		;45f8
	add hl,hl			;45fa
	add hl,hl			;45fb
	add hl,hl			;45fc
	ld a,h			;45fd   ; ...A = pagina de origen
	inc a			;45fe
	ld h,l			;45ff
	ld l,b			;4600
	pop bc			;4601
	ld de,00808h		;4602   ; 8x8
	ex af,af'			;4605   ; destino en la pagina 0
	xor a			;4606
	ex af,af'			;4607
	exx			;4608
	bit 0,b		;4609   ; opaco o transparente?
	exx			;460b
	jp z,copia_bloque		;460c
	jp copia_transparente		;460f

; ----------------------------------------------------------------------
; Escribe la cadena que va pegada DETRAS del `call` (acaba en 0) a partir de
; DE, 8 pixeles por letra, y vuelve detras del 0.
; ----------------------------------------------------------------------
escribe_texto:
	ex (sp),hl			;4612   ; HL = la cadena (la direccion de vuelta)
	ld (0d5dbh),hl		;4613   ; la lista o la cadena que se esta pintando = hl
L_4616:
	ld hl,(0d5dbh)		;4616   ; la letra...
	ld a,(hl)			;4619
	push de			;461a
	call pinta_letra		;461b   ; ...se pinta
	pop de			;461e
	ld hl,00008h		;461f   ; 8 pixeles a la derecha
	add hl,de			;4622
	ex de,hl			;4623
	ld hl,(0d5dbh)		;4624   ; la siguiente
	inc hl			;4627
	ld (0d5dbh),hl		;4628   ; la lista o la cadena que se esta pintando = hl
	ld a,(hl)			;462b   ; el 0 acaba
	and a			;462c
	jp nz,L_4616		;462d
	inc hl			;4630   ; vuelve detras del 0
	ex (sp),hl			;4631
	ret			;4632
escribe_letra:
	ld de,(0d5dbh)		;4633   ; en la posicion de D5DB
	push de			;4637
	exx			;4638
	ld b,000h		;4639   ; opaca
	exx			;463b
	call pinta_letra		;463c
	pop de			;463f
	ex de,hl			;4640   ; y la posicion avanza 8
	ld hl,00008h		;4641
	add hl,de			;4644
	ld (0d5dbh),hl		;4645   ; la lista o la cadena que se esta pintando = hl
	ret			;4648
pinta_letra:
	ld b,000h		;4649   ; ASCII -> tile: espacio = 0
	cp 020h		;464b
	ld hl,00000h		;464d
	jr z,L_465F		;4650
	sub 030h		;4652   ; '0'-'9' -> 2-11
	cp 00ah		;4654   ; 'A'... -> 12...
	jr c,L_465A		;4656
	sub 006h		;4658
L_465A:
	ld l,a			;465a
	ld h,000h		;465b
	inc hl			;465d   ; +2
	inc hl			;465e
L_465F:
	call pinta_tile		;465f
	ret			;4662
escribe_bcd:
	push af			;4663   ; A = dos cifras BCD; la de las decenas...
	push de			;4664
	srl a		;4665
	srl a		;4667
	srl a		;4669
	srl a		;466b
	jr nz,L_4674		;466d   ; ...si es 0 sale un espacio
	ld a,020h		;466f
	jp L_4676		;4671
L_4674:
	add a,030h		;4674
L_4676:
	call pinta_letra		;4676   ; decenas
	pop de			;4679
	pop af			;467a
	inc de			;467b   ; 8 pixeles a la derecha
	inc de			;467c
	inc de			;467d
	inc de			;467e
	inc de			;467f
	inc de			;4680
	inc de			;4681
	inc de			;4682
	and 00fh		;4683   ; unidades
	add a,030h		;4685
	call pinta_letra		;4687
	ret			;468a
copia_transparente:
	di			;468b   ; como p00:44F1 pero con LMMM y TIMP: el color 0 no se copia
	push bc			;468c
	push af			;468d
	call espera_vdp		;468e   ; espera al VDP
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
	out (c),l		;46a2   ; SX, SY, pagina
	xor a			;46a4
	out (c),a		;46a5
	out (c),h		;46a7
	out (c),b		;46a9
	pop hl			;46ab
	out (c),l		;46ac   ; DX, DY, pagina A'
	out (c),a		;46ae
	out (c),h		;46b0
	ex af,af'			;46b2
	out (c),a		;46b3
	ex af,af'			;46b5
	xor a			;46b6
	out (c),e		;46b7   ; NX = E, NY = D
	out (c),a		;46b9
	out (c),d		;46bb
	out (c),a		;46bd
	out (c),a		;46bf
	out (c),a		;46c1
	ld a,098h		;46c3   ; CMD 0x98 = LMMM con TIMP
	out (c),a		;46c5
	ei			;46c7
	ret			;46c8

; ----------------------------------------------------------------------
; Pinta un bloque de tiles: HL = lista de palabras (una por tile), DE = lo
; que se suma a cada una, C x B = ancho y alto en pixeles, desde D5D6/D5D7.
; ----------------------------------------------------------------------
pinta_bloque_tiles:
	ld a,(0d5d6h)		;46c9   ; x de partida (se guarda en D5DA)
	ld (0d5dah),a		;46cc   ; x del principio de la fila = a
	add a,c			;46cf   ; C = x final
	ld c,a			;46d0
	ld a,(0d5d7h)		;46d1   ; B = y final
	add a,b			;46d4
	ld b,a			;46d5
	ld (0d5dbh),hl		;46d6   ; D5DB = la lista
L_46D9:
	push bc			;46d9
	push de			;46da
	push de			;46db
	ld hl,(0d5dbh)		;46dc   ; el tile siguiente...
	ld e,(hl)			;46df
	inc hl			;46e0
	ld d,(hl)			;46e1
	inc hl			;46e2
	ld (0d5dbh),hl		;46e3   ; la lista o la cadena que se esta pintando = hl
	ex de,hl			;46e6
	pop de			;46e7
	add hl,de			;46e8   ; ...+ DE
	ld de,(0d5d6h)		;46e9   ; en (D5D6, D5D7)
	call pinta_tile		;46ed
	pop de			;46f0
	pop bc			;46f1
	ld a,(0d5d6h)		;46f2   ; 8 pixeles a la derecha
	add a,008h		;46f5
	ld (0d5d6h),a		;46f7   ; x donde se pinta = a
	cp c			;46fa
	jp nz,L_46D9		;46fb
	ld a,(0d5dah)		;46fe   ; fila acabada: x al principio...
	ld (0d5d6h),a		;4701   ; x donde se pinta = a
	ld a,(0d5d7h)		;4704   ; ...y 8 pixeles abajo
	add a,008h		;4707
	ld (0d5d7h),a		;4709   ; y donde se pinta = a
	cp b			;470c
	jp nz,L_46D9		;470d
	ret			;4710

; ----------------------------------------------------------------------
; Pinta un bloque de bloques de 16x16 (p00:4777): HL = lista de palabras
; (0xFFxx = hueco), C x B = columnas y filas, desde D5D6/D5D7.
; ----------------------------------------------------------------------
pinta_bloque_16:
	ld a,(0d5d6h)		;4711   ; x de partida
	ld (0d5dah),a		;4714   ; x del principio de la fila = a
	ld (0d5dbh),hl		;4717   ; la lista o la cadena que se esta pintando = hl
	xor a			;471a   ; columna y fila a 0
	ld (0d5d8h),a		;471b   ; columna del bloque que se pinta = a
	ld (0d5d9h),a		;471e   ; fila del bloque que se pinta = a
L_4721:
	push bc			;4721
	push de			;4722
	push de			;4723
	ld hl,(0d5dbh)		;4724   ; el bloque siguiente
	ld e,(hl)			;4727
	inc hl			;4728
	ld d,(hl)			;4729
	inc hl			;472a
	ld (0d5dbh),hl		;472b   ; la lista o la cadena que se esta pintando = hl
	ld a,e			;472e
	cp 0ffh		;472f   ; 0xFF: hueco, no se pinta
	jr nz,L_4736		;4731
	pop de			;4733
	jr L_4744		;4734
L_4736:
	dec de			;4736   ; numero - 1 + DE
	ex de,hl			;4737
	pop de			;4738
	add hl,de			;4739
	ld de,(0d5d6h)		;473a   ; de = x donde se pinta
	ld h,000h		;473e
	inc hl			;4740
	call pinta_bloque		;4741   ; se pinta
L_4744:
	pop de			;4744
	pop bc			;4745
	ld a,(0d5d6h)		;4746   ; 16 pixeles a la derecha
	add a,010h		;4749
	ld (0d5d6h),a		;474b   ; x donde se pinta = a
	ld a,(0d5d8h)		;474e   ; columna + 1
	inc a			;4751
	ld (0d5d8h),a		;4752   ; columna del bloque que se pinta = a
	cp c			;4755
	jp nz,L_4721		;4756
	ld a,(0d5dah)		;4759   ; fila acabada: x al principio...
	ld (0d5d6h),a		;475c   ; x donde se pinta = a
	xor a			;475f
	ld (0d5d8h),a		;4760   ; columna del bloque que se pinta = a
	ld a,(0d5d7h)		;4763   ; ...16 abajo
	add a,010h		;4766
	ld (0d5d7h),a		;4768   ; y donde se pinta = a
	ld a,(0d5d9h)		;476b   ; fila + 1
	inc a			;476e
	ld (0d5d9h),a		;476f   ; fila del bloque que se pinta = a
	cp b			;4772
	jp nz,L_4721		;4773
	ret			;4776

; ----------------------------------------------------------------------
; Un bloque de 16x16: cuatro tiles de 8x8 sacados de la tabla de bloques
; (D5EA, en el banco 27, que se pone en 0xA000).
; ----------------------------------------------------------------------
pinta_bloque:
	ld a,01bh		;4777   ; banco 27 en 0xA000
	ld (0d192h),a		;4779   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;477c   ; registro del mapper: banco A en 0xA000
	push hl			;477f
	push hl			;4780
	exx			;4781
	pop hl			;4782
	ld a,l			;4783   ; (bloque & 7) * 4...
	and 007h		;4784
	ld l,a			;4786
	ld h,000h		;4787
	add hl,hl			;4789
	add hl,hl			;478a
	pop de			;478b
	push hl			;478c
	ex de,hl			;478d
	ld a,l			;478e   ; ...+ (bloque & 0xF8) * 8: 8 bytes por bloque
	and 0f8h		;478f
	ld l,a			;4791
	ld h,000h		;4792
	add hl,hl			;4794
	add hl,hl			;4795
	add hl,hl			;4796
	pop de			;4797
	add hl,de			;4798
	ld de,(0d5eah)		;4799   ; + la tabla de la fase (D5EA)
	add hl,de			;479d
	push hl			;479e
	pop ix		;479f
	exx			;47a1
	ld l,(ix+000h)		;47a2   ; tile de arriba a la izquierda
	ld h,(ix+001h)		;47a5
	push de			;47a8
	call pinta_tile		;47a9
	pop de			;47ac
	ld hl,00008h		;47ad   ; 8 a la derecha
	add hl,de			;47b0
	ex de,hl			;47b1
	push de			;47b2
	ld l,(ix+002h)		;47b3   ; arriba a la derecha
	ld h,(ix+003h)		;47b6
	call pinta_tile		;47b9
	pop de			;47bc
	ld hl,007f8h		;47bd   ; la fila de abajo: 8 lineas mas abajo y 8 a la izquierda
	add hl,de			;47c0
	ex de,hl			;47c1
	push de			;47c2
	ld bc,00020h		;47c3   ; los tiles de abajo van 32 bytes mas alla (filas de 8 bloques)
	add ix,bc		;47c6
	ld l,(ix+000h)		;47c8   ; abajo a la izquierda
	ld h,(ix+001h)		;47cb
	call pinta_tile		;47ce
	pop de			;47d1
	ld hl,00008h		;47d2
	add hl,de			;47d5
	ex de,hl			;47d6
	ld l,(ix+002h)		;47d7   ; abajo a la derecha
	ld h,(ix+003h)		;47da
	call pinta_tile		;47dd
	ld a,000h		;47e0   ; banco 0 otra vez en 0xA000
	ld (0d192h),a		;47e2   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;47e5   ; registro del mapper: banco A en 0xA000
	ret			;47e8

; ----------------------------------------------------------------------
; Las 32 fichas de sprite de D413 (11 bytes cada una): +0/1 patron, +2 x,
; +3 y (0xFF = oculto), +4/5 el ultimo patron cargado, +7, +8 juego de
; graficos, +9 numero de sprite, +0A sitio en la tabla de patrones.
; ----------------------------------------------------------------------
limpia_fichas_sprite:
	ld ix,0d413h		;47e9   ; la primera...
	ld b,020h		;47ed   ; ...de 32
L_47EF:
	push bc			;47ef
	ld a,020h		;47f0   ; A = numero de ficha (0-31)
	sub b			;47f2
	ld (ix+000h),000h		;47f3   ; sin patron
	ld (ix+001h),000h		;47f7
	ld (ix+009h),a		;47fb   ; sprite y sitio de patron = el suyo
	ld (ix+00ah),a		;47fe
	ld (ix+007h),000h		;4801
	ld (ix+003h),0ffh		;4805   ; y = 0xFF: oculto
	inc ix		;4809   ; la siguiente, 11 bytes mas alla
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
vacia_fichas_sprite:
	push bc			;4823   ; B fichas desde IX: sin patron y ocultas
	ld (ix+000h),000h		;4824
	ld (ix+001h),000h		;4828
	ld (ix+007h),000h		;482c
	ld (ix+003h),0ffh		;4830
	inc ix		;4834   ; la siguiente
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
	djnz vacia_fichas_sprite		;484b
	ret			;484d

; ----------------------------------------------------------------------
; B fichas de sprite desde IX a la tabla de atributos de RAM (D193): carga
; su patron si ha cambiado y escribe y, x, patron y el cuarto byte.
; ----------------------------------------------------------------------
fichas_a_atributos:
	push bc			;484e
	call carga_patron_sprite		;484f   ; el patron, si ha cambiado
	ld a,(ix+009h)		;4852   ; HL = D193 + sprite * 4
	ld l,a			;4855
	ld h,000h		;4856
	add hl,hl			;4858
	add hl,hl			;4859
	ld de,0d193h		;485a   ; de -> la tabla de atributos de los 32 sprites
	add hl,de			;485d
	ld a,(ix+003h)		;485e   ; y = 0xFF: se esconde en y = 0xE0
	cp 0ffh		;4861
	jr z,sprite_oculto		;4863
	ld b,a			;4865   ; y + desplazamiento vertical del actor (D5DE)
	ld a,(0d5deh)		;4866   ; a = lo que se suma a la y de los sprites
	add a,b			;4869
L_486A:
	ld (hl),a			;486a   ; atributo 0: y
	inc hl			;486b
	ld a,(0d5ddh)		;486c   ; x + desplazamiento horizontal (D5DD)
	add a,(ix+002h)		;486f
	ld (hl),a			;4872   ; atributo 1: x
	inc hl			;4873
	ld a,(ix+00ah)		;4874   ; atributo 2: patron = sitio * 4 (sprites de 16x16)
	add a,a			;4877
	add a,a			;4878
	ld (hl),a			;4879
	inc hl			;487a
	ld a,(ix+008h)		;487b   ; atributo 3: lo que diga +8
	ld (hl),a			;487e
	inc ix		;487f   ; la ficha siguiente
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
	djnz fichas_a_atributos		;4896
	ret			;4898
sprite_oculto:
	ld a,0e0h		;4899   ; y = 0xE0, fuera de la pantalla
	jp L_486A		;489b
pon_scroll_vertical:
	push bc			;489e
	di			;489f
	call espera_vdp		;48a0   ; espera al VDP
	ld a,(0d5e0h)		;48a3   ; D5E0: el desplazamiento vertical de la pantalla
	ld b,a			;48a6
	ld a,(00007h)		;48a7
	inc a			;48aa
	ld c,a			;48ab
	ld a,b			;48ac   ; a R#23 (0x80 + 23 = 0x97)
	out (c),a		;48ad
	ld a,097h		;48af
	out (c),a		;48b1
	ei			;48b3
	pop bc			;48b4
	ret			;48b5

; ----------------------------------------------------------------------
; Pinta un bloque de 16x16 con la tabla de bloques de p00:5BC3 en vez de la
; de la fase, en (D92B, D92C): el bloque lo elige D92D por la tabla de
; p00:48E7. Con el color 0 transparente.
; ----------------------------------------------------------------------
pinta_bloque_especial:
	ld hl,(0d5eah)		;48b6   ; guarda la tabla de bloques de la fase...
	ld (0d5ech),hl		;48b9   ; la tabla de bloques guardada = hl
	ld hl,05bc3h		;48bc   ; ...y pone la de p00:5BC3
	ld (0d5eah),hl		;48bf   ; la tabla de bloques de 16x16 de la fase = hl
	ld a,(0d92dh)		;48c2   ; D92D - 1 indexa p00:48E7
	dec a			;48c5
	ld l,a			;48c6
	ld h,000h		;48c7
	ld de,048e7h		;48c9
	add hl,de			;48cc
	ld a,(hl)			;48cd
	ld l,a			;48ce
	ld h,000h		;48cf
	ld a,(0d92bh)		;48d1   ; x
	ld e,a			;48d4
	ld a,(0d92ch)		;48d5   ; y
	ld d,a			;48d8
	exx			;48d9   ; transparente
	ld b,001h		;48da
	exx			;48dc
	call pinta_bloque		;48dd
	ld hl,(0d5ech)		;48e0   ; devuelve la tabla de la fase
	ld (0d5eah),hl		;48e3   ; la tabla de bloques de 16x16 de la fase = hl
	ret			;48e6

; ----------------------------------------------------------------------
; DATOS bloque_especial: Que bloque de p00:5BC3 pinta p00:48B6 segun D92D (18
;   valores)
;   0x48e7..0x48f9  (18 bytes)
DATA_bloque_especial:
	defb 00fh,010h,011h,000h,001h,002h,005h,006h,003h,004h,007h,008h,009h,00ah,00bh,00ch	; 48e7  ................
	defb 00dh,00eh	; 48f7

; ======================================================================
; CODIGO 0x48f9..0x4a19  (288 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Da de alta un actor (IX): segun su tipo (+0) le reserva sprites en uno de
; los grupos (DA17 de dos en dos bits, DA18 de uno en uno), apunta sus fichas
; de sprite en +3/4 y cuantas son en +5, y lo pinta (p00:4A1B).
; ----------------------------------------------------------------------
alta_actor:
	ld a,(ix+000h)		;48f9   ; tipo 0: hueco libre, nada que hacer
	and a			;48fc
	ret z			;48fd
	ld a,(ix+000h)		;48fe   ; tipos 0x0A, 0x1A y 0x1B: grupo de dos sprites (p00:4967)
	cp 00ah		;4901
	jp z,alta_actor_dos		;4903
	cp 01ah		;4906
	jp z,alta_actor_dos		;4908
	cp 01bh		;490b
	jp z,alta_actor_dos		;490d
	cp 016h		;4910   ; tipos 0x16, 0x1F, 0x0B, 0x0C, 0x17, 0x1E y 0x25: un sprite (p00:49EB)
	jp z,alta_actor_uno		;4912
	cp 01fh		;4915
	jp z,alta_actor_uno		;4917
	cp 00bh		;491a
	jp z,alta_actor_uno		;491c
	cp 00ch		;491f
	jp z,alta_actor_uno		;4921
	cp 017h		;4924
	jp z,alta_actor_uno		;4926
	cp 01eh		;4929
	jp z,alta_actor_uno		;492b
	cp 025h		;492e
	jp z,alta_actor_uno		;4930
	ld d,000h		;4933   ; los demas: un grupo libre de DA17 con los bits 00
	call busca_grupo		;4935
	ld a,b			;4938   ; no hay: no sale
	and a			;4939
	ret z			;493a
	ld a,003h		;493b   ; se marca ocupado (11)
	call marca_grupo		;493d
	ld a,b			;4940   ; +0E = grupo con el bit 4: "cinco sprites"
	and 007h		;4941
	set 4,a		;4943
	ld (ix+00eh),a		;4945
	ld a,b			;4948   ; primera ficha: 0x10 + (grupo - 1) * 5
	dec a			;4949
	add a,a			;494a
	add a,a			;494b
	add a,b			;494c
	add a,010h		;494d
	ld de,0000bh		;494f   ; 11 bytes por ficha
	ld hl,0d413h		;4952   ; hl -> las 32 fichas de sprite
	ld b,a			;4955
L_4956:
	add hl,de			;4956
	djnz L_4956		;4957
	ld (ix+003h),l		;4959   ; +3/4 = sus fichas
	ld (ix+004h),h		;495c
	ld a,005h		;495f   ; +5 = cinco sprites
	ld (ix+005h),a		;4961
	jp pinta_actor_nuevo		;4964
alta_actor_dos:
	ld d,040h		;4967   ; un grupo con 01...
	call busca_grupo		;4969
	ld a,b			;496c
	and a			;496d
	jp nz,L_49AF		;496e
	ld d,080h		;4971   ; ...o con 10...
	call busca_grupo		;4973
	ld a,b			;4976
	and a			;4977
	jp nz,L_49B7		;4978
	ld d,000h		;497b   ; ...o libre (00)
	call busca_grupo		;497d
	ld a,b			;4980
	and a			;4981
	ret z			;4982
	ld a,002h		;4983   ; libre: se marca 10
	call marca_grupo		;4985
L_4988:
	ld a,b			;4988   ; +0E = grupo con el bit 7
	and 007h		;4989
	set 7,a		;498b
	ld (ix+00eh),a		;498d
	ld a,b			;4990   ; primera ficha: 0x10 + (grupo - 1) * 5
	dec a			;4991
	add a,a			;4992
	add a,a			;4993
	add a,b			;4994
	add a,010h		;4995
	ld de,0000bh		;4997
	ld hl,0d413h		;499a   ; hl -> las 32 fichas de sprite
	ld b,a			;499d
L_499E:
	add hl,de			;499e
	djnz L_499E		;499f
	ld (ix+003h),l		;49a1
	ld (ix+004h),h		;49a4
	ld a,002h		;49a7   ; dos sprites
	ld (ix+005h),a		;49a9
	jp pinta_actor_nuevo		;49ac
L_49AF:
	ld a,003h		;49af   ; tenia 01: pasa a 11 (el grupo lleno)
	call marca_grupo		;49b1
	jp L_4988		;49b4
L_49B7:
	ld a,b			;49b7   ; tenia 10: la segunda mitad del grupo
	and 007h		;49b8
	set 6,a		;49ba
	ld (ix+00eh),a		;49bc
	ld a,003h		;49bf
	call marca_grupo		;49c1
	ld a,b			;49c4
	and 007h		;49c5
	set 6,a		;49c7
	ld (ix+00eh),a		;49c9
	ld a,b			;49cc   ; primera ficha: 0x12 + (grupo - 1) * 5
	dec a			;49cd
	add a,a			;49ce
	add a,a			;49cf
	add a,b			;49d0
	add a,012h		;49d1
	ld de,0000bh		;49d3
	ld hl,0d413h		;49d6   ; hl -> las 32 fichas de sprite
	ld b,a			;49d9
L_49DA:
	add hl,de			;49da
	djnz L_49DA		;49db
	ld (ix+003h),l		;49dd
	ld (ix+004h),h		;49e0
	ld a,002h		;49e3
	ld (ix+005h),a		;49e5
	jp pinta_actor_nuevo		;49e8
alta_actor_uno:
	call busca_sitio_uno		;49eb   ; un sitio libre de DA18
	ld a,b			;49ee
	and a			;49ef
	ret z			;49f0
	ld a,001h		;49f1   ; se marca ocupado
	call marca_sitio_uno		;49f3
	ld a,b			;49f6   ; +0E = sitio con el bit 5
	and 007h		;49f7
	set 5,a		;49f9
	ld (ix+00eh),a		;49fb
	ld a,b			;49fe   ; ficha 0x0A + sitio
	add a,00ah		;49ff
	ld de,0000bh		;4a01
	ld hl,0d413h		;4a04   ; hl -> las 32 fichas de sprite
	ld b,a			;4a07
L_4A08:
	add hl,de			;4a08
	djnz L_4A08		;4a09
	ld (ix+003h),l		;4a0b
	ld (ix+004h),h		;4a0e
	ld a,001h		;4a11   ; un sprite
	ld (ix+005h),a		;4a13
	jp pinta_actor_nuevo		;4a16

; ----------------------------------------------------------------------
; DATOS resto_4A19: dos `ret` sueltos que nadie ejecuta
;   0x4a19..0x4a1b  (2 bytes)
DATA_resto_4A19:
	defb 0c9h,0c9h	; 4a19

; ======================================================================
; CODIGO 0x4a1b..0x4c68  (589 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Pinta un actor recien dado de alta: busca la definicion de su pose (tipo
; +0, pose +1, en el banco 30 o 26 en 0x8000), la convierte en fichas de
; sprite (p00:5AA5) y las pasa a la tabla de atributos.
; ----------------------------------------------------------------------
pinta_actor_nuevo:
	push ix		;4a1b
	ld a,(ix+006h)		;4a1d   ; su x y su y, como desplazamiento de sus sprites
	ld (0d5ddh),a		;4a20   ; lo que se suma a la x de los sprites = a
	ld a,(ix+007h)		;4a23
	ld (0d5deh),a		;4a26   ; lo que se suma a la y de los sprites = a
	ld a,(ix+000h)		;4a29   ; tipos menores que 0x18: definiciones en el banco 30...
	cp 018h		;4a2c
	jr nc,L_4A3A		;4a2e
	ld a,01eh		;4a30
	ld (0d191h),a		;4a32   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4a35   ; registro del mapper: banco A en 0x8000
	jr L_4A42		;4a38
L_4A3A:
	ld a,01ah		;4a3a   ; ...los demas en el banco 26
	ld (0d191h),a		;4a3c   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4a3f   ; registro del mapper: banco A en 0x8000
L_4A42:
	push ix		;4a42   ; IY = IX + 0x0A
	pop hl			;4a44
	ld de,0000ah		;4a45
	add hl,de			;4a48
	push hl			;4a49
	pop iy		;4a4a
	call definicion_pose		;4a4c   ; DE = definicion de la pose
	ld (ix+00ch),e		;4a4f   ; apuntada en +0C/0D
	ld (ix+00dh),d		;4a52
	ld l,(ix+003h)		;4a55   ; HL = sus fichas de sprite
	ld h,(ix+004h)		;4a58
	push de			;4a5b
	pop ix		;4a5c
	ex af,af'			;4a5e   ; A' = 2: alta
	ld a,002h		;4a5f
	ex af,af'			;4a61
	call anima		;4a62   ; rellena las fichas
	pop ix		;4a65
	push ix		;4a67
	ld l,(ix+003h)		;4a69   ; y las pasa a atributos
	ld h,(ix+004h)		;4a6c
	ld b,(ix+005h)		;4a6f
	push hl			;4a72
	pop ix		;4a73
	call fichas_a_atributos		;4a75
	pop ix		;4a78
	ld a,003h		;4a7a   ; bancos 3 y 4 otra vez, los del juego
	ld (0d190h),a		;4a7c   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4a7f   ; registro del mapper: banco A en 0x6000
	ld a,004h		;4a82
	ld (0d191h),a		;4a84   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4a87   ; registro del mapper: banco A en 0x8000
	ret			;4a8a
pinta_actor:
	call definicion_pose		;4a8b   ; lo mismo para un actor ya dado de alta: la definicion de su pose...
	ld (ix+00ch),e		;4a8e
	ld (ix+00dh),d		;4a91
	push ix		;4a94   ; ...su x y su y...
	ld a,(ix+006h)		;4a96
	ld (0d5ddh),a		;4a99   ; lo que se suma a la x de los sprites = a
	ld a,(ix+007h)		;4a9c
	ld (0d5deh),a		;4a9f   ; lo que se suma a la y de los sprites = a
	ld a,(ix+000h)		;4aa2   ; ...el banco de las definiciones...
	cp 018h		;4aa5
	jr nc,L_4AB3		;4aa7
	ld a,01eh		;4aa9
	ld (0d191h),a		;4aab   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4aae   ; registro del mapper: banco A en 0x8000
	jr L_4ABB		;4ab1
L_4AB3:
	ld a,01ah		;4ab3
	ld (0d191h),a		;4ab5   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4ab8   ; registro del mapper: banco A en 0x8000
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
	ld a,000h		;4ad5   ; A' = 0: solo cambia la pose
	ex af,af'			;4ad7
	call anima		;4ad8   ; rellena las fichas
	pop ix		;4adb
	push ix		;4add
	ld a,(ix+00ah)		;4adf   ; +2 = +0A con el bit 7 de A' (la orientacion)
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
	call fichas_a_atributos		;4afa   ; y las pasa a atributos
	pop ix		;4afd
	ld a,003h		;4aff   ; bancos 3 y 4 otra vez
	ld (0d190h),a		;4b01   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4b04   ; registro del mapper: banco A en 0x6000
	ld a,004h		;4b07
	ld (0d191h),a		;4b09   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4b0c   ; registro del mapper: banco A en 0x8000
	ret			;4b0f

; ----------------------------------------------------------------------
; Da de baja un actor: devuelve sus sprites al grupo, los esconde y borra
; sus 38 bytes.
; ----------------------------------------------------------------------
baja_actor:
	ld a,(ix+003h)		;4b10   ; sin fichas: no estaba dado de alta
	and a			;4b13
	ret z			;4b14
	ld a,(ix+00eh)		;4b15   ; +0E: de que grupo eran sus sprites
	bit 4,a		;4b18
	jp nz,L_4B2C		;4b1a
	bit 5,a		;4b1d
	jp nz,baja_actor_uno		;4b1f
	bit 6,a		;4b22
	jp nz,baja_actor_dos_a		;4b24
	bit 7,a		;4b27
	jp nz,baja_actor_dos_b		;4b29
L_4B2C:
	and 003h		;4b2c   ; cinco sprites: el grupo vuelve a 00
	ld b,a			;4b2e
	xor a			;4b2f
	call marca_grupo		;4b30
L_4B33:
	push ix		;4b33
	ld l,(ix+003h)		;4b35   ; sus fichas
	ld h,(ix+004h)		;4b38
	ld b,(ix+005h)		;4b3b
	ld a,h			;4b3e
	or l			;4b3f
	jr z,L_4B62		;4b40
	push hl			;4b42
	pop ix		;4b43
	push ix		;4b45
	push bc			;4b47
	call vacia_fichas_sprite		;4b48   ; se vacian...
	pop bc			;4b4b
	pop ix		;4b4c
	call fichas_a_atributos		;4b4e   ; ...y se esconden
	pop hl			;4b51
	push hl			;4b52
	ld d,h			;4b53   ; los 38 bytes del actor a 0
	ld e,l			;4b54
	inc de			;4b55
	ld bc,00025h		;4b56
	xor a			;4b59
	ld (hl),a			;4b5a
	ldir		;4b5b
	ld hl,0da19h		;4b5d   ; ya hay sitio para otro (DA19 bit 0)
	res 0,(hl)		;4b60
L_4B62:
	pop ix		;4b62
	ld a,003h		;4b64   ; bancos 3 y 4 otra vez
	ld (0d190h),a		;4b66   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4b69   ; registro del mapper: banco A en 0x6000
	ld a,004h		;4b6c
	ld (0d191h),a		;4b6e   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4b71   ; registro del mapper: banco A en 0x8000
	ret			;4b74
baja_actor_uno:
	and 007h		;4b75   ; un sprite: su sitio de DA18 vuelve a libre
	ld b,a			;4b77
	xor a			;4b78
	call marca_sitio_uno		;4b79
	jp L_4B33		;4b7c
baja_actor_dos_b:
	and 003h		;4b7f   ; la segunda mitad de un grupo de dos
	add a,a			;4b81
	ld b,a			;4b82
	jp L_4B8B		;4b83
baja_actor_dos_a:
	and 003h		;4b86   ; la primera mitad
	add a,a			;4b88
	dec a			;4b89
	ld b,a			;4b8a
L_4B8B:
	push bc			;4b8b
	ld a,(0da17h)		;4b8c   ; DA17: se borra el bit del grupo B
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
	ld (0da17h),a		;4bb3   ; se guarda
	pop bc			;4bb6
	jp L_4B33		;4bb7
marca_sitio_uno:
	push bc			;4bba   ; DA18: el sitio B (1-6) pasa a valer A
	push af			;4bbb
	ld a,(0da18h)		;4bbc   ; a = seis sitios de un sprite, un bit cada uno
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
	ld (0da18h),a		;4bf2   ; se guarda
	pop bc			;4bf5
	ret			;4bf6
definicion_pose:
	ld a,(ix+000h)		;4bf7   ; la tabla de poses del tipo (p00:4C68)...
	ld de,04c68h		;4bfa
	dec a			;4bfd
	ld l,a			;4bfe
	ld h,000h		;4bff
	add hl,hl			;4c01
	add hl,de			;4c02
	ld e,(hl)			;4c03
	inc hl			;4c04
	ld d,(hl)			;4c05
	ld a,(ix+001h)		;4c06   ; ...y en ella la de la pose +1
	ld l,a			;4c09
	ld h,000h		;4c0a
	add hl,hl			;4c0c
	add hl,de			;4c0d
	ld e,(hl)			;4c0e
	inc hl			;4c0f
	ld d,(hl)			;4c10
	ret			;4c11
busca_sitio_uno:
	ld a,(0da18h)		;4c12   ; DA18: seis sitios de un sprite
	ld b,006h		;4c15
L_4C17:
	ld c,a			;4c17
	bit 7,a		;4c18   ; bit 7 a 0: libre; B dice cual
	ret z			;4c1a
	ld a,c			;4c1b
	add a,a			;4c1c   ; el siguiente
	djnz L_4C17		;4c1d
	ld hl,0da19h		;4c1f   ; ninguno libre: DA19 bit 1
	set 1,(hl)		;4c22
	ret			;4c24
busca_grupo:
	ld a,(0da17h)		;4c25   ; DA17: tres grupos de dos bits; busca uno que valga D
	ld b,003h		;4c28
L_4C2A:
	ld c,a			;4c2a
	and 0c0h		;4c2b   ; los dos bits altos
	cp d			;4c2d
	ret z			;4c2e
	ld a,c			;4c2f   ; el siguiente grupo
	add a,a			;4c30
	add a,a			;4c31
	djnz L_4C2A		;4c32
	ld hl,0da19h		;4c34   ; ninguno: DA19 bit 0
	set 0,(hl)		;4c37
	ret			;4c39
marca_grupo:
	push bc			;4c3a   ; DA17: el grupo B pasa a valer A
	push af			;4c3b
	ld a,(0da17h)		;4c3c   ; a = tres grupos de sprites, dos bits cada uno
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
	ld (0da17h),a		;4c63   ; se guarda
	pop bc			;4c66
	ret			;4c67

; ----------------------------------------------------------------------
; DATOS poses_por_tipo: Por cada tipo de actor (1-37), la direccion de su
;   lista de poses
;   0x4c68..0x4cb2  (74 bytes)
DATA_poses_por_tipo:
	defw 04cb2h,04cbeh,04ccah,04cd6h,04cdeh,04ce6h,04cf2h,04cf6h	; 4c68
	defw 04d02h,04d0ah,04d12h,04d1ah,04d22h,04d26h,04d2ah,04d2eh	; 4c78
	defw 04d36h,04d4ah,04d5eh,04d72h,04d7ah,04d82h,04daeh,04dbah	; 4c88
	defw 04dc2h,04dd0h,04dd4h,04dd8h,04dcch,04db4h,04ddch,04ddah	; 4c98
	defw 04de0h,04dceh,04de8h,04dech,04deah	; 4ca8

; ----------------------------------------------------------------------
; DATOS poses: Las listas de poses: para cada pose, la direccion de su
;   definicion en el banco 30 o 26 (0x8000)
;   0x4cb2..0x4df4  (322 bytes)
DATA_poses:
	defw 08000h,0800bh,08020h,0802bh,08016h,0801bh,08097h,0809ch	; 4cb2
	defw 080a1h,080a6h,080abh,080b0h,08134h,0813fh,0815ch,08167h	; 4cc2
	defw 0814ah,08153h,0828eh,08299h,082a4h,082b7h,08444h,0844dh	; 4cd2
	defw 08456h,0845fh,084d1h,084dah,084edh,084f8h,08503h,08510h	; 4ce2
	defw 085bfh,085cah,085f5h,085f5h,085d5h,085deh,085e7h,085eeh	; 4cf2
	defw 086a8h,086b1h,086bah,086c1h,0876eh,08777h,08780h,08787h	; 4d02
	defw 087beh,087c5h,087cch,087d3h,087f2h,087fbh,08804h,0880dh	; 4d12
	defw 0883ah,08843h,088a0h,088abh,088d4h,088ddh,08904h,0890dh	; 4d22
	defw 08916h,0891fh,0895bh,08964h,0896dh,08978h,08983h,08988h	; 4d32
	defw 08997h,089a2h,0898dh,08992h,08a67h,08a70h,08a79h,08a84h	; 4d42
	defw 08a8fh,08a94h,08aa3h,08aaeh,08a99h,08a9eh,08b61h,08b6ah	; 4d52
	defw 08b87h,08ba2h,08b7dh,08b82h,08bbdh,08bd8h,08b73h,08b78h	; 4d62
	defw 08e54h,08e5dh,08e66h,08e6fh,08f17h,08f20h,08f29h,08f32h	; 4d72
	defw 08e78h,08e7fh,08e86h,08e8bh,08f3bh,08f42h,08f49h,08f4eh	; 4d82
	defw 08172h,08172h,0817bh,0817bh,08182h,08182h,08b3eh,08b3eh	; 4d92
	defw 08928h,08928h,086c8h,086cfh,08468h,08468h,00000h,08fdah	; 4da2
	defw 08fe7h,088bdh,088d0h,0891bh,08000h,08103h,081deh,08291h	; 4db2
	defw 08607h,086a2h,08430h,08430h,084d1h,0856ch,08763h,0834fh	; 4dc2
	defw 08369h,08354h,0836eh,08383h,0831ch,08744h,0873dh,0881ch	; 4dd2
	defw 0888dh,088a0h,088b0h,0881ch,08a11h,08966h,08a4ch,08aa3h	; 4de2
	defw 08a11h	; 4df2

; ----------------------------------------------------------------------
; DATOS colores_sprite: Color de cada juego de graficos de sprite (p00:45CA):
;   0x00-0x0F y 0x40-0x4F
;   0x4df4..0x4e14  (32 bytes)
DATA_colores_sprite:
	defb 000h,001h,002h,003h,004h,005h,006h,007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh	; 4df4  ................
	defb 040h,041h,042h,043h,044h,045h,046h,047h,048h,049h,04ah,04bh,04ch,04dh,04eh,04fh	; 4e04  @ABCDEFGHIJKLMNO

; ======================================================================
; CODIGO 0x4e14..0x4e99  (133 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; TAREA 0: la principal. Presentacion, demo y partida, en bucle.
; ----------------------------------------------------------------------
tarea_principal:
	xor a			;4e14   ; sin desplazamiento vertical
	ld (0d5e0h),a		;4e15   ; el desplazamiento vertical de la pantalla = a
	call pon_scroll_vertical		;4e18
	ld a,0ffh		;4e1b   ; D5DF = 0xFF
	ld (0d5dfh),a		;4e1d   ; 0xFF = el juego corre, 0 = pausa = a
	ld a,000h		;4e20   ; musica 0 y efecto 0
	ld (0d178h),a		;4e22   ; efecto pedido, para p01:63E1 = a
	ld a,000h		;4e25
	ld (0d17ah),a		;4e27   ; musica pedida, para p01:640F = a
	ld a,003h		;4e2a   ; D067 = 3
	ld (0d067h),a		;4e2c   ; 3 al empezar = a
	call pantalla_titulo		;4e2f   ; prepara la partida (p00:4FE0)
	xor a			;4e32
	ld (0d17dh),a		;4e33   ; bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo = a
presentacion:
	call borra_vram		;4e36   ; VRAM a 0
	ld a,001h		;4e39   ; arranca la tarea 1 (p00:524F)
	call crea_tarea		;4e3b
L_4E3E:
	call cede		;4e3e   ; un cuadro
	ld a,(04010h)		;4e41   ; el byte 0x4010 de la cabecera (vale 0): un interruptor de pruebas...
	and a			;4e44
	jp z,L_4E61		;4e45
	ld a,000h		;4e48   ; ...que, encendido, deja cambiar con las teclas 4 y 5 (fila 0)...
	call 00141h		;4e4a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 030h		;4e4d
	add a,a			;4e4f
	cpl			;4e50
	ld b,a			;4e51
	ld a,(0f3e1h)		;4e52   ; ...los bits 5-6 de R#2: la pagina que se ve
	and 09fh		;4e55
	or b			;4e57
	ld (0f3e1h),a		;4e58
	ld c,002h		;4e5b
	ld b,a			;4e5d
	call 00047h		;4e5e   ; BIOS WRTVDP - Writes data in the VDP-register | WRTVDP R#2
L_4E61:
	ld a,(0d17dh)		;4e61   ; D17D bit 6: la presentacion ha acabado
	bit 6,a		;4e64
	jr z,L_4E3E		;4e66
	call borra_vram		;4e68   ; VRAM a 0
	ld a,004h		;4e6b   ; para las tareas 4, 2, 3 y 1
	call para_tarea_y_cede		;4e6d
	ld a,002h		;4e70
	call para_tarea_y_cede		;4e72
	ld a,003h		;4e75
	call para_tarea_y_cede		;4e77
	ld a,001h		;4e7a
	call para_tarea_y_cede		;4e7c
	call limpia_fichas_sprite		;4e7f   ; sprites a cero...
	ld ix,0d413h		;4e82   ; ...y los 32 ocultos
	ld b,020h		;4e86
	call fichas_a_atributos		;4e88
	call borra_vram		;4e8b   ; VRAM a 0

; ----------------------------------------------------------------------
; FIN DE PARTIDA: "GAME OVER" y la cuenta para continuar.
; ----------------------------------------------------------------------
	exx			;4e8e   ; opaco
	ld b,000h		;4e8f
	exx			;4e91
	ld d,060h		;4e92   ; en x = 0x60, y = 0x60
	ld e,060h		;4e94
	call escribe_texto		;4e96

; ----------------------------------------------------------------------
; DATOS texto_game_over: "GAME OVER"
;   0x4e99..0x4ea3  (10 bytes)
DATA_texto_game_over:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 4e99  GAME OVER.

; ======================================================================
; CODIGO 0x4ea3..0x4eec  (73 bytes)
; ======================================================================


	ld a,000h		;4ea3   ; corta el efecto...
	ld (0d17ah),a		;4ea5   ; musica pedida, para p01:640F = a
	ld a,008h		;4ea8   ; ...y pide el 8
	ld (0d17ah),a		;4eaa   ; musica pedida, para p01:640F = a
	ld a,0c8h		;4ead   ; 200 cuadros...
	call duerme		;4eaf
	ld a,0c8h		;4eb2   ; ...y otros 200
	call duerme		;4eb4
	ld a,006h		;4eb7   ; efecto 6
	ld (0d17ah),a		;4eb9   ; musica pedida, para p01:640F = a
	xor a			;4ebc   ; la partida a cero (lo mismo que p00:4FE0)
	ld (0d17dh),a		;4ebd   ; bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo = a
	ld (0d905h),a		;4ec0   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ld (0d919h),a		;4ec3   ; el arma que lleva = a
	ld (0d926h),a		;4ec6   ; los golpes que le quedan al escudo = a
	ld (0d91eh),a		;4ec9   ; la puntuacion, cuatro bytes BCD = a
	ld (0d91fh),a		;4ecc   ; puntuacion, cifras 3-4 = a
	ld (0d920h),a		;4ecf   ; puntuacion, cifras 5-6 = a
	ld (0d921h),a		;4ed2   ; puntuacion, byte 4; bit 7: ha cambiado = a
	ld (0d90dh),a		;4ed5
	ld (0d90eh),a		;4ed8
	ld (0d90fh),a		;4edb   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld (0d910h),a		;4ede   ; bits: 0 en la salida, 6 jefe, 7 no pierde vida = a
	exx			;4ee1
	ld b,000h		;4ee2
	exx			;4ee4
	ld d,080h		;4ee5   ; en (0x30, 0x80)
	ld e,030h		;4ee7
	call escribe_texto		;4ee9

; ----------------------------------------------------------------------
; DATOS texto_to_continue: "TO CONTINUE"
;   0x4eec..0x4ef8  (12 bytes)
DATA_texto_to_continue:
	defb 054h,04fh,020h,043h,04fh,04eh,054h,049h,04eh,055h,045h,000h	; 4eec  TO CONTINUE.

; ======================================================================
; CODIGO 0x4ef8..0x4f03  (11 bytes)
; ======================================================================


	exx			;4ef8
	ld b,000h		;4ef9
	exx			;4efb
	ld d,088h		;4efc   ; en (0x30, 0x88)
	ld e,030h		;4efe
	call escribe_texto		;4f00

; ----------------------------------------------------------------------
; DATOS texto_push_space_1: "     PUSH SPACE KEY"
;   0x4f03..0x4f17  (20 bytes)
DATA_texto_push_space_1:
	defb 020h,020h,020h,020h,020h,050h,055h,053h,048h,020h,053h,050h,041h,043h,045h,020h	; 4f03       PUSH SPACE
	defb 04bh,045h,059h,000h	; 4f13

; ======================================================================
; CODIGO 0x4f17..0x4f22  (11 bytes)
; ======================================================================


	exx			;4f17
	ld b,000h		;4f18
	exx			;4f1a
	ld d,098h		;4f1b   ; en (0x30, 0x98)
	ld e,030h		;4f1d
	call escribe_texto		;4f1f

; ----------------------------------------------------------------------
; DATOS texto_to_cancel: "TO CANCEL"
;   0x4f22..0x4f2c  (10 bytes)
DATA_texto_to_cancel:
	defb 054h,04fh,020h,043h,041h,04eh,043h,045h,04ch,000h	; 4f22  TO CANCEL.

; ======================================================================
; CODIGO 0x4f2c..0x4f37  (11 bytes)
; ======================================================================


	exx			;4f2c
	ld b,000h		;4f2d
	exx			;4f2f
	ld d,0a0h		;4f30   ; en (0x30, 0xA0)
	ld e,030h		;4f32
	call escribe_texto		;4f34

; ----------------------------------------------------------------------
; DATOS texto_push_graph: "     PUSH GRAPH KEY"
;   0x4f37..0x4f4b  (20 bytes)
DATA_texto_push_graph:
	defb 020h,020h,020h,020h,020h,050h,055h,053h,048h,020h,047h,052h,041h,050h,048h,020h	; 4f37       PUSH GRAPH
	defb 04bh,045h,059h,000h	; 4f47

; ======================================================================
; CODIGO 0x4f4b..0x4f68  (29 bytes)
; ======================================================================


	ld hl,01c20h		;4f4b   ; 7200 cuadros (dos minutos a 60 Hz) para decidir
cuenta_continuar:
	push hl			;4f4e
	call cede		;4f4f   ; un cuadro
	pop hl			;4f52
	push hl			;4f53
	ld a,l			;4f54   ; cada 32 cuadros cambia...
	and 01fh		;4f55
	jr z,$+50		;4f57
	bit 5,l		;4f59   ; ..."GAME OVER" o espacios: parpadea
	jr nz,$+25		;4f5b
	exx			;4f5d
	ld b,000h		;4f5e
	exx			;4f60
	ld d,060h		;4f61
	ld e,060h		;4f63
	call escribe_texto		;4f65

; ----------------------------------------------------------------------
; DATOS texto_game_over_2: "GAME OVER" (el parpadeo)
;   0x4f68..0x4f72  (10 bytes)
DATA_texto_game_over_2:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 4f68  GAME OVER.

; ======================================================================
; CODIGO 0x4f72..0x4f7f  (13 bytes)
; ======================================================================


	jr $+23		;4f72   ; salta los espacios
borra_game_over:
	exx			;4f74
	ld b,000h		;4f75
	exx			;4f77
	ld d,060h		;4f78
	ld e,060h		;4f7a
	call escribe_texto		;4f7c

; ----------------------------------------------------------------------
; DATOS texto_blancos: nueve espacios: borran "GAME OVER"
;   0x4f7f..0x4f89  (10 bytes)
DATA_texto_blancos:
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,000h	; 4f7f           .

; ======================================================================
; CODIGO 0x4f89..0x504b  (194 bytes)
; ======================================================================


mira_continuar:
	call lee_mandos		;4f89
	pop hl			;4f8c
	ld a,(0d573h)		;4f8d   ; boton 1 (ESPACIO): continua en la misma fase
	bit 4,a		;4f90
	jp nz,continua		;4f92
	bit 5,a		;4f95   ; boton 2 (GRAPH): se acaba
	jr nz,se_acaba		;4f97
	dec hl			;4f99   ; un cuadro menos
	ld a,h			;4f9a
	or l			;4f9b
	jp nz,cuenta_continuar		;4f9c   ; aun queda tiempo
se_acaba:
	ld a,001h		;4f9f   ; bancos 1 y 2: el sonido
	ld (0d190h),a		;4fa1   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4fa4   ; registro del mapper: banco A en 0x6000
	ld a,002h		;4fa7
	ld (0d191h),a		;4fa9   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4fac   ; registro del mapper: banco A en 0x8000
	call 00041h		;4faf   ; BIOS DISSCR - Inhibits the screen display | pantalla apagada mientras...
	call 06077h		;4fb2   ; ...p01:6077 rehace el VDP
	call 00044h		;4fb5   ; BIOS ENASCR - Displays the screen
	ld a,000h		;4fb8   ; sin efecto
	ld (0d17ah),a		;4fba   ; musica pedida, para p01:640F = a
	xor a			;4fbd   ; vuelta a la fase 0...
	ld (0d5e5h),a		;4fbe   ; la fase = a
	jp tarea_principal		;4fc1   ; ...y a la presentacion desde el principio
continua:
	ld a,001h		;4fc4   ; lo mismo pero sin tocar la fase (D5E5)
	ld (0d190h),a		;4fc6   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;4fc9   ; registro del mapper: banco A en 0x6000
	ld a,002h		;4fcc
	ld (0d191h),a		;4fce   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;4fd1   ; registro del mapper: banco A en 0x8000
	call 00041h		;4fd4   ; BIOS DISSCR - Inhibits the screen display
	call 06077h		;4fd7
	call 00044h		;4fda   ; BIOS ENASCR - Displays the screen
	jp presentacion		;4fdd   ; a jugar otra vez

; ----------------------------------------------------------------------
; Pone la partida a cero y pinta la pantalla de titulo.
; ----------------------------------------------------------------------
pantalla_titulo:
	ld a,000h		;4fe0   ; sin musica ni efecto
	ld (0d178h),a		;4fe2   ; efecto pedido, para p01:63E1 = a
	ld a,000h		;4fe5
	ld (0d17ah),a		;4fe7   ; musica pedida, para p01:640F = a
	xor a			;4fea   ; D17D, D905, D919, D926, D91E-D921 y D90D-D910 a 0
	ld (0d17dh),a		;4feb   ; bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo = a
	ld (0d905h),a		;4fee   ; lo que lleva Rastan: bits 0-1 arma, 2-3 escudo, 5 puntos dobles, 6 escudo doble, 7 arma doble = a
	ld (0d919h),a		;4ff1   ; el arma que lleva = a
	ld (0d926h),a		;4ff4   ; los golpes que le quedan al escudo = a
	ld (0d91eh),a		;4ff7   ; la puntuacion, cuatro bytes BCD = a
	ld (0d91fh),a		;4ffa   ; puntuacion, cifras 3-4 = a
	ld (0d920h),a		;4ffd   ; puntuacion, cifras 5-6 = a
	ld (0d921h),a		;5000   ; puntuacion, byte 4; bit 7: ha cambiado = a
	ld (0d90dh),a		;5003
	ld (0d90eh),a		;5006
	ld (0d90fh),a		;5009   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld (0d910h),a		;500c   ; bits: 0 en la salida, 6 jefe, 7 no pierde vida = a
	call limpia_fichas_sprite		;500f   ; sprites a cero y ocultos
	ld ix,0d413h		;5012   ; ix -> las 32 fichas de sprite
	ld b,020h		;5016
	call fichas_a_atributos		;5018
	xor a			;501b   ; D181 = 0
	ld (0d181h),a		;501c   ; 5 = la demo ha terminado = a
	call borra_vram		;501f   ; VRAM a 0
	call pinta_titulo		;5022   ; carga los graficos del titulo (p00:5124)
	ld hl,05227h		;5025   ; el logotipo: la lista de tiles de p00:5227...
	ld de,00000h		;5028
	ld b,010h		;502b   ; ...16 de alto por 0x50 de ancho...
	ld c,050h		;502d
	ld a,0a0h		;502f   ; ...desde y = 0xA0...
	ld (0d5d7h),a		;5031   ; y donde se pinta = a
	ld a,058h		;5034   ; ...x = 0x58
	ld (0d5d6h),a		;5036   ; x donde se pinta = a
	exx			;5039   ; opaco
	ld b,000h		;503a
	exx			;503c
	call pinta_bloque_tiles		;503d   ; pintado
	exx			;5040
	ld b,000h		;5041
	exx			;5043
	ld d,0b8h		;5044   ; en (0x20, 0xB8)
	ld e,020h		;5046
	call escribe_texto		;5048

; ----------------------------------------------------------------------
; DATOS texto_taito: "@ TAITO CORPORATION 1988" (la @ es el tile 12, el de
;   delante de la A)
;   0x504b..0x5064  (25 bytes)
DATA_texto_taito:
	defb 040h,020h,054h,041h,049h,054h,04fh,020h,043h,04fh,052h,050h,04fh,052h,041h,054h	; 504b  @ TAITO CORPORAT
	defb 049h,04fh,04eh,020h,031h,039h,038h,038h,000h	; 505b  ION 1988.

; ======================================================================
; CODIGO 0x5064..0x506f  (11 bytes)
; ======================================================================


	exx			;5064
	ld b,000h		;5065
	exx			;5067
	ld d,0c0h		;5068   ; en (0x38, 0xC0)
	ld e,038h		;506a
	call escribe_texto		;506c

; ----------------------------------------------------------------------
; DATOS texto_derechos: "ALL RIGHTS RESERVED"
;   0x506f..0x5083  (20 bytes)
DATA_texto_derechos:
	defb 041h,04ch,04ch,020h,052h,049h,047h,048h,054h,053h,020h,052h,045h,053h,045h,052h	; 506f  ALL RIGHTS RESER
	defb 056h,045h,044h,000h	; 507f

; ======================================================================
; CODIGO 0x5083..0x508e  (11 bytes)
; ======================================================================


escribe_push_space:
	exx			;5083
	ld b,000h		;5084
	exx			;5086
	ld d,088h		;5087   ; en (0x40, 0x88)
	ld e,040h		;5089
	call escribe_texto		;508b

; ----------------------------------------------------------------------
; DATOS texto_push_space_2: "PUSH SPACE KEY"
;   0x508e..0x509d  (15 bytes)
DATA_texto_push_space_2:
	defb 050h,055h,053h,048h,020h,053h,050h,041h,043h,045h,020h,04bh,045h,059h,000h	; 508e  PUSH SPACE KEY.

; ======================================================================
; CODIGO 0x509d..0x50ad  (16 bytes)
; ======================================================================


	ld a,00fh		;509d   ; medio cuarto de segundo (15 cuadros) con el texto...
	call duerme		;509f
	exx			;50a2
	ld b,000h		;50a3
	exx			;50a5
	ld d,088h		;50a6   ; ...y otro tanto con espacios encima: parpadea
	ld e,040h		;50a8
	call escribe_texto		;50aa

; ----------------------------------------------------------------------
; DATOS texto_blancos_2: catorce espacios: borran "PUSH SPACE KEY"
;   0x50ad..0x50bc  (15 bytes)
DATA_texto_blancos_2:
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,000h	; 50ad                .

; ======================================================================
; CODIGO 0x50bc..0x50ea  (46 bytes)
; ======================================================================


	ld a,00fh		;50bc   ; 15 cuadros
	call duerme		;50be
	ld a,(0d181h)		;50c1   ; D181 = 5: la demo ha terminado (lo pone la tarea 1)
	cp 005h		;50c4
	jr z,fin_de_demo		;50c6
	call lee_mandos		;50c8   ; boton 1...
	ld a,(0d573h)		;50cb   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	bit 4,a		;50ce
	jr z,$-77		;50d0   ; ...no: sigue parpadeando (p00:5083)
	ret			;50d2   ; pulsado: a jugar
fin_de_demo:
	xor a			;50d3   ; D181 a 0
	ld (0d181h),a		;50d4   ; 5 = la demo ha terminado = a
	call borra_vram		;50d7   ; VRAM a 0
	ld a,080h		;50da   ; D17D = 0x80
	ld (0d17dh),a		;50dc   ; bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo = a
	exx			;50df
	ld b,000h		;50e0
	exx			;50e2
	ld d,070h		;50e3   ; en (0x60, 0x70)
	ld e,060h		;50e5
	call escribe_texto		;50e7

; ----------------------------------------------------------------------
; DATOS texto_game_over_demo: "GAME OVER" (al acabar la demo)
;   0x50ea..0x50f4  (10 bytes)
DATA_texto_game_over_demo:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 50ea  GAME OVER.

; ======================================================================
; CODIGO 0x50f4..0x5189  (149 bytes)
; ======================================================================


	ld a,032h		;50f4   ; 50 cuadros
	call duerme		;50f6
	ld a,001h		;50f9   ; la tarea 1 otra vez
	call crea_tarea		;50fb
espera_en_demo:
	call cede		;50fe
	call lee_mandos		;5101   ; boton 1 pulsado: se corta
	ld a,(0d573h)		;5104   ; a = los mandos: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton 1, 5 boton 2
	bit 4,a		;5107
	jr nz,corta_demo		;5109
	ld a,(0d181h)		;510b   ; D181 = 5: la demo acabo sola
	cp 005h		;510e
	jr nz,espera_en_demo		;5110
	ld hl,0d17dh		;5112   ; D17D: bit 1 = 1, bit 7 = 0...
	set 1,(hl)		;5115
	res 7,(hl)		;5117
	jp pantalla_titulo		;5119   ; ...y otra vez la pantalla de titulo
corta_demo:
	ld hl,0d17dh		;511c   ; igual, pero vuelve a quien llamo
	set 1,(hl)		;511f
	res 7,(hl)		;5121
	ret			;5123

; ----------------------------------------------------------------------
; El titulo: para las tareas, apaga la pantalla, pinta el dibujo con bloques
; de 16x16 de la tabla de p00:5D27, pone su paleta y lo sube desde abajo
; subiendo el desplazamiento vertical de 0xF0 a 0.
; ----------------------------------------------------------------------
pinta_titulo:
	ld a,004h		;5124   ; para las tareas 4, 3, 2 y 1
	call para_tarea_y_cede		;5126
	ld a,003h		;5129
	call para_tarea_y_cede		;512b
	ld a,002h		;512e
	call para_tarea_y_cede		;5130
	ld a,001h		;5133
	call para_tarea_y_cede		;5135
	call limpia_fichas_sprite		;5138   ; sprites a cero y ocultos
	ld ix,0d413h		;513b   ; ix -> las 32 fichas de sprite
	ld b,020h		;513f
	call fichas_a_atributos		;5141
	call 00041h		;5144   ; BIOS DISSCR - Inhibits the screen display | pantalla apagada
	ld a,0f0h		;5147   ; desplazamiento vertical 0xF0: el dibujo empieza abajo
	ld (0d5e0h),a		;5149   ; el desplazamiento vertical de la pantalla = a
	ld hl,05d27h		;514c   ; la tabla de bloques del titulo
	ld (0d5eah),hl		;514f   ; la tabla de bloques de 16x16 de la fase = hl
	ld hl,05189h		;5152   ; la lista de p00:5189...
	ld de,00000h		;5155
	ld b,007h		;5158   ; ...7 filas...
	ld c,009h		;515a   ; ...de 9 bloques...
	ld a,010h		;515c   ; ...desde y = 0x10...
	ld (0d5d7h),a		;515e   ; y donde se pinta = a
	ld a,040h		;5161   ; ...x = 0x40
	ld (0d5d6h),a		;5163   ; x donde se pinta = a
	exx			;5166   ; transparente
	ld b,001h		;5167
	exx			;5169
	call pinta_bloque_16		;516a   ; pintado
	ld hl,05207h		;516d   ; la paleta del titulo (p00:5207)
	call pon_paleta		;5170
	call 00044h		;5173   ; BIOS ENASCR - Displays the screen | pantalla encendida
sube_titulo:
	call pon_scroll_vertical		;5176   ; el desplazamiento al VDP
	ld a,002h		;5179   ; cada 2 cuadros...
	call duerme		;517b
	ld a,(0d5e0h)		;517e   ; ...hasta llegar a 0...
	and a			;5181
	ret z			;5182
	inc a			;5183   ; ...una linea mas
	ld (0d5e0h),a		;5184   ; el desplazamiento vertical de la pantalla = a
	jr sube_titulo		;5187

; ----------------------------------------------------------------------
; DATOS titulo_bloques: El dibujo del titulo: 7 filas x 9 bloques de 16x16
;   (palabras; 0 = vacio)
;   0x5189..0x5207  (126 bytes)
DATA_titulo_bloques:
	defw 00000h,00000h,00000h,00002h,00003h,00000h,00000h,00000h,00000h	; 5189
	defw 00004h,00005h,00006h,00007h,00008h,00009h,0000ah,00000h,00000h	; 519b
	defw 0000bh,0000ch,0000dh,0000eh,0000fh,00010h,00011h,00000h,00000h	; 51ad
	defw 00012h,00013h,00014h,00015h,00016h,00017h,00018h,00019h,00000h	; 51bf
	defw 00000h,0001ah,00000h,0001bh,0001ch,0001dh,0001eh,0001fh,00000h	; 51d1
	defw 00000h,00000h,00000h,00020h,00021h,00022h,00023h,00024h,00025h	; 51e3
	defw 00000h,00000h,00000h,00026h,00027h,00000h,00000h,00000h,00000h	; 51f5

; ----------------------------------------------------------------------
; DATOS titulo_paleta: La paleta del titulo: 16 colores x 2 bytes (0RRR0BBB,
;   00000GGG)
;   0x5207..0x5227  (32 bytes)
DATA_titulo_paleta:
	defw 00000h,00664h,00550h,00450h,00340h,00330h,00070h,00220h	; 5207
	defw 00000h,00444h,07777h,00222h,00000h,00010h,00333h,00032h	; 5217

; ----------------------------------------------------------------------
; DATOS logo_taito: El rotulo de abajo: 2 filas x 10 tiles de 8x8 (palabras)
;   0x5227..0x524f  (40 bytes)
DATA_logo_taito:
	defw 00027h,00028h,00029h,0002ah,0002bh,0002ch,0002dh,0002eh,0002fh,00030h	; 5227
	defw 00000h,00031h,00032h,00033h,00034h,00035h,00036h,00037h,00038h,00039h	; 523b

; ======================================================================
; CODIGO 0x524f..0x553a  (747 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; TAREA 1: la partida. Pinta el marcador, pone a cero al jugador, arranca
; las tareas 2, 3 y 4 y entra en la primera pantalla de la fase.
; ----------------------------------------------------------------------
tarea_partida:
	ld hl,0584bh		;524f   ; el marcador: la lista de tiles de p00:584B...
	ld de,00000h		;5252
	ld b,010h		;5255   ; ...16 de alto, 0xF0 de ancho...
	ld c,0f0h		;5257
	ld a,000h		;5259   ; ...en (0, 0)
	ld (0d5d7h),a		;525b   ; y donde se pinta = a
	ld a,000h		;525e
	ld (0d5d6h),a		;5260   ; x donde se pinta = a
	exx			;5263
	ld b,000h		;5264
	exx			;5266
	call pinta_bloque_tiles		;5267   ; pintado en la pagina 0
	ld hl,00000h		;526a   ; y copiado: 256 x 0x10 lineas de y = 0 a y = 0x28 de la pagina 1
	ld de,010f0h		;526d
	ld bc,02800h		;5270
	xor a			;5273
	ex af,af'			;5274
	ld a,001h		;5275
	ex af,af'			;5277
	call copia_vram_vram		;5278
	ld a,001h		;527b   ; DB52 y DB53 = 1
	ld (0db52h),a		;527d
	ld (0db53h),a		;5280
	call borra_vram		;5283   ; VRAM a 0
	ld a,0a0h		;5286   ; D91C y D91D = 0xA0
	ld (0d91dh),a		;5288   ; el largo total de la barra = a
	ld (0d91ch),a		;528b   ; la vida de Rastan = a
	ld a,001h		;528e   ; D902 = 1, D903 = 0xFE
	ld (0d902h),a		;5290
	ld a,0feh		;5293
	ld (0d903h),a		;5295
	xor a			;5298   ; D90D-D910, D924-D925 y D91E-D921 a 0
	ld (0d90dh),a		;5299
	ld (0d90eh),a		;529c
	ld (0d90fh),a		;529f   ; bit 7 muerto, bit 4 un rato sin mandos = a
	ld (0d910h),a		;52a2   ; bits: 0 en la salida, 6 jefe, 7 no pierde vida = a
	ld (0d925h),a		;52a5   ; la vida que muestra la barra = a
	ld (0d924h),a		;52a8   ; bit 7: el jugador usa la ficha 10 = a
	ld (0d91eh),a		;52ab   ; la puntuacion, cuatro bytes BCD = a
	ld (0d91fh),a		;52ae   ; puntuacion, cifras 3-4 = a
	ld (0d920h),a		;52b1   ; puntuacion, cifras 5-6 = a
	ld (0d921h),a		;52b4   ; puntuacion, byte 4; bit 7: ha cambiado = a
	ld a,001h		;52b7   ; DA1F = 1
	ld (0da1fh),a		;52b9
	ld hl,0da20h		;52bc   ; DA1D = DA20
	ld (0da1dh),hl		;52bf
	ld a,001h		;52c2   ; DA1C = 1
	ld (0da1ch),a		;52c4
	ld hl,0d933h		;52c7   ; DA1A = D933, la lista de actores
	ld (0da1ah),hl		;52ca
	ld a,002h		;52cd   ; arranca las tareas 2 (p00:56F2), 3 (p00:5760) y 4 (p00:5799)
	call crea_tarea		;52cf
	ld a,003h		;52d2
	call crea_tarea		;52d4
	ld a,004h		;52d7
	call crea_tarea		;52d9
	call pinta_marcador		;52dc   ; p00:5805
entra_en_fase:
	call ficha_de_fase		;52df   ; la ficha de la fase (p00:5655)...
	jp nueva_pantalla		;52e2   ; ...y su pantalla

; ----------------------------------------------------------------------
; El bucle de la partida, cada dos cuadros: pausa, fin de fase, trucos de
; pruebas, fin de partida y el paso de una pantalla a otra cuando el
; jugador sale por un borde.
; ----------------------------------------------------------------------
bucle_partida:
	ld a,007h		;52e5   ; fila 7 del teclado, bit 4: STOP
	call 00141h		;52e7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 4,a		;52ea
	jr nz,cada_dos_cuadros		;52ec
L_52EE:
	ld a,007h		;52ee   ; pulsada: se espera a que se suelte...
	call 00141h		;52f0   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 4,a		;52f3
	jr z,L_52EE		;52f5
	ld a,(0d5dfh)		;52f7   ; ...y D5DF cambia: pausa
	cpl			;52fa
	ld (0d5dfh),a		;52fb   ; 0xFF = el juego corre, 0 = pausa = a
cada_dos_cuadros:
	ld a,002h		;52fe   ; dos cuadros
	call duerme		;5300
	ld hl,0d910h		;5303   ; D910 bit 0: fase acabada
	bit 0,(hl)		;5306
	jr nz,fase_siguiente		;5308
	ld hl,0d17dh		;530a   ; o D17D bit 0 (se borra al mirarlo)
	bit 0,(hl)		;530d
	res 0,(hl)		;530f
	jr z,truco_fases		;5311
fase_siguiente:
	ld hl,0d5e5h		;5313   ; D5E5 + 1: la fase siguiente
	inc (hl)			;5316
	ld a,(hl)			;5317
	cp 011h		;5318   ; la 0x11 no se juega: de la 0x10 se pasa a la 0x12
	jp nz,entra_en_fase		;531a
	inc (hl)			;531d
	jp entra_en_fase		;531e
truco_fases:
	ld a,(04010h)		;5321   ; con el byte 0x4010 de la cabecera encendido...
	and a			;5324
	jp z,mira_fin_partida		;5325
	ld a,000h		;5328   ; ...fila 0: tecla 7 = fase siguiente...
	call 00141h		;532a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld hl,0d5e5h		;532d   ; hl -> la fase
	and 0c0h		;5330
	bit 7,a		;5332
	jr nz,L_533A		;5334
	inc (hl)			;5336   ; (7)
	jp entra_en_fase		;5337
L_533A:
	bit 6,a		;533a   ; ...tecla 6 = fase anterior
	jr nz,mira_fin_partida		;533c
	dec (hl)			;533e
	jp entra_en_fase		;533f
mira_fin_partida:
	ld a,(0d17dh)		;5342   ; D17D bit 1: la partida se acaba
	bit 1,a		;5345
	jr nz,acaba_partida		;5347
	ld a,(04010h)		;5349   ; con el interruptor de pruebas, BS (fila 7 bit 5) tambien la acaba
	and a			;534c
	jp z,mira_bordes		;534d
	ld a,007h		;5350
	call 00141h		;5352   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 5,a		;5355
	jp nz,mira_bordes		;5357
acaba_partida:
	ld hl,0d17dh		;535a   ; D17D bit 6: aviso a la tarea 0
	set 6,(hl)		;535d
	ld a,002h		;535f   ; para la tarea 2
	call para_tarea_y_cede		;5361
	jp cada_dos_cuadros		;5364
mira_bordes:
	ld a,(0d8fch)		;5367   ; donde aparecera el jugador: de entrada, donde esta (D8FC = x, D8FD = y)
	ld (0d92eh),a		;536a   ; x donde aparece el jugador en la pantalla nueva = a
	ld a,(0d8fdh)		;536d   ; a = la y de Rastan
	ld (0d92fh),a		;5370   ; y donde aparece el jugador = a
	ld a,(0d8fch)		;5373   ; por la izquierda (x < 7)...
	cp 007h		;5376
	jr nc,borde_derecho		;5378
	ld a,0dah		;537a   ; ...aparecera a la derecha (x = 0xDA)
	ld (0d92eh),a		;537c   ; x donde aparece el jugador en la pantalla nueva = a
	ld a,(0d5f0h)		;537f   ; columna 0: no hay pantalla a la izquierda
	and a			;5382
	jp z,bucle_partida		;5383
	dec a			;5386   ; columna - 1 (D5F0)
	ld (0d5f0h),a		;5387   ; la columna de la pantalla en que se esta = a
	ld a,(0d8fdh)		;538a   ; y si estaba arriba del todo...
	cp 019h		;538d
	jp nc,nueva_pantalla		;538f
	ld a,023h		;5392   ; ...baja a y = 0x23
	ld (0d92fh),a		;5394   ; y donde aparece el jugador = a
	jp nueva_pantalla		;5397
borde_derecho:
	ld a,(0d8fch)		;539a   ; por la derecha (x >= 0xE2)...
	cp 0e2h		;539d
	jr c,borde_inferior		;539f
	ld a,00fh		;53a1   ; ...aparecera a la izquierda (x = 0x0F)
	ld (0d92eh),a		;53a3   ; x donde aparece el jugador en la pantalla nueva = a
	ld a,(0d5eeh)		;53a6   ; la ultima columna (D5EE)...
	ld b,a			;53a9
	ld a,(0d5f0h)		;53aa   ; ...no tiene pantalla a la derecha
	cp b			;53ad
	jp z,bucle_partida		;53ae
	inc a			;53b1   ; columna + 1
	ld (0d5f0h),a		;53b2   ; la columna de la pantalla en que se esta = a
	ld a,(0d8fdh)		;53b5   ; a = la y de Rastan
	cp 019h		;53b8
	jp nc,nueva_pantalla		;53ba
	ld a,023h		;53bd
	ld (0d92fh),a		;53bf   ; y donde aparece el jugador = a
	jp nueva_pantalla		;53c2
borde_inferior:
	ld a,(0d8fdh)		;53c5   ; por abajo (y >= 0xAF)...
	cp 0afh		;53c8
	jp c,borde_superior		;53ca
	ld a,023h		;53cd   ; ...aparecera arriba (y = 0x23)
	ld (0d92fh),a		;53cf   ; y donde aparece el jugador = a
	ld a,(0d5efh)		;53d2   ; la ultima fila (D5EF)...
	ld b,a			;53d5
	ld a,(0d5f1h)		;53d6   ; a = la fila de la pantalla en que se esta
	cp b			;53d9
	jp z,bucle_partida		;53da
	inc a			;53dd   ; fila + 1 (D5F1)
	ld (0d5f1h),a		;53de   ; la fila de la pantalla en que se esta = a
	jp nueva_pantalla		;53e1
borde_superior:
	ld a,(0d90dh)		;53e4   ; por arriba solo si trepa: D90D con los bits 0xC2 a 0x80 o 0x82
	and 0c2h		;53e7
	cp 080h		;53e9
	jr z,sigue_en_pantalla		;53eb
	cp 082h		;53ed
	jr z,sigue_en_pantalla		;53ef
	ld a,(0d8fdh)		;53f1   ; y en lo alto (y < 0x19)
	cp 019h		;53f4
	jp nc,sigue_en_pantalla		;53f6
	ld a,0a5h		;53f9   ; aparecera abajo (y = 0xA5)
	ld (0d92fh),a		;53fb   ; y donde aparece el jugador = a
	ld a,(0d5f1h)		;53fe   ; fila 0: no hay pantalla encima
	and a			;5401
	jp z,bucle_partida		;5402
	dec a			;5405   ; fila - 1
	ld (0d5f1h),a		;5406   ; la fila de la pantalla en que se esta = a
	jp nueva_pantalla		;5409
sigue_en_pantalla:
	jp bucle_partida		;540c

; ----------------------------------------------------------------------
; Cambio de pantalla: para las tareas 2-4, pone al jugador quieto, pinta la
; pantalla nueva desde el mapa de la fase y la deja lista.
; ----------------------------------------------------------------------
nueva_pantalla:
	call 00041h		;540f   ; BIOS DISSCR - Inhibits the screen display | pantalla apagada
	ld a,004h		;5412   ; para las tareas 4, 3 y 2
	call para_tarea_y_cede		;5414
	ld a,003h		;5417
	call para_tarea_y_cede		;5419
	ld a,002h		;541c
	call para_tarea_y_cede		;541e
	ld hl,0d90dh		;5421   ; D90D = 0xC0, D90E y D90F = 0
	ld (hl),0c0h		;5424
	ld hl,0d90eh		;5426
	ld (hl),000h		;5429
	ld hl,0d90fh		;542b   ; hl -> bit 7 muerto, bit 4 un rato sin mandos
	ld (hl),000h		;542e
	ld hl,0d910h		;5430   ; D910: se queda el bit 7 y se pone el 4
	ld a,(hl)			;5433
	and 080h		;5434
	or 010h		;5436
	ld (hl),a			;5438
	ld hl,0d924h		;5439   ; D924 = 0
	ld (hl),000h		;543c
	ld hl,0d902h		;543e   ; D902 = 0xFE, D903 = 1
	ld (hl),0feh		;5441
	ld hl,0d903h		;5443
	ld (hl),001h		;5446
	ld a,0ffh		;5448   ; D8F7 y D8F8 = 0xFF
	ld (0d8f7h),a		;544a   ; la pose del cuadro anterior = a
	ld (0d8f8h),a		;544d   ; D8F5 del cuadro anterior = a
	ld a,027h		;5450   ; D913 = 0x27
	ld (0d913h),a		;5452   ; cuenta del estado del jugador = a
	call limpia_fichas_sprite		;5455   ; sprites a cero y ocultos
	ld ix,0d413h		;5458   ; ix -> las 32 fichas de sprite
	ld b,020h		;545c
	call fichas_a_atributos		;545e
	ld a,(0d5f1h)		;5461   ; fila 0: el mapa de D5E1; las demas: el de D5E3
	ld hl,(0d5e1h)		;5464   ; hl = el mapa de fondo de la fila 0 de pantallas
	and a			;5467
	jr z,L_546D		;5468
	ld hl,(0d5e3h)		;546a   ; hl = el mapa de fondo de las demas filas
L_546D:
	ld a,h			;546d   ; sin mapa: no se pinta fondo
	or l			;546e
	jr z,pantalla_de_delante		;546f
	ld de,0d5f4h		;5471   ; la pantalla, desempaquetada en D5F4...
	call desempaqueta_mapa		;5474   ; ...por p00:557D
	ld hl,0d5f4h		;5477   ; y pintada: 11 filas x 16 bloques de 16x16...
	ld de,00000h		;547a
	ld b,00bh		;547d
	ld c,010h		;547f
	ld a,020h		;5481   ; ...desde y = 0x20
	ld (0d5d7h),a		;5483   ; y donde se pinta = a
	ld a,000h		;5486
	ld (0d5d6h),a		;5488   ; x donde se pinta = a
	exx			;548b   ; opaca
	ld b,000h		;548c
	exx			;548e
	push ix		;548f
	call pinta_bloque_16		;5491
	pop ix		;5494

; ----------------------------------------------------------------------
; La pantalla de delante: la tabla de pantallas de la fase (D5E7) tiene una
; palabra por pantalla, fila a fila; si su byte bajo es 0xFF no hay mapa y el
; alto dice a que columna y fila se salta (un atajo de la fase).
; ----------------------------------------------------------------------
pantalla_de_delante:
	ld de,(0d5e7h)		;5496   ; la tabla de pantallas
	ld a,(0d5f1h)		;549a   ; fila 0: empieza en la primera palabra
	and a			;549d
	jr z,busca_pantalla		;549e
	ld b,a			;54a0
	ld a,(0d5eeh)		;54a1   ; (ultima columna + 1) * 2 bytes por fila...
	inc a			;54a4
	add a,a			;54a5
	ld c,a			;54a6
	xor a			;54a7
L_54A8:
	add a,c			;54a8   ; ...por la fila
	djnz L_54A8		;54a9
	ld l,a			;54ab
	ld h,000h		;54ac
	add hl,de			;54ae
	ex de,hl			;54af
busca_pantalla:
	ld a,(0d5f0h)		;54b0   ; + columna * 2
	add a,a			;54b3
	ld l,a			;54b4
	ld h,000h		;54b5
	ld a,002h		;54b7   ; la tabla esta en el banco 2 (0x8000)
	ld (0d191h),a		;54b9   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;54bc   ; registro del mapper: banco A en 0x8000
	add hl,de			;54bf
	ld e,(hl)			;54c0   ; la palabra de esta pantalla
	inc hl			;54c1
	ld d,(hl)			;54c2
	ld a,e			;54c3   ; 0xFFxx: no es una pantalla sino un salto...
	cp 0ffh		;54c4
	jp nz,pinta_delante		;54c6
	ld a,d			;54c9   ; ...nibble alto = columna...
	and 0f0h		;54ca
	srl a		;54cc
	srl a		;54ce
	srl a		;54d0
	srl a		;54d2
	ld (0d5f0h),a		;54d4   ; la columna de la pantalla en que se esta = a
	ld a,d			;54d7   ; ...nibble bajo = fila...
	and 00fh		;54d8
	ld (0d5f1h),a		;54da   ; la fila de la pantalla en que se esta = a
	jp pantalla_de_delante		;54dd   ; ...y se busca otra vez
pinta_delante:
	ex de,hl			;54e0
	ld de,0d774h		;54e1   ; desempaquetada en D774
	call desempaqueta_mapa		;54e4
	ld hl,0d774h		;54e7   ; pintada encima del fondo: 11 filas x 16 bloques desde y = 0x20...
	ld de,00000h		;54ea
	ld b,00bh		;54ed
	ld c,010h		;54ef
	ld a,020h		;54f1
	ld (0d5d7h),a		;54f3   ; y donde se pinta = a
	ld a,000h		;54f6
	ld (0d5d6h),a		;54f8   ; x donde se pinta = a
	exx			;54fb   ; ...con el color 0 transparente
	ld b,001h		;54fc
	exx			;54fe
	push ix		;54ff
	call pinta_bloque_16		;5501
	pop ix		;5504
	ld de,0d774h		;5506   ; lo que va detras del mapa: columnas que se alargan (p00:55C5)
	call alarga_columnas		;5509
	ld hl,0d8d4h		;550c   ; D8D4-D8F3 a 0xFF
	ld de,0d8d5h		;550f
	ld bc,0001fh		;5512
	ld (hl),0ffh		;5515
	ldir		;5517
	call actores_de_pantalla		;5519   ; los actores de la pantalla (p00:58F9)
	call limpia_fichas_sprite		;551c   ; sprites a cero
	ld ix,0d476h		;551f   ; y las fichas 9-30 a atributos
	ld b,016h		;5523
	call fichas_a_atributos		;5525
	ld a,(0d17dh)		;5528   ; D17D bit 7: la demo
	bit 7,a		;552b
	jr z,$+23		;552d
	exx			;552f   ; en (0x60, 0x70), transparente
	ld b,001h		;5530
	exx			;5532
	ld d,070h		;5533
	ld e,060h		;5535
	call escribe_texto		;5537

; ----------------------------------------------------------------------
; DATOS texto_game_over_3: "GAME OVER" (encima de la demo)
;   0x553a..0x5544  (10 bytes)
DATA_texto_game_over_3:
	defb 047h,041h,04dh,045h,020h,04fh,056h,045h,052h,000h	; 553a  GAME OVER.

; ======================================================================
; CODIGO 0x5544..0x57d3  (655 bytes)
; ======================================================================


pantalla_lista:
	ld ix,0d413h		;5544   ; los 32 sprites a atributos
	ld b,020h		;5548
	call fichas_a_atributos		;554a
	ld a,(0d92eh)		;554d   ; el jugador, donde se decidio en p00:5367
	ld (0d8fch),a		;5550   ; la x de Rastan = a
	ld a,(0d92fh)		;5553   ; a = y donde aparece el jugador
	ld (0d8fdh),a		;5556   ; la y de Rastan = a
	ld a,004h		;5559   ; arranca otra vez las tareas 4, 3 y 2
	call crea_tarea		;555b
	ld a,003h		;555e
	call crea_tarea		;5560
	ld a,002h		;5563
	call crea_tarea		;5565
	call 00044h		;5568   ; BIOS ENASCR - Displays the screen | pantalla encendida
	ld hl,0d90dh		;556b   ; D90D = 0xC0, D90E y D90F = 0
	ld (hl),0c0h		;556e
	ld hl,0d90eh		;5570
	ld (hl),000h		;5573
	ld hl,0d90fh		;5575   ; hl -> bit 7 muerto, bit 4 un rato sin mandos
	ld (hl),000h		;5578
	jp bucle_partida		;557a   ; y al bucle de la partida

; ----------------------------------------------------------------------
; Desempaqueta un mapa (HL) en DE: palabras de bloque, salvo 0xD0nn que
; repite la palabra siguiente nn veces; acaba en una palabra con E & D = 0xEF.
; Los mapas estan en el banco de la ficha de fase (D5E9) y el siguiente.
; ----------------------------------------------------------------------
desempaqueta_mapa:
	ld a,(0d5e9h)		;557d   ; banco del mapa en 0x8000...
	ld (0d191h),a		;5580   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;5583   ; registro del mapper: banco A en 0x8000
	inc a			;5586   ; ...y el siguiente en 0xA000
	ld (0d192h),a		;5587   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;558a   ; registro del mapper: banco A en 0xA000
	push hl			;558d   ; IX = el mapa, HL = el destino
	pop ix		;558e
	ex de,hl			;5590
siguiente_palabra:
	ld e,(ix+000h)		;5591   ; la palabra
	ld d,(ix+001h)		;5594
	ld a,e			;5597   ; 0xEFEF (o cualquiera con E & D = 0xEF): fin
	and d			;5598
	cp 0efh		;5599
	jp z,L_55C4		;559b
	ld a,d			;559e   ; 0xD0nn: repeticion
	cp 0d0h		;559f
	jr nz,copia_palabra		;55a1
	ld b,e			;55a3   ; nn veces...
	inc ix		;55a4
	inc ix		;55a6
	ld e,(ix+000h)		;55a8   ; ...la palabra que sigue
	ld d,(ix+001h)		;55ab
L_55AE:
	ld (hl),e			;55ae
	inc hl			;55af
	ld (hl),d			;55b0
	inc hl			;55b1
	djnz L_55AE		;55b2
	inc ix		;55b4   ; se saltan las dos palabras
	inc ix		;55b6
	jr siguiente_palabra		;55b8
copia_palabra:
	ld (hl),e			;55ba   ; una palabra tal cual
	inc hl			;55bb
	ld (hl),d			;55bc
	inc hl			;55bd
	inc ix		;55be   ; la siguiente
	inc ix		;55c0
	jr siguiente_palabra		;55c2
L_55C4:
	ret			;55c4

; ----------------------------------------------------------------------
; Lo que va detras del mapa de delante (IX, tras su 0xEFEF): fichas de 6
; bytes [casilla, palabra-0x8000, palabra-0x9000, alto], acabadas en 0xFF.
; Cada una pone dos palabras en D774 y las copia hacia abajo `alto` filas.
; ----------------------------------------------------------------------
alarga_columnas:
	ld a,(0d5e9h)		;55c5   ; los bancos del mapa
	ld (0d191h),a		;55c8   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;55cb   ; registro del mapper: banco A en 0x8000
	inc a			;55ce
	ld (0d192h),a		;55cf   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;55d2   ; registro del mapper: banco A en 0xA000
	inc ix		;55d5   ; se salta el final del mapa
	inc ix		;55d7
siguiente_columna:
	ld a,(ix+000h)		;55d9   ; 0xFF: no hay mas
	cp 0ffh		;55dc
	jp z,repinta_delante		;55de
	ld l,a			;55e1   ; casilla * 2 + D774
	ld h,000h		;55e2
	add hl,hl			;55e4
	ld de,0d774h		;55e5   ; de -> lo de delante desempaquetado: 11 x 16 bloques
	add hl,de			;55e8
	push hl			;55e9
	ld l,(ix+001h)		;55ea   ; primera palabra + 0x8000
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
	ld l,(ix+003h)		;55fb   ; segunda palabra + 0x9000
	ld h,(ix+004h)		;55fe
	ld de,09000h		;5601
	add hl,de			;5604
	ex de,hl			;5605
	pop hl			;5606
	ld (hl),e			;5607
	inc hl			;5608
	ld (hl),d			;5609
	inc hl			;560a
	ld b,(ix+005h)		;560b   ; alto: cuantas filas se copia hacia abajo
	ex de,hl			;560e
copia_fila_abajo:
	push bc			;560f
	dec de			;5610   ; los 4 bytes recien puestos...
	dec de			;5611
	dec de			;5612
	dec de			;5613
	push de			;5614
	ld hl,00020h		;5615   ; ...a la fila de debajo (16 palabras = 0x20 bytes)
	add hl,de			;5618
	ex de,hl			;5619
	pop hl			;561a
	ldi		;561b
	ldi		;561d
	ldi		;561f
	ldi		;5621
	pop bc			;5623
	djnz copia_fila_abajo		;5624
	inc ix		;5626   ; la ficha siguiente
	inc ix		;5628
	inc ix		;562a
	inc ix		;562c
	inc ix		;562e
	inc ix		;5630
	jp siguiente_columna		;5632
repinta_delante:
	push ix		;5635
	ld hl,0d774h		;5637   ; D774 entera otra vez, transparente
	ld de,00000h		;563a
	ld b,00bh		;563d
	ld c,010h		;563f
	ld a,020h		;5641
	ld (0d5d7h),a		;5643   ; y donde se pinta = a
	ld a,000h		;5646
	ld (0d5d6h),a		;5648   ; x donde se pinta = a
	exx			;564b
	ld b,001h		;564c
	exx			;564e
	call pinta_bloque_16		;564f
	pop ix		;5652
	ret			;5654

; ----------------------------------------------------------------------
; Lee la ficha de la fase D5E5 (16 bytes en p02:9035), escribe el numero de
; ronda y pide su musica.
; ----------------------------------------------------------------------
ficha_de_fase:
	ld a,002h		;5655   ; banco 2 en 0x8000: las fichas
	ld (0d191h),a		;5657   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;565a   ; registro del mapper: banco A en 0x8000
	ld a,(0d5e5h)		;565d   ; fases 0x12 en adelante...
	cp 012h		;5660
	ld a,003h		;5662   ; (musica 3 por defecto)
	ld (0d17ah),a		;5664   ; musica pedida, para p01:640F = a
	ld a,007h		;5667   ; ...ronda 7 y musica 7
	jp nc,L_5680		;5669
	ld a,(0d5e5h)		;566c   ; las demas: B = fase / 3 + 1 (la ronda)...
	ld b,000h		;566f
L_5671:
	inc b			;5671
	sub 003h		;5672
	jp nc,L_5671		;5674
	add a,003h		;5677   ; ...y musica 2, 3 o 4 segun el resto
	inc a			;5679
	inc a			;567a
	ld a,a			;567b   ; (un `ld a,a` que no hace nada)
	ld (0d17ah),a		;567c   ; musica pedida, para p01:640F = a
	ld a,b			;567f   ; A = ronda
L_5680:
	ld de,00830h		;5680   ; el numero de ronda en (0x30, 0x08)
	ex af,af'			;5683
	xor a			;5684
	ex af,af'			;5685
	call escribe_bcd		;5686
	ld a,(0d5e5h)		;5689   ; fase * 16 + 0x9035: su ficha
	add a,a			;568c
	ld l,a			;568d
	ld h,000h		;568e
	add hl,hl			;5690
	add hl,hl			;5691
	add hl,hl			;5692
	ld de,09035h		;5693
	add hl,de			;5696
	ld e,(hl)			;5697   ; +0/1: la tabla de pantallas (D5E7)
	inc hl			;5698
	ld d,(hl)			;5699
	inc hl			;569a
	ld (0d5e7h),de		;569b   ; la tabla de pantallas de la fase = de
	ld e,(hl)			;569f   ; +2/3: la tabla de bloques (D5EA)
	inc hl			;56a0
	ld d,(hl)			;56a1
	inc hl			;56a2
	ld (0d5eah),de		;56a3   ; la tabla de bloques de 16x16 de la fase = de
	ld a,(hl)			;56a7   ; +4: la ultima columna (D5EE)
	inc hl			;56a8
	ld (0d5eeh),a		;56a9   ; la ultima columna de pantallas = a
	ld a,(hl)			;56ac   ; +5: la ultima fila (D5EF)
	inc hl			;56ad
	ld (0d5efh),a		;56ae   ; la ultima fila de pantallas = a
	ld a,(hl)			;56b1   ; +6: la columna de salida (D5F0)
	inc hl			;56b2
	ld (0d5f0h),a		;56b3   ; la columna de la pantalla en que se esta = a
	ld a,(hl)			;56b6   ; +7: la fila de salida (D5F1)
	inc hl			;56b7
	ld (0d5f1h),a		;56b8   ; la fila de la pantalla en que se esta = a
	ld e,(hl)			;56bb   ; +8/9: el fondo de la fila 0 (D5E1)
	inc hl			;56bc
	ld d,(hl)			;56bd
	inc hl			;56be
	ld (0d5e1h),de		;56bf   ; el mapa de fondo de la fila 0 de pantallas = de
	ld e,(hl)			;56c3   ; +A/B: el fondo de las demas filas (D5E3)
	inc hl			;56c4
	ld d,(hl)			;56c5
	inc hl			;56c6
	ld (0d5e3h),de		;56c7   ; el mapa de fondo de las demas filas = de
	ld e,(hl)			;56cb   ; +C/D: la paleta
	inc hl			;56cc
	ld d,(hl)			;56cd
	inc hl			;56ce
	ld a,(hl)			;56cf   ; +E: el banco de los mapas (D5E9)
	ld (0d5e9h),a		;56d0   ; el banco de los mapas de la fase = a
	inc hl			;56d3
	ld a,(hl)			;56d4   ; +F: donde sale el jugador; nibble bajo * 16 = x...
	ld b,a			;56d5
	and 00fh		;56d6
	add a,a			;56d8
	add a,a			;56d9
	add a,a			;56da
	add a,a			;56db
	ld (0d8fch),a		;56dc   ; la x de Rastan = a
	ld (0d92eh),a		;56df   ; x donde aparece el jugador en la pantalla nueva = a
	ld a,b			;56e2   ; ...nibble alto + 0x20 = y
	and 0f0h		;56e3
	add a,020h		;56e5
	ld (0d8fdh),a		;56e7   ; la y de Rastan = a
	ld (0d92fh),a		;56ea   ; y donde aparece el jugador = a
	ex de,hl			;56ed   ; la paleta de la fase
	call pon_paleta		;56ee
	ret			;56f1

; ----------------------------------------------------------------------
; TAREA 2: el jugador. Cada cuadro, si el juego no esta en pausa, mueve a
; Rastan (p06:6000, bancos 6 y 7) y pasa sus sprites a atributos.
; ----------------------------------------------------------------------
tarea_jugador:
	call cede		;56f2   ; un cuadro
	ld a,(0d5dfh)		;56f5   ; D5DF = 0: pausa
	and a			;56f8
	jr z,tarea_jugador		;56f9
	ld a,006h		;56fb   ; bancos 6 y 7
	ld (0d190h),a		;56fd   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;5700   ; registro del mapper: banco A en 0x6000
	ld a,007h		;5703
	ld (0d191h),a		;5705   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;5708   ; registro del mapper: banco A en 0x8000
	call 06000h		;570b   ; el jugador
	ld ix,0d413h		;570e   ; sus 10 fichas de sprite a atributos
	ld b,00ah		;5712
	call fichas_a_atributos		;5714
	ld a,(0d924h)		;5717   ; D924 bit 7: un sprite mas para el jugador (la ficha 10)
	bit 7,a		;571a
	jp z,sin_arma		;571c
	ld a,(0d922h)		;571f   ; su y y su x como desplazamiento
	ld (0d5deh),a		;5722   ; lo que se suma a la y de los sprites = a
	ld a,(0d923h)		;5725   ; a = la x de la ficha 10 del jugador
	ld (0d5ddh),a		;5728   ; lo que se suma a la x de los sprites = a
	ld hl,0d481h		;572b   ; la ficha de sprite 10 (D481)...
	ld iy,0d902h		;572e   ; ...con los datos del jugador (D902)...
	ld ix,0963ah		;5732   ; ...y la definicion de p26:963A
	ex af,af'			;5736   ; A' = 0
	xor a			;5737
	ex af,af'			;5738
	ld a,01ah		;5739   ; banco 26 en 0x8000
	ld (0d191h),a		;573b   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;573e   ; registro del mapper: banco A en 0x8000
	call anima		;5741   ; rellena la ficha
ficha_del_arma:
	ld ix,0d481h		;5744   ; la ficha 10 a atributos
	ld b,001h		;5748
	call fichas_a_atributos		;574a
	jr tarea_jugador		;574d
sin_arma:
	xor a			;574f   ; ficha 10 sin patron...
	ld (0d481h),a		;5750   ; la ficha de sprite 10 = a
	ld (0d482h),a		;5753   ; ficha 10, byte alto del patron = a
	ld (0d488h),a		;5756   ; ficha 10, byte +7 = a
	ld a,0ffh		;5759   ; ...y oculta
	ld (0d484h),a		;575b   ; ficha 10, y = a
	jr ficha_del_arma		;575e

; ----------------------------------------------------------------------
; TAREA 3: los enemigos. Cada cuadro, si no hay pausa, p03:6000 (bancos 3
; y 4). En la ultima fase (0x17) espera y...
; ----------------------------------------------------------------------
tarea_enemigos:
	call cede		;5760   ; un cuadro
	ld a,(0d5dfh)		;5763   ; pausa?
	and a			;5766
	jr z,tarea_enemigos		;5767
	ld a,003h		;5769   ; bancos 3 y 4
	ld (0d190h),a		;576b   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;576e   ; registro del mapper: banco A en 0x6000
	ld a,004h		;5771
	ld (0d191h),a		;5773   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;5776   ; registro del mapper: banco A en 0x8000
	call 06000h		;5779   ; los enemigos
	ld a,(0d5e5h)		;577c   ; fase 0x17?
	cp 017h		;577f
	jr nz,tarea_enemigos		;5781
	ld a,0c8h		;5783   ; 400 cuadros
	call duerme		;5785
	ld a,0c8h		;5788
	call duerme		;578a
	ld a,0c8h		;578d
	call duerme		;578f
	ld a,042h		;5792   ; D17D = 0x42: bits 1 y 6, se acaba la partida
	ld (0d17dh),a		;5794   ; bits: 0 fase acabada, 1 fin de partida, 6 aviso a la tarea 0, 7 demo = a
	jr tarea_enemigos		;5797

; ----------------------------------------------------------------------
; TAREA 4: cada cuadro, si no hay pausa, p05:6000 (banco 5 en 0x6000).
; ----------------------------------------------------------------------
tarea_4:
	call cede		;5799   ; un cuadro
	ld a,(0d5dfh)		;579c   ; pausa?
	and a			;579f
	jr z,tarea_4		;57a0
	ld a,005h		;57a2   ; banco 5
	ld (0d190h),a		;57a4   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;57a7   ; registro del mapper: banco A en 0x6000
	call 06000h		;57aa   ; p05:6000
	jr tarea_4		;57ad
alta_actor_b5:
	call alta_actor		;57af   ; alta de un actor y vuelve a dejar el banco 5 (alta_actor pone el 3)
	ld a,005h		;57b2
	ld (0d190h),a		;57b4   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;57b7   ; registro del mapper: banco A en 0x6000
	ret			;57ba
pinta_actor_b5:
	call pinta_actor		;57bb   ; lo mismo con pinta_actor
	ld a,005h		;57be
	ld (0d190h),a		;57c0   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;57c3   ; registro del mapper: banco A en 0x6000
	ret			;57c6
baja_actor_b5:
	call baja_actor		;57c7   ; lo mismo con baja_actor
	ld a,005h		;57ca
	ld (0d190h),a		;57cc   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;57cf   ; registro del mapper: banco A en 0x6000
	ret			;57d2

; ----------------------------------------------------------------------
; DATOS enemigo_pose_tipo: Por cada codigo de enemigo de los mapas (1-25):
;   pose y tipo de actor (p00:598A)
;   0x57d3..0x5805  (50 bytes)
DATA_enemigo_pose_tipo:
	defb 000h,018h	; 57d3
	defb 001h,018h	; 57d5
	defb 002h,018h	; 57d7
	defb 000h,019h	; 57d9
	defb 001h,019h	; 57db
	defb 002h,019h	; 57dd
	defb 003h,019h	; 57df
	defb 000h,020h	; 57e1
	defb 000h,01ah	; 57e3
	defb 000h,01bh	; 57e5
	defb 000h,01ch	; 57e7
	defb 000h,01dh	; 57e9
	defb 000h,01eh	; 57eb
	defb 000h,01fh	; 57ed
	defb 000h,022h	; 57ef
	defb 000h,021h	; 57f1
	defb 000h,023h	; 57f3
	defb 000h,024h	; 57f5
	defb 001h,01fh	; 57f7
	defb 001h,01eh	; 57f9
	defb 000h,01eh	; 57fb
	defb 000h,025h	; 57fd
	defb 004h,019h	; 57ff
	defb 002h,017h	; 5801
	defb 001h,017h	; 5803

; ======================================================================
; CODIGO 0x5805..0x5810  (11 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El marcador: SCORE, la puntuacion a 0, ROUND y LIFE.
; ----------------------------------------------------------------------
pinta_marcador:
	exx			;5805
	ld b,000h		;5806
	exx			;5808
	ld d,010h		;5809   ; en (0x08, 0x10)
	ld e,008h		;580b
	call escribe_texto		;580d

; ----------------------------------------------------------------------
; DATOS texto_score: "SCORE"
;   0x5810..0x5816  (6 bytes)
DATA_texto_score:
	defb 053h,043h,04fh,052h,045h,000h	; 5810

; ======================================================================
; CODIGO 0x5816..0x5821  (11 bytes)
; ======================================================================


	exx			;5816
	ld b,000h		;5817
	exx			;5819
	ld d,018h		;581a   ; en (0x00, 0x18)
	ld e,000h		;581c
	call escribe_texto		;581e

; ----------------------------------------------------------------------
; DATOS texto_cero: seis espacios y "0": la puntuacion inicial
;   0x5821..0x5829  (8 bytes)
DATA_texto_cero:
	defb 020h,020h,020h,020h,020h,020h,030h,000h	; 5821        0.

; ======================================================================
; CODIGO 0x5829..0x5834  (11 bytes)
; ======================================================================


	exx			;5829
	ld b,000h		;582a
	exx			;582c
	ld d,008h		;582d   ; en (0x08, 0x08)
	ld e,008h		;582f
	call escribe_texto		;5831

; ----------------------------------------------------------------------
; DATOS texto_round: "ROUND"
;   0x5834..0x583a  (6 bytes)
DATA_texto_round:
	defb 052h,04fh,055h,04eh,044h,000h	; 5834

; ======================================================================
; CODIGO 0x583a..0x5845  (11 bytes)
; ======================================================================


	exx			;583a
	ld b,000h		;583b
	exx			;583d
	ld d,008h		;583e   ; en (0x50, 0x08)
	ld e,050h		;5840
	call escribe_texto		;5842

; ----------------------------------------------------------------------
; DATOS texto_life: "LIFE"
;   0x5845..0x584a  (5 bytes)
DATA_texto_life:
	defb 04ch,049h,046h,045h,000h	; 5845

; ======================================================================
; CODIGO 0x584a..0x584b  (1 bytes)
; ======================================================================


	ret			;584a

; ----------------------------------------------------------------------
; DATOS marcador_fondo: La franja de abajo del marcador: 2 filas x 30 tiles
;   (palabras), 0x216/0x217 y 0x226/0x227 alternos
;   0x584b..0x58c3  (120 bytes)
DATA_marcador_fondo:
	defw 00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h	; 584b
	defw 00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h,00216h,00217h	; 5869
	defw 00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h	; 5887
	defw 00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h,00226h,00227h	; 58a5

; ======================================================================
; CODIGO 0x58c3..0x5a8e  (459 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Rellena y pasa a atributos las fichas de sprite de un actor con su
; definicion en el banco 8 (en 0x6000). La orientacion sale de D93D.
; ----------------------------------------------------------------------
pinta_con_banco_8:
	ld a,008h		;58c3   ; banco 8 en 0x6000
	ld (0d190h),a		;58c5   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;58c8   ; registro del mapper: banco A en 0x6000
	push hl			;58cb
	push bc			;58cc
	ex af,af'			;58cd   ; A' = 0
	xor a			;58ce
	ex af,af'			;58cf
	call anima		;58d0   ; rellena las fichas
	ld a,(0d93dh)		;58d3   ; D935 = D93D con el bit 7 de A'
	and 07fh		;58d6
	ex af,af'			;58d8
	rrca			;58d9
	and 080h		;58da
	ld b,a			;58dc
	ex af,af'			;58dd
	or b			;58de
	ld (0d935h),a		;58df   ; actor 0, byte +2 = a
	pop bc			;58e2
	pop ix		;58e3
	call fichas_a_atributos		;58e5   ; y a atributos
	ld a,003h		;58e8   ; bancos 3 y 4 otra vez
	ld (0d190h),a		;58ea   ; copia del registro del mapper de 0x6000 = a
	ld (06ff8h),a		;58ed   ; registro del mapper: banco A en 0x6000
	ld a,004h		;58f0
	ld (0d191h),a		;58f2   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;58f5   ; registro del mapper: banco A en 0x8000
	ret			;58f8

; ----------------------------------------------------------------------
; Los actores de una pantalla nueva: da de baja los que habia y lee de
; detras del mapa (HL) hasta 8 enemigos, 3 objetos y un bloque especial.
; Cada posicion es un byte: nibble bajo * 16 = x, nibble alto + 0x20 = y.
; ----------------------------------------------------------------------
actores_de_pantalla:
	push ix		;58f9
	ld ix,0da20h		;58fb   ; los 8 enemigos de DA20 (38 bytes cada uno)...
	ld b,008h		;58ff
L_5901:
	push bc			;5901
	ld a,(ix+000h)		;5902   ; ...los que haya, de baja
	and a			;5905
	jp z,L_590C		;5906
	call baja_actor		;5909
L_590C:
	ld de,00026h		;590c
	add ix,de		;590f
	pop bc			;5911
	djnz L_5901		;5912
	ld ix,0d933h		;5914   ; y los 6 actores de D933
	ld b,006h		;5918
L_591A:
	push bc			;591a
	ld a,(ix+000h)		;591b
	and a			;591e
	jp z,L_5925		;591f
	call baja_actor		;5922
L_5925:
	ld de,00026h		;5925
	add ix,de		;5928
	pop bc			;592a
	djnz L_591A		;592b
	ld hl,0da20h		;592d   ; DA20-DB4F a 0
	ld de,0da21h		;5930   ; de -> enemigo 0, byte +1
	ld bc,0012fh		;5933
	xor a			;5936
	ld (hl),a			;5937
	ldir		;5938
	ld hl,0d933h		;593a   ; D933-DA16 a 0
	ld de,0d934h		;593d   ; de -> actor 0, byte +1
	ld bc,000e3h		;5940
	xor a			;5943
	ld (hl),a			;5944
	ldir		;5945
	ld (0da17h),a		;5947   ; todos los grupos de sprites libres
	ld (0da18h),a		;594a   ; seis sitios de un sprite, un bit cada uno = a
	pop hl			;594d
	inc hl			;594e   ; la lista de la pantalla
	ld ix,0da20h		;594f   ; hasta 8 enemigos
	ld b,008h		;5953
lee_enemigo:
	push bc			;5955
	ld a,(0d5e9h)		;5956   ; los bancos del mapa
	ld (0d191h),a		;5959   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;595c   ; registro del mapper: banco A en 0x8000
	inc a			;595f
	ld (0d192h),a		;5960   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;5963   ; registro del mapper: banco A en 0xA000
	ld a,(hl)			;5966   ; 0xFF: no hay
	cp 0ffh		;5967
	jr z,L_599E		;5969
	ld b,a			;596b   ; la posicion de salida: x en +10...
	and 00fh		;596c
	add a,a			;596e
	add a,a			;596f
	add a,a			;5970
	add a,a			;5971
	ld (ix+010h),a		;5972
	ld a,b			;5975   ; ...y en +11
	and 0f0h		;5976
	add a,020h		;5978
	ld (ix+011h),a		;597a
	inc hl			;597d
	ld a,(hl)			;597e   ; el codigo: con el bit 7, va tal cual al tipo (p00:5A88)
	bit 7,a		;597f
	jp nz,enemigo_tal_cual		;5981
	dec a			;5984   ; si no, la tabla de p00:57D3...
	push hl			;5985
	ld l,a			;5986
	ld h,000h		;5987
	add hl,hl			;5989
	ld de,057d3h		;598a
	add hl,de			;598d
	ld a,(hl)			;598e   ; ...da la pose (+1)...
	ld (ix+001h),a		;598f
	inc hl			;5992
	ld a,(hl)			;5993   ; ...y el tipo (+0)
	ld (ix+000h),a		;5994
	pop hl			;5997
siguiente_enemigo:
	inc hl			;5998
	ld de,00026h		;5999   ; 38 bytes por enemigo
	add ix,de		;599c
L_599E:
	pop bc			;599e
	djnz lee_enemigo		;599f
	inc hl			;59a1   ; y hasta 3 objetos en D933
	ld ix,0d933h		;59a2   ; ix -> los 6 actores de la pantalla
	ld b,003h		;59a6
lee_objeto:
	push bc			;59a8
	ld a,(0d5e9h)		;59a9   ; a = el banco de los mapas de la fase
	ld (0d191h),a		;59ac   ; copia del registro del mapper de 0x8000 = a
	ld (077f8h),a		;59af   ; registro del mapper: banco A en 0x8000
	inc a			;59b2
	ld (0d192h),a		;59b3   ; copia del registro del mapper de 0xA000 = a
	ld (07ff8h),a		;59b6   ; registro del mapper: banco A en 0xA000
	ld a,(hl)			;59b9   ; 0xFF: no hay
	cp 0ffh		;59ba
	jr z,siguiente_objeto		;59bc
	ld b,a			;59be   ; x en +6...
	and 00fh		;59bf
	add a,a			;59c1
	add a,a			;59c2
	add a,a			;59c3
	add a,a			;59c4
	ld (ix+006h),a		;59c5
	ld a,b			;59c8   ; ...y en +7
	and 0f0h		;59c9
	add a,020h		;59cb
	ld (ix+007h),a		;59cd
	inc hl			;59d0   ; el tipo
	ld a,(hl)			;59d1
	ld (ix+000h),a		;59d2
	inc hl			;59d5
siguiente_objeto:
	ld de,00026h		;59d6
	add ix,de		;59d9
	pop bc			;59db
	djnz lee_objeto		;59dc
	inc hl			;59de   ; el bloque especial: posicion...
	ld a,(hl)			;59df
	cp 0ffh		;59e0
	jp z,sin_bloque_especial		;59e2
	ld b,a			;59e5   ; ...x en D92B...
	and 00fh		;59e6
	add a,a			;59e8
	add a,a			;59e9
	add a,a			;59ea
	add a,a			;59eb
	ld (0d92bh),a		;59ec   ; x del bloque especial de la pantalla = a
	ld a,b			;59ef   ; ...y en D92C...
	and 0f0h		;59f0
	add a,020h		;59f2
	ld (0d92ch),a		;59f4   ; y del bloque especial = a
	inc hl			;59f7   ; ...cual, en D92D...
	ld a,(hl)			;59f8
	ld (0d92dh),a		;59f9   ; cual es el bloque especial = a
	call pinta_bloque_especial		;59fc   ; ...y se pinta
	jp altas_de_objetos		;59ff
sin_bloque_especial:
	xor a			;5a02
	ld (0d92dh),a		;5a03   ; cual es el bloque especial = a
altas_de_objetos:
	ld ix,0d933h		;5a06   ; ix -> los 6 actores de la pantalla
	ld b,003h		;5a0a
L_5A0C:
	push bc			;5a0c
	ld a,(ix+000h)		;5a0d   ; los objetos de tipo 0 y 2 no se pintan aun
	and a			;5a10
	jr z,siguiente_alta		;5a11
	cp 002h		;5a13
	jr z,siguiente_alta		;5a15
	ld l,a			;5a17   ; +0F = el byte del tipo en p00:5A8E
	ld h,000h		;5a18
	ld de,05a8eh		;5a1a
	add hl,de			;5a1d
	ld a,(hl)			;5a1e
	ld (ix+00fh),a		;5a1f
	call alta_actor		;5a22   ; alta...
	call pinta_actor		;5a25   ; ...y ocho pasos de su animacion, para que salga ya puesto
	call pinta_actor		;5a28
	call pinta_actor		;5a2b
	call pinta_actor		;5a2e
	call pinta_actor		;5a31
	call pinta_actor		;5a34
	call pinta_actor		;5a37
	call pinta_actor		;5a3a
siguiente_alta:
	pop bc			;5a3d
	ld de,00026h		;5a3e
	add ix,de		;5a41
	djnz L_5A0C		;5a43
	ld ix,0da20h		;5a45   ; y los enemigos de tipo 0x18, 0x1C, 0x22 y 0x25 se dan de alta ya
	ld b,008h		;5a49
L_5A4B:
	push bc			;5a4b
	ld a,(ix+000h)		;5a4c
	and a			;5a4f
	jr z,L_5A7F		;5a50
	cp 018h		;5a52
	jr z,alta_enemigo_fijo		;5a54
	cp 01ch		;5a56
	jr z,alta_enemigo_fijo		;5a58
	cp 022h		;5a5a
	jr z,alta_enemigo_fijo		;5a5c
	cp 025h		;5a5e
	jr z,alta_enemigo_fijo		;5a60
	jr L_5A7F		;5a62
alta_enemigo_fijo:
	call alta_actor		;5a64   ; alta y ocho pasos de animacion
	call pinta_actor		;5a67
	call pinta_actor		;5a6a
	call pinta_actor		;5a6d
	call pinta_actor		;5a70
	call pinta_actor		;5a73
	call pinta_actor		;5a76
	call pinta_actor		;5a79
	call pinta_actor		;5a7c
L_5A7F:
	pop bc			;5a7f
	ld de,00026h		;5a80
	add ix,de		;5a83
	djnz L_5A4B		;5a85
	ret			;5a87
enemigo_tal_cual:
	ld (ix+000h),a		;5a88   ; el codigo con el bit 7 es directamente el tipo
	jp siguiente_enemigo		;5a8b

; ----------------------------------------------------------------------
; DATOS objeto_mas0f: El byte +0F de cada tipo de objeto (p00:5A1A): 0x00-0x30
;   0x5a8e..0x5aa5  (23 bytes)
DATA_objeto_mas0f:
	defb 000h,010h,020h,010h,010h,010h,030h,020h,020h,020h,010h,010h,010h,020h,010h,020h	; 5a8e  .. ...0   ... .
	defb 020h,020h,020h,020h,020h,020h,000h	; 5a9e

; ======================================================================
; CODIGO 0x5aa5..0x5b7d  (216 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Un paso de animacion. IX = definicion: base de los patrones, numero de
; cuadros y la lista de cuadros; cada cuadro = duracion, sprites y 4 bytes
; por sprite (patron, x, y, atributo; 0xFF = sprite vacio). IY = estado
; (+0 cuadro, +1 lo que le queda), HL = las fichas de sprite. Con A' bit 1
; empieza de cero; devuelve A' = 1 si la animacion ha dado la vuelta.
; ----------------------------------------------------------------------
anima:
	ex af,af'			;5aa5
	bit 1,a		;5aa6   ; desde el principio?
	jr z,L_5AB2		;5aa8
	ld (iy+000h),0feh		;5aaa   ; cuadro 0xFE: el siguiente sera el 0xFF+1 = 0...
	ld (iy+001h),001h		;5aae   ; ...y cuenta 1: se cambia ya
L_5AB2:
	ex af,af'			;5ab2
	push hl			;5ab3
	ld a,(iy+001h)		;5ab4   ; aun le queda al cuadro?
	dec a			;5ab7
	ld (iy+001h),a		;5ab8
	jp nz,sigue_el_cuadro		;5abb
	ld l,(ix+000h)		;5abe   ; la base de los patrones
	ld h,(ix+001h)		;5ac1
	push hl			;5ac4
	inc ix		;5ac5
	inc ix		;5ac7
	ld a,(iy+000h)		;5ac9   ; el cuadro siguiente...
	inc a			;5acc
	cp (ix+000h)		;5acd   ; ...pasa del ultimo?
	jr c,cuadro_siguiente		;5ad0
	ex af,af'			;5ad2   ; si: A' = 1 (el `ld a,0` sobra) y se vuelve al 0
	ld a,000h		;5ad3
	ld a,001h		;5ad5
	ex af,af'			;5ad7
	xor a			;5ad8
	jr L_5ADE		;5ad9
cuadro_siguiente:
	ex af,af'			;5adb
	xor a			;5adc
	ex af,af'			;5add
L_5ADE:
	ld (iy+000h),a		;5ade   ; apuntado
	inc ix		;5ae1   ; la lista de cuadros...
	add a,a			;5ae3
	ld e,a			;5ae4
	ld d,000h		;5ae5
	add ix,de		;5ae7
	ld l,(ix+000h)		;5ae9   ; ...el de este
	ld h,(ix+001h)		;5aec
	push hl			;5aef
	pop ix		;5af0
	ld a,(ix+000h)		;5af2   ; su duracion
	ld (iy+001h),a		;5af5
	inc ix		;5af8
	ld a,(ix+000h)		;5afa   ; cuantos sprites lleva
	ld b,a			;5afd
	inc ix		;5afe
	pop de			;5b00   ; DE = base de los patrones, IY = fichas de sprite
	pop iy		;5b01
cada_sprite:
	push bc			;5b03
	ld a,(ix+000h)		;5b04   ; 0xFF: sprite vacio
	cp 0ffh		;5b07
	jp z,sprite_vacio		;5b09
	dec a			;5b0c   ; (patron - 1) * 32 + base
	ld l,a			;5b0d
	ld h,000h		;5b0e
	add hl,hl			;5b10
	add hl,hl			;5b11
	add hl,hl			;5b12
	add hl,hl			;5b13
	add hl,hl			;5b14
	add hl,de			;5b15
	ld (iy+000h),l		;5b16   ; ficha +0/1: el patron
	ld (iy+001h),h		;5b19
	ld a,(ix+001h)		;5b1c   ; +2: x relativa
	ld (iy+002h),a		;5b1f
	ld a,(ix+002h)		;5b22   ; +3: y relativa
	ld (iy+003h),a		;5b25
	ld a,(0d5ddh)		;5b28   ; +6/+7: la posicion del actor
	ld (iy+006h),a		;5b2b
	ld a,(0d5deh)		;5b2e   ; a = lo que se suma a la y de los sprites
	ld (iy+007h),a		;5b31
	ld a,(ix+003h)		;5b34   ; +8: el juego de graficos y bancos
	ld (iy+008h),a		;5b37
	inc ix		;5b3a
	inc ix		;5b3c
	inc ix		;5b3e
	inc ix		;5b40
ficha_siguiente:
	inc iy		;5b42   ; 11 bytes mas alla
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
	djnz cada_sprite		;5b59
	ret			;5b5b
sprite_vacio:
	push de			;5b5c
	push iy		;5b5d
	pop de			;5b5f
	ld hl,05b7dh		;5b60   ; los 8 bytes de p00:5B7D: sin patron y oculto
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
	jr ficha_siguiente		;5b76
sigue_el_cuadro:
	ex af,af'			;5b78   ; A' = 0: no ha dado la vuelta
	xor a			;5b79
	ex af,af'			;5b7a
	pop hl			;5b7b
	ret			;5b7c

; ----------------------------------------------------------------------
; DATOS ficha_vacia: Una ficha de sprite vacia (patron 0xFFFF, y = 0xFF) y
;   tres y = 0xE0
;   0x5b7d..0x5b95  (24 bytes)
DATA_ficha_vacia:
	defb 0ffh,0ffh,000h,0ffh,0ffh,0ffh,000h,000h,0e0h,000h,000h,000h,0e0h,000h,000h,000h	; 5b7d  ................
	defb 0e0h,000h,000h,000h,0e0h,000h,000h,000h	; 5b8d  ........

; ======================================================================
; CODIGO 0x5b95..0x5bc3  (46 bytes)
; ======================================================================


repinta_cuadro:
	push hl			;5b95   ; vuelve a rellenar las fichas del cuadro actual (IY+0) sin avanzar
	ld l,(ix+000h)		;5b96
	ld h,(ix+001h)		;5b99
	push hl			;5b9c
	inc ix		;5b9d
	inc ix		;5b9f
	inc ix		;5ba1
	ld a,(iy+000h)		;5ba3   ; el cuadro de ahora
	add a,a			;5ba6
	ld e,a			;5ba7
	ld d,000h		;5ba8
	add ix,de		;5baa
	ld l,(ix+000h)		;5bac
	ld h,(ix+001h)		;5baf
	push hl			;5bb2
	pop ix		;5bb3
	inc ix		;5bb5
	ld a,(ix+000h)		;5bb7   ; cuantos sprites
	ld b,a			;5bba
	inc ix		;5bbb
	pop de			;5bbd
	pop iy		;5bbe
	jp cada_sprite		;5bc0

; ----------------------------------------------------------------------
; DATOS bloques_especiales: Tabla de bloques de 16x16 de p00:48B6 (palabras de
;   tile, filas de 8 bloques)
;   0x5bc3..0x5d27  (356 bytes)
DATA_bloques_especiales:
	defw 00834h,00835h,00836h,00837h,00838h,00839h,0083ah,0083bh	; 5bc3
	defw 0083ch,0083dh,0083eh,0083fh,00840h,00841h,00842h,00843h	; 5bd3
	defw 00844h,00845h,00846h,00847h,00848h,00849h,0084ah,0084bh	; 5be3
	defw 0084ch,0084dh,0084eh,0084fh,00850h,00851h,00852h,00853h	; 5bf3
	defw 00854h,00855h,00856h,00857h,00858h,00859h,0085ah,0085bh	; 5c03
	defw 0085ch,0085dh,0085eh,0085fh,00860h,00861h,00862h,00863h	; 5c13
	defw 00864h,00865h,00866h,00867h,00868h,00869h,0086ah,0086bh	; 5c23
	defw 0086ch,0086dh,0086eh,0086fh,00870h,00871h,00872h,00000h	; 5c33
	defw 00873h,00874h,00875h,00876h,00877h,00878h,00000h,00000h	; 5c43
	defw 000cch,000ceh,000d0h,000d2h,000d4h,000d6h,000d8h,000dah	; 5c53
	defw 00879h,0087ah,0087bh,0087ch,0087dh,0087eh,00000h,00000h	; 5c63
	defw 000cdh,000cfh,000d1h,000d3h,000d5h,000d7h,000d9h,000dbh	; 5c73
	defw 000dch,000deh,000e0h,000e2h,000e4h,000e6h,000e8h,000eah	; 5c83
	defw 000ech,000eeh,000f0h,000f2h,000f4h,000f6h,000b8h,000bah	; 5c93
	defw 000ddh,000dfh,000e1h,000e3h,000e5h,000e7h,000e9h,000ebh	; 5ca3
	defw 000edh,000efh,000f1h,000f3h,000f5h,000f7h,000b9h,000bbh	; 5cb3
	defw 000bch,000beh,000c0h,000c2h,000c4h,000c6h,000c8h,000cah	; 5cc3
	defw 000b8h,000bah,000bch,000beh,000c0h,000c2h,000c4h,000c6h	; 5cd3
	defw 000bdh,000bfh,000c1h,000c3h,000c5h,000c7h,000c9h,000cbh	; 5ce3
	defw 000b9h,000bbh,000bdh,000bfh,000c1h,000c3h,000c5h,000c7h	; 5cf3
	defw 000c8h,000cah,00000h,00000h,00000h,00000h,00000h,00000h	; 5d03
	defw 00000h,00000h,00000h,00000h,00000h,00000h,00000h,00000h	; 5d13
	defw 000c9h,000cbh	; 5d23

; ----------------------------------------------------------------------
; DATOS bloques_titulo: Tabla de bloques de 16x16 del dibujo del titulo
;   (p00:514C)
;   0x5d27..0x6000  (729 bytes)
DATA_bloques_titulo:
	defw 00000h,00000h,00180h,00180h,00000h,00000h,00000h,00000h	; 5d27
	defw 0087fh,00880h,00881h,00882h,00000h,00000h,00000h,00883h	; 5d37
	defw 00000h,00000h,00180h,00180h,00000h,00884h,00885h,00000h	; 5d47
	defw 00886h,00887h,00888h,00889h,0088ah,0088bh,0088ch,0088dh	; 5d57
	defw 0088eh,0088fh,00000h,00000h,00000h,00000h,00890h,00891h	; 5d67
	defw 00892h,00893h,00894h,00895h,00896h,00897h,00898h,00899h	; 5d77
	defw 0089ah,0089bh,0089ch,0089dh,0089eh,0089fh,008a0h,008a1h	; 5d87
	defw 008a2h,008a3h,008a4h,008a5h,008a6h,008a7h,008a8h,008a9h	; 5d97
	defw 008aah,008abh,008ach,008adh,008aeh,008afh,008b0h,008b1h	; 5da7
	defw 008b2h,008b3h,008b4h,008b5h,008b6h,008b7h,008b8h,008b9h	; 5db7
	defw 008bah,008bbh,008bch,008bdh,00000h,008beh,008bfh,00000h	; 5dc7
	defw 00000h,00000h,00000h,008c0h,008c1h,008c2h,00000h,00000h	; 5dd7
	defw 008c3h,008c4h,00000h,00000h,008c5h,00000h,008c6h,008c7h	; 5de7
	defw 008c8h,008c9h,008cah,008cbh,008cch,008cdh,008ceh,008cfh	; 5df7
	defw 008d0h,008d1h,008d2h,00000h,00000h,00000h,008d3h,008d4h	; 5e07
	defw 008d5h,008d6h,008d7h,008d8h,008d9h,008dah,008dbh,008dch	; 5e17
	defw 008ddh,008deh,008dfh,008e0h,008e1h,008e2h,008e3h,008e4h	; 5e27
	defw 008e5h,008e6h,00000h,00000h,00000h,008e7h,008e8h,00000h	; 5e37
	defw 008e9h,008eah,008ebh,008ech,008edh,008eeh,008efh,008f0h	; 5e47
	defw 008f1h,008f2h,008f3h,00000h,00000h,00000h,00000h,00000h	; 5e57
	defw 00000h,00000h,00180h,00180h,00760h,00760h,00760h,00760h	; 5e67
	defw 00760h,00761h,00762h,00763h,00764h,00760h,00765h,00766h	; 5e77
	defw 00000h,00000h,00180h,00180h,00760h,00760h,00767h,00767h	; 5e87
	defw 00767h,00768h,00769h,0076ah,0076bh,00767h,0076ch,0076dh	; 5e97
	defw 0076eh,00760h,0076fh,00770h,00771h,00772h,00773h,00760h	; 5ea7
	defw 00774h,00775h,00776h,00760h,00777h,00778h,00779h,0077ah	; 5eb7
	defw 0077bh,00767h,0077ch,0077dh,0077eh,0077fh,00780h,00767h	; 5ec7
	defw 00180h,00781h,00782h,00767h,00783h,00784h,00785h,00786h	; 5ed7
	defw 00787h,00788h,00789h,0078ah,0078bh,0078ch,0078dh,0078eh	; 5ee7
	defw 0078fh,00790h,00791h,00792h,00793h,00794h,00795h,00796h	; 5ef7
	defw 00797h,00798h,00799h,0079ah,0079bh,0079ch,0079dh,0079eh	; 5f07
	defw 0079fh,007a0h,007a1h,007a2h,007a3h,007a4h,007a5h,007a6h	; 5f17
	defw 007a7h,007a8h,008f4h,008f5h,008f6h,008f7h,008f8h,008f9h	; 5f27
	defw 008fah,008fbh,008fch,008fdh,008feh,008ffh,00900h,00901h	; 5f37
	defw 00902h,00903h,00904h,00905h,00906h,00907h,00908h,00909h	; 5f47
	defw 0090ah,0090bh,0090ch,0090dh,0090eh,0090fh,00910h,00911h	; 5f57
	defw 00912h,00913h,00914h,00915h,00916h,00917h,00918h,00919h	; 5f67
	defw 0091ah,0091bh,0091ch,0091dh,0091eh,0091fh,00920h,00921h	; 5f77
	defw 00922h,00923h,00924h,00925h,00926h,00927h,00928h,00929h	; 5f87
	defw 0092ah,0092bh,0092ch,0092dh,0092eh,0092fh,00930h,00931h	; 5f97
	defw 00932h,00933h,00934h,00935h,00936h,00937h,00938h,00939h	; 5fa7
	defw 0093ah,0093bh,0093ch,0093dh,0093eh,0093fh,00940h,00941h	; 5fb7
	defw 00942h,00943h,00944h,00945h,00946h,00947h,00948h,00949h	; 5fc7
	defw 0094ah,0094bh,0094ch,0094dh,0094eh,0094fh,00950h,00951h	; 5fd7
	defw 00952h,00953h,00954h,00955h,00956h,00957h,00958h,00959h	; 5fe7
	defw 0095ah,0095bh,0095ch,0095dh	; 5ff7
	defb 05eh	; 5fff
