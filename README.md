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
│   ├── unit-test-generator/     # unit & integration tests, mutation testing, property-based
│   ├── api-test-generator/      # REST/GraphQL tests, Pact contracts, OWASP security
│   ├── e2e-test-generator/      # browser tests, visual regression, a11y, Core Web Vitals
│   ├── test-plan-designer/      # ISTQB CTAL techniques, SFDIPOT, FEW HICCUPPS
│   ├── mutation-test-auditor/   # mutation score analysis, survivor classification
│   ├── contract-test-generator/ # consumer-driven contracts with Pact
│   ├── test-data-builder/       # factories, builders, faker, isolation strategies
│   ├── flaky-test-detective/    # flaky test root-cause diagnosis and fixes
│   └── exploratory-test-charter/ # session-based exploratory testing charters
commands/          # slash commands / prompts (linked as agent commands)
│   ├── generate-tests.md
│   ├── review-test-coverage.md
│   ├── write-bug-report.md
│   └── regression-plan.md
install.sh         # link assets into a project's agent config folders
uninstall.sh       # remove only the links that point back here
```

Coverage spans the full professional QA spectrum: **unit/integration, API, E2E/UI,
test planning, mutation quality validation, consumer-driven contracts, test data
management, flaky test diagnosis, and exploratory testing**.

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

## Skill reference

| Skill | What it does |
|---|---|
| `unit-test-generator` | Unit/integration tests with 2-value BVA, mutation testing, property-based testing |
| `api-test-generator` | REST/GraphQL tests with Pact contracts, OWASP API Top 10, IDOR checks |
| `e2e-test-generator` | Browser tests with SFDIPOT journey mapping, visual regression, axe-core a11y |
| `test-plan-designer` | ISTQB CTAL plan design: decision tables, N-switch, pairwise, FEW HICCUPPS oracles |
| `mutation-test-auditor` | Mutation score analysis, survivor classification by type, risk-based thresholds |
| `contract-test-generator` | Consumer-driven Pact contracts, provider verification, `can-i-deploy` CI gate |
| `test-data-builder` | Factory/builder/faker scaffolding, in-memory vs persisted strategy, parallel safety |
| `flaky-test-detective` | Root-cause classification (race, shared state, time, network, env) and fixes |
| `exploratory-test-charter` | Time-boxed charters using SFDIPOT heuristics and FEW HICCUPPS oracles |

## Adding a new asset

- **Agent:** add `agents/<name>.md` with `name`, `description`, `mode`, `permission`.
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
