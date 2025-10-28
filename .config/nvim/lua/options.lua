-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Mouse mode
vim.o.mouse = 'a'

-- Mode is in status line
vim.o.showmode = false

-- Shared nvim and os clipboard
vim.schedule(function () vim.o.clipboard = 'unnamedplus' end)

-- Case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- decrease update time
vim.o.updatetime = 250

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

-- cursor
vim.o.cursorline = true

-- keep 10 lines above and below cursor
vim.o.scrolloff = 10

-- no line wrap
vim.o.wrap = false

-- signcolumn show signs instead of line numbers for debugging purposes
vim.o.signcolumn = 'yes'

-- indent broken lines
vim.o.breakindent = true

-- indents
vim.o.shiftwidth = 4
vim.o.tabstop = 4

