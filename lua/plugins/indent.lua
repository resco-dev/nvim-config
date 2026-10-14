return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    opts = {
        indent = {
            char = "│",
            highlight = "IblIndent",
        },

        scope = {
            enabled = true,
            highlight = "IblScope",
            show_start = false,
            show_end = false,
        },
    },

    config = function(_, opts)
        local function set_colors()
            vim.api.nvim_set_hl(0, "IblIndent", {
                fg = "#303235",
                nocombine = true,
            })

            vim.api.nvim_set_hl(0, "IblScope", {
                fg = "#505358",
                nocombine = true,
            })
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = set_colors,
        })

        set_colors()
        require("ibl").setup(opts)
    end,
}
