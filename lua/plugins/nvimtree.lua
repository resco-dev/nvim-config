return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      sync_root_with_cwd = true,
      actions = {
          change_dir = {
              enable = true,
              global = true,
          },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        api.map.on_attach.default(bufnr)

        vim.keymap.set("n", "<Tab>", function()
            api.node.open.no_window_picker()
            api.tree.open()
        end, {
            buffer = bufnr,
            desc = "Open file and stay in tree",
            silent = true,
        })
    end,
    },
    init = function()
        -- Save expanded folders when exiting Neovim
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                require("tree_state").save()
            end,
        })

        -- Open the tree on startup
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                if vim.fn.argc() ~= 0 then
                    return
                end

                vim.schedule(function()
                    local tree = require("nvim-tree.api").tree
                    local state = require("tree_state")

                    if not tree.is_visible() then
                        tree.toggle({
                            path = vim.fn.getcwd(),
                            focus = false,
                        })
                    end

                    -- Restore the current workspace's tree
                    local name = state.current_workspace()

                    if name and tree.is_visible() then
                        tree.change_root(vim.fn.getcwd())
                        state.restore(name)
                    end
                end)
            end,
        })
    end,
  },
}
