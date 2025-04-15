local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
    setup = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client:supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
                    vim.keymap.set("i", "<c-n>", function()
                        vim.lsp.completion.get()
                    end)
                end
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, {})
            end,
        })
        vim.lsp.enable("buf_ls")
        vim.lsp.config("buf_ls", {
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format()
                        end,
                    })
                end
            end,
            settings = {
                filetypes = { "proto" },
            },
        })
        vim.lsp.enable("clangd")
        vim.lsp.config("clangd", {
            settings = {
                filetypes = { "c", "cpp", "cuda" },
            },
        })
        vim.lsp.enable("gopls")
        vim.lsp.enable("lua_ls")
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            "vim",
                            "require",
                        },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })

        vim.lsp.enable("pyright")
        vim.lsp.enable("ruff")

        vim.lsp.enable("rust_analyzer")
        vim.lsp.config("rust_analyzer", {
            on_attach = function(client, bufnr)
                require("completion").on_attach(client)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format()
                        end,
                    })
                end
            end,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
        })

        vim.lsp.enable("taplo")
    end,
}
