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

# generate_gitconfig merges the base and environment-specific .gitconfig files,
# compares the result with the current ~/.gitconfig, and updates or warns as needed.
# - Uses $DOTFILES_OS_TYPE (default: linux) to select the environment config.
# - If ~/.gitconfig exists and differs from the merged result, shows a diff and exits with error.
# - If ~/.gitconfig does not exist, creates it from the merged config.
generate_gitconfig() {
	# ENV
	CONFIG_TYPE="${DOTFILES_OS_TYPE:-linux}"
	GITCONFIG_BASE="$DOTFILES_DIR/git/.gitconfig"
	GITCONFIG_ENV="$DOTFILES_DIR/git/.gitconfig.$CONFIG_TYPE"
	GITCONFIG_TARGET="$HOME/.gitconfig"
	GITCONFIG_TEMP="/tmp/.gitconfig"

	# Merge .gitconfig files
	cat "$GITCONFIG_BASE" "$GITCONFIG_ENV" > "$GITCONFIG_TEMP"

	echo "Generating .gitconfig"
	# Compare with existing .gitconfig
	if [ -f "$GITCONFIG_TARGET" ]; then
		# Check diff if .gitconfig exists
		if ! diff -q "$GITCONFIG_TEMP" "$GITCONFIG_TARGET" > /dev/null; then
			echo "  ❌ .gitconfig differs from expected merged version."
			echo "  Showing diff:"
			diff "$GITCONFIG_TEMP" "$GITCONFIG_TARGET"
			echo "  Update or delete your current .gitconfig and retry."
			exit 1
		else
			echo "  .gitconfig is up-to-date. No changes needed."
			rm "$GITCONFIG_TEMP"
		fi
	else
		# Place .gitconfig if it doesn't exist.
		mv "$GITCONFIG_TEMP" "$GITCONFIG_TARGET"
		echo "  .gitconfig created from $CONFIG_TYPE"
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
brew bundle --no-upgrade --file="$DOTFILES_DIR/version_manager/Brewfile"

# --- Install tools by mise ---
mise install

# --- Making Symlink ---

mkdir -p "$HOME/.config"

# Bash
link_file "$DOTFILES_DIR/linux/.bashrc" "$HOME/.bashrc"

# mise
link_file "$DOTFILES_DIR/version_manager/mise" "$HOME/.config/mise"

# Git
generate_gitconfig
link_file "$DOTFILES_DIR/git/.gitignore" "$HOME/.gitignore"
link_file "$DOTFILES_DIR/git/lazygit" "$HOME/.config/lazygit"

# Tmux
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
link_file "$DOTFILES_DIR/vim/nvim" "$HOME/.config/nvim"

# --- Complete ---
echo "dotfiles installation complete!"

