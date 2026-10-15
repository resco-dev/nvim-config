
return {
    "natecraddock/workspaces.nvim",
    lazy = false,
    dependencies = { "jedrzejboczar/possession.nvim" },

    opts = {
        cd_type = "global",

        hooks = {
            -- Save the existing workspace before switching
            open_pre = function()
                local current = require("workspaces").name()

                if current then
                    -- Save current workspace expanded folders
                    require("tree_state").save(current)

                    -- Save current workspace editor layout and buffers
                    require("possession.session").save(
                        "workspace-" .. current,
                        { no_confirm = true }
                    )
                end
            end,
            -- Load the destination workspace

            open = function(name, path)
                local session = require("possession.session")
                local session_name = "workspace-" .. name
                local exists = session.exists(session_name)

                -- Restore saved editor layout
                if exists then
                    session.load(session_name)
                end

                -- Open the file explorer if it isn't already open
                local tree = require("nvim-tree.api").tree

                if not tree.is_visible() then
                    tree.open({
                        path = path,
                        focus = false,
                    })
                end

                -- Always set the tree root to the workspace directory
                tree.change_root(path)

                -- Restore previously expanded folders
                require("tree_state").restore(name)

                -- Check whether an editing pane exists
                local has_editor = false

                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local buf = vim.api.nvim_win_get_buf(win)

                    if vim.bo[buf].buftype == ""
                        and vim.bo[buf].filetype ~= "NvimTree" then
                        has_editor = true
                        break
                    end
                end

                -- Create an empty editor pane if necessary
                if not has_editor then
                    vim.cmd("botright vnew")
                end

                -- Save newly created workspaces
                if not exists then
                    session.save(session_name, {
                        no_confirm = true,
                    })
                end
            end,
        },
    },
}
