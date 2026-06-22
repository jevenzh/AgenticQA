---
name: unit-test-generator
description: Generate high-value unit and integration tests for a function, class, or module. Use when the user asks to "add tests", "increase coverage", or "test this code" at the code level. Detects the repo's framework and edge cases automatically.
---

# Unit Test Generator

Generate meaningful unit/integration tests that protect behavior and survive refactors.

## When to use

The user wants tests for specific code (a function, class, module) — adding coverage, testing edge cases, or backfilling tests for legacy code.

## Procedure

1. **Detect conventions.** Find the test framework, directory layout, and naming pattern already used (look for `package.json` scripts, `pytest.ini`/`pyproject.toml`, `pom.xml`/`build.gradle`, `go.mod`, etc.). Match them exactly. Do not introduce a new framework.
2. **Read the target.** Understand inputs, outputs, side effects, and dependencies of the code under test.
3. **Enumerate cases before coding.** List: happy path, boundary values, empty/null/zero, error and exception paths, and any state/order sensitivity.
4. **Write the tests.** Use existing fixtures/mocks for time, randomness, network, and filesystem. Keep each test focused and descriptively named.
5. **Run and verify.** Execute the suite. Fix test-side issues; surface real product bugs separately with a minimal repro rather than hiding them.
6. **Report.** State what is now covered and what remains untested.

## Quality bar

- Tests are deterministic and independent (no shared mutable state between tests).
- Behavior/contract is tested, not private implementation detail.
- Edge and error paths are present, not just the happy path.
- Test names describe the behavior under test.

## Anti-patterns to avoid

- Asserting on internal calls instead of observable results.
- Snapshot-everything tests that fail on any cosmetic change.
- `sleep`-based synchronization.
- Chasing coverage % with trivial tests that assert nothing meaningful.
