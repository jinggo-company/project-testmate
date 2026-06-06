#!/bin/bash
# setup-emulator.sh — Configure Android Emulator for TestMate
set -euo pipefail

echo "[TestMate] Setting up Android Emulator..."

# Check if adb is available
if ! command -v adb &>/dev/null; then
  echo "[TestMate] WARNING: adb not found. Please install Android SDK."
  echo "[TestMate] Skipping emulator setup."
  exit 0
fi

# Check for running devices
DEVICES=$(adb devices | grep -c "device$" 2>/dev/null || echo "0")

if [ "$DEVICES" -gt 0 ]; then
  echo "[TestMate] Found $DEVICES connected device(s)."
  adb devices
else
  echo "[TestMate] No connected devices found."
  echo "[TestMate] To create an emulator, run:"
  echo "  avdmanager create avd -n testmate_avd -k 'system-images;android-33;google_apis;x86_64'"
  echo "  emulator -avd testmate_avd"
fi

echo "[TestMate] Emulator setup check complete."
