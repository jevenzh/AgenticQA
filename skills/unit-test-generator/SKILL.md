---
name: unit-test-generator
description: Generate high-value unit and integration tests for a function, class, or module. Covers happy paths, edge cases, mutation testing, and property-based testing. Use when adding coverage, testing edge cases, or validating test quality with mutation analysis.
---

# Unit Test Generator

Generate meaningful unit/integration tests that protect behavior, survive refactors, and pass mutation testing.

## When to use

The user wants tests for specific code (a function, class, module) — adding coverage, testing edge cases, backfilling legacy code, or validating that existing tests actually catch bugs.

## Procedure

### Step 0 — Context probe

Before writing anything:
1. Find the test framework, directory layout, and naming conventions (`package.json` scripts, `pytest.ini`/`pyproject.toml`, `pom.xml`/`build.gradle`, `go.mod`, etc.). Match them exactly.
2. Check for a coverage report (`.coverage`, `lcov.info`, `coverage-summary.json`) — identify uncovered lines in the target file.
3. Check for a mutation testing config (`.stryker.config.js`, `pitest-maven-plugin`, `mutmut.toml`) — if present, note the current mutation score.
4. Read the target code: inputs, outputs, side effects, dependencies, and error paths.

### Step 1 — Enumerate cases before coding

List cases using a structured technique:
- **Equivalence partitioning**: group inputs by expected behavior; test one representative from each valid and invalid partition
- **Boundary value analysis (2-value)**: test at and just outside each boundary — for `n > 0`, test `0` (invalid boundary) and `1` (valid boundary), not just a midpoint
- **State sensitivity**: if the unit has state, list the state transitions and test each valid/invalid transition
- **Error paths**: what exceptions or error codes are possible, and under what inputs?

State your case list explicitly before writing any code.

### Step 2 — Write tests

Use the repo's existing fixtures/mocks for time, randomness, network, and filesystem. Keep each test focused on one behavior, named as a sentence: `"returns empty list when input is null"`, not `"testNull"`.

### Step 3 — Advanced tier (apply when basic coverage is solid)

**Mutation testing**: if a mutation tool is configured, run it against the target file only — not the whole codebase. Identify surviving mutants — these are mutations the tests failed to detect. Strengthen assertions or add missing cases to kill the survivors. Tools: Stryker (JS/TS), PIT (Java), mutmut/cosmic-ray (Python), go-mutesting (Go).

**Property-based testing**: for pure functions with complex input spaces (parsing, math, serialization, sorting), write property tests that generate many random inputs and assert an invariant that must always hold (e.g. `encode(decode(x)) == x`, `sort(sort(x)) == sort(x)`). Tools: Hypothesis (Python), fast-check (JS/TS), jqwik (Java), gopter (Go).

### Step 4 — Run and verify

Execute the suite. Fix test-side issues; surface genuine product bugs with a minimal reproduction rather than silently patching them.

### Step 5 — Report

State: lines/branches now covered, cases written, mutation score change (if applicable), and what remains untested with a priority note.

## Quality bar

- Tests are deterministic and independent (no shared mutable state between tests).
- Behavior and public contract are tested, not private implementation details.
- Edge and error paths are covered, not just the happy path.
- Test names describe the behavior under test as a sentence.
- Surviving mutants in critical code paths are addressed or explicitly accepted with a documented reason.

## Anti-patterns to avoid

- Asserting on internal calls instead of observable outputs.
- Snapshot-everything tests that fail on cosmetic changes.
- `sleep`-based synchronization.
- Coverage % chasing with tests that assert nothing meaningful.
- Property tests that only exercise one hard-coded example — use the generator.
