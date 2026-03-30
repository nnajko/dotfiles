return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c_sharp", "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline",
                "json", "yaml", "xml", "toml",
                "html", "css", "javascript", "typescript",
                "bash", "dockerfile", "gitcommit", "gitignore",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
