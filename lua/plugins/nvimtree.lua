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
      -- Open the tree on startup when Neovim was started without a file argument
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            require("nvim-tree.api").tree.open()
          end
        end,
        once = true,
      })
    end,
  },
}
