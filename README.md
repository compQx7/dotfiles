# dotfiles

## Prerequisites

- Git must be installed

```sh
# e.g. ubuntu
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl git
```

Windows only:

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
    ./install.sh
    ```

    Windows:

    ```ps1
    ```

## Remind

- Be aware of extensibility and portability.  
  Always be aware of tool dependency. Emphasize pure functionality.

- Don't forget to improve the environment.  
  Regularly refer to other dotfiles and incorporate them.

