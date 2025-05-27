#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

log_info() {
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo -e "[\e[32mINFO\e[0m] $timestamp $*" >&2
}
log_warn() {
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo -e "[\e[33mWARNING\e[0m] $timestamp $*" >&2
}
log_error() {
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo -e "[\e[31mERROR\e[0m] $timestamp $*" >&2
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

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

