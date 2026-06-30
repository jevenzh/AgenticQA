# Flake Root Cause Taxonomy

Classify flaky behavior by cause before choosing a fix.

## Common Classes

- timing and synchronization
- shared or leaked test data
- environment dependency
- order dependence
- nondeterministic clocks, randomness, or background work

## Fix Rule

Do not treat retries as the primary fix. Retries can mask signal quality problems.

## Theory and Practice Anchors

- reliable-test engineering practice: flakiness is a systems problem, not a cosmetic inconvenience.
- Fowler and modern CI guidance: brittle high-level tests should be minimized and stabilized, not normalized.
