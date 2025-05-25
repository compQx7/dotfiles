local keymap = require('utils').keymap

local oil = {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup({
      -- float = {
      -- 	width = 0.9,
      -- 	height = 0.9,
      -- 	border = 'rounded',
      -- 	preview_split = 'right',
      -- },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<Leader>fn'] = {
          function()
            require('telescope.builtin').find_files({
              cwd = require('oil').get_current_dir(),
            })
          end,
          mode = 'n',
          nowait = true,
          desc = 'Find files in the current directory',
        },
        ['<Leader>fa'] = {
          function()
            require('telescope.builtin').live_grep({
              cwd = require('oil').get_current_dir(),
            })
          end,
          mode = 'n',
          nowait = true,
          desc = 'Find files in the current directory',
        },
        ['<C-t>'] = {
          function()
            local curdir = require('oil').get_current_dir()
            if curdir then
              vim.cmd('ToggleTerm dir=' .. curdir)
            end
          end,
          mode = 'n',
          nowait = true,
          desc = 'Open terminal at the current directory',
        },
        ['<Leader>l'] = {
          function()
            require('oil').select()
          end,
          mode = 'n',
          nowait = true,
          desc = 'Open terminal at the current directory',
        },
        ['<Leader>h'] = {
          'actions.parent',
          mode = 'n',
          nowait = true,
          desc = 'Open terminal at the current directory',
        },
      },
    })

    local oil = require('oil')
    keymap('n', '<Space>fe', function()
      -- require('oil').toggle_float()
      oil.open()
    end, { desc = 'Oil current buffer\'s directory' })
    keymap('n', '<Space>fE', function()
      oil.open('.')
    end, { desc = 'Oil .' })
  end,
}

return oil
