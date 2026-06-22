---
name: api-test-generator
description: Generate REST/GraphQL API tests from a spec, schema, or route handlers — covering contract, auth, pagination, and negative cases. Use when the user wants to test endpoints, validate a schema, or check service contracts.
---

# API Test Generator

Generate API tests that verify a service honors its contract and fails safely.

## When to use

The user wants to test HTTP/REST or GraphQL endpoints: contract validation, integration tests, auth/authorization checks, or negative-case coverage.

## Procedure

1. **Find the contract.** Prefer an OpenAPI/Swagger file or GraphQL schema. If none exists, derive the surface from route/controller/handler code.
2. **Inventory operations.** List endpoints/operations in scope and, for each, the cases: success, validation errors, auth (missing/invalid token), authorization boundaries, and edge inputs (empty, oversized, wrong content-type).
3. **Pick tooling already in the repo.** e.g. supertest, pytest + httpx/requests, RestAssured, Playwright `APIRequestContext`, or k6 for load. Don't add a new client if one exists.
4. **Write the tests.** Validate the full response against the schema (status, headers, body shape), not just one field. Seed and clean up test data hermetically where possible.
5. **Run and verify.** Execute against the configured test environment; on failure capture the full request and response.
6. **Report.** List contract violations, undocumented behavior, and authorization gaps with concrete evidence.

## Quality bar

- Positive, negative, and authorization cases exist per endpoint.
- Responses validated against the contract/schema.
- Tests are repeatable; live-environment dependencies are clearly marked.

## Anti-patterns to avoid

- Testing only 2xx responses.
- Asserting a single field while ignoring schema/shape.
- Hardcoding tokens/IDs that break across environments.
- Skipping authorization ("can A access B's resource?") checks.
