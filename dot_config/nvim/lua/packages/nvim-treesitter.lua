local languages = require('globals').LANGUAGES

vim.pack.add{
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    data = {
        run = function(_) vim.cmd 'TSUpdate' end,
    },
  },
}

local parsers = {}
for _, config in pairs(languages) do
  if config.parser then
    table.insert(parsers, config.parser)
  end
end

require('nvim-treesitter').install{ parsers }

