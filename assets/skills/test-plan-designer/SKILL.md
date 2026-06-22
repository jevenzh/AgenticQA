---
name: test-plan-designer
description: Design a risk-based test plan and concrete test cases from a requirement, ticket, spec, or diff, and write clear bug reports. Use before writing tests or when scoping regression for a change.
---

# Test Plan Designer

Turn requirements, tickets, or diffs into a prioritized, traceable test plan.

## When to use

The user wants test strategy, test-case design, regression scoping, or a well-formed bug report — typically before test code is written.

## Procedure

1. **Restate scope.** Read the requirement/ticket/spec/diff and summarize what is being tested in one or two sentences.
2. **Surface risk and ambiguity.** List risks (likelihood × impact), assumptions, and open questions.
3. **Design cases with technique.** Apply equivalence partitioning, boundary value analysis, decision tables, and state-transition analysis; note which you used.
4. **Assign the layer.** Map each case to unit / integration / API / E2E, avoiding duplicate coverage across layers.
5. **Write actionable cases.** Each case: ID, preconditions, steps, expected result, priority, and the requirement it traces to.
6. **For defects, write a bug report:** summary, environment, steps to reproduce, expected vs actual, severity/priority, evidence.

## Output format

Produce a markdown test plan with: Scope, Assumptions & Open Questions, Test Cases (table by type), Test Data, Environments, Out of Scope. For change-based work, add a Regression Scope section tied to the diff's blast radius.

## Quality bar

- Cases are risk-prioritized and traceable to requirements.
- Each case is concrete enough to implement without clarification.
- Coverage is assigned to the right layer with no redundant overlap.

## Anti-patterns to avoid

- Vague cases ("test the login works").
- Treating all cases as equal priority.
- Duplicating the same check at every layer.
- Hiding assumptions instead of stating them.
