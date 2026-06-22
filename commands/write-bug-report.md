---
description: Turn an observed problem into a clear, reproducible bug report with severity and evidence.
mode: agent
argument-hint: <description of the bug or failing behavior>
---

# Write Bug Report

Create a bug report for: **$ARGUMENTS**

Investigate as needed (read code, run the failing case, check logs) and produce a report with these sections:

- **Summary** — one line: what is broken and where.
- **Environment** — OS/browser/runtime, version/commit, configuration.
- **Steps to Reproduce** — numbered, minimal, deterministic.
- **Expected Result** vs **Actual Result**.
- **Severity / Priority** — with a one-line justification (user impact × frequency).
- **Evidence** — error output, stack trace, screenshot path, or failing test.
- **Suspected Area** — file/component most likely responsible, if identifiable.

Keep it minimal and reproducible. If you cannot reproduce it, say so and list what information is still needed.
