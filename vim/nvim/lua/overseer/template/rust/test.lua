local find_file_path = require('utils').find_file_path

return {
	name = 'Cargo Test',
	builder = function(params)
		return {
			cmd = 'cargo',
			args = { 'test' },
			cwd = find_file_path('Cargo.toml', false),
			components = {
				{ 'default' },
				-- { 'on_output_quickfix', open = true },
				-- { 'on_result_diagnostics_quickfix', open = true },
				{ 'display_duration' },
			},
			-- cmd = { 'echo', 'Hello, World!' },
			-- on_complete = function(task)
			-- 	vim.notify('タスクが完了しました: ' .. task.name, vim.log.levels.INFO)
			-- end,
		}
	end,
	condition = {
		-- filetype = { 'rs' },
		callback = function()
			-- Cargo.toml が存在する場合にのみタスクを有効化
			local path = find_file_path('Cargo.toml', false)
			return path
		end,
	},
}

