#!/usr/bin/env bash
# Генерация PDF (для этого проекта совпадает со сборкой).
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/build.sh" "$@"
exec "$SCRIPT_DIR/clean.sh"
