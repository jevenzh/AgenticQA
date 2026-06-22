#!/usr/bin/env bash
#
# install.sh — symlink the canonical QA AI assets into a project's
# coding-agent config folders (Claude Code, OpenCode, GitHub Copilot).
#
# One source of truth (this repo's assets/) is linked into each agent's
# hidden config directory inside the TARGET PROJECT, so every coding agent
# picks up the same QA agents, skills, and workflows.
#
# Usage:
#   ./install.sh [options]
#
# Options:
#   -p, --project <path>   Target project root (default: current directory)
#   -t, --target  <list>   Comma list of: claude,opencode,copilot,all (default: all)
#       --copy             Copy files instead of symlinking
#       --force            Overwrite existing non-symlink files
#       --dry-run          Print actions without changing anything
#   -h, --help             Show this help
#
set -euo pipefail

# ---- resolve this repo's absolute path (follow symlinks) --------------------
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
REPO_ROOT="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
ASSETS="$REPO_ROOT"

# ---- defaults --------------------------------------------------------------
PROJECT="$(pwd)"
TARGETS="all"
MODE="link"      # link | copy
FORCE=0
DRY=0

# ---- args ------------------------------------------------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--project) PROJECT="$2"; shift 2;;
    -t|--target)  TARGETS="$2"; shift 2;;
    --copy)       MODE="copy"; shift;;
    --force)      FORCE=1; shift;;
    --dry-run)    DRY=1; shift;;
    -h|--help)    grep '^#' "$0" | sed 's/^#//'; exit 0;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done

PROJECT="$(cd "$PROJECT" 2>/dev/null && pwd)" || { echo "Project path not found" >&2; exit 1; }
[[ "$TARGETS" == "all" ]] && TARGETS="claude,opencode,copilot"

echo "Source repo : $REPO_ROOT"
echo "Project     : $PROJECT"
echo "Targets     : $TARGETS"
echo "Mode        : $MODE$([[ $DRY -eq 1 ]] && echo '  (dry-run)')"
echo

# ---- helpers ---------------------------------------------------------------
run() { if [[ $DRY -eq 1 ]]; then echo "  + $*"; else eval "$@"; fi; }

# place SRC at DEST as a symlink (or copy). SRC may be a file or directory.
place() {
  local src="$1" dest="$2"
  if [[ ! -e "$src" ]]; then return; fi
  run "mkdir -p \"\$(dirname \"$dest\")\""
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" ]]; then
      run "rm -f \"$dest\""                       # refresh our own/any symlink
    elif [[ $FORCE -eq 1 ]]; then
      run "rm -rf \"$dest\""
    else
      echo "  ! skip (exists, not a symlink): $dest  — use --force to overwrite"
      return
    fi
  fi
  if [[ "$MODE" == "copy" ]]; then
    run "cp -R \"$src\" \"$dest\""
  else
    run "ln -s \"$src\" \"$dest\""
  fi
  echo "  -> ${dest#$PROJECT/}"
}

link_files() {  # link_files <src_dir> <glob> <dest_dir> <suffix>
  local src_dir="$1" glob="$2" dest_dir="$3" suffix="$4"
  shopt -s nullglob
  for f in "$src_dir"/$glob; do
    local base; base="$(basename "$f" .md)"
    place "$f" "$dest_dir/${base}${suffix}"
  done
  shopt -u nullglob
}

link_skills() {  # link each skill directory
  local dest_dir="$1"
  shopt -s nullglob
  for d in "$ASSETS"/skills/*/; do
    local name; name="$(basename "$d")"
    place "${d%/}" "$dest_dir/$name"
  done
  shopt -u nullglob
}

# ---- per-target installers -------------------------------------------------
install_claude() {
  echo "[Claude Code] -> .claude/"
  link_files "$ASSETS/agents"    '*.md' "$PROJECT/.claude/agents"   ".md"
  link_files "$ASSETS/commands" '*.md' "$PROJECT/.claude/commands" ".md"
  link_skills "$PROJECT/.claude/skills"
  echo
}

install_opencode() {
  echo "[OpenCode] -> .opencode/"
  link_files "$ASSETS/agents"    '*.md' "$PROJECT/.opencode/agents"   ".md"
  link_files "$ASSETS/commands" '*.md' "$PROJECT/.opencode/commands" ".md"
  link_skills "$PROJECT/.opencode/skills"
  echo
}

install_copilot() {
  echo "[GitHub Copilot] -> .github/"
  link_files "$ASSETS/agents" '*.md' "$PROJECT/.github/agents" ".md"
  link_skills "$PROJECT/.github/skills"
  echo
}

IFS=',' read -ra LIST <<< "$TARGETS"
for t in "${LIST[@]}"; do
  case "$t" in
    claude)   install_claude;;
    opencode) install_opencode;;
    copilot)  install_copilot;;
    *) echo "Unknown target: $t" >&2;;
  esac
done

echo "Done. Commit the canonical assets in this repo; the links above point back to them."
