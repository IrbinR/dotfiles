return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = {},
		},
	},
	opts = {},
	keys = require("config.keymaps.commentNvim"),
}
