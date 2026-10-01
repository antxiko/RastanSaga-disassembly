# Rastan (Taito, 1988, MSX2)
# desensamblado
#
# El orden de las cosas: trazar el flujo -> generar el listado -> comprobar que
# vuelve a dar la ROM byte a byte -> las comprobaciones que el reensamblado NO
# cubre.
#
# Es un MegaROM de 256 KB con el mapper ASCII8, 32 bancos de 8 KB. Cada banco
# es un modulo (p00..p31) con su propio org -el sitio donde el mapper lo pone
# para ejecutarlo o leerlo, medido en tools/paginas.py-, su trazado, sus notas
# y su listado. `make verify` reensambla los 32 y los concatena: tiene que salir
# la ROM entera, byte a byte.
#
# tools/cartucho.py traza el CARTUCHO ENTERO llevando la cuenta de que banco hay
# en cada ranura. De ahi salen los src/pNN.entries -las llamadas que cruzan el
# mapper y los destinos de las tablas de saltos- y los src/pNN.nocode -las
# tablas-. `make semillas` los regenera.
#
# La ROM no se distribuye. Hace falta en la raiz como rastan.rom, y
# `make comprueba` verifica el sha256.

ROM      = rastan.rom
SHA      = 03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
SRC      = src
WORK     = work
TITULO   = RASTAN - Taito (1988) - MSX2 - MegaROM de 256 KB (ASCII8)

PAGINAS  = 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \
           16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

# Donde se ejecuta (o se lee) cada banco. Es la misma tabla que `python3
# tools/paginas.py lista` (un test lo comprueba); esta copiada aqui para no
# lanzar python 64 veces por cada make.
ORG_00 = 0x4000
ORG_01 = 0x6000
ORG_02 = 0x8000
ORG_03 = 0x6000
ORG_04 = 0x8000
ORG_05 = 0x6000
ORG_06 = 0x6000
ORG_07 = 0x8000
ORG_08 = 0x6000
ORG_09 = 0x8000
ORG_10 = 0xa000
ORG_11 = 0x6000
ORG_12 = 0x8000
ORG_13 = 0xa000
ORG_14 = 0x6000
ORG_15 = 0x8000
ORG_16 = 0x8000
ORG_17 = 0xa000
ORG_18 = 0x8000
ORG_19 = 0xa000
ORG_20 = 0x8000
ORG_21 = 0xa000
ORG_22 = 0x8000
ORG_23 = 0xa000
ORG_24 = 0x8000
ORG_25 = 0xa000
ORG_26 = 0x8000
ORG_27 = 0xa000
ORG_28 = 0x8000
ORG_29 = 0xa000
ORG_30 = 0x8000
ORG_31 = 0xa000
ORG    = $(ORG_$(1))

all: listado verify sanity test

$(ROM):
	@echo "=================================================================="
	@echo " Falta $(ROM), y este repositorio NO lo distribuye."
	@echo ""
	@echo " Es Rastan (Taito, 1988) para MSX2, MegaROM de 262144 bytes"
	@echo " exactos. Ponlo aqui con ese nombre. Para comprobar que es el mismo:"
	@echo "     shasum -a 256 $(ROM)"
	@echo "     $(SHA)"
	@echo ""
	@echo " Sin el se puede leer el listado ya generado en $(SRC)/, y los"
	@echo " tests que no dependen del binario siguen pasando."
	@echo "=================================================================="
	@false

comprueba: $(ROM)
	@echo "$(SHA)  $(ROM)" | shasum -a 256 -c -

# La regla banco -> org: todas las escrituras al mapper, contadas y cotejadas.
reconoce: $(ROM)
	@python3 tools/paginas.py mide $(ROM)

# Los 32 bancos cortados de la ROM, uno por fichero.
$(WORK)/p00.bin: $(ROM) tools/paginas.py
	@mkdir -p $(WORK)
	python3 tools/paginas.py corta $(ROM) $(WORK)

paginas: $(WORK)/p00.bin

# Las semillas: el trazado de cartucho entero, que es el unico que sabe que
# banco hay en cada ranura. Reescribe los .entries y los .nocode.
semillas: $(ROM)
	python3 tools/cartucho.py $(ROM) escribe $(SRC)

# El trazado sigue el flujo desde los puntos de entrada DE CADA BANCO.
define REGLA_TRAZA
$(WORK)/p$(1).trace.json: $(WORK)/p00.bin $(SRC)/p$(1).entries $(SRC)/p$(1).nocode tools/z80trace.py
	python3 tools/z80trace.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(SRC)/p$(1).entries \
	        $(WORK)/p$(1) $(SRC)/p$(1).nocode
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_TRAZA,$(p))))

trace: $(foreach p,$(PAGINAS),$(WORK)/p$(p).trace.json)

# Un listado por banco: src/rastan_pNN.asm, con el org de ese banco.
define REGLA_LISTADO
$(SRC)/rastan_p$(1).asm: $(WORK)/p$(1).trace.json $(SRC)/p$(1).notes tools/mkasm.py
	python3 tools/mkasm.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(WORK)/p$(1).trace.json \
	        $(SRC)/p$(1).notes $(WORK)/msx.sym $(SRC)/rastan_p$(1).asm \
	        "$(TITULO) - banco $(1) (en $(call ORG,$(1)))"
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_LISTADO,$(p))))

listado: $(foreach p,$(PAGINAS),$(SRC)/rastan_p$(p).asm)

# La prueba que decide si el desensamblado es fiable: cada banco reensambla a
# sus 8192 bytes, y los 32 concatenados dan la ROM entera.
verify: $(WORK)/p00.bin
	@for p in $(PAGINAS); do \
	  sh tools/verify_build.sh $(SRC)/rastan_p$$p.asm $(WORK)/p$$p.bin \
	     `python3 tools/paginas.py org $$p` $(WORK)/p$$p.out.bin > $(WORK)/verify_p$$p.txt || { cat $(WORK)/verify_p$$p.txt; exit 1; }; \
	done
	@echo "32 bancos reensamblados byte a byte"
	@sh tools/verify_rom.sh $(WORK) $(ROM) $(SHA)

# Lo que el reensamblado NO puede cazar: que unos datos se esten leyendo como
# codigo. El binario sale identico igual, porque los bytes no cambian; lo unico
# que cambia es lo que decimos de ellos.
sanity: trace
	@echo "=================================================================="
	@echo " la regla banco -> org la cumplen todas las escrituras al mapper"
	@echo "=================================================================="
	@python3 tools/paginas.py mide $(ROM) | tail -1
	@echo "=================================================================="
	@echo " ningun byte declarado como datos puede salir como codigo"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_trace.py $(WORK)/p$$p.trace.json $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@python3 tools/check_datos_como_codigo.py $(WORK) $(SRC)
	@echo "=================================================================="
	@echo " el trazado por bancos y el de cartucho entero dicen lo mismo"
	@echo "=================================================================="
	@python3 tools/check_bancos.py $(ROM) $(WORK)
	@echo "=================================================================="
	@echo " ningun punto de entrada puede caer dentro de una zona de datos"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_entradas.py $(SRC)/p$$p.entries $(SRC)/p$$p.notes \
	          $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@echo "=================================================================="
	@echo " ni un byte del cartucho sin asignar (los 32 bancos)"
	@echo "=================================================================="
	@python3 tools/presupuesto.py $(WORK) $(SRC)

densidad:
	@for p in $(PAGINAS); do \
	  echo "-- p$$p"; python3 tools/densidad.py $(SRC)/rastan_p$$p.asm | tail -2; \
	done

test:
	@echo "=================================================================="
	@echo " Tests"
	@echo "=================================================================="
	@python3 -m unittest discover -s tests -v

clean:
	rm -f $(WORK)/p*.trace.json $(WORK)/p*.blocks $(WORK)/p*.out.bin \
	      $(WORK)/reensamblada.rom $(WORK)/pasmo.err $(WORK)/verify_p*.txt

.PHONY: all comprueba reconoce paginas semillas trace listado verify \
        sanity densidad test clean
