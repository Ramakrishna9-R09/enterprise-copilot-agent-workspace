# New Feature Workflow

Use this prompt when a human asks to implement a new feature from a Jira ticket or product brief.

## Workflow

1. Invoke `jira-agent` when a Jira ticket ID is available.
2. Invoke `hld-agent` when system design or cross-component behavior is involved.
3. Wait for HLD approval when an HLD is produced.
4. Invoke `lld-agent` to create the implementation blueprint.
5. Wait for LLD approval.
6. Invoke `code-generator` to implement the approved scope.
7. Invoke `unit-tester` to reach 90%+ branch coverage for changed logic.
8. Invoke `code-reviewer` and address confirmed defects through `bug-fixer`.
9. Invoke `confluence-agent` when design documentation should be published.
10. Invoke `jira-agent` to update Jira with PR, tests, and documentation links.

## Required Output

Return:

1. Feature summary.
2. Design artifacts created.
3. Implementation summary.
4. Tests and coverage.
5. Review status.
6. Documentation links.
7. Jira status.
8. PR readiness.

## Guardrails

- Do not implement before required approvals.
- Do not create unauthenticated routes.
- Do not bypass Zod validation.
- Do not create duplicate Confluence pages.
- Do not perform destructive Jira actions without explicit confirmation.
