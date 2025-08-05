return {

	{
		"<leader>bs",
		function()
			require("utils.commentBoxMenu")()
		end,
		desc = "Abrir Catálogo commentBox",
	},
	{ "<leader>bc", "<cmd>CBcatalog<CR>", desc = "Abrir Catálogo commentBox" },
}
