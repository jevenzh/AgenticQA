# Security Test Report

## Scope
- Change/API surface: account settings endpoints
- Roles/tenants: user/admin, tenant A/B

## Threat Surface
- Profile update, role assignment, API token rotation

## Security Test Matrix
| Area | Test Case | Expected | Result | Evidence |
|---|---|---|---|---|
| Authorization | user A requests user B profile | 403 | failed | req/resp logs attached |

## Findings
| ID | Severity | Description | Repro Steps | Evidence | Blocker |
|---|---|---|---|---|---|
| SEC-12 | high | cross-tenant profile read allowed | login as A, call B endpoint | 200 with B payload | yes |

## Remediation
| Finding ID | Action | Owner | Due |
|---|---|---|---|
| SEC-12 | enforce tenant filter in profile query | backend owner | 2026-07-01 |
