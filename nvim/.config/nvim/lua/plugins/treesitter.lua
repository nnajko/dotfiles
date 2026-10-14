return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"c_sharp",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"json",
			"yaml",
			"xml",
			"toml",
			"html",
			"css",
			"javascript",
			"typescript",
			"bash",
			"dockerfile",
			"gitcommit",
			"gitignore",
			"zig",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"gotmpl",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if lang then
					pcall(vim.treesitter.start, args.buf, lang)
				end
			end,
		})
	end,
}
