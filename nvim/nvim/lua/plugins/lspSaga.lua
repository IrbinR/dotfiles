return {
	"nvimdev/lspsaga.nvim",
	opts = {
		ui = {
			border = "rounded",
			winblend = 0,
			title = true,
		},
		code_action = {
			keys = { quit = "q", exec = "<CR>" },
		},
		finder = {
			keys = { open = "o", vsplit = "v", split = "s", quit = "q" },
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = require("config.keymaps.lspSaga"),
}
