-- Use Space as the leader key
vim.g.mapleader = " "

-- Install lazy.nvim the first time Neovim starts
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--Disable built-in netrw explorer as per nvim-tree recommendations
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Install and configure plugins
require("lazy").setup({
  { import = "plugins" }, --loads lua/plugins/*.lua
}, {
	rocks = { enabled = false },
})

-- Show line numbers and the current line's number
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces instead of tabs; indent by 4 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Search as you type; ignore case unless you use a capital letter
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep some context visible near the edges of the screen
vim.opt.scrolloff = 8

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Show whitespace at the end of lines
vim.opt.list = true

-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Save undo history between Neovim sessions
vim.opt.undofile = true

