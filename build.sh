#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MAIN_TEX="diploma.tex"
readonly OUTPUT_PDF="diploma.pdf"
readonly REQUIRED_TOOLS=(latexmk xelatex bibtex fc-list)
readonly REQUIRED_FONTS=("Times New Roman" "Liberation Sans" "Liberation Mono")

usage() {
  cat <<'EOF'
Usage: ./build.sh [build|clean|distclean]

Commands:
  build      Build diploma.pdf
  clean      Remove LaTeX temporary files
  distclean  Remove temporary files and diploma.pdf
EOF
}

build() {
  cd "$ROOT_DIR"
  require_dependencies
  latexmk -xelatex -bibtex -interaction=nonstopmode -halt-on-error "$MAIN_TEX"
}

require_dependencies() {
  local tool
  for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      printf 'Missing required tool: %s\n' "$tool" >&2
      exit 1
    fi
  done

  local font
  for font in "${REQUIRED_FONTS[@]}"; do
    if ! grep -Fq "$font" < <(fc-list); then
      printf 'Missing required font: %s\n' "$font" >&2
      printf 'Install the Microsoft core fonts / Liberation fonts and rerun the build.\n' >&2
      exit 1
    fi
  done
}

clean() {
  cd "$ROOT_DIR"
  latexmk -c "$MAIN_TEX"

  rm -f \
    *.aux \
    *.bbl \
    *.bcf \
    *.blg \
    *.fdb_latexmk \
    *.fls \
    *.lof \
    *.log \
    *.lot \
    *.nav \
    *.out \
    *.run.xml \
    *.snm \
    *.synctex.gz \
    *.toc \
    *.vrb
}

distclean() {
  clean
  rm -f "$ROOT_DIR/$OUTPUT_PDF"
}

command="${1:-build}"

case "$command" in
  build)
    build
    ;;
  clean)
    clean
    ;;
  distclean)
    distclean
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac
