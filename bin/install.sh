#!/usr/bin bash

set -u  # 未定義の変数使用をエラーにする (任意)
set -e  # エラーが起きたらスクリプトを終了する (任意)

# --- 初期設定 ---
# DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"
OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

# 既存ファイルのバックアップ先ディレクトリ
BACKUP_DIR="$HOME/dotfiles_backup"

echo "🔧 Starting dotfiles install for Linux with Homebrew"
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# --- Install Homebrew ---
if ! command -v brew &>/dev/null; then
	echo "🍺 Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
	echo "🍺 Homebrew already installed."
fi

# --- Install packages by Homebrew ---
echo "📦 Installing packages with Homebrew..."

brew_packages=(
	git
	zsh
	curl
	neovim
	fzf
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

# # リンクを張りたい設定ファイルのリスト
# FILES=(
# 	"bashrc"
# 	"vimrc"
# 	"gitconfig"
# 	# 必要に応じて追加
# )
#
# # バックアップディレクトリがなければ作成
# mkdir -p "$BACKUP_DIR"
#
# for file in "${FILES[@]}"; do
# 	# 実際にリンクしたいファイル (リポジトリ側)
# 	target="$DOTFILES_DIR/$file"
# 	# ホームディレクトリに置く際のファイル名 (.付加)
# 	link_name="$HOME/.$file"
#
# 	# 既にシンボリックリンクが存在するか？
# 	if [ -L "$link_name" ]; then
# 		# リンク先が正しいかどうかを確認
# 		actual_target="$(readlink "$link_name")"
# 		if [ "$actual_target" = "$target" ]; then
# 			echo "[INFO] .$file: 既に正しいシンボリックリンクが張られています。スキップします。"
# 		else
# 			echo "[WARN] .$file: 異なるシンボリックリンクが存在するため削除します。"
# 			rm "$link_name"
# 			ln -s "$target" "$link_name"
# 			echo "[INFO] .$file: 新たにシンボリックリンクを作成しました。"
# 		fi
#
# 	# シンボリックリンクでなく、物理的なファイル/ディレクトリが存在する場合
# 	elif [ -e "$link_name" ]; then
# 		echo "[WARN] .$file: 既存のファイル/ディレクトリがあるためバックアップディレクトリに移動します。"
# 		mv "$link_name" "$BACKUP_DIR"
# 		ln -s "$target" "$link_name"
# 		echo "[INFO] .$file: シンボリックリンクを作成しました。"
#
# 	else
# 		# ファイルも存在しない (新規にシンボリックリンクを作成可能)
# 		echo "[INFO] .$file: シンボリックリンクを作成します。"
# 		ln -s "$target" "$link_name"
# 		echo "[INFO] .$file: シンボリックリンクを作成しました。"
# 	fi
# done

# --- シンボリックリンク関数 ---
link_file() {
	src=$1
	dest=$2

	if [ -e "$dest" ] || [ -L "$dest" ]; then
		echo "  ↪ Skipping $dest (already exists)"
	else
		echo "  🔗 Linking $dest → $src"
		ln -s "$src" "$dest"
	fi
}

# --- 共通設定（git, starship） ---
echo "🔗 Linking common configs..."

mkdir -p "$HOME/.config"
link_file "$CONFIG_DIR/common/gitconfig" "$HOME/.gitconfig"

# --- zsh 設定 ---
# echo "🔗 Linking zsh configs..."
# mkdir -p "$HOME/.config/zsh"
# link_file "$CONFIG_DIR/linux/zsh/.zshrc" "$HOME/.zshrc"

# --- Neovim 設定 ---
echo "🔗 Linking Neovim configs..."
mkdir -p "$HOME/.config"
link_file "$CONFIG_DIR/linux/nvim" "$HOME/.config/nvim"

# --- 完了 ---
echo "✅ Linux (Homebrew) dotfiles installation complete!"

