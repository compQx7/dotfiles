local copilotchat = {
	'CopilotC-Nvim/CopilotChat.nvim',
	dependencies = {
		{ 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
		{ 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
	},
	config = function()
		local select = require('CopilotChat.select')
		require('CopilotChat').setup({
			debug = false,

			window = {
				layout = 'float',
				relative = 'editor',
				width = 0.8,
				height = 0.8,
			},
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        reset = {
          normal = '<C-l>',
          insert = '<C-l>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-s>',
        },
			},
			prompts = {
				Explain = {
					prompt = '/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。',
				},
				Review = {
					prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。',
					callback = function(response, source) end,
				},
				Fix = {
					prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。',
				},
				Refactor = {
					prompt = '/COPILOT_GENERATE 拡張性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。',
				},
				BetterNamings = {
					prompt = '/COPILOT_GENERATE 選択されたコードの変数名や関数名を改善してください。日本語で返答ください。',
				},
				Optimize = {
					prompt = '/COPILOT_REFACTOR 選択されたコードを最適化してパフォーマンスと可読性を向上させてください。',
				},
				Docs = {
					prompt = '/COPILOT_DOCS 選択されたコードに対してドキュメンテーションコメントを追加してください。',
				},
				Tests = {
					prompt = '/COPILOT_TESTS 選択されたコードの詳細な単体テスト関数を書いてください。',
				},
				Summarize = {
					prompt = '/COPILOT_GENERATE 選択範囲の要約を書いてください。日本語で返答ください。',
				},
				FixDiagnostic = {
					prompt = 'ファイル内の次のような診断上の問題を解決してください:',
					selection = select.diagnostics,
				},
				Commit = {
					prompt = '変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。',
					selection = select.gitdiff,
				},
				CommitStaged = {
					prompt = '変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。',
					selection = function(source)
						local select = require('CopilotChat.select')
						return select.gitdiff(source, true)
					end,
				},
			},
		})

		vim.api.nvim_create_user_command('CopilotChatBuffer', function()
			local input = vim.fn.input('Quick Chat: ')
			if input ~= '' then
				require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
			end
		end, {})

		vim.api.nvim_create_user_command('ShowCopilotChatActionPrompt', function()
			local actions = require('CopilotChat.actions')
			require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
		end, {})
	end,
}

return copilotchat

