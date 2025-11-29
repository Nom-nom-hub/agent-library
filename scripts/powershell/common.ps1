# Common functions for Agent Library scripts

# Colors for output
$Colors = @{
    Reset = "`e[0m"
    Red = "`e[0;31m"
    Green = "`e[0;32m"
    Yellow = "`e[1;33m"
    Blue = "`e[0;34m"
}

# Logging functions
function Write-Log {
    param([string]$Message, [ValidateSet("Info", "Success", "Warning", "Error")][string]$Level = "Info")
    
    switch ($Level) {
        "Info" { Write-Host "$($Colors.Blue)ℹ$($Colors.Reset) $Message" }
        "Success" { Write-Host "$($Colors.Green)✓$($Colors.Reset) $Message" }
        "Warning" { Write-Host "$($Colors.Yellow)⚠$($Colors.Reset) $Message" }
        "Error" { Write-Host "$($Colors.Red)✗$($Colors.Reset) $Message" -ForegroundColor Red }
    }
}

function Invoke-Command {
    param([scriptblock]$ScriptBlock, [string]$Description)
    
    Write-Log "Running: $Description" -Level Info
    try {
        & $ScriptBlock
    }
    catch {
        Write-Log "Command failed: $($_.Exception.Message)" -Level Error
        exit 1
    }
}

function Test-CommandExists {
    param([string]$Command)
    
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

# Export functions
Export-ModuleMember -Function Write-Log, Invoke-Command, Test-CommandExists
