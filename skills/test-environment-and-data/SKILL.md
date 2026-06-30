---
name: test-environment-and-data
description: Validate test environment and seeded data readiness so API/integration/E2E tests are repeatable, isolated, and parallel-safe.
when_to_use: Use before running integration/API/E2E suites, after flaky-state failures, or during CI stabilization. Triggers include "test data setup", "environment readiness", "state leakage", "parallel-safe", "seed/reset".
argument-hint: [suite|environment]
---

# Test Environment and Data

Use this skill to prevent environment and data drift from invalidating test signals.

## Inputs

- Scope: `$ARGUMENTS`
- Target environment(s)
- Data fixtures/seeding approach

## Procedure

1. Define environment prerequisites by tier (local/CI/staging) using `references/environment-tier-checklist.md`.
2. Document seed-data contract using `references/test-data-contract-rules.md`:
   - owner
   - schema version
   - setup/reset steps
3. Verify suite setup/teardown behavior.
4. Identify isolation risks:
   - shared mutable data
   - order dependence
   - cross-test contamination
5. Confirm parallel safety.
6. Produce readiness status and mandatory fixes.
7. If authoring a local markdown artifact, optionally run `scripts/validate-env-data-readiness.sh <file>` before presenting it.

## Output contract

Use `templates/env-data-readiness-template.md`.

Required sections:

- Environment prerequisites
- Seed/reset contract
- Setup/teardown checklist
- Isolation risks
- Mandatory fixes before reliable runs

## Guardrails

- Do not assume shared state is acceptable.
- Do not mark ready if seed/reset path is undefined.
- Do not claim parallel-safe without explicit verification.

## Reference assets

- Template: `templates/env-data-readiness-template.md`
- Example: `examples/sample-env-data-readiness.md`
- Validation script: `scripts/validate-env-data-readiness.sh`
- Theory/practice reference: `references/environment-tier-checklist.md`
- Theory/practice reference: `references/test-data-contract-rules.md`
