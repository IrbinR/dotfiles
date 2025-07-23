local toggleterm = require("toggleterm")
local map = vim.keymap.set

-- Terminal flotante (por defecto)
map("n", "<leader>tf", function()
	toggleterm.toggle(1, nil, nil, "float") -- float es el tipo por defecto
end, { desc = "Toggle terminal flotante" })

-- Terminal vertical (40% del ancho)
map("n", "<leader>tv", function()
	toggleterm.toggle(2, vim.o.columns * 0.5, nil, "vertical")
end, { desc = "Toggle terminal vertical" })

-- Terminal horizontal (15 líneas de altura)
map("n", "<leader>th", function()
	toggleterm.toggle(3, 20, nil, "horizontal")
end, { desc = "Toggle terminal horizontal" })

-- Mapeos dentro del terminal
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Salir de modo terminal" }) -- Indispensable
map("t", "<C-w>h", [[<C-\><C-n><C-w>h]], { desc = "Moverse a ventana izquierda" }) -- Navegar entre splits
