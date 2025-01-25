local plug = {
	'nvim-zh/colorful-winsep.nvim',
	event = { 'WinLeave' },
	config = function()
		require('colorful-winsep').setup({
			hi = {
				bg = '',
				fg = '#E8AEAA',
			},
		})
	end,
}

return plug

