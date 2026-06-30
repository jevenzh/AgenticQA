# Unit Test Heuristics

Use unit tests to protect behavior at the cheapest reliable layer.

## What a Strong Unit Test Covers

A strong case usually targets one of these:
- deterministic happy-path behavior
- boundary or partition edge behavior
- invalid inputs and error handling
- state transitions or order-sensitive logic
- interaction with a dependency only when the interaction is externally meaningful

## Minimal Case Selection

Start with:
- one core success case
- one high-risk boundary or partition case
- one failure or error-path case

Add more only when a distinct risk remains uncovered.

## Anti-Bloat Rule

Do not add tests that only restate implementation steps. Prefer a smaller set of high-signal tests over exhaustive but redundant permutations.

## Theory and Practice Anchors

- Kent Beck, *Test-Driven Development: By Example*: unit tests should drive small, behavior-focused design.
- xUnit test patterns and Meszaros' test-smell concepts: keep tests readable, isolated, and intention-revealing.
- Fowler and Cohn test-pyramid guidance: favor broad lower-level automated coverage for speed and feedback.
