#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <env-data-readiness.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Environment Prerequisites"
  "## Seed and Reset Contract"
  "## Setup and Teardown Checklist"
  "## Isolation Risks"
  "## Readiness Decision"
)
fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done
if ! grep -Eq '^\|[[:space:]]*Dependency[[:space:]]*\|[[:space:]]*Required Version[[:space:]]*\|[[:space:]]*Present[[:space:]]*\|[[:space:]]*Notes[[:space:]]*\|' "$file"; then
  echo "missing Environment Prerequisites table header" >&2
  fail=1
fi
if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "environment and data readiness structure looks valid: $file"
