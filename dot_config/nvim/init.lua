-- utility for other configs
require('util')
-- non-plugin keymaps
require('keymap')
-- visual config
require('theme')
-- plugins
require('packages')
-- formatters
require('autocommands')

-- relative line numbers except on the current line
vim.opt.number = true 
vim.opt.relativenumber = true

-- disable wrapping when line is too long
vim.opt.wrap = false

-- set default tab width (in spaces)
vim.opt.tabstop = 4
-- set default shift width (when indenting and unindenting whole lines)
vim.opt.shiftwidth = 4
-- autoconvert tabs to spaces
vim.opt.expandtab = true

-- stop autocommenting new lines underneath comments
vim.cmd('autocmd BufEnter * set formatoptions-=ro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=ro')

-- don't create backup files
vim.opt.backup = false
-- disable unsaved file recovery
vim.opt.swapfile = false
-- enable persistent undos
vim.opt.undofile = true

-- make searching case-insensitive
vim.opt.ignorecase = true
-- make searching case-sensitive when capitalisation used
vim.opt.smartcase = true

