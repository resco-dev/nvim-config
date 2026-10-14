return {
    "jedrzejboczar/possession.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    init = function()
        vim.opt.sessionoptions:remove("terminal")
        vim.opt.sessionoptions:append({ "buffers", "blank" })
    end,

    opts = {
        silent = true,
        load_silent = true,

        autosave = {
            current = true,
            on_load = false,
            on_quit = true,
        },

        autoload = "last",

        plugins = {
            close_windows = false,
            delete_hidden_buffers = false,
            delete_buffers = false,
        },

        hooks = {
            before_load = function(_, user_data)
                local buffers = {}

                -- Collect normal file buffers only
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_valid(buf)
                        and vim.bo[buf].buftype == "" then

                        -- Protect unsaved changes
                        if vim.bo[buf].modified then
                            vim.notify(
                                "Save modified files before switching sessions",
                                vim.log.levels.WARN
                            )
                            return nil
                        end

                        table.insert(buffers, buf)
                    end
                end

                -- Delete file buffers, leaving terminals alone
                for _, buf in ipairs(buffers) do
                    local ok, err = pcall(
                        vim.api.nvim_buf_delete,
                        buf,
                        { force = false }
                    )

                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                        return nil
                    end
                end

                return user_data or {}
            end,
        },
    },
}
