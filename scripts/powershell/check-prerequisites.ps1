# Check prerequisites for Agent Library projects
# Verifies that required tools are installed and accessible

param(
    [switch]$Verbose = $false
)

$ErrorActionPreference = "Stop"

# Source common functions
. (Join-Path $PSScriptRoot "common.ps1")

Write-Log "Checking prerequisites for Agent Library..." -Level Info

$missingTools = 0
$optionalTools = 0

# Helper functions
function Test-Tool {
    param(
        [string]$ToolName,
        [string]$Description,
        [switch]$Required = $false
    )
    
    try {
        $tool = Get-Command $ToolName -ErrorAction SilentlyContinue
        if ($tool) {
            $version = & $ToolName --version 2>$null | Select-Object -First 1
            if (-not $version) { $version = "installed" }
            Write-Log "Found: $Description ($version)" -Level Success
            return $true
        }
    }
    catch { }
    
    if ($Required) {
        Write-Log "Missing: $Description (required)" -Level Error
        $script:missingTools++
    }
    else {
        Write-Log "Not found: $Description (optional)" -Level Warning
        $script:optionalTools++
    }
    
    return $false
}

Write-Host ""
Write-Log "Required Tools:" -Level Info
Test-Tool "python" "Python 3.11+" -Required
Test-Tool "git" "Git version control" -Required

Write-Host ""
Write-Log "Optional Tools (AI Agents):" -Level Info
Test-Tool "claude" "Claude Code CLI"
Test-Tool "gemini" "Gemini CLI"
Test-Tool "cursor-agent" "Cursor"
Test-Tool "amp" "Amp"
Test-Tool "qwen" "Qwen Code"

Write-Host ""
if ($missingTools -gt 0) {
    Write-Log "$missingTools required tool(s) missing" -Level Error
    exit 1
}
else {
    Write-Log "All required tools are available" -Level Success
}

if ($optionalTools -gt 0) {
    Write-Log "$optionalTools optional tool(s) not found" -Level Warning
    Write-Log "Consider installing at least one AI agent" -Level Info
}
else {
    Write-Log "All optional tools are available" -Level Success
}

Write-Log "Prerequisites check complete!" -Level Success
