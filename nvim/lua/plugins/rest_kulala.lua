return {
	"mistweaverco/kulala.nvim",
	keys = require("core.keymaps.plugins.kulala"),
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
	},
}
