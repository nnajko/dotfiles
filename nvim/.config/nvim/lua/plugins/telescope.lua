return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    opts = {
        pickers = {
            find_files = {
                theme = "ivy"
            }
        },
        extensions = {
            fzf = {}
        },
        defaults = {
            file_ignore_patterns = {
                "Vagabond.CommerceManager",
                "OrderXmlImport",
                "Legacy",
                "Mediachase.Commerce.Workflow",
                "node_modules",
                "Vagabond.DatabaseRestore",
                "PandoraBox",
                "ThumbnailResizer",
                "%.sql$",
                "%.vsd$",
                "%.dll$",
                "%.exe$",
                "%.pdb$",
                "%.png$",
                "%.jpg$",
                "%.gif$",
                "%.ico$",
                "%.woff$",
                "%.woff2$",
                "%.ttf$",
                "%.eot$",
                "%.pdf$",
                "%.Designer%.cs$",
                "%.g%.cs$"
            }
        }
    },
    config = function(_, opts)
        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('fzf')
        local builtin = require('telescope.builtin')

        vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Help tags" })
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>pF", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<leader>en", function()
            builtin.find_files { cwd = vim.fn.stdpath("config") }
        end, { desc = "Edit nvim config" })
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Live grep" })
    end
}
