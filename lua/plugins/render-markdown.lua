return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        -- Keep rendering active while typing.
        render_modes = { "n", "i", "c" },

        -- Reveal the Markdown source on the line being edited.
        anti_conceal = {
            enabled = true,
        },
    },

    keys = {
        {
            "<leader>mr",
            "<cmd>RenderMarkdown toggle<cr>",
            desc = "Toggle Markdown rendering",
        },
    },
}
