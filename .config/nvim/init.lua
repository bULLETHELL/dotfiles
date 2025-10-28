-- Set space as leader key before anything else
vim.g.mapleader = ' '
vim.g.localmapleader = vim.g.mapleader

-- Set to true if Nerd Font is used in terminal
vim.g.have_nerd_font = true

require 'options'

-- lazy bootstrap installs lazy
require 'lazy-bootstrap'

-- lazy plugins
require 'lazy-plugins'
