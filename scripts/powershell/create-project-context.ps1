# Create and initialize project context for Agent Library projects
# This script sets up the necessary context structure when a project is initialized

param(
    [string]$ProjectRoot = ".",
    [string]$ProjectName = "project",
    [switch]$Json = $false
)

$ErrorActionPreference = "Stop"

# Source common functions
. (Join-Path $PSScriptRoot "common.ps1")

Write-Log "Initializing project context for: $ProjectName" -Level Info

# Create context directories
$contextPath = Join-Path $ProjectRoot ".agents" "context"
$personasPath = Join-Path $ProjectRoot ".agents" "personas"
$tasksPath = Join-Path $ProjectRoot ".agents" "tasks"
$memoryPath = Join-Path $ProjectRoot ".agents" "memory"

foreach ($path in @($contextPath, $personasPath, $tasksPath, $memoryPath)) {
    New-Item -ItemType Directory -Path $path -Force | Out-Null
}

Write-Log "Created context directories" -Level Success

# Create initial context file
$contextState = @{
    project = @{
        name = $ProjectName
        created = (Get-Date -AsUTC -Format 'o')
        version = "0.1.0"
    }
    phase = "initialization"
    active_personas = @()
    completed_tasks = @()
    project_decisions = @()
    files_created = @{}
    metadata = @{}
} | ConvertTo-Json -Depth 10

$contextFile = Join-Path $contextPath "state.json"
Set-Content -Path $contextFile -Value $contextState

Write-Log "Created context state file" -Level Success

# Create personas registry
$personasRegistry = @{
    available_personas = @(
        "architect",
        "implementer", 
        "debugger",
        "reviewer",
        "researcher",
        "documentarian",
        "optimizer",
        "tester"
    )
    active_personas = @()
    persona_sessions = @{}
} | ConvertTo-Json -Depth 10

$personasFile = Join-Path $personasPath "registry.json"
Set-Content -Path $personasFile -Value $personasRegistry

Write-Log "Created personas registry" -Level Success

# Create tasks tracking file
$taskTracking = @{
    tasks = @()
    completed = @()
    in_progress = @()
    failed = @()
} | ConvertTo-Json -Depth 10

$tasksFile = Join-Path $tasksPath "tracking.json"
Set-Content -Path $tasksFile -Value $taskTracking

Write-Log "Created tasks tracking" -Level Success

# Create memory index
$memoryIndex = @"
# $ProjectName Memory Index

Project-specific knowledge and decisions.

## Key Decisions

_To be populated as development proceeds_

## Architecture Notes

_To be populated during planning phase_

## Implementation Notes

_To be populated during implementation_

## Lessons Learned

_To be populated throughout development_
"@

$memoryFile = Join-Path $memoryPath "index.md"
Set-Content -Path $memoryFile -Value $memoryIndex

Write-Log "Created memory index" -Level Success

Write-Log "Project context initialized successfully!" -Level Success

# Output JSON for programmatic use
if ($Json) {
    $output = @{
        status = "success"
        project = $ProjectName
        root = $ProjectRoot
        context_dir = $contextPath
        personas_dir = $personasPath
        tasks_dir = $tasksPath
        memory_dir = $memoryPath
    } | ConvertTo-Json

    Write-Host $output
}
