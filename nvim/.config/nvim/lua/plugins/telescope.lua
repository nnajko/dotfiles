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
            },
            live_grep = {
                theme = "ivy"
            },
            buffers = {
                theme = "ivy",
                mappings = {
                    i = { ["<c-x>"] = "delete_buffer" },
                    n = { ["x"] = "delete_buffer" },
                },
            },
            oldfiles = {
                theme = "ivy"
            },
            git_files = {
                theme = "ivy"
            },
            help_tags = {
                theme = "ivy"
            }
        },
        extensions = {
            fzf = {}
        },
        defaults = {
            file_ignore_patterns = {
                -- Directories
                "node_modules/",
                "%.git/",
                "bin/",
                "obj/",
                "dist/",
                "build/",
                "__pycache__/",
                "%.vs/",
                "%.idea/",
                "%.vscode/",
                "packages/",

                -- .NET generated
                "%.Designer%.cs$",
                "%.g%.cs$",

                -- Binaries & artifacts
                "%.dll$", "%.exe$", "%.pdb$",
                "%.so$", "%.o$", "%.a$",

                -- Images & fonts
                "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.ico$", "%.svg$",
                "%.woff2?$", "%.ttf$", "%.eot$",

                -- Other binary/large files
                "%.pdf$", "%.zip$", "%.tar$", "%.gz$",
                "%.sql$", "%.vsd$",
                "%.min%.js$", "%.min%.css$",
                "%.map$",

                -- Lock files
                "package%-lock%.json$",
                "pnpm%-lock%.yaml$",
                "yarn%.lock$",

                -- Project-specific
                "Vagabond.CommerceManager",
                "OrderXmlImport",
                "Legacy",
                "Mediachase.Commerce.Workflow",
                "Vagabond.DatabaseRestore",
                "PandoraBox",
                "ThumbnailResizer",
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
        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Open buffers" })
        vim.keymap.set('n', '<leader>pr', builtin.oldfiles, { desc = "Recent files" })
    end
}
