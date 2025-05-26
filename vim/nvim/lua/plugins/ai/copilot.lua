local is_vscode = require('utils').is_vscode
-- local copilot = {
-- 	'github/copilot.vim',
-- 	lazy = false,
-- }
local copilot = {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  enabled = not is_vscode(),
  config = function()
    require('copilot').setup({
      copilot_node_command = (function()
        local node_version = tonumber(vim.fn.system('node --version'):match('v(%d+)'))
        if node_version and node_version < 20 then
          print('To use Copilot, the node version is old, so find the path to the latest node.')
          -- Find latest Node version ≥ 20 managed by mise
          local latest_node_path = vim.fn.trim(
            vim.fn.system(
              'mise list node --json | jq -r \'[.[] | select(.version | test("^2[0-9]+"))] | max_by(.version) | .install_path\''
            )
          ) .. '/bin/node'
          print('latest_node_path: ' .. latest_node_path)

          if latest_node_path ~= '' then
            -- local node_major = latest_node_path:match("^%s*(%d+)")
            -- if node_major then
            -- 		local mise_node_path = vim.fn.trim(vim.fn.system("mise which node@" .. node_major .. " 2>/dev/null || echo ''"))
            -- 		if mise_node_path ~= "" then
            -- 				return mise_node_path
            -- 		end
            -- end
            return latest_node_path
          end
        end
        return nil
      end)(),
    })
  end,
}

return copilot
