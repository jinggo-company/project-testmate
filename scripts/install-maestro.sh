#!/bin/bash
# install-maestro.sh — Install Maestro CLI for TestMate
set -euo pipefail

echo "[TestMate] Installing Maestro CLI..."

# Check if already installed
if command -v maestro &>/dev/null; then
  echo "[TestMate] Maestro already installed: $(maestro --version)"
  exit 0
fi

OS="$(uname -s)"
case "${OS}" in
  Darwin)
    echo "[TestMate] Installing via Homebrew (macOS)..."
    brew tap mobile-dev-inc/tap
    brew install maestro
    ;;
  Linux)
    echo "[TestMate] Installing via curl (Linux)..."
    curl -Ls "https://get.maestro.mobile.dev" | bash

    # Add to PATH if not already
    MAESTRO_BIN="$HOME/.maestro/bin"
    if [ -d "$MAESTRO_BIN" ]; then
      export PATH="$MAESTRO_BIN:$PATH"
      echo "export PATH=\"\$HOME/.maestro/bin:\$PATH\"" >> "$HOME/.bashrc" 2>/dev/null || true
    fi
    ;;
  *)
    echo "[TestMate] Unsupported OS: ${OS}"
    exit 1
    ;;
esac

# Verify installation
echo "[TestMate] Verifying installation..."
maestro --version
echo "[TestMate] Maestro CLI installed successfully."
