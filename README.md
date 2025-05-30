# dotfiles

## Prerequisites

Linux:

- Git must be installed

	```sh
  # e.g. ubuntu
	sudo apt update && sudo apt upgrade -y
	sudo apt install -y build-essential curl git
	```

Windows:

- Git must be installed

	```ps1
	winget install Git.Git --source winget
	```

- VC++ Runtime

	Check if already installed

	```ps1
	winget list --id Microsoft.VCRedist.2015+.x64
	```

	Install

	```ps1
	winget install Microsoft.VCRedist.2015+.x64 --source winget
	```

- [PowerShell 7](https://learn.microsoft.com/ja-jp/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7?view=powershell-7.4) or later

	```ps1
	winget install --id Microsoft.PowerShell --source winget
	```

## How to use

1. Clone this repository to the home directory.

1. Check the packages to be installed and comment them out if necessary.

    - dotfiles/version_manager/Brewfile
    - dotfiles/version_manager/mise/config.toml

1. Run the install script.

    Linux:

    ```sh
    cd ~/dotfiles/bin
    # If you want to do a partial setup, run `./setup.sh` to see how to use it.
    ./setup.sh all
    ```

    Windows:

    ```ps1
    cd ~/dotfiles/bin
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    # If you want to do a partial setup, run `./setup.ps1` to see how to use it.
    ./setup.ps1 all
    ```

## Remind

- Build from scratch as much as possible.

- Be aware of extensibility and portability.  
  Always be aware of tool dependency. Emphasize pure functionality.

- Don't forget to improve the environment.  
  Regularly refer to other dotfiles and incorporate them.

