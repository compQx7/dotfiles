. "$PSScriptRoot\common.ps1"

Log-Info "Setting up shell & terminal..."

Link-File (Join-Path $DOTFILES_DIR 'windows\WindowsPowerShell') (Join-Path $HOME 'Documents\WindowsPowerShell')
# Link-File (Join-Path $DOTFILES_DIR 'windows\terminal\settings.json') (Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')

