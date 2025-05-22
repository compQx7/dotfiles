-- local is_windows = vim.loop.os_uname().sysname == 'Windows'
-- local is_vscode = vim.fn.exists('g:vscode') == 1
local is_vscode = require('utils').is_vscode

require('core.options')
require('core.autocmds')
require('core.keymaps')

if vim.loop.os_uname().sysname == 'Windows_NT' then
	local pwsh_options = {
		shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
		shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
		shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
		shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
		shellquote = '',
		shellxquote = '',
	}

	for k, v in pairs(pwsh_options) do
		vim.opt[k] = v
	end
end

if not is_vscode then
	require('plugins/lazy')
	require('plugins/keymaps')
end

