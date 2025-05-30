. "$PSScriptRoot\common.ps1"

Log-Info "Setting up Neovim..."

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Log-Error "Neovim is not installed. Please install it first."
    exit 1
}

Link-File "$DOTFILES_DIR\vim\nvim" "$env:LOCALAPPDATA\nvim"

