local map = vim.keymap.set

map("n", "<leader>nl", "<cmd>Neotree toggle left<cr>", { desc = "Toggle NeoTree Left" })
map("n", "<leader>no", "<cmd>Neotree focus<cr>", { desc = "Focus NeoTree" })
map("n", "<leader>nf", "<cmd>Neotree toggle float<cr>", { desc = "Toggle NeoTree Float" })

-- Atajos cuando Neo-tree está enfocado (modo 'n' dentro del árbol)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = true })
		end

		-- Navegación rápida
		bufmap("n", "l", "open") -- Abrir archivo/directorio
		bufmap("n", "h", "close_node") -- Cerrar directorio
		bufmap("n", "H", "toggle_hidden") -- Mostrar/ocultar archivos ocultos
	end,
})
