# agentic_qa — portable AI QA assets for coding agents

A single, version-controlled source of truth for **QA-focused AI agents, skills, and
workflows**, designed to be picked up automatically by multiple CLI coding agents —
**Claude Code, GitHub Copilot, and OpenCode** — via symlinks into each agent's
per-project config folder.

Maintain one copy here. Run `install.sh` inside any project to link these assets into
that project's `.claude/`, `.opencode/`, and `.github/` directories. Update once, and
every coding agent sees the change.

## What's inside

```text
agents/            # QA subagent definitions (markdown + frontmatter)
│   ├── qa-unit-tester.md
│   ├── qa-api-tester.md
│   ├── qa-e2e-tester.md
│   ├── qa-test-planner.md
│   ├── qa-security-tester.md
│   └── qa-performance-tester.md
skills/            # SKILL.md skills (Claude Code, OpenCode, Copilot)
│   ├── unit-test-generator/SKILL.md
│   │   ├── templates/
│   │   ├── examples/
│   │   ├── references/
│   │   └── scripts/
│   ├── api-test-generator/SKILL.md
│   ├── e2e-test-generator/SKILL.md
│   ├── test-plan-designer/SKILL.md
│   ├── qa-governance-workflow/SKILL.md
│   ├── test-reliability-manager/SKILL.md
│   ├── qa-metrics-scorecard/SKILL.md
│   ├── security-test-generator/SKILL.md
│   ├── performance-test-generator/SKILL.md
│   ├── test-environment-and-data/SKILL.md
│   └── uat-script-designer/SKILL.md
commands/          # slash commands / prompts (linked as agent commands)
│   ├── generate-tests.md
│   ├── review-test-coverage.md
│   ├── write-bug-report.md
│   ├── regression-plan.md
│   ├── quality-gates.md
│   ├── test-reliability-audit.md
│   ├── qa-scorecard.md
│   ├── security-regression-plan.md
│   ├── performance-budget-check.md
│   ├── test-data-readiness.md
│   ├── generate-uat-scripts.md
│   └── generate-qa-artifact-pack.md
install.sh         # link assets into a project's agent config folders
uninstall.sh       # remove only the links that point back here
```

Skill packages are not just `SKILL.md` files. Mature skills also include supporting `templates/`, `examples/`, `references/`, and optional `scripts/` for validation or scanning.

Coverage spans QA domains including **unit/integration, API, E2E/UI, test planning,
test case design specs, UAT script design, quality governance, reliability management,
security testing, performance/resilience, and test environment/data readiness**.

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

## Standard QA workflow

1. Design the test case design spec with `test-plan-designer`.
2. When business acceptance applies, create YAML UAT scripts with `uat-script-designer`.
   The `generate-uat-scripts` command should be the default entrypoint when the user asks for manual acceptance or sign-off artifacts.
3. Plan scope using risk, blast radius, and `regression-plan`.
4. Define quality gates per stage with `quality-gates`.
5. Generate and run layer-appropriate tests (unit/API/E2E/security/performance).
6. Use `generate-qa-artifact-pack` when a team wants the full chain from test design through automated coverage and UAT artifacts.
7. Audit reliability with `test-reliability-audit` and resolve flakes.
8. Validate environment/data readiness with `test-data-readiness`.
9. Review coverage with `review-test-coverage` and close high-risk gaps.
10. Produce release health decision with `qa-scorecard`.

## Workflow for maintaining the assets

1. Edit or add files under `agents/`, `skills/`, or `commands/` here.
2. Run `./scripts/validate-skill-assets.sh` to verify template validators and install discovery.
   This also checks repo inventory consistency and regenerates the skill maturity matrix.
3. Commit (`git add -A && git commit`).
4. In each project, the symlinks already point back here — no re-install needed unless you
   added a brand-new asset (re-run `install.sh` to link new files).

## Adding a new asset

- **Agent:** add `agents/<name>.md` with `name`, `description`, `mode`, `tools`.
- **Skill:** add `skills/<name>/SKILL.md` with `name` + `description` frontmatter.
- Add `templates/`, `examples/`, `references/`, and `scripts/` when the skill needs reusable artifacts, validation helpers, or theory-backed guidance.
- **Command:** add `commands/<name>.md` with `description` + `mode: agent`.

Example end-to-end artifact chain: `docs/examples/sample-qa-artifact-pack.md`.
Reference-authoring guide: `docs/guides/theory-backed-reference-authoring.md`.
Skill maturity matrix: `docs/skill-maturity-matrix.md`.
Matrix generator: `scripts/generate-skill-maturity-matrix.sh`.
Consistency checker: `scripts/check-repo-consistency.sh`.

## Recommended Skill Package Shape

Use this structure for mature skills:

```text
skills/<name>/
├── SKILL.md                 # concise workflow entrypoint
├── templates/               # output skeletons the agent fills in
├── examples/                # high-quality sample outputs
├── references/              # trusted theory, heuristics, and decision guides
└── scripts/                 # optional validators or scanners for repeatable checks
```

Guidance:
- Keep `SKILL.md` short and load supporting assets only where they improve decisions or artifact quality.
- Put reusable theory and heuristics in `references/`, not inline in the entrypoint.
- Add `scripts/` only for repeatable validation or scanning tasks; do not hide reasoning inside scripts.
- Prefer repo-local examples and templates over generic prose.

Then re-run `install.sh` in any project to link the new file.

## Repo Validation

- Run `./scripts/validate-skill-assets.sh` to execute all shipped skill validators against their templates and confirm `install.sh --dry-run` still discovers the repo correctly.
- Run `./scripts/generate-skill-maturity-matrix.sh` to refresh the maturity matrix from the filesystem.
- Run `./scripts/check-repo-consistency.sh` to ensure README inventory and skill entrypoints stay aligned.
- GitHub Actions runs the same check via `.github/workflows/validate-skill-assets.yml` on push and pull request.

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
