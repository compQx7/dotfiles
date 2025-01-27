local plug = {
  'stevearc/overseer.nvim',
	-- dependencies = {
	-- 	'nvim-lua/plenary.nvim',
	-- 	'nvim-telescope/telescope.nvim',
	-- },
	config = function()
		local overseer = require("overseer")

		-- overseer/template 以下にあるフォルダ名一覧を取得
		local function get_template_folders()
			local template_path = vim.fn.stdpath('config') .. '/lua/overseer/template'
			local folders = {}
			for _, folder in ipairs(vim.fn.readdir(template_path)) do
				if vim.fn.isdirectory(template_path .. '/' .. folder) == 1 then
					table.insert(folders, folder)
				end
			end
			return folders
		end
		local templates = get_template_folders()

		overseer.setup({
			templates = {
				'builtin',
				unpack(templates),
			},
			task_list = {
        direction = "right",
        max_width = { 200, 0.8 },
				bindings = {
					["?"] = "ShowHelp",
					-- ["<CR>"] = "RunAction",
					-- ["<C-e>"] = "Edit",
					-- ["o"] = "Open",
					-- ["<C-v>"] = "OpenVsplit",
					-- ["<C-s>"] = "OpenSplit",
					-- ["<C-f>"] = "OpenFloat",
					-- ["<C-q>"] = "OpenQuickFix",
					-- ["p"] = "TogglePreview",
					["L"] = "IncreaseDetail",
					["H"] = "DecreaseDetail",
					["<M-l>"] = "IncreaseAllDetail",
					["<M-h>"] = "DecreaseAllDetail",
					-- ["["] = "DecreaseWidth",
					-- ["]"] = "IncreaseWidth",
					-- ["{"] = "PrevTask",
					-- ["}"] = "NextTask",
				},
			},
		})

		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local tasks = overseer.list_tasks({ recent_first = true })
			if vim.tbl_isempty(tasks) then
				vim.notify("No tasks found", vim.log.levels.WARN)
			else
				overseer.run_action(tasks[1], "restart")
			end
		end, {})

		overseer.register_template({
			name = "PNPM Build with Env",
			builder = function(params)
			return {
				cmd = "pnpm",
				args = { "-F", params.package, "run", "build" },
				-- env = {
				-- 	NODE_ENV = params.node_env or "production", -- 環境変数
				-- },
				components = { "default", "on_output_quickfix" },
			}
			end,
			params = {
				package = { type = "string", name = "Package Name", optional = false },
				-- node_env = { type = "string", name = "Node Env", optional = true },
			},
			description = "Run build with custom NODE_ENV",
		})
	end,
}

return plug

