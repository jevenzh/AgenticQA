---
name: api-test-generator
description: Generate REST or GraphQL API tests from specs, schemas, or route handlers with contract, authorization, and negative-case coverage. Use when validating endpoints, checking service contracts, or hardening API behavior.
when_to_use: Use when the user asks to test endpoints, validate OpenAPI or GraphQL behavior, check auth/authz rules, or add API regression coverage. Triggers include "API tests", "contract tests", "test this endpoint", "authorization coverage", and "schema validation".
argument-hint: [endpoint|spec|schema|route]
---

# API Test Generator

Use this skill to verify that an API honors its contract and fails safely.

## Inputs

- Scope: `$ARGUMENTS`
- OpenAPI/Swagger, GraphQL schema, or route/controller definitions
- Existing API test tooling and environment constraints
- Upstream test case design spec when available

## Procedure

1. Find the contract source; derive from code only if no formal contract exists.
2. Inventory the operations in scope.
3. If a test case design spec exists, start from the API-assigned cases and preserve their trace IDs.
4. Use `references/api-negative-case-catalog.md` and `references/authn-authz-matrix.md` to build a case matrix per operation:
   - success
   - validation failure
   - authentication failure
   - authorization boundary
   - edge input and content-type mismatch
   - pagination/filtering/sorting where relevant
5. Separate automatable contract/security checks from business-facing UAT scripts; do not duplicate acceptance scripts as API tests unless the behavior is properly machine-verifiable.
6. Reuse the repo's existing HTTP client and fixtures.
7. Validate full response contract using `references/contract-assertion-depth.md`: status, headers, body shape, and error envelope.
8. Ensure test data is seeded/reset deterministically.
9. If authoring a local markdown artifact, optionally run `scripts/validate-api-test-matrix.sh <file>` before presenting it.
10. Run the suite, capture request/response on failure, and report contract or security gaps.

## Output contract

Use `templates/api-test-matrix-template.md`.

Required sections:

- Contract source
- Operation matrix
- Trace IDs from the source test case design spec when present
- Data/env assumptions
- Coverage completed
- Remaining risks and undocumented behavior

## Guardrails

- Do not test only 2xx paths.
- Do not skip authz boundary checks.
- Do not assert a single field while ignoring the schema.
- Do not hardcode tokens, IDs, or environment-fragile fixtures.

## Reference assets

- Template: `templates/api-test-matrix-template.md`
- Example: `examples/sample-api-test-matrix.md`
- Validation script: `scripts/validate-api-test-matrix.sh`
- Theory/practice reference: `references/api-negative-case-catalog.md`
- Theory/practice reference: `references/authn-authz-matrix.md`
- Theory/practice reference: `references/contract-assertion-depth.md`
