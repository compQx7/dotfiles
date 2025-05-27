#!/bin/bash
set -euo pipefail

source ./modules/common.sh

log_info "Installing tools via mise..."

if ! command -v mise >/dev/null 2>&1; then
  log_error "mise is not installed. Please install it first." >&2
  exit 1
fi

mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/version_manager/mise" "$HOME/.config/mise"

mise install

log_info "Installing additional tools with mise-managed npm..."
npm install -g typescript typescript-language-server eslint

log_info "Installing additional tools with mise-managed pip..."
pip install python-lsp-server

