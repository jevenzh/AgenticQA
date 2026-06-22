#!/usr/bin/env bash
#
# uninstall.sh — remove symlinks that point back into this QA assets repo.
# Only removes links resolving into REPO_ROOT/assets; leaves your own files alone.
#
# Usage: ./uninstall.sh [-p <project>] [-t claude,opencode,copilot|all] [--dry-run]
#
set -euo pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
  SOURCE="$(readlink "$SOURCE")"; [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
REPO_ROOT="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
ASSETS="$REPO_ROOT/assets"

PROJECT="$(pwd)"; TARGETS="all"; DRY=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--project) PROJECT="$2"; shift 2;;
    -t|--target)  TARGETS="$2"; shift 2;;
    --dry-run)    DRY=1; shift;;
    -h|--help)    grep '^#' "$0" | sed 's/^#//'; exit 0;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done
PROJECT="$(cd "$PROJECT" && pwd)"
[[ "$TARGETS" == "all" ]] && TARGETS="claude,opencode,copilot"

declare -a DIRS
IFS=',' read -ra LIST <<< "$TARGETS"
for t in "${LIST[@]}"; do
  case "$t" in
    claude)   DIRS+=("$PROJECT/.claude/agents" "$PROJECT/.claude/commands" "$PROJECT/.claude/skills");;
    opencode) DIRS+=("$PROJECT/.opencode/agents" "$PROJECT/.opencode/commands" "$PROJECT/.opencode/skills");;
    copilot)  DIRS+=("$PROJECT/.github/chatmodes" "$PROJECT/.github/prompts");;
  esac
done

removed=0
for d in "${DIRS[@]}"; do
  [[ -d "$d" ]] || continue
  for link in "$d"/* "$d"/.*; do
    [[ -L "$link" ]] || continue
    target="$(readlink "$link")"
    case "$target" in
      "$ASSETS"/*)
        if [[ $DRY -eq 1 ]]; then echo "  - would remove ${link#$PROJECT/}"; else rm -f "$link"; echo "  - removed ${link#$PROJECT/}"; fi
        removed=$((removed+1));;
    esac
  done
done
echo "Removed $removed link(s)."
