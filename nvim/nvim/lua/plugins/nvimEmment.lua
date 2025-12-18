return {
	"olrtg/nvim-emmet",
	ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
	config = function()
		vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
	end,
}
