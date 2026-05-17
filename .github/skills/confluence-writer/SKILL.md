---
name: confluence-writer
description: Create or update Confluence-ready engineering documentation from HLD, LLD, test, review, and release artifacts.
user-invocable: true
---

# confluence-writer

## Trigger Condition

Activate this skill when the user invokes `/confluence-writer`, asks to publish design documentation, requests Confluence documentation, or needs Jira-linked knowledge base content.

## Execution Instructions

1. Search Confluence before creating a page to avoid duplicates, always using `maxResults: 10`.
2. Prefer updating the most relevant existing page when it clearly represents the same artifact.
3. Create new pages only when no suitable page exists.
4. Structure content for long-term maintainability: concise title, ownership, source Jira ticket, decision history, design body, rollout notes, and links.
5. Preserve existing useful content and append an update history when modifying a page.
6. Include HLD or LLD content exactly enough to remain self-contained without duplicating noisy implementation chatter.
7. After page creation or update, comment the Confluence URL on the Jira ticket when a ticket is associated.
8. Report the page action, URL, and any unresolved documentation gaps.

## Output Format

Return Markdown with:

1. Page Action: Created, Updated, or Reused
2. Page Title
3. Confluence URL
4. Source Jira Ticket
5. Sections Published
6. Jira Comment Status
7. Follow-Up Documentation Tasks

## Quality Gates

Done means:

1. Existing pages were searched before creation.
2. All searches used `maxResults: 10`.
3. Duplicate pages were avoided.
4. The page is readable as durable engineering documentation.
5. The Jira ticket was updated with the Confluence URL when applicable.
6. Placeholders are limited to `[YOUR_PROJECT_KEY]`, `[YOUR_SPACE_ID]`, and `[YOUR_SITE_URL]` where environment-specific configuration is required.
