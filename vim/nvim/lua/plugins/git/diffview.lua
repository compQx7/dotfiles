local diffview = {
	'sindrets/diffview.nvim',
	lazy = false,
	config = function()
		local actions = require('diffview.actions')
		require('diffview').setup({
			show_help_hints = false,
			file_panel = {
				listing_style = "tree", -- One of 'list' or 'tree'
				tree_options = {
					flatten_dirs = true,
					folder_statuses = "never", -- One of 'never', 'only_folded' or 'always'.
				},
				win_config = {
					position = 'bottom',
					height = 10,
					win_opts = {},
				},
			},
			keymaps = {
				file_panel = {
					{ 'n', 'e', actions.goto_file_edit, { desc = 'Open the file' }},
					{ 'n', 's', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' }},
				},
			},
		})
	end,
	keys = {
		{ mode = 'n', '<Leader>hh', '<cmd>DiffviewOpen HEAD<CR>' },
		{ mode = 'n', '<Leader>hf', '<cmd>DiffviewFileHistory %<CR>' },
		{ mode = 'n', '<Leader>hc', '<cmd>DiffviewClose<CR>' },
		{ mode = 'n', '<Leader>hd', '<cmd>Diffview<CR>' },
	}
}

return diffview

