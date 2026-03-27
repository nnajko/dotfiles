return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        { "<leader>f", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Format buffer" },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            cs = { "csharpier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            markdown = { "prettier" },
        },
        format_on_save = {
            timeout_ms = 3000,
            lsp_format = "fallback",
        },
    },
}
