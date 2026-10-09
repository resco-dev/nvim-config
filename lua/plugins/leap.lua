return {
    url = "https://codeberg.org/andyg/leap.nvim.git",
    name = "leap.nvim",
    lazy = false,
    dependencies = { "tpope/vim-repeat" },
    config = function()
        -- Compatibility with the older names in your mapping.lua.
        vim.keymap.set("o", "<Plug>(leap-forward-x)", "<Plug>(leap-forward-till)", { remap = true })
        vim.keymap.set("o", "<Plug>(leap-backward-x)", "<Plug>(leap-backward-till)", { remap = true })
    end,
}
