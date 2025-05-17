-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- 日本語ヘルプ
opt.helplang = { "ja", "en" }

-- 参考　https://zenn.dev/arrow2nd/articles/aa2605c67efdb0#%E6%9C%AC%E4%BD%93%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3

-- 文字コード
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 24bit color
opt.termguicolors = true

-- 不可視文可視化
opt.list = true
opt.listchars = { tab = ">>", trail = "-", nbsp = "+" }

opt.history = 512

-- 補完
opt.completeopt = "menuone,noinsert"

-- LSPの警告フォーマット
-- ref: https://dev.classmethod.jp/articles/eetann-change-neovim-lsp-diagnostics-format/
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- vim.lsp.set_log_level("debug")
