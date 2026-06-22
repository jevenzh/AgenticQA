# agentic_qa — portable AI QA assets for coding agents

A single, version-controlled source of truth for **QA-focused AI agents, skills, and
workflows**, designed to be picked up automatically by multiple CLI coding agents —
**Claude Code, GitHub Copilot, and OpenCode** — via symlinks into each agent's
per-project config folder.

Maintain one copy here. Run `install.sh` inside any project to link these assets into
that project's `.claude/`, `.opencode/`, and `.github/` directories. Update once, and
every coding agent sees the change.

## What's inside

```
agents/            # QA subagent definitions (markdown + frontmatter)
│   ├── qa-unit-tester.md
│   ├── qa-api-tester.md
│   ├── qa-e2e-tester.md
│   └── qa-test-planner.md
skills/            # SKILL.md skills (Claude Code, OpenCode, Copilot)
│   ├── unit-test-generator/SKILL.md
│   ├── api-test-generator/SKILL.md
│   ├── e2e-test-generator/SKILL.md
│   └── test-plan-designer/SKILL.md
commands/          # slash commands / prompts (linked as agent commands)
│   ├── generate-tests.md
│   ├── review-test-coverage.md
│   ├── write-bug-report.md
│   └── regression-plan.md
install.sh         # link assets into a project's agent config folders
uninstall.sh       # remove only the links that point back here
```

Coverage spans the four requested QA domains: **unit/integration, API, E2E/UI, and
test planning** (test-case design, bug reports, regression scoping).

## Install into a project

```bash
# from the target project's root:
/path/to/agentic_qa/install.sh

# or point at the project explicitly, pick targets, preview first:
/path/to/agentic_qa/install.sh --project ~/code/my-app --target claude,opencode
/path/to/agentic_qa/install.sh --dry-run
```

Options: `-p/--project <path>`, `-t/--target claude,opencode,copilot|all`,
`--copy` (copy instead of symlink), `--force` (overwrite existing non-symlink files),
`--dry-run`. Re-running is safe and idempotent — it refreshes the links.

Remove with `./uninstall.sh` (only deletes symlinks resolving back into this repo).

## How each asset maps per agent

Every coding agent has its own config layout, so one canonical file is linked under the
name and extension each tool expects. The frontmatter is a **superset** — each tool reads
the keys it understands and ignores the rest, so the same source file works everywhere.

| Canonical asset      | Claude Code             | OpenCode                  | GitHub Copilot          |
|----------------------|-------------------------|---------------------------|-------------------------|
| `agents/*.md`        | `.claude/agents/*.md`   | `.opencode/agents/*.md`   | `.github/agents/*.md`   |
| `skills/<n>/`        | `.claude/skills/<n>/`   | `.opencode/skills/<n>/`   | `.github/skills/<n>/`   |
| `commands/*.md`      | `.claude/commands/*.md` | `.opencode/commands/*.md` | — (agents & skills only)|

Notes:
- **Skills** use the shared `SKILL.md` convention; all three agents link the skill
  directory directly.
- **Agents** become Claude Code / OpenCode subagents and Copilot custom agents
  (all three use plain `.md`).
- **Commands** become Claude Code / OpenCode slash commands. Copilot has no equivalent
  command directory, so it consumes the same intent through its agents and skills.

## Workflow for maintaining the assets

1. Edit or add files under `agents/`, `skills/`, or `commands/` here.
2. Commit (`git add -A && git commit`).
3. In each project, the symlinks already point back here — no re-install needed unless you
   added a brand-new asset (re-run `install.sh` to link new files).

## Adding a new asset

- **Agent:** add `agents/<name>.md` with `name`, `description`, `mode`, `tools`.
- **Skill:** add `skills/<name>/SKILL.md` with `name` + `description` frontmatter.
- **Command:** add `commands/<name>.md` with `description` + `mode: agent`.

Then re-run `install.sh` in any project to link the new file.

## Notes on per-project vs global

This setup links into **per-project** config folders (`.claude/`, `.opencode/`, `.github/`
at the project root), so QA assets travel with — and can be committed to — each project.
To make them available globally instead, the same `install.sh` mapping can be pointed at a
user-level config dir; per-project was chosen deliberately for portability and team sharing.

## References

- Claude Code subagents, skills, and slash commands (`.claude/`).
- OpenCode agents, commands, and skills (`.opencode/`, plural dir names; singular kept for
  backwards compatibility): https://opencode.ai/docs/agents/ , https://opencode.ai/docs/skills/
- GitHub Copilot custom instructions, prompt files, and chat modes (`.github/`):
  https://docs.github.com/en/copilot/tutorials/customization-library/prompt-files
