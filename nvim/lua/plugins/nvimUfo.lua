return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async", -- Dependencia requerida
	},
	event = "VeryLazy",
	opts = function()
		vim.o.foldcolumn = "1" -- columna de fold como VSCode
		vim.o.foldlevel = 99 -- necesario
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				-- Treesitter → LSP → indent
				return { "treesitter", "indent" }
			end,
		})
	end,
}
