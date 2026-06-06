#!/bin/bash
# verify-deployment.sh — Verify TestMate deployment
set -uo pipefail

# Ensure maestro and java are in PATH
export PATH="$PATH:$HOME/.maestro/bin"
[ -d "$HOME/.local/java" ] && export JAVA_HOME=$(ls -d $HOME/.local/java/jdk-* 2>/dev/null | head -1)
[ -n "${JAVA_HOME:-}" ] && export PATH="$JAVA_HOME/bin:$PATH"

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if eval "$@"; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=========================================="
echo " TestMate Deployment Verification"
echo "=========================================="

# Check 1: Maestro CLI
check "Maestro CLI is installed" "command -v maestro &>/dev/null"

# Check 2: Maestro version
if command -v maestro &>/dev/null; then
  VERSION=$(maestro --version 2>&1)
  check "Maestro version: $VERSION" "[[ -n '$VERSION' ]]"
else
  FAIL=$((FAIL+1))
  echo "[FAIL] Maestro CLI not installed"
fi

# Check 3: Project structure
check "scripts/ directory exists" "[[ -d scripts ]]"
check "templates/ directory exists" "[[ -d templates ]]"
check "flows/ directory exists" "[[ -d flows ]]"
check "ci/ directory exists" "[[ -d ci ]]"
check "docs/ directory exists" "[[ -d docs ]]"

# Check 4: Template files
check "Ecommerce templates exist" "[[ -d templates/ecommerce ]]"
check "Social templates exist" "[[ -d templates/social ]]"
check "Finance templates exist" "[[ -d templates/finance ]]"

# Check 5: CI config files
check "GitHub Actions config exists" "[[ -f ci/github-actions.yml ]]"
check "GitLab CI config exists" "[[ -f ci/gitlab-ci.yml ]]"

# Check 6: Documentation
check "README.md exists" "[[ -f README.md ]]"
check "TECH_STACK.md exists" "[[ -f docs/TECH_STACK.md ]]"
check "ARCHITECTURE.md exists" "[[ -f docs/ARCHITECTURE.md ]]"
check "TEST_CASES.md exists" "[[ -f docs/TEST_CASES.md ]]"

echo "=========================================="
echo " Results: $PASS passed, $FAIL failed"
echo "=========================================="

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
