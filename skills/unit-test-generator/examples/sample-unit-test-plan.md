# Unit Test Plan

## Target
- File/module/symbol: `src/retryPolicy.ts::nextDelay`
- Framework: Vitest
- Existing test location: `src/__tests__/retryPolicy.test.ts`

## Case Inventory
| Case ID | Type | Priority | Scenario | Expected Outcome |
|---|---|---|---|---|
| UT-1 | happy | P0 | retry count 1 | base delay returned |
| UT-2 | boundary | P0 | retry count at max | capped delay returned |
| UT-3 | error | P1 | negative retry count | throws validation error |

## Test Boundaries
- Unit coverage: delay calculation, max-cap enforcement.
- Integration coverage: provider-specific retry config loading.

## Risks and Gaps
- concurrency behavior still needs integration coverage.
