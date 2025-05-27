#!/bin/bash
set -euo pipefail

source ./modules/common.sh

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
	log_info "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
	log_info "Homebrew already installed."
fi

# Install packages via Homebrew
log_info "Installing packages with Homebrew..."
brew bundle --no-upgrade --file="$DOTFILES_DIR/version_manager/Brewfile"

