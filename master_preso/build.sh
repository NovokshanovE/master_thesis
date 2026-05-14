#!/usr/bin/env bash
# Сборка презентации (XeLaTeX, как в preso.tex).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

MAIN="preso"

if command -v latexmk >/dev/null 2>&1; then
  exec latexmk -xelatex -interaction=nonstopmode -file-line-error "$MAIN.tex"
fi

xelatex -interaction=nonstopmode -file-line-error "$MAIN.tex"
xelatex -interaction=nonstopmode -file-line-error "$MAIN.tex"
