--[[
return {
	"angeljreyes/boilersharp.nvim",
	opts = {
		usings = false,

		---Information about the namespace section of the boilerplate.
		---This can be set to `false` to disable the section altogether.
		namespace = {
			---When to use file scoped namespace syntax.
			---Set this to "auto" to get this from the C# version inferred from
			---the csproj file of the project.
			---@type "never" | "always" | "auto"
			use_file_scoped = "always",
		},

		---Information about the type declaration section of the boilerplate.
		---This can be set to `false` to disable the section altogether.
		type_declaration = {
			---Access modifier to use when writing boilerplate. Set this to
			---`false` to not use any access modifier (implicitly `internal`).
			---@type "public" | "internal" | "file" | false
			default_access_modifier = "public",

			---C# keyword to use when declaring the type.
			default_type_declaration = "class",

			---Whether the plugin should use the `interface` keyword for the
			---type declaration when the name of the type matches the C#
			---interface naming convention, which would be equivalent to this
			---regular expression: `^I[A-Z].*$`.
			infer_interfaces = true,
		},

		---Whether to add autocommands for writing boilerplate when you enter
		---an empty C# file. Set this to `false` if you wanna be in control
		---of when boilerplate gets written to the file through user commands
		---or lua functions.
		add_autocommand = false,

		---What type of indentation to use for boilerplate generation. This is
		---only ever used when not using file scoped namespace syntax and
		---`type_declaration` is enabled. Set this to "auto" to take this from
		---the buffer's options.
		---
		---It is recommended that you set up an "after/ftplugin/cs.lua" file
		---in your nvim config with options for `expandtab` instead of
		---changing this option from its default value.
		---See `:h ftplugin` and `:h after-directory`.
		---
		---Warning: This option may be overridden by tpope/vim-sleuth.
		---@type "tabs" | "spaces" | "auto"
		indent_type = "auto",

		---Function that returns whether or not to write boilerplate. The
		---function takes as parameters data about the directory of the file,
		---and data about the csproj file.
		filter = function()
			return true
		end,

		---Whether or not to try to install the xml parser through
		---nvim-treesitter automatically.
		auto_install_xml_parser = true,

		---Whether to ignore buffers with buftype different than "".
		---See `:h 'buftype'`.
		ignore_special_buffers = true,
	},
	config = function()
		require("boilersharp").setup()

		vim.keymap.set("n", "<C-I-B>", function()
			require("boilersharp").write_boilerplate()
		end)
	end,
}
]]
return {}
