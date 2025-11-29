# Update agent context based on project state
# Maintains agent-specific knowledge and project decisions

param(
    [string]$ProjectRoot = ".",
    [string]$AgentType = ""
)

$ErrorActionPreference = "Stop"

# Source common functions
. (Join-Path $PSScriptRoot "common.ps1")

Write-Log "Updating agent context for project: $ProjectRoot" -Level Info

# Check if project exists
$agentsDir = Join-Path $ProjectRoot ".agents"
if (-not (Test-Path $agentsDir)) {
    Write-Log "Project directory not found: $ProjectRoot" -Level Error
    exit 1
}

# Helper function to update agent file
function Update-AgentFile {
    param(
        [string]$FilePath,
        [string]$AgentName
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Log "Agent file not found: $FilePath" -Level Warning
        return
    }
    
    Write-Log "Updating context for: $AgentName" -Level Info
    
    # Update timestamp in file if it exists
    if (Test-Path $FilePath) {
        $content = Get-Content -Path $FilePath -Raw
        $updatedContent = $content -replace "Last updated:.*", ("Last updated: $(Get-Date)")
        Set-Content -Path $FilePath -Value $updatedContent
    }
    
    Write-Log "Updated: $AgentName" -Level Success
}

# Update agent contexts
if ([string]::IsNullOrEmpty($AgentType)) {
    # Update all agents
    Write-Log "Updating all agent contexts..." -Level Info
    
    $contextPath = Join-Path $agentsDir "context"
    if (Test-Path $contextPath) {
        Get-ChildItem -Path $contextPath -Filter "*.md" | ForEach-Object {
            $agentName = $_.BaseName
            Update-AgentFile -FilePath $_.FullName -AgentName $agentName
        }
    }
}
else {
    # Update specific agent
    $agentFile = Join-Path $agentsDir "context" "$AgentType.md"
    Update-AgentFile -FilePath $agentFile -AgentName $AgentType
}

Write-Log "Agent context updated" -Level Success

# Read and display project state
$stateFile = Join-Path $agentsDir "context" "state.json"
if (Test-Path $stateFile) {
    $state = Get-Content -Path $stateFile | ConvertFrom-Json
    $phase = $state.phase
    Write-Log "Current project phase: $phase" -Level Info
}
