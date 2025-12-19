
return {
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Cerrar buffer actual",
	},

	{
		"<leader>bda",
		function()
			Snacks.bufdelete.all()
		end,
		desc = "Cerrar todos los buffer",
	},

	{
		"<leader>bo",
		function()
			Snacks.bufdelete.other()
		end,
		desc = "Cerrar todos los buffer excepto el actual",
	},

	{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Ir a buffer Siguiente" },
	{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Ir a buffer anterior" },

	{ "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Ir a buffer 1" },
	{ "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Ir a buffer 2" },
	{ "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Ir a buffer 3" },
	{ "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Ir a buffer 4" },
	{ "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Ir a buffer 5" },
	{ "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Ir a buffer 6" },
	{ "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Ir a buffer 7" },
	{ "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Ir a buffer 8" },
	{ "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Ir a buffer 9" },
	{ "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "Ir a last buffer" },
}
