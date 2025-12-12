local harpoon = require("harpoon")
local telescope_finders = require("telescope.finders")
local telescope_state = require("telescope.actions.state")
local telescope_config = require("telescope.config").values
local telescope_pickers = require("telescope.pickers")

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		harpoon:setup({})

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		--vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)

		local function make_finder(paths)
			return telescope_finders.new_table({ results = paths })
		end

		local function get_paths(files)
			local paths = {}
			local items = files.items
			local len = files._length

			for i = 1, len do
				paths[i] = ""
				local item = items[i]
				if item ~= nil then
					paths[i] = item.value
				end
			end

			return paths
		end

		local function toggle_telescope()
			telescope_pickers
				.new({}, {
					prompt_title = "Harpoon",
					finder = make_finder(get_paths(harpoon:list())),
					previewer = telescope_config.file_previewer({}),
					sorter = telescope_config.generic_sorter({}),
					attach_mappings = function(prompt_buffer_number, map)
						map("i", "<C-d>", function()
							local selected_entry = telescope_state.get_selected_entry()
							local current_picker = telescope_state.get_current_picker(prompt_buffer_number)
							harpoon:list():remove_at(selected_entry.index)
							current_picker:refresh(make_finder(get_paths(harpoon:list())))
						end)

						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope()
		end, { desc = "Open harpoon window" })
	end,
}
