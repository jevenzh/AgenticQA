#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <api-test-matrix.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Operation Matrix"
  "## Data and Environment Assumptions"
  "## Remaining Risks"
)

fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done

if ! grep -Eq '^\|[[:space:]]*Operation[[:space:]]*\|[[:space:]]*Case Type[[:space:]]*\|[[:space:]]*Priority[[:space:]]*\|[[:space:]]*Preconditions[[:space:]]*\|[[:space:]]*Expected Result[[:space:]]*\|' "$file"; then
  echo "missing Operation Matrix table header" >&2
  fail=1
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "API test matrix structure looks valid: $file"
