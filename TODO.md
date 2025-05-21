# TODO

## dotfiles 運用

- 初期化スクリプト作成
  - 実行しなくとも手順書になる(README.md 削減)

- WSL2設定ファイルの管理
  - wsl の ~/.config で他に管理するものある？
  - `C:\Users\masa\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
    - GUIDはdotfiles管理に入れてよい？
  - /etc/wsl.conf
- .Brewfile

## Task for main branching

- keymap description
- Japanese -> English

## nvim

- isolate lazy code (plugin file should be write only plugin config)
- neovim in vscode + keymaps.json
- neovim 0.11 + update lsp setting
- mise + manage the lsp
- add `mise.local.toml` in global gitignore
- react, rust, go, python, のtest, lsp, task runner 環境を整える。
  - js環境
    - import をコードアクションで補完したい
    - jestのテストを個別に実行したい
    - フロントエンド用の設定を on/off できるようにしたい

- sql file is treated as binary in git
- 候補選択を tab で行うのはやめる
- space は分かりやすくしたい（indent-blankline が邪魔している？）
- プロジェクト全体での置換
- 汎用的なdiffを見たい。.diffファイルを開けないか。

- Git環境
  - diffview のみやすさ向上
  - 数コミット前からの変更を左側に表示したい
    - Gitsigns の changebase が巨大リポジトリでうまくいかない
      - diffview も同様
- gh でリポジトリ検索、ghq で取得、リポジトリ調査環境

- git workflow
  - DiffviewXxxx
  - GitSigns による hunk 操作
  - LazyGit による commit 操作
  - Telescope による Git 操作
  - gh コマンドなどによるレビュー

### debug

必要な debug 機能

- break point
  - 条件付き break point もあると良い
  - テストコードにも break point を設定できると良い
- callstack
- 変数の値を確認

### plugin

- telescope の代替として fzf-lua を検討
- cssの色表現 norcalli/nvim-colorizer.lua
- 折り畳みを見やすく anuvyklack/pretty-fold.nvim
- 折り畳みを開かずプレビュー anuvyklack/fold-preview.nvim
- linterの検討, aleとの比較
  - mfussenegger/nvim-lint

### survey

- fold の活用
- quickfix の活用
- window separate の活用

