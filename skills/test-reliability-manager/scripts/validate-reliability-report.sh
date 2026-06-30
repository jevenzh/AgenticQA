#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <reliability-report.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Reliability Summary"
  "## Flake Hotspots"
  "## Quarantine Compliance"
  "## Runtime Budget"
  "## Remediation Plan"
)
fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done
if ! grep -Eq '^\|[[:space:]]*Test/Suite[[:space:]]*\|[[:space:]]*Symptom[[:space:]]*\|[[:space:]]*Root Cause Class[[:space:]]*\|[[:space:]]*Frequency[[:space:]]*\|[[:space:]]*Impact[[:space:]]*\|' "$file"; then
  echo "missing Flake Hotspots table header" >&2
  fail=1
fi
if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "reliability report structure looks valid: $file"
