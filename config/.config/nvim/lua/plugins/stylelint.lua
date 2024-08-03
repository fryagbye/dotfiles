return {
  "bmatcuk/stylelint-lsp",
  require("lspconfig").stylelint_lsp.setup({
    settings = {
      stylelintplus = {
        -- see available options in stylelint-lsp documentation
      },
    },
  }),
}
