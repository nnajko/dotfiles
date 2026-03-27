return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>pv", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
        { "<leader>pw", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
    },
    opts = {
        open_for_directories = true,
        change_neovim_cwd_on_close = true,
    },
}
