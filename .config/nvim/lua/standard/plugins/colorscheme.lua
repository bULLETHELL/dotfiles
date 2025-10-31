return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable:missing-fields
      require('gruvbox').setup {
        italic = {
          strings = false,
        },
      }
      vim.o.background = 'dark'
      vim.cmd 'colorscheme gruvbox'
    end,
  },
}
