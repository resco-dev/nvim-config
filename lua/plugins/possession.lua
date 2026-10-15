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
            nvim_tree = false,
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

            after_load = function(session_name)
                -- Only handle sessions belonging to a workspace
                local name = session_name:match("^workspace%-(.+)$")

                if not name then
                    return
                end

                vim.schedule(function()
                    -- Don't restore an outdated session
                    if require("possession.session").get_session_name()
                        ~= session_name then
                        return
                    end

                    local tree = require("nvim-tree.api").tree
                    local path = vim.fn.getcwd()

                    -- Find the registered workspace directory
                    for _, workspace in ipairs(require("workspaces").get()) do
                        if workspace.name == name then
                            path = workspace.path
                            break
                        end
                    end

                    -- Open the tree without stealing focus
                    if not tree.is_visible() then
                        tree.toggle({
                            path = path,
                            focus = false,
                        })
                    end

                    -- Restore the workspace's tree root and state
                    if tree.is_visible() then
                        tree.change_root(path)
                        require("tree_state").restore(name)
                    end
                end)
            end,
        },
    },
}
