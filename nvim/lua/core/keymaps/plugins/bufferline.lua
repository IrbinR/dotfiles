return {

	-- Cerrar buffers
	{ "<leader>bl", "<cmd>lua Snacks.bufdelete()<cr>", desc = "Cerrar buffer actual" },
	{ "<leader>buo", "<cmd>BufferLineCloseOthers<cr>", desc = "Cerrar otros buffers" },
	{ "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>", desc = "Cerrar buffers a la izquierda" },
	{ "<leader>bcr", "<cmd>BufferLineCloseRight<cr>", desc = "Cerrar buffers a la derecha" },

	-- Navegación entre buffers
	{ "<A-n>", "<cmd>BufferLineCycleNext<cr>", desc = "Ir a buffer Siguiente" },
	{ "<A-p>", "<cmd>BufferLineCyclePrev<cr>", desc = "Ir a buffer anterior" },

	-- Ir a buffer específico por posición visible
	{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Ir a buffer 1" },
	{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Ir a buffer 2" },
	{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Ir a buffer 3" },
	{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Ir a buffer 4" },
	{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Ir a buffer 5" },
	{ "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Ir a buffer 6" },
	{ "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Ir a buffer 7" },
	{ "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Ir a buffer 8" },
	{ "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Ir a buffer 9" },
	{ "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "Ir a last buffer" },
}
