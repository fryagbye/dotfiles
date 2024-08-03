return {
  "lukas-reineke/indent-blankline.nvim", -- Indent guides
  main = "ibl",
  event = "VimEnter",
  config = function()
    require("ibl")
  end,
}
