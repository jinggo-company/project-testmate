#!/bin/bash
# run-tests.sh — Run TestMate test flows
set -euo pipefail

echo "[TestMate] Running test flows..."

MAESTRO_FORMAT="${MAESTRO_FORMAT:-junit}"
FLOWS_DIR="${1:-flows}"

if [ ! -d "$FLOWS_DIR" ]; then
  echo "[TestMate] Flows directory not found: $FLOWS_DIR"
  exit 1
fi

# Run all flows
maestro test "$FLOWS_DIR" --format="$MAESTRO_FORMAT" --output=reports/
echo "[TestMate] Test execution complete. Reports in reports/"
