return
{
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    ft = { "cs", "vb", "fsproj", "csproj", "solution" },
    cond = function()
        return vim.fn.glob('*.sln') ~= ''
            or vim.fn.glob('*.slnx') ~= ''
            or vim.fn.glob('*/*.csproj') ~= ''
            or vim.fn.glob('*/*.fsproj') ~= ''
    end,
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

        local capabilities = require('blink.cmp').get_lsp_capabilities()
        vim.lsp.config('easy-dotnet', { capabilities = capabilities })
        vim.lsp.enable('easy-dotnet')

        vim.keymap.set("n", "<leader>nt", function()
            dotnet.testrunner()
        end, { desc = "Dotnet test runner" })

        vim.keymap.set("n", "<leader>nb", function()
            dotnet.build()
        end, { desc = "Dotnet build" })
    end
}
