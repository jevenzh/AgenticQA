---
name: test-plan-designer
description: Design risk-based test plans and concrete test cases from requirements, tickets, specs, or diffs. Applies ISTQB CTAL advanced techniques (decision tables, N-switch state transitions, pairwise, classification trees) and exploratory heuristics (SFDIPOT, FEW HICCUPPS). Use before writing tests or when scoping regression.
---

# Test Plan Designer

Turn requirements, tickets, diffs, or exploratory sessions into a risk-prioritized, traceable test plan using professional design techniques.

## When to use

The user wants test strategy, test-case design, regression scoping, exploratory test charters, or a well-formed bug report — typically before test code is written.

## Procedure

### Step 0 — Context probe

Before designing, gather:
1. Source of truth: requirement, ticket, spec, user story, or git diff
2. Existing test coverage for the area (rough count from coverage report or file scan)
3. Risk context: what is the blast radius if this breaks in production?
4. Constraints: test environment, data availability, timeline

### Step 1 — Restate scope

Summarize what is and isn't being tested in one or two sentences. Ambiguity at this step propagates into every case downstream.

### Step 2 — Risk analysis

For each functional area, score: **likelihood** (1–3) × **impact** (1–3) = priority. Apply full technique coverage to high-risk areas; happy-path only to low-risk. Document assumptions and open questions — never hide them.

### Step 3 — Select and apply the right design technique

Choose the technique that fits the structure of the area under test:

| Structure | Technique |
|---|---|
| Single variable with numeric ranges | Equivalence partitioning + 2-value BVA |
| Multiple independent conditions → one outcome | Decision table |
| System with discrete states and transitions | State-transition testing (N-switch or round-trip) |
| Multiple independent variables × each other | Classification tree or pairwise/combinatorial |
| Actor-driven scenario | Use-case / scenario testing |

**Name which technique you applied to each area.**

**Equivalence partitioning + 2-value BVA**: group inputs into valid and invalid partitions; for each boundary, test at the boundary and just outside it. For `age ≥ 18`: test `17` (invalid) and `18` (valid) — not `15` and `25`.

**Decision table testing**: enumerate all condition combinations; apply the don't-care operator to minimize rows; verify the table is complete (every combination covered), consistent (no contradicting outcomes), and correct. Use checksums to detect missing rules.

**State-transition testing**: model the system's states and transitions. Apply:
- *N-switch coverage*: test every sequence of N consecutive transitions (N=0 = state coverage, N=1 = transition coverage, N=2 = pairs of transitions)
- *Round-trip coverage*: include paths that return to their starting state

**Classification tree / pairwise**: when exhaustive combination testing is impractical, classify each input dimension into partitions and use pairwise selection so every pair of parameter values appears at least once. Tools: `allpairspy` (Python), `pict` (CLI), `@fast-check/arbitraries` with pairwise.

### Step 4 — Assign to the right test layer

Map each case to **unit / integration / API / E2E** — no redundant coverage across layers. State why each layer was chosen for each case.

### Step 5 — Write actionable cases

Each case must have:
- **ID**: short, stable identifier
- **Technique**: which design method generated this case
- **Preconditions**: required system state and data
- **Steps**: numbered, specific, executable
- **Expected result**: concrete and verifiable
- **Priority**: derived from the risk score
- **Traces to**: requirement, ticket, or spec section

### Step 6 — Exploratory supplement: FEW HICCUPPS oracles

For areas without a detailed spec, use FEW HICCUPPS to know *when* observed behavior is a defect:

- **F — Familiar**: does it behave consistently with similar features?
- **E — Explainability**: can you explain the result? If not, investigate.
- **W — World**: does it conform to real-world facts (math, physics, common sense)?
- **H — History**: is it consistent with prior versions?
- **I — Image**: does it reflect the organization's quality brand?
- **C — Comparable products**: does it match industry-standard equivalents?
- **C — Claims**: does it match what specs, docs, tooltips, and UI labels promise?
- **U — User expectations**: would a real user find this surprising or confusing?
- **P — Purpose**: does it fulfill the stated goal?
- **P — Product**: is it internally consistent with the rest of the product?
- **S — Standards**: does it comply with WCAG, legal, or platform standards?

### Step 7 — Regression scope (for change-based work)

Given a diff: map changed code → callers/dependents → affected existing test cases → coverage gaps. List what must re-run vs. what can be safely skipped. This is the blast radius analysis.

### Step 8 — Bug report format (for defect-driven work)

- **Summary**: one sentence identifying the behavior and the condition
- **Environment**: OS, browser/runtime, version, account type, test data
- **Steps to reproduce**: numbered, minimal, reproducible
- **Expected**: what should happen (cite the FEW HICCUPPS oracle that tells you this is wrong)
- **Actual**: what happened
- **Severity / priority**: critical / major / minor / cosmetic
- **Evidence**: screenshot, video, log, network trace

## Output format

Produce a markdown test plan with these sections:
1. **Scope** — what is and isn't being tested
2. **Risk Matrix** — area | likelihood | impact | priority
3. **Assumptions & Open Questions**
4. **Test Cases** — table: ID | technique | preconditions | steps | expected | priority | traces-to
5. **Layer Assignment** — unit / integration / API / E2E breakdown
6. **Test Data** — what is needed and how it's sourced
7. **Environments** — what runs where
8. **Regression Scope** — (for change-based work only)
9. **Out of Scope**

## Quality bar

- Cases are risk-prioritized and traceable to requirements.
- Each case is concrete enough to implement without further clarification.
- The design technique is named per area.
- Coverage is assigned to the right layer with no redundant overlap.
- Assumptions and open questions are stated, not hidden.

## Anti-patterns to avoid

- Vague cases ("test the login works").
- Treating all cases as equal priority.
- Duplicating the same check at every test layer.
- Hiding assumptions instead of stating them.
- Writing cases without naming which technique generated them.
