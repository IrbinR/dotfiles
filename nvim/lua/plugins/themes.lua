return {
	{
		"sam4llis/nvim-tundra",
		opts = {},
		lazy = true,
		config = function(_, opts)
			require("nvim-tundra").setup(opts)
			vim.g.tundra_biome = "arctic" -- 'arctic' or 'jungle'
			vim.opt.background = "dark"
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		opts = {},
		lazy = true,
		config = function(_, opts)
			vim.o.background = "dark" -- or "light" for light mode
			require("gruvbox").setup(opts)
		end,
	},

	{
		"olimorris/onedarkpro.nvim",
		lazy = true,
		opts = {},
	},

	{
		"maxmx03/solarized.nvim",
		lazy = true,
		---@type solarized.config
		opts = {
			variant = "summer",
		},
		config = function(_, opts)
			vim.o.termguicolors = true
			vim.o.background = "dark"
			require("solarized").setup(opts)
			--vim.cmd.colorscheme("solarized")
		end,
	},

	{
		"loctvl842/monokai-pro.nvim",
		lazy = true,
		opts = {
			background_clear = {},
		},
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {},
	},

}
