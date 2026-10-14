
local M = {}
local api = require("nvim-tree.api")

local state_file = vim.fn.stdpath("data") .. "/tree-state.json"

local function read_state()
    if vim.fn.filereadable(state_file) == 0 then
        return {}
    end

    local ok, data = pcall(function()
        return vim.json.decode(
            table.concat(vim.fn.readfile(state_file), "\n")
        )
    end)

    return ok and type(data) == "table" and data or {}
end

-- Normalize paths for Windows and macOS
local function normalize(path)
    return vim.fs.normalize(path):gsub("[/\\]+$", ""):lower()
end

-- Find the current workspace
function M.current_workspace()
    local workspaces = require("workspaces")

    local name = workspaces.name()
    if name then
        return name
    end

    -- Fallback for Possession autoload on startup
    local cwd = normalize(vim.fn.getcwd())

    for _, workspace in ipairs(workspaces.get()) do
        if normalize(workspace.path) == cwd then
            return workspace.name
        end
    end

    return nil
end

-- Save expanded directories
function M.save(name)
    name = name or M.current_workspace()

    if not name or not api.tree.is_visible() then
        return
    end

    local expanded = {}

    local function collect(nodes)
        for _, node in ipairs(nodes or {}) do
            if node.open then
                table.insert(expanded, node.absolute_path)
                collect(node.nodes)
            end
        end
    end

    collect(api.tree.get_nodes())

    local state = read_state()
    state[name] = expanded

    vim.fn.writefile({
        vim.json.encode(state),
    }, state_file)
end

-- Restore expanded directories
function M.restore(name)
    name = name or M.current_workspace()

    if not name or not api.tree.is_visible() then
        return
    end

    local expanded = read_state()[name]

    if type(expanded) ~= "table" then
        return
    end

    local wanted = {}

    for _, path in ipairs(expanded) do
        wanted[path] = true
    end

    api.tree.collapse_all()

    api.tree.expand_all(nil, {
        expand_until = function(_, node)
            return wanted[node.absolute_path] == true
        end,
    })
end

return M
