# Mocking Boundaries

Mock only what must be controlled to keep the test deterministic.

## Good Reasons to Mock

- time and clocks
- randomness
- network and external services
- filesystem or process boundaries
- expensive infrastructure dependencies

## Weak Reasons to Mock

- internal collaborators that could be exercised directly
- private call structure or method ordering when output behavior is what matters
- domain objects whose real behavior is cheap and deterministic

## Boundary Rule

Prefer testing real in-process logic and mock only external or nondeterministic edges.

## Theory and Practice Anchors

- Gerard Meszaros, *xUnit Test Patterns*: mock only where test doubles reduce uncontrollable dependencies.
- Fowler on test doubles: use stubs/mocks deliberately, not as default structure.
- London vs classic school debates both agree that over-mocking can couple tests to implementation.
