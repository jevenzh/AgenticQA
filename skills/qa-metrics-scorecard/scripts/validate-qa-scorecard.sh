#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <qa-scorecard.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## KPI Table"
  "## Risk Summary"
  "## Corrective Actions"
)
fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done
if ! grep -Eq '^\|[[:space:]]*Metric[[:space:]]*\|[[:space:]]*Current[[:space:]]*\|[[:space:]]*Threshold[[:space:]]*\|[[:space:]]*Trend[[:space:]]*\|[[:space:]]*Status[[:space:]]*\|[[:space:]]*Notes[[:space:]]*\|' "$file"; then
  echo "missing KPI Table header" >&2
  fail=1
fi
if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "qa scorecard structure looks valid: $file"
