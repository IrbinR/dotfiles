return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		quickfile = { enabled = true },
		--scope = { enabled = true },
		scroll = { enabled = true },
		lazygit = { enabled = true },
		--statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
