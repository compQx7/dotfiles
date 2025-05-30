. "$PSScriptRoot\common.ps1"

Log-Info "Installing tools via mise..."

if (-not (Get-Command mise -ErrorAction SilentlyContinue)) {
    Log-Error "mise is not installed. Please install it first."
    exit 1
}

Link-File "$DOTFILES_DIR\version_manager\mise" "$HOME\mise"

$shimPath = "$env:LOCALAPPDATA\mise\shims"
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newPath = $currentPath + ";" + $shimPath
[Environment]::SetEnvironmentVariable('Path', $newPath, 'User')

mise install

Log-Info "Installing additional tools with mise-managed npm..."
npm install -g typescript typescript-language-server eslint

Log-Info "Installing additional tools with mise-managed pip..."
python -m pip install python-lsp-server

