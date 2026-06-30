# Theory-Backed Reference Authoring Guide

Use this guide when adding `references/` files to QA skills.

## Goal

A good reference file helps an agent make better decisions with trusted, reusable guidance. It should strengthen the skill without bloating `SKILL.md`.

## Recommended Structure

Each reference file should usually include:
- short purpose statement
- decision rules, heuristics, or checklists
- anti-patterns or common misuse
- `Theory and Practice Anchors` section naming trusted sources

## Source Quality Rules

Prefer sources in this order:
1. formal standards and professional bodies
   - ISO/IEC/IEEE 29119
   - ISTQB syllabi
   - NIST guidance
2. mature industry frameworks
   - OWASP
   - Google SRE
   - Microsoft engineering guidance
3. canonical books or well-known practitioner references
   - Myers
   - Beck
   - Fowler
   - Meszaros
   - Cohn

## Citation Rules

- name the source clearly enough to be recognizable
- cite the concept, not fake precision you cannot verify
- avoid fabricated page numbers or quotations
- do not over-cite; use the minimum anchors needed to justify the guidance
- separate theory anchors from repo-specific advice

## Writing Rules

- keep references concise and decision-oriented
- prefer bullets over essays
- explain when to use a heuristic, not only what it is
- keep technology-neutral unless the skill is domain-specific
- do not duplicate the full contents of `SKILL.md`

## Example Pattern

```markdown
# Authorization Abuse Cases

Use these cases when a feature crosses role, tenant, or ownership boundaries.

## Default Abuse Cases
- unauthenticated access attempt
- under-privileged access attempt
- cross-tenant read attempt
- cross-tenant write attempt

## Theory and Practice Anchors
- OWASP ASVS and API Security Top 10: broken authorization remains a top failure class.
- Risk-based testing practice: negative authz checks deserve priority because impact is high.
```

## Anti-Patterns

- long narrative history lessons
- generic textbook summaries with no decision value
- unsupported claims presented as standards
- repo-specific instructions hidden inside a theory reference
