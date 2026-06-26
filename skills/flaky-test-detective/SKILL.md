---
name: flaky-test-detective
description: Diagnose and fix non-deterministic (flaky) tests by classifying root cause and applying targeted fixes. Use when a test fails intermittently, passes locally but fails in CI, or fails only in parallel runs or a specific order.
---

# Flaky Test Detective

Find why a test is non-deterministic and fix the root cause — not the symptom.

## When to use

A test fails intermittently without code changes. It passes locally but fails in CI. It fails only when run in parallel or in a particular order. It's currently suppressed with a skip or retry because "it's flaky."

## Procedure

### Step 0 — Gather evidence

Before diagnosing, collect signal:
1. Run the test in isolation repeatedly: `pytest path/to/test.py::test_name --count=20`, `jest --testPathPattern=... --passWithNoTests`, `go test -run TestName -count=20`
2. Run the full suite with parallelism enabled
3. Run with randomized order if supported (`pytest-randomly`, `--randomize`, `--shuffle`)
4. Check CI logs for the last N failures — note the error message, stack trace, timestamp, and whether it correlates with other tests running concurrently

### Step 1 — Classify the root cause

Match the symptoms to a root cause category:

| Root cause | Key symptoms | Targeted fix |
|---|---|---|
| **Async race / timing** | Fails more under load or in CI; passes when you add a sleep; error is "element not found" or timeout | Replace fixed sleeps with condition-based waits; use web-first assertions (E2E); properly `await` async operations |
| **Shared mutable state** | Passes in isolation; fails in a specific order; error changes with test sequence | Move setup into `beforeEach`; clean up in `afterEach`; use transaction rollbacks; remove global singletons from test scope |
| **Time/date dependency** | Fails near midnight, month boundaries, or DST transitions; fails on machines with a different timezone | Freeze time: `freezegun` (Python), `jest.useFakeTimers()` (JS), `time.Now()` injection (Go); never use real wall-clock time in unit tests |
| **Network / external service** | Intermittent connection errors or unexpected responses; slow CI network causes timeouts | Mock or stub the external dependency; use recorded fixtures (VCR cassettes, MSW handlers, nock); retry only as a last resort with a documented reason |
| **Environment / CI difference** | Passes locally always, fails in CI always or mostly | Check env vars, file paths, locale, case-sensitivity (macOS vs Linux), available memory and CPU; reproduce locally with Docker |
| **Port / resource conflict** | Error is "address already in use" or file locked; fails only in parallel | Use random ports; use temp directories per test; scope resource acquisition to `beforeEach`/`afterEach` |
| **Test order dependency** | Fails only after specific other tests; root test manipulates shared DB/file/singleton | Identify which upstream test leaves dirty state; add teardown to that test; make the failing test own its preconditions |

### Step 2 — Apply the targeted fix

Fix the root cause, not the symptom:

**Do not** add `sleep(500)` to make it "more reliable" — that is a symptom suppressor, not a fix.  
**Do not** add retry logic inside a test — it hides real failures and inflates run time.  
**Do not** mark as `@skip` or `xit` without filing a tracked issue with reproduction steps.

**Async race**: replace `sleep` with an explicit wait condition:
```python
# Bad
time.sleep(1)
assert page.is_visible('#result')

# Good (Playwright)
page.wait_for_selector('#result', state='visible')
expect(page.locator('#result')).to_be_visible()
```

**Shared state**: scope setup and teardown correctly:
```js
// Bad — beforeAll mutates shared state
beforeAll(async () => { testUser = await createUser(); });

// Good — each test owns its data
beforeEach(async () => { testUser = await userFactory.create(); });
afterEach(async () => { await testUser.destroy(); });
```

**Time dependency**: inject a clock:
```python
# Python — freeze time
from freezegun import freeze_time

@freeze_time('2025-01-15 12:00:00')
def test_expires_after_24_hours():
    ...
```

### Step 3 — Verify the fix

The test must pass:
1. In isolation × 20 repetitions: `--count=20`, `--repeat=20`, `-v -count=20`
2. In the full suite with parallelism enabled
3. In CI (push a branch; check the pipeline)

All three must be green before declaring the flake resolved.

### Step 4 — Harden and document

After fixing:
- Add a brief comment explaining what caused the flake and what the fix is — it will rot if not documented
- Check neighboring tests for the same root-cause pattern (flakes cluster)
- If the flake was due to a missing abstraction (e.g., no time injection), consider fixing the pattern across the suite

### Step 5 — Report

State: root cause category, fix applied, verification results (N/20 local passes, CI green), and any neighboring tests identified with the same risk pattern.

## Quality bar

- Test passes ≥ 20 consecutive runs in isolation.
- Test passes in the full parallel suite.
- Fix addresses root cause, not timing.
- No `sleep`, retry loops, or skips introduced by the fix.

## Anti-patterns to avoid

- Adding sleeps or delays as the "fix."
- Wrapping the test body in a retry loop.
- Skipping the test and logging a ticket that never gets prioritized.
- Fixing the assertion (making it less strict) instead of fixing the cause (why the state is wrong).
- Declaring the flake fixed after only a single local pass.
