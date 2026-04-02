return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local job_indicator = {
            function()
                if package.loaded['easy-dotnet'] then
                    return require('easy-dotnet.ui-modules.jobs').lualine()
                end
                return ''
            end,
            cond = function()
                return package.loaded['easy-dotnet'] ~= nil
            end,
        }

        require('lualine').setup({
            sections = {
                lualine_a = { "mode", job_indicator },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            }
        })
    end,
}
