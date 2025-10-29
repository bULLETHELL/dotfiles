-- Clear highlights from search on pressing escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close buffer
vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- Don't lose visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
