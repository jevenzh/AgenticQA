---
name: mutation-test-auditor
description: Run mutation testing against target files, classify surviving mutants by type, apply risk-based thresholds, and write targeted tests to improve test quality. Use after achieving basic coverage to validate that tests actually catch bugs. Supports Stryker (JS/TS), PIT (Java), mutmut/cosmic-ray (Python), go-mutesting (Go).
---

# Mutation Test Auditor

Measure whether your tests can actually catch bugs — not just whether they execute over the code.

## When to use

Line/branch coverage looks solid but you're not confident the tests would catch real regressions. You want to validate test quality, not just quantity. You're adding tests to a high-risk module and need confidence they are effective.

## Procedure

### Step 0 — Context probe

1. Detect the mutation testing tool:
   - JS/TS: `.stryker.config.js` / `stryker.config.json` / `stryker.config.mjs`
   - Java: `pom.xml` with `pitest-maven-plugin` or `build.gradle` with PIT
   - Python: `mutmut.toml` / `setup.cfg [mutmut]` section, or `cosmic-ray` config
   - Go: `go-mutesting` binary, `gremlins` config
2. If no tool is configured, select and scaffold one for the project's language.
3. Identify the target: scope mutation to the file(s) under review, not the whole codebase — full-codebase runs timeout.
4. Read the current mutation score if a prior report exists (`stryker-report.json`, `pitest/index.html`, `.mutmut-cache`).

### Step 1 — Configure and run

Scope mutation to only the relevant source file(s) and their corresponding tests:
- **Stryker**: set `mutate` array to the target files
- **PIT**: set `targetClasses` / `targetTests` filters
- **mutmut**: `mutmut run src/mymodule.py --paths-to-mutate src/mymodule.py`

Run and capture the report (HTML or JSON). Note the mutation score: `killed / (killed + survived + timeout)`.

### Step 2 — Classify surviving mutants

Surviving mutants are mutations the tests did not detect. Group by type to diagnose the weakness:

| Mutant type | What it exposes | Fix strategy |
|---|---|---|
| Arithmetic operator (`+→-`, `*→/`) | Tests don't verify computed values | Add assertions on the numeric result, not just "not null" |
| Relational operator (`>→>=`, `==→!=`) | Boundaries not tested | Add 2-value BVA cases at each boundary |
| Logical operator (`&&→\|\|`, `!→∅`) | Condition combinations not covered | Add decision table cases for each condition combination |
| Return value (`return x → return null/0/""`) | Callers don't verify the return | Assert the specific returned value |
| Void method call removed | Side effects not observed | Assert the observable side effect (state change, event, file write, DB row) |
| Constant (`0→1`, `"" → "mutant"`) | Literal values not asserted | Assert expected constants explicitly |
| Conditionals boundary (`if x > 0` → `if x >= 0`) | Off-by-one not caught | Add boundary value test at the exact edge |

### Step 3 — Apply risk-based thresholds

Not every surviving mutant needs to be killed. Set thresholds by module risk:

| Risk level | Examples | Target mutation score |
|---|---|---|
| Critical | Auth, payment, data integrity, encryption | ≥ 90% |
| Core business logic | Domain rules, pricing, permissions | ≥ 80% |
| Supporting code | Utilities, formatters, adapters | ≥ 65% |
| Trivial | Logging, string formatting, config readers | Accept as-is |

Accept (document explicitly, don't silently ignore) surviving mutants in trivial or unreachable code. Never accept survivors in security, payment, or data-integrity paths.

### Step 4 — Kill high-priority survivors

For each unaccepted surviving mutant, write the minimal test case that kills it. Prefer strengthening an existing assertion over adding a new test. After writing, re-run mutation to confirm the score improved.

### Step 5 — Report

State:
- Mutation score before and after
- Surviving mutant count by type
- Which were killed (and by which new/strengthened test)
- Which were accepted and why (documented per mutant)
- Risk-adjusted assessment: does the module meet its threshold?

## Quality bar

- Mutation score meets the risk-based threshold for the module.
- All accepted survivors have a documented rationale.
- No surviving mutants in auth, payment, or data-integrity paths.
- Mutation was run against a scoped target, not the whole codebase.

## Anti-patterns to avoid

- Running mutation against the whole codebase — it will time out.
- Killing mutants by weakening assertions (making the test accept the mutation instead of detecting it).
- Accepting survivors in high-risk paths without documentation.
- Treating 100% mutation score as the goal — it's a proxy for confidence, not a guarantee of correctness.
- Ignoring timeout mutants — they often indicate infinite loops or blocking code paths worth investigating.
