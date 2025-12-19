local servers = { "pyright", "ts_ls", "lua_ls", "html", "marksman", "bashls", "emmet_language_server", "cssls" }
return {
	"neovim/nvim-lspconfig",
	dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		vim.diagnostic.config({
			virtual_lines = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		--[[local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end]]

		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				--on_attach = on_attach,
				settings = (server == "lua_ls") and {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				} or nil,
			})
		end
	end,
}
