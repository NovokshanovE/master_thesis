#!/usr/bin/env bash
# Удаление вспомогательных файлов LaTeX. По умолчанию PDF не трогаем.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

MAIN="preso"
REMOVE_PDF=false

for arg in "$@"; do
  case "$arg" in
    --all|-a) REMOVE_PDF=true ;;
    -h|--help)
      echo "Использование: $0 [--all]"
      echo "  (без флагов) — удалить .aux, .log, .nav и т.д., оставить $MAIN.pdf"
      echo "  --all, -a    — также удалить $MAIN.pdf"
      exit 0
      ;;
  esac
done

patterns=(
  "$MAIN.aux"
  "$MAIN.log"
  "$MAIN.nav"
  "$MAIN.out"
  "$MAIN.snm"
  "$MAIN.toc"
  "$MAIN.vrb"
  "$MAIN.fls"
  "$MAIN.fdb_latexmk"
  "$MAIN.synctex.gz"
  "$MAIN.xdv"
  "$MAIN.bbl"
  "$MAIN.blg"
  "$MAIN.bcf"
  "$MAIN.run.xml"
  "$MAIN.lof"
  "$MAIN.lot"
  "$MAIN.idx"
  "$MAIN.ilg"
  "$MAIN.ind"
)

if command -v latexmk >/dev/null 2>&1; then
  latexmk -c -f "$MAIN.tex" 2>/dev/null || true
fi

rm -f "${patterns[@]}"

if [[ "$REMOVE_PDF" == true ]]; then
  rm -f "$MAIN.pdf"
fi
