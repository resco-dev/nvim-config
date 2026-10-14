-- Function to save tree view folder expension state between workspaces
local M = {}
local api = require("nvim-tree.api")
local file = vim.fn.stdpath("data") .. "/tree-state.json"

local function read_state()
    if vim.fn.filereadable(file) == 0 then
        return {}
    end

    local ok, data = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))
    end)

    return ok and type(data) == "table" and data or {}
end

function M.save()
    local session = require("possession.session").get_session_name()

    if not session or not api.tree.is_visible() then
        return
    end

    local expanded = {}

    local function collect(nodes)
        for _, node in ipairs(nodes or {}) do
            if node.type == "directory" and node.open then
                table.insert(expanded, node.absolute_path)
                collect(node.nodes)
            end
        end
    end

    collect(api.tree.get_nodes())

    local state = read_state()
    state[session] = expanded

    vim.fn.writefile({ vim.json.encode(state) }, file)
end

function M.restore(session)
    local paths = read_state()[session]

    if type(paths) ~= "table" or not api.tree.is_visible() then
        return
    end

    local wanted = {}
    for _, path in ipairs(paths) do
        wanted[path] = true
    end

    api.tree.expand_all(nil, {
        expand_until = function(_, node)
            return wanted[node.absolute_path] == true
        end,
    })
end

return M
