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
                        default = { "lsp", "path", "snippets", "buffer" },
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

        local servers = { 'lua_ls', 'ts_ls', 'jsonls', 'yamlls', 'html', 'cssls' }
        for _, server in ipairs(servers) do
            vim.lsp.config(server, { capabilities = capabilities })
        end
        vim.lsp.enable(servers)


        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
            callback = function(args)
                local buf = args.buf
                local opts = { buffer = buf, silent = true }

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
                end

                -- Navigation
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "gr", vim.lsp.buf.references, "Find references")
                map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                map("n", "K", vim.lsp.buf.hover, "Hover info")
                map("n", "<leader>ds", vim.lsp.buf.signature_help, "Signature help")

                -- Actions
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

                -- Diagnostics
                map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
                map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
                map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
            end,
        })
    end,
}
