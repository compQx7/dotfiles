#!/usr/bin/env bash
set -euo pipefail

# The link_file function creates a symbolic link from the specified source (src)
# to the destination (dest).
# - If dest is already a symbolic link, it will be overwritten.
# - If dest is a regular file or directory, it will be skipped.
# - If dest does not exist, a new symbolic link will be created.
link_file() {
	src=$1
	dest=$2

	if [ -L "$dest" ]; then
		if [ "$(readlink "$dest")" = "$src" ]; then
			echo "  Symlink $dest already points to $src, skipping"
		else
			echo "  Overwriting symlink $dest"
			rm "$dest"
			ln -s "$src" "$dest"
		fi
	elif [ -e "$dest" ]; then
		echo "  Skipping $dest (already exists and is not a symlink)"
	else
		echo "  Linking $dest → $src"
		ln -s "$src" "$dest"
	fi
}

# --- Initialize ---
DOTFILES_DIR="$HOME/dotfiles"

echo "Starting dotfiles install."
echo "Dotfiles directory: $DOTFILES_DIR"

# --- Install Homebrew ---
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
	echo "Homebrew already installed."
fi

# --- Install tools by Homebrew ---
echo "Installing packages with Homebrew..."
brew bundle --no-upgrade --file="$DOTFILES_DIR/bin/Brewfile"

# --- Making Symlink ---

mkdir -p "$HOME/.config"

# Bash
link_file "$DOTFILES_DIR/linux/.bashrc" "$HOME/.bashrc"

# mise
link_file "$DOTFILES_DIR/mise" "$HOME/.config/mise"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/.gitignore" "$HOME/.gitignore"
link_file "$DOTFILES_DIR/git/lazygit" "$HOME/.config/lazygit"
# git config --global core.autocrlf input

# Tmux
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
link_file "$DOTFILES_DIR/vim/nvim" "$HOME/.config/nvim"

# --- Complete ---
echo "dotfiles installation complete!"

