param(
    [Parameter(Mandatory = $false)]
    [ValidateSet("all", "shell", "reg", "git", "scoop", "mise", "nvim")]
    [string]$Target
)

. "$PSScriptRoot\modules\common.ps1"

function Show-Usage {
    Write-Host "Usage: ./setup.ps1 -Target <target>"
    Write-Host ""
    Write-Host "Available targets:"
    Write-Host "  all       Set up all components"
    Write-Host "  shell     Set up shell and terminal configurations"
    Write-Host "  reg       Import registry settings (e.g., Caps2Ctrl)"
    Write-Host "  git       Set up Git configurations"
    Write-Host "  scoop     Install Scoop packages"
    Write-Host "  mise      Install tools via mise"
    Write-Host "  nvim      Set up Neovim and related dependencies"
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  ./setup.ps1 -Target all"
    exit 1
}

function Run-Install {
    param([string]$Target)
    $ScriptDir = "$DOTFILES_DIR\bin"

    switch ($Target) {
        "all" {
            & "$ScriptDir\modules\shell.ps1"
            & "$ScriptDir\modules\reg.ps1"
            & "$ScriptDir\modules\git.ps1"
            & "$ScriptDir\modules\scoop.ps1"
            & "$ScriptDir\modules\mise.ps1"
            & "$ScriptDir\modules\nvim.ps1"
        }
        "shell" {
            & "$ScriptDir\modules\shell.ps1"
        }
        "reg" {
            & "$ScriptDir\modules\reg.ps1"
        }
        "git" {
            & "$ScriptDir\modules\git.ps1"
        }
        "scoop" {
            & "$ScriptDir\modules\scoop.ps1"
        }
        "mise" {
            & "$ScriptDir\modules\mise.ps1"
        }
        "nvim" {
            & "$ScriptDir\modules\shell.ps1"
            & "$ScriptDir\modules\scoop.ps1"
            & "$ScriptDir\modules\mise.ps1"
            & "$ScriptDir\modules\nvim.ps1"
        }
        Default {
            Log-Error "Unknown target: $Target"
            Show-Usage
        }
    }
}

if (-not $Target) {
    Log-Error "Missing required target argument."
    Show-Usage
}

Run-Install -Target $Target

