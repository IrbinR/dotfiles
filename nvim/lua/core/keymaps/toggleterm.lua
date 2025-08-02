return {

	-- ─[ Terminal flotante (por defecto) ]────────────────────────────────
	{
		"<leader>tf",
		"<cmd>Toggleterm direction=float<cr>",
		desc = "Toggle terminal flotante",
	},

	-- ─[ Terminal horizontal (15 líneas de altura) ]──────────────────────
	{
		"<leader>th",
		"<cmd>Toggleterm direction=horizontal size=20<cr>",
		desc = "Toggle terminal horizontal",
	},

	-- ─[ Mapeos dentro del terminal ]─────────────────────────────────────
	{ "<Esc>", [[<C-\><C-n>]], mode = "t", desc = "Salir de modo terminal" }, -- Indispensable

	{ "<C-w>h", [[<C-\><C-n><C-w>h]], mode = "t", desc = "Moverse a ventana izquierda" }, -- Navegar entre splits
}

-- Terminal vertical (40% del ancho)
--[[ map("n", "<leader>tv", function()
	toggleterm.toggle(2, vim.o.columns * 0.5, nil, "vertical")
end, { desc = "Toggle terminal vertical" }) ]]
