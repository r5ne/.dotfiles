local languages = require('globals').LANGUAGES

local active_filetypes = vim.tbl_keys(languages)

vim.api.nvim_create_autocmd("FileType", {
  pattern = active_filetypes,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local config = languages[ft]
    
    if not config then return end

    -- treesitter (syntax highlighting)
    if config.parser then
      pcall(vim.treesitter.start)
    end

    -- formatter keybind <space>f
    if config.formatter then
      vim.bo[args.buf].equalprg = config.formatter
      
      vim.keymap.set("n", "<leader>f", function()
        local view = vim.fn.winsaveview()
        vim.cmd("normal! gggqG")
        vim.fn.winrestview(view)
      end, { buffer = args.buf, desc = "Format File" })
end
  end,
})
