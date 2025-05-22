# dotfiles-and-scripts

## Windows

### Prerequisites

- Git must be installed
- PowerShell 7 or later

[PowerShell 7](https://learn.microsoft.com/ja-jp/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7?view=powershell-7.4)

```ps1
winget install --id Microsoft.PowerShell --source winget
```

1. Clone this repository.
2. Run the install script.

## Linux

### NeoVim

Update & Install basics

```sh
# e.g. ubuntu
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl git
```

Clone dotfiles

```sh
ghq get {compQx7/dotfiles}
ln -s ~/dotfiles/linux/.bashrc ~
ln -s ~/dotfiles/.tmux.conf ~
ln -s ~/dotfiles/git/.gitconfig ~
mkdir ~/.config
ln -s ~/dotfiles/vim/nvim ~/.config
ln -s ~/dotfiles/git/lazygit ~/.config
ln -s ~/dotfiles/mise ~/.config
```

```sh
asdf list all golang
asdf plugin add golang XXXXXX.git
asdf install golang latest
asdf global golang latest
```

## Remind

- Always be aware of tool dependency. Emphasize pure functionality.
- Regularly refer to other dot files and incorporate them.

