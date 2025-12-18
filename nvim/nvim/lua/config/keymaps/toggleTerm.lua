return {

	-- ─[ Terminal flotante (por defecto) ]────────────────────────────────
	{
		"<leader>to",
		"<cmd>1ToggleTerm direction=float<cr>",
		desc = "Toggle terminal flotante",
	},

	-- ─[ Terminal horizontal (15 líneas de altura) ]──────────────────────
	{
		"<leader>h1",
		"<cmd>2ToggleTerm direction=horizontal<cr>",
		desc = "Toggle terminal horizontal 1",
	},
	{
		"<leader>h2",
		"<cmd>3ToggleTerm direction=horizontal<cr>",
		desc = "Toggle terminal horizontal 2",
	},
	{
		"<leader>h3",
		"<cmd>4ToggleTerm direction=horizontal<cr>",
		desc = "Toggle terminal horizontal 3",
	},

	-- ─[ Terminal vertical (60 líneas de altura) ]──────────────────────
	{
		"<leader>v1",
		"<cmd>5ToggleTerm direction=vertical<cr>",
		desc = "Toggle terminal vertical 1",
	},
	{
		"<leader>v2",
		"<cmd>6ToggleTerm direction=vertical<cr>",
		desc = "Toggle terminal vertical 2",
	},
	{
		"<leader>v3",
		"<cmd>7ToggleTerm direction=vertical<cr>",
		desc = "Toggle terminal vertical 3",
	},

	-- ─[ Mapeos dentro del terminal ]─────────────────────────────────────
	{ "<Esc>", [[<C-\><C-n>]], mode = "t", desc = "Salir de modo terminal" },
}
