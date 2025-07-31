return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- ===== 1. Fuentes de autocompletado (OBLIGATORIAS) =====
		"hrsh7th/cmp-nvim-lsp", -- Autocompletado LSP
		"hrsh7th/cmp-buffer", -- Sugerencias del buffer
		"hrsh7th/cmp-path", -- Rutas de archivos
		"hrsh7th/cmp-cmdline", -- Autocompletado para cmdline (: / ?)
		"folke/lazydev.nvim", -- Autocompletado para configs de Neovim

		-- ===== 2. Snippets (OBLIGATORIOS si usas LuaSnip) =====
		"L3MON4D3/LuaSnip", -- Motor de snippets
		"saadparwaiz1/cmp_luasnip", -- Adaptador para nvim-cmp
		"rafamadriz/friendly-snippets", -- Snippets predefinidos

		-- ===== 3. Íconos para autocompletado =====
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		-- ----------------------------
		-- A. CONFIGURACIÓN DE SNIPPETS
		-- ----------------------------
		require("luasnip.loaders.from_vscode").lazy_load() -- Carga friendly-snippets

		-- ----------------------------
		-- B. CONFIGURACIÓN PRINCIPAL (BUFFERS)
		-- ----------------------------
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- Usa LuaSnip
				end,
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 50, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						-- ...
						return vim_item
					end,
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar con Enter
				["<Tab>"] = cmp.mapping(function(fallback)
					if require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump() -- Expandir snippets
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- Fuente LSP
				{ name = "lazydev", group_index = 1 }, -- Nueva fuente (prioridad alta)

				{ name = "luasnip" }, -- Snippets
				{ name = "path" }, -- Rutas
				{ name = "render-markdown" },
			}, {
				{ name = "buffer" }, -- Texto en buffers
			}),
		})

		-- ----------------------------
		-- C. AUTOCOMPLETADO PARA CMDLINE (: / ?)
		-- ----------------------------
		-- 1. Para búsquedas (/ y ?)
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- 2. Para comandos (:)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{ { name = "path" } }, -- Rutas primero
				{ { name = "cmdline" } } -- Comandos de Vim después
			),
		})

		-- ----------------------------
		-- D. INTEGRACIÓN CON AUTOPAIRS (OBLIGATORIA)
		-- ----------------------------
		-- 1. Configura autopairs (si no lo tienes en otro archivo)
		require("nvim-autopairs").setup()

		-- 2. Integración con nvim-cmp
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
