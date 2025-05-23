local tokyonight = {
  'folke/tokyonight.nvim',
  config = function()
    require('tokyonight').setup({
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    })
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}

return tokyonight
