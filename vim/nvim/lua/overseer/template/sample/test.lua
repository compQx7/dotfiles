local find_file_path = require('utils').find_file_path

return {
	name = "pnpm sample",
	builder = function(params)
		return {
			cmd = "pnpm",
			args = { "-F", params.package, "run", "test" },
			-- env = {
			-- 	NODE_ENV = params.node_env or "production", -- 環境変数
			-- },
			cwd = find_file_path("Cargo.toml", false),
			components = {
				{ "default" },
				-- { "on_output_quickfix", open = true },
				-- { "on_result_diagnostics_quickfix", open = true },
				{ "display_duration" },
			},
			-- on_complete = function(task)
			-- 	vim.notify("タスクが完了しました: " .. task.name, vim.log.levels.INFO)
			-- end,
		}
	end,
	params = {
		package = {
			type = "string",
			prompt = "Arguments",
			default = "package_prefix",
			optional = false,
			description = "Which test tot run",
		},
	},
	condition = {
		-- filetype = { "rs" },
		callback = function()
			-- Cargo.toml が存在する場合にのみタスクを有効化
			local path = find_file_path("Cargo.toml", false)
			return path
		end,
	},
}

