# Atlassian MCP Setup

This workspace uses the Atlassian remote MCP server so GitHub Copilot agent mode can read Jira tickets and publish Confluence documentation without leaving VS Code.

## VS Code Configuration

The MCP server is configured in `.vscode/settings.json`:

```json
{
  "mcp": {
    "servers": {
      "atlassian": {
        "command": "npx",
        "args": ["mcp-remote", "https://mcp.atlassian.com/v1/sse"]
      }
    }
  }
}
```

## OAuth Setup

1. Open this repository in VS Code.
2. Ensure GitHub Copilot Chat agent mode is enabled.
3. Start the configured `atlassian` MCP server from the VS Code MCP servers view or by triggering an Atlassian tool from Copilot Chat.
4. Complete the browser-based OAuth flow when prompted.
5. Grant permissions for both Jira and Confluence. The workflow requires Jira issue read/comment access and Confluence page search/create/update access.
6. Confirm the authenticated Atlassian site is `https://[YOUR_SITE_URL].atlassian.net`.

## Verification Command

Ask Copilot Chat in agent mode:

```text
Use the atlassian MCP server to search Jira project [YOUR_PROJECT_KEY] with maxResults: 10 and list the first issue key only.
```

Then verify Confluence access:

```text
Use the atlassian MCP server to search Confluence space [YOUR_SPACE_ID] with maxResults: 10 for pages containing architecture and return page titles only.
```

## Operating Rules

- Use `maxResults: 10` on every Atlassian query.
- Search Confluence before creating pages.
- Comment the Confluence URL back on the Jira ticket after creating or updating documentation.
- Confirm before destructive or irreversible Jira operations.
- For cloud or non-interactive agents, use API token authentication rather than OAuth.
