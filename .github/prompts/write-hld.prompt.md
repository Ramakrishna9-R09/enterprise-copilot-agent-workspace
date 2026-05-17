# Write HLD

Use this prompt to create a human-reviewable high-level design from a Jira ticket, product brief, or engineering request.

## Workflow

1. Invoke `jira-agent` if a Jira ticket ID is provided.
2. Invoke `hld-agent` to produce documentation only.
3. Ensure the HLD follows `.github/copilot-instructions.md`.
4. Stop after the HLD and wait for human approval before any LLD or code work.

## Required Output

Return the HLD with:

1. Overview.
2. System context.
3. Component breakdown.
4. Data flow.
5. External dependencies.
6. Non-functional requirements.
7. Open questions.
8. LLD handoff notes.

## Completion Rule

End with: `HLD is ready for review. Type APPROVED to continue to LLD planning.`
