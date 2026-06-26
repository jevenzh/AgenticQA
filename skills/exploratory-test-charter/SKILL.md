---
name: exploratory-test-charter
description: Design and execute structured exploratory testing sessions using SFDIPOT product heuristics and FEW HICCUPPS oracle heuristics. Produces time-boxed charters, session notes, and structured bug reports. Use when testing without a complete spec, auditing an unfamiliar feature, or investigating a reported bug area.
---

# Exploratory Test Charter

Structure exploratory testing into time-boxed sessions with clear scope, a defined oracle for recognizing bugs, and documented findings.

## When to use

There is no detailed spec to derive cases from. You're investigating a new feature, a reported bug area, or an unfamiliar part of the system. You want to discover bugs that scripted tests won't find because no one thought to write them.

## Procedure

### Step 0 — Context probe

1. Read any available documentation, tickets, or code for the area under test.
2. Identify the mission: what user goal or quality risk are you investigating?
3. Set a time-box: **45–90 minutes** per charter. If the scope demands more, create a second charter — don't extend the session.

### Step 1 — Write the charter

A charter has three parts:

> **Explore** [the area]  
> **With** [the resources, tools, and data]  
> **To discover** [what risks or behaviors you're looking for]

**Example**: *"Explore the checkout flow with a mixed cart (physical + digital items + a discount coupon) with a test account in the staging environment to discover how the order summary handles tax calculation edge cases, what error states are surfaced to the user, and whether pricing is consistent between cart and confirmation screens."*

A good charter is specific enough that two engineers would explore roughly the same territory.

### Step 2 — Apply SFDIPOT to generate test ideas

Use SFDIPOT as a checklist to make sure you cover the whole product, not just the obvious paths:

- **S — Structure**: navigate every reachable state, screen, and path. What happens at structural edges — empty state, maximum items, deeply nested navigation, inaccessible states?
- **F — Function**: exercise each action. What happens with invalid inputs, double-submissions, interruptions mid-action, or actions in an unexpected order?
- **D — Data**: vary inputs systematically. Empty, null, minimal, maximal, boundary values, special characters, Unicode, very long strings, injections. What data persists? What gets discarded?
- **I — Interfaces**: probe integration boundaries. What happens when a downstream API is slow, errors, returns an unexpected shape, or times out? Does the UI surface this meaningfully?
- **P — Platform**: check environmental assumptions. Does behavior vary by browser, OS, screen size, locale, timezone, language setting, or network condition?
- **O — Operations**: explore concurrent and operational scenarios. Two users editing the same record, session expiry mid-action, browser back button after a form submit, high memory pressure.
- **T — Time**: exercise time-sensitive logic. Session timeouts, token expiry, date-based features at midnight and month boundaries, DST transitions, scheduled state changes.

Work through all seven areas; note which you skipped and why.

### Step 3 — Apply FEW HICCUPPS to recognize bugs

Without an explicit expected result, use these oracles to decide whether observed behavior is a defect:

- **F — Familiar**: does it behave consistently with similar features in this product?
- **E — Explainability**: can you explain why the result occurred? If you can't, investigate further.
- **W — World**: does it conform to real-world facts — math, physical constraints, common sense?
- **H — History**: is it consistent with earlier versions of the product?
- **I — Image**: does it reflect the organization's brand, values, and quality standards?
- **C — Comparable products**: does it match how industry-standard equivalents behave?
- **C — Claims**: does it match what the documentation, UI labels, tooltips, and specs promise?
- **U — User expectations**: would a typical user find this surprising, confusing, or misleading?
- **P — Purpose**: does it fulfill the feature's stated goal?
- **P — Product**: is it internally consistent with the rest of the product?
- **S — Standards**: does it comply with WCAG, legal, regulatory, or platform standards?

When observed behavior fails one of these tests, you have a candidate bug — investigate to confirm before reporting.

### Step 4 — Execute the session

Take brief notes in real time (not a full report — that comes after):
- What you did and what you observed
- Anything surprising, inconsistent, or worth returning to
- Questions and assumptions that surfaced
- Candidate bugs (one-line description; full report comes in Step 5)

**Stay on charter.** If you discover something interesting outside scope, note it as a new charter candidate and return — don't let it consume the session time.

### Step 5 — Debrief and report

Immediately after the session, produce:

**Session summary**
- Charter: what was explored, with what tools/data, looking for what
- Time spent and coverage achieved

**Findings**
- Bugs found (write a structured bug report for each)
- Quality risks identified (even if not confirmed bugs)
- Open questions for the team

**SFDIPOT coverage map**: which areas were covered, which were skipped and why

**New charters**: follow-up areas that need further exploration

### Bug report format

- **Summary**: one sentence identifying the behavior and the condition that triggers it
- **Environment**: OS, browser/runtime, version, account type, test data used
- **Steps to reproduce**: numbered, minimal, independently reproducible
- **Expected**: what should happen — cite the FEW HICCUPPS oracle that tells you this is wrong
- **Actual**: what happened
- **Severity / priority**: critical / major / minor / cosmetic
- **Evidence**: screenshot, screen recording, log excerpt, network trace

## Quality bar

- Each charter has a clear mission, scope, and time-box before the session starts.
- All seven SFDIPOT areas are considered; any skipped area has a stated reason.
- Every candidate bug is evaluated against at least one FEW HICCUPPS oracle before reporting.
- Bug reports are reproducible from the written steps alone.
- Each session's findings feed back into the scripted test backlog.

## Anti-patterns to avoid

- Free-form clicking without a written charter — produces noise, not reproducible signal.
- Spending the entire session in one SFDIPOT area — you'll miss entire risk categories.
- Reporting a behavior as a bug without applying a FEW HICCUPPS oracle — it may be intentional.
- Writing bug reports during the session — breaks focus and degrades exploration quality.
- Sessions longer than 90 minutes without a break — concentration degrades and bugs get missed.
- Skipping the debrief — undocumented findings evaporate within hours.
