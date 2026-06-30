# E2E Journey Plan

## Journey
- Flow: checkout retry recovery
- Framework: Playwright
- Priority: P0

## Milestones
| Step | User Goal | Assertion | Locator Strategy |
|---|---|---|---|
| 1 | open checkout | checkout form visible | role + heading |
| 2 | submit order during transient failure | retry banner shown | test id |
| 3 | recover and confirm order | confirmation number visible | role + text |

## Setup and Data
- Auth setup: API-issued session cookie fixture.
- Seed data: cart with retryable payment scenario.
- Environment prerequisites: payment sandbox + seeded retry response.

## Risks
- Flake risks: shared cart state if fixtures are reused.
- Runtime risks: retry scenario adds 20s if sandbox is slow.
- Remaining gaps: mobile layout behavior not covered.
