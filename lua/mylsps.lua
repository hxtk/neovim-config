return {
    setup = function()
        local lspconfig = require("lspconfig")
        lspconfig.bufls.setup({})
        lspconfig.gopls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.ruff.setup({})
    end,
}
