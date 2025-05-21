# dotfiles-and-scripts

## Windows

### 前提

- Git がインストールされていること
- PowerShell 7 以上

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

Install Homebrew
下記を実行後に Next Step にしたがって PATH を通す

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install tools

```sh
brew install neovim asdf ripgrep fd ghq fzf lazygit git-delta tmux jq yq
```

[asdf getting started](https://asdf-vm.com/guide/getting-started.html)

Clone dotfiles

```sh
ghq get {compQx7/dotfiles}
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/linux/.bashrc ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/.tmux.conf ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/vim/nvim ~/.config
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/git/.gitconfig ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/git/lazygit ~/.config
```

```sh
asdf list all golang
asdf plugin add golang XXXXXX.git
asdf install golang latest
asdf global golang latest
```

## Remind

- 定期的に他の dotfiles を参考に覗いて取り入れてみる。
- tool への依存性は常に意識する。純粋な機能を大切にする。

