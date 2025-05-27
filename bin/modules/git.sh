#!/bin/bash
set -euo pipefail

source ./modules/common.sh

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

	log_info "Generating .gitconfig..."
	# Compare with existing .gitconfig
	if [ -f "$GITCONFIG_TARGET" ]; then
		# Check diff if .gitconfig exists
		if ! diff -q "$GITCONFIG_TEMP" "$GITCONFIG_TARGET" > /dev/null; then
			log_error "  ❌ .gitconfig differs from expected merged version."
			log_info "  Showing diff:"
			diff "$GITCONFIG_TEMP" "$GITCONFIG_TARGET"
			log_info "  Update or delete your current .gitconfig and retry."
			exit 1
		else
			log_info "  .gitconfig is up-to-date. No changes needed."
			rm "$GITCONFIG_TEMP"
		fi
	else
		# Place .gitconfig if it doesn't exist.
		mv "$GITCONFIG_TEMP" "$GITCONFIG_TARGET"
		log_info "  .gitconfig created from $CONFIG_TYPE"
	fi
}

log_info "Setting up git..."

mkdir -p "$HOME/.config/git"
generate_gitconfig
link_file "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"
link_file "$DOTFILES_DIR/git/lazygit" "$HOME/.config/lazygit"

