return({
	"seblyng/roslyn.nvim",
	ft = { "cs", "razor" },
	opts = {
		broad_search = true,
		lock_target = true,
	},
	dependencies = {
		{
			"tris203/rzls.nvim",
			config = true,
		},
	},
	config = function()
		local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
		local cmd = {
			"roslyn",
			"--stdio",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			"--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
			"--razorDesignTimePath="
				.. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
			"--extension",
			vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
		}

		vim.lsp.config("roslyn", {
			cmd = cmd,
			handlers = require("rzls.roslyn_handlers"),
			on_attach = function()
				print("Roslyn attached")
			end,
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,

					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_literal_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
			},
		})

		vim.lsp.enable("roslyn")
	end,
	init = function()
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})

        vim.api.nvim_create_autocmd({ "InsertLeave" }, {
            pattern = "*",
            callback = function()
                local clients = vim.lsp.get_clients({ name = "roslyn" })
                if not clients or #clients == 0 then
                    return
                end

                for _, client in ipairs(clients) do
                    local buffers = vim.lsp.get_buffers_by_client_id(client.id)
                    for _, buf in ipairs(buffers) do
                        local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
                        client:request("textDocument/diagnostic", params, nil, buf)
                    end
                end
            end,
        })
	end,
})
