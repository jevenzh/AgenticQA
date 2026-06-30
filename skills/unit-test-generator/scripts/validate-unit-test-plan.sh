#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <unit-test-plan.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Target"
  "## Case Inventory"
  "## Test Boundaries"
  "## Risks and Gaps"
)

fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done

if ! grep -Eq '^\|[[:space:]]*Case ID[[:space:]]*\|[[:space:]]*Type[[:space:]]*\|[[:space:]]*Priority[[:space:]]*\|[[:space:]]*Scenario[[:space:]]*\|[[:space:]]*Expected Outcome[[:space:]]*\|' "$file"; then
  echo "missing Case Inventory table header" >&2
  fail=1
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "unit test plan structure looks valid: $file"
