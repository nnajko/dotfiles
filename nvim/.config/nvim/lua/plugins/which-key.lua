return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>a", group = "AI/Claude" },
            { "<leader>d", group = "Debug" },
            { "<leader>h", group = "Git hunks" },
            { "<leader>n", group = "Dotnet" },
            { "<leader>p", group = "Project/Files" },
            { "<leader>t", group = "Test" },
            { "<leader>x", group = "Diagnostics" },
            { "<leader>c", group = "Code" },
            { "<leader>g", group = "Git" },
            { "ys", group = "Surround add" },
        },
    },
}
