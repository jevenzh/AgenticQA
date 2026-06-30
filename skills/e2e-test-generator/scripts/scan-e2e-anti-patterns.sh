#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <e2e-test-file-or-dir> [...]" >&2
  exit 2
fi

patterns=(
  'sleep\s*\('
  'waitForTimeout\s*\('
  'page\.waitFor\s*\([[:space:]]*[0-9]+'
  '\$\('
  'document\.querySelector\s*\('
  'locator\(["\x27][#.][^"\x27]+'
  'getByText\(["\x27].+["\x27]\)'
)

labels=(
  'fixed sleep() usage'
  'Playwright waitForTimeout usage'
  'numeric page.waitFor(...) usage'
  'jQuery-style selector usage'
  'raw document.querySelector usage'
  'css/id/class locator() usage'
  'text-only locator that may be brittle'
)

files=()
for path in "$@"; do
  if [[ -d "$path" ]]; then
    while IFS= read -r f; do
      files+=("$f")
    done < <(find "$path" -type f \( -name '*.spec.*' -o -name '*.test.*' -o -name '*playwright*' -o -name '*cypress*' \))
  elif [[ -f "$path" ]]; then
    files+=("$path")
  fi
done

if [[ ${#files[@]} -eq 0 ]]; then
  echo "no matching files found" >&2
  exit 2
fi

found=0
for file in "${files[@]}"; do
  for i in "${!patterns[@]}"; do
    if grep -En "${patterns[$i]}" "$file" >/tmp/e2e_scan_match.$$ 2>/dev/null; then
      found=1
      echo "[$file] ${labels[$i]}"
      cat /tmp/e2e_scan_match.$$
    fi
  done
done
rm -f /tmp/e2e_scan_match.$$ 2>/dev/null || true

if [[ $found -eq 0 ]]; then
  echo "no common E2E anti-patterns detected"
fi
