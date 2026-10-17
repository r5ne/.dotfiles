-- adds a configurable start screen
vim.pack.add({
    'https://github.com/nvim-mini/mini.starter',
})
local starter = require('mini.starter')
starter.setup({
    items = {
        starter.sections.recent_files()
    },
})

-- go back to the home screen
vim.keymap.set({'n', 'x'}, '<leader>h', '<cmd>lua MiniStarter.open()<CR>', { desc = 'Go to the [h]ome screen' })
