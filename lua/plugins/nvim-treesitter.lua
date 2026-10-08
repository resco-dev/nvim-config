
-- Tree-sitter syntax highlighting for Neovim 0.11.
-- Put this file in: lua/plugins/nvimtreesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- compatible with Neovim 0.11; upstream main requires 0.12+
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").compilers = { "cl" }
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "rust", "lua", "toml" },
        highlight = { enable = true },
        auto_install = true,
      })
    end,
  },
}
