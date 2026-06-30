#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <security-report.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Threat Surface"
  "## Security Test Matrix"
  "## Findings"
  "## Remediation"
)

fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done

if ! grep -Eq '^\|[[:space:]]*Area[[:space:]]*\|[[:space:]]*Test Case[[:space:]]*\|[[:space:]]*Expected[[:space:]]*\|[[:space:]]*Result[[:space:]]*\|[[:space:]]*Evidence[[:space:]]*\|' "$file"; then
  echo "missing Security Test Matrix table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*ID[[:space:]]*\|[[:space:]]*Severity[[:space:]]*\|[[:space:]]*Description[[:space:]]*\|[[:space:]]*Repro Steps[[:space:]]*\|[[:space:]]*Evidence[[:space:]]*\|[[:space:]]*Blocker[[:space:]]*\|' "$file"; then
  echo "missing Findings table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Finding ID[[:space:]]*\|[[:space:]]*Action[[:space:]]*\|[[:space:]]*Owner[[:space:]]*\|[[:space:]]*Due[[:space:]]*\|' "$file"; then
  echo "missing Remediation table header" >&2
  fail=1
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "security report structure looks valid: $file"
