# QA Enhancement Release Notes

## Added

- Governance workflow skill and quality gates command
- Test reliability manager skill and reliability audit command
- QA metrics scorecard skill and scorecard command
- Security specialist agent, security test generator skill, and security regression planning command
- Performance specialist agent, performance test generator skill, and performance budget check command
- Test environment and data readiness skill and command

## Changed

- Enhanced existing planning and coverage workflows with governance, reliability, security, and performance dimensions
- Updated unit/API/E2E agents with stronger reliability and environment expectations
- Expanded README asset inventory and standard QA workflow guidance

## Recommended Adoption Sequence

1. Run `quality-gates` and `regression-plan` at change planning time.
2. Generate layer-specific tests with `generate-tests` plus specialized agents.
3. Run `test-reliability-audit` and fix/quarantine flaky tests with owner and expiry.
4. Run `security-regression-plan` and `performance-budget-check` for release-bound changes.
5. Produce `qa-scorecard` before release decision.

## Remaining TODOs

- [ ] Align core agents with the richer skill workflow so direct agent invocation still requires upstream artifacts, trace IDs, validators, and automated-vs-UAT separation.
- [ ] Normalize older commands so they explicitly route through the corresponding skills, references, and validation scripts.
- [ ] Upgrade governance, reliability, metrics, and environment/data skills to the same `references/` plus optional `scripts/` standard used by the main generator skills.
- [ ] Improve README inventory so supporting assets such as `templates/`, `examples/`, `references/`, and `scripts/` are visible as part of the repo contract.
