-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- レジスターに登録しない
--vim.keymap.set("n", "x", '"_x')
--vim.keymap.set("n", "c", '"_c')
--vim.keymap.set("n", "d", '"_d')

-- 補完表示時のEnterで改行をしない
-- init.lua に以下の設定を追加

-- キーマッピングを設定するための関数
local function set_keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Enterキーのマッピング
set_keymap("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
    or vim.api.nvim_replace_termcodes("<CR>", true, true, true)
end, { expr = true })

-- completeoptの設定
vim.opt.completeopt = { "menuone", "noinsert" }

-- <C-n>キーのマッピング
set_keymap("i", "<C-n>", function()
  return vim.fn.pumvisible() == 1 and vim.api.nvim_replace_termcodes("<Down>", true, true, true)
    or vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
end, { expr = true })

-- <C-p>キーのマッピング
set_keymap("i", "<C-p>", function()
  return vim.fn.pumvisible() == 1 and vim.api.nvim_replace_termcodes("<Up>", true, true, true)
    or vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
end, { expr = true })

-- Tabキーのマッピング
set_keymap("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    -- 補完メニューが表示されている場合
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      -- 補完候補が選択されている場合は補完を確定
      return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
    else
      -- 補完候補が選択されていない場合は次の候補を選択
      return vim.api.nvim_replace_termcodes("<Down>", true, true, true)
    end
  else
    -- 補完メニューが表示されていない場合は通常のタブ動作
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  end
end, { expr = true })

-- Shift-Tabキーのマッピング
set_keymap("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    -- 補完メニューが表示されている場合は前の候補を選択
    return vim.api.nvim_replace_termcodes("<Up>", true, true, true)
  else
    -- 補完メニューが表示されていない場合は通常のShift-Tab動作
    return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
  end
end, { expr = true })

-- dap
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "S-<F11>", require("dap").step_out)
