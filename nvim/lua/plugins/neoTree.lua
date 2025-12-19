return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			window = {
				mappings = {
					["P"] = {
						"toggle_preview",
						config = {
							use_float = false,
							-- use_image_nvim = true,
							-- use_snacks_image = true,
							-- title = 'Neo-tree Preview',
						},
					},
				},
			},

			event_handlers = {

				{
					event = "file_open_requested",
					handler = function()
						-- auto close
						-- vim.cmd("Neotree close")
						-- OR
						require("neo-tree.command").execute({ action = "close" })
					end,
				},

				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},

				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.opt.fillchars:append({ vert = " " })
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE", bg = "NONE" })
			vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		end,
		keys = require("config.keymaps.neoTree"),
	},
}
