#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <uat-script.yaml>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_keys=(
  "suite:"
  "scenario_id:"
  "title:"
  "business_goal:"
  "preconditions:"
  "steps:"
  "postconditions:"
  "evidence:"
  "priority:"
  "owner:"
  "acceptance_criteria:"
)

fail=0
for key in "${required_keys[@]}"; do
  if ! grep -Eq "^[[:space:]]*${key}" "$file"; then
    echo "missing key: ${key%:}" >&2
    fail=1
  fi
done

step_actions=$(grep -Ec '^[[:space:]]*-[[:space:]]*action:[[:space:]]*.+$|^[[:space:]]+action:[[:space:]]*.+$' "$file" || true)
step_expected=$(grep -Ec '^[[:space:]]+expected:[[:space:]]*.+$' "$file" || true)

if [[ "$step_actions" -eq 0 ]]; then
  echo "missing populated step action entries" >&2
  fail=1
fi
if [[ "$step_expected" -eq 0 ]]; then
  echo "missing populated step expected entries" >&2
  fail=1
fi
if [[ "$step_actions" -ne "$step_expected" ]]; then
  echo "mismatch: action count ($step_actions) != expected count ($step_expected)" >&2
  fail=1
fi

if grep -Eq '^[[:space:]]*(suite|scenario_id|title|business_goal|priority|owner):[[:space:]]*""[[:space:]]*$' "$file"; then
  echo "warning: one or more scalar fields are still empty strings" >&2
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "UAT YAML structure looks valid: $file"
