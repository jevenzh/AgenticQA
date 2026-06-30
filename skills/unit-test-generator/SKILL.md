---
name: unit-test-generator
description: Generate high-value unit and integration tests for functions, classes, or modules using the repo's existing framework and conventions. Use when adding code-level coverage, backfilling legacy tests, or closing behavior gaps in changed code.
when_to_use: Use when the user asks to add tests, increase coverage, test a function/module, or protect edge cases in changed code. Triggers include "add unit tests", "backfill tests", "increase coverage", "test this module", and "cover edge cases".
argument-hint: [file|symbol|module]
---

# Unit Test Generator

Use this skill to add deterministic code-level tests that protect behavior instead of implementation detail.

## Inputs

- Target scope: `$ARGUMENTS`
- Existing test framework and repo conventions
- Changed behavior, bug report, or untested path
- Upstream test case design spec when available

## Procedure

1. Detect the current framework, naming pattern, and test location.
2. Read the target code and identify observable behavior, inputs, outputs, and side effects.
3. If a test case design spec exists, start from it and select the cases assigned to unit or integration layers.
4. Use `references/unit-test-heuristics.md` to enumerate the smallest meaningful case set:
   - happy path
   - boundaries
   - empty/null/zero
   - error and exception paths
   - state/order sensitivity
5. Decide where unit coverage ends and integration coverage begins.
6. Keep business-facing UAT or manual acceptance scenarios out of unit tests unless they reduce to deterministic code behavior.
7. Use `references/mocking-boundaries.md` and `references/determinism-checklist.md` to control mocks, fixtures, time, randomness, I/O, network, and filesystem.
8. Run the relevant suite and keep iterating until the result is deterministic.
9. If authoring a local markdown artifact, optionally run `scripts/validate-unit-test-plan.sh <file>` before presenting it.
10. Report what is now covered, what remains untested, and any product bug found.

## Output contract

Use `templates/unit-test-plan-template.md` before or alongside generation.

Required output elements:

- framework/convention summary
- case inventory
- trace back to the source test case design spec when present
- implemented coverage
- remaining risks/gaps

## Guardrails

- Do not introduce a new framework when one already exists.
- Do not assert internal call structure when observable outcomes suffice.
- Do not add trivial tests that only inflate coverage numbers.
- Do not leave timing, randomness, or shared state uncontrolled.

## Reference assets

- Template: `templates/unit-test-plan-template.md`
- Example: `examples/sample-unit-test-plan.md`
- Validation script: `scripts/validate-unit-test-plan.sh`
- Theory/practice reference: `references/unit-test-heuristics.md`
- Theory/practice reference: `references/mocking-boundaries.md`
- Theory/practice reference: `references/determinism-checklist.md`
