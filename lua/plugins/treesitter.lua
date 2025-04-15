return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            auto_install = true,
            highlight = {
                enable = true,
                disable = "help",
            },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "fish",
                "go",
                "gomod",
                "jq",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "proto",
                "vim",
                "vimdoc",
            },
        })
    end,
}
