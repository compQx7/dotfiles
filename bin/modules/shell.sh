#!/bin/bash
set -euo pipefail

source ./modules/common.sh

log_info "Setting up shell & terminal..."

link_file "$DOTFILES_DIR/linux/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/linux/.bashrc.d" "$HOME/.bashrc.d"
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

