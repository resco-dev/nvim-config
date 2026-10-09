return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "natecraddock/workspaces.nvim",
        -- Required by your <leader>fs mapping.
        {
            "jedrzejboczar/possession.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {},
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({})
        telescope.load_extension("workspaces")
        telescope.load_extension("possession")
    end,
}
