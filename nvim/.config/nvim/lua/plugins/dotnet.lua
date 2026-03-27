return
{
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    config = function()
        local dotnet = require("easy-dotnet")
        dotnet.setup({
            auto_bootstrap_namespace = {
                --block_scoped, file_scoped
                type = "file_scoped",
                enabled = true,
                use_clipboard_json = {
                    behavior = "prompt", --'auto' | 'prompt' | 'never',
                    register = "+",      -- which register to check
                },
            },
            test_runner = {
                mappings = {
                    refresh_testrunner = { lhs = "<C-R>", desc = "refresh testrunner" }
                }
            },
            notifications = {
                handler = false
            }
        })

        vim.keymap.set("n", "<leader>nt", function()
            dotnet.testrunner()
        end, { desc = "Dotnet test runner" })

        vim.keymap.set("n", "<leader>nb", function()
            dotnet.build()
        end, { desc = "Dotnet build" })
    end
}
