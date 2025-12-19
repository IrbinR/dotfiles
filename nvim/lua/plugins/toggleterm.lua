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

		size = function(term)
			if term.direction == "horizontal" then
				return math.floor(vim.o.lines * 0.4)
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
		end,
	},
	keys = require("config.keymaps.toggleTerm"),
}
