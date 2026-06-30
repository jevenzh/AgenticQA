---
name: uat-script-designer
description: Create business-facing UAT test scripts in YAML with step-by-step actions, expected outcomes, evidence requirements, and sign-off context. Use when a change needs manual acceptance testing, business validation, rehearsal, or regulated sign-off.
when_to_use: Use when the user asks for UAT scripts, manual acceptance steps, sign-off checklists, business validation flows, or non-code executable test actions. Triggers include "UAT", "acceptance test script", "manual test steps", "business sign-off", and "YAML test script".
argument-hint: [feature|flow|acceptance-scope]
---

# UAT Script Designer

Use this skill to convert acceptance scenarios into business-executable YAML scripts.

## Inputs

- Scope: `$ARGUMENTS`
- Upstream test case design spec or test plan when available
- Business roles, environments, and sign-off expectations

## Procedure

1. Use `references/uat-vs-e2e-boundary.md` to identify which scenarios truly require UAT rather than automated-only coverage.
2. Write each script for a human operator, not a test runner.
3. For each scenario, capture:
   - business goal
   - preconditions
   - ordered actions
   - expected outcome per step
   - evidence to collect
   - postconditions
4. Keep steps concrete and environment-specific enough to execute without interpretation; use `references/yaml-authoring-rules.md` when shaping the YAML.
5. Mark who performs the script, what evidence is required, and what constitutes acceptance using `references/business-evidence-guidelines.md`.
6. Call out any overlap with automated E2E/API coverage so teams do not duplicate effort blindly.
7. If authoring a local YAML artifact, optionally run `scripts/validate-uat-yaml.sh <file>` before presenting it.

## Output contract

Use `templates/uat-script-template.yaml`.

Required fields:

- suite
- scenario_id
- title
- business_goal
- preconditions
- steps
- postconditions
- evidence
- priority
- owner
- acceptance_criteria

## Guardrails

- Do not use developer-centric jargon when business testers are the audience.
- Do not produce YAML scripts for scenarios that are purely internal code-level checks.
- Do not omit evidence fields for sign-off workflows.
- Do not blur automated assertions and manual actions into one ambiguous script.

## Reference assets

- Template: `templates/uat-script-template.yaml`
- Example: `examples/sample-uat-script.yaml`
- Validation script: `scripts/validate-uat-yaml.sh`
- Theory/practice reference: `references/uat-vs-e2e-boundary.md`
- Theory/practice reference: `references/business-evidence-guidelines.md`
- Theory/practice reference: `references/yaml-authoring-rules.md`
- Related skill: `../test-plan-designer/SKILL.md`
