local plug = {
	'nvimdev/lspsaga.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter', -- optional
		'nvim-tree/nvim-web-devicons',     -- optional
	},
	config = function()
		require('lspsaga').setup({
			symbol_in_winbar = {
				enable = false,
			},
		})
	end,
}

return plug

