#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

run_check() {
  local label="$1"
  local cmd="$2"
  echo "[check] $label"
  eval "$cmd"
}

run_check "install dry-run" "./install.sh --dry-run --project . --target all >/tmp/agenticqa-install-dry-run.log"
run_check "repo consistency" "./scripts/check-repo-consistency.sh"
run_check "skill maturity matrix generation" "./scripts/generate-skill-maturity-matrix.sh"

run_check "test-plan-designer template" "skills/test-plan-designer/scripts/validate-test-plan.sh skills/test-plan-designer/templates/test-plan-template.md"
run_check "uat-script-designer template" "skills/uat-script-designer/scripts/validate-uat-yaml.sh skills/uat-script-designer/templates/uat-script-template.yaml"
run_check "unit-test-generator template" "skills/unit-test-generator/scripts/validate-unit-test-plan.sh skills/unit-test-generator/templates/unit-test-plan-template.md"
run_check "api-test-generator template" "skills/api-test-generator/scripts/validate-api-test-matrix.sh skills/api-test-generator/templates/api-test-matrix-template.md"
run_check "qa-governance-workflow template" "skills/qa-governance-workflow/scripts/validate-gate-matrix.sh skills/qa-governance-workflow/templates/gate-matrix-template.md"
run_check "test-reliability-manager template" "skills/test-reliability-manager/scripts/validate-reliability-report.sh skills/test-reliability-manager/templates/reliability-report-template.md"
run_check "qa-metrics-scorecard template" "skills/qa-metrics-scorecard/scripts/validate-qa-scorecard.sh skills/qa-metrics-scorecard/templates/qa-scorecard-template.md"
run_check "security-test-generator template" "skills/security-test-generator/scripts/validate-security-report.sh skills/security-test-generator/templates/security-matrix-template.md"
run_check "performance-test-generator template" "skills/performance-test-generator/scripts/validate-perf-report.sh skills/performance-test-generator/templates/perf-report-template.md"
run_check "test-environment-and-data template" "skills/test-environment-and-data/scripts/validate-env-data-readiness.sh skills/test-environment-and-data/templates/env-data-readiness-template.md"

# The E2E scanner expects real test files in a target repo, so validate the script exists and is executable here.
run_check "e2e anti-pattern scanner present" "test -x skills/e2e-test-generator/scripts/scan-e2e-anti-patterns.sh"

echo "All skill asset checks passed."
