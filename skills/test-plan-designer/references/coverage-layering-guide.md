# Coverage Layering Guide

Assign each behavior to the cheapest layer that can reliably detect the risk.

## Layer Selection Heuristic

- `Unit`: pure logic, calculations, validation rules, edge conditions
- `Integration`: component contracts, persistence, message flow, framework wiring
- `API`: service contract, authn/authz, error envelope, schema behavior
- `E2E`: critical user journeys and browser-visible integration paths
- `Manual/UAT`: business judgment, usability, sign-off, regulated evidence capture

## Anti-Duplication Rule

Do not prove the same behavior end-to-end if it is already sufficiently protected at a lower layer unless:
- the integration path itself is risky
- the user-visible journey is critical
- the release needs explicit sign-off evidence

## Theory and Practice Anchors

- Mike Cohn's test pyramid and Martin Fowler's practical test pyramid: prefer many fast lower-level tests with selective higher-level tests.
- Google testing guidance on test size and flakiness reduction: keep broad UI coverage intentionally small and stable.
- ISTQB layered test strategy concepts: align coverage depth with risk and purpose rather than habit.
