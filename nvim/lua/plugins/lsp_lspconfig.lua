local servers = { "lua_ls", "pyright", "ts_ls", "html", "emmet_ls", "marksman" }
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
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

		-- 1. Capacidades estándar (con snippets y autocompletado)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Configuración común (sin cambios)
		local on_attach = function(_, bufnr)
            require("core.keymaps.nvimLspconfig")
		end

		-- 3. Configuración específica por servidor
		for _, server in ipairs(servers) do
			local server_opts = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			if server == "emmet_ls" then
				server_opts.filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"vue",
					"svelte",
				}
				server_opts.init_options = {
					html = { options = { ["bem.enabled"] = true } },
				}
			elseif server == "lua_ls" then
				server_opts.settings = {
					Lua = {
						runtime = {
							version = "LuaJIT", -- Neovim usa LuaJIT
						},
						diagnostics = {
							globals = { "vim" }, -- Reconoce 'vim' como global
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, -- No preguntar sobre third party
						},
						telemetry = {
							enable = false, -- Desactivar telemetría
						},
						completion = {
							callSnippet = "Replace", -- Mejor autocompletado
						},
					},
				}
			end

			lspconfig[server].setup(server_opts)
		end
	end,
}
