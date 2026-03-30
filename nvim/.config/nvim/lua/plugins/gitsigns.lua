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
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- Navigation
            map('n', ']h', function() gs.nav_hunk('next') end, "Next hunk")
            map('n', '[h', function() gs.nav_hunk('prev') end, "Prev hunk")

            -- Actions
            map('n', '<leader>hs', gs.stage_hunk, "Stage hunk")
            map('n', '<leader>hr', gs.reset_hunk, "Reset hunk")
            map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Stage selection")
            map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Reset selection")
            map('n', '<leader>hu', gs.undo_stage_hunk, "Undo stage hunk")
            map('n', '<leader>hp', gs.preview_hunk, "Preview hunk")
            map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, "Blame line")
            map('n', '<leader>hd', gs.diffthis, "Diff this")
        end
    }
}
