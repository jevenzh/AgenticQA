# Test Design Techniques

Use these techniques to convert vague requirements into defensible test cases.

## Recommended Technique Selection

- `Equivalence partitioning`: group inputs that should behave the same; test one representative from each meaningful class.
- `Boundary value analysis`: test the edges around limits because faults cluster at boundaries.
- `Decision tables`: use when outcomes depend on combinations of rules, flags, or permissions.
- `State transition testing`: use when allowed behavior depends on current status, sequence, or lifecycle stage.
- `Error guessing`: apply only after the structured techniques above, based on defect history and domain experience.

## Minimal Selection Rule

For each requirement or risk area, explicitly note:
- which technique was chosen
- why it fits the behavior
- which important combinations or boundaries remain untested

## Quality Checks

A well-designed case set should:
- cover all high-risk partitions
- include valid and invalid conditions
- expose rule conflicts and state-dependent behavior
- avoid redundant cases that assert the same thing at multiple layers

## Theory and Practice Anchors

- ISTQB Foundation Level Syllabus v4.0: canonical definitions for equivalence partitioning, boundary value analysis, decision tables, and state transition testing.
- Glenford J. Myers, Corey Sandler, Tom Badgett, *The Art of Software Testing*, 3rd ed.: enduring rationale for fault-focused test design and error guessing.
- ISO/IEC/IEEE 29119 series: formalizes test design and documentation concepts used in professional test processes.
