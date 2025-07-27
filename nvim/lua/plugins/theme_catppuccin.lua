return {

	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		flavour = "macchiato",
		integrations = {
			mason = true,
			noice = true,
		},
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
