return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local ok, jobs = pcall(require, "easy-dotnet.ui-modules.jobs")
        local job_indicator = ok and { jobs.lualine } or {}

        require('lualine').setup({
            sections = {
                lualine_a = vim.list_extend({ "mode" }, job_indicator),
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            }
        })
    end,
}
