local fidget = {
  'j-hui/fidget.nvim',
  lazy = false,
  config = function()
    require('fidget').setup({})
  end,
}

return fidget
