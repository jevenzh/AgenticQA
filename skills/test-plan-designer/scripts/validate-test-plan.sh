#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <test-plan.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Risks, Assumptions, Open Questions"
  "## Test Case Design Spec"
  "## Test Cases"
  "## Automated vs Manual/UAT Coverage Split"
  "## Quality Gate Mapping"
  "## Acceptance Metrics"
  "## Test Data and Environments"
  "## Regression Scope"
  "## Out of Scope"
)

fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done

if ! grep -Eq '^\|[[:space:]]*ID[[:space:]]*\|[[:space:]]*Layer[[:space:]]*\|[[:space:]]*Priority[[:space:]]*\|' "$file"; then
  echo "missing Test Cases table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Behavior[[:space:]]*\|[[:space:]]*Automated Layer[[:space:]]*\|[[:space:]]*Manual/UAT Needed[[:space:]]*\|' "$file"; then
  echo "missing Automated vs Manual/UAT Coverage Split table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Case ID[[:space:]]*\|[[:space:]]*Gate Stage[[:space:]]*\|' "$file"; then
  echo "missing Quality Gate Mapping table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Metric[[:space:]]*\|[[:space:]]*Threshold[[:space:]]*\|' "$file"; then
  echo "missing Acceptance Metrics table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[^-].*\|.*\|.*\|.*\|.*\|.*\|.*\|.*\|$' "$file"; then
  echo "warning: no populated markdown table rows detected" >&2
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "test plan structure looks valid: $file"
