# Write LLD

Use this prompt to create a low-level implementation blueprint from an approved HLD.

## Workflow

1. Confirm the HLD has been approved.
2. Invoke `lld-agent`.
3. Ensure the LLD follows `.github/copilot-instructions.md`.
4. Stop after the LLD and wait for human approval before implementation.

## Required Output

Return the LLD with:

1. File-level plan.
2. Function signatures with TypeScript types.
3. API contracts.
4. Database schema and migration SQL.
5. Mermaid sequence diagram.
6. Error handling per failure case.
7. Feature flags and configuration.
8. Test plan.
9. Implementation order.

## Completion Rule

End with: `LLD is ready for review. Type APPROVED to continue to implementation.`
