local keymap = require('utils').keymap

local bufferline = {
	'akinsho/bufferline.nvim',
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup({})
		keymap('n', '<C-n>', '<cmd>BufferLineCycleNext<CR>', { desc = '' })
		keymap('n', '<C-p>', '<cmd>BufferLineCyclePrev<CR>', { desc = '' })
		keymap('n', '<Leader>bp', '<cmd>BufferLineTogglePin<CR>', { desc = '' })
		keymap('n', '<Leader>bs', '<cmd>BufferLineSortByRelativeDirectory<CR>', { desc = '' })
		keymap('n', '<Leader>bco', '<cmd>BufferLineCloseOthers<CR>', { desc = '' })
		keymap('n', '<Leader>bcr', '<cmd>BufferLineCloseRight<CR>', { desc = '' })
		keymap('n', '<Leader>bcl', '<cmd>BufferLineCloseLeft<CR>', { desc = '' })
	end,
}

return bufferline

