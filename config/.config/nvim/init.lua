-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local bkey = vim.api.nvim_buf_set_keymap

-- Lazygit起動時にESCを無効化する
vim.api.nvim_create_augroup("LazygitKeyMapping", {})
-- ⚠️TermEnterでは起動されたバッファではなく、起動したバッファが対象になってしまう
vim.api.nvim_create_autocmd("TermOpen", {
  group = "LazygitKeyMapping",
  pattern = "*",
  callback = function()
    local filetype = vim.bo.filetype
    -- filetypeにはlazygitが渡る。空文字ではない
    if filetype == "lazygit" then
      -- このkeymapが肝。なんでこれで動くのかは謎
      bkey(0, "t", "<ESC>", "<ESC>", { silent = true })
      -- <C-\><C-n>がNeovimとしてのESC。<ESC>はLazygitが奪う
      bkey(0, "t", "<C-v><ESC>", [[<C-\><C-n>]], { silent = true })
    end
  end,
})

require("config.stylelint")
