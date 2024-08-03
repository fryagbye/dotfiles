return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    toggle_key = "<C-p>",
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
  init = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        --local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp_signature").on_attach({}, buffer)
      end,
    })
  end,
}
