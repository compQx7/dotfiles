local aerial = {
	'stevearc/aerial.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons'
	},
	config = function()
		require('aerial').setup({
			layout = {
				default_direction = 'prefer_right',
			},
      keymaps = {
        ['<CR>'] = 'actions.jump',
        ['l'] = 'actions.jump',
			},
		})
	end,
}

return aerial

