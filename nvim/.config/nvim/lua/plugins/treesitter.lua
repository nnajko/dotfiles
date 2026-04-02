return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitter = require('nvim-treesitter')
        treesitter.install({
            "c_sharp", "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            "json", "yaml", "xml", "toml",
            "html", "css", "javascript", "typescript",
            "bash", "dockerfile", "gitcommit", "gitignore",
        })
        treesitter.setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            }
        })
    end,
}
