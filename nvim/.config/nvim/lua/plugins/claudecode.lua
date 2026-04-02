return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<CR>",            desc = "Toggle Claude Code" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<CR>",       desc = "Focus Claude Code" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<CR>",   desc = "Resume session" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Continue session" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>",       desc = "Add current file" },
        { "<leader>as", "<cmd>ClaudeCodeSend<CR>",        mode = "v",                 desc = "Send selection" },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>",  desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>",    desc = "Deny diff" },
    },
}
