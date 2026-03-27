return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs_staged_enable = true,
        signcolumn          = true,
        numhl               = false,
        linehl              = false,
        word_diff           = false,
        on_attach = function(bufnr)
            local gs = require('gitsigns')
            local opts = { buffer = bufnr }

            -- Navigation
            vim.keymap.set('n', ']h', function() gs.nav_hunk('next') end, opts)
            vim.keymap.set('n', '[h', function() gs.nav_hunk('prev') end, opts)

            -- Actions
            vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
            vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts)
            vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts)
            vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts)
            vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
            vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
            vim.keymap.set('n', '<leader>hb', function() gs.blame_line({ full = true }) end, opts)
            vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)
        end
    }
}
