# install_windows.ps1
$DOTFILES_DIR = (Resolve-Path "$PSScriptRoot/..").Path

# --- Install Scoop ---
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# --- Add Scoop buckets ---
$buckets = @("main", "extras", "versions")
foreach ($bucket in $buckets) {
    if (-not (scoop bucket list | Select-String -Pattern "^$bucket")) {
        scoop bucket add $bucket
    }
}

# --- Install Applications by Scoop ---
$apps = @(
	"gcc",
	"googlechrome",
    # "git",
	"neovim",
	"fzf",
	"lazygit",
	"fd",
	"ripgrep",
	"ghq",
	"gh",
	"7zip",
	"delta"
)
foreach ($app in $apps) {
    if (-not (scoop list | Select-String -Pattern "^$app")) {
        Write-Host "Installing $app..."
        scoop install $app
    }
}

# FUnction that set Symbolic Link
function New-Symlink {
    param (
        [string]$Source,
        [string]$Target
    )

    if (Test-Path $Target) {
        Write-Host "Skipping $Target (already exists)"
    } else {
        Write-Host "Linking $Target -> $Source"
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
    }
}

# --- Set SymbolicLink ---

# Terminal
# $termSrc = Join-Path $DOTFILES_DIR "config\windows\terminal\settings.json"
# $termDest = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
# New-Symlink -Source $termSrc -Target $termDest

# PowerShell Profile ---
$pwshSrc = Join-Path $DOTFILES_DIR "config\windows\WindowsPowerShell" # windows\powershell\Microsoft.PowerShell_profile.ps1
$pwshDest = "$HOME\Documents\WindowsPowerShell" # Documents\PowerShell\Microsoft.PowerShell_profile.ps1
New-Symlink -Source $pwshSrc -Target $pwshDest

# Git
$gitSrc = Join-Path $DOTFILES_DIR "git\.gitconfig"
$gitDest = "$HOME\.gitconfig"
New-Symlink -Source $nvimSrc -Target $nvimDest
# git config --global core.autocrlf true

# NeoVim
$nvimSrc = Join-Path $DOTFILES_DIR "config\common\vim\nvim"
$nvimDest = "$HOME\AppData\Local\nvim"
New-Symlink -Source $nvimSrc -Target $nvimDest

# Lazygit
$lazygitSrc = Join-Path $DOTFILES_DIR "config\common\git\lazygit"
$lazygitDest = "$HOME\AppData\Local\lazygit"
New-Symlink -Source $nvimSrc -Target $nvimDest

# --- Import reg files ---
$regFilePath = Join-Path $DOTFILES_DIR "config\windows\Caps2Ctrl.reg"
if (Test-Path $regFilePath) {
    Write-Host "Importing Caps2Ctrl.reg..."
    Start-Process -FilePath "regedit.exe" -ArgumentList "/s", "`"$regFilePath`"" -Verb RunAs
} else {
    Write-Warning "Caps2Ctrl.reg not found at $regFilePath"
}

