local toggleterm = {
	'akinsho/toggleterm.nvim',
	lazy = false,
	config = function()
		require('toggleterm').setup({
			open_mapping = [[<C-t>]],
			start_in_insert = true,
			insert_mappings = false,
			persist_size = true,
			direction = 'float',
		})
	end,
}

return toggleterm

