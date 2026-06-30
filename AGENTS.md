# Repository Guidelines

## Project Structure & Module Organization
This repository is the canonical source for portable QA assets consumed by Claude Code, OpenCode, and GitHub Copilot. Primary content lives in `agents/` for sub-agent prompts, `skills/<skill-name>/` for reusable skill packages with `SKILL.md`, `templates/`, and `examples/`, and `commands/` for slash-command style workflows. Supporting documentation lives in `docs/`. The `.claude/`, `.opencode/`, and `.github/` directories are linked install targets and should stay aligned with the canonical assets rather than edited directly.

## Build, Test, and Development Commands
There is no compiled build. Use the repo as content plus install scripts.

- `./install.sh --dry-run --project . --target all`: preview links for all supported agents.
- `./install.sh --project /path/to/app --target claude,opencode`: install or refresh symlinks in a target project.
- `./uninstall.sh --project /path/to/app`: remove links that point back to this repo.
- `git diff --stat` and `git status --short`: verify scope before committing documentation or skill changes.

## Coding Style & Naming Conventions
Write in concise Markdown with clear headings and imperative instructions. Keep files ASCII unless existing content requires otherwise. Use kebab-case for skill and command names such as `test-plan-designer` and `performance-budget-check`. Each agent or skill should expose accurate frontmatter and repo-specific examples. When adding a skill, follow the established structure: `SKILL.md`, optional `templates/`, and optional `examples/`.

## Testing Guidelines
Validation is structural and workflow-based. Re-run `./install.sh --dry-run --project . --target all` after adding or renaming assets to confirm discovery paths. Check that new skills are linkable under all three agent targets and that examples/templates referenced by `SKILL.md` actually exist. For workflow changes, verify related `README.md` sections and command docs stay consistent.

## Commit & Pull Request Guidelines
Recent history favors short, direct commit subjects such as `Fix agent frontmatter for OpenCode compatibility` and `Add relative symlinks for out-of-the-box agent support`. Keep commits atomic and scoped to one concern: agents, skills, commands, or install behavior. Pull requests should summarize affected assets, explain any cross-agent compatibility impact, and include the verification command used, typically `./install.sh --dry-run --project . --target all`.

## Agent-Specific Notes
Do not edit generated install targets in `.claude/`, `.opencode/`, or `.github/` as the source of truth. Update the canonical file under `agents/`, `skills/`, or `commands/`, then reinstall if a brand-new asset was added.
