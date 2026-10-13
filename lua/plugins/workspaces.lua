
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

                -- Open the file explorer
                require("nvim-tree.api").tree.open({
                    path = path,
                    focus = false,
                })

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
