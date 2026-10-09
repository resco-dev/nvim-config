local M = {}

function M.setup(os)
    local dependencies = {
        {
            name = "ripgrep",
            bins = { "rg" },
            windows = "BurntSushi.ripgrep.MSVC",
            macos = "ripgrep",
            apt = "ripgrep",
            dnf = "ripgrep",
            pacman = "ripgrep",
        },
        {
            name = "fd",
            bins = { "fd", "fdfind" },
            windows = "sharkdp.fd",
            macos = "fd",
            apt = "fd-find",
            dnf = "fd-find",
            pacman = "fd",
        },
    }

    -- Check whether a dependency is installed
    local function installed(dep)
        for _, bin in ipairs(dep.bins) do
            if vim.fn.executable(bin) == 1 then
                return true
            end
        end

        return false
    end

    -- Find missing dependencies
    local missing = {}

    for _, dep in ipairs(dependencies) do
        if not installed(dep) then
            table.insert(missing, dep)
        end
    end

    if #missing == 0 then
        return
    end

    -- NixOS: Check only, never install automatically
    local is_nixos = os.nixos
        or (os.linux and vim.fn.filereadable("/etc/NIXOS") == 1)

    if is_nixos then
        local names = {}

        for _, dep in ipairs(missing) do
            table.insert(names, dep.name)
        end

        vim.notify(
            "NixOS: Missing Telescope dependencies: "
                .. table.concat(names, ", ")
                .. "\nAdd them to your NixOS/Home Manager configuration.",
            vim.log.levels.WARN
        )

        return
    end

    -- Detect available package manager
    local function get_manager()
        if os.windows then
            return "windows", "winget"
        elseif os.macos then
            return "macos", "brew"
        elseif os.linux then
            if vim.fn.executable("apt-get") == 1 then
                return "apt", "apt-get"
            elseif vim.fn.executable("dnf") == 1 then
                return "dnf", "dnf"
            elseif vim.fn.executable("pacman") == 1 then
                return "pacman", "pacman"
            end
        end

        return nil, nil
    end

    local manager, executable = get_manager()

    if not manager or vim.fn.executable(executable) == 0 then
        vim.notify(
            "Telescope: No supported package manager found",
            vim.log.levels.WARN
        )
        return
    end

    -- Construct installation command
    local command = {}

    if manager == "windows" then
        local commands = {}

        for _, dep in ipairs(missing) do
            table.insert(
                commands,
                "winget install --id "
                    .. dep.windows
                    .. " --exact"
                    .. " --accept-package-agreements"
                    .. " --accept-source-agreements"
            )
        end

        command = {
            "cmd.exe",
            "/c",
            table.concat(commands, " && "),
        }
    else
        local packages = {}

        for _, dep in ipairs(missing) do
            table.insert(packages, dep[manager])
        end

        if manager == "macos" then
            command = { "brew", "install", "--no-ask" }
        elseif manager == "apt" then
            command = { "sudo", "apt-get", "install", "-y" }
        elseif manager == "dnf" then
            command = { "sudo", "dnf", "install", "-y" }
        elseif manager == "pacman" then
            command = { "sudo", "pacman", "-S", "--needed" }
        end

        vim.list_extend(command, packages)
    end

    -- Install missing dependencies in an interactive terminal
    vim.schedule(function()
        local names = {}

        for _, dep in ipairs(missing) do
            table.insert(names, dep.name)
        end

        vim.notify(
            "Telescope: Installing " .. table.concat(names, ", "),
            vim.log.levels.INFO
        )

        vim.cmd("botright 12split")

        vim.fn.termopen(command, {
            on_exit = function(_, exit_code)
                vim.schedule(function()
                    if exit_code == 0 then
                        vim.notify(
                            "Telescope dependencies installed. "
                                .. "Restart Neovim if necessary.",
                            vim.log.levels.INFO
                        )
                    else
                        vim.notify(
                            "Telescope dependency installation failed "
                                .. "(exit code " .. exit_code .. ")",
                            vim.log.levels.ERROR
                        )
                    end
                end)
            end,
        })

        vim.cmd("startinsert")
    end)
end

return M
