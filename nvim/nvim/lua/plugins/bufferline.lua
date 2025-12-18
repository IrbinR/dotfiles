return {
	"akinsho/bufferline.nvim",
	version = "*",
	lazy = false,
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local config = require("config.customPlugins.bufferline")
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				local theme = vim.g.colors_name
				local opts = config.validated(theme)
				require("bufferline").setup(opts)
			end,
		})
	end,
	keys = require("config.keymaps.bufferline"),
}
