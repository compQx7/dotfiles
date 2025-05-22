local nightfox = {
	'EdenEast/nightfox.nvim',
	config = function()
		require('nightfox').setup({
			vim.cmd[[colorscheme nightfox]]
			-- vim.cmd[[colorscheme duskfox]]
			-- vim.cmd[[colorscheme nordfox]]
		})
	end,
}

return nightfox

