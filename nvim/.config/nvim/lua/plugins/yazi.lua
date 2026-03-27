return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>pv", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
        { "<leader>pf", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
    },
    opts = {
        open_for_directories = true,
    },
}
