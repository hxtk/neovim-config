local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

local fmtgroup = augroup("format_on_save", {})
-- Protobuf format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.proto",
    callback = function()
        vim.cmd(":%!buf format")
    end,
})

-- JSON format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.json",
    callback = function()
        vim.cmd(":%!jq .")
    end,
})

-- Rust format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.rs",
    callback = function()
        vim.cmd(":%!rustfmt")
    end,
})

-- Python format on save
autocmd("BufWritePost", {
    group = fmtgroup,
    pattern = "*.py",
    callback = function()
        vim.cmd(":silent! !black %")
        vim.cmd(":silent! !ruff check --fix %")
    end,
})

-- Stylua on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.lua",
    callback = function()
        local config = vim.fs.find("stylua.toml", {
            upward = true,
            stop = vim.loop.os_homedir(),
            path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        })[1]
        if config == nil then
            if vim.fn.has("macunix") then
                config = vim.loop.os_homedir() .. "/.config/stylua/stylua.toml"
            else
                config = vim.env.APPDATA .. "\\stylua\\stylua.toml"
            end
        end
        vim.cmd(string.format(":%%!stylua -f '%s' --stdin-filepath '%%' -", config))
    end,
})
