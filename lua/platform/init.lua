local M = {}

-- Detect operating system
local uname = vim.uv.os_uname()

M.os = {
    name = uname.sysname,
    version = uname.version,
    release = uname.release,
    machine = uname.machine,

    windows = vim.fn.has("win32") == 1,
    macos = vim.fn.has("mac") == 1,
    linux = uname.sysname == "Linux",
}

-- Detect NixOS separately from other Linux distributions
M.os.nixos = M.os.linux
    and vim.fn.filereadable("/etc/NIXOS") == 1

-- Locate this module's directory
local source = debug.getinfo(1, "S").source:sub(2)
local directory = vim.fn.fnamemodify(source, ":h")

-- Discover and execute platform modules
local setup_started = false

function M.setup()
    if setup_started then
        return
    end

    setup_started = true

    local files = vim.fn.globpath(directory, "*.lua", false, true)

    table.sort(files)

    for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")

        -- Skip ourselves
        if name ~= "init" then
            local ok, module = pcall(
                require,
                "platform." .. name
            )

            if not ok then
                vim.notify(
                    "Failed to load platform module: "
                        .. name .. "\n" .. tostring(module),
                    vim.log.levels.ERROR
                )

            elseif type(module) == "table"
                and type(module.setup) == "function" then

                local success, err = pcall(module.setup, M.os)

                if not success then
                    vim.notify(
                        "Platform setup failed: "
                            .. name .. "\n" .. tostring(err),
                        vim.log.levels.ERROR
                    )
                end
            end
        end
    end
end

return M
