
return {
    "jedrzejboczar/possession.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    init = function()
        vim.opt.sessionoptions:remove({
            "terminal",
            "buffers",
        })
        vim.opt.sessionoptions:append("blank")
    end,

    opts = {
        silent = true,
        load_silent = true,
        autosave = {
            current = true,
            on_load = false,
            on_quit = true,
        },

        plugins = {
            close_windows = false,
            delete_hidden_buffers = false,
        },
    },
}
