# Common utility functions for PowerShell scripts

$DOTFILES_DIR = Join-Path $HOME "dotfiles"

function Log-Info {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[INFO] $timestamp $Message" -ForegroundColor Green
}

function Log-Warn {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[WARNING] $timestamp $Message" -ForegroundColor Yellow
}

function Log-Error {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[ERROR] $timestamp $Message" -ForegroundColor Red
}

function Command-Exists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# The Link-File function creates a symbolic link from the specified source (Src)
# to the destination (Dest).
# - If Dest is already a symbolic link, it will be overwritten.
# - If Dest is a regular file or directory, it will be skipped.
# - If Dest does not exist, a new symbolic link will be created.
function Link-File {
    param(
        [string]$Src,
        [string]$Dest
    )
    if (Test-Path $Dest) {
        if ((Get-Item $Dest).LinkType) {
            if ((Get-Item $Dest).Target.Replace('\', '/') -eq $Src.Replace('\', '/')) {
                Log-Info "  Symlink $Dest already points to $Src, skipping"
            } else {
                Log-Info "  Overwriting symlink $Dest"
                Remove-Item $Dest
                New-Item -ItemType SymbolicLink -Path $Dest -Target $Src | Out-Null
            }
        } elseif (Test-Path $Dest) {
            Log-Warn "  Skipping $Dest (already exists and is not a symlink)"
        }
    } else {
        Log-Info "  Linking $Dest -> $Src"
        New-Item -ItemType SymbolicLink -Path $Dest -Target $Src | Out-Null
    }
}

