return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>pv", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
        { "<leader>pV", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
    },
    opts = {
        open_for_directories = true,
    },
    -- Required for open_for_directories: without this netrw claims the
    -- directory buffer before yazi.nvim loads, so `nvim <dir>` lands in netrw.
    -- https://github.com/mikavilpas/yazi.nvim/issues/802
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
}
