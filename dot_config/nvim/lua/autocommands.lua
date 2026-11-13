local languages = require('globals').LANGUAGES

local active_filetypes = vim.tbl_keys(languages)

-- Set up all formatters to trigger on <leader>f
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

-- Set up .desktop LSP via desktop-file-validate CLI tool
local namespace = vim.api.nvim_create_namespace("desktop_validator")
local DIAG_ERROR = vim.diagnostic.severity.ERROR
local DIAG_WARN = vim.diagnostic.severity.WARN
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.desktop",
  callback = function(args)
    local file = vim.fn.expand("%:p")
    
    vim.system({"desktop-file-validate", file}, { text = true }, function(obj)
      local diagnostics = {}
      if obj.code ~= 0 then
        local output = obj.stdout .. (obj.stderr or "")
        for line in output:gmatch("[^\r\n]+") do
          local lnum, severity_str, msg = line:match(":(%d+):%s*(%a+):%s*(.*)")
          if not lnum then
            severity_str, msg = line:match(":%s*(%a+):%s*(.*)")
            lnum = 1
          end
          if severity_str and msg then
            local severity = severity_str == "error" and DIAG_ERROR or DIAG_WARN
            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = 0,
              severity = severity,
              message = msg,
              source = "desktop-file-validate"
            })
          end
        end
      end

      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(args.buf) then return end
        if obj.code == 0 then
          vim.diagnostic.reset(namespace, args.buf)
        else
          vim.diagnostic.set(namespace, args.buf, diagnostics)
        end
      end)
    end)
  end,
})
