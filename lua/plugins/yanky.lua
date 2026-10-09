return {
    "gbprod/yanky.nvim",
    lazy = false,
    opts = {
        ring = { storage = "shada" },
    },
    config = function(_, opts)
        require("yanky").setup(opts)
        -- Compatibility with the older names in your mapping.lua.
        vim.keymap.set("n", "<Plug>(YankyCycleForward)", "<Plug>(YankyNextEntry)", { remap = true })
        vim.keymap.set("n", "<Plug>(YankyCycleBackward)", "<Plug>(YankyPreviousEntry)", { remap = true })
    end,
}
