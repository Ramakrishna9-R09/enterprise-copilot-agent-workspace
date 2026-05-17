# Operating Runbook

This runbook describes how to operate the Copilot agent workspace in a real engineering flow.

## Prerequisites

- VS Code with GitHub Copilot Chat agent mode.
- Node.js with `npx` available on PATH.
- Atlassian MCP server configured from `.vscode/settings.json`.
- OAuth authorization for both Jira and Confluence.
- Repository placeholders replaced:
  - `[YOUR_SITE_URL]`
  - `[YOUR_PROJECT_KEY]`
  - `[YOUR_SPACE_ID]`

## Standard Ticket Flow

1. Start with a Jira ticket ID from project `[YOUR_PROJECT_KEY]`.
2. Run the full SDLC prompt from `.github/prompts/full-sdlc.prompt.md`.
3. Let `jira-agent` extract the ticket context.
4. Let `hld-agent` produce the high-level design.
5. Review the HLD as a human.
6. Type `APPROVED` only when the design is acceptable.
7. Let `lld-agent` produce the implementation blueprint.
8. Review the LLD as a human.
9. Type `APPROVED` only when implementation scope is clear.
10. Let `code-generator`, `unit-tester`, `code-reviewer`, and `bug-fixer` complete the implementation loop.
11. Let `jira-agent` update Jira with the PR and test status.
12. Let `confluence-agent` publish or update documentation and link it back to Jira.

## Human Approval Rules

- HLD approval is required before LLD.
- LLD approval is required before code.
- Destructive or irreversible Jira actions require explicit confirmation.
- Production-impacting migrations or config changes require rollout notes.

## Atlassian Rules

- Every Jira and Confluence search uses `maxResults: 10`.
- Confluence must be searched before creating pages.
- Documentation pages must link to the source Jira ticket.
- Jira tickets must receive the Confluence URL after page creation or update.

## Failure Handling

If Jira cannot be reached:

1. Verify the MCP server is running.
2. Re-run OAuth.
3. Confirm Jira permissions for the project.
4. Continue from pasted ticket context only if the human approves.

If Confluence cannot be reached:

1. Verify Confluence OAuth scopes.
2. Search the target space manually from the MCP tool.
3. Do not create duplicate pages from partial information.
4. Keep the documentation artifact in Markdown until publishing succeeds.

If tests fail:

1. Keep the failing command output in the PR notes.
2. Invoke `bug-fixer` only for confirmed defects.
3. Do not weaken tests to force a pass.
4. Re-run focused tests before broader suites.

## Demo Script

1. Show `.github/copilot-instructions.md` as permanent governance.
2. Show `.github/agents/` to explain separation of responsibilities.
3. Show `.github/prompts/full-sdlc.prompt.md` to highlight approval gates.
4. Show `.vscode/settings.json` to explain MCP integration.
5. Run `tools/validate-workspace.ps1` to prove the repository contract.
6. Walk through how a Jira ID becomes a reviewed, tested, documented PR.
