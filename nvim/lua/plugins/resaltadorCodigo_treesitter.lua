return {

    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "lua", "bash", "query", "javascript",
            "html", "css", "java", "json",
            "python", "scss", "sql", "tsx",
            "markdown", "markdown_inline",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = { enable = true },
        indent = { enable = true },
    },
    build = ":TSUpdate"

}
