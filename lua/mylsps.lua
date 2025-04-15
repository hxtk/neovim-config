return {
    setup = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client:supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                end
            end,
        })
        vim.lsp.enable("buf_ls")
        vim.lsp.enable("clangd")
        vim.lsp.enable("gopls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("ruff")

        vim.lsp.enable("rust_analyzer")
        vim.lsp.config("rust_analyzer", {
            on_attach = function(client)
                require("completion").on_attach(client)
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
