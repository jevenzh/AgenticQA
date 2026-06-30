# Sample QA Artifact Pack

This example shows how one change should flow through the repository's intermediate QA artifacts.

## Scenario

Feature: order-cancellation flow now supports partial refund approval by finance reviewers.

## Artifact Chain

1. `test-plan-designer`
   - produces the test case design spec
   - identifies risk areas: authorization, state transitions, audit trail, notification side effects
2. `generate-tests`
   - routes deterministic rules to unit/API coverage
   - routes browser journey coverage to E2E
3. `generate-uat-scripts`
   - creates finance-reviewer sign-off scripts for approval wording, evidence capture, and business acceptance
4. `qa-scorecard`
   - summarizes remaining release risk after execution

## Expected Artifact Set

- Test case design spec:
  - trace IDs for partial refund rules
  - automated vs UAT split
  - quality gate mapping
- Automated test outputs:
  - unit tests for refund-state transitions
  - API tests for role and ownership boundaries
  - E2E test for approval journey
- UAT YAML scripts:
  - reviewer happy path
  - unauthorized reviewer rejection path
  - evidence collection for audit sign-off

## Example Trace Flow

| Trace ID | Requirement | Layer | Output Artifact |
|---|---|---|---|
| `REFUND-001` | Finance reviewer can approve eligible partial refund | Unit | refund state-transition tests |
| `REFUND-002` | Non-reviewer cannot approve refund | API | authz regression matrix |
| `REFUND-003` | Reviewer sees approval UI and confirmation | E2E | browser journey test |
| `REFUND-004` | Finance sign-off evidence is recorded | UAT | YAML acceptance script |

## What Good Looks Like

- every high-risk requirement has a traceable artifact
- automated tests cover deterministic behavior at the lowest useful layer
- UAT scripts cover only business judgment and sign-off needs
- release readiness can be explained using evidence, not intuition
