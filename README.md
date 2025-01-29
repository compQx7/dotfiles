# dotfiles-and-scripts

## Windows

Scoop

```sh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

```sh
Scoop install git 7zip neovim fzf delta
scoop install vscode nvm
```

### NeoVim

```sh
# 管理者権限でコマンドプロンプトを開いて以下を実行する
mklink /d %USERPROFILE%\AppData\Local\nvim %USERPROFILE%\ghq\github.com\compQx7\dotfiles\vim\nvim\
```

### PowerShell

```sh
# 管理者権限でコマンドプロンプトを開いて以下を実行する
mklink /d %USERPROFILE%\Documents\WindowsPowerShell %USERPROFILE%\ghq\github.com\compQx7\dotfiles\windows\WindowsPowerShell
```

### other

lazygit
```sh
mklink /d %USERPROFILE%\AppData\Local\lazygit %USERPROFILE%\ghq\github.com\compQx7\dotfiles\git\lazygit\
```

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
brew install neovim asdf ripgrep fd ghq peco lazygit git-delta tmux
```

[asdf getting started](https://asdf-vm.com/guide/getting-started.html)

Clone dotfiles

```sh
ghq get {compQx7/dotfiles}
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/linux/.bashrc ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/.tmux.conf ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/vim/nvim ~/.config
# [include]
#     path = .gitconfig.common
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/git/.gitconfig.common ~
sudo ln -s ~/ghq/github.com/compQx7/dotfiles/git/lazygit ~/.config
```

```sh
asdf list all golang
asdf plugin add golang XXXXXX.git
asdf install golang latest
asdf global golang latest
```

