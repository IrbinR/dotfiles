return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = {
		"html",
		"xml",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
		"vue",
		"php",
		"markdown",
		"markdown_inline",
	},
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Cierra etiquetas automáticamente
				enable_rename = true, -- Renombra etiqueta de cierre al editar la apertura
				enable_close_on_slash = false, -- Cerrar con </
			},
		})
	end,
}
