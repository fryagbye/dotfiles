return {
  require("lspconfig").pylsp.setup({
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391", "E501" },
            maxLineLength = 120,
          },
        },
      },
    },
  }),
}
