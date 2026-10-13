
local function shorten(text)
    text = text or ""

    -- Replace full Windows/Unix paths with filenames
    text = text:gsub("(%a:[\\/][^%s]+)", function(path)
        return "…/" .. (path:match("[^\\/]+$") or path)
    end)

    text = text:gsub("(/[^%s]+/[^%s]+)", function(path)
        return "…/" .. (path:match("[^/]+$") or path)
    end)

    -- Limit message length
    if vim.fn.strchars(text) > 55 then
        text = vim.fn.strcharpart(text, 0, 52) .. "..."
    end

    return text
end

return {
    "j-hui/fidget.nvim",
    version = "*",
    lazy = false,

    opts = {
        progress = {
            display = {
                render_limit = 7,
                done_ttl = 2,

                format_message = function(msg)
                    local default = require("fidget.progress.display")
                        .default_format_message(msg)
                    return shorten(default)
                end,

                format_annote = function(msg)
                    return shorten(msg.title)
                end,
            },
        },

        notification = {
            window = {
                align = "bottom",
                h_align = "right",

                max_width = 40,
                max_height = 4,

                x_padding = 1,
                y_padding = 0,
                winblend = 100,
                normal_hl = "Comment",
            },

            view = {
                line_margin = 0,
                group_separator = "",
            },
        },
    },
}
