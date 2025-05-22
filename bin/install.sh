#!/usr/bin bash

# Error when using undefined variables
# Exit the script if an error occurs
set -ue

# --- Initialize ---
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"
BACKUP_DIR="$HOME/dotfiles_backup"

echo "Starting dotfiles install for Linux with Homebrew"
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

# --- Install packages by Homebrew ---
echo "Installing packages with Homebrew..."

brew_packages=(
	git
	zsh
	curl
	mise
	neovim
	fzf
	ripgrep
	fd
	ghq
	lazygit
	git-delta
	tmux
	jq
	yq
	unzip
	starship
)

for pkg in "${brew_packages[@]}"; do
	if ! brew list "$pkg" &>/dev/null; then
		echo "  ➤ Installing $pkg"
		brew install "$pkg"
	else
		echo "  ✓ $pkg already installed"
	fi
done

# # A list of configuration files to link to
# FILES=(
# 	"bashrc"
# 	"vimrc"
# 	"gitconfig"
# )
#
# # Create the backup directory if it does not exist.
# mkdir -p "$BACKUP_DIR"
#
# for file in "${FILES[@]}"; do
# 	# The actual file I want to link (in the repository)
# 	target="$DOTFILES_DIR/$file"
# 	# Link name
# 	link_name="$HOME/.$file"
#
# 	# Does the symbolic link already exist?
# 	if [ -L "$link_name" ]; then
# 		# Check if the link is correct
# 		actual_target="$(readlink "$link_name")"
# 		if [ "$actual_target" = "$target" ]; then
# 			echo "[INFO] .$file: Correct symlink already exists. Skip."
# 		else
# 			echo "[WARN] .$file: There is a different symbolic link, so delete it."
# 			rm "$link_name"
# 			ln -s "$target" "$link_name"
# 			echo "[INFO] .$file: Created a new symbolic link."
# 		fi
#
# 	# If a physical file/directory exists, not a symbolic link
# 	elif [ -e "$link_name" ]; then
# 		echo "[WARN] .$file: Move to the backup directory since it has existing files/directories."
# 		mv "$link_name" "$BACKUP_DIR"
# 		ln -s "$target" "$link_name"
# 		echo "[INFO] .$file: Created a symbolic link."
#
# 	else
# 		echo "[INFO] .$file: Create a symbolic link."
# 		ln -s "$target" "$link_name"
# 		echo "[INFO] .$file: Created a symbolic link."
# 	fi
# done

link_file() {
	src=$1
	dest=$2

	if [ -e "$dest" ] || [ -L "$dest" ]; then
		echo "  Skipping $dest (already exists)"
	else
		echo "  Linking $dest → $src"
		ln -s "$src" "$dest"
	fi
}

# --- Common Settings ---
echo "Linking common configs..."

# Git
mkdir -p "$HOME/.config"
link_file "$CONFIG_DIR/common/gitconfig" "$HOME/.gitconfig"
git config --global core.autocrlf input

# --- Neovim ---
echo "Linking Neovim configs..."
mkdir -p "$HOME/.config"
link_file "$CONFIG_DIR/linux/nvim" "$HOME/.config/nvim"

# --- Complete ---
echo "Linux (Homebrew) dotfiles installation complete!"

