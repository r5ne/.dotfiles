local M = {}

M.LANGUAGES = {
  -- programming languages
  cpp    = { parser = "cpp", formatter = "clang-format --style=file", lsp = "clangd" },
  c      = { parser = "c", formatter = "clang-format --style=file", lsp = "clangd" },
  python = { parser = "python", formatter = "ruff format", lsp = {
      "ruff",
      { name = "basedpyright", settings = { basedpyright = { disableLanguageServices = true } } }
  } },
  asm    = { parser = "asm" },

  -- scripting languages
  lua    = { parser = "lua", formatter = "stylua" },
  bash   = { parser = "bash" },
  css    = { parser = "css" },
  html   = { parser = "html", formatter = "superhtml fmt",  lsp = "superhtml" },
  htmldjango = { parser = "htmldjango", formatter = "superhtml fmt", lsp = { "superhtml", "djls" } },

  -- config languages
  ini    = { parser = "ini" },
  yaml   = { parser = "yaml" },
  json   = { parser = "json" },
}

return M
