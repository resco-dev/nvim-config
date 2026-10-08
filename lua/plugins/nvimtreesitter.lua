-- Tree-sitter for Neovim 0.12+ and lazy.nvim.
-- Put this file in: lua/plugins/nvimtreesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- nvim-treesitter does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      require("nvim-treesitter").install({ "rust", "lua", "toml" })

      -- Neovim 0.12 provides the highlighting engine. Guard the start so a
      -- Rust buffer opened before its parser finishes installing won't error.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "rust", "lua", "toml" },
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
