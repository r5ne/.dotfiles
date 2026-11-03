vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

-- parse the languages global and enable the given lsps
local languages = require('globals').LANGUAGES
local lsps = {}

for _, lang_config in pairs(languages) do
  if lang_config.lsp then
    -- Normalize single string/table to a list
    local servers = (vim.islist or vim.tbl_islist)(lang_config.lsp) 
                    and lang_config.lsp 
                    or { lang_config.lsp }

    for _, server in ipairs(servers) do
      if type(server) == "string" then
        -- Case 1: Simple string -> Just enable (uses built-in/lspconfig defaults)
        vim.lsp.enable(server)
      elseif type(server) == "table" then
        -- Case 2: Table -> Configure first, then enable
        -- We clone the table to avoid modifying the global config, removing 'name'
        local opts = vim.deepcopy(server)
        opts.name = nil 
        
        vim.lsp.config(server.name, opts)
        vim.lsp.enable(server.name)
      end
    end
  end
end
vim.lsp.enable(lsps)

-- keymap
local map = vim.keymap.set
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { 
      buffer = event.buf, 
      desc = '[G]o to [D]efinition' 
    })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { 
      buffer = event.buf, 
      desc = '[R]e[n]ame' 
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { 
      buffer = event.buf, 
      desc = 'Qui[c]k [a]tions' 
    })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { 
      buffer = event.buf, 
      desc = 'View documentation' 
    })
  end,
})
