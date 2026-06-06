#!/bin/bash
# tests/unit/test-scripts.sh — Unit tests for TestMate scripts
set -uo pipefail

PASS=0
FAIL=0
PROJ_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

check() {
  local desc="$1"
  shift
  if eval "$@" >/dev/null 2>&1; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=== TestMate Unit Tests: Script Validation ==="

# --- install-maestro.sh ---
check "install-maestro.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/install-maestro.sh ]]"
check "install-maestro.sh has shebang" "head -1 $PROJ_ROOT/scripts/install-maestro.sh | grep -q '^#!/bin/bash'"
check "install-maestro.sh has set -euo pipefail" "grep -q 'set -euo pipefail' $PROJ_ROOT/scripts/install-maestro.sh"
check "install-maestro.sh handles Linux OS" "grep -q 'Linux' $PROJ_ROOT/scripts/install-maestro.sh"
check "install-maestro.sh handles Darwin OS" "grep -q 'Darwin' $PROJ_ROOT/scripts/install-maestro.sh"
check "install-maestro.sh verifies installation" "grep -q 'maestro --version' $PROJ_ROOT/scripts/install-maestro.sh"

# --- setup-emulator.sh ---
check "setup-emulator.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/setup-emulator.sh ]]"
check "setup-emulator.sh has shebang" "head -1 $PROJ_ROOT/scripts/setup-emulator.sh | grep -q '^#!/bin/bash'"
check "setup-emulator.sh has set -euo pipefail" "grep -q 'set -euo pipefail' $PROJ_ROOT/scripts/setup-emulator.sh"
check "setup-emulator.sh checks for adb" "grep -q 'command -v adb' $PROJ_ROOT/scripts/setup-emulator.sh"
check "setup-emulator.sh checks for connected devices" "grep -q 'adb devices' $PROJ_ROOT/scripts/setup-emulator.sh"

# --- verify-deployment.sh ---
check "verify-deployment.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/verify-deployment.sh ]]"
check "verify-deployment.sh has shebang" "head -1 $PROJ_ROOT/scripts/verify-deployment.sh | grep -q '^#!/bin/bash'"
check "verify-deployment.sh has set -uo pipefail" "grep -q 'set -uo pipefail' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh checks Maestro CLI" "grep -q 'command -v maestro' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh checks project structure" "grep -q 'scripts/' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh checks templates" "grep -q 'templates/' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh checks CI configs" "grep -q 'ci/' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh reports pass/fail counts" "grep -q 'passed' $PROJ_ROOT/scripts/verify-deployment.sh"

# --- run-tests.sh ---
check "run-tests.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/run-tests.sh ]]"
check "run-tests.sh has shebang" "head -1 $PROJ_ROOT/scripts/run-tests.sh | grep -q '^#!/bin/bash'"
check "run-tests.sh has set -euo pipefail" "grep -q 'set -euo pipefail' $PROJ_ROOT/scripts/run-tests.sh"
check "run-tests.sh uses maestro test" "grep -q 'maestro test' $PROJ_ROOT/scripts/run-tests.sh"

echo ""
echo "=== TestMate Unit Tests: YAML Template Validation ==="

# Validate sample flow YAML
check "sample-flow.yaml exists" "[[ -f $PROJ_ROOT/flows/sample-flow.yaml ]]"
check "sample-flow.yaml is valid YAML" "python3 -c 'import yaml; list(yaml.safe_load_all(open(\"$PROJ_ROOT/flows/sample-flow.yaml\")))' 2>/dev/null"

# Validate template YAMLs
for template in templates/ecommerce/checkout-flow.yaml templates/ecommerce/login-flow.yaml templates/ecommerce/search-flow.yaml templates/social/register-flow.yaml templates/social/post-flow.yaml templates/social/interact-flow.yaml templates/finance/login-flow.yaml templates/finance/transfer-flow.yaml templates/finance/statement-flow.yaml; do
  check "$template exists and is valid YAML" "[[ -f $PROJ_ROOT/$template ]] && python3 -c 'import yaml; list(yaml.safe_load_all(open(\"$PROJ_ROOT/$template\")))' 2>/dev/null"
done

echo ""
echo "=== TestMate Unit Tests: CI Config Validation ==="

check "github-actions.yml exists" "[[ -f $PROJ_ROOT/ci/github-actions.yml ]]"
check "github-actions.yml has maestro step" "grep -q 'maestro' $PROJ_ROOT/ci/github-actions.yml"
check "github-actions.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/ci/github-actions.yml\"))' 2>/dev/null"

check "gitlab-ci.yml exists" "[[ -f $PROJ_ROOT/ci/gitlab-ci.yml ]]"
check "gitlab-ci.yml has maestro step" "grep -q 'maestro' $PROJ_ROOT/ci/gitlab-ci.yml"
check "gitlab-ci.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/ci/gitlab-ci.yml\"))' 2>/dev/null"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
