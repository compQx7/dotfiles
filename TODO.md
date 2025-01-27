# TODO

- wsl中心に使うので、react, rust, go, python, のtest, lsp, task runner 環境を整える。
- gh でリポジトリ検索、ghq で取得、リポジトリ調査環境
- wsl の ~/.config
- windows のターミナルの設定ファイル
- git の設定ファイルでショートカット（ex. sta: status, sw: switch)

- signature tree は lspsaga で代用できる？
- telescope の代替として fzf-lua を検討
- 候補選択を tab で行うのはやめる
- space は分かりやすくしたい（indent-blankline が邪魔している？）
- WSL2設定ファイルの管理
- wsl の ~/.config で他に管理するものある？

- 初期化スクリプト作成
  - 実行しなくとも手順書になる

- Git環境
  - diffview のみやすさ向上
  - vscode git graph のように複数ブランチの動きや進んでいるリモートブランチを把握したい
    - `git log --all` +a
  - 数コミット前からの変更を左側に表示したい
    - Gitsigns の changebase が巨大リポジトリでうまくいかない
      - diffview も同様

- プロジェクトごとに追加プラグインや追加設定ができると良い
  - dotfiles にセットを用意するか、プロジェクトルートに設定を配置

- 必要な debug 機能
  - break point
    - 条件付き break point もあると良い
    - テストコードにも break point を設定できると良い
  - callstack
  - 変数の値を確認

- js環境
  - import をコードアクションで補完したい
  - jestのテストを個別に実行したい
  - フロントエンド用の設定を on/off できるようにしたい
- プロジェクト全体での置換
- 汎用的なdiffを見たい。.diffファイルを開けないか。

- linterの検討, aleとの比較
  - mfussenegger/nvim-lint

- main branch
  - keymap 一か所にするなど統一
  - `'` -> `"`
  - keymap description
  - Japanese -> English

- fold の活用
- quickfix の活用
- window separate の活用

- git workflow
  - DiffviewXxxx
  - GitSigns による hunk 操作
  - LazyGit による commit 操作
  - Telescope による Git 操作
  - gh コマンドなどによるレビュー

## plugin

- cssの色表現 norcalli/nvim-colorizer.lua
- 折り畳みを見やすく anuvyklack/pretty-fold.nvim
- 折り畳みを開かずプレビュー anuvyklack/fold-preview.nvim

