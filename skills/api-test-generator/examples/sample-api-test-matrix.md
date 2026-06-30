# API Test Matrix

## Scope
- Endpoint/spec/schema: `POST /v1/payments/retry`
- Contract source: `openapi/payments.yaml`
- Framework/client: pytest + httpx

## Operation Matrix
| Operation | Case Type | Priority | Preconditions | Expected Result |
|---|---|---|---|---|
| POST /v1/payments/retry | success | P0 | valid auth + retryable payment | 202 with retry job id |
| POST /v1/payments/retry | auth failure | P0 | missing token | 401 error envelope |
| POST /v1/payments/retry | authz boundary | P0 | tenant A requests tenant B payment | 403 |
| POST /v1/payments/retry | validation | P1 | malformed body | 400 with field errors |

## Data and Environment Assumptions
- seeded retryable payment fixture exists in staging sandbox.

## Remaining Risks
- downstream webhook reconciliation still needs integration coverage.
