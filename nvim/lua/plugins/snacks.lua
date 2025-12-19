return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		--dashboard = { enabled = true },
		quickfile = { enabled = true },
		-- scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
	},
}
