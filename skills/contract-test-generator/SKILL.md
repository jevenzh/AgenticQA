---
name: contract-test-generator
description: Generate consumer-driven contract tests using Pact for REST or message-based APIs. Covers consumer test authoring, pact file generation, provider verification, and CI gate with can-i-deploy. Use when multiple services or teams consume an API and you need to catch breaking changes without full integration environments.
---

# Contract Test Generator

Catch API breaking changes before they reach production — without shared integration environments or end-to-end test suites.

## When to use

Multiple services or teams consume an API. You need confidence that a provider change won't silently break consumers, or that a consumer's assumptions are actually met by the provider — verified on every commit.

## Procedure

### Step 0 — Context probe

1. Identify consumer(s) and provider(s) in scope and the protocol (REST/HTTP, GraphQL, message queue).
2. Check for existing Pact setup: `pact-foundation` libraries, pact files in a `pacts/` or `contracts/` directory, a `PACT_BROKER_URL` or `PACT_BROKER_BASE_URL` in env/CI config.
3. Identify the HTTP client the consumer uses (fetch, axios, supertest, httpx, RestTemplate, etc.).
4. Identify the auth mechanism and how test credentials are obtained without hitting a real auth service.

### Step 1 — Consumer side: define expectations

In the consumer's test suite, for each interaction the consumer initiates:

1. Import the Pact mock provider for the consumer's language (`@pact-foundation/pact` for JS/TS, `pact-python`, `pact-jvm`, etc.).
2. Define the interaction:
   - **Request**: method, path, query params, headers, request body
   - **Response**: status code, response headers, response body
3. Use flexible matchers for dynamic fields — never exact values for things that change:
   - `like(value)` — match the type and structure, not the exact value
   - `eachLike(item)` — match an array where each element matches the item shape
   - `regex(pattern, example)` — match a string pattern (e.g. UUIDs, ISO dates)
4. Run the consumer code against the Pact mock server — this generates the pact file in `pacts/`.

### Step 2 — Publish the contract

If a **Pact Broker** is configured:
```bash
pact-broker publish ./pacts \
  --consumer-app-version <git-sha-or-semver> \
  --broker-base-url $PACT_BROKER_BASE_URL \
  --tag <branch-name>
```

If no broker: share the pact file directly with the provider (file-based) and commit it to the provider's repo.

### Step 3 — Provider side: verify

In the provider's test suite:
1. Import the Pact verifier for the provider's language.
2. Point it at the pact file or Pact Broker URL.
3. Start the real provider application (not a mock).
4. Implement **provider state handlers** — for each `given("...")` clause in a pact, set up the required data before Pact sends the request:
   ```js
   stateHandlers: {
     'a user with ID 123 exists': async () => { await db.users.create({ id: '123', ... }); },
   }
   ```
5. Run verification: Pact replays each recorded request against the real provider and compares the response against the consumer's expectation.

### Step 4 — CI integration

- **Consumer CI**: run Pact consumer tests and publish pact files on every commit or PR
- **Provider CI**: run provider verification against all published pacts on every commit
- **Release gate**: add `can-i-deploy` before releasing the provider to each environment:
  ```bash
  pact-broker can-i-deploy \
    --pacticipant <provider-name> \
    --version <version> \
    --to-environment production
  ```
  Block the release pipeline if this returns non-zero.

### Step 5 — Schema evolution safety

For any field being deprecated or renamed in the provider:
1. Keep existing consumer pact tests running until all consumers have migrated.
2. Add new consumer pact tests for the new field shape before removing the old field.
3. Only remove the old contract interaction after all consumers have published updated pacts that no longer depend on it.

### Step 6 — Report

State: interactions covered per consumer-provider pair, provider states implemented, pact broker publication status, `can-i-deploy` result, and any verification failures with the mismatched request/response detail.

## Quality bar

- Consumer tests use matchers (`like`, `eachLike`, `regex`) for all dynamic fields (IDs, timestamps, generated values).
- Provider state handlers exist for every `given()` clause in the pact.
- `can-i-deploy` runs in CI before provider releases.
- Pact files are version-tagged and either committed or published to a broker.

## Anti-patterns to avoid

- Exact-value matching for timestamps, UUIDs, or generated IDs — breaks on every run.
- Testing the Pact mock on the provider side — the provider must verify against a real running service.
- Missing provider state setup — verification will fail for the wrong reasons.
- Publishing pacts without version tags — makes `can-i-deploy` unreliable.
- Skipping `can-i-deploy` because "we'll know if it breaks" — the whole point is to know before it does.
