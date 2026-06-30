# Determinism Checklist

A unit test should pass or fail for the same reason every run.

## Check These Sources of Nondeterminism

- current time or time zones
- randomness or UUID generation
- global or shared mutable state
- environment variables that vary by machine
- network, filesystem, or process timing
- test order dependence

## Control Strategy

- inject or freeze clocks
- seed or stub random generators
- isolate state per test
- create fixtures explicitly in setup
- avoid hidden dependence on prior tests

## Theory and Practice Anchors

- Google testing guidance on hermetic and reliable tests: tests should be isolated from external instability.
- Modern CI reliability practice: uncontrolled environment and order dependence are primary flake sources even in lower-level tests.
