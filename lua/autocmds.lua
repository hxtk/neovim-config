local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

local fmtgroup = augroup("format_on_save", {})
-- Protobuf format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.proto",
    callback = function()
        local v = vim.fn.winsaveview()
        vim.cmd(":%!buf format")
        vim.fn.winrestview(v)
    end,
})

-- JSON format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.json",
    callback = function()
        local v = vim.fn.winsaveview()
        vim.cmd(":%!jq .")
        vim.fn.winrestview(v)
    end,
})

-- Rust format on save
autocmd("BufWritePre", {
    group = fmtgroup,
    pattern = "*.rs",
    callback = function()
        local v = vim.fn.winsaveview()
        vim.cmd(":%!rustfmt")
        vim.fn.winrestview(v)
    end,
})

-- Python format on save
autocmd("BufWritePost", {
    group = fmtgroup,
    pattern = "*.py",
    callback = function()
        local v = vim.fn.winsaveview()
        vim.cmd(":silent! !black %")
        vim.cmd(":silent! !ruff check --fix %")
        vim.fn.winrestview(v)
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
        local v = vim.fn.winsaveview()
        vim.cmd(string.format(":%%!stylua -f '%s' --stdin-filepath '%%' -", config))
        vim.fn.winrestview(v)
    end,
})
