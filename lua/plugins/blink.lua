return {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",

    dependencies = {
        "rafamadriz/friendly-snippets",
    },

    opts = {
        keymap = {
            preset = "enter",
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            menu = {
                border = "rounded",
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,

                window = {
                    border = "rounded",
                    max_width = 60,
                    max_height = 18,
                },
            },
        },

        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },

        fuzzy = {
            implementation = "prefer_rust",
        },

        signature = {
            enabled = true,
        },
    },
}
