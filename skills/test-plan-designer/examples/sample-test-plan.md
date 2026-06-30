# Test Plan

## Scope
- Feature/change: invoice retry after transient payment failure
- Summary: ensure retries recover safely without double-charging users.

## Risks, Assumptions, Open Questions
- High risk: checkout path, financial side effects.
- Assumption: payment provider returns stable retryable error codes.
- Open question: max retry count user-facing behavior.

## Test Case Design Spec
- Requirements covered: retry policy correctness, idempotent order creation, user-visible recovery flow.
- Design techniques used: boundary value analysis, decision tables, state transition.
- High-risk behaviors: duplicate charge, duplicate order, silent retry failure.

## Test Cases
| ID | Layer | Priority | Technique | Preconditions | Steps | Expected Result | Trace |
|---|---|---|---|---|---|---|---|
| TP-1 | unit | P0 | boundary | retry count at max-1 | trigger retryable failure | exactly one final retry occurs | retry policy |
| TP-2 | API | P0 | decision table | auth token valid | submit payment with retryable gateway error | 202 accepted, idempotency preserved | payment endpoint |
| TP-3 | E2E | P1 | state transition | seeded cart and account | checkout during transient failure | user sees recovery, no duplicate order | checkout flow |

## Automated vs Manual/UAT Coverage Split
| Behavior | Automated Layer | Manual/UAT Needed | Reason |
|---|---|---|---|
| retry policy correctness | unit/API | no | deterministic and fully automatable |
| user-facing recovery clarity | E2E | yes | business confirmation of wording and operator expectations |
| finance reconciliation evidence | API/integration | yes | business sign-off on downstream acceptance evidence |

## Quality Gate Mapping
| Case ID | Gate Stage | Why It Matters |
|---|---|---|
| TP-1 | PR | protects retry logic correctness |
| TP-2 | Pre-release | protects external contract and idempotency |
| TP-3 | Pre-release | protects user-visible recovery behavior |

## Acceptance Metrics
| Metric | Threshold | Risk if Missed |
|---|---|---|
| duplicate charge incidents | 0 | financial/regulatory impact |
| checkout p95 latency under retry | < 1.2s | degraded conversion |

## Test Data and Environments
- staging payment sandbox with deterministic retryable error fixture.

## Regression Scope
- checkout retry logic, order creation idempotency, payment webhook reconciliation.

## UAT Candidate Scenarios
- Business operator confirms checkout recovery language is understandable.
- Finance or ops verifies one order and one charge artifact after retry flow.

## Business Sign-off Evidence
- screenshot of recovery banner
- order id
- payment attempt log reference

## Out of Scope
- non-retryable payment decline messaging variants.
