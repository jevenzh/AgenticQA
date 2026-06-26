---
name: api-test-generator
description: Generate REST/GraphQL API tests covering contract, auth, negative, schema evolution, and OWASP security cases. Supports consumer-driven contract testing with Pact. Use when testing endpoints, validating schemas, checking service contracts, or hardening auth/authorization.
---

# API Test Generator

Generate API tests that verify a service honors its contract, fails safely, and resists common security attacks.

## When to use

The user wants HTTP/REST or GraphQL endpoint coverage: contract validation, integration tests, auth/authorization checks, negative cases, schema evolution safety, or consumer-driven contracts.

## Procedure

### Step 0 — Context probe

Before writing anything:
1. Locate the API surface: OpenAPI/Swagger file, GraphQL schema, or route/handler code if no spec exists.
2. Identify the test client already in the repo (supertest, pytest+httpx/requests, RestAssured, Playwright APIRequestContext, k6). Don't add a new one.
3. Check if Pact or another contract testing tool is present (`pact-foundation`, `@pact-foundation/pact`, `pactflow`, etc.).
4. Identify the auth mechanism (JWT, OAuth2, API keys, cookies) and how test credentials are obtained.
5. Note how test data is seeded and cleaned up (transaction rollback, truncate, teardown hooks).

### Step 1 — Inventory the surface

For each endpoint/operation in scope, list the cases:
- **Positive**: valid payload → expected status and response shape
- **Validation errors**: missing required fields, wrong types, over-length strings, malformed content-type → 400/422
- **Auth**: missing token → 401, expired token → 401, valid token wrong scope → 403
- **Authorization (IDOR/BOLA)**: can user A read or modify user B's resource? — the most commonly skipped case
- **Edge inputs**: empty body, null fields, max-length strings, Unicode, duplicate submissions

### Step 2 — Write the tests

Validate full response shape against the schema (status, headers, body structure), not just one field. Seed and clean up test data hermetically — no hardcoded IDs that break across environments.

### Step 3 — Advanced tier

**OWASP API Top 10 cases** — add these when the endpoint handles sensitive data:
- **Injection**: SQL/NoSQL/command injection via string fields
- **Broken Object Level Authorization (BOLA/IDOR)**: access another user's object with a valid token
- **Mass assignment**: send extra fields the server should not accept; confirm they are ignored
- **Sensitive data exposure**: confirm tokens, passwords, and PII are not returned in responses
- **Rate limiting**: rapid repeated requests should eventually be throttled (429)

**Consumer-driven contract testing with Pact** — when multiple services consume this API:
1. Consumer side: write a Pact test against a mock server; define request expectations with flexible matchers (`like()`, `eachLike()`, `regex()`) for dynamic fields — not exact values
2. Generate the pact file and publish to a Pact Broker
3. Provider side: run Pact verifier against the real running service; implement provider state handlers for each required precondition
4. Add `can-i-deploy` check to CI before releasing the provider

**Schema evolution safety**: for any field being deprecated or renamed, add a test confirming the old field still exists (backward compatibility), or explicitly test the versioning strategy.

### Step 4 — Run and verify

Execute against the configured test environment. On failure, capture the full request and response including headers. Clearly mark tests that require a live environment.

### Step 5 — Report

List: endpoints covered, authorization gaps found, OWASP cases addressed, contract violations, and any undocumented behavior discovered with the request/response evidence.

## Quality bar

- Positive, negative, and authorization cases exist per endpoint.
- Responses validated against the contract/schema, not just one field.
- Tests are repeatable; live-environment tests are clearly labeled.
- At least one IDOR check exists for every endpoint that returns user-scoped data.
- Pact matchers use `like()`/`eachLike()` for dynamic fields, not exact values.

## Anti-patterns to avoid

- Testing only 2xx responses.
- Asserting on a single field while ignoring response shape.
- Hardcoding tokens or IDs that break across environments.
- Skipping authorization checks entirely.
- Exact-value matching in Pact for timestamps, UUIDs, or generated IDs.
