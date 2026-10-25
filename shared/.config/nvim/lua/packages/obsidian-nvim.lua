vim.pack.add{
    {
        src = 'https://github.com/obsidian-nvim/obsidian.nvim',
        version = vim.version.range '*', -- uses latest release version
    },
}

local obsidian = require('obsidian')
obsidian.setup({
    legacy_commands = false, -- remove after release 4.0.0
    -- define paths to all obsidian vaults
    workspaces = {
        {
            name = 'nr5m',
            path = '~/documents/nr5m',
        },
    },

    -- daily note plugin config
    daily_notes = {
        enabled = true,
        folder = "98-journal",
        date_format = "YYYY/MM-MMMM/YYYY-MM-DD-dddd",
    },
})

-- Only define keymap within the scope of obsidian notes
vim.api.nvim_create_autocmd("User", {
    pattern = "ObsidianNoteEnter",
    callback = function(ev)
        vim.keymap.set({'n', 'x'}, '<leader>l', '<cmd>Obsidian link<CR>', { desc = '[L]ink to an obsidian note.' })
    end,
})


-- Define creating a note as a global keybind.
vim.keymap.set({'n', 'x'}, '<leader>nn', '<cmd>Obsidian new<CR>', { desc = 'Create a [n]ew obsidian [n]ote.' })
vim.keymap.set({'n', 'x'}, '<leader>no', '<cmd>Obsidian open<CR>', { desc = '[O]pen an existing obsidian [n]ote.' })
