---
name: test-reliability-manager
description: Audit and improve test reliability using flake budgets, quarantine policy, runtime budgets, and deterministic execution practices.
when_to_use: Use when CI is flaky, tests are slow or unstable, quarantine is growing, or release confidence is declining. Triggers include "flaky tests", "test reliability", "quarantine", "why is CI unstable", "runtime regression".
argument-hint: [suite|tag|ci-run]
---

# Test Reliability Manager

Use this skill to make test signals trustworthy.

## Inputs

- Scope: `$ARGUMENTS` (suite/tag/run)
- Recent CI failures and retry patterns
- Existing quarantine list and ownership

## Reliability baseline

- Unit/integration flake budget: <= 0.5%
- E2E flake budget: <= 2.0%
- Quarantine SLA: <= 7 days
- PR-critical runtime budget: project-defined threshold

## Procedure

1. Identify flaky tests and group by root cause using `references/flake-root-cause-taxonomy.md`:
   - Timing/waits
   - Data-state leakage
   - Environment dependency
   - Order coupling
2. Remove fragile synchronization (no fixed sleeps).
3. Validate deterministic setup/teardown.
4. For unresolved flakes, enforce quarantine contract using `references/quarantine-policy.md`:
   - owner
   - expiry
   - removal condition
5. Check runtime drift against PR-critical path budget.
6. Produce prioritized remediation actions by impact.
7. If authoring a local markdown artifact, optionally run `scripts/validate-reliability-report.sh <file>` before presenting it.

## Output contract

Use `templates/reliability-report-template.md`.

Required sections:

- Reliability summary
- Flake hotspots
- Quarantine compliance
- Runtime budget status
- Top remediation actions

## Guardrails

- Do not normalize flaky behavior as "acceptable".
- Do not quarantine without owner and expiry.
- Do not claim stable if retry-dependent.

## Reference assets

- Template: `templates/reliability-report-template.md`
- Example: `examples/sample-reliability-report.md`
- Validation script: `scripts/validate-reliability-report.sh`
- Theory/practice reference: `references/flake-root-cause-taxonomy.md`
- Theory/practice reference: `references/quarantine-policy.md`
