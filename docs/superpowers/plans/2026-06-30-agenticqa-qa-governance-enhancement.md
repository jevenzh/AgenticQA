# AgenticQA QA Governance Enhancement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add missing QA governance capabilities (quality gates, reliability policy, metrics, security testing, performance testing, and environment/data guidance) and upgrade existing skills/workflows to align with industry best practices.

**Architecture:** Extend the current “portable QA assets” model with new agents, skills, and commands that encode operational QA workflows in addition to test-authoring guidance. Keep the existing naming conventions and cross-agent symlink model intact so all assets remain reusable across Claude/OpenCode/Copilot.

**Tech Stack:** Markdown-based agent/skill/command assets, Bash installer/uninstaller, git-based verification via dry-run install checks.

---

### Task 1: Add QA Governance Skill (Shift-Left + Quality Gates)

**Files:**
- Create: `skills/qa-governance-workflow/SKILL.md`
- Create: `commands/quality-gates.md`
- Modify: `README.md`

- [ ] **Step 1: Write the failing test (content contract check)**

```bash
rg -n "qa-governance-workflow|quality-gates" README.md skills commands
```

Expected: no matches before implementation.

- [ ] **Step 2: Create governance skill with stage-based gate policy**

```markdown
---
name: qa-governance-workflow
description: Define and enforce stage-based QA workflow and quality gates (local, PR, pre-release, post-release) with pass/fail criteria and escalation rules.
---

# QA Governance Workflow

## Procedure
1. Classify change risk (low/medium/high) from blast radius and user impact.
2. Assign mandatory checks by stage:
   - Local: lint + unit + targeted integration
   - PR: full unit + integration + API contract + security static checks
   - Pre-release: E2E smoke + perf smoke + migration checks
   - Post-release: canary validation + production SLO monitors
3. Define blocking criteria (P0/P1 regressions, contract breaks, critical vulns, flake budget breach).
4. Emit a Quality Gate Matrix table with owner, signal, threshold, and block behavior.
5. Produce waiver process: who can waive, expiry, and compensating controls.
```

- [ ] **Step 3: Add command to invoke the gate workflow**

```markdown
---
description: Build a stage-based quality gate matrix for the current change/release and identify blockers.
mode: agent
argument-hint: <"current diff", PR, release scope>
---

# Quality Gates

Create quality gates for: **$ARGUMENTS**

Required output:
- Risk level and rationale
- Gate Matrix (Local, PR, Pre-release, Post-release)
- Blocking thresholds
- Waivers and expiry
- Immediate actions for red/yellow gates
```

- [ ] **Step 4: Update README asset inventory and coverage statement**

```markdown
- Add `qa-governance-workflow/SKILL.md` under `skills/`
- Add `quality-gates.md` under `commands/`
- Update coverage text to include governance and quality-gate workflow
```

- [ ] **Step 5: Verify the task**

Run:

```bash
rg -n "qa-governance-workflow|quality-gates|governance" README.md skills commands
```

Expected: matches in new files and README.

- [ ] **Step 6: Commit**

```bash
git add README.md skills/qa-governance-workflow/SKILL.md commands/quality-gates.md
git commit -m "feat: add QA governance workflow and quality gates command"
```

### Task 2: Add Test Reliability Policy and Flake Management

**Files:**
- Create: `skills/test-reliability-manager/SKILL.md`
- Create: `commands/test-reliability-audit.md`
- Modify: `agents/qa-e2e-tester.md`
- Modify: `agents/qa-unit-tester.md`

- [ ] **Step 1: Write failing test (policy missing)**

```bash
rg -n "flake|quarantine|reliability budget|runtime budget" skills agents commands
```

Expected: no explicit reliability policy contract found.

- [ ] **Step 2: Create reliability manager skill**

```markdown
---
name: test-reliability-manager
description: Audit and improve test reliability with flake budget, quarantine rules, runtime budgets, and deterministic test standards.
---

# Test Reliability Manager

## Policy Baseline
- Flake budget: <= 2% for E2E suites, <= 0.5% for unit/integration.
- Quarantine SLA: flaky test must be fixed or removed from quarantine within 7 days.
- Runtime budget: PR critical path tests complete within agreed threshold.

## Procedure
1. Identify flaky tests and classify root cause (timing, data, env, order dependence).
2. Enforce no fixed sleeps; replace with condition/assertion waits.
3. Define quarantine with owner + expiry.
4. Emit Reliability Report with actions and due dates.
```

- [ ] **Step 3: Add reliability audit command**

```markdown
---
description: Audit test flakiness, quarantine status, and runtime budgets for the current test portfolio.
mode: agent
argument-hint: <suite path, tag, or "current CI failures">
---

# Test Reliability Audit

Output:
- Flake hotspots
- Quarantine list (owner, age, expiry)
- Runtime budget status
- Top fixes by impact
```

- [ ] **Step 4: Enhance unit/e2e agents with explicit budgets**

```markdown
# In qa-unit-tester.md add DoD bullets:
- Average test runtime stays within project unit-test budget.
- New flaky behavior is unacceptable; identify and fix nondeterminism before completion.

# In qa-e2e-tester.md add DoD bullets:
- Any flaky test is either fixed immediately or quarantined with owner and expiry.
- Runtime impact is reported for PR-critical E2E suites.
```

- [ ] **Step 5: Verify the task**

```bash
rg -n "flake budget|quarantine|runtime budget|owner and expiry" skills agents commands
```

Expected: policy text present in new/updated assets.

- [ ] **Step 6: Commit**

```bash
git add skills/test-reliability-manager/SKILL.md commands/test-reliability-audit.md agents/qa-unit-tester.md agents/qa-e2e-tester.md
git commit -m "feat: add test reliability policy and audit workflow"
```

### Task 3: Add QA Metrics Scorecard Workflow

**Files:**
- Create: `skills/qa-metrics-scorecard/SKILL.md`
- Create: `commands/qa-scorecard.md`
- Modify: `README.md`

- [ ] **Step 1: Write failing test (metrics workflow missing)**

```bash
rg -n "scorecard|escaped defects|MTTR|DRE|quality metrics" README.md skills commands
```

Expected: no dedicated metrics workflow.

- [ ] **Step 2: Create scorecard skill**

```markdown
---
name: qa-metrics-scorecard
description: Build a QA scorecard with leading and lagging indicators for release readiness and process health.
---

# QA Metrics Scorecard

## Required Metrics
- Escaped defects (count + severity)
- Defect removal efficiency (DRE)
- Mean time to detect/mitigate (MTTD/MTTM)
- Flake rate by suite
- Pass rate stability over last N runs
- Coverage risk deltas for changed components

## Procedure
1. Collect available metrics and mark missing instrumentation.
2. Compute scorecard status (green/yellow/red).
3. Recommend concrete corrective actions with owners.
```

- [ ] **Step 3: Add scorecard command**

```markdown
---
description: Generate a QA scorecard for a release, sprint, or current branch health.
mode: agent
argument-hint: <release tag, sprint, or "current branch">
---

# QA Scorecard

Produce:
- KPI table (metric, current, threshold, trend, status)
- Risks and likely release impact
- Top 3 corrective actions
```

- [ ] **Step 4: Update README for new metrics capability**

```markdown
- Add `qa-metrics-scorecard/SKILL.md`
- Add `qa-scorecard.md`
- Mention KPI-driven quality governance in repo capabilities
```

- [ ] **Step 5: Verify the task**

```bash
rg -n "qa-metrics-scorecard|qa-scorecard|escaped defects|DRE|MTTD|MTTM" README.md skills commands
```

Expected: matches in created/updated files.

- [ ] **Step 6: Commit**

```bash
git add README.md skills/qa-metrics-scorecard/SKILL.md commands/qa-scorecard.md
git commit -m "feat: add QA metrics scorecard skill and command"
```

### Task 4: Add Security Testing Specialist Agent + Skill

**Files:**
- Create: `agents/qa-security-tester.md`
- Create: `skills/security-test-generator/SKILL.md`
- Create: `commands/security-regression-plan.md`
- Modify: `README.md`

- [ ] **Step 1: Write failing test (security specialist absent)**

```bash
rg -n "qa-security-tester|security-test-generator|OWASP|threat" agents skills commands README.md
```

Expected: no dedicated security testing assets.

- [ ] **Step 2: Add security agent file**

```markdown
---
name: qa-security-tester
description: Designs and executes security-focused tests for APIs and web flows using OWASP-aligned techniques and abuse-case coverage.
mode: subagent
permission:
  read: allow
  edit: allow
  bash: allow
---

# QA Security Tester

Principles:
- Cover authn/authz, input validation, session handling, rate limiting, and secrets exposure.
- Include abuse cases (privilege escalation, IDOR, injection-like payload classes).
- Require reproducible evidence for each finding.
```

- [ ] **Step 3: Add security skill and command**

```markdown
# skills/security-test-generator/SKILL.md should define:
- threat-surface inventory
- security test matrix by endpoint/flow
- severity tagging and remediation guidance

# commands/security-regression-plan.md should request:
- threat model deltas for current change
- must-run security checks
- release-blocking vulnerabilities
```

- [ ] **Step 4: Update README inventory and domain coverage**

```markdown
- Add security agent/skill/command entries
- Expand domain coverage statement to include security testing
```

- [ ] **Step 5: Verify the task**

```bash
rg -n "qa-security-tester|security-test-generator|security-regression-plan|OWASP|IDOR" README.md agents skills commands
```

Expected: security assets and terminology present.

- [ ] **Step 6: Commit**

```bash
git add README.md agents/qa-security-tester.md skills/security-test-generator/SKILL.md commands/security-regression-plan.md
git commit -m "feat: add security testing specialist assets"
```

### Task 5: Add Performance/Resilience Testing Specialist Agent + Skill

**Files:**
- Create: `agents/qa-performance-tester.md`
- Create: `skills/performance-test-generator/SKILL.md`
- Create: `commands/performance-budget-check.md`
- Modify: `README.md`

- [ ] **Step 1: Write failing test (performance workflow absent)**

```bash
rg -n "qa-performance-tester|performance-test-generator|latency budget|load|soak|stress" agents skills commands README.md
```

Expected: no dedicated performance testing assets.

- [ ] **Step 2: Add performance agent file**

```markdown
---
name: qa-performance-tester
description: Designs and executes performance and resilience tests (baseline, load, stress, soak) with SLO-aware reporting.
mode: subagent
permission:
  read: allow
  edit: allow
  bash: allow
---

# QA Performance Tester

Principles:
- Validate latency, throughput, error rate against explicit budgets.
- Test normal load, peak load, and failure/recovery paths.
- Report bottlenecks with reproducible scenario definitions.
```

- [ ] **Step 3: Add performance skill and command**

```markdown
# skills/performance-test-generator/SKILL.md should define:
- workload model, baseline, load, stress, soak scenarios
- pass/fail thresholds tied to SLOs
- artifact expectations (p95/p99 latency, throughput, error-rate)

# commands/performance-budget-check.md should request:
- target budget and scenario
- results summary vs thresholds
- release recommendation
```

- [ ] **Step 4: Update README**

```markdown
- Add performance agent/skill/command entries
- Expand capability statement to include performance/resilience testing
```

- [ ] **Step 5: Verify the task**

```bash
rg -n "qa-performance-tester|performance-test-generator|performance-budget-check|p95|soak|stress" README.md agents skills commands
```

Expected: performance assets and terms present.

- [ ] **Step 6: Commit**

```bash
git add README.md agents/qa-performance-tester.md skills/performance-test-generator/SKILL.md commands/performance-budget-check.md
git commit -m "feat: add performance and resilience testing assets"
```

### Task 6: Add Test Data + Environment Management Workflow

**Files:**
- Create: `skills/test-environment-and-data/SKILL.md`
- Create: `commands/test-data-readiness.md`
- Modify: `agents/qa-api-tester.md`
- Modify: `agents/qa-e2e-tester.md`

- [ ] **Step 1: Write failing test (env/data playbook missing)**

```bash
rg -n "ephemeral|seed|teardown|data contract|environment readiness" skills agents commands
```

Expected: only partial mentions, no dedicated workflow.

- [ ] **Step 2: Add env/data skill**

```markdown
---
name: test-environment-and-data
description: Standardize test environment readiness, seeded data contracts, and teardown hygiene for reliable repeatable QA.
---

# Test Environment and Data

## Procedure
1. Declare environment tiers and required dependencies.
2. Define seed data contracts (owner, schema, reset strategy).
3. Enforce setup/teardown checklist per suite type.
4. Validate parallel safety and isolation.
```

- [ ] **Step 3: Add readiness command and strengthen API/E2E agents**

```markdown
# commands/test-data-readiness.md output:
- env prerequisites
- data seed/reset checklist
- isolation risks and mitigations

# qa-api-tester.md add:
- explicit seeded data reset requirement

# qa-e2e-tester.md add:
- environment readiness gate before running journeys
```

- [ ] **Step 4: Verify the task**

```bash
rg -n "test-environment-and-data|test-data-readiness|seed data|teardown|parallel-safe" skills agents commands
```

Expected: env/data workflow present and referenced.

- [ ] **Step 5: Commit**

```bash
git add skills/test-environment-and-data/SKILL.md commands/test-data-readiness.md agents/qa-api-tester.md agents/qa-e2e-tester.md
git commit -m "feat: add test environment and data readiness workflow"
```

### Task 7: Enhance Existing Planning/Coverage Workflows and Validate Packaging

**Files:**
- Modify: `commands/regression-plan.md`
- Modify: `commands/review-test-coverage.md`
- Modify: `skills/test-plan-designer/SKILL.md`
- Modify: `README.md`

- [ ] **Step 1: Write failing test (missing operational QA dimensions in existing planners)**

```bash
rg -n "quality gate|security|performance|reliability|scorecard|post-release" commands/regression-plan.md commands/review-test-coverage.md skills/test-plan-designer/SKILL.md
```

Expected: incomplete operational dimensions.

- [ ] **Step 2: Enhance planning assets**

```markdown
# regression-plan.md add required sections:
- Required Quality Gates by stage
- Security/Performance regression slice
- Reliability risks and flake controls
- Post-release verification plan

# review-test-coverage.md add:
- non-functional coverage gaps (security/performance/reliability)
- gate impact for each high-risk gap

# test-plan-designer/SKILL.md add:
- explicit quality-gate mapping
- metric/KPI acceptance criteria
```

- [ ] **Step 3: Update README with full asset map and workflow examples**

```markdown
- Expand "What's inside" tree for all new agents/skills/commands
- Add "Standard QA Workflow" section:
  1) Plan (risk + gates)
  2) Generate tests by layer
  3) Reliability audit
  4) Security/performance checks
  5) Scorecard + release decision
```

- [ ] **Step 4: Verify installer compatibility and projected links**

Run:

```bash
./install.sh --dry-run --project . --target all
./uninstall.sh --dry-run --project . --target all
```

Expected:
- install dry-run prints new agent/skill/command links under `.claude/`, `.opencode/`, `.github/` (commands only for claude/opencode).
- uninstall dry-run reports only symlinks pointing to this repo.

- [ ] **Step 5: Repo-wide validation**

Run:

```bash
rg --files agents skills commands | sort
rg -n "mode: subagent|mode: agent|^name:" agents skills commands
```

Expected:
- all new assets listed
- frontmatter shape consistent with existing conventions.

- [ ] **Step 6: Commit**

```bash
git add README.md commands/regression-plan.md commands/review-test-coverage.md skills/test-plan-designer/SKILL.md
git commit -m "feat: enhance planning and coverage workflows with governance dimensions"
```

### Task 8: Final Review and Release Notes

**Files:**
- Create: `docs/qa-enhancement-release-notes-2026-06-30.md`

- [ ] **Step 1: Write release notes**

```markdown
# QA Enhancement Release Notes

## Added
- New governance/reliability/metrics/security/performance/env-data assets

## Changed
- Updated planning and coverage workflows

## Adoption
- Suggested command sequence for teams
```

- [ ] **Step 2: Verify git diff scope**

Run:

```bash
git status --short
git diff --stat
```

Expected: only intended QA asset and docs changes.

- [ ] **Step 3: Commit**

```bash
git add docs/qa-enhancement-release-notes-2026-06-30.md
git commit -m "docs: add QA enhancement release notes and adoption guidance"
```
