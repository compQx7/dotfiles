local indentblankline = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('ibl').setup({
      scope = { show_start = true },
    })
  end,
}

return indentblankline
