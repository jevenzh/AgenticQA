# Security Severity Rating

Rate findings consistently so release decisions are defensible.

## Minimal Rating Factors

Assess each finding on:
- exploitability
- impact to confidentiality, integrity, and availability
- scope or blast radius
- evidence quality and reproducibility
- presence of compensating controls

## Blocking Guidance

Treat as likely blockers when findings involve:
- privilege escalation
- cross-tenant data access
- sensitive-data exposure
- auth bypass
- reliable remote code or query injection

## Theory and Practice Anchors

- CVSS-style thinking and common vuln triage practice: severity should reflect exploitability and impact, not intuition alone.
- OWASP and enterprise AppSec programs commonly separate severity from business waiver decisions; the skill should do the same.
