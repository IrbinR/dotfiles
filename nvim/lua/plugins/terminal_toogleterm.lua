return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		highlights = {
			-- Usar colores del tema actual
			Normal = {
				link = "Normal",
			},
			NormalFloat = {
				link = "NormalFloat",
			},
			FloatBorder = {
				link = "FloatBorder",
			},
		},
	},
	keys = require("core.keymaps.plugins.toggleterm"),
}
