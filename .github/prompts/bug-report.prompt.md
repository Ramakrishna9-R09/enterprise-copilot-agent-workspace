# Bug Report Workflow

Use this prompt when a human provides a bug report, failing test, production symptom, or Jira defect ticket.

## Workflow

1. Invoke `jira-agent` if a Jira ticket ID is provided.
2. Identify expected behavior, actual behavior, reproduction steps, affected users, severity, and suspected scope.
3. Invoke `bug-fixer` to reproduce or reason through the defect and implement the smallest safe fix.
4. Invoke `unit-tester` to add regression coverage using Jest or React Testing Library.
5. Invoke `code-reviewer` to validate the fix and identify residual risk.
6. Invoke `jira-agent` to add a concise progress update when requested.

## Required Output

Return:

1. Bug summary.
2. Root cause.
3. Fix summary.
4. Regression tests added.
5. Commands run.
6. Review verdict.
7. Jira update status.
8. Residual risk.

## Guardrails

- Do not refactor unrelated code.
- Do not weaken tests to make failures pass.
- Do not close or transition Jira tickets without explicit confirmation.
- Do not skip regression coverage unless a clear technical reason is documented.
