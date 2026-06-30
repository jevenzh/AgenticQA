#!/usr/bin/env bash
set -euo pipefail

file="${1:-}"
if [[ -z "$file" ]]; then
  echo "usage: $0 <perf-report.md>" >&2
  exit 2
fi
if [[ ! -f "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

required_sections=(
  "## Scope"
  "## Scenarios"
  "## Budgets"
  "## Results"
  "## Bottlenecks"
  "## Recommendation"
)

fail=0
for section in "${required_sections[@]}"; do
  if ! grep -Fqx "$section" "$file"; then
    echo "missing section: $section" >&2
    fail=1
  fi
done

if ! grep -Eq '^\|[[:space:]]*Scenario[[:space:]]*\|[[:space:]]*Workload[[:space:]]*\|[[:space:]]*Duration[[:space:]]*\|[[:space:]]*Objective[[:space:]]*\|' "$file"; then
  echo "missing Scenarios table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Metric[[:space:]]*\|[[:space:]]*Target[[:space:]]*\|' "$file"; then
  echo "missing Budgets table header" >&2
  fail=1
fi

if ! grep -Eq '^\|[[:space:]]*Scenario[[:space:]]*\|[[:space:]]*p95[[:space:]]*\|[[:space:]]*p99[[:space:]]*\|[[:space:]]*Throughput[[:space:]]*\|[[:space:]]*Error Rate[[:space:]]*\|[[:space:]]*Status[[:space:]]*\|' "$file"; then
  echo "missing Results table header" >&2
  fail=1
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "performance report structure looks valid: $file"
