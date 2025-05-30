. "$PSScriptRoot\common.ps1"

# Install Scoop if not already installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Log-Info "Installing Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Log-Info "Scoop already installed."
}

# $packageId = "Microsoft.VCRedist.2015+.x64"
# $installed = winget list --id $packageId | Measure-Object
#
# if ($installed.Count -eq 0) {
#     Log-Info "Installing $packageId..."
#     winget install --id $packageId --source winget --accept-package-agreements --accept-source-agreements
# } else {
#     Log-Info "$packageId is already installed. Skipping."
# }

# Install packages via Scoop
Log-Info "Installing packages with Scoop..."
$Scoopfile = "$DOTFILES_DIR\version_manager\scoop-packages.json"
if (Test-Path $Scoopfile) {
	scoop import $Scoopfile
}
