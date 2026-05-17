$ErrorActionPreference = "Stop"

function Assert-True {
    param(
        [bool] $Condition,
        [string] $Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Read-Text {
    param([string] $Path)
    return Get-Content -LiteralPath $Path -Raw
}

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $root

$requiredFiles = @(
    "AGENTS.md",
    "README.md",
    ".env.example",
    ".editorconfig",
    ".gitattributes",
    ".gitignore",
    ".vscode/settings.json",
    ".github/MCP_SETUP.md",
    ".github/copilot-instructions.md",
    ".github/pull_request_template.md",
    ".github/workflows/validate-agent-workspace.yml",
    ".github/skills/hld-creator/SKILL.md",
    ".github/skills/lld-creator/SKILL.md",
    ".github/skills/code-reviewer/SKILL.md",
    ".github/skills/unit-tester/SKILL.md",
    ".github/skills/jira-workflow/SKILL.md",
    ".github/skills/confluence-writer/SKILL.md",
    ".github/agents/hld-agent.agent.md",
    ".github/agents/lld-agent.agent.md",
    ".github/agents/code-generator.agent.md",
    ".github/agents/code-reviewer.agent.md",
    ".github/agents/bug-fixer.agent.md",
    ".github/agents/unit-tester.agent.md",
    ".github/agents/jira-agent.agent.md",
    ".github/agents/confluence-agent.agent.md",
    ".github/prompts/full-sdlc.prompt.md",
    ".github/prompts/write-hld.prompt.md",
    ".github/prompts/write-lld.prompt.md",
    ".github/prompts/bug-report.prompt.md",
    ".github/prompts/new-feature.prompt.md",
    "docs/OPERATING_RUNBOOK.md"
)

foreach ($file in $requiredFiles) {
    Assert-True (Test-Path -LiteralPath $file) "Missing required file: $file"
}

$settings = Read-Text ".vscode/settings.json" | ConvertFrom-Json
Assert-True ($null -ne $settings.mcp.servers.atlassian) "settings.json must define mcp.servers.atlassian"
Assert-True ($settings.mcp.servers.atlassian.command -eq "npx") "Atlassian MCP command must be npx"
Assert-True (($settings.mcp.servers.atlassian.args -join " ") -eq "mcp-remote https://mcp.atlassian.com/v1/sse") "Atlassian MCP args are incorrect"

$skillFiles = Get-ChildItem ".github/skills" -Filter "SKILL.md" -Recurse
Assert-True ($skillFiles.Count -eq 6) "Expected 6 skill files, found $($skillFiles.Count)"

foreach ($skill in $skillFiles) {
    $content = Read-Text $skill.FullName
    Assert-True ($content -match "(?s)^---\s*\r?\n.*?name:\s*.+?\r?\n.*?description:\s*.+?\r?\n.*?user-invocable:\s*true.*?\r?\n---") "Skill frontmatter invalid: $($skill.FullName)"
    Assert-True ($content.Contains("## Trigger Condition")) "Skill missing trigger condition: $($skill.FullName)"
    Assert-True ($content.Contains("## Execution Instructions")) "Skill missing execution instructions: $($skill.FullName)"
    Assert-True ($content.Contains("## Output Format")) "Skill missing output format: $($skill.FullName)"
    Assert-True ($content.Contains("## Quality Gates")) "Skill missing quality gates: $($skill.FullName)"
}

$agentFiles = Get-ChildItem ".github/agents" -Filter "*.agent.md"
Assert-True ($agentFiles.Count -eq 8) "Expected 8 agent files, found $($agentFiles.Count)"

foreach ($agent in $agentFiles) {
    $content = Read-Text $agent.FullName
    Assert-True ($content -match "(?s)^---\s*\r?\n.*?name:\s*.+?\r?\n.*?description:\s*.+?\r?\n.*?tools:\s*\r?\n") "Agent frontmatter invalid: $($agent.FullName)"
    Assert-True ($content.Contains("## Role Statement")) "Agent missing role statement: $($agent.FullName)"
    Assert-True ($content.Contains("## Execution Steps")) "Agent missing execution steps: $($agent.FullName)"
    Assert-True ($content.Contains("## Hard Constraints")) "Agent missing hard constraints: $($agent.FullName)"
    Assert-True ($content.Contains("## Output Specification")) "Agent missing output specification: $($agent.FullName)"
    $stepCount = ([regex]::Matches($content, "(?m)^\d+\. ")).Count
    Assert-True ($stepCount -ge 6) "Agent needs at least 6 numbered execution steps: $($agent.FullName)"
}

$fullSdlc = Read-Text ".github/prompts/full-sdlc.prompt.md"
$gateCount = (Select-String -Path ".github/prompts/full-sdlc.prompt.md" -Pattern "STOP. Show output above. Do NOT proceed until human types APPROVED." -SimpleMatch).Count
Assert-True ($gateCount -eq 2) "full-sdlc prompt must contain exactly two STOP approval gates"
Assert-True ($fullSdlc -match "hld-agent[\s\S]*lld-agent[\s\S]*code-generator[\s\S]*unit-tester[\s\S]*code-reviewer[\s\S]*bug-fixer[\s\S]*jira-agent[\s\S]*confluence-agent") "full-sdlc prompt pipeline order is incomplete"

$criticalChecks = @{
    ".github/agents/code-reviewer.agent.md" = "DO NOT write or suggest specific code"
    ".github/agents/bug-fixer.agent.md" = "DO NOT refactor unrelated code"
    ".github/agents/hld-agent.agent.md" = "MUST output documentation only"
    ".github/agents/lld-agent.agent.md" = "MUST write zero implementation code"
    ".github/agents/jira-agent.agent.md" = "MUST confirm before any destructive/irreversible action"
    ".github/agents/unit-tester.agent.md" = "MUST target 90%+ branch coverage"
    ".github/agents/confluence-agent.agent.md" = "MUST search for existing pages before creating new ones"
}

foreach ($path in $criticalChecks.Keys) {
    $content = Read-Text $path
    Assert-True ($content.Contains($criticalChecks[$path])) "Missing critical phrase in ${path}: $($criticalChecks[$path])"
}

$allowedPlaceholders = @("[YOUR_PROJECT_KEY]", "[YOUR_SPACE_ID]", "[YOUR_SITE_URL]")
$filesToScan = Get-ChildItem -File -Recurse -Force |
    Where-Object { $_.FullName -notmatch "\\.git\\" -and $_.FullName -notmatch "\\tools\\validate-workspace\.ps1$" }

foreach ($file in $filesToScan) {
    $content = Read-Text $file.FullName
    $matches = [regex]::Matches($content, "\[[A-Z][A-Z0-9_ -]*\]")
    foreach ($match in $matches) {
        Assert-True ($allowedPlaceholders -contains $match.Value) "Unexpected placeholder $($match.Value) in $($file.FullName)"
    }
}

$instructions = Read-Text ".github/copilot-instructions.md"
foreach ($required in @(
    'Node.js 20',
    'React 18',
    'Zod always, no exceptions',
    'AppError',
    'logger',
    'QueryBuilder',
    'JWT middleware is required on all routes',
    'environment variables only',
    '`async` and `await` only',
    'maxResults: 10',
    'Always search Confluence before creating pages'
)) {
    Assert-True ($instructions.Contains($required)) "copilot-instructions.md missing required standard: $required"
}

Write-Host "PASS: Agent workspace contract is valid."
