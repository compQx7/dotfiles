Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias lg lazygit
# Set-Alias make mingw32-make

function repo {
    $selection = ghq list -p | fzf
    if ([string]::IsNullOrWhiteSpace($selection)) {
        Write-Output "No selection made. Exiting."
        return
    }
    cd $selection
}

function repocode {
    $selection = ghq list -p | fzf
    if ([string]::IsNullOrWhiteSpace($selection)) {
        Write-Output "No selection made. Exiting."
        return
    }
    code $selection
}

function repovi {
    $selection = ghq list -p | fzf
    if ([string]::IsNullOrWhiteSpace($selection)) {
        Write-Output "No selection made. Exiting."
        return
    }
    cd $selection
	nvim .
}

function viconf {
	cd $env:LOCALAPPDATA/nvim; vim .
}

