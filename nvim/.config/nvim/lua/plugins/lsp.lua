return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            'saghen/blink.cmp',
            version = '1.*',
            config = function()
                local blink = require('blink.cmp')
                blink.setup({
                    fuzzy = { implementation = "prefer_rust_with_warning" },
                    sources = {
                        default = { "lsp", "easy-dotnet", "path", "snippets", "buffer" },
                        providers = {
                            ["easy-dotnet"] = {
                                name = "easy-dotnet",
                                enabled = true,
                                module = "easy-dotnet.completion.blink",
                                score_offset = 10000,
                                async = true,
                            },
                        },
                    },
                })
            end,
        },
        {
            "folke/lazydev.nvim",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        vim.lsp.config('lua_ls', { capabilities = capabilities })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('easy_dotnet', { capabilities = capabilities })
        vim.lsp.enable('easy_dotnet')

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
            callback = function(args)
                local buf = args.buf
                local opts = { buffer = buf, silent = true }

                -- Navigation
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>ds", vim.lsp.buf.signature_help, opts)

                -- Actions
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                -- Diagnostics
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            end,
        })
    end,
}
