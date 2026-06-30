#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

echo "[check] skill package entrypoints"
while IFS= read -r dir; do
  if [[ ! -f "$dir/SKILL.md" ]]; then
    echo "missing SKILL.md in $dir" >&2
    fail=1
  fi
done < <(find skills -mindepth 1 -maxdepth 1 -type d | sort)

echo "[check] README command inventory"
while IFS= read -r cmd_file; do
  name="$(basename "$cmd_file")"
  if ! rg -Fq "$name" README.md; then
    echo "README missing command entry: $name" >&2
    fail=1
  fi
done < <(find commands -maxdepth 1 -type f -name '*.md' | sort)

echo "[check] README agent inventory"
while IFS= read -r agent_file; do
  name="$(basename "$agent_file")"
  if ! rg -Fq "$name" README.md; then
    echo "README missing agent entry: $name" >&2
    fail=1
  fi
done < <(find agents -maxdepth 1 -type f -name '*.md' | sort)

echo "[check] README skill inventory"
while IFS= read -r skill_dir; do
  name="$(basename "$skill_dir")/SKILL.md"
  if ! rg -Fq "$name" README.md; then
    echo "README missing skill entry: $name" >&2
    fail=1
  fi
done < <(find skills -mindepth 1 -maxdepth 1 -type d | sort)

if [[ $fail -ne 0 ]]; then
  exit 1
fi

echo "repo consistency checks passed"
