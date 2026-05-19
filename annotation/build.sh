#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MAIN_TEX="annotation.tex"

cd "$ROOT_DIR"
latexmk -xelatex -interaction=nonstopmode -halt-on-error "$MAIN_TEX"
