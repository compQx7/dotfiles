VerticalLayout1 = {
	layout_strategy = 'vertical',
	layout_config = {
		height = 0.99,
		preview_height = 0.6,
		vertical = {
			mirror = true, -- Toggle window to top/bottom
		},
	},
	winblend = 20,
}
VerticalLayout2 = {
	layout_strategy = 'vertical',
	layout_config = {
		height = 0.99,
		preview_height = 0.6,
		vertical = {
			mirror = true, -- Toggle window to top/bottom
		},
	},
	winblend = 20,
	file_ignore_patterns = {
		-- TODO: Is this the correct escape notation?
		'^.git',
		-- '.cache',
		'node_modules',
	},
	vim_grep_arguments = {
		'rg',
		'--color=never',
		'--no-heading',
		'--with-filename',
		'--line-number',
		'--column',
		'--smart-case',
		'-uu',
	},
	path_display = {
		filename_first = {
			reverse_directories = true,
		},
	},
	-- path_display = function(opts, path)
	-- 	local tail = require('telescope.utils').path_tail(path)
	-- 	return string.format('%s (%s)', tail, path)
	-- end,
}

local telescope = {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- {
		-- 	'nvim-telescope/telescope-fzf-native.nvim',
		-- 	build = 'make',
		-- },
		-- 'nvim-telescope/telescope-file-browser.nvim',
	},
	cmd = 'Telescope',
	-- lazy = false,
	config = function()
		require('telescope').setup({
			defaults = {
				layout_strategy = 'vertical',
				-- cache_picker = {
				-- 	num_pickers = 1,
				-- },
			},
			pickers = {
				find_files = VerticalLayout2,
				live_grep = VerticalLayout1,
				current_buffer_fuzzy_find = VerticalLayout1,
				buffers = VerticalLayout2,
			},
			extensions = {
				-- fzf = {
				-- 	fuzzy = true,
				-- 	override_generic_sorter = true,
				-- 	override_file_sorter = true,
				-- 	case_mode = 'smart_case',
				-- },
			-- Compare with oil (Easy to add/delete, move/copy, needs customization for LSP)
			-- 	file_browser = {
			-- 		theme = 'ivy',
			-- 		-- disables netrw and use telescope-file-browser in its place
			-- 		hijack_netrw = true,
			-- 		mappings = {
			-- 			['i'] = {
			-- 				-- your custom insert mode mappings
			-- 				-- ['<C-h>'] = require('telescope').extensions.file_browser.actions.goto_parent_dir,
			-- 				-- ['<C-l>'] = require('telescope').extensions.file_browser.actions.open_dir,
			-- 			},
			-- 			['n'] = {
			-- 				-- your custom normal mode mappings
			-- 			},
			-- 		},
			-- 	},
			},
		})
		-- require('telescope').load_extension('file_browser')
		-- require('telescope').load_extension('fzf')

		-- local function myresume(picker_title)
		-- 	local cached_pickers = require('telescope.state').get_global_key('cached_pickers')
		-- 	if not cached_pickers then
		-- 		return
		-- 	end
		-- 	for i, picker in pairs(cached_pickers) do
		-- 		if picker.prompt_title == picker_title then
		-- 			return i
		-- 		end
		-- 	end
		-- 	return
		-- end
		-- function _G.find_files_or_resume()
		-- 	local index = myresume('Find Files')
		-- 	if index ~= nil then
		-- 		builtin.resume({ cache_index = index })
		-- 	else
		-- 		builtin.find_files()
		-- 	end
		-- end

		-- function _G.live_grep_in_directory()
		-- 	local directory_path = vim.fn.input('Search path: ', '', 'file')
		-- 	if directory_path then
		-- 		builtin.live_grep({ cwd = directory_path })
		-- 	else
		-- 		print('No directory specified.')
		-- 	end
		-- end
		-- vim.keymap.set('n', '<Leader>fd', '<cmd>lua live_grep_in_directory()<CR>', { noremap = true, silent = true })

		-- vim.keymap.set('n', '<leader>fb', function()
		-- 	builtin.buffers {
		-- 		attach_mappings = function(_, map)
		-- 			map('i', '<C-d>', function(prompt_bufnr)
		-- 				local actions = require('telescope.actions')
		-- 				local state = require('telescope.actions.state')
		-- 				local selection = state.get_selected_entry()
		-- 				actions.close(prompt_bufnr)
		-- 				vim.cmd('bdelete ' .. selection.bufnr)
		-- 				builtin.buffers()
		-- 			end)
		-- 			return true
		-- 		end,
		-- 	}
		-- end, { desc = 'Manage buffers' })
	end,
}

return telescope

