local map = vim.keymap.set

-- map leader key for custom keybinds
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- pressing escape after searching clears the highlighted matches
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- :update only writes the file if the contents have changed
-- :source executes the commands in the file specified
map({'n', 'v'}, '<leader>o', ':update<CR>:source $MYVIMRC<CR>', { desc = 'S[o]urce neovim config' })

map({'n', 'v'}, '<leader>w', ':update<CR>', { desc = '[W]rite the current file' })
map({'n', 'v'}, '<leader>q', ':quit<CR>', { desc = '[Q]uit' })
map({'n', 'v'}, '<leader>Q', ':quit!<CR>', { desc = 'Discard changes and [q]uit' })
map({'n', 'v'}, '<leader>x', ':exit<CR>', { desc = 'E[x]it: Write and quit' })

-- insert line below cursor without entering insert mode
map({'n', 'v'}, '<CR>', 'o<Esc>')
-- insert line above cursor without entering insert mode
map({'n', 'v'}, '<S-CR>', 'O<Esc>')

