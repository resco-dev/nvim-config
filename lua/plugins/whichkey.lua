
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        preset = "modern",

        -- Only show shortcuts with descriptions
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,

        -- Floating window
        win = {
            border = "rounded",
            row = math.huge,
            col = math.huge,
            width = 0.38,
            height = { min = 8, max = 0.85 },
            padding = { 0, 1 },
            no_overlap = false,
            title = false,
        },

        -- Compact, single-column layout
        layout = {
            width = { min = 60 },
            spacing = 1,
        },

        -- Show only keys and descriptions
        icons = {
            mappings = true,
            separator = " ",
            group = "",
        },
        show_help = false,
        show_keys = false,
    },

    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps",
        },
    },
}
