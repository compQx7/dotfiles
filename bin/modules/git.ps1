. "$PSScriptRoot\common.ps1"

function Generate-GitConfig {
    # ENV
    $ConfigType = $env:DOTFILES_OS_TYPE
    if (-not $ConfigType) { $ConfigType = "windows" }
    $GitConfigBase = "$DOTFILES_DIR\git\.gitconfig"
    $GitConfigEnv = "$DOTFILES_DIR\git\.gitconfig.$ConfigType"
    $GitConfigTarget = "$HOME\.gitconfig"
    $GitConfigTemp = "$env:TEMP\.gitconfig"

    # Merge .gitconfig files
    Get-Content $GitConfigBase, $GitConfigEnv | Set-Content $GitConfigTemp

    Log-Info "Generating .gitconfig..."

    # Compare with existing .gitconfig
    if (Test-Path $GitConfigTarget) {
        $diff = Compare-Object (Get-Content $GitConfigTemp) (Get-Content $GitConfigTarget)
        if ($diff) {
            Log-Error "  ❌ .gitconfig differs from expected merged version."
            Log-Info "  Showing diff:"
            $diff | Format-Table
            Log-Info "  Update or delete your current .gitconfig and retry."
            exit 1
        } else {
            Log-Info "  .gitconfig is up-to-date. No changes needed."
            Remove-Item $GitConfigTemp
        }
    } else {
        # Place .gitconfig if it doesn't exist.
        Move-Item $GitConfigTemp $GitConfigTarget
        Log-Info "  .gitconfig created from $ConfigType"
    }
}

Log-Info "Setting up git..."

Generate-GitConfig
Link-File "$DOTFILES_DIR\git\ignore" "$HOME\.gitignore"
Link-File "$DOTFILES_DIR\git\lazygit" "$env:LOCALAPPDATA\lazygit"
