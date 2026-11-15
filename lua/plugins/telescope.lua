return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({})
    end,
}
