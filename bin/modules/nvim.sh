#!/bin/bash
set -euo pipefail

source ./modules/common.sh

log_info "Setting up Neovim..."

if ! command -v nvim >/dev/null 2>&1; then
  log_error "Neovim is not installed. Please install it first." >&2
  exit 1
fi

mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/vim/nvim" "$HOME/.config/nvim"

