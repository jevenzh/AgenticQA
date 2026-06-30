#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

out="docs/skill-maturity-matrix.md"
mkdir -p "$(dirname "$out")"

{
  echo "# Skill Maturity Matrix"
  echo
  echo "This matrix is generated from the current filesystem layout."
  echo
  echo "| Skill | Templates | Examples | References | Scripts | Notes |"
  echo "|---|---|---|---|---|---|"

  find skills -mindepth 1 -maxdepth 1 -type d | sort | while read -r dir; do
    skill="$(basename "$dir")"
    templates="No"
    examples="No"
    references="No"
    scripts="No"
    [[ -d "$dir/templates" ]] && templates="Yes"
    [[ -d "$dir/examples" ]] && examples="Yes"
    [[ -d "$dir/references" ]] && references="Yes"
    [[ -d "$dir/scripts" ]] && scripts="Yes"

    notes=()
    [[ -f "$dir/SKILL.md" ]] || notes+=("missing SKILL.md")
    [[ "$scripts" == "No" ]] && notes+=("no reusable validator/scanner")
    if [[ ${#notes[@]} -eq 0 ]]; then
      note="meets mature-package pattern"
    else
      note="$(IFS='; '; echo "${notes[*]}")"
    fi

    echo "| \`$skill\` | $templates | $examples | $references | $scripts | $note |"
  done

  echo
  echo "## Interpretation"
  echo
  echo "- \`Templates\` means the skill defines a reusable artifact shape."
  echo "- \`Examples\` means the skill shows at least one concrete target output."
  echo "- \`References\` means the skill includes trusted theory, heuristics, or external best-practice anchors."
  echo "- \`Scripts\` means the skill ships a reusable validator or scanner rather than relying on prose alone."
  echo
  echo "## Current Assessment"
  echo
  echo "Treat this file as generated state. Re-run \`./scripts/generate-skill-maturity-matrix.sh\` after adding or removing skill support folders."
} > "$out"
