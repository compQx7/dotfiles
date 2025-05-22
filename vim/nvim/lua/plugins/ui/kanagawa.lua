local kanagawa = {
	'rebelot/kanagawa.nvim',
	config = function()
		require('kanagawa').setup({
			vim.cmd[[colorscheme kanagawa-wave]]
			-- vim.cmd[[colorscheme kanagawa-dragon]]
		})
	end,
}

return kanagawa

