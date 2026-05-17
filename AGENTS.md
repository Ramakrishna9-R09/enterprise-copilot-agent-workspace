# Agent Constants

This file keeps token-saving constants and operating rules for cloud agents, local Copilot agent mode, and humans reviewing this repository.

## Atlassian Constants

- Jira site: `https://[YOUR_SITE_URL].atlassian.net`
- Jira project key: `[YOUR_PROJECT_KEY]`
- Confluence space ID: `[YOUR_SPACE_ID]`
- Atlassian query limit: always use `maxResults: 10`

## Cloud Agent Authentication

Cloud or non-interactive agent sessions should use API token authentication, not OAuth. OAuth is appropriate for an interactive VS Code developer flow, but API tokens are more reliable for headless automation and auditable service contexts.

## Global Agent Rules

- Search Jira and Confluence with `maxResults: 10`.
- Search Confluence before creating pages.
- Comment Confluence URLs back on Jira tickets after page creation or update.
- Confirm before destructive or irreversible Jira actions.
- Keep secrets in environment variables only.
- Follow `.github/copilot-instructions.md` for architecture, implementation, testing, and review rules.
