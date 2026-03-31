return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                config = function()
                    local dapui = require("dapui")
                    dapui.setup({
                        layouts = {
                            {
                                elements = {
                                    { id = "scopes", size = 0.25 },
                                    { id = "breakpoints", size = 0.25 },
                                    { id = "stacks", size = 0.25 },
                                    { id = "watches", size = 0.25 },
                                },
                                size = 40,
                                position = "left",
                            },
                            {
                                elements = {
                                    { id = "repl", size = 0.5 },
                                    { id = "console", size = 0.5 },
                                },
                                size = 10,
                                position = "bottom",
                            },
                            {
                                elements = {
                                    { id = "easy-dotnet_cpu", size = 0.5 },
                                    { id = "easy-dotnet_mem", size = 0.5 },
                                },
                                size = 35,
                                position = "right",
                            },
                        },
                    })

                    -- Auto open/close dap-ui with debug sessions
                    local dap = require("dap")
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close()
                    end
                end,
            },
        },
        config = function()
            local dap = require("dap")

            require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

            -- Keymaps for controlling the debugger
            vim.keymap.set("n", "<leader>dq", function()
                dap.terminate()
                dap.clear_breakpoints()
            end, { desc = "Terminate and clear breakpoints" })

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt)" })
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
            vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
            vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })
            vim.keymap.set("n", "<leader>du", function()
                require("dapui").toggle()
            end, { desc = "Toggle DAP UI" })

            -- Quick debug launch via easy-dotnet
            vim.keymap.set("n", "<leader>dd", function()
                vim.cmd("Dotnet debug default profile")
            end, { desc = "Debug dotnet (default profile)" })
        end
    }
}
