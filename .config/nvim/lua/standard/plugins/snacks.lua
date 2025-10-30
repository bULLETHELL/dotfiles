--- File picker, file explorer and much, much more
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = {
        hidden = true,
        ignored = true,
      },
      explorer = {},
      statuscolumn = {},
      ---@class snacks.indent.Config
      indent = {
        animate = {
          enabled = false,
        },
      },
      lazygit = {},
    },
    keys = {
      --- Find
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = '[f]ind [f]iles',
      },
      {
        '<leader>fw',
        function()
          Snacks.picker.grep()
        end,
        desc = '[f]ind [w]ords',
      },
      {
        '<leader>fn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[f]ind [n]eovim config',
      },

      -- Search
      {
        '<leader>sc',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = '[s]earch [c]olorschemes',
      },

      --- Explorer
      {
        '<leader>n',
        function()
          Snacks.explorer()
        end,
        desc = 'Explorer',
      },

      -- Lazygit
      {
        '<leader>lg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Open [l]azy[g]it',
      },
    },
  },
}
