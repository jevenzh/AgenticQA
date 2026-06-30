#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <gate-matrix.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Gate Matrix"
  "## Blocking Conditions"
  "## Waivers"
  "## Remediation Actions"
)
fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done
if ! grep -Eq '^\|[[:space:]]*Stage[[:space:]]*\|[[:space:]]*Signal[[:space:]]*\|[[:space:]]*Threshold[[:space:]]*\|[[:space:]]*Owner[[:space:]]*\|[[:space:]]*Block Behavior[[:space:]]*\|[[:space:]]*Status[[:space:]]*\|' "$file"; then
  echo "missing Gate Matrix table header" >&2
  fail=1
fi
if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "quality gate matrix structure looks valid: $file"
