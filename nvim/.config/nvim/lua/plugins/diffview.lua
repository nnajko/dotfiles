return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
        { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
    opts = {
        enhanced_diff_hl = true,
    },
}
