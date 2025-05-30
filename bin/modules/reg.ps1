. "$PSScriptRoot\common.ps1"

Log-Info "Importing registry settings..."

# # --- Import reg files ---
$regFilePath = Join-Path $DOTFILES_DIR "windows\Caps2Ctrl.reg"
if (Test-Path $regFilePath) {
    Log-Info "Importing Caps2Ctrl.reg..."
    Start-Process -FilePath "regedit.exe" -ArgumentList "/s", "`"$regFilePath`"" -Verb RunAs
} else {
    Log-Warn "Caps2Ctrl.reg not found at $regFilePath"
}

