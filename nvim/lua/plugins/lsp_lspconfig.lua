local servers = { "lua_ls", "pyright", "ts_ls", "html", "emmet_ls" }
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- CAMBIO: Remover "hrsh7th/cmp-nvim-lsp" ya que ahora usas blink.cmp
	},
	config = function()
		-- Configurar Mason
		require("mason").setup()
		-- Configurar Mason-LSPConfig (solo instalación)
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		local lspconfig = require("lspconfig")

		-- CAMBIO: Usar blink.cmp en lugar de cmp-nvim-lsp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Configuración común (sin cambios)
		local on_attach = function(_, bufnr)
			local map = function(mode, lhs, rhs)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
			end
			map("n", "K", vim.lsp.buf.hover)
			map("n", "gd", vim.lsp.buf.definition)
		end

		-- Configurar servidores manualmente (sin cambios)
		--local servers = servers
		for _, server in ipairs(servers) do
			if server == "emmet_ls" then
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "html", "css", "scss", "javascript", "typescript", "vue", "svelte" },
					init_options = {
						html = {
							options = {
								["bem.enabled"] = true,
							},
						},
					},
				})
			else
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end
		end
	end,
}
