local is_vscode = require('utils').is_vscode
local get_browser_path = require('utils').get_browser_path

local plug = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  enabled = not is_vscode(),
  config = function()
    local browser = get_browser_path()
    print("Using browser: " .. browser)
    vim.cmd(string.format([[
      function! OpenBrowserWSL(url)
        call system('"%s" ' . a:url)
      endfunction
    ]], browser))
    vim.g.mkdp_browserfunc = "OpenBrowserWSL"
  end,
}

return plug

