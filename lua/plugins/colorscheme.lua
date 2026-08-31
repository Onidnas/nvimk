return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        treesitter = true,
        telescope = true,
        mason = true,
        barbar = true,
        nvimtree = true,
        blink_cmp = true,
      },
    })
    vim.cmd.colorscheme("catppuccin-nvim")
  end,
}
