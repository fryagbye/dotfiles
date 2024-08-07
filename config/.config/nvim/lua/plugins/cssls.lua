return {
  require("lspconfig").cssls.setup({
    settings = {
      css = { validate = true, lint = { validProperties = { "composes" } } },
    },
  }),
}
