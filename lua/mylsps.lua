return {
    setup = function()
        local lspconfig = require("lspconfig")
        lspconfig.buf_ls.setup({})
        lspconfig.clangd.setup({})
        lspconfig.gopls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.ruff.setup({})
        lspconfig.rust_analyzer.setup({
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
        lspconfig.taplo.setup({})
        lspconfig.zls.setup({})
    end,
}
