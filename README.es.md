# Rastan Saga — desensamblado comentado

*(Also available [in English](README.md).)*

Desensamblado comentado de ***Rastan Saga***, Taito, 1988, para **MSX2**: un
MegaROM de 256 KB con el mapper ASCII8, treinta y dos bancos de 8 KB.

**La web**: https://antxiko.github.io/RastanSaga-disassembly/es/

| | |
|---|---|
| explicado | 100 % (29.820 bytes de código, 232.324 de datos) |
| comentado | 46,1 % de las instrucciones |
| rutinas | 1.406, ninguna por debajo del 10 % |
| reensamblado | la ROM, byte a byte |
| imágenes | dibujadas desde la ROM y cotejadas contra openMSX |

## Qué hay

- El listado de los treinta y dos bancos (`src/rastan_pNN.asm`), que se
  genera desde el binario y las notas y reensambla la ROM exacta.
- Las siete rondas, las 257 pantallas de las 24 fases, montadas desde sus
  mapas con sus enemigos y sus jefes.
- Rastan en sus tres capas, los 37 tipos de actor, los cinco jefes, la fase
  del dragón que el juego se salta, el trono y el final.
- Los cotejos contra openMSX y los tests (`make test`).

## Cómo reproducirlo

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `rastan.rom` en la raíz:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

Los detalles, en [Empezar](docs/es/EMPEZAR.md).

## Aviso

El juego es de Taito; aquí solo están el análisis, los comentarios y las
herramientas. La ROM no se distribuye. Ver [AVISO-LEGAL.md](AVISO-LEGAL.md).
