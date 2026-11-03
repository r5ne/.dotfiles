-- This section contains configuration about purely visual aspects of neovim.

-- enable 24 bit coloring
vim.opt.termguicolors = true
-- enable highlighting searched for words
vim.opt.hlsearch = true

-- get the colorscheme from the URL provided
vim.pack.add({
    'https://github.com/wnkz/monoglow.nvim',
})
-- enable the colorscheme
vim.cmd.colorscheme('monoglow-lack')
-- remove the background of the colorscheme to match the terminal theme
-- must be done AFTER the colorscheme is applied
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermbg = 'none' })

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
    })
  end,
})
