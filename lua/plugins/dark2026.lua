return {
    "code-2026-theme/nvim",
    name = "code-2026",
    lazy = false,
    priority = 1000,

    config = function()
        require("code-2026").setup({
            background = "dark",
        })

        vim.cmd.colorscheme("dark-2026")

        -- Rust / LSP inlay hints
        vim.api.nvim_set_hl(0, "LspInlayHint", {
            fg = "#808080",
            bg = "NONE",
            italic = true,
        })
    end,
}
