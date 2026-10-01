#!/bin/sh
# junta_notas.sh: une los trozos work/n/pNN_*.txt en work/notas_pNN.txt y los
# mete en src/pNN.notes (tools/mete_notas.py).
R=$(cd "$(dirname "$0")/.." && pwd)
cd $R
for f in work/n/p??_01.txt; do
  p=$(basename $f | cut -c2-3)
  cat work/n/p${p}_*.txt > work/notas_p$p.txt
  python3 tools/mete_notas.py $((10#$p))
done
