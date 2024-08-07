-- /lua/config/stylelint.lua

local lspconfig = require("lspconfig")

lspconfig.stylelint_lsp.setup({
  filetypes = { "css", "scss", "less" },
  settings = {
    stylelintplus = {},
  },
})
