# Empezar

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `rastan.rom` en la raíz:

```
sha256  03fa40fa0fa58f252ad9cd9e78b2bc01a0127b5509fe1babdb5a9443ec1f705e
make
```

`make` genera el listado de los 32 bancos, lo reensambla, comprueba que sale
la ROM byte a byte y pasa los tests.

## Qué hace cada paso

| orden | qué hace |
|---|---|
| `make comprueba` | el sha256 de la ROM |
| `make trace` | traza el código de cada banco siguiendo el flujo |
| `make listado` | genera `src/rastan_pNN.asm` desde el binario y las notas |
| `make verify` | reensambla los 32 bancos y los compara con la ROM |
| `make sanity` | ni un byte sin explicar: código trazado o datos con nombre |
| `make densidad` | el porcentaje comentado, banco a banco |
| `make imagenes` | todas las imágenes de la web, desde la ROM |
| `make web` | las páginas y las dos portadas |

## Dónde está cada cosa

| sitio | qué hay |
|---|---|
| `src/pNN.notes` | los nombres, los comentarios y los rangos de datos de cada banco |
| `src/rastan_pNN.asm` | el listado, generado |
| `tools/datos.py` | recorre los datos como el código: dice qué estructura lee cada byte |
| `tools/graficos/` | el título, las fases, las figuras, los secretos |
| `tools/omsx_*.tcl` | las sondas de openMSX |
| `tests/` | los tests |
