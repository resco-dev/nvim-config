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
    end,
}
